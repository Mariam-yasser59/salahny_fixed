// ─── UNIFIED MODELS ───────────────────────────────────────────────────────────
// All app-wide data models. Single source of truth for both driver & workshop.

// ─── STATUS CONSTANTS ─────────────────────────────────────────────────────────
class RequestStatus {
  RequestStatus._();
  static const String pending          = 'pending';
  static const String accepted         = 'accepted';
  static const String inProgress       = 'in_progress';
  static const String diagnosticsReady = 'diagnostics_ready';
  static const String repairInProgress = 'repair_in_progress';
  static const String completed        = 'completed';
  static const String cancelled        = 'cancelled';

  static String label(String s) => switch (s) {
    pending          => 'Pending',
    accepted         => 'Accepted',
    inProgress       => 'In Progress',
    diagnosticsReady => 'Diagnostics Ready',
    repairInProgress => 'Repair In Progress',
    completed        => 'Completed',
    cancelled        => 'Cancelled',
    _                => s,
  };
}

// ─── RISK LEVEL ───────────────────────────────────────────────────────────────
class RiskLevel {
  RiskLevel._();
  static const String healthy  = 'healthy';
  static const String warning  = 'warning';
  static const String critical = 'critical';
}

// ─── USER MODEL ───────────────────────────────────────────────────────────────
class UserModel {
  final String id, name, phone, email, role;
  final double walletBalance, rating;
  final int totalBookings;
  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.role = 'driver',
    this.walletBalance = 0,
    this.rating = 0,
    this.totalBookings = 0,
  });

  static const UserModel mock = UserModel(
    id: 'u1',
    name: 'James Carter',
    phone: '+1 (555) 234-5678',
    email: 'james@example.com',
    role: 'driver',
    walletBalance: 245.0,
    totalBookings: 14,
    rating: 4.8,
  );
}

// ─── VEHICLE MODEL ────────────────────────────────────────────────────────────
class VehicleModel {
  final String id, make, model, year, plate, color, fuel;
  final double health;
  final int mileage;
  const VehicleModel({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.plate,
    required this.color,
    this.fuel = 'Gasoline',
    this.health = 85,
    this.mileage = 0,
  });

  static const List<VehicleModel> mockList = [
    VehicleModel(
      id: 'v1',
      make: 'Toyota',
      model: 'Camry',
      year: '2022',
      plate: '7XYZ 421',
      color: 'Pearl White',
      health: 83,
      mileage: 42000,
    ),
    VehicleModel(
      id: 'v2',
      make: 'Ford',
      model: 'F-150',
      year: '2020',
      plate: '9ABC 832',
      color: 'Midnight Black',
      health: 65,
      mileage: 78000,
    ),
  ];
}

// ─── SERVICE MODEL ────────────────────────────────────────────────────────────
class ServiceModel {
  final String id, name, category, description, emoji;
  final double price;
  final int durationMins;
  final bool isPopular;
  const ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.emoji,
    required this.price,
    this.durationMins = 60,
    this.isPopular = false,
  });

  static const List<ServiceModel> mockList = [
    ServiceModel(id: 's1', name: 'Oil Change',      category: 'Maintenance', description: 'Full synthetic oil change with filter replacement', emoji: '🔧', price: 89,  durationMins: 45, isPopular: true),
    ServiceModel(id: 's2', name: 'Tire Rotation',   category: 'Tires',       description: 'Rotate and balance all four tires',                 emoji: '🔄', price: 59,  durationMins: 60),
    ServiceModel(id: 's3', name: 'Air Filter',      category: 'Maintenance', description: 'Engine air filter replacement',                      emoji: '💨', price: 45,  durationMins: 30, isPopular: true),
    ServiceModel(id: 's4', name: 'Full Inspection', category: 'Inspection',  description: 'Comprehensive 150-point vehicle inspection',         emoji: '🔍', price: 149, durationMins: 90),
    ServiceModel(id: 's5', name: 'Car Wash & Detail',category: 'Cleaning',   description: 'Premium exterior & interior detailing',              emoji: '✨', price: 99,  durationMins: 120),
    ServiceModel(id: 's6', name: 'Brake Service',   category: 'Brakes',      description: 'Brake pad inspection and replacement',               emoji: '🛑', price: 199, durationMins: 90, isPopular: true),
    ServiceModel(id: 's7', name: 'AC Service',      category: 'HVAC',        description: 'AC system check, recharge, and repair',              emoji: '❄️', price: 129, durationMins: 75),
    ServiceModel(id: 's8', name: 'Battery Check',   category: 'Electrical',  description: 'Battery test and terminal cleaning',                 emoji: '🔋', price: 39,  durationMins: 30),
  ];
}

