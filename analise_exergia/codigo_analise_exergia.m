    %-----------An�lise da destrui��o da exergia no recuperador-----------
    %Este c�digo efetua os c�lculos relativos a destrui��o da exergia
    %(irreversibilidades) total no recuperador bem como suas componentes
    %devido a transfer�ncia de calor entre os fluidos � diferen�as finitas
    %de temperatura, e devido a queda de press�o, considerando que o
    %recuperador � adiab�tico.

    clear;
    clc;
   
    tzero=(293.57);%temperatura ambiente - m�dia anual de Juiz de Fora, calculada a partir de serie hist�rica de 30 anos. Fonte: Climatempo. Dispon�vel em: <https://www.climatempo.com.br/climatologia/152/juizdefora-mg>. Acesso em 15/02/2021

    %------------------------Composi��o dos fluidos------------------------
    f_mol_ar = [0.79 0.21 0.0 0 0 0 0 0]; %composi��o molar do ar
    f_mol_gas = [0.76 0 0 0 0.11 0.13 0 0]; %composi��o molar dos gases

    %----------------------------------------------------------------------
    %--------------------Dados C30 (CAI; HUAI; XI, 2018)-------------------
    %----------------------------------------------------------------------
    
    m_c=0.3; %Vaz�o m�ssica de ar, em kg/s
    m_f=0.01; %Vaz�o m�ssica de combust�vel, em kg/s
    Tc_i=358.15; %Temperatura de entrada do fluido frio, em K
    Th_i=584.817; %Temperatura de entrada do fluido frio, em K
    Pc_i = 368000; %press�o de entrada do ar, em Pa (CAI; HUAI; XI, 2018)
    Ph_i = 105000; %press�o de entrada do g�s, em Pa (CAI; HUAI; XI, 2018)
 
    symout = sim('simulink_analise_exergia'); %Executa o c�digo Simulink para an�lise de exergia
    
    
    %Exergia de entrada
    E_i=(m_c+m_f)*(h_h_i(end)-tzero*s_h_i(end))+(m_c)*(h_c_i(end)-tzero*s_c_i(end));
    
    %Exergia total destruida no recuperador
    L=(m_c+m_f)*(h_h_i(end)-h_h_o(end)-tzero*(s_h_i(end)-s_h_o(end)))+(m_c)*(h_c_i(end)-h_c_o(end)-tzero*(s_c_i(end)-s_c_o(end)));
   
    %Exergia de sa�da
    E_o=E_i-L;
    
    %Exergia destruida devido a transfer�ncia de calor entre os fluxos
    I_deltaT=tzero*(C_c(end)*log(Tc_o(end)/Tc_i(end))+C_h(end)*log(Th_o(end)/Th_i(end)));
    
    %Exergia destruida devido a queda de press�o
    I_deltaP=L - I_deltaT;
    
    %Efici�ncia exerg�tica
    psi=E_o/E_i;
    
    %Valores relativos    
    Idt_rel_Ei=I_deltaT/E_i;
    Idp_rel_Ei=I_deltaP/E_i;
    
    Idt_rel_L=I_deltaT/L;
    Idp_rel_L=I_deltaP/L;
    
    