<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:db="http://docbook.org/ns/docbook" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:svg="http://www.w3.org/2000/svg" xmlns:mml="http://www.w3.org/1998/Math/MathML"
    xmlns:dbx="http://sourceforge.net/projects/docbook/defguide/schema/extra-markup"
    xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
    xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:deltaxml="http://www.deltaxml.com/ns/well-formed-delta-v1"
    exclude-result-prefixes="xsl db xlink svg mml dbx xi html">

    <xsl:import href="filtering-attribute-resolver.xsl"/>
        
    <xsl:param name="DITAMAPNAME"/>
   
    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>

    <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
        doctype-public="-//Atmel//DTD DITA Map//EN" doctype-system="map.dtd"/>

    <xsl:template match="/">       
        <xsl:result-document href="{$DITAMAPNAME}">
            <xsl:element name="map">               
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="bookmeta | frontmatter"/>

    <xsl:template match="bookmap | map">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:copy>
            <xsl:call-template name="filtering-attribute-management"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="title">
        <xsl:element name="title">
            <xsl:call-template name="filtering-attribute-management"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="chapter | appendix | topicref">
        <xsl:choose>
            <xsl:when test="@href">
                <xsl:element name="topicref">
                    <xsl:call-template name="filtering-attribute-management"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="topichead">
                    <xsl:call-template name="filtering-attribute-management"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>       
    </xsl:template>
   
</xsl:stylesheet>
