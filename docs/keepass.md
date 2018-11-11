# How to Set-Up Sync for Keepass

1. Backup your KeePass DB. This is synchronization and not backup tool.

1. Create new configuration folder using `config-sync-tools\create-new-item.cmd`

1. Create copy of your KeePass DB and place it to created folder

1. Upload it using `config-sync-tools\sync-upload.cmd`

1. Update following XML:

  * Change `c:\settings\` to root folder of your repository
  * Change `keepass\passwords.kdbx` to name of your config folder and 

```xml
<?xml version="1.0" encoding="utf-8"?>
<TriggerCollection xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<Triggers>
		<Trigger>
			<Guid>EYbf6svzJUC0i+rKg1cY3Q==</Guid>
			<Name>Sync</Name>
			<Events>
				<Event>
					<TypeGuid>s6j9/ngTSmqcXdW6hDqbjg==</TypeGuid>
					<Parameters>
						<Parameter>0</Parameter>
						<Parameter />
					</Parameters>
				</Event>
			</Events>
			<Conditions />
			<Actions>
				<Action>
					<TypeGuid>2uX4OwcwTBOe7y66y27kxw==</TypeGuid>
					<Parameters>
						<Parameter>c:\settings\config-sync-tools\sync-download.cmd</Parameter>
						<Parameter />
						<Parameter>True</Parameter>
						<Parameter>0</Parameter>
						<Parameter />
					</Parameters>
				</Action>
				<Action>
					<TypeGuid>tkamn96US7mbrjykfswQ6g==</TypeGuid>
					<Parameters>
						<Parameter>Sync</Parameter>
						<Parameter>0</Parameter>
					</Parameters>
				</Action>
				<Action>
					<TypeGuid>Iq135Bd4Tu2ZtFcdArOtTQ==</TypeGuid>
					<Parameters>
						<Parameter>c:\settings\local\keepass\passwords.kdbx</Parameter>
						<Parameter />
						<Parameter />
					</Parameters>
				</Action>
				<Action>
					<TypeGuid>tkamn96US7mbrjykfswQ6g==</TypeGuid>
					<Parameters>
						<Parameter>Sync</Parameter>
						<Parameter>1</Parameter>
					</Parameters>
				</Action>
				<Action>
					<TypeGuid>2uX4OwcwTBOe7y66y27kxw==</TypeGuid>
					<Parameters>
						<Parameter>c:\settings\config-sync-tools\sync-upload.cmd</Parameter>
						<Parameter />
						<Parameter>True</Parameter>
						<Parameter>0</Parameter>
						<Parameter />
					</Parameters>
				</Action>
			</Actions>
		</Trigger>
	</Triggers>
</TriggerCollection>
```
1. In KeePass add new trigger: menu Tools > Triggers > Tools > Paste Trigger from Clipboard

1. After you will save your password database, it will automatically merge it and uploads it.