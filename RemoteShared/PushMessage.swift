// LoopFollow
// PushMessage.swift

import Foundation

struct EncryptedPushMessage: Encodable {
    let aps: APSPayload
    let encryptedData: String

    init(encryptedData: String, commandType _: TRCCommandType) {
        self.encryptedData = encryptedData
        aps = APSPayload()
    }

    /// Sent as a background push (see `APNSDelivery.PushType`), so no alert fields.
    struct APSPayload: Encodable {
        let contentAvailable: Int = 1

        enum CodingKeys: String, CodingKey {
            case contentAvailable = "content-available"
        }
    }

    enum CodingKeys: String, CodingKey {
        case aps
        case encryptedData = "encrypted_data"
    }
}

struct CommandPayload: Encodable {
    var user: String
    var commandType: TRCCommandType
    var timestamp: TimeInterval

    var bolusAmount: Decimal?
    var target: Int?
    var duration: Int?
    var carbs: Int?
    var protein: Int?
    var fat: Int?
    var overrideName: String?
    var scheduledTime: TimeInterval?
    var commandID: String?
    var mealID: String?
    var returnNotification: ReturnNotificationInfo?

    var apnsCollapseID: String {
        if commandType.usesCommandIDAsCollapseID, let commandID {
            return commandID
        }
        return commandType.rawValue
    }

    enum CodingKeys: String, CodingKey {
        case user
        case commandType = "command_type"
        case timestamp
        case bolusAmount = "bolus_amount"
        case target
        case duration
        case carbs
        case protein
        case fat
        case overrideName
        case scheduledTime = "scheduled_time"
        case commandID = "command_id"
        case mealID = "meal_id"
        case returnNotification = "return_notification"
    }
}
