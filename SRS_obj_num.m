clear all
clc

fName = sprintf('cs15-1.txt');
fid = fopen(fName);

sfstr = '>>>';
obstr = 'object(s)';
trstr = 'track(s)';

objflag = 0;
trflag = 0;
frame_num = 0;
obj_num = 0;
tr_num = 0;

buf = {};
cnt = 1;

while 1
    lbuf = fgetl(fid); %date and time
    if lbuf == -1
        break;
    end
    
    ind = 1;
    
    %get space position
    comma = strfind(lbuf, ' ');
    comma = [comma length(lbuf)+1];
    preC = 0;
    
    
    %split one line by space
    for i = 1:length(comma)
        cbuf{i} = lbuf(preC+1:comma(i)-1);
        preC = comma(i);
    end 
        
    if strcmp(cbuf{1}, obstr)
      frame_num = frame_num+ 1;
      obj_num = obj_num + str2num(cbuf{2});
      objflag = 1;
    end
    
    if strcmp(cbuf{1}, trstr)
        tr_num = tr_num+ str2num(cbuf{2});
        trflag = 1;
    end
        
    
    %for ii = 1:length(cbuf)
    %    if length(cbuf) > 1
    %        cbuf{ii} = str2double(cbuf{ii});
    %    end
    %    buf{cnt, ii} = cbuf{ii};
    %end
    
    
    clear cbuf;
    cnt = cnt+1;
end

result = [frame_num; obj_num; tr_num];
