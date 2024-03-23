function [data]=readin_generic_csv(file,varargin)
    opts = detectImportOptions(file);
    
    if nargin>1
        readin_mat=varargin{1};
    else
        readin_mat=false;
    end

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    % Specify column names and types
    opts.VariableNamesLine=1;
    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    filename = file + ".mat";

    if(readin_mat==true)
        load(filename)
    else
        
        % Import the data
        CAN = readtable(file, opts,'ReadVariableNames',true);
        
        
        try
            dT0=diff(CAN.T0);
            dT1=diff(CAN.T1);
            dT2=diff(CAN.T2);
            dT3=diff(CAN.T3);
            dT4=diff(CAN.T4);
            dT5=diff(CAN.T5);
            dT6=diff(CAN.T6);
            dT7=diff(CAN.T7);
            dT8=diff(CAN.T8);
            dT9=diff(CAN.T9);
        catch
        end
        
        T0=cumsum(dT0);
        T1=cumsum(dT1);
        T8=cumsum(dT8);


        try
            sz=size(CAN);
            CAN(sz(1),:)=[];
            CAN.dT0=dT0;
            CAN.dT1=dT1;
            CAN.dT2=dT2;
            CAN.dT3=dT3;
            CAN.dT4=dT4;
            CAN.dT5=dT5;
            CAN.dT6=dT6;
            CAN.dT7=dT7;
            CAN.dT8=dT8;
            CAN.dT9=dT9;
        catch
        end
        
        try
            CAN.T1T0=T1-T0-min(T1-T0);
            CAN.T2T1=CAN.T2-CAN.T1;
            CAN.T3T2=CAN.T3-CAN.T2;
            CAN.T4T3=CAN.T4-CAN.T3;
            CAN.T5T4=CAN.T5-CAN.T4;
            CAN.T5T1=CAN.T5-CAN.T1;
            CAN.T6T5=CAN.T6-CAN.T5;
            CAN.T7T6=CAN.T7-CAN.T6;
            CAN.T8T7=CAN.T8-CAN.T7;
            CAN.T8T6=CAN.T8-CAN.T6;
        
            CAN.T9T8=CAN.T9-CAN.T8;
        catch
        end
        
        try
            CAN.T10;
        catch
            try
                CAN.T10=CAN.T9;
            catch
                CAN.T10=CAN.T8;
            end
        end
        try
        CAN.T10T9=CAN.T10-CAN.T9;    
        CAN.T10T8=CAN.T10-CAN.T8;
        catch
        end
        data=CAN;

        try
        % rename b{i} to B{i}
        for i = 0:13
            column = "b" + i;
            if ismember(column, data.Properties.VariableNames)
                data = renamevars(data, [column], ["B"+i]);
            end
        end

        catch ex
            msgText = getReport(ex);
        end

        try
        % change byte values to bit
            for i = 0:13
                column = "B" + i;
                if ismember(column, data.Properties.VariableNames)
                    data.(column) = 8 * data.(column);
                end
            end
        catch ex
            msgText = getReport(ex);
        end

        try
            for i = 0:13
                column = "B" + i;
                if ismember(column, data.Properties.VariableNames)
                    if(isempty(data.(column)(~isnan(data.(column)))))
                        data.(column)=data.B0;
                    end
                end
            end
        catch ex
           msgText = getReport(ex);
        end


        data.T0=data.T1-data.T1T0;
        offset=data.B6/(5.24*10^9)*10^9;
        data.TCP_offset=offset+3/(2/3*299*10^6)*10^9;
        data.T6T5=data.T6T5-min(data.T6T5)+data.TCP_offset;
        data.TCP_theoretic=(data.TCP_offset);
        data.T6=data.T5+data.T6T5;
        data.T7=data.T6+data.T7T6;
        data.T8=data.T7+data.T8T7;
        try
        data.T9=data.T8+data.T9T8;
        data.T10=data.T9+data.T10T9;
        catch
        end
        data.dT1dT0=data.dT1-data.dT0;

        data.T8T1=data.T2T1+data.T3T2+data.T4T3+data.T5T4+data.T6T5+data.T7T6+data.T8T7;

        %%%%compensating the pause
        try
        data.T10=data.T10-min(CAN.T10T8);
        data.T10T8=data.T10-data.T8;
        catch
        end

        %filter out
        data=filter_too_long_IPC(data,1);
        data=filter_too_long_IPC(data,3);
        data=filter_too_long_IPC(data,6);
        %% Clear temporary variables
        clear opts

        save(filename)
    end

end