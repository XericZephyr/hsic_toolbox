function [sample_data, sample_vector] = randsample(obj, sample_rate)
    %
    %   A class-wise randsample function for hsic_data class
    %   sample_rate should be in range [0, 1]
    %
    labeled_data = obj.labeled_data;
    if ~obj.raw_data
        return
    end
    label = labeled_data.label;
    all_classes = unique(label(label ~= 0));
    sample_vector = [];
    for class = all_classes(:)'
        index = find(label == class);
        n = size(index, 1);
        k = ceil(n*sample_rate);
        sample_index = randsample(n, k);
        sample_vector = [sample_vector; index(sample_index)];
    end
    sample_data = obj.get_data_by_index(labeled_data, sample_vector);
end % randsample