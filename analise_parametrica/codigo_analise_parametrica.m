    %-----------------An�lise Param�trica do Recuperador-------------------
    %Este c�digo realiza a an�lise param�trica do recuperador, variando as
    %temperaturas e vaz�es de entrada dos fluidos e verificando como essa
    %varia��o influencia nas temperaturas de sa�da, efetividade, taxa de
    %transfer�ncia de calor, queda de press�o relativa por escoamento e
    %total do recuperador.

    clear;
    clc;

    %---------------------Par�metros Fixos nas An�lises--------------------
    f_mol_ar = [0.79 0.21 0.0 0 0 0 0 0]; %composi��o molar do ar
    f_mol_gas = [0.76 0 0 0 0.11 0.13 0 0]; %composi��o molar dos gases

    Pc_i = 368000; %press�o de entrada do ar, em Pa (CAI; HUAI; XI, 2018)
    Ph_i = 105000; %press�o de entrada do g�s, em Pa (CAI; HUAI; XI, 2018)

    %-----------------------Varia��o das Temperaturas----------------------
    %Vaz�o fixadas
    m_c = 0.40;
    m_h = 0.40;

    %Varia��o da temperatura de entrada do fluido frio---------------------
    Th_i = 800; %temperatura de entrada do fluido quente fixa

    %Pr�-aloca��o
    i=0;
    j=0;
    eftv=zeros(1,30);%efetividade
    temp=zeros(1,30);%temperatura variavel
    q=zeros(1,30);%transfer�ncia de calor 
    dpc=zeros(1,30);%queda de press�o relativa no fluido frio
    dph=zeros(1,30);%queda de press�o relativa no fluido quente
    dpt=zeros(1,30);%Queda de press�o relativa total
    tco=zeros(1,30);%temperatura de sa�da fluido frio
    tho=zeros(1,30);%temperatura de sa�da fluido quente

    while i < 30,
        Tc_i = 400+j;
        i=i+1;
        j=j+10;
        symout = sim('simulink_analise_parametrica');
        eftv(i)=efetiv(end);
        q(i)=q_dot(40,1);
        dpc(i)=(deltaP_c(end)/Pc_i)*100;
        dph(i)=(deltaP_h(end)/Ph_i)*100;
        dpt(i)=dpc(i)+dph(i);
        tco(i)=Tc_o(end);
        tho(i)=Th_o(end);
        temp(i)=Tc_i;
    end

    figure
    plot(temp, tho, 'r', temp, tco, 'b');
    legend('Fluido quente','Fluido frio')
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Temperatura de sa�da dos fluidos [K]')

    figure
    plot(temp, eftv);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Efetividade')

    figure;
    plot(temp, q);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Taxa de transfer�ncia de calor [W]')

    figure;
    plot(temp, dpc);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Queda de press�o relativa (fluido frio) [%]')
    
    figure;
    plot(temp, dpc);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Queda de press�o relativa (fluido quente) [%]')

    figure;
    plot(temp, dpt);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Queda de press�o relativa total [%]')

    %Varia��o da temperatura de entrada do fluido quente-------------------
    Tc_i = 400; %temperatura de entrada do fluido frio fixa

    %Pr�-aloca��o
    i=0;
    j=0;
    eftv=zeros(1,30);%efetividade
    temp=zeros(1,30);%temperatura variavel
    q=zeros(1,30);%transfer�ncia de calor 
    dpc=zeros(1,30);%queda de press�o relativa no fluido frio
    dph=zeros(1,30);%queda de press�o relativa no fluido quente
    dpt=zeros(1,30);%Queda de press�o relativa total
    tco=zeros(1,30);%temperatura de sa�da fluido frio
    tho=zeros(1,30);%temperatura de sa�da fluido quente

    while i < 30,
        Th_i = 500+j;
        i=i+1;
        j=j+10;
        symout = sim('simulink_analise_parametrica');
        eftv(i)=efetiv(end);
        q(i)=q_dot(40,1);
        dpc(i)=(deltaP_c(end)/Pc_i)*100;
        dph(i)=(deltaP_h(end)/Ph_i)*100;
        dpt(i)=dpc(i)+dph(i);
        tco(i)=Tc_o(end);
        tho(i)=Th_o(end);
        temp(i)=Th_i;
    end

    figure
    plot(temp, tho, 'r', temp, tco, 'b');
    legend('Fluido quente','Fluido frio')
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Temperatura de sa�da dos fluidos [K]')

    figure;
    plot(temp, eftv);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Efetividade')

    figure;
    plot(temp, q);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Taxa de transfer�ncia de calor [W]')

    figure;
    plot(temp, dpc);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Queda de press�o relativa (fluido frio) [%]')
   
    figure;
    plot(temp, dph);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Queda de press�o relativa (fluido quente) [%]')

    figure;
    plot(temp, dpt);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Queda de press�o relativa total [%]')

    %--------------------------Varia��o das Vaz�es-------------------------
    %Temperaturas fixadas
    Tc_i = 400;
    Th_i = 800;

    %Varia��o da vaz�o m�ssica do fluido frio------------------------------
    m_h = 0.4; %vaz�o do fluido quente fixa

    i=0;
    j=0;
    eftv=zeros(1,40);%efetividade
    m=zeros(1,40);%vaz�o variavel
    q=zeros(1,40);%transfer�ncia de calor 
    dpc=zeros(1,40);%queda de press�o relativa no fluido frio
    dph=zeros(1,40);%queda de press�o relativa no fluido quente
    dpt=zeros(1,40);%Queda de press�o relativa total
    tco=zeros(1,40);%temperatura de sa�da fluido frio
    tho=zeros(1,40);%temperatura de sa�da fluido quente

    dp_h=zeros(1,40);
    while i < 40,
        m_c = 0.2+j;
        i=i+1;
        j=j+0.010;
        symout = sim('simulink_analise_parametrica');
        eftv(i)=efetiv(end);
        q(i)=q_dot(40,1);
        dpc(i)=(deltaP_c(end)/Pc_i)*100;
        dph(i)=(deltaP_h(end)/Ph_i)*100;
        dpt(i)=dpc(i)+dph(i);
        tco(i)=Tc_o(end);
        tho(i)=Th_o(end);
        m(i)=m_c;
    end

    figure
    plot(m, tho, 'r', m, tco, 'b');
    legend('Fluido quente','Fluido frio')
    xlabel('Vaz�o m�ssica do fluido frio [kg/s]')
    ylabel('Temperatura de sa�da dos fluidos [K]')

    figure;
    plot(m, eftv);
    xlabel('Vaz�o m�ssica do fluido frio [kg/s]')
    ylabel('Efetividade do Recuperador')

    figure;
    plot(m, q);
    xlabel('Vaz�o m�ssica do fluido frio [kg/s]')
    ylabel('Taxa de transfer�ncia de calor [W]')

    figure;
    plot(m, dpc);
    xlabel('Vaz�o m�ssica do fluido frio [kg/s]')
    ylabel('Queda de press�o relativa (fluido frio) [%]')
    
    figure;
    plot(m, dph);
    xlabel('Vaz�o m�ssica do fluido frio [kg/s]')
    ylabel('Queda de press�o relativa (fluido quente) [%]')
    
    figure;
    plot(m, dpt);
    xlabel('Vaz�o m�ssica do fluido frio [kg/s]')
    ylabel('Queda de press�o relativa total [%]')

    %Varia��o da vaz�o m�ssica do fluido quente----------------------------
    m_c = 0.4; %vaz�o do fluido frio fixa

    %Pr�-aloca��o
    i=0;
    j=0;
    eftv=zeros(1,40);%efetividade
    m=zeros(1,40);%vaz�o variavel
    q=zeros(1,40);%transfer�ncia de calor 
    dpc=zeros(1,40);%queda de press�o relativa no fluido frio
    dph=zeros(1,40);%queda de press�o relativa no fluido quente
    dpt=zeros(1,40);%Queda de press�o relativa total
    tco=zeros(1,40);%temperatura de sa�da fluido frio
    tho=zeros(1,40);%temperatura de sa�da fluido quente

    while i < 40,
        m_h = 0.2+j;
        i=i+1;
        j=j+0.010;
        symout = sim('simulink_analise_parametrica');
        eftv(i)=efetiv(end);
        q(i)=q_dot(40,1);
        dpc(i)=(deltaP_c(end)/Pc_i)*100;
        dph(i)=(deltaP_h(end)/Ph_i)*100;
        dpt(i)=dpc(i)+dph(i);
        tco(i)=Tc_o(end);
        tho(i)=Th_o(end);
        m(i)=m_h;
    end

    figure
    plot(m, tho, 'r', m, tco, 'b');
    legend('Fluido quente','Fluido frio')
    xlabel('Vaz�o m�ssica do fluido quente [kg/s]')
    ylabel('Temperatura de sa�da dos fluidos [K]')

    figure;
    plot(m, eftv);
    xlabel('Vaz�o m�ssica do fluido quente [kg/s]')
    ylabel('Efetividade do Recuperador')

    figure;
    plot(m, q);
    xlabel('Vaz�o m�ssica do fluido quente [kg/s]')
    ylabel('Taxa de transfer�ncia de calor [W]')

    figure;
    plot(m, dpc);
    xlabel('Vaz�o m�ssica do fluido quente [kg/s]')
    ylabel('Queda de press�o relativa (fluido frio) [%]')
    
    figure;
    plot(m, dph);
    xlabel('Vaz�o m�ssica do fluido quente [kg/s]')
    ylabel('Queda de press�o relativa (fluido quente) [%]')
    
    figure;
    plot(m, dpt);
    xlabel('Vaz�o m�ssica do fluido quente [kg/s]')
    ylabel('Queda de press�o relativa total [%]')