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
      include 'uplus.usr'
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

      ux   = 1.0
      uy   = 0.0
      uz   = 0.0
      temp = 0.0

      return
      end
c-----------------------------------------------------------------------
      subroutine userchk()
      include 'SIZE'
      include 'TOTAL'

      integer f,idir
      character*3 bctyp

      integer gs_avg_hndl
      save    gs_avg_hndl
      data    gs_avg_hndl / 0 /

      real up(lx1,ly1,lz1,lelv)
      real yp(lx1,ly1,lz1,lelv)
c     call gfldr('restart0.f00001')

      ifxyo = .true.
      ifto  = .false.

      f     = 1
      bctyp = 'W  '
      nelx = 32
      nely = 16
      nelz = 16
      ifld = 1  !velocity field
      idir = 2  !y_direction
 
      call comp_uplus(up,yp,vx,vy,vz,f,bctyp,gs_avg_hndl
     $                  ,nelx,nely,nelz,ifld,idir)

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat()   ! This routine to modify element vertices
      include 'SIZE'
      include 'TOTAL'

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat2()  ! This routine to modify mesh coordinates
      include 'SIZE'
      include 'TOTAL'

!..   declare some local variables
      REAL*8 lambda

      n = nx1*ny1*nz1*nelt

!..   the geometry fot this domain is taken from the paper by Maass & Schumann
!..   (Ref.: http://elib.dlr.de/31857/1/94-Maass.pdf)
      delta  = 2.54         !.. this is the height of the crest of the wavy wall
      lambda = 20.0*delta   !.. this is the wavelength of the wavy wall (in mm)
      hmax   = lambda       !.. depth of the domain in mm

      domainLength = 4.0*lambda
      xStartDomain = 0.0
      xEndDomain   = domainLength

      domainHeight = 1.0*lambda
      yStartDomain = 0.0
      yEndDomain   = ( delta + domainHeight )

      domainSpan   = 2.0*lambda
      zStartDomain = 0.0
      zEndDomain   = domainSpan

      call rescale_x(xm1, xStartDomain, xEndDomain)
      call rescale_x(ym1, yStartDomain, yEndDomain)
      call rescale_x(zm1, zStartDomain, zEndDomain)

      n = nx1*ny1*nz1*nelt
      do i=1,n
        x  = xm1(i,1,1,1)
        y  = ym1(i,1,1,1)

        yw = bottomSWW(x, delta, lambda)

        yy = (1. - yw/yEndDomain)*y + yw	! 0->yw & ymax=fix

        ym1(i,1,1,1) = yy 
      enddo

      scale = 1./hmax			! scale by the depth of the domain (hmax)
      call rescale_x(xm1, xStartDomain*scale, xEndDomain*scale)
      call rescale_x(ym1, yStartDomain*scale, yEndDomain*scale)
      call rescale_x(zm1, zStartDomain*scale, zEndDomain*scale)

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat3()
      include 'SIZE'
      include 'TOTAL'

      return
      end
C=======================================================================
      function y_lower_lift(x,xmax)	! lift from y=0 for 0<x<xmax
					! periodic for P BC
      amp = 1.e-4
      amp = 0.1

      one = 1.
      pi2 = 8.*atan(one)

      xx  = x/xmax
      yy  = cos(pi2*xx)
      yy  = amp*yy

      y_lower_lift = yy

      return
      end
c-----------------------------------------------------------------------
      FUNCTION bottomSWW(x,delta,alambda)

      ONE = 1.0
      PI  = 4.0*ATAN(ONE)

      y   = delta*COS(2.0*PI*x/alambda)

      bottomSWW = y

      return
      END
c-----------------------------------------------------------------------

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
