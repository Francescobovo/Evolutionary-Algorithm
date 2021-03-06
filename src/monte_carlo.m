function [aopt, fopt] = montecarlo(eval_budget)

    addpath(genpath('/Users/francesco/Documents/Octave/source/matpower')); % use all subdirectories(including matpower)
    load('para119.mat') % load the dataset
    upper_b = para.ub; % take the upper bound and test whether the base topology is valid
    lower_b = para.lb; % take the lower bound and test whether the base topology is valid
    size = para.n;
    vector = zeros(size, 1);
    ftn = zeros(eval_budget,1);
    minim_ftn = 99999999999;

    % create valid individual
    parfor i = 1:eval_budget
      flag = 0;
      while flag == 0 
        parfor j = 1:size % create an individual as random vector from lower bound to uppper bound
          vector(j) = randi(upper_b(j)); 
        end
        if valid_119(vector) == 1 % stop loop if individual is valid
          flag = 1;
        end
      end
      ftn(i) = calculation_119(vector);
      if minim_ftn > ftn(i)   
        minim_ftn = ftn(i);
        aopt = vector;
      end
    end

    fopt = min(min(ftn(ftn>0)));

end


