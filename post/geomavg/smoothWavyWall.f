C-----------------------------------------------------------------------
c
c	Ramesh's Periodic Hill w/ wall shape function & ~ target res
c
C
C  user specified routines:
C     - userbc : boundary conditions
C     - useric : initial conditions
C     - uservp : variable properties
C     - userf  : local acceleration term for fluid
C     - userq  : local source term for scalars
C     - userchk: general purpose routine for checking errors etc.
C
C-----------------------------------------------------------------------
#define PI (4.*atan(1.))
#define DELTA 1.
#define XLEN (1*DELTA)
#define YLEN (1*DELTA)
#define ZLEN (1*DELTA)
#define NUMBER_ELEMENTS_X 16
#define NUMBER_ELEMENTS_Y 12
#define NUMBER_ELEMENTS_Z 8
C-----------------------------------------------------------------------
      include 'geomavg.usr'
C-----------------------------------------------------------------------
      subroutine uservp(ix,iy,iz,eg) ! set variable properties
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'

      integer e,f,eg
c     e = gllel(eg)

      udiff  = 0.0
      utrans = 0.0

      return
      end
c-----------------------------------------------------------------------
      subroutine userf(ix,iy,iz,eg) ! set acceleration term
c
c     Note: this is an acceleration term, NOT a force!
c     Thus, ffx will subsequently be multiplied by rho(x,t).
c
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'

      integer e,f,eg
c     e = gllel(eg)

      ffx = 0.0
      ffy = 0.0
      ffz = 0.0

      return
      end
c-----------------------------------------------------------------------
      subroutine userq(ix,iy,iz,eg) ! set source term
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'

      integer e,f,eg
c     e = gllel(eg)

      qvol   = 0.0

      return
      end
c-----------------------------------------------------------------------
      subroutine userbc(ix,iy,iz,iside,ieg) ! set up boundary conditions
c     NOTE ::: This subroutine MAY NOT be called by every process
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'

c      if (cbc(iside,gllel(ieg),ifield).eq.'v01')

c	Empty/no call to with BCs P, W, SYM!

      ux   = 0.0
      uy   = 0.0
      uz   = 0.0
      temp = 0.0

      return
      end
c-----------------------------------------------------------------------
      subroutine useric(ix,iy,iz,ieg) ! set up initial conditions
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'

      integer idum
      save    idum 
      data    idum / 0 /

      real C, k, kx, ky

      Re_tau = 550 
      C      = 5.17
      k      = 0.41

      yp = (1-y)*Re_tau
      if (y.lt.0) yp = (1+y)*Re_tau
      
c     Reichardt function
      ux  = 1/k*log(1+k*yp) + (C - (1/k)*log(k)) *
     $      (1 - exp(-yp/11) - yp/11*exp(-yp/3))
      ux  = ux * Re_tau*param(2)

c     perturb
      eps = 1e-2
      kx  = 23
      kz  = 13

      alpha = kx * 2*PI/XLEN
      beta  = kz * 2*PI/ZLEN 

      ux  = ux  + eps*beta  * sin(alpha*x)*cos(beta*z) 
      uy  =       eps       * sin(alpha*x)*sin(beta*z)
      uz  =      -eps*alpha * cos(alpha*x)*sin(beta*z)

      temp=0

      ux = sin(2*PI*x/XLEN)
     $   + sin(2*PI*y/YLEN)

      ux = x*x*x*y + sin(y*z) + 2200 + 80*z*z*x
      uy = ux
      uz = ux

      ux = -0.25*XLEN + (2*x/XLEN)
      uy = -0.25*YLEN + (2*y/YLEN)
      uz = -0.25*ZLEN + (2*z/ZLEN)

      if(x .gt. 0.5*XLEN) ux = 0.25*XLEN - (2*(x-0.5*XLEN)/XLEN)
      if(y .gt. 0.5*YLEN) uy = 0.25*YLEN - (2*(y-0.5*YLEN)/YLEN)
      if(z .gt. 0.5*ZLEN) uz = 0.25*ZLEN - (2*(z-0.5*ZLEN)/ZLEN)

      return
      end
