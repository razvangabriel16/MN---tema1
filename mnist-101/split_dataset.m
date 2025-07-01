function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  % X -> the loaded dataset with all training examples
  % y -> the corresponding labels
  % percent -> fraction of training examples to be put in training dataset

  % X_[train|test] -> the datasets for training and test respectively
  % y_[train|test] -> the corresponding labels

  % Example: [X, y] has 1000 training examples with labels and percent = 0.85
  %           -> X_train will have 850 examples
  %           -> X_test will have the other 150 examples

  % TODO: split_dataset implementation
  [l1,c1] = size(X);
  [l2,c2] = size(y);
  fr1 = zeros(1,l1);
  fr2 = zeros(1,l1);
  size1 = l1 * percent;
  X_train = zeros(1, c1);
  X_test = zeros(1,c1);
  y_train = zeros(1,c2);
  y_test = zeros(1,c2);
  if (size1 - floor(size1)) ~= 0
    return;
  endif
  cnt = 0;
  while cnt ~=  size1
    pos = randi(l1);
    fr2(pos) = fr2(pos) + 1;
    if fr1(pos) == 0
      X_train = [X_train; X(pos, :)];
      y_train = [y_train; y(pos, :)];
      cnt = cnt + 1;
      fr1(pos) = 1;
    end;
  endwhile
  %for i = 1:l1
  %  if fr1(i) == 0
  %    X_test = [X_test; X(i, :)];
  %    y_test = [y_test; y(i, :)];
  %  endif
  %endfor
  %mask = (fr1 == 0);
  X_test = [X_test; X(fr1 == 0, :)];
  y_test = [y_test; y(fr1 == 0, :)];
  X_train(1,:)=[];
  y_train(1,:)=[];
  X_test(1,:) = [];
  y_test(1,:) = [];
end
