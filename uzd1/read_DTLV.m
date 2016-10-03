function [data] = read_DTLV(file_name)

file = load(file_name);

year=floor(file(:,1)/10000);
month=floor((file(:,1)-year*10000)/100);
day=floor(file(:,1)-year*10000-month*100);
hour=floor(file(:,2)/10000);
min=floor((file(:,2)-hour*10000)/100);
second=floor(file(:,2)-hour*10000-min*100);

data.date = datenum(year,month,day,hour,min,second)';
data.last = file(:,3)';
data.volume = file(:,4)';