// ─── WORKSHOP MODEL ───────────────────────────────────────────────────────────
class WorkshopModel {
  final String id, name, address, phone, specialty;
  final double rating, distance;
  final int reviews, jobsDone;
  final bool isOpen, isVerified;
  const WorkshopModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.specialty,
    required this.rating,
    required this.distance,
    this.reviews = 0,
    this.jobsDone = 0,
    this.isOpen = true,
    this.isVerified = false,
  });

  static const List<WorkshopModel> mockList = [
    WorkshopModel(id: 'w1', name: 'ProTech Auto Center',  address: '142 Maple Ave, Downtown', phone: '+1 555 010 1234', specialty: 'Full Service',        rating: 4.9, distance: 0.8, reviews: 312, jobsDone: 1820, isOpen: true,  isVerified: true),
    WorkshopModel(id: 'w2', name: 'Speed Kings Garage',   address: '78 Oak Street, Midtown',  phone: '+1 555 020 5678', specialty: 'Performance & Tuning', rating: 4.7, distance: 2.1, reviews: 198, jobsDone: 940,  isOpen: true,  isVerified: true),
    WorkshopModel(id: 'w3', name: 'QuickFix Motors',       address: '33 Pine Rd, Uptown',      phone: '+1 555 030 9012', specialty: 'Tires & Brakes',       rating: 4.5, distance: 3.4, reviews: 87,  jobsDone: 430,  isOpen: false),
  ];
}

// ─── BOOKING / REQUEST MODEL ──────────────────────────────────────────────────
class BookingModel {
  final String id, serviceId, serviceName, workshopId, workshopName, vehicleId;
  final String status, date, time;
  final double price, progress;
  final String? customerName, customerPhone, vehicleInfo, diagnosticId;
  const BookingModel({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.workshopId,
    required this.workshopName,
    required this.vehicleId,
    required this.status,
    required this.date,
    required this.time,
    required this.price,
    this.progress = 0.0,
    this.customerName,
    this.customerPhone,
    this.vehicleInfo,
    this.diagnosticId,
  });

  static const List<BookingModel> mockList = [
    BookingModel(id: 'b1', serviceId: 's1', serviceName: 'Oil Change',      workshopId: 'w1', workshopName: 'ProTech Auto', vehicleId: 'v1', status: RequestStatus.inProgress, date: 'Dec 22, 2024', time: '10:00 AM', price: 89,  progress: 0.55, customerName: 'James Carter', customerPhone: '+1 (555) 234-5678', vehicleInfo: 'Toyota Camry 2022'),
    BookingModel(id: 'b2', serviceId: 's6', serviceName: 'Brake Service',   workshopId: 'w2', workshopName: 'Speed Kings',  vehicleId: 'v1', status: RequestStatus.completed,  date: 'Nov 14, 2024', time: '2:00 PM',  price: 199, progress: 1.0,  customerName: 'James Carter', customerPhone: '+1 (555) 234-5678', vehicleInfo: 'Toyota Camry 2022'),
    BookingModel(id: 'b3', serviceId: 's4', serviceName: 'Full Inspection', workshopId: 'w1', workshopName: 'ProTech Auto', vehicleId: 'v2', status: RequestStatus.cancelled,  date: 'Oct 5, 2024',  time: '11:00 AM', price: 149, customerName: 'James Carter', customerPhone: '+1 (555) 234-5678', vehicleInfo: 'Ford F-150 2020'),
    BookingModel(id: 'b4', serviceId: 's2', serviceName: 'Tire Rotation',   workshopId: 'w3', workshopName: 'QuickFix',     vehicleId: 'v2', status: RequestStatus.pending,    date: 'Dec 28, 2024', time: '9:00 AM',  price: 59,  customerName: 'Sara Ahmed',   customerPhone: '+20 101 987 6543', vehicleInfo: 'Ford F-150 2020'),
    BookingModel(id: 'b5', serviceId: 's3', serviceName: 'Air Filter',      workshopId: 'w1', workshopName: 'ProTech Auto', vehicleId: 'v1', status: RequestStatus.accepted,   date: 'Dec 29, 2024', time: '11:30 AM', price: 45,  customerName: 'Michael Torres', customerPhone: '+1 (555) 876-5432', vehicleInfo: 'BMW X3 2020'),
  ];
}

