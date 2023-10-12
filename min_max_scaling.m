for i=1:12
    F=feature1(:,i);
    min_val = min(F);
    max_val = max(F);
    scaled_feature(:,i) = (F - min_val) / (max_val - min_val);
end