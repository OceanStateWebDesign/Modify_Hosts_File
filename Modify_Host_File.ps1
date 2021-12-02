
Function MakeNewForm {

	$Form.Close()

	$Form.Dispose()

	MakeForm

}

Function MakeForm {

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$hostfile = 'c:\windows\system32\drivers\etc\hosts';


$form = New-Object System.Windows.Forms.Form
$form.Text = 'Hosts File Manager'
$form.Size = New-Object System.Drawing.Size(900,600)
$form.StartPosition = 'CenterScreen'
$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})

$txt = New-Object System.Windows.Forms.Label
$txt.Location = New-Object System.Drawing.Point(250,20)
$txt.Size = New-Object System.Drawing.Size(380,25)
$txt.Font = 'Microsoft Sans Serif,13'
$txt.Text = 'HOSTS FILE MANAGEMENT'
$form.Controls.Add($txt)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(360,125)
$label.Size = New-Object System.Drawing.Size(260,25)
$label.Font = 'Microsoft Sans Serif,10'
$label.Text = 'Add New Host:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(260,155)
$textBox.Size = New-Object System.Drawing.Size(260,100)
$textBox.Width = 350
$textBox.Height = 100
$form.Controls.Add($textBox)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(390,185)
$okButton.Size = New-Object System.Drawing.Size(75,25)
$okButton.Text = 'OK'

$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$okbutton.Add_Click(
{

[System.Windows.Forms.MessageBox]::Show("Host Added Successfully")

Add-Content -Path $hostfile -Value $textBox.Text

MakeNewForm


})


#display current host file entries
$Label03                     = New-Object system.Windows.Forms.Label
$Label03.text                = "Your Current Host File Entries"
$Label03.AutoSize            = $true
$Label03.width               = 25
$Label03.height              = 10
$Label03.location            = New-Object System.Drawing.Point(300,250)
$Label03.Font                = 'Microsoft Sans Serif,10'

$Form.Controls.Add($Label03)

$textbox03                       = New-Object system.Windows.Forms.TextBox
$textbox03.multiline                = $true
$textbox03.width                    = 600
$textbox03.height                   = 140
$textbox03.location                 = New-Object System.Drawing.Point(160,280)
$textbox03.Font                     = 'Microsoft Sans Serif,10'
$textbox03.Scrollbars = "Vertical"
$textbox03.Lines = Get-Content $hostfile | Select-String -Pattern "#" -NotMatch |  % { $_.Line } | Out-String

$Form.Controls.Add($textbox03)



$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(350,465)
$label.Size = New-Object System.Drawing.Size(200,20)
$label.Font = 'Microsoft Sans Serif,10'
$label.Text = 'Reset Hosts File'
$form.Controls.Add($label)

$resetButton = New-Object System.Windows.Forms.Button
$resetButton.Location = New-Object System.Drawing.Point(390,495)
$resetButton.Size = New-Object System.Drawing.Size(75,25)
$resetButton.Text = 'OK'

$form.AcceptButton = $resetButton
$form.Controls.Add($resetButton)

$resetbutton.Add_Click(
{

[System.Windows.Forms.MessageBox]::Show("Hosts File Reset Successfully")

Clear-Content $hostfile 

MakeNewForm


})



$result = $form.ShowDialog()



 }

 MakeForm