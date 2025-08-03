import React from 'react';
import CohortDetails from './CohortDetails';

function App() {
  const cohorts = [
    {
      id: "INTADMDF10",
      track: ".NET FSD",
      startDate: "22-Feb-2022",
      status: "Scheduled",
      coach: "Aathma",
      trainer: "Jojo Jose"
    },
    {
      id: "ADM21JF014",
      track: "Java FSD",
      startDate: "10-Sep-2021",
      status: "Ongoing",
      coach: "Apoorrv",
      trainer: "Elisa Smith"
    },
    {
      id: "CDBJF21025",
      track: "Java FSD",
      startDate: "24-Dec-2021",
      status: "Ongoing",
      coach: "Aathma",
      trainer: "John Doe"
    }
  ];

  return (
    <div style={{ padding: '20px' }}>
      <h2>Cohorts Details</h2>
      {cohorts.map((cohort, index) => (
        <CohortDetails key={index} cohort={cohort} />
      ))}
    </div>
  );
}

export default App;
