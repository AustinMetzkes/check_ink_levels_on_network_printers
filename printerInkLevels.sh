#!/bin/sh

#script to measure the ink in our printer that are 
#on our network. We ran it with a cronjob that ran
#every 12 hours and would send us an email with the
#printers that were below the given percentage of ink.
#We uased canon printers.



#everything snmpwalk -v1 -c public 192.168.0.1 1.3.6.1.2.1.43.11.1.1


check_ink_levels()
{
	echo ink levels for $1:
	echo ------------------
black=$(snmpwalk -v1 -c public $1 1.3.6.1.2.1.43.11.1.1.9.1.1 | awk '{print $4}')
echo "Black ink level is at $black%"
cyan=$(snmpwalk -v1 -c public $1 1.3.6.1.2.1.43.11.1.1.9.1.2 | awk '{print $4}')
echo "Cyan ink level is at $cyan%" 
magenta=$(snmpwalk -v1 -c public $1 1.3.6.1.2.1.43.11.1.1.9.1.3 | awk '{print $4}')
echo "Magenta ink level is at $magenta%" 
yellow=$(snmpwalk -v1 -c public $1 1.3.6.1.2.1.43.11.1.1.9.1.4 | awk '{print $4}')
echo "Yellow ink level is at $yellow%" 
echo ------------------

if [ $black -lt 15 ] || [ $cyan -lt 15 ] || [ $magenta -lt 15 ] || [ $yellow -lt 15 ]
then
#configure your server to log in to your email provider to specify what email it comes from.
	echo -e "Subject: Black ink is low at $1 \n\n The black toner is low at $black%\n" | mail reciever1@gmail.com,reciever2@gmail.com
# may need to replace 'mail' with 'sendmail -f "Printer" -r "sender@gmail.com (Printer)"'
fi


} 

#enter either your printers domain on the network or the ip addres for each printer you want measure.
check_ink_levels printer.domain
check_ink_levels printer IP
check_ink_levels 10.10.8.3 



#grab strings 1.3.6.1.2.1.43.11.1.1.6

#black ink string 1.3.6.1.2.1.43.11.1.1.6.1.1
#cyan ink string 1.3.6.1.2.1.43.11.1.1.6.1.2
#magenta ink string 1.3.6.1.2.1.43.11.1.1.6.1.3
#yellow ink string 1.3.6.1.2.1.43.11.1.1.6.1.4

#grab levels 1.3.6.1.2.1.43.11.1.1.9

#black ink levels 1.3.6.1.2.1.43.11.1.1.9.1.1
#cyan ink levels 1.3.6.1.2.1.43.11.1.1.9.1.2
#magenta ink levels 1.3.6.1.2.1.43.11.1.1.9.1.3
#yellow ink levels 1.3.6.1.2.1.43.11.1.1.9.1.4

