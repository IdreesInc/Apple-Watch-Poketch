//
//  MarkingMap.swift
//  Poketch WatchKit Extension
//
//  Created by Idrees Hassan on 11/14/21.
//

import SwiftUI

struct MarkingMap: View {
    
    @EnvironmentObject var config: Config
    
    @State var offsets: [CGPoint]
    @State var originalOffsets: [CGPoint]
    
    let markingMapWidth = 156.0 // 170.0
    let markingSize = 10.0 // 10.0
    let markingMargin = 20.0 // Gotta avoid that control center
    let markingSpacing = 3.0
    let lowerBound: Double
    
    init() {
        let width = WKInterfaceDevice.current().screenBounds.width / 2.0 - markingMargin -  markingSize / 2.0
        lowerBound = WKInterfaceDevice.current().screenBounds.height / 2 - markingSize / 2 - markingMargin
        originalOffsets = [
            CGPoint(x: width - (markingSize + markingSpacing) * 5, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 4, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 3, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 2, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 1, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 0, y: lowerBound)
        ]
        offsets = [
            CGPoint(x: width - (markingSize + markingSpacing) * 5, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 4, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 3, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 2, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 1, y: lowerBound),
            CGPoint(x: width - (markingSize + markingSpacing) * 0, y: lowerBound)
        ]
        print(offsets)
    }

    var body: some View {
        ZStack {
            config.theme.colorA
            ZStack {
                Image("marking-map-b").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingMapWidth).foregroundColor(config.theme.colorB)
                Image("marking-map-c").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingMapWidth).foregroundColor(config.theme.colorC)
            }
            Image("marking-map-circle").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingSize).foregroundColor(config.theme.colorD).offset(x: offsets[0].x, y: offsets[0].y)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            offsets[0] = CGPoint(x: touch.location.x - markingSize / 2, y: touch.location.y - markingSize / 2)
                        })
                        .onEnded({ touch in
                            if offsets[0].y > lowerBound - markingSize / 2 {
                                offsets[0].x = originalOffsets[0].x
                                offsets[0].y = originalOffsets[0].y
                            }
                        })
                )
            Image("marking-map-star").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingSize).foregroundColor(config.theme.colorD).offset(x: offsets[1].x, y: offsets[1].y)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            offsets[1] = CGPoint(x: touch.location.x - markingSize / 2, y: touch.location.y - markingSize / 2)
                        })
                        .onEnded({ touch in
                            if offsets[1].y > lowerBound - markingSize / 2 {
                                offsets[1].x = originalOffsets[1].x
                                offsets[1].y = originalOffsets[1].y
                            }
                        })
                )
            Image("marking-map-square").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingSize).foregroundColor(config.theme.colorD).offset(x: offsets[2].x, y: offsets[2].y)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            offsets[2] = CGPoint(x: touch.location.x - markingSize / 2, y: touch.location.y - markingSize / 2)
                        })
                        .onEnded({ touch in
                            if offsets[2].y > lowerBound - markingSize / 2 {
                                offsets[2].x = originalOffsets[2].x
                                offsets[2].y = originalOffsets[2].y
                            }
                        })
                )
            Image("marking-map-triangle").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingSize).foregroundColor(config.theme.colorD).offset(x: offsets[3].x, y: offsets[3].y)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            offsets[3] = CGPoint(x: touch.location.x - markingSize / 2, y: touch.location.y - markingSize / 2)
                        })
                        .onEnded({ touch in
                            if offsets[3].y > lowerBound - markingSize / 2 {
                                offsets[3].x = originalOffsets[3].x
                                offsets[3].y = originalOffsets[3].y
                            }
                        })
                )
            Image("marking-map-heart").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingSize).foregroundColor(config.theme.colorD).offset(x: offsets[4].x, y: offsets[4].y)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            offsets[4] = CGPoint(x: touch.location.x - markingSize / 2, y: touch.location.y - markingSize / 2)
                        })
                        .onEnded({ touch in
                            if offsets[4].y > lowerBound - markingSize / 2 {
                                offsets[4].x = originalOffsets[4].x
                                offsets[4].y = originalOffsets[4].y
                            }
                        })
                )
            Image("marking-map-diamond").renderingMode(.template).interpolation(.none).resizable().aspectRatio(contentMode: .fit).frame(width: markingSize).foregroundColor(config.theme.colorD).offset(x: offsets[5].x, y: offsets[5].y)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touch in
                            offsets[5] = CGPoint(x: touch.location.x - markingSize / 2, y: touch.location.y - markingSize / 2)
                        })
                        .onEnded({ touch in
                            if offsets[5].y > lowerBound - markingSize / 2 {
                                offsets[5].x = originalOffsets[5].x
                                offsets[5].y = originalOffsets[5].y
                            }
                        })
                )
        }
    }
}

struct MarkingMap_Previews: PreviewProvider {
    static var previews: some View {
        MarkingMap().environmentObject(Config()).ignoresSafeArea(.all).navigationBarHidden(true).previewDevice("Apple Watch Series 6 - 40mm")
    }
}
