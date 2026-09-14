# Como Usar a Macro MedTrack no PowerPoint

Siga os passos abaixo para importar e executar a macro que gera automaticamente a apresentação da MedTrack Saúde Digital.

## Passo a Passo

### 1. Abrir o PowerPoint
Abra o Microsoft PowerPoint em seu computador.

### 2. Acessar o Editor VBA
Pressione as teclas `Alt + F11` para abrir o editor do Visual Basic for Applications (VBA).

### 3. Inserir um Módulo
No menu superior, clique em **Inserir > Módulo**. Uma nova janela de módulo será aberta.

### 4. Importar ou Colar o Código
Você tem duas opções:

**Opção A - Importar o arquivo:**
- No menu, clique em **Arquivo > Importar Arquivo...**
- Navegue até o arquivo `vba/MedTrack_Apresentacao.bas` e selecione-o.

**Opção B - Copiar e colar:**
- Abra o arquivo `vba/MedTrack_Apresentacao.bas` em um editor de texto.
- Copie todo o conteúdo.
- Cole no módulo vazio que foi criado no passo anterior.

### 5. Executar a Macro
- Com o módulo selecionado, pressione `F5` ou clique no botão **Executar** (▶) na barra de ferramentas.
- Ou vá em **Inserir > Macros**, selecione `GerarApresentacaoCompletaMedTrackMelhorada` e clique em **Executar**.

### 6. Verificar o Arquivo Gerado
A apresentação será salva automaticamente na sua **Área de Trabalho (Desktop)** com o nome `MedTrack_Saude_Digital.pptx`.

### 7. Caso o Arquivo Não Apareça
Se você não encontrar o arquivo na Área de Trabalho:
- Verifique se a apresentação não ficou aberta atrás da janela do editor VBA.
- Minimize o editor VBA e verifique se o PowerPoint está aberto com a apresentação gerada.
- Salve a apresentação manualmente se necessário (**Arquivo > Salvar Como**).

## Observações Importantes

- **Habilitar Macros:** Certifique-se de que as macros estão habilitadas no PowerPoint antes de executar o código.
- **Permissões:** Você pode precisar de permissões de administrador para executar macros, dependendo das configurações de segurança do seu sistema.
