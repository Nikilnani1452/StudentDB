namespace com.satinfotech.studentdb;
using { managed, cuid } from '@sap/cds/common';

@assert.unique:{
    stid:[stid]
}

entity Student: cuid, managed {
    @title: 'Student ID'
    stid: String(10);
    @title: 'Gender'
    gender: String(1);
    @title: 'First Name'
    fname: String(30) @mandatory;
    @title: 'Last Name'
    lname: String(30) @mandatory;
    @title: 'Email'
    email: String(80) @mandatory;
    @title: 'PAN No'
    pan_no: String(10) @mandatory;
    @title: 'Date of Birth'
    dob: Date @mandatory;
    @title: 'Course'
    course: Association to Courses;
    @title: 'Languages Known'
    Languages: Composition of many {
        key ID: UUID;
        lang: Association to Languages;
    }
    @title: 'Age'
    virtual age: Integer @Core.Computed;
    @title: 'Is Alumni'
    is_alumni: Boolean default false;
}

@cds.persistence.skip
entity Gender {
    @title: 'code'
    key code: String(1);
    @title: 'Description'
    description: String(10);
}

entity Courses: cuid, managed {
    @title: 'Code'
    code: String(3);
    @title: 'Description'
    description: String(50);
    @title: 'Books'
    Books: Composition of many {
        key ID: UUID;
        book: Association to Books;
    }
}

entity Languages: cuid, managed {
    @title: 'Code'
    code: String(2);
    @title: 'Description'
    description: String(20);
}

entity Books: cuid, managed {
    @title: 'Name'
    code: String(30);
    @title: 'Author'
    author: String(30);
    @title: 'Description'
    description: String(100);
}