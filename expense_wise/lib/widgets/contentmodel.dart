class UnboardingContent{

  String image;
  String title;
  String description;

  UnboardingContent({required this.description,required this.image,required this.title});

}
List<UnboardingContent> contents=[

  UnboardingContent(
    description:"select from \n    Best Menu  ",
    image :"images/expense1.png",

    title:"Manage expenses\n      on-the-go",
  ),

  UnboardingContent(
    description:"Take control of \n      your money",
    image :"images/expense2.png",

    title:"Effortlessly monitor your spending habits.",
  ),

  UnboardingContent(
    description:"Budget better,  \n     live smarter",
    image :"images/expense3.png",

    title:"Achieve financial peace\n      of mind",
  ),

];