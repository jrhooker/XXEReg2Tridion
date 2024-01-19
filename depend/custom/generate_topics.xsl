<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:deltaxml="http://www.deltaxml.com/ns/well-formed-delta-v1">

  <xsl:import href="filtering-attribute-resolver.xsl"/>

  <xsl:param name="PATHTOPROJECT"/>

  <xsl:param name="WORKINGDIR"/>

  <xsl:variable name="STARTING-DIR" select="concat($WORKINGDIR, $PATHTOPROJECT, '\')"/>

  <xsl:variable name="STARTING-DIR-VAR">
    <xsl:choose>
      <xsl:when test="contains($STARTING-DIR, 'c:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'c:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($STARTING-DIR, 'C:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'C:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($STARTING-DIR, 'd:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'd:'), '\', '/')"/>
      </xsl:when>
      <xsl:when test="contains($STARTING-DIR, 'D:')">
        <xsl:value-of select="translate(substring-after($STARTING-DIR, 'D:'), '\', '/')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="translate($STARTING-DIR, '\', '/')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="registers" select="//*[(contains(@class, ' map/topicref '))]/@href"/>

  <xsl:output method="xml" media-type="text/xml" indent="yes" encoding="UTF-8"
    doctype-public="-//Atmel//DTD DITA Mathml Topic//EN" doctype-system="AtmelTopic.dtd"/>

  <xsl:template match="/">
    <xsl:for-each select="$registers">
      <xsl:message>INPUT: <xsl:value-of select="$STARTING-DIR-VAR"/></xsl:message>
      <xsl:variable name="file" select="document(concat($STARTING-DIR-VAR, .))"/>
      <xsl:result-document href="{.}">
        <xsl:call-template name="filtering-attribute-management"/>
        <xsl:apply-templates select="$file/*[contains(@class, ' topic/topic')]"/>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="reg-name-main">
    <xsl:element name="ph">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
      <xsl:if test="following-sibling::reg-desc">
        <xsl:text> - </xsl:text>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template match="reg-desc">
    <xsl:element name="ph">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="reg-def">
    <xsl:element name="tbody">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field">
    <xsl:element name="row">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-bits | field-name | field-default | field-desc">
    <xsl:element name="entry">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="double">
    <xsl:value-of select="msb"/>:<xsl:value-of select="lsb"/>
  </xsl:template>

  <xsl:template match="single">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="desc-title">
    <xsl:element name="p">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:element name="ph">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum-list">
    <xsl:element name="p">
      <xsl:element name="simpletable">
        <xsl:call-template name="filtering-attribute-management"/>
        <xsl:attribute name="relcolwidth">1* 1* 2*</xsl:attribute>
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum">
    <xsl:element name="strow">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum-value | field-enum-name | field-enum-desc">
    <xsl:element name="stentry">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="field-enum-def">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="address-map">
    <xsl:element name="tbody">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="register-reference">
    <xsl:element name="row">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="address ">
    <xsl:element name="row">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

<!-- Start here -->
  
  <xsl:template
    match="
   reg-address | reg-size | reg-name | reg-details | value | position | dword/name | dword/description
    | include/name | include/description | register-reference/address | addr-element
    | test-row-type | test-owner | test-desc | test-proc | test-exp-rslt">
    <xsl:element name="entry">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="field-type">
    <xsl:element name="entry">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:if test="@sticky">
        <xsl:element name="p">[STICKY:<xsl:value-of select="upper-case(@sticky)"/>]</xsl:element>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="child::p"><xsl:apply-templates/></xsl:when>
        <xsl:otherwise>
          <xsl:element name="p"><xsl:apply-templates/></xsl:element>
        </xsl:otherwise>
      </xsl:choose>            
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="address-details">
    <xsl:element name="entry">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="p | paragraph">
    <xsl:element name="p">
      <xsl:call-template name="filtering-attribute-management"/>           
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="b[child::p]">          
      <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="xref">
    <xsl:element name="xref">
      <xsl:call-template name="filtering-attribute-management"/>           
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="address-prefix">
    <xsl:element name="ph">
      <xsl:call-template name="filtering-attribute-management"/> 
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="addr-mnemonic">
    <xsl:element name="p">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:element name="ph"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template
    match="double/msb | test-matrix-nm-short | test-matrix-nm-long | test-name-short | test-name-long | msg-name-main | title/msg-desc">
    <xsl:element name="ph">
      <xsl:call-template name="filtering-attribute-management"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
 
  <xsl:template match="bookmeta | pmc-requirement"/>
  
  <xsl:template match="node()" mode="wrap">
    <xsl:copy>
      <xsl:call-template name="filtering-attribute-management"/>     
      <xsl:apply-templates select="node()" mode="wrap"/>
    </xsl:copy>
  </xsl:template> 

   
  <xsl:template match="frontmatter">
    <xsl:choose>
      <xsl:when test="@href">
        <xsl:element name="topicref">
          <xsl:call-template name="filtering-attribute-management"/>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="backmatter">
    <xsl:choose>
      <xsl:when test="@href">
        <xsl:element name="topicref">
          <xsl:call-template name="filtering-attribute-management"/>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="instances">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="instance">
    <xsl:element name="p">
      <xsl:element name="b">Instance:</xsl:element>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="instance-start">
    <xsl:value-of select="."/>
    <xsl:text>:</xsl:text>
  </xsl:template>
  
  <xsl:template match="instance-stop">
    <xsl:value-of select="."/>
  </xsl:template>





</xsl:stylesheet>
