<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date"
    version="1.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="/">
        <xsl:variable name="pub-ja" select="concat(date:year(invoice/@pub), '年', date:month-in-year(invoice/@pub), '月', date:day-in-month(invoice/@pub), '日')"/>
        <xsl:variable name="due-ja" select="concat(date:year(invoice/@due), '年', date:month-in-year(invoice/@due), '月', date:day-in-month(invoice/@due), '日')"/>
        
%!PS-Adobe-3.1 EPSF-3.0
%%BoundingBox: 0 0 595 842

/x1  70 def
/x2 370 def
/x3 420 def
/x4 470 def
/x5 520 def

/y1 680 def

/lh  16 def    % line height
/xo  10 def    % x offset
/yo   5 def    % y offset
/pd   3 def    % padding

/fs1 30 def
/fs2 20 def
/fs3 12 def

/Japanese-Gothic-UniJIS-UTF8-H findfont fs1 scalefont setfont
x1 y1 yo add moveto (請求書) show

/Japanese-Gothic-UniJIS-UTF8-H findfont fs2 scalefont setfont
x1 y1 lh 4 mul sub moveto (<xsl:value-of select="invoice/client/name"/> 御中) show

/Japanese-Gothic-UniJIS-UTF8-H findfont fs3 scalefont setfont
x1 y1 lh  1 mul sub moveto (<xsl:value-of select="$pub-ja"/>) show
x1 y1 lh  2 mul sub moveto (ID: <xsl:value-of select="invoice/@uid"/>) show
x1 y1 lh  6 mul sub moveto (下記のとおりご請求申し上げます。) show
x1 y1 lh  8 mul sub moveto (ご請求金額 ¥<xsl:value-of select="format-number(invoice/lines/@total, '#,###')"/> -) show
x1 y1 lh  9 mul sub moveto (お支払い期限 <xsl:value-of select="$due-ja"/>) show
x1 y1 lh 11 mul sub moveto (<xsl:value-of select="invoice/sender/name"/>) show
x1 y1 lh 12 mul sub moveto (〒<xsl:value-of select="invoice/sender/zip-code"/>) show
x1 y1 lh 13 mul sub moveto (<xsl:value-of select="invoice/sender/address"/>) show
x1 y1 lh 14 mul sub moveto (TEL: <xsl:value-of select="invoice/sender/phone"/>) show
x1 y1 lh 22 mul sub moveto (お振込先:) show
x1 y1 lh 23 mul sub moveto (<xsl:value-of select="invoice/bank/name"/><xsl:text>&#32;</xsl:text><xsl:value-of select="invoice/bank/branch-name"/><xsl:text>&#32;</xsl:text>(<xsl:value-of select="invoice/bank/type"/>)<xsl:text>&#32;</xsl:text><xsl:value-of select="invoice/bank/account-number"/><xsl:text>&#32;</xsl:text><xsl:value-of select="invoice/bank/account-name"/>) show

1 setlinewidth
x1 y1 lh  8 mul sub -2 add moveto 192 y1 lh  8 mul sub -2 add lineto stroke

0 setlinewidth
/ty y1 lh 15 mul sub def
x1 ty moveto x5 ty lineto stroke

x1 ty moveto x1 ty lh 5 mul sub lineto stroke
x2 ty moveto x2 ty lh 5 mul sub lineto stroke
x3 ty moveto x3 ty lh 2 mul sub lineto stroke
x4 ty moveto x4 ty lh 5 mul sub lineto stroke
x5 ty moveto x5 ty lh 5 mul sub lineto stroke

/ty y1 lh 16 mul sub def
x1 ty moveto x5 ty lineto stroke
x1 pd add ty pd add moveto (内容) show
x2 pd add ty pd add moveto (数量) show
x3 pd add ty pd add moveto (単価) show
x4 pd add ty pd add moveto (金額) show

/ty y1 lh 17 mul sub def
x1 ty moveto x5 ty lineto stroke
x1 pd add ty pd add moveto (<xsl:value-of select="invoice/lines/line"/>) show
x2 pd add ty pd add moveto (<xsl:value-of select="invoice/lines/line/@qty"/>) show
x3 pd add ty pd add moveto (<xsl:value-of select="format-number(invoice/lines/line/@unit-price, '#,###')"/>) show
x4 pd add ty pd add moveto (<xsl:value-of select="format-number(invoice/lines/line/@unit-price, '#,###')"/>) show <!-- TODO: -->

/ty y1 lh 18 mul sub def
x2 ty moveto x5 ty lineto stroke
x2 pd add ty pd add moveto (小計) show
x4 pd add ty pd add moveto (<xsl:value-of select="format-number(invoice/lines/@sub-total, '#,###')"/>) show

/ty y1 lh 19 mul sub def
x2 ty moveto x5 ty lineto stroke
x2 pd add ty pd add moveto (消費税（<xsl:value-of select="invoice/lines/@tax-rate"/>%）) show
x4 pd add fs3 2 div add ty pd add moveto (<xsl:value-of select="format-number(invoice/lines/@tax, '#,###')"/>) show

/ty y1 lh 20 mul sub def
x1 ty moveto x5 ty lineto stroke
x2 pd add ty pd add moveto (合計) show
x4 pd add ty pd add moveto (<xsl:value-of select="format-number(invoice/lines/@total, '#,###')"/>) show
    </xsl:template>
    
</xsl:stylesheet>