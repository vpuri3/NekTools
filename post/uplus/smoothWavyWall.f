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
#define DELTA 0.2
#define XLEN 1.
#define YLEN 1.
#define ZLEN 1.
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

      integer idum
      save    idum 
      data    idum / 0 /

      ux = y*y
      uy = 0
      uz = 0

      return
      end
c-----------------------------------------------------------------------
      subroutine userchk()
      include 'SIZE'
      include 'TOTAL'

      parameter(lxyz = lx1*ly1*lz1)
      parameter(nxzf = 2*ldim)
c
      real upl(lx1,ly1,lz1,lelv)
      real ypl(lx1,ly1,lz1,lelv)
      integer f,ifld,idir
      character*3 bctyp
c 
      integer gs_sctr_hndl
      save    gs_sctr_hndl
      data    gs_sctr_hndl / 0 /
c
      common /uplus/ fTx(lx1,ly1,lz1,lelv) ! shear stress X-comp
     $             , fTy(lx1,ly1,lz1,lelv) !              Y   
     $             , fTz(lx1,ly1,lz1,lelv) !              Z
     $             , fTm(lx1,ly1,lz1,lelv) !              Mag    
     $             , fNx(lx1,ly1,lz1,lelv) ! face normal  X-comp
     $             , fNy(lx1,ly1,lz1,lelv) !              Y
     $             , fNz(lx1,ly1,lz1,lelv) !              Z 
c
     $             , volTx(lx1,ly1,lz1,lelv)
     $             , volTy(lx1,ly1,lz1,lelv)
     $             , volTz(lx1,ly1,lz1,lelv)
     $             , volTm(lx1,ly1,lz1,lelv)
     $             , volNx(lx1,ly1,lz1,lelv)
     $             , volNy(lx1,ly1,lz1,lelv)
     $             , volNz(lx1,ly1,lz1,lelv)
c
     $             , utan(lx1,ly1,lz1,lelv) ! tangential velocity mag
     $             , unor(lx1,ly1,lz1,lelv) ! normal     velocity mag
     $             , d2f (lx1,ly1,lz1,lelv) ! distance to face
c
      common /ctmp1/ ur(lxyz),us(lxyz),ut(lxyz)
     $             , vr(lxyz),vs(lxyz),vt(lxyz)
     $             , wr(lxyz),ws(lxyz),wt(lxyz)

      real sij(lx1,ly1,lz1,nxzf,lelv) ! strain rate tensor
c
ccccccccccccccccccccccc
      integer n,nxzf,e,i,j
      real n1,n2,n3,x,y,z,tmp,t1,t2,t3,dsty,vsc
      real s11,s12,s13
      real s21,s22,s23
      real s31,s32,s33
      real s1(lx1,ly1,lz1,lelv)
     $    ,s2(lx1,ly1,lz1,lelv)
     $    ,s3(lx1,ly1,lz1,lelv)
     $    ,s4(lx1,ly1,lz1,lelv)
     $    ,s5(lx1,ly1,lz1,lelv)
     $    ,s6(lx1,ly1,lz1,lelv)
ccccccccccccccccccccccc

      f     = 1
      bctyp = 'W  '
      nelx  = 10
      nely  = 10
      nelz  = 10
      ifld  = 1
      idir  = 2
c
      call comp_uplus(upl,ypl,vx,vy,vz,f,bctyp,gs_sctr_hndl
     $                      ,nelx,nely,nelz,ifld,idir)

cccccccccccccccccccccccccccccc
c     checking normal and shear stress
cccccccccccccccccccccccccccccc
      dsty = param(1)
      vsc  = param(2)
      n    = lx1*ly1*lz1*nelv
c
      call rzero(sij,n*nxzf)
      call comp_sij(sij,nxzf,vx,vy,vz,ur,us,ut,vr,vs,vt,wr,ws,wt)
c
      do e=1,nelv
         do i=1,lx1*ly1*lz1
            x = xm1(1,1,i,e)
            y = ym1(1,1,i,e)
            z = zm1(1,1,i,e)
c
            s1(1,1,i,e) = 0
            s2(1,1,i,e) = 0
            s3(1,1,i,e) = 0
            s4(1,1,i,e) = 2*y
            s5(1,1,i,e) = 0
            s6(1,1,i,e) = 0
c
            s1(1,1,i,e) = abs(sij(1,1,i,1,e)- s1(1,1,i,e)*vsc) ! 2dudx
            s2(1,1,i,e) = abs(sij(1,1,i,2,e)- s2(1,1,i,e)*vsc) ! 2dvdy
            s3(1,1,i,e) = abs(sij(1,1,i,3,e)- s3(1,1,i,e)*vsc) ! 2dwdz
            s4(1,1,i,e) = abs(sij(1,1,i,4,e)- s4(1,1,i,e)*vsc) ! u_y + v_x
            s5(1,1,i,e) = abs(sij(1,1,i,5,e)- s5(1,1,i,e)*vsc) ! v_z + w_y
            s6(1,1,i,e) = abs(sij(1,1,i,6,e)- s6(1,1,i,e)*vsc) ! u_z + w_x
         enddo
      enddo

      do e=1,nelv
        if (cbc(f,e,ifld).eq.bctyp) then
          iface  = eface1(f)   ! surface to volume shifts
          js1    = skpdat(1,iface)
          jf1    = skpdat(2,iface)
          jskip1 = skpdat(3,iface)
          js2    = skpdat(4,iface)
          jf2    = skpdat(5,iface)
          jskip2 = skpdat(6,iface)

          k = 0
          do j2=js2,jf2,jskip2
          do j1=js1,jf1,jskip1
            k = k + 1
