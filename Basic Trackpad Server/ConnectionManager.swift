//
//  ConnectionManager.swift
//  Basic Trackpad Server
//
//  Created by Tomasz Pieczykolan on 13/12/16.
//  Copyright © 2016 Tomasz Pieczykolan. All rights reserved.
//

import MultipeerConnectivity

class ConnectionManager: NSObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate {
    
    static let shared = ConnectionManager()
    
    private override init() {
        super.init()
        self.advertiseSelf(true)
    }
    
    // MARK: - Setup
    
    var peerID: MCPeerID = MCPeerID(displayName: Host.current().localizedName ?? "Basic Trackpad Server")
    
    lazy var session: MCSession = {
        let s = MCSession(peer: self.peerID)
        s.delegate = self
        return s
    }()
    
    // MARK: - Advertiser
    
    var advertiser: MCNearbyServiceAdvertiser?
    
    func advertiseSelf(_ advertise: Bool) {
        if advertise {
            self.advertiser = MCNearbyServiceAdvertiser(peer: self.peerID, discoveryInfo: nil, serviceType: serviceType)
            self.advertiser?.delegate = self
            self.advertiser?.startAdvertisingPeer()
        } else {
            self.advertiser?.stopAdvertisingPeer()
            self.advertiser = nil
        }
    }
    
    // MARK: - MCSessionDelegate
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print(#function, peerID.displayName, state.rawValue)
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if data.count == MemoryLayout<CGVector>.size {
            MouseManager.shared.translateMousePosition(by: data.withUnsafeBytes({ (ptr) -> CGVector in
                return ptr.pointee
            }))
        } else if data.count == MemoryLayout<Bool>.size {
            MouseManager.shared.mouseIsDown = data.withUnsafeBytes({ (ptr) -> Bool in
                return ptr.pointee
            })
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print(#function)
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print(#function)
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        print(#function)
    }
    
    // MARK: - MCNearbyServiceAdvertiserDelegate
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print(#function)
    }
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print(#function)
        invitationHandler(true, self.session)
    }
}
