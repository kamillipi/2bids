#!/bin/bash
#
#	$1=workdir (tempdir)
#	$2=participant label
#	$3=output
#	$4=session_label

T1w_index=1
T2w_index=1
T1rho_index=1
T1map_index=1
T2map_index=1
T2star_index=1
FLAIR_index=1
FLASH_index=1
PD_index=1
PDT2_index=1
inplaneT1_index=1
inplaneT2_index=1
angio_index=1
defacemask_index=1
SWImagandphase_index=1
task_index=1
rest_index=1
dwi_index=1
fmri_index=1
unassigned_index=1

elements=$(ls)
echo "found elements"
echo $elements

for element in ${elements[*]}
    do
    
    cd $1/$element
    
    echo "I'm in"
    pwd
	
	header=$(ls *.json)
	echo "found jsons"
	echo $header
	images=$(ls *.gz)
	echo "found images"
	echo $images
	
	IN=$(grep -Po '"ProtocolName":.*?[^\\]",' $header)
	sequence=$(echo $IN | tr "\" ,:" "\n")
	parse=(`echo $sequence`)
	lowercase_sequence=`echo ${parse[1]} | tr [:upper:] [:lower:]`
	acq_label=`echo ${parse[1]} | sed 's/["(""_"")""]//g' `
	
	case $lowercase_sequence in
	
	*"rest"*)
		echo "found resting state fMRI"
			cp $images $3/func/sub-$2_ses-$4_task-rest_run-$rest_index\_bold.nii.gz
			cp $header $3/func/sub-$2_ses-$4_task-rest_run-$rest_index\_bold.json
			((rest_index++))
			 ;;
	*"task"*) 
		echo "found task fMRI"
			cp $images $3/func/sub-$2_ses-$4_task-$acq_label\_run-$task_index\_bold.nii.gz
			cp $header $3/func/sub-$2_ses-$4_task-$acq_label\_run-$task_index\_bold.json
			((task_index++))
			 ;;
	*"fmri"*) 
	    echo "found fMRI"
	        cp $images $3/func/sub-$2_ses-$4_task-$acq_label\_run-$fmri_index\_bold.nii.gz
	        cp $header $3/func/sub-$2_ses-$4_task-$acq_label\_run-$fmri_index\_bold.json
	        ((fmri_index++))
	        ;;
	*"dwi"*)
		echo "found dwi"
		bval=$(ls *.bval)
		bvec=$(ls *.bvec)
			cp $images $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.nii.gz
			cp $header $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.json
			cp $bvec $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.bvec
			cp $bval $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.bval
			((dwi_index++))
			 ;;
	*"dti"*)
		echo "found dwi"
		bval=$(ls *.bval)
		bvec=$(ls *.bvec)
			cp $images $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.nii.gz
			cp $header $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.json
			cp $bvec $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.bvec
			cp $bval $3/dwi/sub-$2_ses-$4_run-$dwi_index\_dwi.bval
			((dwi_index++))
			 ;;
	*"flair"*)
		echo "found FLAIR"
			cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$FLAIR_index\_FLAIR.nii.gz
			cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$FLAIR_index\_FLAIR.json
			((FLAIR_index++))
			 ;;
	*"flash"*)
		echo "found FLASH"
			cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$FLASH_index\_FLASH.nii.gz
			cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$FLASH_index\_FLASH.json
			((FLASH_index++))
			 ;;
	*"t1"*)
		case $lowercase_sequence in
		*"rho"*)
			echo "found T1 Rho"
				cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T1rho_index\_T1map.nii.gz
				cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T1rho_index\_T1map.json
				((T1rho_index++))
				 ;;
	
		*"map"*)
			echo "found T1 map"
				cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T1map_index\_T1map.nii.gz
				cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T1map_index\_T1map.json
				 ;;
		*)
			echo "found T1 weighted"
				cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T1w_index\_T1w.nii.gz
				cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T1w_index\_T1w.json
				((T1w_index++))
				 ;;
	
		esac;;
		
	*"t2"*)
		case $lowercase_sequence in
		*"map"*)
			echo "found T2 map"
				cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2map_index\_T2map.nii.gz
				cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2map_index\_T2map.json
				((T2map_index++))
				 ;;
		*"*"*)
			echo "found T2 STAR weighted"
				cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2star_index\_T2star.nii.gz
				cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2star_index\_T2star.json
				((T2star_index++))
				 ;;
		*"star"*)
			echo "found T2 STAR weighted"
				cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2star_index\_T2star.nii.gz
				cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2star_index\_T2star.json
				((T2star_index++))
				 ;;
		*)
			echo "found T2 weighted"
				cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2w_index\_T2w.nii.gz
				cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$T2w_index\_T2w.json
				((T2w_index++))
				 ;;
		esac;;
	*"roton"*)
		echo "found PD"
			cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$PD_index\_PD.nii.gz
			cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$PD_index\_PD.json
			((PD_index++))
			 ;;
	*"ngiography"*)
		echo "found Angio"
			cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$angio_index\_angio.nii.gz
			cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$angio_index\_angio.json
			((angio_index++))
			 ;;
	*"swi"*)
		echo "found swi"
			cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$SWImagandphase_index\_SWImagandphase.nii.gz
			cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$SWImagandphase_index\_SWImagandphase.json
			((SWImagandphase_index++))
			 ;;
	*"fac"*)
		echo "found Defacing mask"
			cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$defacemask_index\_defacemask.nii.gz
			cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$defacemask_index\_defacemask.json
			((defacemask_index++))
			;;
	*"pd"*)
		echo "found PD"
			cp $images $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$PD_index\_PD.nii.gz
			cp $header $3/anat/sub-$2_ses-$4_acq-$acq_label\_run-$PD_index\_PD.json
			((PD_index++))
			 ;;
	*)
		case $acq_label in
			
			*"nback"*) 
	        echo "found n-back"
	                cp $images $3/func/sub-$2_ses-$4_task-nback_run-$fmri_index\_bold.nii.gz
	                cp $header $3/func/sub-$2_ses-$4_task-nback_run-$fmri_index\_bold.json
	                ((fmri_index++))
	                 ;;
			*) 
			echo "err: scans not assigned"
					if [ $unassigned_index -eq 1 ]
						then 
							mkdir $3/unassigned
						fi
			        cp $images $3/unassigned/sub-$2_ses-$4_run-$unassigned_index\-${parse[1]}_MODALITY.nii.gz
			        cp $header $3/unassigned/sub-$2_ses-$4_run-$unassigned_index\-${parse[1]}_MODALITY.json
			        ((unassigned_index++))
			        ;;
		esac;;
	esac
done
rm -r $1
rm -r $1/../RAW