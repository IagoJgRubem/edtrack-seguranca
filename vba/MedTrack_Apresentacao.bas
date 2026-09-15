Attribute VB_Name = "MedTrack_Apresentacao"
Option Explicit

' ============================================================================
' MedTrack Saúde Digital - Gerador de Apresentação PowerPoint
' ============================================================================
' Esta macro cria automaticamente uma apresentação profissional sobre
' a MedTrack Saúde Digital com todos os slides necessários.
' ============================================================================

Sub GerarApresentacaoCompletaMedTrackMelhorada()
    On Error GoTo ErrorHandler
    
    Dim pptApp As Object
    Dim pptPres As Object
    Dim slideIndex As Integer
    Dim desktopPath As String
    Dim filePath As String
    
    ' Obter caminho da Área de Trabalho
    desktopPath = CreateObject("WScript.Shell").SpecialFolders("Desktop")
    filePath = desktopPath & "\MedTrack_Saude_Digital.pptx"
    
    ' Criar nova instância do PowerPoint
    Set pptApp = CreateObject("PowerPoint.Application")
    pptApp.Visible = True
    
    ' Criar nova apresentação
    Set pptPres = pptApp.Presentations.Add
    slideIndex = 1
    
    ' Slide 1 - Capa
    Call AdicionarSlideCapa(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 2 - Sobre a MedTrack
    Call AdicionarSlideSobre(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 3 - Problema
    Call AdicionarSlideProblema(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 4 - Solução
    Call AdicionarSlideSolucao(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 5 - Funcionalidades
    Call AdicionarSlideFuncionalidades(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 6 - Benefícios
    Call AdicionarSlideBeneficios(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 7 - Tecnologias
    Call AdicionarSlideTecnologias(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 8 - Diferenciais
    Call AdicionarSlideDiferenciais(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 9 - Público-Alvo
    Call AdicionarSlidePublicoAlvo(pptPres, slideIndex)
    slideIndex = slideIndex + 1
    
    ' Slide 10 - Encerramento
    Call AdicionarSlideEncerramento(pptPres, slideIndex)
    
    ' Salvar apresentação
    pptPres.SaveAs filePath
    
    MsgBox "Apresentação gerada com sucesso!" & vbCrLf & _
           "Local: " & filePath, vbInformation, "MedTrack Saúde Digital"
    
    Exit Sub
    
ErrorHandler:
    MsgBox "Erro ao gerar apresentação: " & Err.Description, vbCritical, "Erro"
End Sub

Private Sub AdicionarSlideCapa(pres As Object, index As Integer)
    Dim slide As Object
    Dim titleShape As Object
    Dim subtitleShape As Object
    
    Set slide = pres.Slides.Add(index, 1) ' ppLayoutTitle
    
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "MedTrack Saúde Digital"
    
    Set subtitleShape = slide.Shapes(2)
    subtitleShape.TextFrame.TextRange.Text = "Revolucionando o Monitoramento de Pacientes Crônicos" & vbCrLf & _
                                            "Inovação em Saúde Digital"
End Sub

Private Sub AdicionarSlideSobre(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "Sobre a MedTrack"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "• Startup de saúde digital focada em pacientes crônicos" & vbCrLf & _
                "• Missão: melhorar a qualidade de vida através da tecnologia" & vbCrLf & _
                "• Especialistas em monitoramento remoto e prevenção de complicações" & vbCrLf & _
                "• Equipe multidisciplinar com expertise em saúde e tecnologia" & vbCrLf & _
                "• Compromisso com inovação e cuidado humanizado"
    End With
End Sub

Private Sub AdicionarSlideProblema(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "O Problema"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "• Pacientes crônicos enfrentam dificuldades no acompanhamento contínuo" & vbCrLf & _
                "• Alto índice de reinternações hospitalares evitáveis" & vbCrLf & _
                "• Falta de monitoramento em tempo real dos sinais vitais" & vbCrLf & _
                "• Dificuldade de acesso a cuidados especializados" & vbCrLf & _
                "• Sobrecarga do sistema de saúde público e privado"
    End With
End Sub

Private Sub AdicionarSlideSolucao(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "Nossa Solução"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "• Plataforma integrada de monitoramento remoto de pacientes" & vbCrLf & _
                "• Dispositivos IoT para coleta de sinais vitais em tempo real" & vbCrLf & _
                "• Algoritmos de IA para detecção precoce de anomalias" & vbCrLf & _
                "• Alertas automáticos para equipe médica e cuidadores" & vbCrLf & _
                "• Aplicativo móvel para pacientes e familiares"
    End With
End Sub

Private Sub AdicionarSlideFuncionalidades(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "Funcionalidades Principais"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "✓ Monitoramento contínuo de sinais vitais" & vbCrLf & _
                "✓ Histórico clínico digital integrado" & vbCrLf & _
                "✓ Telemedicina e consultas remotas" & vbCrLf & _
                "✓ Lembretes de medicamentos e consultas" & vbCrLf & _
                "✓ Relatórios personalizados para médicos" & vbCrLf & _
                "✓ Integração com prontuário eletrônico"
    End With
End Sub

Private Sub AdicionarSlideBeneficios(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "Benefícios"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "Para Pacientes:" & vbCrLf & _
                "  • Maior autonomia e qualidade de vida" & vbCrLf & _
                "  • Redução de visitas hospitalares desnecessárias" & vbCrLf & _
                "  • Segurança 24/7 com monitoramento constante" & vbCrLf & vbCrLf & _
                "Para Profissionais de Saúde:" & vbCrLf & _
                "  • Dados em tempo real para melhor tomada de decisão" & vbCrLf & _
                "  • Otimização do tempo e recursos" & vbCrLf & _
                "  • Prevenção de complicações graves"
    End With
End Sub

Private Sub AdicionarSlideTecnologias(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "Tecnologias Utilizadas"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "• Internet das Coisas (IoT) para dispositivos médicos" & vbCrLf & _
                "• Inteligência Artificial e Machine Learning" & vbCrLf & _
                "• Computação em Nuvem (Cloud Computing)" & vbCrLf & _
                "• Blockchain para segurança de dados" & vbCrLf & _
                "• APIs RESTful para integrações" & vbCrLf & _
                "• Aplicativos nativos iOS e Android"
    End With
End Sub

Private Sub AdicionarSlideDiferenciais(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "Diferenciais Competitivos"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "🎯 Foco exclusivo em pacientes crônicos" & vbCrLf & _
                "🎯 Algoritmos preditivos proprietários" & vbCrLf & _
                "🎯 Interface intuitiva e acessível" & vbCrLf & _
                "🎯 Conformidade com LGPD e regulamentações ANVISA" & vbCrLf & _
                "🎯 Parcerias com instituições de saúde renomadas" & vbCrLf & _
                "🎯 Suporte humanizado 24 horas"
    End With
End Sub

Private Sub AdicionarSlidePublicoAlvo(pres As Object, index As Integer)
    Dim slide As Object
    
    Set slide = pres.Slides.Add(index, 2) ' ppLayoutText
    slide.Shapes(1).TextFrame.TextRange.Text = "Público-Alvo"
    
    With slide.Shapes(2).TextFrame.TextRange
        .Text = "• Pacientes com doenças crônicas (diabetes, hipertensão, etc.)" & vbCrLf & _
                "• Idosos que necessitam de monitoramento contínuo" & vbCrLf & _
                "• Hospitais e clínicas especializadas" & vbCrLf & _
                "• Planos de saúde e operadoras" & vbCrLf & _
                "• Cuidadores e familiares de pacientes crônicos" & vbCrLf & _
                "• Profissionais de saúde (médicos, enfermeiros)"
    End With
End Sub

Private Sub AdicionarSlideEncerramento(pres As Object, index As Integer)
    Dim slide As Object
    Dim titleShape As Object
    Dim subtitleShape As Object
    
    Set slide = pres.Slides.Add(index, 1) ' ppLayoutTitle
    
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "Obrigado!"
    
    Set subtitleShape = slide.Shapes(2)
    subtitleShape.TextFrame.TextRange.Text = "MedTrack Saúde Digital" & vbCrLf & _
                                            "Juntos por uma vida mais saudável" & vbCrLf & vbCrLf & _
                                            "Contato: contato@medtrack.com.br"
End Sub
