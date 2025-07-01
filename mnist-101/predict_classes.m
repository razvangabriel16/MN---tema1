function [classes] = predict_classes(X, weights, ...
                  input_layer_size, hidden_layer_size, ...
                  output_layer_size)
  % X -> the test examples for which the classes must be predicted
  % weights -> the trained weights (after optimization)
  % [input|hidden|output]_layer_size -> the sizes of the three layers

  % classes -> a vector with labels from 1 to 10 corresponding to
  %            the test examples given as parameter

  % TODO: predict_classes implementation
  sz1 = (input_layer_size + 1) * hidden_layer_size;
  sz2 = (hidden_layer_size + 1) * output_layer_size;
  Buf1 = weights(1:sz1);
  Buf2 = weights(sz1 + 1:sz1 + sz2);
  Theta1 = reshape(Buf1, hidden_layer_size, input_layer_size + 1);
  Theta2 = reshape(Buf2, output_layer_size, hidden_layer_size + 1);
  [dataset_lines, dataset_col] = size(X);
  classes = zeros(dataset_lines, 1);
  for i = 1:dataset_lines
    pixels = X(i, :)';
    a1 = [1; pixels];
    z2 = Theta1 * a1;
    a2 = sigmoid(z2);
    a2_b = [1; a2];
    z3 = Theta2 * a2_b;
    a3 = sigmoid(z3);
    h_teta = a3;
    maxi = h_teta(1);
    [~, maxid] = max(a3);
    classes(i) = maxid;
  end
end
