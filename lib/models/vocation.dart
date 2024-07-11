enum Vocation {
  raider(
    title: "Terminal Raider",
    description: "Adept in terminal commands to trigger traps.",
    weapon: "Terminal",
    ability: "Shellshock",
    image: "terminal_raider.jpg",
  ),
  junkie(
    title: "Code Junkie",
    description: "Uses code to infiltrate enemy defenses.",
    weapon: "React 99",
    ability: "Higher Order Overdrive",
    image: "code_junkie.jpg",
  ),
  ninja(
    title: "UX Ninja",
    description: "Uses quick & stealthy visual attacks",
    weapon: "Infused Stylus",
    ability: "Tripple Swipe",
    image: "ux_ninja.jpg",
  ),
  wizard(
    title: "Algo Wizard",
    description: "Carries a staff to unleash algorithmic magic.",
    weapon: "Crystal Staff",
    ability: "Algorithmic Daze",
    image: "algo_wizard.jpg",
  );

  const Vocation(
      {required this.title,
      required this.description,
      required this.image,
      required this.weapon,
      required this.ability});

  final String title;
  final String description;
  final String image;
  final String weapon;
  final String ability;
}