// ─── OBD VITAL ────────────────────────────────────────────────────────────────
class OBDVital {
  final String key, unit;
  final double value;
  const OBDVital({required this.key, required this.unit, required this.value});
}

// ─── OBD FAULT CODE ───────────────────────────────────────────────────────────
class OBDFaultCode {
  final String code, description, severity;
  const OBDFaultCode({
    required this.code,
    required this.description,
    this.severity = RiskLevel.warning,
  });
}

// ─── AI PREDICTION ────────────────────────────────────────────────────────────
class AIPrediction {
  final String issue, technicalNote, recommendedFix, repairCategory, urgency;
  final double confidence;
  const AIPrediction({
    required this.issue,
    required this.technicalNote,
    required this.recommendedFix,
    required this.repairCategory,
    required this.urgency,
    required this.confidence,
  });
}

// ─── DIAGNOSTIC REPORT ────────────────────────────────────────────────────────
class DiagnosticReport {
  final String id, vehicleId, date, summary, riskLevel;
  final double health;
  final List<OBDFaultCode> faultCodes;
  final List<OBDVital> vitals;
  final List<String> recommendations;
  final AIPrediction? aiPrediction;
  final String? attachedRequestId;

  const DiagnosticReport({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.summary,
    required this.riskLevel,
    required this.health,
    required this.faultCodes,
    required this.vitals,
    required this.recommendations,
    this.aiPrediction,
    this.attachedRequestId,
  });

  static const DiagnosticReport mock = DiagnosticReport(
    id: 'd1',
    vehicleId: 'v1',
    date: 'Dec 18, 2024',
    summary: 'Good overall condition with minor issues detected',
    riskLevel: RiskLevel.warning,
    health: 83,
    faultCodes: [
      OBDFaultCode(code: 'P0420', description: 'Catalyst Efficiency Below Threshold', severity: RiskLevel.warning),
      OBDFaultCode(code: 'P0171', description: 'System Too Lean (Bank 1)',             severity: RiskLevel.warning),
    ],
    vitals: [
      OBDVital(key: 'Engine Temp',   unit: '°C', value: 87),
      OBDVital(key: 'Oil Pressure',  unit: 'psi', value: 78),
      OBDVital(key: 'Battery',       unit: 'V',   value: 92),
      OBDVital(key: 'Tire Pressure', unit: 'psi', value: 68),
      OBDVital(key: 'Fuel Level',    unit: '%',   value: 54),
      OBDVital(key: 'Coolant',       unit: '%',   value: 90),
    ],
    recommendations: [
      'Schedule exhaust system inspection soon',
      'Replace air filter within 1,000 miles',
      'Check oxygen sensor readings',
    ],
    aiPrediction: AIPrediction(
      issue: 'Catalytic Converter Degradation',
      technicalNote: 'OBD code P0420 indicates the catalytic converter is not operating within expected efficiency thresholds. P0171 lean condition may be causing incomplete combustion contributing to the fault.',
      recommendedFix: 'Inspect and replace catalytic converter. Check for exhaust leaks and O2 sensor functionality.',
      repairCategory: 'Exhaust System',
      urgency: RiskLevel.warning,
      confidence: 0.87,
    ),
  );

