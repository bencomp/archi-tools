<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions"
xmlns:archimate="http://www.archimatetool.com/archimate"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  version="2.0">
  <xsl:output encoding="UTF-8"/>


  <xsl:template match="/archimate:model">
    <xsl:element name="html">
        <xsl:element name="head">
            <xsl:element name="title">Glossary of information objects in <xsl:value-of select="@name" /></xsl:element>
        </xsl:element>
        <xsl:element name="body">
            <xsl:element name="h1">Glossary of information objects in <xsl:value-of select="@name" /></xsl:element>
    
            <xsl:apply-templates select=".//element[@xsi:type='archimate:BusinessObject']">
                <xsl:sort select="@name" />
            </xsl:apply-templates>
        </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match="element">
    <xsl:element name="h2"><xsl:value-of select="@name" /></xsl:element>
    
    <xsl:apply-templates select="documentation" />
  </xsl:template>
  
  <xsl:template match="documentation">
    <xsl:element name="p"><xsl:value-of select="." /></xsl:element>
  </xsl:template>
</xsl:stylesheet>
