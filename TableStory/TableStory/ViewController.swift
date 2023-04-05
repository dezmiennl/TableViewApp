//
//  ViewController.swift
//  TableStory
//
//  Created by Dezmien Lugo on 3/21/23.
//

import UIKit
import MapKit
//array objects of our data.
let data = [
    Item(name: "Wake the Dead Coffee House", neighborhood: "Alamo", desc: "Wake the Dead coffee house is a local San Marcos coffee shop open for late night studying until midnight. The coffee house has some art and interesting decor to enjoy while you drink your coffee or enjoy one of the food options they have. You can listen to the hip music playing indoors or in the patio area outdoors. It's a great working environment that celebrates local artisit and provides a welcoming atmosphere.", lat: 29.90212, long: -97.988086, imageName: "rest1"),
    Item(name: "The Native Blends", neighborhood: "Downtown", desc: "The Native Blends has a variety of drink options and flavors of protein waffles to choose from! Their menu items are delicious and their staff is extremely friendly and welcoming to students in the area. It can be empty at times and at most have a a few small groups of friends chatting alongside some chill study music at a reasonable volume to cover conversation but not distract you from work. Their teas are excellent for students as they're energizing and support brain function!", lat: 29.885309, long: -97.939484, imageName: "rest2"),
    Item(name: "Cheatham Street Flats", neighborhood: "East Guadalupe", desc: "This is is a study spot exclusive to Cheatham Street Flats residents and their guests. The study room at Cheatham has seating and a large tv for you to play your choice of music, watch your favorite show, or nothing at all while you get your work done. The study room has a large sliding door to let some fresh air and street noise in if you prefer. The lounge is just across the hall to relax once you finish your study session. ", lat: 29.87642, long: -97.9401, imageName: "rest3"),
    Item(name: "LazyDaze", neighborhood: "Rio Vista", desc: "Lazydaze is one of the chillest and most inviting coffee houses in San Marcos. The environement feels judgement-free and extremely comfortable. The vibe is amzing and added to by the friendly staff. The coffee house is also CBD friendly, relaxing and spacious for cutstomers to enjoy, even with your pets! ", lat: 29.88365, long: -97.92372, imageName: "rest4"),
    Item(name: "Rio Vista Park", neighborhood: "Rio Vista", desc: "Rio vista park is a local San Marcos with an extremely relaxing atmosphere that let's you appreciate the natural beauty of San Marcos while studying and getting work done. You can walk the short trail for a brain break in between and even walk to the park depending on what area of San Marcos you live in. The sounds of the leaves blowing and water crashing is extremely calming and allows for efficient work to be done without distracting noise. ", lat: 29.878533, long: -97.931734, imageName: "rest5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      
      
//Add image references
    let image = UIImage(named: item.imageName)
    cell?.imageView?.image = image
    cell?.imageView?.layer.cornerRadius = 10
    cell?.imageView?.layer.borderWidth = 5
    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      return cell!
  }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
   
    
  }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetailSegue" {
          if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
              // Pass the selected item to the detail view controller
              detailViewController.item = selectedItem
          }
      }
  }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }
    }


}

