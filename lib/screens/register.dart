import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cjn/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _gender = 'Male';
  String? _role;
  String? _userType = 'Candidate';
  String? _selectedCountryCode = '(+213)';
  
  final List<String> _userTypes = ['Candidate', 'Viewer', 'Employer'];
  
  final List<Map<String, String>> _countryCodes = [
    {'code': '(+213)', 'country': 'Algeria', 'value': '213'},
    {'code': '(+376)', 'country': 'Andorra', 'value': '376'},
    {'code': '(+244)', 'country': 'Angola', 'value': '244'},
    {'code': '(+1264)', 'country': 'Anguilla', 'value': '1264'},
    {'code': '(+1268)', 'country': 'Antigua & Barbuda', 'value': '1268'},
    {'code': '(+54)', 'country': 'Argentina', 'value': '54'},
    {'code': '(+374)', 'country': 'Armenia', 'value': '374'},
    {'code': '(+297)', 'country': 'Aruba', 'value': '297'},
    {'code': '(+61)', 'country': 'Australia', 'value': '61'},
    {'code': '(+43)', 'country': 'Austria', 'value': '43'},
    {'code': '(+994)', 'country': 'Azerbaijan', 'value': '994'},
    {'code': '(+1242)', 'country': 'Bahamas', 'value': '1242'},
    {'code': '(+973)', 'country': 'Bahrain', 'value': '973'},
    {'code': '(+880)', 'country': 'Bangladesh', 'value': '880'},
    {'code': '(+1246)', 'country': 'Barbados', 'value': '1246'},
    {'code': '(+375)', 'country': 'Belarus', 'value': '375'},
    {'code': '(+32)', 'country': 'Belgium', 'value': '32'},
    {'code': '(+501)', 'country': 'Belize', 'value': '501'},
    {'code': '(+229)', 'country': 'Benin', 'value': '229'},
    {'code': '(+1441)', 'country': 'Bermuda', 'value': '1441'},
    {'code': '(+975)', 'country': 'Bhutan', 'value': '975'},
    {'code': '(+591)', 'country': 'Bolivia', 'value': '591'},
    {'code': '(+387)', 'country': 'Bosnia Herzegovina', 'value': '387'},
    {'code': '(+267)', 'country': 'Botswana', 'value': '267'},
    {'code': '(+55)', 'country': 'Brazil', 'value': '55'},
    {'code': '(+673)', 'country': 'Brunei', 'value': '673'},
    {'code': '(+359)', 'country': 'Bulgaria', 'value': '359'},
    {'code': '(+226)', 'country': 'Burkina Faso', 'value': '226'},
    {'code': '(+257)', 'country': 'Burundi', 'value': '257'},
    {'code': '(+855)', 'country': 'Cambodia', 'value': '855'},
    {'code': '(+237)', 'country': 'Cameroon', 'value': '237'},
    {'code': '(+1)', 'country': 'Canada', 'value': '1'},
    {'code': '(+238)', 'country': 'Cape Verde Islands', 'value': '238'},
    {'code': '(+1345)', 'country': 'Cayman Islands', 'value': '1345'},
    {'code': '(+236)', 'country': 'Central African Republic', 'value': '236'},
    {'code': '(+56)', 'country': 'Chile', 'value': '56'},
    {'code': '(+86)', 'country': 'China', 'value': '86'},
    {'code': '(+57)', 'country': 'Colombia', 'value': '57'},
    {'code': '(+269)', 'country': 'Comoros', 'value': '269'},
    {'code': '(+242)', 'country': 'Congo', 'value': '242'},
    {'code': '(+682)', 'country': 'Cook Islands', 'value': '682'},
    {'code': '(+506)', 'country': 'Costa Rica', 'value': '506'},
    {'code': '(+385)', 'country': 'Croatia', 'value': '385'},
    {'code': '(+53)', 'country': 'Cuba', 'value': '53'},
    {'code': '(+90392)', 'country': 'Cyprus North', 'value': '90392'},
    {'code': '(+357)', 'country': 'Cyprus South', 'value': '357'},
    {'code': '(+42)', 'country': 'Czech Republic', 'value': '42'},
    {'code': '(+45)', 'country': 'Denmark', 'value': '45'},
    {'code': '(+253)', 'country': 'Djibouti', 'value': '253'},
    {'code': '(+1809)', 'country': 'Dominica', 'value': '1809'},
    {'code': '(+1809)', 'country': 'Dominican Republic', 'value': '1809'},
    {'code': '(+593)', 'country': 'Ecuador', 'value': '593'},
    {'code': '(+20)', 'country': 'Egypt', 'value': '20'},
    {'code': '(+503)', 'country': 'El Salvador', 'value': '503'},
    {'code': '(+240)', 'country': 'Equatorial Guinea', 'value': '240'},
    {'code': '(+291)', 'country': 'Eritrea', 'value': '291'},
    {'code': '(+372)', 'country': 'Estonia', 'value': '372'},
    {'code': '(+251)', 'country': 'Ethiopia', 'value': '251'},
    {'code': '(+500)', 'country': 'Falkland Islands', 'value': '500'},
    {'code': '(+298)', 'country': 'Faroe Islands', 'value': '298'},
    {'code': '(+679)', 'country': 'Fiji', 'value': '679'},
    {'code': '(+358)', 'country': 'Finland', 'value': '358'},
    {'code': '(+33)', 'country': 'France', 'value': '33'},
    {'code': '(+594)', 'country': 'French Guiana', 'value': '594'},
    {'code': '(+689)', 'country': 'French Polynesia', 'value': '689'},
    {'code': '(+241)', 'country': 'Gabon', 'value': '241'},
    {'code': '(+220)', 'country': 'Gambia', 'value': '220'},
    {'code': '(+7880)', 'country': 'Georgia', 'value': '7880'},
    {'code': '(+49)', 'country': 'Germany', 'value': '49'},
    {'code': '(+233)', 'country': 'Ghana', 'value': '233'},
    {'code': '(+350)', 'country': 'Gibraltar', 'value': '350'},
    {'code': '(+30)', 'country': 'Greece', 'value': '30'},
    {'code': '(+299)', 'country': 'Greenland', 'value': '299'},
    {'code': '(+1473)', 'country': 'Grenada', 'value': '1473'},
    {'code': '(+590)', 'country': 'Guadeloupe', 'value': '590'},
    {'code': '(+671)', 'country': 'Guam', 'value': '671'},
    {'code': '(+502)', 'country': 'Guatemala', 'value': '502'},
    {'code': '(+224)', 'country': 'Guinea', 'value': '224'},
    {'code': '(+245)', 'country': 'Guinea - Bissau', 'value': '245'},
    {'code': '(+592)', 'country': 'Guyana', 'value': '592'},
    {'code': '(+509)', 'country': 'Haiti', 'value': '509'},
    {'code': '(+504)', 'country': 'Honduras', 'value': '504'},
    {'code': '(+852)', 'country': 'Hong Kong', 'value': '852'},
    {'code': '(+36)', 'country': 'Hungary', 'value': '36'},
    {'code': '(+354)', 'country': 'Iceland', 'value': '354'},
    {'code': '(+91)', 'country': 'India', 'value': '91'},
    {'code': '(+62)', 'country': 'Indonesia', 'value': '62'},
    {'code': '(+98)', 'country': 'Iran', 'value': '98'},
    {'code': '(+964)', 'country': 'Iraq', 'value': '964'},
    {'code': '(+353)', 'country': 'Ireland', 'value': '353'},
    {'code': '(+972)', 'country': 'Israel', 'value': '972'},
    {'code': '(+39)', 'country': 'Italy', 'value': '39'},
    {'code': '(+1876)', 'country': 'Jamaica', 'value': '1876'},
    {'code': '(+81)', 'country': 'Japan', 'value': '81'},
    {'code': '(+962)', 'country': 'Jordan', 'value': '962'},
    {'code': '(+7)', 'country': 'Kazakhstan', 'value': '7'},
    {'code': '(+254)', 'country': 'Kenya', 'value': '254'},
    {'code': '(+686)', 'country': 'Kiribati', 'value': '686'},
    {'code': '(+850)', 'country': 'Korea North', 'value': '850'},
    {'code': '(+82)', 'country': 'Korea South', 'value': '82'},
    {'code': '(+965)', 'country': 'Kuwait', 'value': '965'},
    {'code': '(+996)', 'country': 'Kyrgyzstan', 'value': '996'},
    {'code': '(+856)', 'country': 'Laos', 'value': '856'},
    {'code': '(+371)', 'country': 'Latvia', 'value': '371'},
    {'code': '(+961)', 'country': 'Lebanon', 'value': '961'},
    {'code': '(+266)', 'country': 'Lesotho', 'value': '266'},
    {'code': '(+231)', 'country': 'Liberia', 'value': '231'},
    {'code': '(+218)', 'country': 'Libya', 'value': '218'},
    {'code': '(+417)', 'country': 'Liechtenstein', 'value': '417'},
    {'code': '(+370)', 'country': 'Lithuania', 'value': '370'},
    {'code': '(+352)', 'country': 'Luxembourg', 'value': '352'},
    {'code': '(+853)', 'country': 'Macao', 'value': '853'},
    {'code': '(+389)', 'country': 'Macedonia', 'value': '389'},
    {'code': '(+261)', 'country': 'Madagascar', 'value': '261'},
    {'code': '(+265)', 'country': 'Malawi', 'value': '265'},
    {'code': '(+60)', 'country': 'Malaysia', 'value': '60'},
    {'code': '(+960)', 'country': 'Maldives', 'value': '960'},
    {'code': '(+223)', 'country': 'Mali', 'value': '223'},
    {'code': '(+356)', 'country': 'Malta', 'value': '356'},
    {'code': '(+692)', 'country': 'Marshall Islands', 'value': '692'},
    {'code': '(+596)', 'country': 'Martinique', 'value': '596'},
    {'code': '(+222)', 'country': 'Mauritania', 'value': '222'},
    {'code': '(+269)', 'country': 'Mayotte', 'value': '269'},
    {'code': '(+52)', 'country': 'Mexico', 'value': '52'},
    {'code': '(+691)', 'country': 'Micronesia', 'value': '691'},
    {'code': '(+373)', 'country': 'Moldova', 'value': '373'},
    {'code': '(+377)', 'country': 'Monaco', 'value': '377'},
    {'code': '(+976)', 'country': 'Mongolia', 'value': '976'},
    {'code': '(+1664)', 'country': 'Montserrat', 'value': '1664'},
    {'code': '(+212)', 'country': 'Morocco', 'value': '212'},
    {'code': '(+258)', 'country': 'Mozambique', 'value': '258'},
    {'code': '(+95)', 'country': 'Myanmar', 'value': '95'},
    {'code': '(+264)', 'country': 'Namibia', 'value': '264'},
    {'code': '(+674)', 'country': 'Nauru', 'value': '674'},
    {'code': '(+977)', 'country': 'Nepal', 'value': '977'},
    {'code': '(+31)', 'country': 'Netherlands', 'value': '31'},
    {'code': '(+687)', 'country': 'New Caledonia', 'value': '687'},
    {'code': '(+64)', 'country': 'New Zealand', 'value': '64'},
    {'code': '(+505)', 'country': 'Nicaragua', 'value': '505'},
    {'code': '(+227)', 'country': 'Niger', 'value': '227'},
    {'code': '(+234)', 'country': 'Nigeria', 'value': '234'},
    {'code': '(+683)', 'country': 'Niue', 'value': '683'},
    {'code': '(+672)', 'country': 'Norfolk Islands', 'value': '672'},
    {'code': '(+670)', 'country': 'Northern Marianas', 'value': '670'},
    {'code': '(+47)', 'country': 'Norway', 'value': '47'},
    {'code': '(+968)', 'country': 'Oman', 'value': '968'},
    {'code': '(+680)', 'country': 'Palau', 'value': '680'},
    {'code': '(+507)', 'country': 'Panama', 'value': '507'},
    {'code': '(+675)', 'country': 'Papua New Guinea', 'value': '675'},
    {'code': '(+595)', 'country': 'Paraguay', 'value': '595'},
    {'code': '(+51)', 'country': 'Peru', 'value': '51'},
    {'code': '(+63)', 'country': 'Philippines', 'value': '63'},
    {'code': '(+48)', 'country': 'Poland', 'value': '48'},
    {'code': '(+351)', 'country': 'Portugal', 'value': '351'},
    {'code': '(+1787)', 'country': 'Puerto Rico', 'value': '1787'},
    {'code': '(+974)', 'country': 'Qatar', 'value': '974'},
    {'code': '(+262)', 'country': 'Reunion', 'value': '262'},
    {'code': '(+40)', 'country': 'Romania', 'value': '40'},
    {'code': '(+7)', 'country': 'Russia', 'value': '7'},
    {'code': '(+250)', 'country': 'Rwanda', 'value': '250'},
    {'code': '(+378)', 'country': 'San Marino', 'value': '378'},
    {'code': '(+239)', 'country': 'Sao Tome & Principe', 'value': '239'},
    {'code': '(+966)', 'country': 'Saudi Arabia', 'value': '966'},
    {'code': '(+221)', 'country': 'Senegal', 'value': '221'},
    {'code': '(+381)', 'country': 'Serbia', 'value': '381'},
    {'code': '(+248)', 'country': 'Seychelles', 'value': '248'},
    {'code': '(+232)', 'country': 'Sierra Leone', 'value': '232'},
    {'code': '(+65)', 'country': 'Singapore', 'value': '65'},
    {'code': '(+421)', 'country': 'Slovak Republic', 'value': '421'},
    {'code': '(+386)', 'country': 'Slovenia', 'value': '386'},
    {'code': '(+677)', 'country': 'Solomon Islands', 'value': '677'},
    {'code': '(+252)', 'country': 'Somalia', 'value': '252'},
    {'code': '(+27)', 'country': 'South Africa', 'value': '27'},
    {'code': '(+34)', 'country': 'Spain', 'value': '34'},
    {'code': '(+94)', 'country': 'Sri Lanka', 'value': '94'},
    {'code': '(+290)', 'country': 'St. Helena', 'value': '290'},
    {'code': '(+1869)', 'country': 'St. Kitts', 'value': '1869'},
    {'code': '(+1758)', 'country': 'St. Lucia', 'value': '1758'},
    {'code': '(+249)', 'country': 'Sudan', 'value': '249'},
    {'code': '(+597)', 'country': 'Suriname', 'value': '597'},
    {'code': '(+268)', 'country': 'Swaziland', 'value': '268'},
    {'code': '(+46)', 'country': 'Sweden', 'value': '46'},
    {'code': '(+41)', 'country': 'Switzerland', 'value': '41'},
    {'code': '(+963)', 'country': 'Syria', 'value': '963'},
    {'code': '(+886)', 'country': 'Taiwan', 'value': '886'},
    {'code': '(+7)', 'country': 'Tajikstan', 'value': '7'},
    {'code': '(+66)', 'country': 'Thailand', 'value': '66'},
    {'code': '(+228)', 'country': 'Togo', 'value': '228'},
    {'code': '(+676)', 'country': 'Tonga', 'value': '676'},
    {'code': '(+1868)', 'country': 'Trinidad & Tobago', 'value': '1868'},
    {'code': '(+216)', 'country': 'Tunisia', 'value': '216'},
    {'code': '(+90)', 'country': 'Turkey', 'value': '90'},
    {'code': '(+7)', 'country': 'Turkmenistan', 'value': '7'},
    {'code': '(+993)', 'country': 'Turkmenistan', 'value': '993'},
    {'code': '(+1649)', 'country': 'Turks & Caicos Islands', 'value': '1649'},
    {'code': '(+688)', 'country': 'Tuvalu', 'value': '688'},
    {'code': '(+256)', 'country': 'Uganda', 'value': '256'},
    {'code': '(+44)', 'country': 'UK', 'value': '44'},
    {'code': '(+380)', 'country': 'Ukraine', 'value': '380'},
    {'code': '(+971)', 'country': 'United Arab Emirates', 'value': '971'},
    {'code': '(+598)', 'country': 'Uruguay', 'value': '598'},
    {'code': '(+1)', 'country': 'USA', 'value': '1'},
    {'code': '(+7)', 'country': 'Uzbekistan', 'value': '7'},
    {'code': '(+678)', 'country': 'Vanuatu', 'value': '678'},
    {'code': '(+379)', 'country': 'Vatican City', 'value': '379'},
    {'code': '(+58)', 'country': 'Venezuela', 'value': '58'},
    {'code': '(+84)', 'country': 'Vietnam', 'value': '84'},
    {'code': '(+1284)', 'country': 'Virgin Islands - British', 'value': '1284'},
    {'code': '(+1340)', 'country': 'Virgin Islands - US', 'value': '1340'},
    {'code': '(+681)', 'country': 'Wallis & Futuna', 'value': '681'},
    {'code': '(+969)', 'country': 'Yemen (North)', 'value': '969'},
    {'code': '(+967)', 'country': 'Yemen (South)', 'value': '967'},
    {'code': '(+260)', 'country': 'Zambia', 'value': '260'},
    {'code': '(+263)', 'country': 'Zimbabwe', 'value': '263'},
  ];

  final List<String> _roles = [
    'IOS Developer',
    'Android Developer',
    'Software Developer',
    'Web Developer',
    'Data Scientist',
    'AI/ML Engineer',
    'Full Stack Developer',
    'Front-end Developer',
    'Back-end Developer',
    'Cloud Engineer',
    'DevOps Engineer',
    'Game Developer',
    'Cybersecurity Analyst',
    'Database Administrator',
    'Systems Analyst',
    'Network Engineer',
    'IT Support Specialist',
    'Blockchain Developer',
    'UI/UX Designer',
    'Quality Assurance (QA) Engineer',
  ];

  // Controllers for text fields
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  final _academicYearController = TextEditingController();
  final _dobController = TextEditingController();
  final _collegeCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experienceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
    _academicYearController.dispose();
    _dobController.dispose();
    _collegeCodeController.dispose();
    _passwordController.dispose();
    _qualificationController.dispose();
    _skillsController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = Provider.of<AuthService>(context, listen: false);
    
    try {
      // Create user data map
      Map<String, dynamic> userData = {
        'name': _nameController.text,
        'phone': '${_selectedCountryCode}${_phoneController.text}',
        'gender': _gender,
        'userType': _userType,
        'role': _role,
        'department': _departmentController.text,
        'academicYear': _academicYearController.text,
        'dob': _dobController.text,
        'collegeCode': _collegeCodeController.text,
        'qualification': _qualificationController.text,
        'skills': _skillsController.text,
        'experience': _experienceController.text,
      };

      // Register user with Firebase
      bool success = await authService.registerWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
        userData: userData,
      );

      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate to home screen or login
        Navigator.pushReplacementNamed(context, '/');
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authService.errorMessage ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('USER REGISTRATION FORM'),
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: _userType,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'User Type*',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey,
                    ),
                    dropdownColor: Colors.grey[900],
                    style: const TextStyle(color: Colors.white),
                    items: _userTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                    onChanged: (value) => setState(() => _userType = value),
                    validator: (value) => value == null ? 'Please select a user type' : null,
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(_nameController, 'Candidate Name*', 'Please enter the candidate name *', required: true),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: DropdownButtonFormField<String>(
                          value: _selectedCountryCode,
                          decoration: const InputDecoration(
                            labelText: 'Country Code',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.grey,
                          ),
                          dropdownColor: Colors.grey[900],
                          style: const TextStyle(color: Colors.white),
                          items: _countryCodes.map((country) => 
                            DropdownMenuItem(
                              value: country['code'],
                              child: Text('${country['code']} ${country['country']}'),
                            )
                          ).toList(),
                          onChanged: (value) => setState(() => _selectedCountryCode = value),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(_phoneController, 'Candidate Phone*', 'Please enter the candidate phone *', required: true, keyboardType: TextInputType.phone),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(_emailController, 'Candidate Email*', 'Please enter the candidate email *', required: true, keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  const Text('Candidate Gender', style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value),
                        activeColor: Colors.blue,
                      ),
                      const Text('Male', style: TextStyle(color: Colors.white)),
                      Radio<String>(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value),
                        activeColor: Colors.blue,
                      ),
                      const Text('Female', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(_departmentController, 'Candidate Department', 'Please enter the candidate department'),
                  const SizedBox(height: 16),
                  _buildTextField(_academicYearController, 'Academic Year', 'Please enter the candidate academic year'),
                  const SizedBox(height: 16),
                  _buildTextField(_dobController, 'Candidate Date Of Birth(DOB)', 'dd/mm/yyyy', readOnly: true, onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark(),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      _dobController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                    }
                  }),
                  const SizedBox(height: 16),
                  _buildTextField(_collegeCodeController, 'College Code', 'Please enter the candidate college code'),
                  const SizedBox(height: 16),
                  _buildTextField(_passwordController, 'Password*', 'Please enter the candidate password', required: true, obscureText: true),
                  const SizedBox(height: 16),
                  _buildTextField(_qualificationController, 'Highest Qualifications', 'Please enter the highest qualification'),
                  const SizedBox(height: 16),
                  _buildTextField(_skillsController, 'Skills', 'Please enter the skills'),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _role,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Role*',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey,
                    ),
                    dropdownColor: Colors.grey[900],
                    style: const TextStyle(color: Colors.white),
                    items: _roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                    onChanged: (value) => setState(() => _role = value),
                    validator: (value) => value == null ? 'Please select a role' : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(_experienceController, 'Experience', 'Please enter the candidate experience'),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: authService.isLoading ? null : () {
                          _formKey.currentState?.reset();
                          setState(() {
                            _gender = 'Male';
                            _role = null;
                            _userType = 'Candidate';
                            _selectedCountryCode = '(+213)';
                          });
                        },
                        child: const Text('Clear'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          foregroundColor: Colors.black,
                        ),
                        onPressed: authService.isLoading ? null : _handleRegistration,
                        child: authService.isLoading 
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            )
                          : const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      validator: required
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (label.contains('Email') && !_isValidEmail(value)) {
                return 'Please enter a valid email address';
              }
              if (label.contains('Password') && !_isValidPassword(value)) {
                return 'Password must be at least 8 characters with uppercase, lowercase, and number';
              }
              return null;
            }
          : null,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 && 
           RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password);
  }
} 