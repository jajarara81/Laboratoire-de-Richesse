#!/bin/bash
source /root/Laboratoire-de-Richesse/scripts/venv_paypal/bin/activate
python3 /root/Laboratoire-de-Richesse/scripts/paypal_balance.py > "/root/Laboratoire-de-Richesse/reports/paypal_report_2025-03-07.log"
deactivate