  static const List<DiagnosticReport> mockHistory = [
    DiagnosticReport(
      id: 'd1', vehicleId: 'v1', date: 'Dec 18, 2024',
      summary: 'Minor exhaust system issue detected',
      riskLevel: RiskLevel.warning, health: 83,
      faultCodes: [OBDFaultCode(code: 'P0420', description: 'Catalyst Efficiency Below Threshold')],
      vitals: [OBDVital(key: 'Engine Temp', unit: '°C', value: 87)],
      recommendations: ['Schedule exhaust inspection'],
    ),
    DiagnosticReport(
      id: 'd2', vehicleId: 'v1', date: 'Nov 5, 2024',
      summary: 'Healthy — no faults detected',
      riskLevel: RiskLevel.healthy, health: 96,
      faultCodes: [], vitals: [],
      recommendations: ['Routine maintenance on schedule'],
    ),
    DiagnosticReport(
      id: 'd3', vehicleId: 'v2', date: 'Oct 12, 2024',
      summary: 'Critical battery and brake issues',
      riskLevel: RiskLevel.critical, health: 51,
      faultCodes: [
        OBDFaultCode(code: 'C0031', description: 'Left Front Wheel Speed Sensor Circuit', severity: RiskLevel.critical),
        OBDFaultCode(code: 'U0100', description: 'Lost Communication With ECM/PCM',       severity: RiskLevel.critical),
      ],
      vitals: [OBDVital(key: 'Battery', unit: 'V', value: 34)],
      recommendations: ['Immediate brake inspection required', 'Replace battery immediately'],
    ),
  ];
}

// ─── LEGACY COMPATIBILITY (used by existing screens) ──────────────────────────
class DiagnosticModel {
  final String id, vehicleId, date, summary;
  final double health;
  final List<String> codes, recommendations;
  final Map<String, double> vitals;
  const DiagnosticModel({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.summary,
    required this.health,
    required this.codes,
    required this.recommendations,
    required this.vitals,
  });

  static const DiagnosticModel mock = DiagnosticModel(
    id: 'd1', vehicleId: 'v1', date: 'Dec 18, 2024',
    summary: 'Good overall condition with minor issues',
    health: 83,
    codes: ['P0420 — Catalyst Efficiency Below Threshold', 'P0171 — System Too Lean (Bank 1)'],
    recommendations: ['Schedule exhaust inspection', 'Replace air filter within 1,000 miles', 'Check O2 sensors'],
    vitals: {'Engine Temp': 87, 'Oil Pressure': 78, 'Battery': 92, 'Tire Pressure': 68},
  );
}

// ─── PACKAGE MODEL ────────────────────────────────────────────────────────────
class PackageModel {
  final String id, name, tagline, duration;
  final double price, originalPrice;
  final List<String> features;
  final bool isPopular;
  const PackageModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.duration,
    required this.price,
    required this.originalPrice,
    required this.features,
    this.isPopular = false,
  });

  static const List<PackageModel> mockList = [
    PackageModel(id: 'p1', name: 'Basic',   tagline: 'Perfect for 1 vehicle',    duration: 'month',    price: 29,  originalPrice: 49,  features: ['Monthly checkup', '10% service discount', 'WhatsApp support', '2 emergency calls']),
    PackageModel(id: 'p2', name: 'Premium', tagline: 'Best for families',         duration: '3 months', price: 79,  originalPrice: 129, features: ['Weekly checkup', '25% discount', '24/7 priority support', '5 emergency calls', 'Free monthly wash', 'Full diagnostic report'], isPopular: true),
    PackageModel(id: 'p3', name: 'Fleet',   tagline: 'For businesses & fleets',   duration: 'year',     price: 599, originalPrice: 899, features: ['Daily monitoring', '40% discount', 'Dedicated manager', 'Unlimited emergency', 'Self-service bay', 'Custom reports', 'API integration']),
  ];
}

// ─── NOTIFICATION MODEL ───────────────────────────────────────────────────────
class NotificationModel {
  final String id, title, body, type;
  final DateTime time;
  final bool isRead;
  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.time,
    this.isRead = false,
  });
}

// ─── CHAT MESSAGE ─────────────────────────────────────────────────────────────
class ChatMessage {
  final String id, text, senderId;
  final DateTime time;
  final bool isMe;
  const ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.time,
    this.isMe = false,
  });
}

// ─── WORKSHOP BOOKING DATA (workshop module internal) ────────────────────────
class WsBookingData {
  final String id, serviceName, customerName, customerPhone, vehicleInfo;
  final String date, time, status;
  final double price, progress;
  final String? attachedDiagnosticId;

