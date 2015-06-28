#!/bin/bash
INSTALLER="atlassian-confluence-5.8.4-x64.bin"


echo "Installing confluence..."
sudo chmod +x /vagrant/$INSTALLER
sudo /vagrant/$INSTALLER -q -varfile /vagrant/response.varfile > /dev/null 2>&1

echo "Configuring firewall..."
sudo firewall-cmd --permanent --zone=public --add-port=8090/tcp > /dev/null 2>&1
sudo firewall-cmd --reload > /dev/null 2>&1

echo "Configuring confluence service..."
sudo /opt/atlassian/confluence/bin/stop-confluence.sh > /dev/null 2>&1
sudo cp /vagrant/confluence.service /usr/lib/systemd/system/ > /dev/null 2>&1
sudo systemctl enable confluence > /dev/null 2>&1

echo "Starting Confluence..."
sudo systemctl start confluence > /dev/null 2>&1

echo "Confluence installation and setup has completed."
echo "Depending on the speed of your workstation, it may take several"
echo "minutes before the application is available for use."
echo "Default website: http://localhost:8090/"
