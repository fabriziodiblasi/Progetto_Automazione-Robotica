function puma560_model = load_puma560_model(d, a, alpha)
    for i=1:6
        L(i) = Link('d', d(i), 'a', a(i), 'alpha', alpha(i), 'revolute');
    end

    puma560_model = SerialLink(L, 'name','puma560_model');
end