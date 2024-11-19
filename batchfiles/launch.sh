export PATHTOPROJECT=\Source
export OUTPUTPATH=\out
export FILENAME=titan_regs.ditamap
export DITAMAPNAME=titan_regs.ditamap

cd ..\

export WORKINGDIR=$CD

cd $WORKINGDIR\batchfiles

rd /s /q $WORKINGDIR\out\

mkdir $WORKINGDIR\out\

java -cp $WORKINGDIR/depend/tools/saxon9/saxon9he.jar;$WORKINGDIR\depend\tools\Saxon9\xml-commons-resolver-1.2.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:$WORKINGDIR$OUTPUTPATH\test.xml ^
-s:$WORKINGDIR\$PATHTOPROJECT\$FILENAME ^
-xsl:$WORKINGDIR\depend\custom\generate_ditamap.xsl ^
DITAMAPNAME="$DITAMAPNAME" PATHTOPROJECT="$PATHTOPROJECT" OUTPUTPATH="$OUTPUTPATH" WORKINGDIR="$WORKINGDIR" 
  
  
java -cp $WORKINGDIR/depend/tools/saxon9/saxon9he.jar;$WORKINGDIR\depend\tools\Saxon9\xml-commons-resolver-1.2.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:$WORKINGDIR$OUTPUTPATH\test.xml ^
-s:$WORKINGDIR\$PATHTOPROJECT\$FILENAME ^
-xsl:$WORKINGDIR\depend\custom\generate_topics.xsl ^
PATHTOPROJECT="$PATHTOPROJECT" OUTPUTPATH="$OUTPUTPATH" WORKINGDIR="$WORKINGDIR" 

 
