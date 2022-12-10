#!/bin/bash
#SBATCH --mail-type=NONE    # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=wae16sru@uea.ac.uk     # Where to send mail
#SBATCH -p gpu-rtx6000-2
#SBATCH --qos=gpu-rtx
#SBATCH --gres=gpu:1             # Select compute-64-512 queue
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH -t 96:00:00             # Set time limit to 96 hours
#SBATCH --job-name=diff_proc_dtifit      # Set job name
#SBATCH -o diff_proc-dtifit-%j.out               # Write job output to bbb_proc-(job_number).out
#SBATCH -e diff_proc-dtifit-%j.err               # Write job error to bbb_proc-(job_number).err
#set up environment


#source /gpfs/home/wae16sru/APOLLO_MR_data/diff_proc_dtifit.sh && dtifit_pipe $(ls -d AP*)

source /gpfs/home/wae16sru/APOLLO_MR_data/diff_proc_dtifit.sh && dtifit_pipe AP45_v1




