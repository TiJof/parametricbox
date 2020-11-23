// Custom Box Generator with partition
// Made by RABOUIN Geoffroy
// geoffroy+openscad@rabouin.es
// you can write me in French or English
include <Chamfers-for-OpenSCAD/Chamfer.scad>;
Delta=0.01;

$FloorHeight = 1;

$PartitionInterval = 5;
$PartitionWidth = 1;

$BoxThickness = 1.5;

$BottomLenght = 143;
$BottomWidth = 93;
$BottomHeight = 44;

$TopHeight = 40;
$TopLenght = $BoxThickness + $BottomLenght;
$TopWidth = $BoxThickness + $BottomWidth;
$PartitionWidthHole = $PartitionWidth + 0.5;
$PartitionHeight = $TopHeight + $BottomHeight - $FloorHeight;

$NeedRulesSupport = 1;
$SupportLenght = 15;
$SupportWidth = 10;
$SupportHeight = 68;
$SupportThickness = 3;

// Set this to 
// 1 for the main box
// 2 for the partition
// 3 for all the elements
$ElementToRender = 3;

if (($ElementToRender == 1) || ($ElementToRender == 3)) {
  // Main box
  difference() {
    union(){
      // floor
      translate([0, 0, 0])
        cube([$BottomLenght, $BottomWidth, $FloorHeight], center=false);

      // Bottom one
      // Lenght
      translate([0, 0, 0])
        cube([$BottomLenght, $BoxThickness, $BottomHeight], center=false);
      translate([0, $BottomWidth - $BoxThickness, 0])
        cube([$BottomLenght, $BoxThickness, $BottomHeight], center=false);
      // Width
      translate([0, 0, 0])
        cube([$BoxThickness, $BottomWidth, $BottomHeight], center=false);
      translate([$BottomLenght - $BoxThickness, 0, 0])
        cube([$BoxThickness, $BottomWidth, $BottomHeight], center=false);

      // Top one
      // Lenght
      translate([-$BoxThickness, -$BoxThickness, $BottomHeight])
        chamferCube([$BottomLenght + $BoxThickness * 2, $BoxThickness * 2, $TopHeight], chamfers=[[1, 0, 0, 0], [1, 0, 0, 1], [0, 0, 0, 0]], ch=$BoxThickness);
      translate([-$BoxThickness, $BottomWidth - $BoxThickness, $BottomHeight])
        chamferCube([$BottomLenght + $BoxThickness * 2, $BoxThickness * 2, $TopHeight], chamfers=[[0, 1, 0, 0], [1, 0, 0, 1], [0, 0, 0, 0]], ch=$BoxThickness);
      // Width
      translate([-$BoxThickness, -$BoxThickness, $BottomHeight])
        chamferCube([$BoxThickness * 2, $BottomWidth + $BoxThickness * 2, $TopHeight], chamfers=[[1, 1, 0, 0], [1, 0, 0, 0], [0, 0, 0, 0]], ch=$BoxThickness);
        translate([$BottomLenght - $BoxThickness, -$BoxThickness, $BottomHeight])
      chamferCube([$BoxThickness * 2, $BottomWidth + $BoxThickness* 2, $TopHeight], chamfers=[[1, 1, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0]], ch=$BoxThickness);

      // Support
      if ($NeedRulesSupport == 1)
        translate([$BoxThickness, $BoxThickness, $SupportHeight])
          chamferCube([$SupportLenght, $SupportWidth, $SupportThickness ], , chamfers=[[0, 1, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0]], ch=$BoxThickness);
        translate([$TopLenght - $BoxThickness - $SupportLenght, $BoxThickness, $SupportHeight])
          chamferCube([$SupportLenght, $SupportWidth, $SupportThickness ], , chamfers=[[0, 1, 0, 0], [1, 0, 0, 0], [0, 0, 0, 0]], ch=$BoxThickness);
        translate([$BoxThickness, $TopWidth - $SupportWidth - $BoxThickness, $SupportHeight])
          chamferCube([$SupportLenght, $SupportWidth, $SupportThickness ], , chamfers=[[1, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0]], ch=$BoxThickness);
        translate([$TopLenght - $BoxThickness - $SupportLenght, $TopWidth - $SupportWidth - $BoxThickness, $SupportHeight])
          chamferCube([$SupportLenght, $SupportWidth, $SupportThickness ], , chamfers=[[1, 0, 0, 0], [1, 0, 0, 0], [0, 0, 0, 0]], ch=$BoxThickness);    
    }
    // partitions holes
    for(Offset = [$BoxThickness : $PartitionInterval : $BottomLenght])
      if ((Offset > $PartitionInterval) && (Offset < $BottomLenght - $PartitionInterval))
        translate([Offset, $BoxThickness / 1.75, $FloorHeight + 0.00001 ])
          cube([$PartitionWidthHole, $BottomWidth - (2 * ($BoxThickness / 1.75)), $PartitionHeight ], center=false);
  }
}

if (($ElementToRender == 2) || ($ElementToRender == 3)) {
  // partitions
  difference() {
    translate([-$PartitionHeight, $BottomWidth / 2, 0])
      cube([$PartitionHeight, $BottomWidth - (2 * ($BoxThickness / 1.75)), $PartitionWidth ], center=true);
    translate([-1.5 * $PartitionHeight, $BottomWidth / 2, 0 ])
      scale([0.6,1,1])
      cylinder(h = $BoxThickness, d = $BottomWidth*3/4, center = true);
  }
}
