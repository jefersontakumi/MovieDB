# MovieDB
Aplicativo de catalogos de filmes, utilizando a base de dados da [The Movie DataBase](https://www.themoviedb.org/) 

## Começando
Esse projeto utiliza o framework Alamofire e o gerenciador de dependencias CocoaPods. 
Então após baixar o projeto, abra o prompt de comando, e dentro do diretório do projeto execute o seguinte comando:

```
pod install
```

### Pré-requisitos
* Xcode Version 10.2.1 (10E1001) 
* Swift 5

### Gerar o ipa para um site interno
1 -  É necessário ter uma conta Enterprise
2 - Gerar a chave do aplicativo no site do Apple Developer
3 - Selecionar no schema o device "Generic iOS Device"
4 -  Selecionar no menu "Product > Archive"
5 -  Clique em "Distribute App"
6 -  Selecione a opção "Enterprise" e clique em next
7 - Clique novamente em next
8 -  Clique novamente em next
9 - Clique em export

### Site para instação
Criar uma pagina com um link itms-services://?action=download-manifest&url=https://www.teste.com.br/MovieDB.plist

Obs: é necessário a url ser https

#### Modelo do arquivo plist

```
<plist version="1.0">
    <dict>
        <key>items</key>
        <array>
    <dict>
    <key>assets</key>
    <array>
        <dict>
            <key>kind</key>
            <string>software-package</string>
            <key>url</key>
            <string>https://[URL do ipa]</string>
        </dict>
        <dict>
            <key>kind</key>
            <string>full-size-image</string>
            <key>needs-shine</key>
            <true/>
            <key>url</key>
            <string>logo.png</string>
        </dict>
        <dict>
            <key>kind</key>
            <string>display-image</string>
            <key>needs-shine</key>
            <true/>
            <key>url</key>
            <string>tumb_support.png</string>
        </dict>
    </array>
    <key>metadata</key>
    <dict>
        <key>bundle-identifier</key>
        <string>br.com.takumi.MovieDB</string>
        <key>bundle-version</key>
        <string>1.0.0</string>
        <key>build-version</key>
        <string>1</string>
        <key>kind</key>
        <string>software</string>
        <key>title</key>
        <string>MovieDB</string>
        </dict>
</dict>
```

