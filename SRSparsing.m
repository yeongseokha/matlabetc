clear all
clc

fName = sprintf('tess.txt');
fid = fopen(fName);

sfstr = '>>>';
obstr = 'object(s)';
trstr = 'track(s)';

obflag = 0;
trflag = 0;
buf = {};
cnt = 1;

while 1
    lbuf = fgetl(fid); %date and time
    if lbuf == -1
        break;
    end
    
    ind = 1;
    comma = strfind(lbuf, ',');
    comma = [comma length(lbuf)+1];
    preC = 0;
    
    for i = 1:length(comma)
        cbuf{i} = lbuf(preC+1:comma(i)-1);
        preC = comma(i);
    end 
        
    
    for ii = 1:length(cbuf)
        if length(cbuf) > 1
            cbuf{ii} = str2double(cbuf{ii});
        end
        buf{cnt, ii} = cbuf{ii};
    end
    
    
    clear cbuf;
    cnt = cnt+1;
end
