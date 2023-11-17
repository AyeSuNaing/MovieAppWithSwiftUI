//
//  MovieDetailScreen.swift
//  TheMovieApp
//
//  Created by AyeSuNaing on 13/10/2023.
//

import SwiftUI

struct MovieDetailScreen: View {
    var movieId : Int?
    var type: String?
    
    // dismiss
    @Environment(\.presentationMode) var presentationMode
    
    // view model
    @StateObject var mDetailViewModel : MovieDetailViewModel
    
    init( movieId : Int? , type: String?){
        _mDetailViewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId : movieId ?? 0, type: type ?? "" ))
    }
    
    
    var body: some View {
        ZStack{
            Color(.white)
            
            if mDetailViewModel.mMovieVO  == nil {
                EmptyView()
            }
            else{
                VStack{
                    ZStack{
                        Color(PRIMARY_COLOR)
                        
                        ScrollView(.vertical){
                            VStack(alignment: .leading, spacing: 0.0){
                                AppBarDetailView(mMovieVO: mDetailViewModel.mMovieVO,onTapBack: {
                                    presentationMode.wrappedValue.dismiss()
                                })
                                
                                DetailInfoSectinView(mMovieVO: mDetailViewModel.mMovieVO){ value in
                                    mDetailViewModel.setFavorite()
                                }
                                
                                
                                   
                            }
                        }

                    }
                    
                   
                        
                }
                
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailInfoSectinView: View{
    var mMovieVO : MovieVO?
    var onTapFav: ((Int)->Void)?
    var joinNames : String = ""
    
    init(mMovieVO: MovieVO? = nil, onTapFav: ( (Int) -> Void)? = nil) {
        self.mMovieVO = mMovieVO
        self.onTapFav = onTapFav
        self.joinNames = getCustomString(genres: mMovieVO?.genres)
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0.0){
            HStack(alignment: .top){
                Text(mMovieVO?.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: TEXT_REGULAR_3X))
                    .fontWeight(.bold)
                
                Spacer()
                
                FavoriteButtonView(mMovie: mMovieVO, onTapFav: { value in
                    guard let onTapFav = self.onTapFav else {
                        return
                    }
                    onTapFav(value)
                })
            }
            
//            HStack(alignment: .top){
//                Text("\(mMovieVO?.runtime ?? 0) | \(joinNames)" )
//                    .foregroundColor(Color(BLUE_COLOR))
//                    .font(.system(size: TEXT_REGULAR))
//                    .fontWeight(.bold)
//                Spacer()
//                Text("English" )
//                    .foregroundColor(.black)
//                    .font(.system(size: TEXT_REGULAR))
//                    .fontWeight(.bold)
//                Text("  3D  " )
//                    .foregroundColor(.black)
//                    .font(.system(size: TEXT_SMALL))
//                    .fontWeight(.medium)
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(5)
//            }
//            .padding(.top, MARGIN_MEDIUM_2)
            
            Spacer().frame(height: MARGIN_LARGE)
            Text(LABEL_DESCRIPTION)
                .foregroundColor(.black)
                .font(.system(size: TEXT_REGULAR_2X))
                .fontWeight(.bold)
                
            Spacer().frame(height: MARGIN_MEDIUM_3)
            
            Text(mMovieVO?.overview ?? "")
                .foregroundColor(.gray)
                .font(.system(size: TEXT_REGULAR))
                .lineLimit(5)
                .fontWeight(.bold)
            
           
        }
        .padding()
    }
    
    func getCustomString(genres: [GenreVO]?)-> String{
        let joinedNames = genres?.prefix(2).map { $0.name ?? "" }.joined(separator: ", ")
        return joinedNames ?? ""
        
    }
}

struct AppBarDetailView: View {
    var mMovieVO : MovieVO?
    var onTapBack: () -> Void

    var body: some View {
        // App Bar
        ZStack{
            // Image
            MovieDetailsImageView(imageUrl: mMovieVO?.getBackdropPathTogetherWithBaseUrl() ?? "")

            VStack(alignment: .leading){
                
                HStack{
                    Image(systemName: IC_BACK)
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: MARGIN_XLARGE,height: MARGIN_XLARGE)
                        .padding()
                        .onTapGesture {
                            onTapBack()
                        }
                    
                    Spacer()
                }
                .padding(EdgeInsets.init(top: MARGIN_XXLARGE, leading: MARGIN_MEDIUM, bottom: 0, trailing: 0))
                Spacer()
                
            }
           
                
                
            
        }
    }
}
struct MovieDetailsImageView : View {
    var imageUrl : String = ""
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)){
            phase in
            switch phase {
            case .empty:
                 ProgressView()
                    .frame(width:UIScreen.main.bounds.width,height: MOVIE_DETAILS_APPBAR_HEIGHT)
            case .success(let image):
                 image
                    .resizable()
                    .frame(width:UIScreen.main.bounds.width,height: MOVIE_DETAILS_APPBAR_HEIGHT)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(MARGIN_RADIUS_15)
            case .failure:
                Image(systemName: "exclamationmark.icloud")

            @unknown default:
                EmptyView()
            }
        }
    }
}


