<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
                exclude-result-prefixes="dita-ot ditamsg">

  <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl" /> 
  <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl" /> 
  
  <xsl:variable name="msgprefix" select="''"/>

  <xsl:output method="xml" encoding="UTF-8" byte-order-mark="yes"/>

  <xsl:template match="/">
    <xsl:if test="count(//*[@navtitle]) gt 0">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP001I'"/>
        <xsl:with-param name="msgparams">%1=<xsl:value-of select="count(//*[@navtitle])"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:apply-templates/>
    
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' topic/image ')]">
    <xsl:if test="@alt">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP002I'"/>
        <xsl:with-param name="msgparams">%1=alt;%2=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="@longdescref">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP002I'"/>
        <xsl:with-param name="msgparams">%1=longdescref;%2=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' topic/boolean ') or contains(@class,' topic/indextermref ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP003I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' map/reltable ') or contains(@class,' map/relcolspec ')]" priority="5">
    <xsl:if test="@collection-type">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP005I'"/>
        <xsl:with-param name="msgparams">%1=collection-type;%2=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>
  <xsl:template match="*[contains(@class,' mapgroup-d/topichead ') or contains(@class,' mapgroup-d/topicgroup ')]" priority="5">
    <xsl:if test="@locktitle">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP005I'"/>
        <xsl:with-param name="msgparams">%1=locktitle;%2=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="*[@print or @query or contains(@chunk,'to-navigation')]">
    <xsl:if test="@print">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP007I'"/>
        <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="@query">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP008I'"/>
        <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="contains(@chunk,'to-navigation')">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP013I'"/>
        <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' map/navref ')][@keyref]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP006I'"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>
  <xsl:template match="*[contains(@class,' map/map ')][@title]" priority="5">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP011I'"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' topic/simpletable ')]">
    <xsl:if test="@refcols">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP009I'"/>
        <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="*[@role='sample' or @role='external']" priority="5">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP010I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="@role"/>;%2=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' topic/lq ')]" priority="5">
    <xsl:if test="@type='internal' or @type='external'">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP012I'"/>
        <xsl:with-param name="msgparams">%1=<xsl:value-of select="@type"/>;%2=<xsl:value-of select="name()"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>
 
  <!-- linkpool or linklist -->
  <xsl:template match="*[@collection-type='tree']">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP004I'"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="@*|*|comment()|processing-instruction()|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|comment()|processing-instruction()|text()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
