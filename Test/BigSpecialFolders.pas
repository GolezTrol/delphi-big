unit BigSpecialFolders;

interface

uses
  Windows, KnownFolders;

type
  TBigKnownFolder = (
    bkfDocuments,
    bkfPublicDocuments,
    bkfLocalAppData,
    bkfRoamingAppData,
    bkfCommonAppData );

type
  TBigKnownFolderId = record
    KnownFolderId: TGuid;
    CSIDL: Integer;
    LegacyPath: string;
  end;

function BigTryGetSpecialFolder(Folder: TBigSpecialFolder);

implementation

end.
