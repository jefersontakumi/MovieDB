# MovieDB

### Especificações do projeto
O projeto foi desenvolvido com o  Xcode Version 10.2.1 (10E1001) com Swift 5
Foi utilizado o Alamofire utilizando o gerenciador de dependencia Cocoapod 
A estrtutura segue o padrão VIPER

### Gerar o ipa para um site interno
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

Modelo do arquivo plist

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

