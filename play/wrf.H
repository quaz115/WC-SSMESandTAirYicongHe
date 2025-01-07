

HELLO






PROGRAM wrf

   USE module_wrf_top, only : wrf_init, wrf_dfi, wrf_run, wrf_finalize
#if ( WRFPLUS == 1 )
   USE module_wrf_top, only : config_flags, wrf_adtl_check, &
                              wrf_run_tl_standalone, wrf_run_ad_standalone
   USE module_state_description, only : dyn_em, dyn_em_tl, dyn_em_ad
#endif











   IMPLICIT NONE

#ifdef _OPENMP
  CALL setfeenv()
#endif

  
  CALL wrf_init    

  
  CALL wrf_dfi

#if ( WRFPLUS == 1 )
  
  CALL wrf_adtl_check
#endif

  
#if ( WRFPLUS == 1 )
  IF  ( config_flags%dyn_opt .EQ. dyn_em ) &
#endif
  CALL wrf_run

#if ( WRFPLUS == 1 )
  
  IF  ( config_flags%dyn_opt .EQ. dyn_em_tl .and. config_flags%tl_standalone ) &
  CALL wrf_run_tl_standalone

  
  IF  ( config_flags%dyn_opt .EQ. dyn_em_ad ) &
  CALL wrf_run_ad_standalone
#endif

  
  CALL wrf_finalize

END PROGRAM wrf


