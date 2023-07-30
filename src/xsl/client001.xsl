<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date"
    version="1.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="yearmonth"/><!-- 2023-07 -->
    <xsl:param name="dd"/><!-- 05 -->
    <xsl:param name="idgen8"/><!-- d02984f2 -->
    
    <xsl:template match="/">
        
        <xsl:variable name="yymmdd" select="concat(substring($yearmonth, 3, 2), substring($yearmonth, 6, 2), $dd)"/><!-- 230705 -->
        <xsl:variable name="uid" select="concat($yymmdd, '-', $idgen8)"/><!-- 230705-d02984f2 -->
        <xsl:variable name="pub" select="concat($yearmonth, '-', $dd)"/><!-- 2023-07-05 -->
        <xsl:variable name="due" select="date:add(date:add(date:date(concat($yearmonth, '-01')), 'P1M'), '-P1D')"/><!-- 2023-07-31 -->
        
        <xsl:variable name="target-date-first" select="date:add(date:date(concat($yearmonth, '-01')), '-P1M')"/><!-- 2023-06-01 -->
        <xsl:variable name="target-date-last" select="date:add(date:date(concat($yearmonth, '-01')), '-P1D')"/><!-- 2023-06-30 -->
        
        <xsl:variable name="target-date-year-ja" select="concat(date:year($target-date-first), '年')"/> <!-- 2023年 -->
        <xsl:variable name="target-date-first-ja" select="concat(date:month-in-year($target-date-first), '月1日')"/><!-- 6月1日 -->
        <xsl:variable name="target-date-last-ja" select="concat(date:month-in-year($target-date-last), '月', date:day-in-month($target-date-last), '日')"/> <!-- 6月30日 -->
        <xsl:variable name="target" select="concat('期間', $target-date-year-ja, $target-date-first-ja, '〜', $target-date-last-ja)"/> <!-- 期間2023年6月1日〜6月30日 -->
        
        <invoice uid="{$uid}" pub="{$pub}" due="{$due}">
            <client>
                <name>株式会社○○</name>
            </client>
            <bank>
                <name>○○銀行</name>
                <branch-name>○○支店</branch-name>
                <type>普通</type>
                <account-number>1234567</account-number>
                <account-name>○○　○○</account-name>
            </bank>
            <sender>
                <name>○○　○○</name>
                <zip-code>000-0000</zip-code>
                <address>○○ 1-2-3</address>
                <phone>090-0000-0000</phone>
            </sender>
            <lines total="99000" sub-total="90000" tax="9000" tax-rate="10">
                <line unit-price="90000" qty="1">○○費用(<xsl:value-of select="$target"/>)</line>
            </lines>
        </invoice>
        
    </xsl:template>
    
</xsl:stylesheet>