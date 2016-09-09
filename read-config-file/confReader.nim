import os, strutils, tables

proc readConfig(fileName: string): Table[string, string] =
  let
    inputFile = readFile(fileName)

  result = initTable[string, string]()

  for line in inputFile.splitLines:
    if line.len < 1 or line.startsWith("#") : continue #ignoring empty line or commented out
    var chunkData = split(line, '=')
    if chunkData.len != 2 :
      quit("invalid config file, see at : " & line)
    result[chunkData[0]] = chunkData[1]

  if result.len < 1 : quit("empty config file")

proc getFile(): string =
  var fileName = paramStr(1)
  if os.isAbsolute(fileName):
    return fileName
  else:
    return os.getCurrentDir() & "/" & fileName

proc isFileExist(pth: string): bool = return os.existsFile(pth)

when isMainModule:
  var absPathFile = getFile()
  if not isFileExist(absPathFile):
    quit("file not exist")
  else:
    var listVar = readConfig(absPathFile)
    echo listVar
