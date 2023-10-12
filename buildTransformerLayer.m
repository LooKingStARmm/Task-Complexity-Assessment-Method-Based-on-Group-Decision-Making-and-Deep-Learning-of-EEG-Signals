% 构建一个简化的Transformer层
function transformerLayer = buildTransformerLayer(model_size, num_heads, feed_forward_size)
    self_attention = attentionLayer('SelfAttention', num_heads, ...
        'NumInputPorts', 1, 'ModelSize', model_size);
    
    feed_forward = [
        fullyConnectedLayer(feed_forward_size, 'Name', 'ff1')
        reluLayer('Name', 'relu')
        fullyConnectedLayer(model_size, 'Name', 'ff2')
    ];
    
    transformerLayer = [
        self_attention
        layerNormalizationLayer('Name', 'ln1')
        feed_forward
        layerNormalizationLayer('Name', 'ln2')
    ];
end

% 构建Transformer模型
input_size = size(train_features, 2);
input_layer = imageInputLayer([input_size 1 1], 'Name', 'input');
sequence_input_layer = sequenceInputLayer(input_size, 'Name', 'sequence_input');

transformer_layers = [];
for i = 1:num_layers
    transformer_layers = [transformer_layers; buildTransformerLayer(model_size, num_heads, feed_forward_size)];
end
