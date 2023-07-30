
# autoinvoice

Every month...

1. Generate PDF invoice files (Japanese).
2. Send emails attached the PDF.

...automatically.


## Requirements

- python3
- xsltproc
- gs

## Setup

1. Edit bin/client001.py
2. Edit src/xsl/client001.xsl
3. ( Edit src/xsl/xml_to_ps.xsl )
4. Upload autoinvoice directory to your hosting service (e.g. lolipop)
5. Set bin/client001.py permission **700**
6. Set **cron** for bin/client001.py (e.g. 5 minutes cycle)
