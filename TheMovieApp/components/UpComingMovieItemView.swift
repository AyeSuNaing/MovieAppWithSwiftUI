//
//  UpComingMovieItemView.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

struct UpComingMovieItemView: View {
    var mMovie: MovieVO?
    var onTapFav: ((Int)->Void)?
    var body: some View {
        HStack{
            // Image
            UpComngItemImageView(imageUrl: mMovie?.getPosterPathTogetherWithBaseUrl() ?? "")
            VStack(alignment: .leading, spacing: MARGIN_SMALL){
                // Text
                Text(mMovie?.title ?? "")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.system(size: TEXT_REGULAR_2X))
                    .lineLimit(1)
                    .padding(.top, MARGIN_MEDIUM)
                // Text
                Text(mMovie?.overview ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: TEXT_REGULAR))
                    .lineLimit(5)
                    .multilineTextAlignment(.leading) // Align text to the left
                    .padding(.top, MARGIN_MEDIUM)
                Spacer()
                FavoriteButtonView(mMovie: mMovie, onTapFav: { value in
                    guard let onTapFav = self.onTapFav else {
                        return
                    }
                    onTapFav(value)
                    
                })
                .padding(.bottom, MARGIN_SMALL)
                
            }
        }.frame(height: MOVIE_UPCOMING_HEIGHT)
    }
}

struct UpComngItemImageView : View {
    var imageUrl : String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)!){
            phase in
            switch phase {
            case .empty:
                 ProgressView()
                    .frame(width: MOVIE_ITEM_WIDTH,height: MOVIE_ITEM_HEIGHT)
                    .cornerRadius(MARGIN_RADIUS_10)
                    .clipped()
            case .success(let image):
                 image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: MOVIE_UPCOMING_WIDTH,height: MOVIE_UPCOMING_HEIGHT)
                    .cornerRadius(MARGIN_RADIUS_10)
                    .clipped()
                
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(MARGIN_RADIUS_10)
                    .clipped()
                
            @unknown default:
                EmptyView()
            }
        }
    }
}


#Preview {
    UpComingMovieItemView()
}
