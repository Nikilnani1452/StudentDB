sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'studentdb/test/integration/FirstJourney',
		'studentdb/test/integration/pages/StudentList',
		'studentdb/test/integration/pages/StudentObjectPage'
    ],
    function(JourneyRunner, opaJourney, StudentList, StudentObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('studentdb') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStudentList: StudentList,
					onTheStudentObjectPage: StudentObjectPage
                }
            },
            opaJourney.run
        );
    }
);