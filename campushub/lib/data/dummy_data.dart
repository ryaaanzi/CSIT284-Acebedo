import 'package:flutter/material.dart';

import 'package:campushub/models/activity.dart';
import 'package:campushub/models/activity_category.dart';

const availableCategories = [
  ActivityCategory(
    id: 'c1',
    title: 'Technology',
    color: Colors.blue,
  ),
  ActivityCategory(
    id: 'c2',
    title: 'Research',
    color: Colors.purple,
  ),
  ActivityCategory(
    id: 'c3',
    title: 'Competition',
    color: Colors.red,
  ),
  ActivityCategory(
    id: 'c4',
    title: 'Career',
    color: Colors.orange,
  ),
  ActivityCategory(
    id: 'c5',
    title: 'Leadership',
    color: Colors.green,
  ),
  ActivityCategory(
    id: 'c6',
    title: 'Community',
    color: Colors.teal,
  ),
];

const dummyActivities = [
  Activity(
    id: 'a1',
    categories: [
      'c1',
      'c3',
    ],
    title: 'Flutter Mobile Development Workshop',
    imageUrl:
        'https://images.unsplash.com/photo-1555066931-4365d14bab8c',
    description:
        'A hands-on workshop introducing Flutter application development.',
    venue: 'GLE202',
    duration: 180,
    skillLevel: SkillLevel.beginner,
    requirements: [
      'Laptop',
      'Flutter SDK Installed',
      'VS Code or Android Studio',
    ],
    benefits: [
      'Learn Flutter basics',
      'Build your first mobile app',
      'Certificate of Participation',
    ],
  ),

  Activity(
    id: 'a2',
    categories: [
      'c2',
    ],
    title: 'Research Writing Seminar',
    imageUrl:
        'https://images.unsplash.com/photo-1455390582262-044cdead277a',
    description:
        'Learn the fundamentals of academic and technical research writing.',
    venue: 'Library AVR',
    duration: 120,
    skillLevel: SkillLevel.beginner,
    requirements: [
      'Notebook',
      'Pen',
    ],
    benefits: [
      'Improve research skills',
      'Understand publication requirements',
      'Certificate',
    ],
  ),

  Activity(
    id: 'a3',
    categories: [
      'c1',
      'c3',
    ],
    title: 'Campus Hackathon 2026',
    imageUrl:
        'https://images.unsplash.com/photo-1515879218367-8466d910aaa4',
    description:
        'A 12-hour coding competition where teams build innovative solutions.',
    venue: 'Innovation Center',
    duration: 720,
    skillLevel: SkillLevel.advanced,
    requirements: [
      'Team of 3-5 members',
      'Laptop',
      'Valid Student ID',
    ],
    benefits: [
      'Cash prizes',
      'Industry exposure',
      'Networking opportunities',
    ],
  ),

  Activity(
    id: 'a4',
    categories: [
      'c4',
    ],
    title: 'Resume and Interview Bootcamp',
    imageUrl:
        'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d',
    description:
        'Prepare for internships and employment opportunities.',
    venue: 'Career Center',
    duration: 90,
    skillLevel: SkillLevel.beginner,
    requirements: [
      'Updated Resume',
    ],
    benefits: [
      'Resume feedback',
      'Mock interviews',
      'Career guidance',
    ],
  ),

  Activity(
    id: 'a5',
    categories: [
      'c5',
      'c6',
    ],
    title: 'Student Leadership Camp',
    imageUrl:
        'https://images.unsplash.com/photo-1522202176988-66273c2fd55f',
    description:
        'Develop leadership, teamwork, and communication skills.',
    venue: 'Camp Marina',
    duration: 480,
    skillLevel: SkillLevel.intermediate,
    requirements: [
      'Student Organization Membership',
      'Consent Form',
    ],
    benefits: [
      'Leadership training',
      'Team-building activities',
      'Networking',
    ],
  ),

  Activity(
    id: 'a6',
    categories: [
      'c1',
    ],
    title: 'Artificial Intelligence Workshop',
    imageUrl:
        'https://images.unsplash.com/photo-1677442135136-760c813028c0',
    description:
        'Introduction to machine learning and generative AI concepts.',
    venue: 'Computer Laboratory 3',
    duration: 180,
    skillLevel: SkillLevel.intermediate,
    requirements: [
      'Laptop',
      'Python Installed',
    ],
    benefits: [
      'Hands-on AI activities',
      'Practical machine learning experience',
    ],
  ),

  Activity(
    id: 'a7',
    categories: [
      'c2',
      'c4',
    ],
    title: 'Undergraduate Research Forum',
    imageUrl:
        'https://images.unsplash.com/photo-1517048676732-d65bc937f952',
    description:
        'Students present completed research projects and findings.',
    venue: 'University Auditorium',
    duration: 240,
    skillLevel: SkillLevel.intermediate,
    requirements: [
      'Research Paper',
      'Presentation Slides',
    ],
    benefits: [
      'Research dissemination',
      'Academic recognition',
    ],
  ),

  Activity(
    id: 'a8',
    categories: [
      'c3',
    ],
    title: 'Huawei ICT Competition Training',
    imageUrl:
        'https://images.unsplash.com/photo-1516321318423-f06f85e504b3',
    description:
        'Intensive preparation for networking and cloud competitions.',
    venue: 'Networking Laboratory',
    duration: 300,
    skillLevel: SkillLevel.advanced,
    requirements: [
      'Networking Fundamentals',
      'Laptop',
    ],
    benefits: [
      'Competition preparation',
      'Certification opportunities',
    ],
  ),

  Activity(
    id: 'a9',
    categories: [
      'c6',
    ],
    title: 'Community Outreach Program',
    imageUrl:
        'https://images.unsplash.com/photo-1559027615-cd4628902d4a',
    description:
        'Volunteer activities aimed at helping local communities.',
    venue: 'Partner Barangay',
    duration: 360,
    skillLevel: SkillLevel.beginner,
    requirements: [
      'Volunteer Registration',
    ],
    benefits: [
      'Community service experience',
      'Volunteer certificate',
    ],
  ),

  Activity(
    id: 'a10',
    categories: [
      'c1',
      'c4',
    ],
    title: 'Cybersecurity Career Talk',
    imageUrl:
        'https://images.unsplash.com/photo-1563986768609-322da13575f3',
    description:
        'Industry experts share cybersecurity trends and career paths.',
    venue: 'Engineering Theater',
    duration: 120,
    skillLevel: SkillLevel.beginner,
    requirements: [],
    benefits: [
      'Career insights',
      'Industry networking',
    ],
  ),
];