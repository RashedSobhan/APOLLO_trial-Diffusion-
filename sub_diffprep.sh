#!/bin/bash

for subj_dir in */ ; do
    echo "$subj_dir"
    _98_AP_file=$(ls $subj_dir*dMRI_dir98_AP*.bvec)
    filename=$(basename -- "$_98_AP_file")
    _98_AP="${filename%.*}"
    if [ -z "$_98_AP" ]
    then
      continue
    fi    
    
    _99_AP_file=$(ls $subj_dir*dMRI_dir99_AP*.bvec)
    filename=$(basename -- "$_99_AP_file")
    _99_AP="${filename%.*}"
    if [ -z "$_99_AP" ]
    then
      continue
    fi

    _98_PA_file=$(ls $subj_dir*dMRI_dir98_PA*.bvec)
    filename=$(basename -- "$_98_PA_file")
    _98_PA="${filename%.*}"
    if [ -z "$_98_PA" ]
    then
      continue
    fi

    _99_PA_file=$(ls $subj_dir*dMRI_dir99_PA*.bvec)
    filename=$(basename -- "$_99_PA_file")
    _99_PA="${filename%.*}"
    if [ -z "$_99_PA" ]
    then
      continue
    fi

    sed -e "s#<subj_dir>#$subj_dir#g" -e "s#<98_AP>#$_98_AP#g" -e "s#<99_AP>#$_99_AP#g" -e "s#<98_PA>#$_98_PA#g" -e "s#<99_PA>#$_99_PA#g"< basejob.sh | sbatch

done
