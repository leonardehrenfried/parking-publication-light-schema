var fs = require('fs');

const FILENAMES = [
  'draft7/DATEXII_3_ParkingPublicationLight.json',
  'draft7/DATEXII_3_Common.json',
  'draft7/DATEXII_3_LocationReferencing.json'
];

FILENAMES.forEach(n =>{
  var data = fs.readFileSync(n, 'utf8');
  var schema = JSON.parse(data);

  Object.keys(schema.definitions).forEach(key => {
    const s = schema.definitions[key];
    if(Array.isArray(s.allOf)) {
      s.allOf = [s.allOf[0], s.allOf[0]];
    }
  });

  fs.writeFileSync(n, JSON.stringify(schema, null, 2));
});
