classdef hsic_data < handle
    %
    % Data model for HSI classification
    %
   
    properties
        raw_data  = [];
        raw_label = [];
        labeled_data = [];
    end
    
    % Class methods
    methods 
        
        % Constructor
        function obj = hsic_data(raw_data, raw_label)
            %
            % Construct a hsi_data object through raw h*w*nbs data cube and
            % h*w raw label matrix
            %

            % check validation of raw_data
            if (length(size(raw_data)) == 3)
                obj.raw_data = raw_data;
            else
                error('Invalid hsi raw data');
            end

            % check validation of raw_label
            if (length(size(raw_label)) == 2)
                [h w n] = size(raw_data);
                [h1 w1] = size(raw_label);
                if (h1 == h && w1 == w)
                    obj.raw_label = raw_label;
                end
            end
            if ~obj.raw_label
                error('Invalid input hsi label');
            end
            obj.labeled_data;
        end % hsic_data
        
        
        function labeled_data = get.labeled_data(obj)
            if ~obj.raw_data
                error('HSI data not available');
            end
            if isempty(obj.labeled_data)
                obj = obj.init_labeled_data();
            end
            labeled_data = obj.labeled_data;
        end % get.struct_data
        
        function obj = init_labeled_data(obj)
            %
            %   Initialize or revert labeled data to the original state
            %
            struct_data = obj.struct_raw_data(obj.raw_data, obj.raw_label);
            index = find(struct_data.label~=0);
            obj.labeled_data = struct('data', struct_data.data(index, :), 'label', struct_data.label(index), 'position', struct_data.position(index, :));
        end % init_labeled_data
        
        function obj = disp(obj)
            [h w n] = size(obj.raw_data);
            fprintf('==============HSI Basic Info=================\n');
            fprintf('Height: %d, Width: %d, Bands: %d\n', h, w, n);
            fprintf('Total Pixels: %d, Labeled Pixels: %d\n', h*w, size(obj.labeled_data.data, 1));
            fprintf('==============HSI Class Info=================\n');
            label = obj.labeled_data.label;
            all_classes = unique(label(label ~= 0));
            for class = all_classes(:)'
                index = find(label == class);
                fprintf('Class #%3d:   %8d samples\n', class, length(index));
            end
            fprintf('=============================================\n');
        end
        
        labeled_data = randsample(obj, sample_rate)
        
        obj = normalize(obj, method, args)
        
    end % methods
   
    methods (Static)
        
        function outdataobj = get_data_by_index(indataobj, index)
            data = indataobj.data(index, :);
            label = indataobj.label(index);
            position = indataobj.position(index, :);
            outdataobj = struct('data', data, 'label', label, 'position', position);          
        end % get_data_by_index
        
        function struct_data = struct_raw_data(raw_data, raw_label)
            [h w n] = size(raw_data);
            data = reshape(raw_data, h*w, n);
            label = reshape(raw_label, h*w, 1);
            [position(1,:), position(2, :)] = ind2sub([h w], 1:h*w);
            struct_data = struct('data', data, 'label', label, 'position', position'); 
        end % struct_raw_data
        
    end
   
end % classdef

