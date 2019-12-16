class PatientModel {
  String name;
  String surname;
  String yearOfBirth;
  String height;
  String weight;

  PatientModel(
      {this.name, this.surname, this.yearOfBirth, this.height, this.weight});
}

PatientModel patientMock = PatientModel(
  name: "Mateusz",
  surname: "Waleszczynski",
  yearOfBirth: "1997",
  height: "145",
  weight: "75",
);
