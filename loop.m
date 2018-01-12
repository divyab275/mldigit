
  i=0;
  while (i!=11)
    getpicture
    t = imageTo20x20Gray('e.jpg',0,0,Theta1,Theta2);
    i = predict(Theta1,Theta2,t)
    pause(0.5);
    t = reshape(t,1,400);
    k = input("Press 1 to add to the dataset");
    if(k==1)
      x = [x;t];
      Y = [Y;label];
      save("dataset.mat",'x','Y');
    end
    % title(gca,num2str (i));
  endwhile