c
            x = xm1(j1,j2,1,e)
            y = ym1(j1,j2,1,e)
            z = zm1(j1,j2,1,e)
c
            tmp = 1 + ssx(x,DELTA)**2
            tmp = sqrt(tmp)
            n1 = ssx(x,DELTA)/tmp
            n2 = -1.0        /tmp
            n3 =  0.0
c
            s11 = sij(j1,j2,1,1,e) ! s1
            s21 = sij(j1,j2,1,4,e) ! s4
            s31 = sij(j1,j2,1,6,e) ! s6
c
            s12 = sij(j1,j2,1,4,e) ! s4
            s22 = sij(j1,j2,1,2,e) ! s2
            s32 = sij(j1,j2,1,5,e) ! s5
c
            s13 = sij(j1,j2,1,6,e) ! s6
            s23 = sij(j1,j2,1,5,e) ! s5
            s33 = sij(j1,j2,1,3,e) ! s3
cccccccccccccccccc
            s11 = 0.0 
            s21 = 2*y
            s31 = 0.0 
c
            s12 = 2*y
            s22 = 0.0 
            s32 = 0.0 
c
            s13 = 0.0 
            s23 = 0.0 
            s33 = 0.0 
c
            t1 = -(s11*n1 + s12*n2 + s13*n3)*vsc*dsty
            t2 = -(s21*n1 + s22*n2 + s23*n3)*vsc*dsty
            t3 = -(s31*n1 + s32*n2 + s33*n3)*vsc*dsty
c
            fTx(j1,j2,1,e) = abs(fTx(j1,j2,1,e) - t1)
            fTy(j1,j2,1,e) = abs(fTy(j1,j2,1,e) - t2)
            fTz(j1,j2,1,e) = abs(fTz(j1,j2,1,e) - t3)
c
            fNx(j1,j2,1,e) = abs(fNx(j1,j2,1,e) - n1)
            fNy(j1,j2,1,e) = abs(fNy(j1,j2,1,e) - n2)
            fNz(j1,j2,1,e) = abs(fNz(j1,j2,1,e) - n3)
c
          enddo
          enddo

        endif
      enddo

      tmp = glmax(s1,n)
      if(nid.eq.0) write(6,*) "error s1", tmp
      tmp = glmax(s2,n)
      if(nid.eq.0) write(6,*) "error s2", tmp
      tmp = glmax(s3,n)
      if(nid.eq.0) write(6,*) "error s3", tmp
      tmp = glmax(s4,n)
      if(nid.eq.0) write(6,*) "error s4", tmp
      tmp = glmax(s5,n)
      if(nid.eq.0) write(6,*) "error s5", tmp
      tmp = glmax(s6,n)
      if(nid.eq.0) write(6,*) "error s6", tmp
c
      tmp = glmax(fTx,n)
      if(nid.eq.0) write(6,*) "max error in x-shear is ", tmp
      tmp = glmax(fTy,n)
      if(nid.eq.0) write(6,*) "max error in y-shear is ", tmp
      tmp = glmax(fTz,n)
      if(nid.eq.0) write(6,*) "max error in z-shear is ", tmp
c
      tmp = glmax(fNx,n)
      if(nid.eq.0) write(6,*) "max error in x-normal is ", tmp
      tmp = glmax(fNy,n)
      if(nid.eq.0) write(6,*) "max error in y-normal is ", tmp
      tmp = glmax(fNz,n)
      if(nid.eq.0) write(6,*) "max error in z-normal is ", tmp


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

      ! element vertices unchanged since XLEN = (xmax-xmin) = 1

      n = nx1*ny1*nz1*nelt 
      call cfill(ediff,param(2),n)  ! initialize viscosity

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat2()  ! This routine to modify mesh coordinates
      include 'SIZE'
      include 'TOTAL'

       nt = nx1*ny1*nz1*nelt
 
       call rescale_x(xm1, 0.0, 1.0)
       call rescale_x(ym1, 0.0, 1.0)
       call rescale_x(zm1, 0.0, 1.0)
       ! box \vect{x} \in [0,1]^3

       del = 0.2
       do i=1,nt
         x  = xm1(i,1,1,1)
         y  = ym1(i,1,1,1)
         z  = zm1(i,1,1,1)
 
         yw = ss(x,DELTA)
 
         yy = (1. - yw/1.0)*y + yw
         ym1(i,1,1,1) = yy
       enddo

      return
      end
c-----------------------------------------------------------------------
      subroutine usrdat3()
      include 'SIZE'
      include 'TOTAL'

      return
      end
c-----------------------------------------------------------------------
      function ss(x,d)          ! bottom surface y = ss(x,d)

      ss = 1.0 - (2.0*x-1.0)**2
      ss = ss*d

      return
      end
c-----------------------------------------------------------------------
      function ssx(x,d)          ! d(ss)/dx

      ssx = -4.0*(2.0*x-1)
      ssx = ssx*d

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
