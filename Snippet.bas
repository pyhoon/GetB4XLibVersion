B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
Sub Process_Globals
	
End Sub

' Reads the version from a .b4xlib file (B4A / B4J)
Public Sub GetB4XLibVersion (LibPath As String) As String
	Dim jZip As JavaObject
	jZip.InitializeNewInstance("java.util.zip.ZipFile", Array(LibPath))
	Dim ZipEntry As JavaObject = jZip.RunMethod("getEntry", Array("manifest.txt"))
	If ZipEntry.IsInitialized Then
		Dim jInputStream As JavaObject = jZip.RunMethod("getInputStream", Array(ZipEntry))
		Dim b() As Byte = Bit.InputStreamToBytes(jInputStream)
		Dim txt As String = BytesToString(b, 0, b.Length, "utf8")
		Dim lines() As String = Regex.Split(CRLF, txt)
		For Each line As String In lines
			If line.StartsWith("Version=") Then
				Return line.SubString(8) ' Extract version number
			End If
		Next
	End If
	Return "Unknown"
End Sub