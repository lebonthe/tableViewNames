//
//  ViewController.swift
//  tableViewNames
//
//  Created by Min Hu on 2023/12/20.
//

import UIKit

class ViewController: UIViewController {
    // Table View 介面連結
    @IBOutlet weak var tableView: UITableView!
    
    // Boy 的名字 array，儲存名跟姓
    let names = [
        Name(firstName: "Oliver", lastName: "Bennett"),
        Name(firstName: "Ethan", lastName: "Parker"),
        Name(firstName: "Noah", lastName: "Johnson"),
        Name(firstName: "Liam", lastName: "Anderson"),
        Name(firstName: "Mason", lastName: "Smith"),
        Name(firstName: "Lucas", lastName: "Williams"),
        Name(firstName: "Jacob", lastName: "Davis"),
        Name(firstName: "Aiden", lastName: "Wilson"),
        Name(firstName: "Logan", lastName: "Brown"),
        Name(firstName: "Alexander", lastName: "Harris"),
        Name(firstName: "Jack", lastName: "Clark"),
        Name(firstName: "Henry", lastName: "Lewis"),
        Name(firstName: "Charlie", lastName: "White"),
        Name(firstName: "Max", lastName: "Roberts"),
        Name(firstName: "Leo", lastName: "Thompson"),
        Name(firstName: "Dylan", lastName: "Walker"),
        Name(firstName: "Ryan", lastName: "Hall"),
        Name(firstName: "Oscar", lastName: "Allen"),
        Name(firstName: "Samuel", lastName: "Young"),
        Name(firstName: "Isaac", lastName: "Adams")
    ]
    
    // 用來顯示在 tableView 上的 array
    var array:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 將 boy 的名和姓組合成完整名稱，儲存到 array 中
        for i in 0...names.count - 1{
            array.append("\(names[i].firstName) \(names[i].lastName)")
        }
    }
    // 當 Segmented Control 的選項改變時觸發的動作
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        array.removeAll() // 清空 array
        // 獲取當前選擇的 Segmented Control 選項
        let option = NameOptions(rawValue: sender.selectedSegmentIndex)!
        // 依照不同的選項，執行不同的動作
        switch option {
        case .girlNames:
            fetchGirlNames() // 獲取 Girl 的名字
        case .filmTitlesm:
            fetchFilmTitle() // 獲取電影標題
        case .planetNames:
            fetchPlanetTitle() // 獲取星球名稱
        default:
            // 預設情況下，重新加載 Boy 名字
            for i in 0...names.count - 1{
                array.append("\(names[i].firstName) \(names[i].lastName)")
            }
            // 在主線程中重新加載 TableView
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // 獲取 Girl 名字的函數
    func fetchGirlNames() {
        // 如果 url 正確獲取到網址
        guard let url = URL(string: "https://raw.githubusercontent.com/lebonthe/JSON_API/main/girls20Names.json") else { return }
        // 使用 url 網址產生 URLSession 的連線任務 dataTask function，有三個參數 data, response 與 error
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data { // 如果有抓到資料
                let decoder = JSONDecoder() // 創建一個 JSONDecoder 類的實例 decoder
                do {// 用 decode 方法，將 data 解碼成 GirlNames 類型
                    let nameResponse = try decoder.decode(GirlNames.self, from: data)
                    // 將解碼的名字加入到 array 中
                    for i in 0...nameResponse.names.count - 1{
                        self.array.append("\(nameResponse.names[i].firstName) \(nameResponse.names[i].lastName)")
                    }
                    // 在主線程中重新加載 tableView
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                } catch { // 如果 try 失敗，拋出錯誤
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume() // 啟動網路任務
    }
    // 獲取 Film 名字的函數 
    func fetchFilmTitle(){
         guard let url = URL(string: "https://raw.githubusercontent.com/lebonthe/JSON_API/main/films20Names.json") else { return }
         URLSession.shared.dataTask(with: url) { data, response, error in
             if let data {
                 let decoder = JSONDecoder()
                 do {
                     let nameResponse = try decoder.decode(FilmsTitles.self, from: data)
                     for i in 0...nameResponse.filmTitles.count - 1{
                         self.array.append("\(nameResponse.filmTitles[i].title)" )
                     }
                     DispatchQueue.main.async {
                         self.tableView.reloadData()
                     }
                 } catch {
                     print("Error decoding JSON: \(error)")
                 }
             }
         }.resume()
     }
    // 獲取 Planet 名字的函數
    func fetchPlanetTitle(){
         guard let url = URL(string: "https://raw.githubusercontent.com/lebonthe/JSON_API/main/planets20Names.json") else { return }
         URLSession.shared.dataTask(with: url) { data, response, error in
             if let data {
                 let decoder = JSONDecoder()
                 do {
                     let nameResponse = try decoder.decode(PlanetNames.self, from: data)
                     for i in 0...nameResponse.planetNames.count - 1{
                         self.array.append("\(nameResponse.planetNames[i].name)" )
                     }
                     DispatchQueue.main.async {
                         self.tableView.reloadData()
                     }
                 } catch {
                     print("Error decoding JSON: \(error)")
                 }
             }
         }.resume()
     }
}

// ViewController 作為 UITableView 的 Data Source
extension ViewController: UITableViewDataSource{
    // 返回 TableView 的 Cell 行數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    // 配置每行的 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OptionTableViewCell.self)", for: indexPath) as? OptionTableViewCell else { fatalError("dequeueReusableCell optionTableViewCell failed")
        }
        // 設定 cell 的文本為 array 中對應索引的值
        cell.namesLabel?.text = array[indexPath.row]
        return cell
    }
}
