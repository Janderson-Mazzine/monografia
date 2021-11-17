    %--------------------Validação da Simulação ---------------------------
    %Este código efetua os cálculos relativos a validação da simulação do
    %recuperador CWPS da microturbina Capstone C30, e gerando gráficos para
    %análise.

    clear;
    clc;

    %--------------------Parâmetros Fixos nas Análises---------------------
    f_mol_ar = [0.79 0.21 0.0 0 0 0 0 0]; %composição molar do ar
    f_mol_gas = [0.76 0 0 0 0.11 0.13 0 0]; %composição molar dos gases

    N=0.82; %rotação da turbina, para o cálculo do modelo preliminar simplificado.

    Pc_i = 368000; %pressão de entrada do ar, em Pa (CAI; HUAI; XI, 2018)
    Ph_i = 105000; %pressão de entrada do gás, em Pa (CAI; HUAI; XI, 2018)

    %-----------Dados de entrada - 9 casos (XU et al, 2009)----------------
    caso=[1 2 3 4 5 6 7 8 9];
    m=[0.20 0.26 0.30 0.20 0.26 0.15 0.20 0.26 0.30]; %Vazão mássica, em kg/s
    tci=[348.71 348.40 348.63 348.37 349.26 346.82 348.46 348.80 347.55]; %Temperatura de entrada do fluido frio, em K
    thi=[673.15 673.46 673.77 698.15 698.19 722.70 723.15 723.32 722.17]; %Temperatura de entrada do fluido quente, em K

    %------------Dados de saída - 9 casos (XU et al, 2009)-----------------
    tco_ex=[631.71 627.83 636.61 650.26 653.09 658.15 676.31 680.86 674.99]; %Temperatura de saída do fluido frio, em K
    tho_ex=[386.15 381.25 390.95 392.15 385.15 408.15 385.15 389.35 385.95]; %Temperatura de saída do fluido quente, em K

    deltapc_ex=[2070 2530 2810 2210 2590 2350 2490 2710 2810]; %Queda de pressão no lado do fluido frio, em Pa
    deltaph_ex=[1210 1710 1990 1370 1560 1070 1390 1770 1990]; %Queda de pressão no lado do fluido quente, em Pa

    %-----------------------Pré-alocação de variáveis----------------------
    tho_simp=zeros(1,9);
    deltapc_simp=zeros(1,9);
    deltaph_simp=zeros(1,9);
    tco_deta=zeros(1,9);
    tho_deta=zeros(1,9);
    tco_simp=zeros(1,9);
    tho_simp=zeros(1,9);
    deltapc_deta=zeros(1,9);
    deltaph_deta=zeros(1,9);
    efetividade=zeros(1,9);
    dp_relativ_total=zeros(1,9);
    erro_abs_tco=zeros(1,9);
    erro_abs_tho=zeros(1,9);
    erro_abs_deltapc=zeros(1,9);
    erro_abs_deltaph=zeros(1,9);
    erro_rel_tco=zeros(1,9);
    erro_rel_tho=zeros(1,9);
    erro_rel_deltapc=zeros(1,9);
    erro_rel_deltaph=zeros(1,9);  

    %------------------------Cálculo dos casos-----------------------------
    for i=1:9;
        m_c=m(i);
        m_f=0; %Condição regime permanente à fluxo de massa igual
        Tc_i=tci(i);
        Th_i=thi(i);
        symout = sim('simulink_validacao'); %Executa o código Simulink para validação

        %Registro dos resultados do modelo simplificado
        tco_simp(i)=Tc_o1(end);
        tho_simp(i)=Th_o1(end);
        deltapc_simp(i)=deltaP_c1(end);
        deltaph_simp(i)=deltaP_h1(end);

        %Registro dos resultados do modelo detalhado
        tco_deta(i)=Tc_o(end);
        tho_deta(i)=Th_o(end);
        deltapc_deta(i)=deltaP_c(end);
        deltaph_deta(i)=deltaP_h(end);
        efetividade(i)=efetiv(end);
        dp_relativ_total(i)=deltapc_deta(i)/Pc_i+deltaph_deta(i)/Ph_i; %queda de pressão relativa total

        %Calculos dos erros absolutos
        erro_abs_tco(i)=tco_deta(i)-tco_ex(i);
        erro_abs_tho(i)=tho_deta(i)-tho_ex(i);
        erro_abs_deltapc(i)=deltapc_deta(i)-deltapc_ex(i);
        erro_abs_deltaph(i)=deltaph_deta(i)-deltaph_ex(i);

        %Calculos dos erros relativos
        erro_rel_tco(i)=erro_abs_tco(i)/tco_ex(i);
        erro_rel_tho(i)=erro_abs_tho(i)/tho_ex(i);
        erro_rel_deltapc(i)=erro_abs_deltapc(i)/deltapc_ex(i);
        erro_rel_deltaph(i)=erro_abs_deltaph(i)/deltaph_ex(i);
    end;

    %---Plotagem dos gráficos de validação incluindo modelo simplificado---
    figure;
    plot(caso, tco_deta, 'bs', caso, tco_ex, 'gs', caso, tco_simp, 'ys', caso, tco_deta, 'b', caso, tco_ex, 'g', caso, tco_simp, 'y');
    xlabel('Caso')
    ylabel('Temperatura de saída do fluido frio [K]')
    legend('Calculado','Experimental','Modelo Preliminar')

    figure;
    plot(caso, tho_deta, 'bs', caso, tho_ex, 'gs', caso, tho_simp, 'ys', caso, tho_deta, 'b', caso, tho_ex, 'g', caso, tho_simp, 'y');
    xlabel('Caso')
    ylabel('Temperatura de saída do fluido quente [K]')
    legend('Calculado','Experimental','Modelo Preliminar')

    figure;
    plot(caso, deltapc_deta, 'bs', caso, deltapc_ex, 'gs', caso, deltapc_simp, 'ys', caso, deltapc_deta, 'b', caso, deltapc_ex, 'g', caso, deltapc_simp, 'y');
    xlabel('Caso')
    ylabel('Queda de pressão do fluido frio [Pa]')
    legend('Calculado','Experimental','Modelo Preliminar')

    figure;
    plot(caso, deltaph_deta, 'bs', caso, deltaph_ex, 'gs', caso, deltaph_simp, 'ys', caso, deltaph_deta, 'b', caso, deltaph_ex, 'g', caso, deltaph_simp, 'y');
    xlabel('Caso')
    ylabel('Queda de pressão do fluido quente [Pa]')
    legend('Calculado','Experimental','Modelo Preliminar')

    %--------Plotagem dos gráficos de validação sem modelo simplificado----
    figure;
    plot(caso, tco_deta, 'bs', caso, tco_ex, 'gs', caso, tco_deta, 'b', caso, tco_ex, 'g');
    xlabel('Caso')
    ylabel('Temperatura de saída do fluido frio [K]')
    legend('Calculado','Experimental')

    figure;
    plot(caso, tho_deta, 'bs', caso, tho_ex, 'gs', caso, tho_deta, 'b', caso, tho_ex, 'g');
    xlabel('Caso')
    ylabel('Temperatura de saída do fluido quente [K]')
    legend('Calculado','Experimental')

    figure;
    plot(caso, deltapc_deta, 'bs', caso, deltapc_ex, 'gs', caso, deltapc_deta, 'b', caso, deltapc_ex, 'g');
    xlabel('Caso')
    ylabel('Queda de pressão do fluido frio [Pa]')
    legend('Calculado','Experimental')

    figure;
    plot(caso, deltaph_deta, 'bs', caso, deltaph_ex, 'gs', caso, deltaph_deta, 'b', caso, deltaph_ex, 'g');
    xlabel('Caso')
    ylabel('Queda de pressão do fluido quente [Pa]')
    legend('Calculado','Experimental')

    %------------------Cálculo dos casos especiais-------------------------
    %Dados de operação Capstone C30 (CAI; HUAI; XI, 2018)------------------
    m_c=0.3; %Vazão mássica de ar, em kg/s
    m_f=0.01; %Vazão mássica de combustível, em kg/s
    Tc_i=358.15; %Temperatura de entrada do fluido frio, em K
    Th_i=584.817; %Temperatura de entrada do fluido frio, em K

    symout = sim('simulink_validacao'); %Executa o código Simulink para validação

    %Registro dos resultados do modelo detalhado
    tco_c30=Tc_o(end);
    tho_c30=Th_o(end);
    deltapc_c30=deltaP_c(end);
    deltaph_c30=deltaP_h(end);
    efetividade_c30=efetiv(end);
    dp_relativ_total_c30=deltapc_c30/Pc_i+deltaph_c30/Ph_i; %queda de pressão relativa total

    %Calculos dos erros absolutos
    erro_abs_efetiv_c30=efetividade_c30-0.864;
    erro_abs_dp_rel_to_c30=dp_relativ_total_c30-0.0379;
    erro_abs_tco_c30=tco_c30-552.039;
    erro_abs_tho_c30=tho_c30-402.039;

    %Calculos dos erros relativos
    erro_rel_tco_c30=erro_abs_tco_c30/552.039;
    erro_rel_tho_c30=erro_abs_tho_c30/402.039;
    
    