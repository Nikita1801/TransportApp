//
//  BottomSheetViewController.swift
//  TransportApp
//
//  Created by Никита Макаревич on 27.02.2022.
//

import UIKit

class BottomSheetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var trasnportInfoArray : [StopInformationModel?] = []
    var transportInfoTableView = UITableView()
    var stopInformationRepository = StopInformationRepository()
    var mapVC : MapViewController?
    let idnet = "bottomSheetCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Автобусные остановки"
        stopInformationRepository.delegate = self
        stopInformationRepository.fetchStopInfo(stopID: mapVC?.id ?? "00047fcc-66f3-4f9f-9c0e-8763091979cc")
        
        //transportInfoTableView.reloadData()
    }
    
    func createTable() {
        self.transportInfoTableView = UITableView(frame: view.bounds, style: .grouped)
        transportInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: idnet)
        self.transportInfoTableView.delegate = self
        self.transportInfoTableView.dataSource = self
        
        
        transportInfoTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(transportInfoTableView)
    }

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trasnportInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idnet, for: indexPath)
        
        let stopInfo = trasnportInfoArray[indexPath.row]
        cell.textLabel?.text = stopInfo?.number
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension BottomSheetViewController : StopInformationRepositoryDelegate {
    func didUpdateStopInfo(_ topInformationRepository: StopInformationRepository, stopInformation: [StopInformationModel?]) {
        self.trasnportInfoArray = stopInformation
        DispatchQueue.main.async {
            self.createTable()
        }
    }
    
    
}
