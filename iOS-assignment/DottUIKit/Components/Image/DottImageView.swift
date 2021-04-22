//
//  DottImageView.swift
//  iOS-assignment
//

import UIKit


class DottImageView: UIImageView {
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        setupUI()
    }
    
    func setupUI() {
        
    }
}

extension DottImageView {
    func downloadImage(from url: URL) -> URLSessionDataTask? {
        return getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask? {
        let task = URLSession.shared.dataTask(with: url, completionHandler: completion)
        task.resume()
        return task
    }
}
