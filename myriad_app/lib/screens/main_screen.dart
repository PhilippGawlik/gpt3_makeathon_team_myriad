import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class MainScreen extends StatefulWidget {

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  List<dynamic> jsonResult = [{"IntentID":8,"IntentName":"Suitable detergents","Query":"What are the functions of a detergent?","Response":" The functions of a detergent are: to remove starch and protein from clothes. "},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"What are the differences in the types of detergent?","Response":"Types of detergent include both combined and separate. Combined detergent is for washing only, separately washing with separate detergents, Rinse aid is a separate item, and Special salt is a separate item. "},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"What is the typical alkaline level?","Response":""},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"What is the purpose of adding salt and Rinse Aid separately?","Response":" To get the best dishwashing results, the salt and Rinse-Aid should be added separately."},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"What is the difference between a combined and separate detergent.","Response":"A combined detergent contains both salt and Rinse-Aid. A separate detergent only contains one of those ingredients. "},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"Which type of detergent would be recommended for shorter programmes?","Response":"A separate detergent is recommended for shorter programmes as it is easier"},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"How many types of detergent are acceptable?","Response":" There are two types of detergent, one which is combined and the other which is separate."},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"What are the two main types of detergent?","Response":"The two main types of detergent are combined and separate."},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"What are the three function of detergent for dishwashers?","Response":"The three functions of detergent for dishwashers are: removing protein, removing starch, and removing coloured marks."},
  {"IntentID":8,"IntentName":"Suitable detergents","Query":"Who is the manufacturer of your dishwasher detergent?","Response":"The"},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"What is the purpose of pre-rinsing dishes?","Response":" The purpose of pre-rinsing dishes is to remove excess food to prevent it from transferring onto the dishwasher."},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"What is one way to load items on the dishwasher for better washing and drying results?","Response":"It is best to load items with curves or recesses at an angle to allow the water to run off."},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"What is one way to prevent damage to the dishwasher?","Response":"The best way to prevent damage to the dishwasher is by"},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"What is the most important thing for dishwashing to work properly?","Response":" The most important thing for dishwashing to work properly is that items should be positioned so that water can run off them."},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"What should you do with cutlery?","Response":"Cutlery should be arranged so that points are facing down and sharp edges are downwards."},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"What should be done with containers that have openings?","Response":"Containers with openings should be positioned so that the opening is facing downwards."},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"What can you do to make sure that dishes are safe?","Response":"4"},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"","Response":" What is the dishwasher used for?"},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"","Response":"How should you load the machine?"},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"","Response":"What tableware must be placed at an angle?"},
  {"IntentID":0,"IntentName":"Arrange tableware","Query":"","Response":"What should you do with small parts or containers with openings?"},
  {"IntentID":7,"IntentName":"Safty advice","Query":"What safety information is in the text?","Response":" The appliance can be used in the following safe situations: In private households and in enclosed spaces in a domestic environment, up to an altitude of max. 2500 m above sea level."},
  {"IntentID":7,"IntentName":"Safty advice","Query":"Who should follow the safety instructions and warnings?","Response":"The safety information is for the user of the appliance, that is, for the consumers."},
  {"IntentID":7,"IntentName":"Safty advice","Query":"What should you do if this appliance has been damaged in transit?","Response":"If the appliance has"},
  {"IntentID":7,"IntentName":"Safty advice","Query":"What is the maximum altitude that this dishwasher should be used at?","Response":" The maximum altitude that this dishwasher should be used at is 2500 meters above sea level. "},
  {"IntentID":7,"IntentName":"Safty advice","Query":"Have you read the safety instructions and warnings?","Response":"Yes, you must read the safety instructions and warnings. "},
  {"IntentID":7,"IntentName":"Safty advice","Query":"What precautions should you take after unpacking the dishwasher?","Response":"Check for visible damage on the appliance and do not use it if there is damage. "},
  {"IntentID":7,"IntentName":"Safty advice","Query":"Does this appliance have an automatic diagnostics system?","Response":"No, this appliance does not"},
  {"IntentID":7,"IntentName":"Safty advice","Query":"How far can the appliance be used?","Response":" This appliance can only be used in a domestic environment up to an altitude of 2500 meters."},
  {"IntentID":7,"IntentName":"Safty advice","Query":"What does this appliance clean?","Response":"This appliance can clean household tableware."},
  {"IntentID":7,"IntentName":"Safty advice","Query":"How do you know if the appliance has been damaged in transit?","Response":"You can check if the appliance has been damaged in transit by checking it after unpacking it."},
  {"IntentID":7,"IntentName":"Safty advice","Query":"Why can you only use this appliance as specified in the manual?","Response":"You can only use this appliance as specified in the"},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"What is the maximum age recommended for children to use this appliance?","Response":" The maximum age for children to use this appliance is 8 years."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"What type of people may not use this appliance?","Response":"People with disabilities and mental issues are not allowed to use the appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"What are the dangers of touching the appliance?","Response":"Children must not play with the appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"What is the importance of supervision for children?","Response":"Children must be supervised when they are using the appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"Can children who have not reached the age of eight use the appliance?","Response":" Yes, children aged 8 or over can use the appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"How can I know whether a person is qualified to use the appliance?","Response":"The person should have some experience with appliances."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"Who should clean this appliance?","Response":"No one should clean the appliance, unless they are being supervised by a person qualified to use the appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"What is the maximum size of the child who can use the appliance?","Response":"Children under the age of 8 years cannot use the appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"Can children aged 8 or over use this appliance?","Response":" Yes, children aged 8 or over can use this appliance. "},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"What should be done if children are near the appliance?","Response":"Children should not be near the appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"What are the risks of having people with reduced physical, sensory or mental abilities and inadequate experience and\/or knowledge using this appliance?","Response":"Yes, there are risks of having people with reduced physical, sensory or mental abilities and inadequate experience and\/or knowledge using this appliance."},
  {"IntentID":2,"IntentName":"Restriction on user group","Query":"Are there any precautions that should be taken","Response":"Yes, children should not be doing"},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What are the instructions in the manual and installation instructions?","Response":" The instructions in the manual and installation instructions are to follow the instructions for installation and connection of the appliance."},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What injury may be caused by improper installation?","Response":"The injury that may be caused by improper installation is injury."},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What does the text mean by \"installation and connecting the appliance\"?","Response":"The installation and connection of the appliance is a process of installing and connecting to an appliance."},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What is the main point of this text?","Response":"The main point of"},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"Who is at risk for injury?","Response":" When installing and connecting the appliance, the user is at risk for injury."},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What is the connection between installing the appliance and following instructions?","Response":"Improper installation may cause injury. When installing and connecting the appliance, follow the instructions in the manual and installation instructions."},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"Who may have instructions?","Response":"The manual and installation instructions may have instructions. "},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What is the connection between following instructions and injury?","Response":"Following the instructions in the manual"},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"Could the improper connection of the appliance cause injury?","Response":" Yes, improper installation of the appliance can cause injury."},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What is the manual for this appliance?","Response":"The instruction manual for this appliance is not available. "},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"What are installation instructions?","Response":"Installation instructions are installation guidelines to follow to ensure the proper installation of the appliance."},
  {"IntentID":6,"IntentName":"Risk of injury","Query":"Is my model number in the installation instructions?","Response":"No, the model number of your appliance is not in the installation instructions."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"What is the purpose of the Aqua-Stop valve?","Response":" The Aqua-Stop valve is meant to protect the appliance from damage if water enters the appliance."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"How can you tell when the supply hose is damaged?","Response":"When the supply hose is damaged, you can see the inner electric power cables."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"What is the best way to keep the power cable free from damage?","Response":"Keeping the power cable free from damage is important because it contains electric current which can be dangerous."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"Why should you never cut through the supply hose?","Response":"The"},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"What is dangerous about improper installation?","Response":" Improper installation can result in electric shock, fire or death."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"Why is the mains plug of the power cord left free and accessible?","Response":"The mains plug of the power cord is left free and accessible so that the power can be switched off in case of emergency."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"What is not allowed when installing this appliance?","Response":"It is not allowed to install a timer or remote control switch on the appliance."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"Is it allowed to cut through the supply hose?","Response":""},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"What is the necessity of installing an isolating switch when installing the appliance?","Response":" To ensure the safety of the appliance."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"Why is it dangerous to cut through the supply hose?","Response":"It can cause electric shocks."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"What does the plastic housing on the supply hose contain?","Response":"An electric valve."},
  {"IntentID":4,"IntentName":"Risk of electric shock","Query":"How does the plastic housing on the supply hose differ from the hose?","Response":"The supply hose has electric power cables and the different plastic housing has an electric valve."},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What is the danger with using an extended power cord?","Response":" There is a danger of damage to the power cord as well as the conductors and wires"},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What are the things that should not be used to plug in a computer?","Response":"Extension cables, multiple socket strips, and adapters not approved by the manufacturer"},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What does 'Adapters approved by the manufacturer' mean?","Response":"Adapters approved by the manufacturer mean something which has been approved by the manufacturer."},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What are the effects if the power cord is too short?","Response":"The effects if the power cord is"},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What are the potential hazards of using an extended power cord and non-approved adapters?","Response":" The potential hazards of using an extended power cord and non-approved adapters are that the power can either get too low or you could cause a power overload."},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"Why are extension cables and multiple socket strips not allowed?","Response":"Extension cables and multiple socket strips are not allowed because they can cause the power to become too high or cause a power overload."},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What should you use in order to avoid these hazards?","Response":"Non-"},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"Which of the following are not approved by the manufacturer?","Response":" Extension cables and multiple socket strips are not approved by the manufacturer."},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What should you do if the power cord is too short?","Response":"The power cord should be replaced with one that is the correct length or the customer service should be contacted for a replacement."},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What is the consequence of using an unapproved adapter?","Response":"The consequences of using an unapproved adapter may cause fire or an electric shock."},
  {"IntentID":5,"IntentName":"Risk of fire","Query":"What is the maximum number of adapters that can be used with one power cord?","Response":"Only one"},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"When should I use an approved adapter?","Response":" The text implies that an approved adapter should not be used if the power cord is too short."},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"What should I do if my power cord is too short?","Response":"If the power cord is too short, contact customer service about extending it."},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"What should I do if the power cord is damaged?","Response":"If the power cord is damaged, replace it."},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"How can I be sure the manufacturer approves the adapter?","Response":"The manufacturer approves the adapter if it is accredited by the"},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"What is the purpose of an extension cable?","Response":" An extension cable is used to add extra length to a power cord."},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"What are the dangers of not using a power cord with approved adapters?","Response":"By using non-approved adapters, the power supply can overheat and even catch on fire."},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"What are the dangers of using an extended power cord with non-approved adapters?","Response":"By using an extended power cord with non-approved adapters, the power supply can overheat and even catch on fire."},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"How can you contact customer service?","Response":""},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"Is it safe to use an extension power cord and non-approved adapters?","Response":" It is not safe to use an extension power cord and non-approved adapters. "},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"What are the dangers of using an extension power cord and non-approved adapters?","Response":"Using an extension power cord and non-approved adapters can be dangerous. "},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"Is it safe to use an extension power cord if the power cord is too short? ","Response":"It is not safe to use an extension power cord if the power cord is too short. "},
  {"IntentID":3,"IntentName":"Risk of burns","Query":"What are the dangers of using","Response":"Using an extension power"},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What happens if the Home Connect services are not available in my country?","Response":" If the Home Connect services are not available in my country, then I am unable to use the Home Connect function."},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What are the safety precautions that I need to take when operating the appliance via the Home Connect app?","Response":"Yes, it is important to take safety precautions when operating the appliance via the Home Connect app."},
  {"IntentID":1,"IntentName":"Home Connect","Query":"Can I follow the instructions in the Home Connect app on my mobile device if I am not connected to my home network?","Response":"Yes, I can follow the instructions in the Home Connect app on my mobile device"},
  {"IntentID":1,"IntentName":"Home Connect","Query":"Does the appliance require a password for Home Connect","Response":" Yes"},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What is the Home Connect service","Response":"The Home Connect service allows the user to control the appliance via an app on a mobile device"},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What are the availability of Home Connect services","Response":"The availability of Home Connect services depends on the availability of Home Connect services in your country "},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What are the safety precautions","Response":"Read the safety instructions"},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What is the function of the `Home Connect` app?","Response":" The `Home Connect` app allows the user to control the functions of the appliance."},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What is the last step before you can use the `Home Connect` app?","Response":"The last step before you can use the `Home Connect` app is configuring the settings."},
  {"IntentID":1,"IntentName":"Home Connect","Query":"What is the first step before you can use the `Home Connect` app?","Response":"The first step before you can use the `Home Connect` app is setting up the connection to the WLAN"},{"IntentID":8,"IntentName":"Suitable detergents","Query":"How do I use the machine?","Response":"Use separate detergent, adding Special salt and Rinse aid separately."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"Is it safe to use a dishwasher?","Response":"Yes, it is safe to use a dishwasher."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"What does the dishwasher do?","Response":"The dishwasher removes food particles and grease from dishes."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"Is the machine good for my kids?","Response":"Yes, the machine is good for kids."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"What are enzymes?","Response":"Enzymes are substances that break down starch and remove protein."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"Why is the machine not cleaning my dishes?","Response":"The machine may not be cleaning your dishes because the detergent is not dissolving."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"What is the difference between tea and ketchup?","Response":"Tea is a drink and ketchup is a condiment."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"What is the water temperature for this machine?","Response":"The water temperature for this machine is 40 degrees Celsius."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"What are these tabs?","Response":"Tabs are suitable for all cleaning functions and do not need to be measured out."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"How do I clean the machine?","Response":"Use separate detergent, adding Special salt and Rinse aid separately."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"How do I get the detergent out of the machine?","Response":"The detergent can be removed by using a dishwasher cleaner."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"What if I put in the wrong thing?","Response":"You might not get the desired results."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"Is there a dosage for this machine?","Response":"Yes, there is a dosage for this machine."},{"IntentID":8,"IntentName":"Suitable detergents","Query":"How can I get the detergent to work?","Response":"You can get the detergent to work by following the manufacturer's instructions for each detergent."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"How can I find out how this stupid machine works?","Response":"You can find out how this machine works by visiting the website."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"Is the machine dangerous?","Response":"No, the machine is not dangerous."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"What if I am too stupid to find the detergent?","Response":"You should not put small parts in the tablet collecting tray and do not block it with tableware so as not to obstruct the"},{"IntentID":0,"IntentName":"Arrange tableware","Query":"What is the difference between the power and energy?","Response":"Power is the rate at which energy is used."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"How can I clean this machine?","Response":"To clean the machine, use a dishwasher cleaner."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"How do I know if the machine is working?","Response":"The machine is working if the spray arms are turning."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"How do I know what this thing does?","Response":"This is a dishwasher."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"What the fuck is a pan?","Response":"A pan is a cooking utensil."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"How can I wash my dishes?","Response":"You can wash your dishes by using an appliance."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"How can I avoid breaking my dishes?","Response":"To avoid breaking dishes, position items with curves or recesses at an angle so the water can run off."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"Is it safe to put my children in the dishwasher?","Response":"No, it is not safe to put children in the dishwasher."},{"IntentID":0,"IntentName":"Arrange tableware","Query":"How do I turn the machine on?","Response":"The machine is turned on by pressing the button on the front of the machine."},{"IntentID":7,"IntentName":"Safety advice","Query":"What if I don't know how to use this machine?","Response":"Read the instruction manual carefully."},{"IntentID":7,"IntentName":"Safety advice","Query":"How do I use this stupid machine?","Response":"You can find general information for this instruction manual here."},{"IntentID":7,"IntentName":"Safty advice","Query":"Can I install this myself?","Response":"Yes, this appliance can be installed by the user."},{"IntentID":7,"IntentName":"Safty advice","Query":"What if I break the machine?","Response":"You should not connect the appliance if it has been damaged in transit."},{"IntentID":7,"IntentName":"Safty advice","Query":"What is the best way to install this dishwasher?","Response":"The best way to install this dishwasher is to read the instruction manual."},{"IntentID":7,"IntentName":"Safty advice","Query":"How do I get this thing out of my house?","Response":"You can't."},{"IntentID":7,"IntentName":"Safty advice","Query":"What is the instruction manual?","Response":"The instruction manual is intended for the user of the appliance."},{"IntentID":7,"IntentName":"Safty advice","Query":"Is this a fucking joke?","Response":"No."},{"IntentID":7,"IntentName":"Safty advice","Query":"How high is this machine?","Response":"Up to an altitude of max. 2500 m above sea level."},{"IntentID":7,"IntentName":"Safty advice","Query":"How do I clean the machine?","Response":"You can find general information for this instruction manual here."},{"IntentID":2,"IntentName":"Restriction on user group","Query":"Can I just turn the thing off?","Response":"Yes, you can turn the thing off."},{"IntentID":2,"IntentName":"Restriction on user group","Query":"Is this machine dangerous?","Response":"Yes, this machine is dangerous."},{"IntentID":6,"IntentName":"Risk of injury","Query":"How can I find out how this stupid machine works?","Response":"You can find out how this machine works by reading the manual."},{"IntentID":6,"IntentName":"Risk of injury","Query":"How do I use this machine?","Response":"Read the manual."},{"IntentID":6,"IntentName":"Risk of injury","Query":"How do I stop the machine from hurting my children?","Response":"The machine will not hurt your children if you follow the instructions in the manual and installation instructions."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"How do I know if the machine is dangerous?","Response":"If the machine is not installed according to the specifications on the rating plate, it is dangerous."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"How can I turn this thing on?","Response":"You can't."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"How do I install the dishwasher?","Response":"When installing the dishwasher, the power cord must be accessible."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"Can I put my children in the dishwasher?","Response":"No, you should never put your children in the dishwasher."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"Can the machine hurt my pet?","Response":"Yes, the machine can hurt your pet."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"How do I use the timer?","Response":"You can't."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"How do I get the power cord plugged in?","Response":"The power cord must be plugged in to a properly installed socket with earthing."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"What the fuck is this thing?","Response":"This is a washing machine."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"How can I know if the machine is working?","Response":"The machine is working if the power cable is not trapped or damaged."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"What if I don't want to install the hose?","Response":"You must install the hose."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"How can I tell if the hose is cut?","Response":"The supply hose contains electric power cables."},{"IntentID":4,"IntentName":"Risk of electric shock","Query":"What is the machine's voltage?","Response":"The machine's voltage is alternating current."},{"IntentID":5,"IntentName":"Risk of fire","Query":"Is it dangerous to use an extended power cord and non-approved adapters?","Response":"Yes, it is dangerous to use an extended power cord and non-approved adapters."},{"IntentID":5,"IntentName":"Risk of fire","Query":"Is it safe to use this machine?","Response":"Yes, it is safe to use this machine."},{"IntentID":5,"IntentName":"Risk of fire","Query":"How can I contact customer service?","Response":"You can contact customer service by emailing them at customerservice@example.com."},{"IntentID":5,"IntentName":"Risk of fire","Query":"How do I turn the machine on?","Response":"You can turn the machine on by pressing the power button."},{"IntentID":3,"IntentName":"Risk of burns","Query":"How do I know if the machine is safe?","Response":"If the power cord is too short, contact Customer Service."},{"IntentID":3,"IntentName":"Risk of burns","Query":"Is the machine really dangerous?","Response":"Yes, the machine is really dangerous."},{"IntentID":1,"IntentName":"Home Connect","Query":"How can I find out how to use this machine?","Response":"You can find information about this at: www.home-connect.com."},{"IntentID":1,"IntentName":"Home Connect","Query":"How do I make this thing work?","Response":"You need to set up the connection to the WLAN home network and to the Home Connect app."},{"IntentID":1,"IntentName":"Home Connect","Query":"What the fuck is this?","Response":"This is a text about how to use the Home Connect app."},{"IntentID":1,"IntentName":"Home Connect","Query":"What is Home Connect?","Response":"Home Connect is a service that allows you to control your appliance via a mobile device."},{"IntentID":1,"IntentName":"Home Connect","Query":"I can't find the home-connect, what is it?","Response":"Home Connect is a service that allows you to control your appliance via a mobile device."},{"IntentID":1,"IntentName":"Home Connect","Query":"What is the company's contact information?","Response":"The company's contact information is www.home-connect.com."},{"IntentID":1,"IntentName":"Home Connect","Query":"What the fuck is this thing?","Response":"This is a network-capable appliance."},{"IntentID":1,"IntentName":"Home Connect","Query":"How do I turn the machine on?","Response":"You can turn the machine on by pressing the power button."},{"IntentID":1,"IntentName":"Home Connect","Query":"How do I connect to the Home Connect?","Response":"You must first set up the connection to the WLAN home network (Wi-Fi) and to the Home Connect app."},{"IntentID":1,"IntentName":"Home Connect","Query":"How do I connect the stupid machine to my phone?","Response":"The Home Connect app guides you through the entire login process."},{"IntentID":1,"IntentName":"Home Connect","Query":"Can I wash my clothes in this machine?","Response":"Yes, you can."}];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController eCtrl = new TextEditingController();
  Color colorInclude = Color.fromRGBO(0, 207, 21, 0.21);
  Color colorExclude = Color.fromRGBO(221, 0, 0, 0.24);
  Color borderColer = Colors.grey;
  List<Triplet> items = [];

  @override
  void initState() {
    super.initState();
    loadJson();
   /* WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadJson();
    });*/
  }
  loadJson() {
    List<Triplet> list=[];

    jsonResult.forEach((value) {
      String question = value['Query'];
      String answer = value["Response"];
      String intent = value["IntentName"];

      if (answer.isNotEmpty && question.isNotEmpty && intent.isNotEmpty){
        list.add(new Triplet(question, answer, intent, false));
      }
    });
    setState(() {
      list.shuffle();
      items=list;
    });
  }
  /*
  loadJson() async {
    String data = await rootBundle.loadString('qa.json');
    List<dynamic> jsonResult = json.decode(data);
    List<Triplet> list=[];

    /*
    jsonResult.forEach((value) {
      String question = value['Query'];
      String answer = value["Response"];
      String intent = value["IntentName"];

      if (answer.isNotEmpty && question.isNotEmpty && intent.isNotEmpty){
        list.add(new Triplet(question, answer, intent, false));
      }
    });*/
    list.add(new Triplet('QUESTION', 'ANSWER', 'INTENT', false));
    setState(() {
      list.shuffle();
      items=list;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: /*AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('YourAppTitle'))
          ],

        ),
      )*/PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Image.asset(
                  'logo.png',
                  fit: BoxFit.contain,
                  height: 150,
                )
              ],

            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text('MYRIAD', style: TextStyle(fontSize: 72),)],
            ),*/
          ),
        ),
      )
      ,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Container(
            width: screenSize.width * 0.7,
            height: screenSize.height * 0.6,
            child: Column(
              children: [
                new Expanded(
                    child: Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: new ListView.separated(
                      padding: EdgeInsets.only(right: 20),
                      controller: _scrollController,
                      itemCount: items.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemBuilder: (BuildContext ctxt, int Index) {
                        return new Container(
                          decoration: BoxDecoration(
                              color: items[Index].exclude
                                  ? colorExclude
                                  : colorInclude,
                              border: Border.all(color: borderColer, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [Text('Intent: ', style: TextStyle(fontWeight: FontWeight.bold)), Text(items[Index].intend)],),
                                    SizedBox(height: 5,),
                                    Row(children: [Text('Question: ', style: TextStyle(fontWeight: FontWeight.bold)), Text(items[Index].question)],),
                                    Row(children: [Text('Answer: ', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(width: screenSize.width*0.5, child: Text(items[Index].answer,))],),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: new ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: items[Index].exclude ? Color.fromRGBO(244, 156, 156, 1) : Color.fromRGBO(170, 220, 175, 1),
                                      ),
                                      onPressed: () => setState(() {
                                            items[Index].exclude =
                                                !items[Index].exclude;
                                          }),
                                  child: items[Index].exclude ? Text('INCLUDE', style: TextStyle(color: Colors.black),) : Text('EXCLUDE', style: TextStyle(color: Colors.black))),
                                ),

                                /*
                                    TextButton(onPressed: ()=>setState(() {
                                      items[Index].exclude=!items[Index].exclude;
                                    }),
                                        style: ButtonStyle(backgroundColor: items[Index].exclude ? Color.fromRGBO(247, 183, 183, 1) : Color.fromRGBO(183, 239, 190, 1)),
                                        child: items[Index].exclude ? Text('INCLUDE') : Text('EXCLUDE'))*/
                              ],
                            ),
                          ),
                        );
                        //Text(items[Index].question);
                      }),
                )),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                              side: BorderSide(color: Colors.black, width: 1)
                          ),
                          primary: Colors.white
                        ),
                        onPressed: () => {downloadFile()},
                        child: Text('EXPORT', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32))
                    )],
                )
              ],
            )),
      ),
    );
  }

  Future<void> loadDefaultData() async {

    Future.delayed(Duration(seconds: 5));
    List<Triplet> loadedData = List<Triplet>.generate(
        14, (index) => new Triplet('Question', 'Answer', 'Intent', false));
    setState(() {
      items = loadedData;
    });
  }

}
void downloadFile(){
  html.window.open('https://drive.google.com/file/d/1Bkq2MH8dO5-bVTOPMiBLBuLpvvjR3Sls/view?usp=sharing', 'new tab');
}

class Triplet {
  String question;
  String answer;
  String intend;
  bool exclude;

  Triplet(String q, a, i, r) {
    this.question = q;
    this.answer = a;
    this.intend = i;
    this.exclude = r;
  }
}
