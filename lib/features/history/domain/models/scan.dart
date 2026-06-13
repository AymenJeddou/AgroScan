enum SyncStatus {
  synced,
  pendingInsert,
  pendingDelete;

  static SyncStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'synced':
        return SyncStatus.synced;
      case 'pending_delete':
      case 'pendingdelete':
        return SyncStatus.pendingDelete;
      case 'pending_insert':
      case 'pendinginsert':
      default:
        return SyncStatus.pendingInsert;
    }
  }

  String toMapString() {
    switch (this) {
      case SyncStatus.synced:
        return 'synced';
      case SyncStatus.pendingDelete:
        return 'pending_delete';
      case SyncStatus.pendingInsert:
        return 'pending_insert';
    }
  }
}

class Scan {
  final String id;
  final String? userId;
  final String? pestId;
  final String cropType;
  final String? notes;
  final String imageLocalPath;
  final String? imageRemoteUrl;
  final double confidenceScore;
  final DateTime createdAt;
  final SyncStatus syncStatus;

  const Scan({
    required this.id,
    this.userId,
    this.pestId,
    required this.cropType,
    this.notes,
    required this.imageLocalPath,
    this.imageRemoteUrl,
    required this.confidenceScore,
    required this.createdAt,
    required this.syncStatus,
  });

  factory Scan.fromJson(Map<String, dynamic> json) {
    return Scan(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      pestId: json['pest_id'] as String?,
      cropType: json['crop_type'] as String,
      notes: json['notes'] as String?,
      imageLocalPath: json['image_local_path'] as String,
      imageRemoteUrl: json['image_remote_url'] as String?,
      confidenceScore: (json['confidence_score'] as num).toDouble(),
      createdAt: json['created_at'] is String 
          ? DateTime.parse(json['created_at'] as String) 
          : json['created_at'] as DateTime,
      syncStatus: SyncStatus.fromString(json['sync_status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'pest_id': pestId,
      'crop_type': cropType,
      'notes': notes,
      'image_local_path': imageLocalPath,
      'image_remote_url': imageRemoteUrl,
      'confidence_score': confidenceScore,
      'created_at': createdAt.toIso8601String(),
      'sync_status': syncStatus.toMapString(),
    };
  }

  Scan copyWith({
    String? id,
    String? userId,
    String? pestId,
    String? cropType,
    String? notes,
    String? imageLocalPath,
    String? imageRemoteUrl,
    double? confidenceScore,
    DateTime? createdAt,
    SyncStatus? syncStatus,
  }) {
    return Scan(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      pestId: pestId ?? this.pestId,
      cropType: cropType ?? this.cropType,
      notes: notes ?? this.notes,
      imageLocalPath: imageLocalPath ?? this.imageLocalPath,
      imageRemoteUrl: imageRemoteUrl ?? this.imageRemoteUrl,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}
