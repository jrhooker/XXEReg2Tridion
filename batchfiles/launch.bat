set PATHTOPROJECT=\Source
set OUTPUTPATH=\out
set FILENAME=titan_regs.ditamap
set DITAMAPNAME=titan_regs.ditamap

cd ..\

set WORKINGDIR=%CD%

cd %WORKINGDIR%\batchfiles

rd /s /q %WORKINGDIR%\out\

mkdir %WORKINGDIR%\out\

rd /s /q %WORKINGDIR%\in\

mkdir %WORKINGDIR%\in\

#xcopy %WORKINGDIR%\%PATHTOPROJECT% %WORKINGDIR%\out\ /S /Y


java -cp %WORKINGDIR%/depend/tools/saxon9/saxon9he.jar;%WORKINGDIR%\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:%WORKINGDIR%%OUTPUTPATH%\test.xml ^
-s:%WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% ^
-xsl:%WORKINGDIR%\depend\custom\generate_ditamap.xsl ^
DITAMAPNAME="%DITAMAPNAME%" PATHTOPROJECT="%PATHTOPROJECT%" OUTPUTPATH="%OUTPUTPATH%" WORKINGDIR="%WORKINGDIR%" 
  
  
java -cp %WORKINGDIR%/depend/tools/saxon9/saxon9he.jar;%WORKINGDIR%\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:%WORKINGDIR%%OUTPUTPATH%\test.xml ^
-s:%WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% ^
-xsl:%WORKINGDIR%\depend\custom\generate_topics.xsl ^
PATHTOPROJECT="%PATHTOPROJECT%" OUTPUTPATH="%OUTPUTPATH%" WORKINGDIR="%WORKINGDIR%" 

 