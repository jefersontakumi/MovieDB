# MovieDB

### Especificações do projeto
O projeto foi desenvolvido com o  Xcode Version 10.2.1 (10E1001) com Swift 5
Foi utilizado o Alamofire utilizando o gerenciador de dependencia Cocoapod 
A estrtutura segue o padrão VIPER

### Gerar o ipa para criar um site interno
- É necessário ter uma conta Enterprise
- Selecionar no schema o device "Generic iOS Device"
- Selecionar no menu "Product > Archive"
- Clique em "Distribute App"
- Selecione a opção "Enterprise" e clique em next
- Clique novamente em next
- Clique novamente em next
- Clique novamente em export

### Site para instação
Criar um link com a url itms-services://?action=download-manifest&url=https://www.teste.com.br/MovieDB.plist

Obs: é necessário a url ser https
