namespace db;

using {
    managed,
    User,
    sap.common.CodeList
} from '@sap/cds/common';

entity Employee : managed {
    key empID          : String(10) not null;
        empFName       : String(30) not null;
        empLName       : String(30) not null;
        department     : String(20) not null;
        empManagerID   : String(10);
        leavesEntitled : Integer;
}

entity LeaveRequest : managed {
    key leaveID                   : UUID                       @(Core.Computed : true);
        empID                     : Association to Employee;
        startDate                 : Date not null;
        endDate                   : Date not null;
        noOfDays                  : Integer;
        requestcomments           : String(250);
        approvalRejectionStatus   : Association to LeaveStatus @readonly;
        approvalRejectionComments : String(250);
        virtual ApproveEnabled    : Boolean;
        virtual RejectEnabled     : Boolean;
}

entity LeaveStatus : CodeList {
    key code        : String enum {
            Approved = 'A';
            Rejected = 'R';
            New      = 'X';
        } default 'X';
        criticality : Integer; //  2: yellow colour,  3: green colour, 1: red
//fieldControl            : Integer @odata.Type : 'Edm.Byte'; // 1: #ReadOnly, 7: #Mandatory
//createDeleteHidden      : Boolean;
//insertDeleteRestriction : Boolean; // = NOT createDeleteHidden
}
