#!/usr/local/bin/python3

import os, uuid, glob, datetime, subprocess

import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication

client_slug = 'client001'

dir_path = os.path.abspath(os.path.dirname(__file__))
inv_dir_path = os.path.join(dir_path, "../gen/invoices", client_slug)

today = datetime.date.today()
dd = '05'
yymmdd = today.strftime('%y%m') + dd
yearmonth = today.strftime('%Y-%m')

targetmonth = (datetime.datetime(today.year, today.month, 1) + datetime.timedelta(days=-1)).strftime("%-m")

idgen8 = str(uuid.uuid4()).split('-')[0]
inv_prefix_pre = "invoice_" + yymmdd
inv_prefix = inv_prefix_pre + "_" + idgen8

inv_xsl_path = os.path.join(dir_path, "../src/xsl", client_slug + ".xsl")
inv_xml_path = os.path.join(inv_dir_path, inv_prefix + ".xml")
inv_ps_path  = os.path.join(inv_dir_path, inv_prefix + ".ps")
inv_pdf_path = os.path.join(inv_dir_path, inv_prefix + ".pdf")

globpathname = os.path.join(inv_dir_path, inv_prefix_pre + "_*.pdf")

email0_sent_log_path = os.path.join(dir_path, "../log/emails", client_slug, yymmdd + "_email0")
email1_sent_log_path = os.path.join(dir_path, "../log/emails", client_slug, yymmdd + "_email1")

def shell(args):
    return subprocess.run(args, capture_output=True, text=True).stdout

def genpdf():
    if len(glob.glob(globpathname)) == 0:
        shell(["xsltproc", "-o", inv_xml_path, "--stringparam", "yearmonth", yearmonth, "--stringparam", "dd", dd, "--stringparam", "idgen8", idgen8, inv_xsl_path, os.path.join(dir_path, "../src/xml/dummy.xml")])
        shell(["xsltproc", "-o", inv_ps_path, os.path.join(dir_path, "../src/xsl/xml_to_ps.xsl"), inv_xml_path])
        shell(["gs", "-sDEVICE=pdfwrite", "-I", os.path.join(dir_path, "../src/gs/"), "-o", inv_pdf_path, inv_ps_path])
        
def email0():
    pdf_path = glob.glob(globpathname).pop()
    pdf_filename = os.path.basename(pdf_path)

    subj = "送信予定請求書"
    body = "次に送信予定の請求書はこちら（添付ファイル）。"

    msg = MIMEMultipart()
    msg['Subject'] = subj
    msg['From'] = "robot@example.com"
    msg['To'] = "me@example.com"
    
    msg.attach(MIMEText(body, 'plain', 'utf-8'))
    
    with open(pdf_path, "rb") as f:
        attachment = MIMEApplication(f.read())
    attachment.add_header("Content-Disposition", "attachment", filename=pdf_filename)
    msg.attach(attachment)
    
    if not os.path.exists(email0_sent_log_path):
        with smtplib.SMTP_SSL('smtp.lolipop.jp', 465, timeout=10) as smtp:
            smtp.login('robot@example.com', 'yourpassword')
            smtp.send_message(msg)
            smtp.quit()
        shell(["touch", email0_sent_log_path])

def email1():
    pdf_path = glob.glob(globpathname).pop()
    pdf_filename = os.path.basename(pdf_path)

    subj = "請求書（%s月分）" % targetmonth
    body = """
○○様

お世話になっております。○○のロボットです。

%s月分の請求書をお送りします（添付PDF）。

よろしくお願い申し上げます。
    """ % targetmonth

    msg = MIMEMultipart()
    msg['Subject'] = subj
    msg['From'] = "robot@example.com"
    msg['To'] = "client@example.com"
    msg['Cc'] = "me@example.com"
    
    msg.attach(MIMEText(body, 'plain', 'utf-8'))
    
    with open(pdf_path, "rb") as f:
        attachment = MIMEApplication(f.read())
    attachment.add_header("Content-Disposition", "attachment", filename=pdf_filename)
    msg.attach(attachment)
    
    if not os.path.exists(email1_sent_log_path):
        with smtplib.SMTP_SSL('smtp.lolipop.jp', 465, timeout=10) as smtp:
            smtp.login('robot@example.com', 'yourpassword')
            smtp.send_message(msg)
            smtp.quit()
        shell(["touch", email1_sent_log_path])


d, h, m = map(int, datetime.datetime.now().strftime('%d-%H-%M').split('-'))

if (d == 1 and h == 1 and (1 <= m <= 9)):
    genpdf()

if (d == 1 and h == 2 and (1 <= m <= 9)):
    email0()

if (d == 5 and h == 2 and (1 <= m <= 9)):
    email1()
