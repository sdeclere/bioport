#!/bin/bash

# where to find binary
ARCH=`uname -s 2>/dev/null || echo not`
BWA="${BIOPORTS}/ports/$ARCH/bin/bwa index"

## funcs
function run {
    "$@" > /dev/null
    status=$?
    if [ $status -ne 0 ]; then
        echo "** error with $1"
        exit 1
    fi
    return $status
}
## main starts here 

# arrays of argumnets 
pav=() # for pavane 
bwa=() # for bwa

# remove pavane arg from command line 
for a in "$@" 
  do
  if [[ $a == "--pav-"* ]]  ; 
      then 
      pav+=($a)
  else 
      bwa+=($a)
  fi 
done

PAV_DIR=""

## now treats pavane's specifics arguments 
for aa in ${pav[@]} 
  do
  case $aa in
      --pav-ref*)
	  PAV_REF="${aa#*=}";
	  ;; 
      --pav-dir*) 
	  PAV_DIR="${aa#*=}";
	  ;; 
      *) echo "unknown option:$aa";
	  exit 1 
  esac 
done 

# test if var are defined 
[[ "$PAV_REF" && ${PAV_REF-x} ]] && true || exit 3; 
[[ "$PAV_DIR" && ${PAV_DIR-x} ]] && true || exit 4; 

# test if dir exists 
if [ -d "${PAV_DIR}" ] ; then 
    echo "Directory "$PAV_DIR" already exists";
    \rm -fr ${PAV_DIR};    
fi 

# push current dir
pushd . 

# trap seg faults 
trap 'popd && rm -fr "$PAV_DIR"; exit 2' SEGV

# make a dir and run bwa 
\mkdir "$PAV_DIR" && \cd "$PAV_DIR" && ln -s "$PAV_REF" . && run $BWA ${bwa[@]} `basename "$PAV_REF"`  

if [ "$?" -ne "0" ]; then 
    popd && \rm -fr "$PAV_DIR"
    exit 2;
fi

# cleanup 
echo "$PWD"
popd >/dev/null 

exit $?  # return execution status 
