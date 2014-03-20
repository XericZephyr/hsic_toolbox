%
% Written by: Zheng Xu (xuzheng1111 <at> gmail <dot> com)
% 20-Mar-14 - Initial version.
%

classdef para_set
    %PARA_SET Class for matlab function arguments
    %   Detailed explanation goes here
    
    properties (Access = private)
        value_pack
    end
    
    methods
        
        function val = subsref(obj, ref)
            val = builtin('subsref',obj.value_pack, ref);
        end
        
        function obj = subsasgn(obj, ref, val)
            obj.value_pack = builtin('subsasgn', obj.value_pack, ref, val);
        end
        
        function [] = disp(obj)
            disp('Parameter Set: ');
            disp(obj.value_pack);
        end
        
        function obj = para_set(user_para_set, default_para_set)
            %
            %   para_set class
            %       
            %       Arguments: 
            %
            %           user_para_set:   user specified arguments
            %           default_para_set:default arguement values
            %
            %       Remark:
            %           para_set could be in two formats:
            %               1. {{key1, value1}, {key2, value2} ..}
            %               2. Matlab struct
            %
            %
            obj.value_pack = struct();
            if nargin == 0
                return
            end
            if nargin >= 1
                obj = obj.set_value(user_para_set, true);
            end
            if nargin >= 2
                obj = obj.set_value(default_para_set, false);
            end
            
        end % para_set
        
        function obj = set_value(obj, value_pack, override)
            %
            %   set_value 
            %   
            %   Arguments: 
            %       args: arguments could be with format {{key1, value1}, {key2, 
            %             value2} ... } or in format of struct
            %       override: determine whether the args will override the
            %             orginal value  DEFAULT: true
            %       
            %
            if nargin < 3
                override = true;
            end
            if isa(value_pack, 'struct')
                obj = obj.set_value_by_struct(value_pack, override);
            elseif isa(value_pack, 'cell') 
                obj = obj.set_value_by_args(value_pack, override);
            else 
                error('Unsupported value pack format');
            end
        end % set_value
        
    end
    
    methods (Access=private)
        
        function obj = set_value_by_args(obj, args, override)
            %
            %   set_value_by_args 
            %   
            %   Arguments: 
            %       args: arguments with format {{key1, value1}, {key2, 
            %             value2} ... }
            %       override: determine whether the args will override the
            %             orginal value  DEFAULT: true
            %       
            %
            
            for i = 1:length(args)
                arg = args{i};
                [k, v] = arg{:};
                if override || ~isfield(obj.value_pack, k)
                    obj.value_pack.(k) = v;
                end
            end
        end % set_value_by_args
        
        function obj = set_value_by_struct(obj, value_struct, override)
            %
            %   set_value_by_struct 
            %   
            %   Arguments: 
            %       args: arguments in struct format
            %       override: determine whether the args will override the
            %             orginal value  DEFAULT: true
            %       
            %
            if nargin < 3
                override = true;
            end
            name_list = fieldnames(value_struct);
            for i = 1:length(name_list)
                name = char(name_list(i));
                if override || ~isfield(obj.value_pack, name)
                    obj.value_pack.(name) = value_struct.(name);
                end
            end
        end % set_value_struct
    end
  
end

