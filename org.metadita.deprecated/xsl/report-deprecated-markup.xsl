<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
                exclude-result-prefixes="dita-ot ditamsg">

  <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl" />
  <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl" />

  <xsl:param name="report.only.fixable" select="'false'"/>
  <xsl:variable name="msgprefix" select="''"/>

  <xsl:output method="xml" encoding="UTF-8" byte-order-mark="yes"/>

  <xsl:template match="/">
    <xsl:if test="count(//*[@navtitle]) gt 0">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP001I'"/>
        <xsl:with-param name="msgparams">%1=<xsl:value-of select="count(//*[@navtitle])"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$report.only.fixable != 'true'">
      <!-- If it has xtrc or xtrf, it came from the source doc, not generated during preprocess -->
      <xsl:if test="count(//*[contains(@class,' map/topicmeta ')][@xtrc or @xtrf]/linktext) gt 0">
        <xsl:call-template name="output-message">
          <xsl:with-param name="id" select="'DEP016I'"/>
          <xsl:with-param name="msgparams">%1=<xsl:value-of select="count(//*[contains(@class,' map/topicmeta ')]/linktext[@xtrc or @xtrf])"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="count(//*[@copy-to]) gt 0">
        <xsl:call-template name="output-message">
          <xsl:with-param name="id" select="'DEP017W'"/>
          <xsl:with-param name="msgparams">%1=<xsl:value-of select="count(//*[@copy-to])"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*[contains(@class, 'hazard-d/hazardstatement ')]">
    <xsl:choose>
      <xsl:when test="not(@type)">
        <xsl:call-template name="output-message">
          <xsl:with-param name="id" select="'DEP028I'"/>
          <xsl:with-param name="msgparams"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="@type != 'caution' and @type != 'danger' and @type != 'notice' and @type != 'warning'">
        <xsl:call-template name="output-message">
          <xsl:with-param name="id" select="'DEP029I'"/>
          <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="$report.only.fixable != 'true'">
      <xsl:if test=".//*[contains(@class,' hazard-d/hazardsymbol ')]">
        <xsl:call-template name="output-message">
          <xsl:with-param name="id" select="'DEP030I'"/>
          <xsl:with-param name="msgparams"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
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

  <xsl:template match="*[contains(@class,' topic/titlealts ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP021I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <!-- Warn about itemgroup, but not about the existing task specializations
    that will not require migration -->
  <xsl:template match="*[contains(@class,' topic/itemgroup ')]
    [not(self::tutorialinfo or self::info or self::stepxmp or self::stepxmp or self::stepresult)]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP032I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/sectiondiv ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP041I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/audience ')][@otherjob or @othertype]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP033I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/boolean ') or
    contains(@class,' topic/indextermref ') or
    contains(@class,' topic/data-about ') or
    contains(@class,' topic/longquoteref ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP003I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/state ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP018I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/unknown ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP019I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="index-sort-as">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP020I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/index-base ')][not(self::index-see or self::index-see-also or self::index-sort-as)]">
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
  <xsl:template match="*[@locktitle|@lockmeta]" priority="5">
    <xsl:if test="@locktitle">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP025I'"/>
        <xsl:with-param name="msgparams"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="@lockmeta">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP031I'"/>
        <xsl:with-param name="msgparams"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="topicset | topicsetref">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP022I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' classify-d/')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP023I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' delay-d/')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP026I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' xnal-d/')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP034I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' task/substeps ')]">
    <xsl:if test="$report.only.fixable != 'true'">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP027I'"/>
        <xsl:with-param name="msgparams"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[@chunk]">
    <xsl:choose>
      <xsl:when test="contains(@chunk,'to-navigation')">
        <xsl:call-template name="output-message">
          <xsl:with-param name="id" select="'DEP013I'"/>
          <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$report.only.fixable = 'true'">
        <!-- Do not report, cannot change until after migration -->
      </xsl:when>
      <xsl:when test="@chunk = 'split' or @chunk = 'combine'">
        <!-- No message, already migrated -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="output-message">
          <xsl:with-param name="id" select="'DEP015I'"/>
          <xsl:with-param name="msgparams">%1=<xsl:value-of select="@chunk"/></xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[@print or @query]">
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
  <xsl:template match="*[contains(@class,' map/reltable ')][@title]" priority="5">
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

  <xsl:template match="*[contains(@class,' topic/object ')]/
    @*[name() = 'archive' or name() = 'archivekeyrefs' or
    name() = 'classid' or name() = 'classidkeyref' or
       name() = 'codebase' or name() = 'codebasekeyref' or
       name() = 'declare' or name() = 'standby']">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP035I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <!-- linkpool or linklist -->
  <xsl:template match="*[@collection-type='tree']">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP004I'"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' topic/note ')]" priority="5">
    <xsl:if test="@type='fastpath'">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP024I'"/>
        <xsl:with-param name="msgparams"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' subjectScheme/subjectRelTable ')]" priority="5">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP036I'"/>
      <xsl:with-param name="msgparams"/>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' subjectScheme/has') or contains(@class,' subjectScheme/relatedSubjects ') or
    contains(@class,' subjectScheme/subjectRel ') or contains(@class,' subjectScheme/subjectRole ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP037I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="@specentry|@spectitle">
    <xsl:for-each select="parent::*">
     <xsl:call-template name="output-message">
       <xsl:with-param name="id" select="'DEP038I'"/>
       <xsl:with-param name="msgparams"/>
     </xsl:call-template>
    </xsl:for-each>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="@anchorref">
    <xsl:for-each select="parent::*">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP039I'"/>
        <xsl:with-param name="msgparams"/>
      </xsl:call-template>
    </xsl:for-each>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="@mapkeyref">
    <xsl:for-each select="parent::*">
      <xsl:call-template name="output-message">
        <xsl:with-param name="id" select="'DEP042I'"/>
        <xsl:with-param name="msgparams"/>
      </xsl:call-template>
    </xsl:for-each>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class,' map/anchor ') or contains(@class,' mapgroup-d/anchorref ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP040I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' glossentry/glossAbbreviation ') or
    contains(@class, ' glossentry/glossAlternateFor ') or
    contains(@class, ' glossentry/glossPartOfSpeech ') or
    contains(@class, ' glossentry/glossProperty ') or
    contains(@class, ' glossentry/glossScopeNote ') or
    contains(@class, ' glossentry/glossShortForm ') or
    contains(@class, ' glossentry/glossStatus ')]">
    <xsl:call-template name="output-message">
      <xsl:with-param name="id" select="'DEP043I'"/>
      <xsl:with-param name="msgparams">%1=<xsl:value-of select="name()"/></xsl:with-param>
    </xsl:call-template>
    <xsl:next-match/>
  </xsl:template>

  <xsl:template match="@*|*|comment()|processing-instruction()|text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|comment()|processing-instruction()|text()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
