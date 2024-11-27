export PATHTOPROJECT=/Source
export OUTPUTPATH=/out
export FILENAME=titan_regs.ditamap
export DITAMAPNAME=titan_regs.ditamap

cd ../

export WORKINGDIR=$PWD

export WHICHJAVA=which java

java -version
echo $WHICHJAVA
echo $WORKINGDIR
echo $PATHTOPROJECT
echo $OUTPUTPATH
echo $FILENAME
echo $DITAMAPNAME

cd $WORKINGDIR/batchfiles

mkdir $WORKINGDIR/out/


 
