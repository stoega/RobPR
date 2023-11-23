MODULE Module1
        CONST robtarget Target_10:=[[550,-100,340],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[700,-100,340],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_40:=[[700,100,340],[0,0,1,0],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30:=[[550,100,340],[0,0,1,0],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_50:=[[300,150,340],[0,0,1,0],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!***********************************************************
    !
    ! Modul:  Module1
    !
    ! Beschreibung:
    !   <Fuegen Sie hier eine Beschreibung ein>
    !
    ! Autor: Flo
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Prozedur main
    !
    !   Dies ist die Startroutine 'main', die den Ablauf der Task steuert.
    !
    !***********************************************************
    PROC main()
        !Add your code here
        Path_10;
    ENDPROC
    PROC Path_10()
        MoveL Target_10,v1000,z100,MyTool\WObj:=table;
        MoveL Target_20,v80,fine,MyTool\WObj:=table;
        MoveL Target_40,v1000,z100,MyTool\WObj:=table;
        MoveL Target_30,v1000,z100,MyTool\WObj:=table;
        MoveL Target_50,v1000,z100,MyTool\WObj:=table;
    ENDPROC
ENDMODULE