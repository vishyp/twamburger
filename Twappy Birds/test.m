//
//  test.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/31/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//


#import <Foundation/Foundation.h>
/*2014-10-31 21:11:08.908 Twappy Birds[14708:106602] Welcome Vishy Poosala
2014-10-31 21:11:09.498 Twappy Birds[14708:106602] Tweet {
    contributors = "<null>";
    coordinates = "<null>";
    "created_at" = "Sat Nov 01 04:10:13 +0000 2014";
    entities =     {
        hashtags =         (
                            {
                                indices =                 (
                                                           96,
                                                           105
                                                           );
                                text = startups;
                            },
                            {
                                indices =                 (
                                                           106,
                                                           113
                                                           );
                                text = fanboy;
                            },
                            {
                                indices =                 (
                                                           114,
                                                           126
                                                           );
                                text = beatlemania;
                            }
                            );
        media =         (
                         {
                             "display_url" = "pic.twitter.com/uVGFZ3JeN8";
                             "expanded_url" = "http://twitter.com/kaustavmitra/status/528395510554447873/photo/1";
                             id = 528395509312917504;
                             "id_str" = 528395509312917504;
                             indices =                 (
                                                        139,
                                                        140
                                                        );
                             "media_url" = "http://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                             "media_url_https" = "https://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                             sizes =                 {
                                 large =                     {
                                     h = 400;
                                     resize = fit;
                                     w = 600;
                                 };
                                 medium =                     {
                                     h = 400;
                                     resize = fit;
                                     w = 600;
                                 };
                                 small =                     {
                                     h = 226;
                                     resize = fit;
                                     w = 340;
                                 };
                                 thumb =                     {
                                     h = 150;
                                     resize = crop;
                                     w = 150;
                                 };
                             };
                             "source_status_id" = 528395510554447873;
                             "source_status_id_str" = 528395510554447873;
                             type = photo;
                             url = "http://t.co/uVGFZ3JeN8";
                         }
                         );
        symbols =         (
        );
        urls =         (
        );
        "user_mentions" =         (
                                   {
                                       id = 60629845;
                                       "id_str" = 60629845;
                                       indices =                 (
                                                                  3,
                                                                  16
                                                                  );
                                       name = "Kaustav Mitra";
                                       "screen_name" = kaustavmitra;
                                   },
                                   {
                                       id = 32718488;
                                       "id_str" = 32718488;
                                       indices =                 (
                                                                  42,
                                                                  49
                                                                  );
                                       name = "Vivek Wadhwa";
                                       "screen_name" = wadhwa;
                                   }
                                   );
    };
    "extended_entities" =     {
        media =         (
                         {
                             "display_url" = "pic.twitter.com/uVGFZ3JeN8";
                             "expanded_url" = "http://twitter.com/kaustavmitra/status/528395510554447873/photo/1";
                             id = 528395509312917504;
                             "id_str" = 528395509312917504;
                             indices =                 (
                                                        139,
                                                        140
                                                        );
                             "media_url" = "http://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                             "media_url_https" = "https://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                             sizes =                 {
                                 large =                     {
                                     h = 400;
                                     resize = fit;
                                     w = 600;
                                 };
                                 medium =                     {
                                     h = 400;
                                     resize = fit;
                                     w = 600;
                                 };
                                 small =                     {
                                     h = 226;
                                     resize = fit;
                                     w = 340;
                                 };
                                 thumb =                     {
                                     h = 150;
                                     resize = crop;
                                     w = 150;
                                 };
                             };
                             "source_status_id" = 528395510554447873;
                             "source_status_id_str" = 528395510554447873;
                             type = photo;
                             url = "http://t.co/uVGFZ3JeN8";
                         }
                         );
    };
    "favorite_count" = 0;
    favorited = 0;
    geo = "<null>";
    id = 528398578662666240;
    "id_str" = 528398578662666240;
    "in_reply_to_screen_name" = "<null>";
    "in_reply_to_status_id" = "<null>";
    "in_reply_to_status_id_str" = "<null>";
    "in_reply_to_user_id" = "<null>";
    "in_reply_to_user_id_str" = "<null>";
    lang = en;
    place = "<null>";
    "possibly_sensitive" = 0;
    "retweet_count" = 1;
    retweeted = 0;
    "retweeted_status" =     {
        contributors = "<null>";
        coordinates = "<null>";
        "created_at" = "Sat Nov 01 03:58:01 +0000 2014";
        entities =         {
            hashtags =             (
                                    {
                                        indices =                     (
                                                                       78,
                                                                       87
                                                                       );
                                        text = startups;
                                    },
                                    {
                                        indices =                     (
                                                                       88,
                                                                       95
                                                                       );
                                        text = fanboy;
                                    },
                                    {
                                        indices =                     (
                                                                       96,
                                                                       108
                                                                       );
                                        text = beatlemania;
                                    }
                                    );
            media =             (
                                 {
                                     "display_url" = "pic.twitter.com/uVGFZ3JeN8";
                                     "expanded_url" = "http://twitter.com/kaustavmitra/status/528395510554447873/photo/1";
                                     id = 528395509312917504;
                                     "id_str" = 528395509312917504;
                                     indices =                     (
                                                                    109,
                                                                    131
                                                                    );
                                     "media_url" = "http://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                                     "media_url_https" = "https://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                                     sizes =                     {
                                         large =                         {
                                             h = 400;
                                             resize = fit;
                                             w = 600;
                                         };
                                         medium =                         {
                                             h = 400;
                                             resize = fit;
                                             w = 600;
                                         };
                                         small =                         {
                                             h = 226;
                                             resize = fit;
                                             w = 340;
                                         };
                                         thumb =                         {
                                             h = 150;
                                             resize = crop;
                                             w = 150;
                                         };
                                     };
                                     type = photo;
                                     url = "http://t.co/uVGFZ3JeN8";
                                 }
                                 );
            symbols =             (
            );
            urls =             (
            );
            "user_mentions" =             (
                                           {
                                               id = 32718488;
                                               "id_str" = 32718488;
                                               indices =                     (
                                                                              24,
                                                                              31
                                                                              );
                                               name = "Vivek Wadhwa";
                                               "screen_name" = wadhwa;
                                           }
                                           );
        };
        "extended_entities" =         {
            media =             (
                                 {
                                     "display_url" = "pic.twitter.com/uVGFZ3JeN8";
                                     "expanded_url" = "http://twitter.com/kaustavmitra/status/528395510554447873/photo/1";
                                     id = 528395509312917504;
                                     "id_str" = 528395509312917504;
                                     indices =                     (
                                                                    109,
                                                                    131
                                                                    );
                                     "media_url" = "http://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                                     "media_url_https" = "https://pbs.twimg.com/media/B1U86omCEAAOGmj.jpg";
                                     sizes =                     {
                                         large =                         {
                                             h = 400;
                                             resize = fit;
                                             w = 600;
                                         };
                                         medium =                         {
                                             h = 400;
                                             resize = fit;
                                             w = 600;
                                         };
                                         small =                         {
                                             h = 226;
                                             resize = fit;
                                             w = 340;
                                         };
                                         thumb =                         {
                                             h = 150;
                                             resize = crop;
                                             w = 150;
                                         };
                                     };
                                     type = photo;
                                     url = "http://t.co/uVGFZ3JeN8";
                                 }
                                 );
        };
        "favorite_count" = 1;
        favorited = 0;
        geo = "<null>";
        id = 528395510554447873;
        "id_str" = 528395510554447873;
        "in_reply_to_screen_name" = "<null>";
        "in_reply_to_status_id" = "<null>";
        "in_reply_to_status_id_str" = "<null>";
        "in_reply_to_user_id" = "<null>";
        "in_reply_to_user_id_str" = "<null>";
        lang = en;
        place =         {
            attributes =             {
            };
            "bounding_box" =             {
                coordinates =                 (
                                               (
                                                (
                                                 "-122.190523",
                                                 "37.362824"
                                                 ),
                                                (
                                                 "-122.097537",
                                                 "37.362824"
                                                 ),
                                                (
                                                 "-122.097537",
                                                 "37.465918"
                                                 ),
                                                (
                                                 "-122.190523",
                                                 "37.465918"
                                                 )
                                                )
                                               );
                type = Polygon;
            };
            "contained_within" =             (
            );
            country = "United States";
            "country_code" = US;
            "full_name" = "Palo Alto, CA";
            id = 3ad0f706b3fa62a8;
            name = "Palo Alto";
            "place_type" = city;
            url = "https://api.twitter.com/1.1/geo/id/3ad0f706b3fa62a8.json";
        };
        "possibly_sensitive" = 0;
        "retweet_count" = 1;
        retweeted = 0;/Users/vishypoosala/Documents/iOS Class/Twappy Birds/Twappy Birds/test.m
        source = "<a href=\"http://twitter.com\" rel=\"nofollow\">Twitter Web Client</a>";
        text = "Whoa! Just got RT'ed by @wadhwa to his 1B followers. Feeling a bit like this. #startups #fanboy #beatlemania http://t.co/uVGFZ3JeN8";
        truncated = 0;
        user =         {
            "contributors_enabled" = 0;
            "created_at" = "Mon Jul 27 15:45:57 +0000 2009";
            "default_profile" = 0;
            "default_profile_image" = 0;
            description = "Technology, Startups, Education, Science Fiction and Kababs. Not in any particular order.";
            entities =             {
                description =                 {
                    urls =                     (
                    );
                };
                url =                 {
                    urls =                     (
                                                {
                                                    "display_url" = "spr.ly/SAPStartups";
                                                    "expanded_url" = "http://spr.ly/SAPStartups";
                                                    indices =                             (
                                                                                           0,
                                                                                           20
                                                                                           );
                                                    url = "http://t.co/DZgiJ6d7";
                                                }
                                                );
                };
            };
            "favourites_count" = 48;
            "follow_request_sent" = 0;
            "followers_count" = 343;
            following = 0;
            "friends_count" = 255;
            "geo_enabled" = 1;
            id = 60629845;
            "id_str" = 60629845;
            "is_translation_enabled" = 0;
            "is_translator" = 0;
            lang = en;
            "listed_count" = 12;
            location = "";
            name = "Kaustav Mitra";
            notifications = 0;
            "profile_background_color" = 131516;
            "profile_background_image_url" = "http://abs.twimg.com/images/themes/theme14/bg.gif";
            "profile_background_image_url_https" = "https://abs.twimg.com/images/themes/theme14/bg.gif";
            "profile_background_tile" = 1;
            "profile_banner_url" = "https://pbs.twimg.com/profile_banners/60629845/1401172580";
            "profile_image_url" = "http://pbs.twimg.com/profile_images/2547644787/9a6zws3bij528szrnw8z_normal.jpeg";
            "profile_image_url_https" = "https://pbs.twimg.com/profile_images/2547644787/9a6zws3bij528szrnw8z_normal.jpeg";
            "profile_link_color" = 009999;
            "profile_location" = "<null>";
            "profile_sidebar_border_color" = EEEEEE;
            "profile_sidebar_fill_color" = EFEFEF;
            "profile_text_color" = 333333;
            "profile_use_background_image" = 1;
            protected = 0;
            "screen_name" = kaustavmitra;
            "statuses_count" = 422;
            "time_zone" = "Pacific Time (US & Canada)";
            url = "http://t.co/DZgiJ6d7";
            "utc_offset" = "-25200";
            verified = 0;
        };
    };
    source = "<a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>";
    text = "RT @kaustavmitra: Whoa! Just got RT'ed by @wadhwa to his 1B followers. Feeling a bit like this. #startups #fanboy #beatlemania http://t.co/\U2026";
    truncated = 0;
    user =     {
        "contributors_enabled" = 0;
        "created_at" = "Sat Apr 18 01:41:08 +0000 2009";
        "default_profile" = 0;
        "default_profile_image" = 0;
        description = "Appointments at Duke, Stanford, and Singularity University. Former entrepreneur. Write for Washington Post, Wall Street Journal, LinkedIn Influencers, ..";
        entities =         {
            description =             {
                urls =                 (
                );
            };
            url =             {
                urls =                 (
                                        {
                                            "display_url" = "wadhwa.com";
                                            "expanded_url" = "http://www.wadhwa.com";
                                            indices =                         (
                                                                               0,
                                                                               22
                                                                               );
                                            url = "http://t.co/lRlMZPDph7";
                                        }
                                        );
            };
        };
        "favourites_count" = 1299;
        "follow_request_sent" = 0;
        "followers_count" = 48129;
        following = 1;
        "friends_count" = 369;
        "geo_enabled" = 1;
        id = 32718488;
        "id_str" = 32718488;
        "is_translation_enabled" = 0;
        "is_translator" = 0;
        lang = en;
        "listed_count" = 3069;
        location = "San Francisco";
        name = "Vivek Wadhwa";
        notifications = 0;
        "profile_background_color" = DECAAD;
        "profile_background_image_url" = "http://pbs.twimg.com/profile_background_images/851748712/5be9845b6f6053ad57702fef56577c22.jpeg";
        "profile_background_image_url_https" = "https://pbs.twimg.com/profile_background_images/851748712/5be9845b6f6053ad57702fef56577c22.jpeg";
        "profile_background_tile" = 1;
        "profile_banner_url" = "https://pbs.twimg.com/profile_banners/32718488/1365986345";
        "profile_image_url" = "http://pbs.twimg.com/profile_images/3755159314/f5c832f044b2cf7ff45a73fa13503dcf_normal.jpeg";
        "profile_image_url_https" = "https://pbs.twimg.com/profile_images/3755159314/f5c832f044b2cf7ff45a73fa13503dcf_normal.jpeg";
        "profile_link_color" = 053485;
        "profile_location" = "<null>";
        "profile_sidebar_border_color" = FFFFFF;
        "profile_sidebar_fill_color" = F6F6F6;
        "profile_text_color" = 333333;
        "profile_use_background_image" = 1;
        protected = 0;
        "screen_name" = wadhwa;
        "statuses_count" = 28984;
        "time_zone" = "Pacific Time (US & Canada)";
        url = "http://t.co/lRlMZPDph7";
        "utc_offset" = "-25200";
        verified = 0;
    };
}
2014-10-31 21:11:09.504 Twappy Birds[14708:106602] num tweets = 20 -
2014-10-31 21:11:09.504 Twappy Birds[14708:106602] Tweet = Tweet: <text = RT @kaustavmitra: Whoa! Just got RT'ed by @wadhwa to his 1B followers. Feeling a bit like this. #startups #fanboy #beatlemania http://t.co/…, author = User: <name = Vivek Wadhwa, screenName = wadhwa, profileImageUrl = http://pbs.twimg.com/profile_images/3755159314/f5c832f044b2cf7ff45a73fa13503dcf_normal.jpeg, tagline = Appointments at Duke, Stanford, and Singularity University. Former entrepreneur. Write for Washington Post, Wall Street Journal, LinkedIn Influencers, ..>, sender = User: <name = (null), screenName = (null), profileImageUrl = (null), tagline = (null)>, retmsg = (null) retweeted, retct = 19, favct = 3>
2014-10-31 21:11:09.508 Twappy Birds[14708:106602] Warning once only: Detected a case where constraints ambiguously suggest a height of zero for a tableview cell's content view. We're considering the collapse unintentional and using standard height instead.

*/