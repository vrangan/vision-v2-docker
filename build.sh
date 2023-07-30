#!/bin/bash
cd /vision-v2-repos
script build.out
if [ ! -d VisionFive2 ]; then
    echo "Cloning repos."
    git clone https://github.com/starfive-tech/VisionFive2.git 
else
  if [ ! -d VisionFive2/.git ]; then
    echo "VisionFive2 directory already exists and is not a git repo"
    echo "Quiting"
    exit 1
  fi
fi
cd VisionFive2
git pull  --rebase # if already cloned - to get latest updates
git checkout JH7110_VisionFive2_devel
git submodule update --init --recursive
git submodule foreach git checkout JH7110_VisionFive2_devel
echo "Patching LVM2 site in buildroot as Redhat site is no longer accessible"
git apply //vision-v2/lvm2site.patch
(cd opensbi; git checkout master)
echo "Starting build at : `date`"
echo "May take a few hours"
make -j$(nproc)
echo "Done building at: `date`"
exit  # Exiting the script 
