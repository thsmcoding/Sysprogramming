#!/bin/bash
#defining alias for rm command
#defining global variables
GLOBALSOURCE=0


pycharm() {
echo "Launching IDE Pycharm..."
currentDate=$(date '+%Y-%m-%d_%H:%M:%S')
CURRENTFILE=~/Pycharm_logs/logging"$currentDate".log
echo "Log file will be stored here : " "$CURRENTFILE"
sh /snap/pycharm-community/169/bin/pycharm.sh > "$CURRENTFILE" 2>& 1 & 
echo "Pycharm launching done..."
}

copysafe() {
SOURCE=$GLOBALSOURCE
echo "Starting copying file in argument"
echo "The file " "$SOURCE" " will be saved"
currentDate=$(date '+%Y-%m-%d')
echo today\'s date: "$currentDate"
DIRECTORY=~/.deleted/$currentDate/
if [ ! -d "$DIRECTORY"  ]
then 
	echo "the directory does not exist. Creating it...."	
	mkdir ~/.deleted/$currentDate
fi
DESTINATION=/home/htsme/.deleted/"$currentDate"/"$SOURCE"
cp -R "$SOURCE" "$DESTINATION"
echo ">>> File saved before deletion"
}


rmsafe () {
	NAMEFILE=$1
	echo "$NAMEFILE" "HERE"
	GLOBALSOURCE="$NAMEFILE"
	echo "$GLOBALSOURCE"
	copysafe $GLOBALSOURCE
	echo "You are about to do something dangerous"
	ISDIR=false	
	MESSAGE="Are you sure to erase "
	MARK="?"
	WHOLE=$MESSAGE$NAMEFILE$MARK	
	if [ -d "$NAMEFILE" ]
	then isDirectory =true; echo "You are trying to delete DIRECTORY :""$NAMEFILE"
	else
		echo "You want to delete FILE:""$NAMEFILE"
	fi	
	echo "$WHOLE"
	read -p "Please choose yes or no: " -n 1 -r
	echo 	
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	 if [ $ISDIR = true ]
	 then 
	   echo "Deleting the directory and its content"
	   rmdir -r "$NAMEFILE"
           echo "Directory ""$NAMEFILE"" has been deleted now"
	 else 
           echo "Deleting the file..."
	   rm "$NAMEFILE"
           echo "File ""$NAMEFILE"" has been deleted now"
	 fi		
	else
	   echo "Deletion cancelled"
	fi
}


gitrm(){
echo "Starting to recursively apply write permissions to git files"
if [ -z "${1}" ]
	then echo "Missing directory name as input"
else 
	chmod -R +w "${1}"/.git 
	echo "Deleting local git repository"
	rm -r "${1}"
	echo "gitrm task done"
fi
}









