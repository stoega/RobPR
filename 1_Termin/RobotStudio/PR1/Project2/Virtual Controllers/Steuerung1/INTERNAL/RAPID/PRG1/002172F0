MODULE Module1
    CONST robtarget Target_10:=[[300,-600,50],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_11:=[[300,-600,200],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[300,-900,50],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_21:=[[300,-900,200],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30:=[[0,-600,50],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_31:=[[0,-600,200],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_40:=[[0,-900,50],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_41:=[[0,-900,200],[0,1,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_50:=[[650,415.688,470],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_51:=[[650,415.688,570],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_70:=[[650,-334.312,670],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
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
        MoveL Target_70,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_11,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_10,v100,fine,Servo\WObj:=wobj0;
        MoveL Target_11,v1000,z100,Servo\WObj:=wobj0;
        Abladen;
        MoveL Target_21,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_20,v100,fine,Servo\WObj:=wobj0;
        MoveL Target_21,v1000,z100,Servo\WObj:=wobj0;
        Abladen;
        MoveL Target_31,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_30,v100,fine,Servo\WObj:=wobj0;
        MoveL Target_31,v1000,z100,Servo\WObj:=wobj0;
        Abladen;
        MoveL Target_41,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_40,v100,fine,Servo\WObj:=wobj0;
        MoveL Target_41,v1000,z100,Servo\WObj:=wobj0;
        Abladen;
    ENDPROC
    
    PROC Abladen()
        MoveL Target_70,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_51,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_50,v100,fine,Servo\WObj:=wobj0;
        MoveL Target_51,v1000,z100,Servo\WObj:=wobj0;
        MoveL Target_70,v1000,z100,Servo\WObj:=wobj0;
    ENDPROC
ENDMODULE