c-------------------------------------------------------------------------------
      subroutine userchk()
      include 'SIZE'
      include 'TOTAL'

      integer nelx,nely,nelz,ifld,idir,nrepeat

      integer gs_avg_hndl
      save    gs_avg_hndl
      data    gs_avg_hndl / 0 /
      
      nelx    = 16
      nely    = 12
      nelz    = 8
      ifld    = 1
      idir    = 3
      nrepeat = 2

c     ! call gfldr('restart0.f00001')
      idir = 1
      gs_avg_hndl = 0
      call geom_avg_wrapper(vx,gs_avg_hndl,nelx,nely,nelz,ifld,idir
     $     ,nrepeat)
      idir = 2
      gs_avg_hndl = 0
      call geom_avg_wrapper(vy,gs_avg_hndl,nelx,nely,nelz,ifld,idir
     $     ,nrepeat)
      idir = 3
      gs_avg_hndl = 0
      call geom_avg_wrapper(vz,gs_avg_hndl,nelx,nely,nelz,ifld,idir
     $     ,nrepeat)

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat()   ! This routine to modify element vertices
      include 'SIZE'
      include 'TOTAL'

      common /cdsmag/ ediff(lx1,ly1,lz1,lelv)

      n=8*nelv
      xmin = glmin(xc,n)
      xmax = glmax(xc,n)
      ymin = glmin(yc,n)
      ymax = glmax(yc,n)
      zmin = glmin(zc,n)
      zmax = glmax(zc,n)

      xscale = XLEN/(xmax-xmin)
      yscale = YLEN/(ymax-ymin)
      zscale = ZLEN/(zmax-zmin)

      do i=1,n
         xc(i,1) = xscale*xc(i,1)
         yc(i,1) = yscale*yc(i,1)
         zc(i,1) = zscale*zc(i,1)
      enddo

      n = nx1*ny1*nz1*nelt 
      call cfill(ediff,param(2),n)  ! initialize viscosity

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat2()  ! This routine to modify mesh coordinates
      include 'SIZE'
      include 'TOTAL'

c!..   declare some local variables
c      REAL*8 lambda
c
c      nt = nx1*ny1*nz1*nelt
c
c      delta  = 0.0          !.. this is the height of the crest of the wavy wall
c      lambda = 1.0          !.. this is the wavelength of the wavy wall (in mm)
c      hmax   = lambda       !.. depth of the domain in mm
c
c      domainLength = 1.0*lambda
c      xStartDomain = 0.0
c      xEndDomain   = domainLength
c
c      domainHeight = 1.0
c      yStartDomain = 0.0
c      yEndDomain   = ( delta + domainHeight )
c
c      domainSpan   = 1.0*lambda
c      zStartDomain = 0.0
c      zEndDomain   = domainSpan
c
c      call rescale_x(xm1, 0.0, 1.0)
c      call rescale_x(ym1, 0.0, 1.0)
c      call rescale_x(zm1, 0.0, 1.0)
c
c      do i=1,nt
c        x  = xm1(i,1,1,1)
c        y  = ym1(i,1,1,1)
c        z  = zm1(i,1,1,1)
c
c        yw = ss(x,z)
c
c        yy = (1. - yw/yEndDomain)*y + yw	! 0->yw & ymax=fix
c        ym1(i,1,1,1) = yy
c      enddo

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat3()
      include 'SIZE'
      include 'TOTAL'

      return
      end
c-----------------------------------------------------------------------
      function ss(x,z)          ! bottom surface y = ss(x,z)

      ss = 0.1*x

      return
      end
c-----------------------------------------------------------------------
      function ssx(x,z) 

      sxz = 0.1

      return
      end
c-----------------------------------------------------------------------
      function ssz(x,z)

      ssz = 0.

      return
      end
C=======================================================================

c automatically added by makenek
      subroutine usrsetvert(glo_num,nel,nx,ny,nz) ! to modify glo_num
      integer*8 glo_num(1)

      return
      end

c automatically added by makenek
      subroutine userqtl

      call userqtl_scig

      return
      end
