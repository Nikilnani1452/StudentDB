using { com.satinfotech.studentdb as db } from '../db/schema';

service studentDB {
    entity Student as projection on db.Student;
    entity Gender as projection on db.Gender;
    entity Books as projection on db.Books{
        @UI.Hidden
        ID,
        *
    };
    entity Courses as projection on db.Courses{
        @UI.Hidden: true
        ID,
        *
    };
    entity Languages as projection on db.Languages{
        @UI.Hidden
        ID,
        *
    };
}

annotate studentDB.Student with @odata.draft.enabled;
annotate studentDB.Courses with @odata.draft.enabled;
annotate studentDB.Languages with @odata.draft.enabled;
//annotate studentDB.Books with @odata.draft.enabled;


annotate studentDB.Student with {
    stid @assert.format: '^[a-zA-Z0-9]{2,}$';
    fname @assert.format: '^[a-zA-Z]{2,}$';
    lname @assert.format: '^[a-zA-Z]{2,}$';
    email @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    pan_no @assert.format: '[A-Z]{5}[0-9]{4}[A-Z]{1}';
    //telephone @assert.format: '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
}

annotate studentDB.Books with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: author
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Books : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value: author,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksFacet',
            Label : 'Books',
            Target : '@UI.FieldGroup#Books',
        },
    ],

);

annotate studentDB.Courses.Books with @(
    UI.LineItem:[
        {
            Label: 'Books',
            Value: book_ID
        },
      
    ],
    UI.FieldGroup #CourseBooks : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : book_ID,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksFacet',
            Label : 'Books',
            Target : '@UI.FieldGroup#CourseBooks',
        },
    ],
);

annotate studentDB.Student.Languages with @(
    UI.LineItem:[
        {
            Label: 'Languages',
            Value: lang_ID
        },
      
    ],
    UI.FieldGroup #StudentLanguages : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : lang_ID,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LanguagesFacet',
            Label : 'Languages',
            Target : '@UI.FieldGroup#StudentLanguages',
        },
    ],
);

annotate studentDB.Languages with @(
    UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
     UI.FieldGroup #Languages : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LanguagesFacet',
            Label : 'Languages',
            Target : '@UI.FieldGroup#Languages',
        },
    ],

);

annotate studentDB.Courses with @(
    UI.LineItem: [
        {
            Value : code
        },
        {
            Value : description
        },
        {
            Label: 'Books',
            Value : Books.book.description
        },
    ],
    UI.FieldGroup #CourseInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                Value : code,
            },
            {
                Value : description,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#CourseInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksFacet',
            Label : 'Books Information',
            Target : 'Books/@UI.LineItem',
        },
        
    ],
);

annotate studentDB.Gender with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : code   
        },
        {
            $Type : 'UI.DataField',
            Value : description
        },
    ]
);

annotate studentDB.Student with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : stid
        },
        {
            $Type : 'UI.DataField',
            Label: 'Gender',
            Value : gender
        },
        {
            $Type : 'UI.DataField',
            Value : fname
        },
        {
            $Type : 'UI.DataField',
            Value : lname
        },
        {
            $Type : 'UI.DataField',
            Value : email
        },
        {
            $Type : 'UI.DataField',
            Value : pan_no
        },
        {
            $Type : 'UI.DataField',
            Value : dob
        },
        {
            $Type : 'UI.DataField',
            Value : age
        },
        {
            Value : course.code
        },
        {
            Value: is_alumni
        },
    ],
    UI.SelectionFields: [ stid, fname, lname, email, pan_no, dob, age],       
    UI.FieldGroup #StudentInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : stid,
            },
            {
                $Type : 'UI.DataField',
                Label: 'Gender',
                Value : gender
            },
            {
                $Type : 'UI.DataField',
                Value : fname,
            },
            {
                $Type : 'UI.DataField',
                Value : lname,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Value : pan_no
            },
            {
                $Type : 'UI.DataField',
                Value : dob,
            },
            {
                $Type: 'UI.DataField',
                Value: course_ID
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentInfoFacet',
            Label : 'Student Information',
            Target : '@UI.FieldGroup#StudentInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'StudentLanguagesFacet',
            Label : 'Student Languages Information',
            Target : 'Languages/@UI.LineItem',
        },
    ],
    
);

annotate studentDB.Student.Languages with {
    lang @(
        Common.Text: lang.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Languages',
            CollectionPath : 'Languages',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : lang_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}

annotate studentDB.Student with {
    gender @(     
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Genders',
            CollectionPath : 'Gender',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : gender,
                    ValueListProperty : 'code',
                },
               
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                }
            ]
        }
    );
    course @(
        Common.Text: course.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Courses',
            CollectionPath : 'Courses',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : course_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                   {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    )
};

annotate studentDB.Courses.Books with {
    book @(
        Common.Text: book.code,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Books',
            CollectionPath : 'Books',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : book_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'author'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
}