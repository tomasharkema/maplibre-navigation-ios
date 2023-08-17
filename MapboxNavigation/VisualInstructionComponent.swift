import UIKit
import MapboxDirections

extension VisualInstruction.Component {

    static let scale = UIScreen.main.scale

    public var textRepresentation: TextRepresentation? {
        switch self {
        case .text(let text):
            return text
        case .delimiter(let text):
            return text
        case .image(let image, let alternativeText):
            return alternativeText
        case .guidanceView(let image, let alternativeText):
            return alternativeText
        case .exit(let text):
            return text
        case .exitCode(let text):
            return text
        case .lane:
            return nil
        }
    }

    public var imageURL: URL? {
        switch self {
        case .text(let text):
            return nil
        case .delimiter(let text):
            return nil
        case .image(let image, _):
            return image.imageURL()
        case .guidanceView(let image, _):
            return image.imageURL
        case .exit:
            return nil
        case .exitCode:
            return nil
        case .lane:
            return nil
        }
    }

    public var abbreviation: String? {
        textRepresentation?.text
    }

    public var abbreviationPriority: Int {
        textRepresentation?.abbreviationPriority ?? NSNotFound
    }

    public var cacheKey: String? {
        switch self {
        case .exit(let text), .exitCode(let text):
            return "exit-\(text.text)-\(VisualInstruction.Component.scale)"
        case .image(let image, _):
            guard let imageURL = image.imageURL(scale: VisualInstruction.Component.scale) else { return genericCacheKey }
            return "\(imageURL.absoluteString)-\(VisualInstruction.Component.scale)"
        case .text, .delimiter:
            return nil
        case .guidanceView(let image, _):
            guard let imageURL = image.imageURL else { return genericCacheKey }
            return "\(imageURL.absoluteString)-\(VisualInstruction.Component.scale)"
        case .lane(_, _, _):
            return nil
        }
    }

    public var genericCacheKey: String {
        return "generic-\(textRepresentation?.text ?? "nil")"
    }
}
