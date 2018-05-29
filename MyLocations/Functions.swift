//
//  Functions.swift
//  MyLocations
//
//  Created by Nguyen Van An on 29/05/2018.
//  Copyright © 2018 An. All rights reserved.
//

import Foundation

func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
}
