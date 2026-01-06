#define AppName "Tesseract-OCR"
#define AppVersion "dev"
#define InstallDir "D:\Tesseract-OCR"

[Setup]
AppName={#AppName}
AppVersion={#AppVersion}
DefaultDirName={#InstallDir}
PrivilegesRequired=lowest
OutputDir=output
OutputBaseFilename=tesseract-installer
Compression=lzma2
SolidCompression=yes

[Files]
Source: "..\dist_runtime\*"; DestDir: "{app}"; Flags: recursesubdirs createallsubdirs

[Code]
procedure AddPathUser(Path: string);
var
  S: string;
begin
  if RegQueryStringValue(HKCU, 'Environment', 'Path', S) then
  begin
    if Pos(LowerCase(Path), LowerCase(S)) = 0 then
      RegWriteStringValue(HKCU, 'Environment', 'Path', S + ';' + Path);
  end
  else
    RegWriteStringValue(HKCU, 'Environment', 'Path', Path);
end;

procedure CurStepChanged(Step: TSetupStep);
begin
  if Step = ssPostInstall then
    AddPathUser(ExpandConstant('{app}'));
end;
