//
//
// APIClientRefreshTests.swift
// interesnoitochka
//
// Created by sturdytea on 22.01.2026.
//
// GitHub: https://github.com/sturdytea
//
    

import XCTest
@testable import interesnoitochka

final class APIClientRefreshTests: XCTestCase {

    func testRequestWithAutoRefresh_refreshesTokenAndRetriesRequest() {

        TokenStore.shared.save(
            tokens: AuthTokens(
                accessToken: "expired_access",
                refreshToken: "valid_refresh"
            )
        )

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        let apiClient = APIClient(session: session)

        var requestStep = 0

        MockURLProtocol.requestHandler = { request in
            requestStep += 1

            switch requestStep {
            case 1:
                return (
                    HTTPURLResponse(
                        url: request.url!,
                        statusCode: 401,
                        httpVersion: nil,
                        headerFields: nil
                    )!,
                    nil
                )

            case 2:
                let json = """
                {
                  "access_token": "new_access",
                  "refresh_token": "new_refresh"
                }
                """
                return (
                    HTTPURLResponse(
                        url: request.url!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil
                    )!,
                    Data(json.utf8)
                )

            case 3:
                return (
                    HTTPURLResponse(
                        url: request.url!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil
                    )!,
                    Data("OK".utf8)
                )

            default:
                fatalError("Unexpected request")
            }
        }

        let exp = expectation(description: "Request completed")

        let request = URLRequest(url: URL(string: "https://example.com/protected")!)

        apiClient.requestWithAutoRefresh(request) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(String(decoding: data, as: UTF8.self), "OK")
                XCTAssertEqual(TokenStore.shared.accessToken(), "new_access")
                XCTAssertEqual(TokenStore.shared.refreshToken(), "new_refresh")

            case .failure:
                XCTFail("Request should succeed after refresh")
            }

            exp.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