  const WsBookingData({
    required this.id,
    required this.serviceName,
    required this.customerName,
    required this.customerPhone,
    required this.vehicleInfo,
    required this.date,
    required this.time,
    required this.price,
    required this.status,
    this.progress = 0.0,
    this.attachedDiagnosticId,
  });
}

// ─── WORKSHOP SERVICE ITEM ────────────────────────────────────────────────────
class WsServiceItem {
  final String emoji, name;
  final int durationMins;
  final double price;
  const WsServiceItem({
    required this.emoji,
    required this.name,
    required this.durationMins,
    required this.price,
  });
}

// ─── WORKSHOP PAYOUT ──────────────────────────────────────────────────────────
class WsPayoutData {
  final String period;
  final double amount;
  const WsPayoutData({required this.period, required this.amount});
}

// ─── WORKSHOP MOCK DATA ───────────────────────────────────────────────────────
class WsMock {
  WsMock._();

  static const List<WsBookingData> bookings = [
    WsBookingData(id: 'b001', serviceName: 'Oil Change',         customerName: 'James Carter',   customerPhone: '+1 (555) 234-5678', vehicleInfo: 'Toyota Camry 2022',    date: 'Dec 22', time: '10:00 AM', price: 85,  status: RequestStatus.pending),
    WsBookingData(id: 'b002', serviceName: 'Brake Check',        customerName: 'Sara Ahmed',     customerPhone: '+20 101 987 6543',  vehicleInfo: 'Hyundai Elantra 2021', date: 'Dec 22', time: '12:30 PM', price: 120, status: RequestStatus.pending),
    WsBookingData(id: 'b003', serviceName: 'Engine Diagnostics', customerName: 'Michael Torres', customerPhone: '+1 (555) 876-5432', vehicleInfo: 'BMW X3 2020',          date: 'Dec 22', time: '09:00 AM', price: 200, status: RequestStatus.inProgress, progress: 0.6),
    WsBookingData(id: 'b004', serviceName: 'Tire Rotation',      customerName: 'Lena Hoffman',   customerPhone: '+49 170 123 4567',  vehicleInfo: 'Nissan Sunny 2023',    date: 'Dec 22', time: '11:00 AM', price: 65,  status: RequestStatus.inProgress, progress: 0.35),
    WsBookingData(id: 'b005', serviceName: 'Battery Service',    customerName: 'Omar Khalil',    customerPhone: '+20 100 555 4321',  vehicleInfo: 'Kia Sportage 2022',    date: 'Dec 21', time: '02:15 PM', price: 95,  status: RequestStatus.completed,  progress: 1.0),
    WsBookingData(id: 'b006', serviceName: 'AC Service',         customerName: 'Anna Lee',       customerPhone: '+1 (555) 987-6543', vehicleInfo: 'Honda Civic 2021',     date: 'Dec 23', time: '01:00 PM', price: 180, status: RequestStatus.accepted),
  ];

  static const List<WsServiceItem> services = [
    WsServiceItem(emoji: '🛢️', name: 'Oil Change',         durationMins: 30,  price: 85),
    WsServiceItem(emoji: '🔧', name: 'Engine Diagnostics', durationMins: 60,  price: 200),
    WsServiceItem(emoji: '🛞', name: 'Tire Rotation',      durationMins: 45,  price: 65),
    WsServiceItem(emoji: '🔋', name: 'Battery Service',    durationMins: 20,  price: 95),
    WsServiceItem(emoji: '🚿', name: 'Full Wash & Detail', durationMins: 90,  price: 150),
    WsServiceItem(emoji: '❄️', name: 'AC Service',         durationMins: 60,  price: 180),
  ];

  static const List<WsPayoutData> payouts = [
    WsPayoutData(period: 'Dec 15 – Dec 21', amount: 1800),
    WsPayoutData(period: 'Dec 8 – Dec 14',  amount: 1600),
    WsPayoutData(period: 'Dec 1 – Dec 7',   amount: 2050),
    WsPayoutData(period: 'Nov 24 – Nov 30', amount: 1950),
  ];
}
