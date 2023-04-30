function URnd = URnd()
    % Define global variables for seeds and constants
    persistent s10 s11 s12 s20 s21 s22 a12 a13n m1 a21 a23n m2 norm
    
    % Initialize constants and seeds if not initialized yet
    if isempty(s10) || isempty(s11) || isempty(s12) || isempty(s20) || isempty(s21) || isempty(s22)
        s10 = 64785;
        s11 = 3546;
        s12 = 123456;
        s20 = 658478;
        s21 = 73575;
        s22 = 234567;
        
        a12 = 1403580;
        a13n = 810728;
        m1 = 4294967087;
        a21 = 527612;
        a23n = 1370589;
        m2 = 4294944443;
        norm = 2.32830654929573E-10;
    end
    
    % Generate a uniform random number based on L'Ecuyer's 32bit MRG32K3A method
    p1 = a12 * s11 - a13n * s10;
    k = floor(p1 / m1);
    p1 = p1 - (k * m1);
    if (p1 < 0)
        p1 = p1 + m1;
    end
    
    s10 = s11;
    s11 = s12;
    s12 = p1;
    
    p2 = a21 * s22 - a23n * s20;
    k = floor(p2 / m2);
    p2 = p2 - (k * m2);
    if (p2 < 0)
        p2 = p2 + m2;
    end

    s20 = s21;
    s21 = s22;
    s22 = p2;
    
    if (p1 <= p2)
        URnd = ((p1 - p2 + m1) * norm);
    else
        URnd = ((p1 - p2) * norm);
    end
end
