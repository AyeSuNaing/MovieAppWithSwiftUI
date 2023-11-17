//
//  ActorItemView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI


struct ActorItemView : View {
    var mActor : ActorVO
    var body: some View {
        VStack(alignment:.leading) {
            ActorImageView(imageUrl: mActor.getProfilePathTogetherWithImageBaseUrl() )

            Text(mActor.name ?? "")
                .foregroundColor(.black
                )
                .fontWeight(.bold)
                .font(.system(size: TEXT_REGULAR))
                .lineLimit(1)
                    
           
            
        }
        .frame(width: ACTOR_ITEM_WIDTH)
    }
}


struct ActorImageView: View {
    var imageUrl : String = ""
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)!){
            phase in
            switch phase {
            case .empty:
                 ProgressView()
                    .frame(width: ACTOR_ITEM_WIDTH, height: ACTOR_ITEM_HEIGHT)

            case .success(let image):
                 image
                    .resizable()
                    .frame(width: ACTOR_ITEM_WIDTH, height: ACTOR_ITEM_HEIGHT)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(MARGIN_RADIUS_10)
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                    .frame(width: ACTOR_ITEM_WIDTH, height: ACTOR_ITEM_HEIGHT)

            @unknown default:
                EmptyView()
            }
        }
       
    }
}
