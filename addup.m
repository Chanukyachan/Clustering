function send = addup(a)
    b=size(a);
    key=0;
    for i=1:b(2)
        key=key+a(i);
    end
    send=key;
end