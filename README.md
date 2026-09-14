# MedTrack Apresentação VBA

Este repositório contém uma macro VBA para gerar automaticamente uma apresentação de PowerPoint sobre a **MedTrack Saúde Digital**.

## Estrutura de Pastas

```
/
├── README.md
├── .gitignore
├── vba/
│   └── MedTrack_Apresentacao.bas
└── docs/
    └── COMO_USAR.md
```

## Como Usar o Arquivo VBA

1. Abra o Microsoft PowerPoint.
2. Pressione `Alt + F11` para abrir o editor VBA.
3. No menu, clique em **Inserir > Módulo**.
4. Importe o arquivo `vba/MedTrack_Apresentacao.bas` ou cole seu conteúdo no módulo.
5. Execute a macro `GerarApresentacaoCompletaMedTrackMelhorada`.

## Onde a Apresentação Será Salva

A apresentação gerada será salva na sua **Área de Trabalho (Desktop)** com o nome `MedTrack_Saude_Digital.pptx`.

## Observação Importante

Certifique-se de habilitar macros no PowerPoint antes de executar o código:
- Vá em **Arquivo > Opções > Central de Confiabilidade > Configurações da Central de Confiabilidade > Configurações de Macro**.
- Selecione **Habilitar todas as macros** (ou configure conforme sua política de segurança).