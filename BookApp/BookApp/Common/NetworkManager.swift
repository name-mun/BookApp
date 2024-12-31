//
//  NetworkManager.swift
//  BookApp
//
//  Created by mun on 12/30/24.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
    private let baseURL: String = "https://dapi.kakao.com/v3/search/book?query="

    private init() {}

    // MARK: - fetch

    func fetchData<T: Decodable>(title: String, completion: @escaping (T?) -> Void) {

        // apiKey 불러오기
        guard let apiKey = Bundle.main.infoDictionary?["APIKey"] as? String else { return }

        // URL 생성
        guard let url = URL(string: "\(baseURL)\(title)") else {
            completion(nil)
            print("invaild URL")
            return
        }

        // URLRequest 생성
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "KakaoAK \(apiKey)"]

        // URLSession 생성
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                completion(nil)
                print("response fail")
                return
            }

            // 데이터 디코딩
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completion(nil)
                print("decoding fail")
                return
            }

            completion(decodedData)
        }.resume() // 실행
    }
}
