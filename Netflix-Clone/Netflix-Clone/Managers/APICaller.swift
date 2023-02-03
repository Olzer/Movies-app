import Foundation

struct Constants {
    static let API_KEY = "95615d047609ca46c74f9bf69582d392"
    static let basetURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basetURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else { return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getThendingTVs(completion: @escaping (Result<[TV], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basetURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTVsResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Popular], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basetURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(PopularResponse.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Upcoming], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basetURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(UpcommigResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[TopRated], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.basetURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TopRatedResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
