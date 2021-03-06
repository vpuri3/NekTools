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
# define tSTATSTART param(3)
# define tSTATFREQ  param(4)
# define readSTAT   param(5)
c
#define XLEN (4.0)
#define YLEN (1.0)
#define ZLEN (2.0)
#define PI (4.*atan(1.))
C-----------------------------------------------------------------------
      include 'writefile.usr'
C-----------------------------------------------------------------------
      subroutine uservp(ix,iy,iz,eg) ! set variable properties
      include 'SIZE'
      include 'TOTAL'
      include 'NEKUSE'

      integer e,f,eg

      e = gllel(eg)

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
      common /cforce/ ffx_new,ffy_new,ffz_new

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
      source = 0.0

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

      real eps,kx,ky,kz,alpha,beta,gam

      ux   = 6 * ( y - y*y)
      uy   = 0.0
      uz   = 0.0
      temp = 0.0

c     perturb
      eps = 1e-2
      kx  = 1
      kz  = 5

      alpha = kx * 2*PI/XLEN
      beta  = kz * 2*PI/ZLEN 

      ux  = ux  + eps*beta  * sin(alpha*x)*cos(beta*z) 
      uy  =       eps       * sin(alpha*x)*sin(beta*z)
      uz  =      -eps*alpha * cos(alpha*x)*sin(beta*z)

c     eps = 1e-4
c     kx  = 15
c     kz  = 17

c     alpha = kx * 2*PI/XLEN
c     gam   = kz * 2*PI/ZLEN 

c     ux  = ux  + eps*gam   * sin(alpha*x)*cos(gam*z) 
c     uy  =       eps       * sin(alpha*x)*sin(gam*z)
c     uz  =      -eps*alpha * cos(alpha*x)*sin(gam*z)

      return
      end
c-----------------------------------------------------------------------
      subroutine userchk()
      include 'SIZE'
      include 'TOTAL'

      real tmp1,tmp2,tmp3,tmp4

      tmp1 = 1.
      tmp2 = 2.
      tmp3 = 3.
      tmp4 = 4.

      call write2file(tmp1,tmp2,tmp3,tmp4,'fil'
     $              ,'aaa','bbb','ccc','ddd',10,2,3)

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat()   ! This routine to modify element vertices
      include 'SIZE'
      include 'TOTAL'

      common /cdsmag/ ediff(lx1,ly1,lz1,lelv)

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat2()  ! This routine to modify mesh coordinates
      include 'SIZE'
      include 'TOTAL'

      call rescale_x(xm1,0.0,XLEN)
      call rescale_x(ym1,0.0,YLEN)
      call rescale_x(zm1,0.0,ZLEN)

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat3()
      include 'SIZE'
      include 'TOTAL'

      param(54) = -1
      param(55) = 1
      return
      end
C=======================================================================
      subroutine e2_out
      include 'SIZE'
      include 'TOTAL'
c
c     prints out uvwp abs max and volume average/rms
 

      n   = nx1*ny1*nz1*nelv
      m   = nx2*ny2*nz2*nelv
      vxm = glamax(vx,n)			! absolute value max
      vym = glamax(vy,n)
      prm = glamax(pr,m)
      vxa = glsc2(vx,   bm1,n) / volvm1		! volume-average
      vya = glsc2(vy,   bm1,n) / volvm1
      pra = glsc2(pr,   bm2,m) / volvm2
      vx2 = glsc3(vx,vx,bm1,n) / volvm1
      vy2 = glsc3(vy,vy,bm1,n) / volvm1
      pr2 = glsc3(pr,pr,bm2,m) / volvm2
      vx2 = vx2 - vxa*vxa
      vy2 = vy2 - vya*vya
      pr2 = pr2 - pra*pra
      if (vx2.gt.0) vx2 = sqrt(vx2)		! volume-rms
      if (vy2.gt.0) vy2 = sqrt(vy2)
      if (pr2.gt.0) pr2 = sqrt(pr2)

      if (if3d) then				! 3D
         vzm = glamax(vz,n)
         vza = glsc2(vz,   bm1,n) / volvm1
         vz2 = glsc3(vz,vz,bm1,n) / volvm1
         vz2 = vz2 - vza*vza
         if (vz2.gt.0) vz2 = sqrt(vz2)

         if (nid.eq.0) write(6,1) istep,time,vxa,vya,vza,pra ! 1-2  3-6
     $                      ,vx2,vy2,vz2,pr2,vxm,vym,vzm,prm ! 7-10 11-13
      else
         if (nid.eq.0) write(6,2) istep,time,vxa,vya,pra     ! 1-2 3-5
     $                          ,vx2,vy2,pr2,vxm,vym,prm     ! 6-8 9-11
      endif
    1 format(i7,1p13e16.7,' e2')
    2 format(i7,1p10e16.7,' e2')

      return
      end
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
