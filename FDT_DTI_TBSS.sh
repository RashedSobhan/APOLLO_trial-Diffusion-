#!/bin/bash

if [ $# -ne 1 ];
then

echo "Please provide path to working directory. E.g., $0 /Your/data/folder/ds001226-download"

else

dir=$1

#create a TBSS folder
cd $dir

mkdir TBSS

#copy control and Meningioma I patient FA maps to TBSS folder
for f in sub-CON*
do

cp ./$f/ses-preop/dwi/dti_FA.nii.gz ./TBSS/${f}_FA.nii.gz

done

for f in {01,02,03,06,08,10,13,14,15,17,19}
do

cp ./sub-PAT$f/ses-preop/dwi/dti_FA.nii.gz ./TBSS/sub-PAT${f}_FA.nii.gz

done


#run slicesdir to inspect the data
cd TBSS

slicesdir `imglob *`

#prepare the FA data for TBSS: tbss_1_preproc
tbss_1_preproc *nii.gz

#register all FA images to template space: tbss_2_reg
tbss_2_reg -T

#post-registration processing: tbss_3_postreg
tbss_3_postreg -S

#check tbss_3_postreg output
cd stats

fsleyes -std1mm mean_FA -cm red-yellow -dr 0.2 0.6

fsleyes all_FA mean_FA_skeleton -cm green -dr 0.2 0.6

cd ..

#project all FA data on the skeleton: tbss_4_prestats
tbss_4_prestats 0.3 

#check tbss_4_output
fsleyes all_FA_skeletonised.nii.gz


#create design matrix and contrast file
cd stats
design_ttest2 design 11 11

#run statistical inference using randomise
randomise -i all_FA_skeletonised -o tbss_results -m mean_FA_skeleton_mask -d design.mat -t design.con -n 5000 --T2 -V

#visualise the results with fsleyes: unthresholded t-maps will show in red, and significant differences in blue
#tstat1 maps correspond to the controls>patients comparison
fsleyes -std1mm mean_FA_skeleton -cm green -dr 0.3 0.7 tbss_results_tstat1 -cm red-yellow -dr 1.5 3 tbss_results_tfce_corrp_tstat1 -cm blue-lightblue -dr 0.95 1

fi
