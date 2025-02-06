programa
{
	inclua biblioteca Util --> u
	
	 cadeia nomeHosp[10], cpfHosp[10]
	 inteiro diasHosp[10]
	 real despesasHosp[10]
	 inteiro indiceHospe = 0
	 
	funcao criarMenu() {
		limpa()
		escreva("1 – Cadastrar Hospedes\n")
		escreva("2 – Exibir Hospedes Cadastrados\n")
		escreva("3 – Reservar Área de Lazer\n")
		escreva("4 – Calcular total a pagar\n")
 		escreva("0 – Sair\n")
 		escreva("\nQual sua opcão: ")
	}
	funcao criarMenuReserva(inteiro indice) {
		limpa()
		escreva(nomeHosp[indice], " CPF: ", cpfHosp[indice], "\n\n")
		escreva("A – Academia: Custo de R$ 20,00\n")
		escreva("S – Salão de Festas: Custo de R$ 50,00\n")
		escreva("R - Restaurante: Custo de R$ 35,00\n")
 		escreva("0 – Retornar ao menu inical\n")
 		escreva("\nQual área de lazer desejada: ")
	}
	funcao cadastrarHospede(cadeia nome, cadeia cpf, inteiro dias) {
		se(indiceHospe < u.numero_elementos(nomeHosp)) {
			
			nomeHosp[indiceHospe] = nome
			cpfHosp[indiceHospe] = cpf
			diasHosp[indiceHospe] = dias
			despesasHosp[indiceHospe] = 0.0
			
			escreva("Cadastro realizado com sucesso!")
			indiceHospe++
			
		} senao{
			escreva("Os cadastros estão lotados!")
		}
		
	}
	funcao logico exibirHospedes(){
		logico retorno
		limpa()
		se(indiceHospe == 0){
			escreva("\n-------------------------------\n")
			escreva("Nenhum hóspede cadastrado!")
			retorno = verdadeiro
		}senao {
			para (inteiro i =0; i<indiceHospe;i++){
				escreva("\n-------------------------------\n")
				escreva("Índice: ", i, "\n")
				escreva("Nome: ", nomeHosp[i], " CPF: ", cpfHosp[i], "\n")
				escreva("Quantidade de Dias: ", diasHosp[i], "\n")
			}
			retorno = falso
		}
		escreva("\n-------------------------------\n")
		retorne retorno
	}

	funcao logico verificaIndice(inteiro indice){
		se(indice >=0 e indice < indiceHospe)
			retorne verdadeiro
		retorne falso
	}

	funcao real totalPagar(inteiro indice) {
		real total
		total = diasHosp[indice] * 100.00 + despesasHosp[indice]
		retorne total
	}

	funcao adicionaCusto(real custo, inteiro indice) {
		despesasHosp[indice] += custo
	}
	funcao inicio()
	{
		cadeia nome, cpf
		inteiro opcao, dias, indice
		caracter confirmar, reserva
		faca{
			criarMenu()
			leia(opcao)
			escolha(opcao){
				caso 0:
					escreva("Até a próxima!!")
					pare
				caso 1:
					faca{
						limpa()
						escreva("Pode cadastrar.\nDigite o nome do hóspede: ")
						leia(nome)
						
						escreva("Digite o CPF: ")
						leia(cpf)
						
						escreva("Digite a quantidade de dias: ")
						leia(dias)
						escreva("\n-------------------------------\n")
						escreva("Índice: ", indiceHospe, "\n")
						escreva("Nome: ", nome, " CPF: ", cpf, "\n")
						escreva("Quantidade de Dias: ", dias, "\n")
						escreva("Confirma as informações (S/N)? ")
	
						leia(confirmar)
					
						cadastrarHospede(nome, cpf, dias)
					}enquanto(confirmar != 'S' e confirmar != 's')
						
					u.aguarde(1500)
					pare
				caso 2:
					exibirHospedes()
					escreva("Digite <<ENTER>> para retornar...")
					leia(nome)
					pare
				caso 3:
					se(nao exibirHospedes()){
						escreva("Qual o índice do hóspede: ")
						leia(indice)
						
						se(verificaIndice(indice)){ /* Verifica se esse índice existe */
							faca{
								limpa()
								criarMenuReserva(indice)
								leia(reserva)

								escolha(reserva){
									caso '0':
										escreva("Retornando ao menu inicial.")
										pare
									caso 'A':
										adicionaCusto(20.0, indice)
										escreva("Reservado Academia.")
										pare
									caso 'S':
										adicionaCusto(50.0, indice)
										escreva("Reservado o Salão de Festas.")
										pare
									caso 'R':
										adicionaCusto(35.0, indice)
										escreva("Reservado o Restaurante.")
										pare
									caso contrario:
										escreva("Opção inválida!")
										pare
										
								}
								u.aguarde(1000)
							}enquanto(reserva != '0')
							
						}senao{
							escreva("Índice inválido!")
							
						}
											
					}
					u.aguarde(1500)	
					pare
				caso 4:
					se(nao exibirHospedes()){
						
						
						faca{
							escreva("Qual o índice do hóspede: ")
							leia(indice)
							
						}enquanto(indice >= indiceHospe)
						escreva("\n-------------------------------\n")
						escreva(nomeHosp[indice], " CPF: ", cpfHosp[indice], "\n")
						escreva("Gastou um total de: R$", totalPagar(indice))
						escreva("\n-------------------------------\n")
						escreva("\nDigite <<ENTER>> para retornar...")
						leia(nome)
					}senao
						u.aguarde(1000)	
					pare
				caso contrario:
					escreva("Opção inválida")
					u.aguarde(1000)
					pare
			}
		}enquanto(opcao!=0)
		
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 4546; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {indiceHospe, 8, 10, 11}-{indice, 82, 23, 6};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */