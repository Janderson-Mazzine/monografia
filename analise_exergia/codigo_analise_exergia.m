    %-----------Análise da destruição da exergia no recuperador-----------
    %Este código efetua os cálculos relativos a destruição da exergia
    %(irreversibilidades) total no recuperador bem como suas componentes
    %devido a transferência de calor entre os fluidos à diferenças finitas
    %de temperatura, e devido a queda de pressão, considerando que o
    %recuperador é adiabático.

    clear;
    clc;
   
    tzero=(293.57);%temperatura ambiente - média anual de Juiz de Fora, calculada a partir de serie histórica de 30 anos. Fonte: Climatempo. Disponível em: <https://www.climatempo.com.br/climatologia/152/juizdefora-mg>. Acesso em 15/02/2021

    %------------------------Composição dos fluidos------------------------
    f_mol_ar = [0.79 0.21 0.0 0 0 0 0 0]; %composição molar do ar
    f_mol_gas = [0.76 0 0 0 0.11 0.13 0 0]; %composição molar dos gases

    %----------------------------------------------------------------------
    %--------------------Dados C30 (CAI; HUAI; XI, 2018)-------------------
    %----------------------------------------------------------------------
    
    m_c=0.3; %Vazão mássica de ar, em kg/s
    m_f=0.01; %Vazão mássica de combustível, em kg/s
    Tc_i=358.15; %Temperatura de entrada do fluido frio, em K
    Th_i=584.817; %Temperatura de entrada do fluido frio, em K
    Pc_i = 368000; %pressão de entrada do ar, em Pa (CAI; HUAI; XI, 2018)
    Ph_i = 105000; %pressão de entrada do gás, em Pa (CAI; HUAI; XI, 2018)
 
    symout = sim('simulink_analise_exergia'); %Executa o código Simulink para análise de exergia
    
    
    %Exergia de entrada
    E_i=(m_c+m_f)*(h_h_i(end)-tzero*s_h_i(end))+(m_c)*(h_c_i(end)-tzero*s_c_i(end));
    
    %Exergia total destruida no recuperador
    L=(m_c+m_f)*(h_h_i(end)-h_h_o(end)-tzero*(s_h_i(end)-s_h_o(end)))+(m_c)*(h_c_i(end)-h_c_o(end)-tzero*(s_c_i(end)-s_c_o(end)));
   
    %Exergia de saída
    E_o=E_i-L;
    
    %Exergia destruida devido a transferência de calor entre os fluxos
    I_deltaT=tzero*(C_c(end)*log(Tc_o(end)/Tc_i(end))+C_h(end)*log(Th_o(end)/Th_i(end)));
    
    %Exergia destruida devido a queda de pressão
    I_deltaP=L - I_deltaT;
    
    %Eficiência exergética
    psi=E_o/E_i;
    
    %Valores relativos    
    Idt_rel_Ei=I_deltaT/E_i;
    Idp_rel_Ei=I_deltaP/E_i;
    
    Idt_rel_L=I_deltaT/L;
    Idp_rel_L=I_deltaP/L;
    
    