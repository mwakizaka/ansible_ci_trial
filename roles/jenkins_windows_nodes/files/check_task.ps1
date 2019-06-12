#
# PowerShell Script(タスクの存在を確認)
# check_task.ps1 ${タスク名}
#
Get-ScheduledTask -TaskName $args[0] | select -First 1 TaskName -ExpandProperty TaskName
