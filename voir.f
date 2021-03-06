      program woir

*Revision 98.11 - M. Lepine - reload, detection mauvais type de fichier (xdfopn)
*         98.12 - M. Lepine - utilisation de ccard_arg
*         98.13 - M. Lepine - flush des buffers de stdout dans exfin
*         98.14 - M. Lepine - reload librmn_008
*         98.15 - M. Lepine - reload librmnbeta, correction impression dans convip
*         98.16 - M. Lepine - reload librmn_009
*         98.17 - M. Lepine - sept 2007 - reload librmnbeta, correction fichiers > 2G
*         98.18 - M. Lepine - sept 2007 - reload pour dates etendues 
*         98.19 - M. Lepine - sept 2008 - reload pour fichier cmcarc remote 
*         98.20 - M. Lepine - dec  2010 - reload avec librmn_012 et codebeta moduledate 
*         98.21 - M. Lepine - sept 2011 - reload avec librmn_012 et codebeta moduledate_711e, fstd98
*         98.22 - M. Lepine - juin 2012 - reload avec librmn_013
*         98.30 - M. Lepine - mars 2014 - reload avec librmn_014
*         98.31 - M. Lepine - juin 2014 - ajout de implicit none
*         98.32 - M. Lepine - Dec  2014 - reload avec librmn_015.1
*         98.33 - M. Lepine - Fev. 2015 - reload avec librmn_015.2

      implicit none
      integer, parameter :: ncle=4
      integer fnom,fstouv,fstvoi,fstfrm,exdb,exfin
      external fnom,fstouv,fstvoi,fstnbr,ccard,c_init_appl_var_table
      character *8192 ccard_arg
      external exdb,exfin,ccard_arg
      integer ipos,ier,n

      character * 8 cles(ncle)
      character * 128 val(ncle), def(ncle)
      data cles / 'IMENT:','SEQ','STYLE','HELP' /
      data def / 'scrap','SEQ' ,'NINJNK+DATEV+LEVEL+IP1+GRIDINFO',
     %           'MOREHELP'/
      data val / 'scrap','RND' ,'NINJNK+DATEO+IP1+IG1234',' '/

      call c_init_appl_var_table()
      ipos = -1
      call ccard (cles,def,val,ncle,ipos)

      IF (val(4) .eq. 'MOREHELP') THEN
         print *,"*** VOIR CALLING SEQUENCE ***"
         print *
         print *,'-IMENT [scrap:scrap]'
         print *,'-SEQ [RND:SEQ]'
         print *,
     %'-STYLE [NINJNK DATEO IP1 IG123:NINJNK DATEV LEVEL IP1 GRIDINFO]'
         print *,'   List of possible items for STYLE argument:'
         print *,'         NINJNK: display ni nj nk dimensions'
         print *,"          DATEO: display origin date"     
         print *,'     DATESTAMPO: display origin datetimestamp',
     %           ' for the nostalgics'
         print *,'          DATEV: display valid date and stamp'
         print *,'          LEVEL: display vertical level'
         print *,'            IP1: display coded IP1 value'
         print *,'       GRIDINFO: display decoded grid information'
         print *,'         IG1234: display IG1 IG2 IG3 IG4 values'
         print *
         print *,'     The following items suppress variable printout'
         print *,'         NONOMV: suppress NOMV information'
         print *,'         NOTYPV: suppress TYPV information'
         print *,'         NOETIQ: suppress ETIQUETTE information'
         print *,'         NOIP23: suppress IP2, IP3 information'
         print *,'         NODEET: suppress DEET information'
         print *,'         NONPAS: suppress NPAS information'
         print *,'          NODTY: suppress DTY information'
         print *
         print *,'   Example #1: -style "ninjnk datev level"'       
         print *,'   Example #2: -style datev+level+ip1+notypv'
      else
         ier = exdb('VOIR','V98.33','NON')
c         print *,'Debug+ ccard_arg(cles(1)) = ',
c     %   trim(ccard_arg(cles(1)))
         ier = fnom(10,trim(ccard_arg(cles(1))),
     %             'STD+R/O+REMOTE'//val(2),0)
         if (ier .ge. 0) then
            N = fstouv(10,VAL(2))
            ier = fstvoi(10,val(3))
            ier = fstfrm(10)
            ier = exfin('VOIR','O.K.','NON')
         else
            ier = exfin('VOIR','<< ERREUR >>','NON')
         endif
      endif
      stop
      end
      
      character *128 function product_id_tag()
      product_id_tag='$Id$'
      return
      end
