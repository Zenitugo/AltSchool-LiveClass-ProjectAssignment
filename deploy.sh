#!/bin/bash

cluster='Vagrantfile'

lamp='machines.sh'



if [ -e $cluster ]
then
	echo "Starting 'Slave' VM..."
        vagrant up slave
	bash $lamp


         echo "Starting 'Master' VM..."
         vagrant up master
	 bash $lamp
	 vagrant ssh master
else
	 echo "File not present"
fi

echo "Deployment complete!"

