    %-----------------Análise Paramétrica do Recuperador-------------------
    %Este código realiza a análise paramétrica do recuperador, variando as
    %temperaturas e vazões de entrada dos fluidos e verificando como essa
    %variação influencia nas temperaturas de saída, efetividade, taxa de
    %transferência de calor, queda de pressão relativa por escoamento e
    %total do recuperador.

    clear;
    clc;

    %---------------------Parâmetros Fixos nas Análises--------------------
    f_mol_ar = [0.79 0.21 0.0 0 0 0 0 0]; %composição molar do ar
    f_mol_gas = [0.76 0 0 0 0.11 0.13 0 0]; %composição molar dos gases

    Pc_i = 368000; %pressão de entrada do ar, em Pa (CAI; HUAI; XI, 2018)
    Ph_i = 105000; %pressão de entrada do gás, em Pa (CAI; HUAI; XI, 2018)

    %-----------------------Variação das Temperaturas----------------------
    %Vazão fixadas
    m_c = 0.40;
    m_h = 0.40;

    %Variação da temperatura de entrada do fluido frio---------------------
    Th_i = 800; %temperatura de entrada do fluido quente fixa

    %Pré-alocação
    i=0;
    j=0;
    eftv=zeros(1,30);%efetividade
    temp=zeros(1,30);%temperatura variavel
    q=zeros(1,30);%transferência de calor 
    dpc=zeros(1,30);%queda de pressão relativa no fluido frio
    dph=zeros(1,30);%queda de pressão relativa no fluido quente
    dpt=zeros(1,30);%Queda de pressão relativa total
    tco=zeros(1,30);%temperatura de saída fluido frio
    tho=zeros(1,30);%temperatura de saída fluido quente

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
    ylabel('Temperatura de saída dos fluidos [K]')

    figure
    plot(temp, eftv);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Efetividade')

    figure;
    plot(temp, q);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Taxa de transferência de calor [W]')

    figure;
    plot(temp, dpc);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Queda de pressão relativa (fluido frio) [%]')
    
    figure;
    plot(temp, dpc);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Queda de pressão relativa (fluido quente) [%]')

    figure;
    plot(temp, dpt);
    xlabel('Temperatura de entrada do fluido frio [K]')
    ylabel('Queda de pressão relativa total [%]')

    %Variação da temperatura de entrada do fluido quente-------------------
    Tc_i = 400; %temperatura de entrada do fluido frio fixa

    %Pré-alocação
    i=0;
    j=0;
    eftv=zeros(1,30);%efetividade
    temp=zeros(1,30);%temperatura variavel
    q=zeros(1,30);%transferência de calor 
    dpc=zeros(1,30);%queda de pressão relativa no fluido frio
    dph=zeros(1,30);%queda de pressão relativa no fluido quente
    dpt=zeros(1,30);%Queda de pressão relativa total
    tco=zeros(1,30);%temperatura de saída fluido frio
    tho=zeros(1,30);%temperatura de saída fluido quente

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
    ylabel('Temperatura de saída dos fluidos [K]')

    figure;
    plot(temp, eftv);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Efetividade')

    figure;
    plot(temp, q);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Taxa de transferência de calor [W]')

    figure;
    plot(temp, dpc);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Queda de pressão relativa (fluido frio) [%]')
   
    figure;
    plot(temp, dph);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Queda de pressão relativa (fluido quente) [%]')

    figure;
    plot(temp, dpt);
    xlabel('Temperatura entrada do fluido quente [K]')
    ylabel('Queda de pressão relativa total [%]')

    %--------------------------Variação das Vazões-------------------------
    %Temperaturas fixadas
    Tc_i = 400;
    Th_i = 800;

    %Variação da vazão mássica do fluido frio------------------------------
    m_h = 0.4; %vazão do fluido quente fixa

    i=0;
    j=0;
    eftv=zeros(1,40);%efetividade
    m=zeros(1,40);%vazão variavel
    q=zeros(1,40);%transferência de calor 
    dpc=zeros(1,40);%queda de pressão relativa no fluido frio
    dph=zeros(1,40);%queda de pressão relativa no fluido quente
    dpt=zeros(1,40);%Queda de pressão relativa total
    tco=zeros(1,40);%temperatura de saída fluido frio
    tho=zeros(1,40);%temperatura de saída fluido quente

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
    xlabel('Vazão mássica do fluido frio [kg/s]')
    ylabel('Temperatura de saída dos fluidos [K]')

    figure;
    plot(m, eftv);
    xlabel('Vazão mássica do fluido frio [kg/s]')
    ylabel('Efetividade do Recuperador')

    figure;
    plot(m, q);
    xlabel('Vazão mássica do fluido frio [kg/s]')
    ylabel('Taxa de transferência de calor [W]')

    figure;
    plot(m, dpc);
    xlabel('Vazão mássica do fluido frio [kg/s]')
    ylabel('Queda de pressão relativa (fluido frio) [%]')
    
    figure;
    plot(m, dph);
    xlabel('Vazão mássica do fluido frio [kg/s]')
    ylabel('Queda de pressão relativa (fluido quente) [%]')
    
    figure;
    plot(m, dpt);
    xlabel('Vazão mássica do fluido frio [kg/s]')
    ylabel('Queda de pressão relativa total [%]')

    %Variação da vazão mássica do fluido quente----------------------------
    m_c = 0.4; %vazão do fluido frio fixa

    %Pré-alocação
    i=0;
    j=0;
    eftv=zeros(1,40);%efetividade
    m=zeros(1,40);%vazão variavel
    q=zeros(1,40);%transferência de calor 
    dpc=zeros(1,40);%queda de pressão relativa no fluido frio
    dph=zeros(1,40);%queda de pressão relativa no fluido quente
    dpt=zeros(1,40);%Queda de pressão relativa total
    tco=zeros(1,40);%temperatura de saída fluido frio
    tho=zeros(1,40);%temperatura de saída fluido quente

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
    xlabel('Vazão mássica do fluido quente [kg/s]')
    ylabel('Temperatura de saída dos fluidos [K]')

    figure;
    plot(m, eftv);
    xlabel('Vazão mássica do fluido quente [kg/s]')
    ylabel('Efetividade do Recuperador')

    figure;
    plot(m, q);
    xlabel('Vazão mássica do fluido quente [kg/s]')
    ylabel('Taxa de transferência de calor [W]')

    figure;
    plot(m, dpc);
    xlabel('Vazão mássica do fluido quente [kg/s]')
    ylabel('Queda de pressão relativa (fluido frio) [%]')
    
    figure;
    plot(m, dph);
    xlabel('Vazão mássica do fluido quente [kg/s]')
    ylabel('Queda de pressão relativa (fluido quente) [%]')
    
    figure;
    plot(m, dpt);
    xlabel('Vazão mássica do fluido quente [kg/s]')
    ylabel('Queda de pressão relativa total [%]')