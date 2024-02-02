// String? datecurrent;
// int step = 1;
// String aadharClientId = "";
// String contracts = "";
// String aadharVerified = "";
//
// List<String> stateist = ["Select State"],
//     districtList = ["Select District"],
//     postOfficeList = ["Select Post Office"],
//     genderList = ["Select Gender", "Male", "Female"],
//     titleList = ["Mr.", "Mrs.", "Ms.", "M/s"],
//     careOfTitleList = ["S/O", "D/O", "W/O"],
//     professionList = [
//       "Salaried",
//       "Professional",
//       "Business",
//       "Student",
//       "House Wife",
//       "Other",
//     ],
//     maritalStatusList = ["Single", "Married"],
//     companyTypeList = [
//       "LLP",
//       "Partnership Firm",
//       "HUF",
//       "Society",
//       "Co-Operative Society",
//       "Independent Firm"
//     ],
//     proofTypeList = [
//       "Aadhar Card",
//       "Passport",
//       "Driving License",
//       "Voter ID",
//     ],
//     nomineeRelation = [
//       "Select Nominee Relation",
//       "Husband",
//       "Wife",
//       "Father",
//       "Mother",
//       "Brother",
//       "Sister",
//       "Uncle",
//       "Aunt",
//       "Son",
//       "Daughter",
//       "Father-in-law",
//       "Mother-in-law",
//       "Sister-in-law",
//       "Partner",
//       "Proprietor"
//     ];
//
// String
//    selectedTitle = 'Mr.',
//    selectedCareOfTitle = 'S/O',
//    selectedState = 'Select State',
//    selectedDistrict = 'Select District',
//    selectedCompanyType = 'LLP',
//    selectedProofType = 'Aadhar Card',
//    selectedPostOffice = 'Select Post Office',
//    selectedGender = "Male",
//    selectedProfession = 'Salaried',
//    selectedMaritalStatus = 'Single',
//    selectedNomineeRelation = 'Select Nominee Relation';
//
// TextEditingController dojController = TextEditingController();
// TextEditingController registration_typeController = TextEditingController();
// TextEditingController nameController = TextEditingController();
// TextEditingController fatherNameController = TextEditingController();
// TextEditingController mobileController = TextEditingController();
// TextEditingController emailController = TextEditingController();
// TextEditingController address1Controller = TextEditingController();
// TextEditingController address2Controller = TextEditingController();
// TextEditingController stateController = TextEditingController();
// TextEditingController cityController = TextEditingController();
// TextEditingController landmarkController = TextEditingController();
// TextEditingController pincodeController = TextEditingController();
// TextEditingController phoneController = TextEditingController();
// TextEditingController dobController = TextEditingController();
// TextEditingController nomineeNameController = TextEditingController();
// TextEditingController nomineeDobController = TextEditingController();
// TextEditingController panNoController = TextEditingController();
// TextEditingController panNameController = TextEditingController();
// TextEditingController aadharNoController = TextEditingController();
// TextEditingController kycOtpController = TextEditingController();
// TextEditingController gstNoController = TextEditingController();
// TextEditingController cinNoController = TextEditingController();
// TextEditingController fssaiNoController = TextEditingController();
// TextEditingController accountHolderNameController =
// TextEditingController();
// TextEditingController ifscController = TextEditingController();
// TextEditingController bankNameController = TextEditingController();
// TextEditingController branchNameController = TextEditingController();
// TextEditingController acNoController = TextEditingController();
// TextEditingController confirmAcNoController = TextEditingController();
// TextEditingController sponsorIdController = TextEditingController();
// TextEditingController sponsorNameController = TextEditingController();
// TextEditingController verifyOtpController = TextEditingController();
//
// final firstFormKey = new GlobalKey<FormState>();
// final secondFormKey = new GlobalKey<FormState>();
// final thirdFormKey = new GlobalKey<FormState>();
// final fourthFormKey = new GlobalKey<FormState>();
// final fifthFormKey = new GlobalKey<FormState>();
// final sixthFormKey = new GlobalKey<FormState>();
// final seventhFormKey = new GlobalKey<FormState>();
// final kycFormKey = new GlobalKey<FormState>();
// final kyc_otpFormKey = new GlobalKey<FormState>();
// final panFormKey = new GlobalKey<FormState>();
// final sponsorFormKey = new GlobalKey<FormState>();
//
// var skipBankDetail = false;
// var skipPanDetail = false;
// var checkDocPan = false;
// var acNoVerify = false;
// var panVerify = false;
// var sponsorIdVerify = false;
//
// var showCompanyType = false;
// var showKycVerifyOtp = false;
// var showKycVerifyManual = false;
//
// int isRadioSelected = 0;
// bool sponsoridEnable = true;
// String? memberName;
//
// final ImagePicker _picker = ImagePicker();
// XFile? kycFrontImage, kycBackImage, bankImage;
// int seletecdKycImage = 0;
//
// WebViewController? Controller;
//
// ScrollController scrollController = ScrollController();
//
// LoadingDialog? pr;