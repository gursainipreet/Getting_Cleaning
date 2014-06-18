#Quiz1
#install curl before starting sudo apt-get install curl


urlQ5<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
urlQ1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(urlQ1,destfile="/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/Q1.csv",method ="curl")

urlQ1pdf<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(urlQ1pdf,destfile="/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/Q1pdf.pdf",method ="curl")

> file<-"Q1.csv"
> fileQ1<-read.csv(file)

urlQ4<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(urlQ4,destfile="/media/g/Work/Study/Getting_Cleaning_Data/Get_Clean_Data.git/Q4.xml",method ="curl")