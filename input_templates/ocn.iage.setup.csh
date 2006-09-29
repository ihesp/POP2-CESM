#!/bin/csh -f

#===============================================================================
#  ocn.iage.setup.csh : perform setup tasks for ideal age module
#
#  recognized commands, possibly with arguments, are
#    set_nt         nt_filename
#    namelist       pop_in_filename
#    tavg_contents  tavg_contents_filename
#    prestage       res_dpt_dir res_indpt_dir
#
#  SVN:$Id$
#
#===============================================================================

if ($#argv < 1) then
   echo ocn.iage.setup.csh : command argument missing
   exit 1
endif

set command = $1

if ($command == set_nt) then

   echo -----------------------------------------------------------------
   echo ocn.iage.setup.csh : setting nt
   echo -----------------------------------------------------------------

   if ($#argv < 2) then
      echo nt_filename argument missing
      exit 3
   endif

   set nt_filename = $2

   if !(-f $nt_filename) then
      echo nt_filename = $nt_filename does not exist
      exit 3
   endif

   @ nt_in = `cat $nt_filename`
   @ nt_in += 1
   echo $nt_in >! $nt_filename

else if ($command == namelist) then

   echo -----------------------------------------------------------------
   echo ocn.iage.setup.csh : setting namelist options
   echo -----------------------------------------------------------------

   if ($#argv < 2) then
      echo pop_in_filename argument missing
      exit 4
   endif

   set pop_in_filename = $2

   if !(-f $pop_in_filename) then
      echo pop_in_filename = $pop_in_filename does not exist
      exit 4
   endif

   cat >> $pop_in_filename << EOF

&iage_nml
   init_iage_option = 'RUNTYPE'
   init_iage_init_file = 'same_as_TS'
/
EOF

else if ($command == tavg_contents) then

   echo -----------------------------------------------------------------
   echo ocn.iage.setup.csh : setting tavg_contents variables
   echo -----------------------------------------------------------------

   if ($#argv < 2) then
      echo tavg_contents_filename argument missing
      exit 5
   endif

   set tavg_contents_filename = $2

   if !(-f $tavg_contents_filename) then
      echo tavg_contents_filename = $tavg_contents_filename does not exist
      exit 5
   endif

   echo "IAGE "       >> $tavg_contents_filename

#  disable the following until they are computed correctly
#  echo "IAGE_SQR "   >> $tavg_contents_filename
#  echo "UE_IAGE "    >> $tavg_contents_filename
#  echo "VN_IAGE "    >> $tavg_contents_filename
#  echo "WT_IAGE "    >> $tavg_contents_filename
#  echo "ADV_IAGE "   >> $tavg_contents_filename
#  echo "J_IAGE "     >> $tavg_contents_filename
#  echo "Jint_IAGE "  >> $tavg_contents_filename
#  echo "STF_IAGE "   >> $tavg_contents_filename
#  echo "RESID_IAGE " >> $tavg_contents_filename
#  echo "FvPER_IAGE " >> $tavg_contents_filename
#  echo "FvICE_IAGE " >> $tavg_contents_filename

else if ($command == prestage) then

   echo -----------------------------------------------------------------
   echo ocn.iage.setup.csh : prestaging data files
   echo -----------------------------------------------------------------

else

   echo -----------------------------------------------------------------
   echo ocn.iage.setup.csh : unrecognized command argument $command
   echo -----------------------------------------------------------------

   exit 2

endif