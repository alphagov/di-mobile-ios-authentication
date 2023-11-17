import Foundation
import Networking

public protocol TokenServicing {
    func fetchTokens(authorizationCode: String, endpoint: URL) async throws -> TokenResponse
}

public final class TokenService: TokenServicing {
    let client: NetworkClient
    
    public init(client: NetworkClient) {
        self.client = client
    }
    
    public func fetchTokens(authorizationCode: String, endpoint: URL) async throws -> TokenResponse {
        let requestBody = try JSONEncoder()
            .encode(TokenRequest(authorizationCode: authorizationCode))
        let data = try await client
            .makeRequest(.tokenRequest(body: requestBody, endpoint: endpoint))
        return try JSONDecoder()
            .decode(TokenResponse.self, from: data)
    }
}
