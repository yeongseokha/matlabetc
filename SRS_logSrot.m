clear all
clc

fName = sprintf('프라임앞10.txt');
fid = fopen(fName);

ob_field = {'doppler_bin_index' 'azimuth' 'elevation' 'RCS' 'x_cm' 'y_cm' 'z_cm'};
tr_field = {'RCS' 'x_cm' 'y_cm' 'z_cm'};

frame_num = 0;

object = [];
track = [];

while 1
    lbuf = fgetl(fid); %date and time
    if lbuf == -1
        break;
    end
    
    frame_num = frame_num +1;
    
    %get time
    time = lbuf(5:length(lbuf));
    
    %get objects
    lbuf = fgetl(fid);
    space = strfind(lbuf, ' ');
    objNum = lbuf(space(1)+1 : space(2));
    
    for i = 1:str2num(objNum)
        %parsing object 1 line
        lbuf = fgetl(fid);
        obbuf.frameNum = frame_num;
        obbuf.time = time;
        
        comma = strfind(lbuf, ',');
        comma = [comma length(lbuf)+1];
        for ii = 1:length(comma)-1
            cbuf = lbuf(comma(ii)+1 : comma(ii+1)-1);
            obbuf.(ob_field{ii}) = str2num(cbuf);
            clear cbuf;
        end
        object = [object; obbuf];
        clear obbuf;
    end
    
    %get tracks
    lbuf = fgetl(fid);
    space = strfind(lbuf, ' ');
    trNum = lbuf(space(1)+1 : space(2));
    
    for i = 1:str2num(trNum)
        %parsing track 1 line
        lbuf = fgetl(fid);
        trbuf.frameNum = frame_num;
        trbuf.time = time;
        
        comma = strfind(lbuf, ',');
        comma = [comma length(lbuf)+1];
        for ii = 1:length(comma)-1
            cbuf = lbuf(comma(ii)+1:comma(ii+1)-1);
            trbuf.(tr_field{ii}) = str2num(cbuf);
            clear cbuf;
        end
        track = [track; trbuf];
        clear trbuf;
    end
    
end
