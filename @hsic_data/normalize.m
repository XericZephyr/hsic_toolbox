function obj = normalize(obj, method, args)
    if nargin < 2
        method = 'unit_norm';
        args = {};
    end
    switch method
        case 'unit_norm'
            X = obj.labeled_data.data;
            defaults = {{'p', 2}};
            p = para_set(args, defaults);
            rownorm = @(X, p) sum(abs(X).^p, 2).^(1/p);
            obj.labeled_data.data = X./(rownorm(X, p.p) * ones(1, size(X, 2)));
        otherwise
            error('Unspported method');
    end
end