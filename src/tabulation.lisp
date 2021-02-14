(in-package :cl-hashing)

(declaim (type (uint32) +seed-32+))
(define-constant +seed-32+ #x90c9c730 :test 'eql)

(declaim (type (simple-array uint32 1024) +table-32+))
(define-constant +table-32+
  (make-array 1024
              :element-type 'uint32
              :initial-contents
              '(#x2d8918b0 #x76fb29b6 #xcc10e64a #x5a67170e #x9c6cfb40 #x3ee89ef3
                #xe897c22c #x5f917b26 #x43e37aa8 #x3059986f #xa6003310 #x58033868
                #xba8b1c3e #x51f47b21 #xbba85816 #xa060527a #x1fd6db2c #x077e2aee
                #xb10659ec #x9d6ee114 #x5dc40df7 #x5ad82990 #x139bb041 #xfb408ce7
                #xbe6554dd #xa72b0f21 #x05bc06e3 #x40bb150a #xf5a334ca #xce9cbb46
                #xcefc42d8 #x9c59ff84 #x008579e3 #x4a1b0a1a #xd537fd26 #x58a0c30a
                #xccadd366 #x7e690070 #x008f8f1e #xb567332a #x247569c1 #x1fc46e72
                #x6bacb8c9 #x228b9013 #x9c8b8b11 #xf40f7ac7 #xab69dca4 #x58df7e91
                #xd2eb4d4e #xd6de3125 #xee8a4356 #x8de86961 #xd4c06399 #x6f371978
                #x8582fd56 #xb83ce538 #xbb895591 #x65e60d46 #x64996ee8 #xf364eb11
                #x3b8ee068 #xe60eb3f5 #xdcb0cc1a #xab2ec5e3 #xbcdbdf4e #x8061e1b1
                #x3a66eea4 #x51409ede #x5be78fd6 #x73d4dcdf #x4ed676e4 #x7116cead
                #x62d219ad #xeb0d0f40 #x356d3ac0 #xa90a1241 #x7f5ab26b #x31945af0
                #x85cdf9a9 #x945f901e #x5050a79b #xee014038 #x796f8dcc #xe4267e51
                #x3c5136db #xf8c792e5 #x0b74b902 #x20629853 #x2769dfc9 #x2914a651
                #x72600c03 #x08d01941 #xeb2af4ac #xeca78c41 #x4ffbe0b5 #xc4d2a063
                #xeeed310c #xa5a28421 #xc2f38060 #x88e6d66a #xcf0d8d52 #x6a381ff6
                #x895f0315 #x67a18736 #x9978e81f #xaeed8741 #x4c880c17 #xa0948e82
                #x26236f4b #x8cedf01d #xa51800cc #xcbed6676 #xead8d08c #x72f1b4f7
                #x56259dda #xebc2aa94 #x91ee695b #x60395123 #x659bcb83 #x3fb2db64
                #x5d7d9829 #xa3ce5f2f #x1b6493f9 #x6f0f7401 #x0a8b2b7a #x4b877c0d
                #xeb8ea7fe #xcae2af23 #xac767d34 #x630e1a4c #x1a5ce408 #xe51731a0
                #x99a86c62 #x47bcb5f8 #x1e73c877 #x54a03fb2 #xcb019644 #xde688767
                #x6e4d9d34 #xdedbe323 #x368961c5 #x3382c2b9 #x20796cfd #x8152dc9e
                #x416b5273 #xad436a3e #xf81d9ce4 #xe6fbef26 #xaa4c0794 #x4e39b086
                #xee0ea69f #x9d473475 #x1b4b834f #x808b2cf5 #xf4db5da4 #x1133961f
                #xbce70bc3 #xeb9c0165 #x166df3cb #x29b44ca5 #x20a79357 #xd387feed
                #x737669f1 #x855de47b #x9cf13b1c #x3493a70b #x2a9de624 #x3c3f63a5
                #xd5c130b9 #xce375399 #xe05c9f57 #xbbf68c80 #xbda40d23 #x9b28341b
                #x095cfcda #xc583b762 #xfad73c1e #x0b068a26 #xbbc01294 #xb0880746
                #x6be69e08 #x10d8556e #x7435b3aa #x3ee93f80 #x4628003a #x7df6562d
                #x120a4372 #x26f60116 #x01cd3122 #x817a71e6 #x678d0d1d #xc1a4f7ca
                #xd1ed89c3 #xa90e427c #x7aa3d075 #xca2a3251 #x076af17c #x94ffc6a1
                #xe4e2d929 #x204920fa #x6d4261fe #xeaa6c2bb #x4279face #xbaccd933
                #xf999ee42 #x1b44eb8f #x9f7be2b1 #x852be5bf #x129fd394 #xafb9b03e
                #x9fec21d7 #x6577904f #x8c2ec069 #x41868a9d #x7016c63b #x46821da2
                #x9f9befb0 #x6e311a3a #x8db2b9cb #x7f00fc4a #x7e0a425c #x5b892622
                #xce5cce56 #xc662aaa7 #x3a4feabc #x1cfc0d23 #x86f687cc #xd9e8d8f8
                #xf9fc2e1b #x6e82e52b #x4ab50e13 #xed008152 #x87cdd533 #xc20ff57f
                #xac521f48 #x4c398099 #x02528670 #xab88ed90 #x88ec4657 #x3e58e965
                #x2af674c3 #x0065c6c6 #x05075a53 #xb86396ad #x5d22cc87 #xfd232ad3
                #x9d345b49 #xb524d9b0 #xf3cd823d #x01f15919 #xb14cd5b9 #x84d34d4d
                #xfdc16d17 #x203d1085 #x22fbbcf7 #x777516b0 #x52349353 #x7c0bbf8a
                #xc4620eba #x9b93f870 #xbe7ae52d #x95b9c4e7 #xd49919bf #x6818144a
                #x2e264945 #xe1a21197 #xf21c5485 #x89133296 #xf628639e #x0a09d515
                #x4b9a8680 #xc1110198 #x807ad091 #x96499e8b #xcd695862 #x0b06f589
                #xbc0303f1 #x1a3db746 #xee930966 #x9aeac7cb #xe9dbc4b6 #xbe8b16c7
                #x877ed73e #xe0ed67e9 #xe543f100 #x7e7fa71c #x4c2ad6e9 #x13774b22
                #x7008608d #x5aa08fcf #x625e070d #x89fb688c #xf47ab798 #xa46edb1a
                #x8855066d #x3c051a92 #x2fc75706 #xa9416579 #xfc62f8c0 #x278a4d6d
                #x9b4d4b6d #xff42fcfe #xcd0891dc #x09f6805c #x86d88cb9 #x43dbc216
                #xc1e458ee #x4ef5bec6 #xa2136110 #x4d0182a8 #x0d253bde #x88d00ec3
                #xc80b14c5 #x052c49ea #xc5f3bb2e #x45a95db6 #xd6400804 #x7db220aa
                #x1f00d0cd #x90d6ff1b #x88d485f3 #x97945026 #xce0f0ee4 #x11f54a27
                #x2ddd3fd6 #xc38a91e4 #x396ebc09 #xc79834bd #x4d25b1bf #x593ab6fe
                #xc142d516 #x4af8546f #x1125d3b7 #x0e708e51 #x34d14a97 #x17c35cc0
                #xdf462316 #xf6587d56 #xc1059fb8 #xb840ab2f #xdfd95acd #xa4daaf6f
                #xde90498d #x9ca7829b #x2c58c58f #xe12a15af #x78d7105a #x3d512da2
                #x5f1a701e #x510544c5 #x85d64a54 #xe6885c1c #xa7d26c59 #xe252902c
                #x9f73104c #x1e4c2851 #x279420bb #x83973c60 #x1c915140 #x7a94353a
                #x393c5be5 #xf7e86371 #xdd70988a #x6f2bfbfe #x16d50817 #x45eddc88
                #x6b066b83 #x7b35923e #x41c68f25 #xec0e520b #x2914db2d #x53c22fdd
                #xd5352983 #xb69d8027 #xaa3628d5 #xda1e0888 #xf8f6e4cb #xe55a241f
                #x8ea30c30 #x12922437 #xb0525bd3 #x3e035407 #xa14c1623 #xba357890
                #x2301b3f5 #xc35e25be #x86436087 #x4f3f1cc3 #x8a0b783c #x41228a7d
                #xfb3e23e3 #xbf5a5d08 #x42becaf8 #x698c96fd #x54bd326e #xaa80817b
                #x9c84cae0 #x2e97f9b0 #x57c76714 #xb4161041 #x23f802a8 #xf2b2729e
                #xe76a86b8 #xe01162ed #xd4242b2c #x8598d811 #x417ba1a2 #x412c087a
                #x41ed5fe1 #x54e78b57 #x2de68e37 #x72fc0049 #x337d0951 #xbe08465f
                #xc24f2430 #x12ca7dde #xc0163984 #xa8ebdd19 #x352fe818 #x22153af6
                #xecedcb83 #xfb69c273 #x549be91c #xe88b71bf #xcb4719e9 #x0085ba34
                #x16e617e0 #x4672c0e1 #x1495ae4d #xb0ee252c #xc2ba60da #x9160c261
                #xabf16253 #x5fd84b45 #x03ac2406 #xe0f2aed9 #x923121ce #x8df48512
                #x05192ce0 #x14e3c9c3 #x856ddd36 #x1f08a0e6 #x9b01308b #xc73d87ed
                #x8edc9bda #x5ebd2c26 #xff13f7cc #x92f81c0f #x9ad17067 #x3a26a198
                #x83747698 #xc719e18f #xb90fca98 #xe97af92a #x71545cb9 #xe458a3d4
                #xc96cfcee #x3644fb59 #x620fcfec #xc390fe00 #x8c460a4d #x2bb4a6e8
                #xe3e983d0 #xabe43407 #x77a3e05c #x78e6dae2 #x534b29b7 #x3738766c
                #xdb44d455 #x09ca674c #x2ad9906d #xd06e7573 #xcd8eee93 #x8195e236
                #xed750c8b #xd6dc61ee #x3668076d #x4fa5be6b #x43b9984c #xf958058f
                #x74292881 #x680092dc #xcd42a0a7 #x191e3db4 #x5b8c4a6b #x69fea329
                #x0b857880 #xb5571c59 #x98676478 #x7c989bc9 #xe7c53017 #xea197845
                #xad5aa5d3 #x7f6a1ffe #xeeaeaaf8 #x81bd7fb1 #xeeb5bf05 #x2d63bbed
                #xc74d7a92 #xf43c1504 #x1ba57bbb #xaae7cee7 #x0ad0d751 #xda3710c5
                #x19a08a9d #x1a1f1eeb #xb27ee88b #x3763ba7f #xde8de9f5 #xae970eee
                #xf8493e79 #x8dcf0118 #xe106144d #x384b8bc5 #x75bae9f7 #x6adbc7a8
                #xbef76524 #x43b39096 #x12fde0dd #xfe60ccfd #xcdc7df22 #x6312525d
                #xd13076d5 #x28d49f6a #x831c5bc0 #xcc7afc77 #x09dc1751 #x1ba903ff
                #xfa0e3c76 #xe29cb7d5 #x1fce0899 #xf456e499 #xc9482849 #x7d929b78
                #x977750d3 #xf9ef8e7a #xa1f1fd65 #x91334052 #xe26e95fc #x362f1230
                #x7a86c84e #x537f0248 #x43311f6d #x09c1af59 #x60759532 #x9b703f0c
                #xfaafaf3e #xd8654c41 #x8583e239 #xe2887e21 #x3a0c2990 #xe59d6fa3
                #x9d7f9238 #x6a3ccedd #xa054fcb8 #x43f4f701 #xd9c536dc #xa275e35d
                #x5493f8fe #x1eba9f68 #xa61448e1 #x4278612f #xd13e7f74 #x57d0c52c
                #x48e2e436 #xb0cd10a3 #xa6b38e79 #xb50d64f3 #x06ede8de #xea6ca918
                #x920509e7 #xb0460e1e #x8b0753e7 #x5e9c9d8c #x31e2d2d7 #x7a03a99c
                #x88942ff2 #x503156e8 #xf2840bb3 #xd34cfb3f #x225c4d30 #x609421f9
                #x625769bd #x822cbdf6 #x3440b35d #x93876a8d #xb105f7e8 #x6dc6dd48
                #xe22d736c #x664b5c59 #xfc1dd4a1 #x5d159c38 #x2cc53705 #x47b987f7
                #x6bc06798 #xc69c0638 #x71874d42 #xd1b95484 #x73645d48 #xc11cd3d1
                #x93690b06 #x65833245 #x86acf2e9 #x756f9d02 #x0c1050a3 #xc008d168
                #xee52276d #x2a0f57d0 #x78a52656 #xc5cad943 #x2fda5fa4 #x030f830c
                #xaeb3a1ce #x8a91960d #x07ad79e1 #x38716bba #x50fc036a #x5577b25b
                #x95da5040 #x493343c1 #x62a80b36 #x82ca75d1 #x10423bb5 #x2c3912a2
                #xc8efd465 #x817ef044 #x64298f49 #x79b04ae2 #x8d091146 #xf82dd0dd
                #xc2e29c0f #xabffcf14 #xc7b1009e #xc6843a5d #x685d5747 #xa1a33fe0
                #x5efbf0ad #xcf068707 #x3a5e7910 #x162c3035 #x5f134d94 #x68eb9ca4
                #x17c6cba7 #x39a8964e #xd328382c #x02a3b744 #x26ab2e83 #xc9ae246d
                #x25923e09 #xc54e3a8f #x716c01c2 #x53c32cc7 #xf16f28cc #xbcefc4ea
                #x222c4660 #xe6d199c8 #xf3c75c59 #xa693bb53 #x2e7d372e #xef0b6c5b
                #x1f041a4f #xe23c2f80 #x4801611f #x1d006d32 #xee11ea67 #xc15cda5b
                #x14af2a90 #x04fe3e00 #xa8237cd7 #x6ad785e5 #x81a96944 #x4eda8583
                #xeaffcf4b #x5b756dd8 #x1c3b6f59 #xd3053280 #x75db7592 #x8e4e4148
                #x975deec5 #xddb94ee0 #x049dfe51 #x4821453d #x791bf805 #xdc90a172
                #xf16ffa72 #xa82a9511 #xa9f2f590 #xbbeb5b63 #x856c573f #xc81eda76
                #xb83e581b #x0c56c49c #xea6b0ee5 #x8a06069c #x2e38aa9a #xe224a707
                #xfc28a2d0 #x9910f182 #xba09fde5 #x80434436 #x161c3d96 #x3da385a7
                #x739797e7 #x89d4f2ab #x188de293 #x0191c201 #x9eb340f0 #x3db82580
                #x069c4fa9 #x9e37299c #x4cd896db #xa4557c33 #xefb587ae #xbd8944f8
                #x0e53fc32 #x9d428c41 #x19cd3d74 #x5f825400 #xed8d4e78 #x417b4f14
                #x38f838d2 #x643c12bf #x5a838597 #x0ddcfb6c #xb2815295 #x76468121
                #xcaf6aa28 #x5708b66b #x7377acb4 #x2125becb #x4ca8f73b #xa42fb75f
                #x556bff18 #xdf731a68 #x0bf1eb6b #x003cc095 #xb5dff71b #x9cd2cfce
                #x15866dcd #x51583a8f #xd78ab2b4 #x24b77d3c #xb6f5933c #x82f17355
                #x6970f892 #x429c21f6 #x80f23323 #x1e83d382 #x0a19a29d #x2d0285cf
                #xdaa7a6e6 #x09a4b456 #x7322ddc6 #x4469f032 #x2c37af18 #xb4d70d37
                #x9ed5454e #x3fc60809 #x5725cc94 #xa6c5d4a7 #x225134f1 #x66f6cecc
                #x2d811242 #xfabf7ae0 #x18d7abf0 #xba74961b #xc229ad58 #x82c891f4
                #x310189f3 #x52888b94 #x7d994f96 #x47adb63a #x463c914e #xcae1a38e
                #x29b2e928 #xad9c5651 #x3dd8500d #xa9920d51 #xabe9c9e3 #x966f62ad
                #x0abdf8bc #x8f47a72f #x57ccd7d4 #xf6d01ea2 #xb7569abe #x8416ee32
                #x7a75b6c4 #xce1bc54b #x10f1d79e #x0ff1db57 #x4fa3aa34 #x523c1fc0
                #xbad33913 #x2c8dfb9e #xd3a91e5a #xcedca20d #x0c4ebdaf #x8c6b8608
                #x03a3af05 #x76811fc4 #xcf8d8e15 #x682b13c3 #xe875ab85 #x9c7cdb15
                #x6990e4ec #x1eb45e49 #x20e54cda #x24a63a6b #x83ce4622 #x377bb847
                #x39de1ace #x3f018e28 #x7291accb #xf6afdafe #xa7e48a5e #x406679b8
                #xc5f941dd #x7036f892 #xc29cbbe7 #x8facb5ea #x148980c2 #x0a22ae8a
                #x804f160b #xd26dc99f #x354980fe #x0d085b07 #x5db3da0d #x1a068b30
                #x0a6d0df7 #xf88441f2 #xfa7b96f1 #x23b7fd82 #x98dffabc #xc562f21b
                #x46e5ff65 #xc2646afe #x98908a5d #xe07602c9 #x82ca99e9 #x2ee723ac
                #xccf18023 #xa13884dd #x31a6b84a #xc10c8cec #xa4345e5b #x4c2f9149
                #x42244edd #x4c41bd2b #x6ce15041 #x3551545f #x4eb47656 #xda7e254a
                #x963188c2 #xcf9ab293 #x3665fc91 #x2eb5fd1e #xf04d991f #x2b9912dd
                #x44b76601 #x80c648d4 #xd4dc8518 #xb0742cac #x8c90f1ab #x46677347
                #x5b05d8ba #xb0fd0b6d #x1c64175a #x67a7e5ca #x89b73187 #x001e92e0
                #x5af0fd34 #x6decd22c #x755385df #x1ed060cb #xdf9e4a58 #x7f123261
                #x7f903408 #x7d34b8e5 #x069ef3b7 #x0f14b569 #x0468075a #xec2e1279
                #x90364817 #x65075f5a #x48fa16be #xc09e78e9 #x3ef08cdb #x03cf9a44
                #x57cd6325 #xb480f23e #xd47d12bf #xffe27869 #xa86b3be0 #x278757b5
                #x2c06fafd #x3fc46178 #xde85a0a3 #xef91ba02 #xa091547b #xc794509b
                #x6e77048f #xf79e93be #x58781fb5 #xb6b9bf00 #xc3869028 #x75afaac0
                #x0f5d617e #xd74f4e5a #xd690120d #x20ac9dd1 #x161eda94 #x83adef91
                #x76ee6a45 #xf277ff8a #x0adb81b0 #x1ce9be90 #x98a17270 #xf4d3b87d
                #x1541fdee #x5ca5abbf #xbc547c3e #x56befacf #x1a5707e2 #x49634b67
                #xd29aab24 #x119da1f8 #xba631f9d #x81e4a999 #x8aa0d6a7 #x46ee874d
                #x936aae75 #x1a14a251 #xa63e3e40 #xe0d4f411 #xb59a8cb4 #xc6f50eed
                #x871843ab #x3b97199e #x95976b31 #xd1467ba2 #x5331840d #x094aface
                #x1e31bd6e #x07332382 #x048a9447 #x92997441 #x9e3d6bb3 #x23b9208d
                #xc9369c0b #xd3cc11f5 #x523024ac #x849811c5 #x5a06ba3c #x201fbd1c
                #x1792fb10 #xc62f5732 #x9f104e02 #x2e65cd75 #x128bb3b3 #xd95d083c
                #xb6180117 #x7a90529e #xce41b312 #x18eb263e #xabab3a2f #x456f459c
                #x8d2625a6 #xed52e95b #x1c26504a #x6266796a #x74cabc2b #x0586bcee
                #x338c9cc2 #xce53a922 #x22affce3 #x2f8fac2f #x3ca95954 #x804133e4
                #xecb5b0fb #x93ca1a12 #xaf9b9cb0 #x9793c58d #xf0f4924f #xf648e282
                #xeedc3ce7 #x20ed5436 #x88a153bb #xf40c6c2e #xd7b45916 #x26347f40
                #x0b72adab #xda98707f #x3ba23919 #x5c1a29e8 #xf61e2120 #xecb43b96
                #x08671023 #x560791dd #x2099ee1e #x4c37b8b4 #x94110c0a #xcfaf94f9
                #xc1fa23b6 #x928adf52 #x40209ffc #x2cd09df7 #x25638320 #x3c8d98b8
                #x2db603ec #xfc8cdf3e #x9f13b65a #xf676bfb7 #x73f75f36 #x11b41186
                #x41e07617 #x8432453a #x2cb0c59c #x55204b2f #x2627fcdf #x0cc98e0d
                #x0aae8ce4 #xad3d77f9 #x9f8ece80 #xb1d69e6f))
  :test #'equalp)

(declaim (type (uint64) +seed-64+))
(define-constant +seed-64+ #xbf60ad4d64f8b0ba :test 'eql)

(declaim (type (simple-array uint64 2048) +table-64+))
(define-constant +table-64+
  (make-array 2048
              :element-type 'uint64
              :initial-contents
              '(#xbf60ad4d64f8b0ba #xa87db0db405b3938 #xa6367653a4da6670 #x38ecdcdfb573be31
                #x5b0b47f68e97b0ea #xda3a4f4ecf2a1273 #xad5cb840a0614bc4 #xcff95a40ac9bc92f
                #xd9c42feb94042cdf #xe35205490808ce4e #x064b8fe62fed1cee #xf510c8620998bee9
                #x0863d61d5a74ae5f #x6536281befe69e80 #x054a07434aa69801 #xcf9f11c4e15f4e0e
                #x9a7f9c6cd4545a7e #x2d3d981a714a5a99 #x653652228b699d47 #xd8ad06f278e41e29
                #xff06244821884964 #x295280e517eec866 #x4d5cf105cb987e76 #xdb81ce2165e522b7
                #x32c75f9c3eca7b75 #xa489853927fc6f5a #x6ffb4b813039ca46 #x1e5e3fd187a99c35
                #x6ca4386e86106372 #x4087086a569c8c22 #x3a6688f184ce0d25 #xf14a29ffb0dca90b
                #x689d0c589d066412 #x57b49a8c16e6f087 #x30e20f412e3d3717 #x3a606b2aecc37be8
                #x9715d5cf517a5753 #x77fbfa3f2a1bc2a0 #xb8129ed33f15f979 #x06e51350ef8a117b
                #x8cc3196b97f06b9d #x86e3bd777b65391b #x961b1fb98ad7e4bb #xfcd090e30e81d058
                #x6ea71c3295fdef02 #x98ae9b00b02d6c41 #x6054e569799554d5 #xd7cf86e1bb04f805
                #xe4474df9a0d61a4c #x83ca08809ffe17ca #x8af991162b7b8263 #xe1683d627c4f81a8
                #x646fd6827bb4866f #x61def2c5edd66c29 #xa297a8b774c7ac70 #xd199cab9e92cd47b
                #xcfe1f0336abb037c #x9ff47a8267ccc142 #x25892f95386881e3 #x022bf416af8d64bb
                #xcdb1d8435546c58b #x6e33533ec34c95a6 #x7512463fde2fafed #xf52b81af19287e8c
                #x2bdaf0512787b2ad #x88270379f9f1dfcc #xf7f9a972fa779744 #x89c0a6db664c795f
                #xbcbb89744898879f #x28885394d6171c92 #xee31a564146ebbe3 #xe3b59098d69cf39f
                #xff774efa7698898c #xa08aec993b756a77 #x245967ad71ffaa58 #xf6190578a5ca414c
                #x78af6915109097e7 #x53e57e2f67067150 #x4d5dfb81ac14cd82 #xd8086dc1727e46a1
                #x28cdf5725ac18dee #xc11283f131034133 #x396f962cb0894b72 #x760aa3973e0eb6cc
                #x99e12503d90ef26c #x3cbe0ee9c5754a20 #x3e8c7214f410de3f #x9bb19e12822c312a
                #x1ce73702b613eca2 #x9cf98c8ea7b8fec6 #x201a69d765e02ef5 #xe63401d619551563
                #xcce035a6a4b985c2 #x0e5f832361b58baf #x644e3dcc9473ae39 #xdd9a21b35ea011da
                #xf363d2e6608e7fe3 #x4c2229c5ddcffeba #x71390466cf5a33b4 #xb1d45b04c4f65d0a
                #x856150b8fd6c4903 #x6b4f3eb80071ba7e #xdc7010d583b0ff1c #x282dc71f96a8662c
                #xe3185541085914e6 #xa345a358e2e43b42 #xcd4675e3767a38d6 #xfadd8af110978285
                #x17100b823380e557 #xb22f0cf394b12006 #x3b5a89fab5807dc7 #x1dbe40ce3807486f
                #x4675c32a3ba6bc5d #x6de2aaf6c0425f2b #x355b2bc2cfeca1b4 #x988d725460c5d8a6
                #xfcf2bdcef84c8e10 #xd8c1a3df30e63c0d #x5588fecf944b5043 #x4be0d29703d2cfc8
                #xa3afbf0ab206b6af #xe92b682fa2f4cf98 #x61871942b6308901 #xfe7ae6d2a2daebd4
                #x714ff0b11d2f5ecb #xc95aa6eae7d423e9 #xba2b7076f7f57b27 #x25a3b0271735e54b
                #x753fe25e65ace4d9 #xba6511ae7d6ca57d #x0f20253d42d24ac1 #x053dec72881cb192
                #x78dd51aaccf47fae #x319db0e3626fcddc #x9e02f15e22f685ee #x0b5d51df9fa085a2
                #x5149e09f81ce3be4 #x5a4b78adf1b4f2bb #x83695dec467ba5a2 #xa339b0f7ef8c7850
                #xe31c1dbb496ea924 #x32c534efe236bfbb #xb7120e3f43a7fe0b #xfaf4bf756cb48fe2
                #x72b06c8ffcf8d12b #x59233ec64a3b4dcf #x59f2208f8a631cb2 #x30c3994f4d5d31a4
                #x0bd944d5f433fb2c #x3d103ef836065b59 #x0af9db6b62671d22 #x07f80ddc454f6ff3
                #x1c486fa62b420fa9 #x6d5cf49716584f34 #x3b666201b16b7e10 #x796f25c36354fc87
                #x80760ebddc05cfb6 #xba10c34681898f04 #x4168db20e7c15fff #xb2a0a41b1f45da09
                #x3db6e54401f71a2b #xb46442159ef0223a #x7806a4be6ddfac94 #x8c3f4d6a8bea5271
                #xef2e77358c426c9b #x4f4f7831e4231b27 #x0d29f7ead0c71ff3 #xe295e18190796226
                #x0fc17c08f0790a20 #x25f26ec1d8aa8b6f #x873ca6922db620d9 #x503686dc64ef6f32
                #x6e1b0458d2cea386 #x98c9bf963775d873 #x8544afa5bb0d633a #x80f5d0c184fc2447
                #x7fd42c7b34aeb6b3 #x3f866464afc7b83a #x811aebce1f527ec0 #x8b8cd5d73ecbcefb
                #xf95fe945b961a89a #x0c9446f51c94221f #x6a8e00cbd73623b4 #x589f473836f1cba9
                #xc1091e453c0b743c #xd36a0377ea6ffd45 #x50c2d1d96804a86d #xc6bf8f67d135c90c
                #xc7d49f8f8d3fd2f4 #x64181e05dab12e00 #xb14d123328ac3061 #x8b1eb5da39f470b0
                #xf802e77a702d7278 #xbcbf1dcf60d906e7 #xa4e8da2daa79d128 #x458f4bbfa95a28ca
                #xbb22169b118c1a66 #x5d48096fceaa034f #x78b338a26079c403 #x7ea3713e00f4d6a0
                #x05502fe6dea8b306 #x1039554740bcfc3d #x5027a0c1b9c51191 #x70f383b9754e21ae
                #x8e1fe9001b1f358d #x9dd82e5873a5a0b6 #xd5a334a7534c712e #x482c9be20d11cc47
                #x098ddc7393eea371 #xd00b470d3dea1954 #xb9f1ef2906461d20 #x6a9ba9312b8fb917
                #x05fb16cdd9e723f0 #x5161f1e0d08f39ca #xe04e7feb3457fc9e #x97bbdef0c537515e
                #xbc00b8299e8efaaf #xfb6dc3794969ddff #x494fe5981af54623 #x64be67732829f728
                #x72ccebd6d89d8a52 #xa44d62f0f88c8fb6 #x09316422ce9cb6a8 #xb349e1731f3ae55f
                #xd4ccf9d7e2b50951 #x873180bb83b4d90a #xb00166f51aaf835f #x27e4616bb2f0d0d9
                #xe82b55c9abb1c753 #x7ec7e96adb08b827 #x670b49023eb7a13f #xcbb96d33c0439f4a
                #x17ca186b5ccb9fea #xb96e68f35b4ff0a6 #xc64bdd47a3a8f56f #x55a49919c2fd334e
                #x32945de069fc8f74 #xc4c0093f744ab0de #x76c0487cfdce09ab #x5898fa8ee2797232
                #xbcfd52181461cee9 #x2d52fbfb841538e3 #x30c5a287d0ef0f61 #x7f25e1d28c34b8ef
                #xceec1deae7daf670 #xe110da079aaa224b #x7dc224d5aa9a8b40 #x70ad123d08374790
                #xd9f8422ba3d86852 #x1d7ca6b70c8317e1 #x720aa08c9ff6742e #x857d545c5b4ed18a
                #xa2728e2f6b89dfca #xae4755333753eeff #x23bb5d6aaf433013 #xe7f52e57f4803a31
                #x6aebfe28da0b60ef #x60c7767e62e07ac0 #xf4a25cbcb2672ab5 #x39fc6ae9a2428c62
                #x8cb5e8f833ae3298 #x432c9051d61a1e2b #x5eb71deff3977c34 #x6690860b894e9853
                #xf568f6437a4674f4 #x44246fd0a45bf911 #xbae4322a51bee89e #x7d4f2bd2341b4c79
                #x520e7c18d927ecac #x4260fed4f56a9dd8 #x4a460af6273d98c6 #x93e021b8175453f6
                #x3f6e5b4176e4aef1 #x1a01423cc8668b9b #x6ead5314d9479580 #xce0e0b09dd232087
                #x25c58c9ede7dd954 #xbaba7464ec572220 #x618bee9c2221fc5f #x8eb8de6a27bd7fbb
                #x598c71ce5aab98ac #x9b30f08a6f654663 #x02a69ae94deab765 #x470ef5a9d18f7137
                #x23d2618d7497c84b #xb07373961435c825 #x45e6dedfcd1ab818 #xf135fef816101569
                #x25b33c8247f66b9d #x548de40aa7941a89 #xa035277582fa1ad9 #x61be6ce12078b0b2
                #x321eaf7719be343d #x41e97580dee3e415 #xd2aed16937c86c03 #xb51b51cf86936ed1
                #x14aa3935d19943bf #xefdb22812d1e3bc5 #xe5daee412bb1f993 #x6f3d73dadebd7c55
                #xb2c66be63e5df0b4 #x5fc899e8a2b2c9d2 #xa43879ffd432c602 #xa60a27d7ae0c2836
                #xe858d2b05c7411ea #x9a1ba853f39bcc8a #xb5324addc3b4f6ce #xc3a3a1e0905c03c8
                #x4514c328aa251c16 #xd04ca888497de9eb #x06eb67b7e8262a61 #x6236f13e98cc8c02
                #x2f2754905245700a #x4cdbf82dc6c9faa3 #x6d67dfeba15bb47c #xb597368037143548
                #x36a7d649c40e84ed #x72c241c514c30416 #x34e11e2a0fe59fad #xd9019982aa0a1615
                #x3513ba5d7a566918 #x0ca2a66734228b36 #xe0e4d94135a80e43 #x04580841c49cd56f
                #xe5c97981ac9dc075 #x169b6eb2a2d2bc7e #x5f87206be9862397 #x0aa8aa690d156f7d
                #xec63ebfaba21314a #x9bbe74a6104fa3b1 #x7d8675fdaed48f1e #x9b78267687a4a067
                #xd4cfa2b929ef8de7 #x38220c0d4d19cd0c #x3cbcb0f544b12852 #xd9fcfcaa75d3f092
                #x8d917e2a872b2874 #x571483341be051ab #xd93d997035b623d6 #xa3d0bd7980401ce9
                #xff8a61119ec9b307 #xc19cb5159b37eb54 #x0873f0acdfa8319e #xb6e301b3e3507fff
                #x82e87f0663a75b94 #x3ce505a2f7296c3d #xd88079d45238a50f #x0fc09f31c79db9cd
                #x949a9015989dabfa #x1075c1f9f02d2153 #xad57790bfe2f2e79 #x5ccc751ba81d410e
                #xd0478a588d357307 #x3acd7d50deb31d67 #x44d85c5b8e236dd7 #xe0ea8cffca339f5a
                #x70061559498c1317 #x1adb778398b7d7cf #xc0e963d8bab26a99 #x659e335597a6a25c
                #x9ed61dcb3904ad6e #xa2014a101f733ff5 #xdea56ece305ff4a6 #xf5eb881dd567f9b7
                #xae324bbcb66a7ab1 #xea5069d84c0df09a #xcce9704b47140197 #xd154f43ca6941208
                #x974a33ffdeb04c28 #x0cef29b1285788c2 #x751902c71f20b2c8 #xf63c1d7f15355055
                #x517b9dbcf4fbf431 #x03d1ea7ddc69e8ef #xe5cc03b3bd8dcc77 #x43fe5d29680cc03a
                #xcee9bdbcee052eac #xeb5a315371912caa #xaaea9d54338d4794 #xb29608e0393a7204
                #xf0cf350328eca454 #x4f369452296d2521 #xd2bee8014cad8abc #xe123517f2f1e508b
                #x0b6b31c98916801a #x7996821aca63cc91 #xc0831a115f021d44 #x41cbf306f9bf9aa3
                #x400d10d7cc46f1ea #x6a64540219359d53 #xff3c8ce5bd2313e6 #x721faee1163278ac
                #xf87b9888442e739c #xf9b2887460d27632 #xde2862dd948686d9 #x1ce964b4ce7d9e1c
                #x156179c574f993b4 #x74e7a5ff153ddbb8 #x645b784e0ba04cd9 #x79dec8bcea249c18
                #xbc598dbbf201f891 #xd71f8ae2198f5743 #xfaec19de61ed4150 #x800ce68cc96dd3c1
                #x0a5ea18982100e94 #x41ae7a1869129e44 #x7fa7f5d5ea12b5a1 #xf738d6d0be4607d8
                #x5940ca37b6d754ff #xbd9d731bec28bf1c #x825388fd8ac12f9c #x8d7f33c268ecb1bb
                #xdfb5c8c58364ffcd #x2d71984952e779b5 #x3b25696580a03392 #x3dea8d4a78c1d1b1
                #x664ee9de8977fc55 #x7a136fc95662cdc9 #x2b8451af8491d651 #x34da8e36db766af1
                #x54f6a0bca38f990b #xe8e1ddff5642b97d #xf4577b3d928a5de9 #x02dee18365b82d1a
                #xedde025837b63992 #xc9a29256c1e66ecf #x0502302ee12b38dd #xb1180601a81f22cc
                #x6d011f8bd16684d8 #x24602cc34feef329 #x81c60b2337dc7b4a #xa12acfa8d3f1c533
                #x4b226307a6d95c79 #xaf5df22d402f55ff #x8c3b8803eeeace9b #x0131057a3c6790eb
                #x4fd8af7855312449 #x71e43a2ddc812c88 #xba73eccc217f93ac #xe0897b055e1eb9bf
                #xb41f15e8fe1b6f0e #xaf644ad33e974d54 #x75feed12325b3ffd #xff959c53d59dfa85
                #xb993feed0011b062 #x34669ece0be3b042 #xebad7f8ee0355026 #x9722702c0baad3bc
                #xe3deddd8b37342c5 #x13047eba4e8a13f2 #x628d28cc197497bc #xb57d4a6a93fff30e
                #x82e29fa75e6b8768 #x0ab2c3e97197e6ce #x214055cf5afe579b #x5276e5ebb7f88015
                #xe34a9cac80b8bb17 #x657827d46c19a06a #x8931afc0b1a3caf6 #x46ad90d7ff47b15c
                #xe7b91f9669bf968e #x3d3c5824a053e18e #x2eedda6ef63ff90b #xc9c440ecd1d7b8e7
                #x8b3a850dd491a661 #x74b9b1423eb61123 #x276ca8a5e17e5a3f #x164d302a54add59e
                #x87d67d3d11ba84b4 #x13e0974eaa3a6136 #x367bb867522f8b61 #x501d4be2d59eca18
                #xd299ba34a373d577 #x8d0ba4a6686f8cb5 #x81d638c9cebb3927 #x58a6f4f6d857f221
                #xb90bb09b4e6d1dc2 #xcbb5b628482c3440 #x9a38c075be3de055 #xc02a95f4b9c67abd
                #xd091869fa5b6a19c #x9feeb070821f9031 #x597b7497bdf49523 #x96a57190b5b4ab83
                #x4cedd3160bb457b8 #x143d0636effe332e #xc77347a7581186a2 #xedf0c10fd2187804
                #x44b5878421d90b26 #xfd95961586fc530d #x821f1db0792a1a65 #x4121189a5f2b1a8e
                #xcec09e911bbe0a02 #x93a1b642073ffb1e #x8b73769822840de2 #xd4e034e4fd11d8bf
                #x91ed7f58ae397611 #x08b539b506789b55 #x4c0bd2ed9fe8a8c4 #xc25c239a53ec3f89
                #xdc0bcb58e614bed0 #x8f901c772fb9944f #x9ca5957a7ba9aa39 #x7228908833385b89
                #x24550d1d9ff9a434 #x47c60eab68322557 #x21093f80c44cf176 #xa8c0107062d8155e
                #x01eab0e2e10276fc #xf077230b4ba519a8 #xf07e6fa4fafd550b #x8fcdfd416dca92ad
                #xcecc3e505bea8ba0 #xaadf3e1a57173498 #xf376ffe1f368127d #x44bbee4a96016731
                #x093fd3143e71135d #x4cb166eed5cc489a #x3e3d1d8ad3ea76e0 #xb23fddc4ddddfb4e
                #x80fb6b76b0917918 #x02e66a81e6e369b4 #x38cedc251875e64e #xa7d607d250f503d7
                #x9ac1a037c36b30d8 #x67f44ac0fb35381b #x53c0746f44e0eee5 #x6498bd1601f40bdc
                #xf92f7a9c1e57005f #xa2d104fd2dc73b1f #xfa6b790ea4b15334 #xa991fab19f06eb1d
                #x5469a99308896340 #xf01ee644f41a9427 #xbcdcc83d5653f7f2 #xcdef402d2acbaae9
                #x612dbd572dd90f6d #xd2e874092922eb03 #x13fa9df972d03000 #xc94c8456035255d1
                #xa6aa63490c0d5024 #xa56a4abc515688c6 #xe6df2f1daab51bc4 #xa82a3fab6011b6cf
                #xcf469bee15b890b8 #x271d3c7751bd5a77 #xf21f0a6e31af187d #x4ef9c841f349f57c
                #x380185706af54f74 #x25557239126b293c #x6cba4a8e72fc55df #x11ac0290adae54a3
                #x8f471cbbade73730 #x405195f698e6414c #x4263b4fc07c96d82 #xafedba2d74c74c62
                #x2f5760e7ad8cb2d4 #x467a5ca91e859f01 #x2ff9eed8bfc84ba1 #x3d467527e2010c40
                #xadba3603fe848356 #xfab8c57c9b4d80b0 #xbd7ba5fbf778eddf #x503011e046de1f2e
                #xd9d4ae6cbe97aa6b #x631f7d48b66c956d #xd3ef1730fef8195d #x48b1796b5365992f
                #xae3b2794e62a18b4 #xcfe7747ba8def6a6 #xbaa71e4de418435b #xf429a3b312e0c828
                #x9374f9774a873823 #x8d66c5ca797abd07 #x86816490c6e67240 #x4abfdfa9144c3a4f
                #x1fe9300afa3a6892 #x26e0d67a366dd879 #xb579cddf04003662 #xc192d185315eb3ac
                #xb67790b714693341 #xa93e92f35a000f43 #x389ae212ff225c91 #xa3958f59d22d035d
                #x6452994a899f58dc #x399e60bcbb4fd948 #xc6ee2a8785165a88 #xcafe74e3600dd542
                #x029b6572531cdd43 #xcc68a18729ff28e3 #x03b9af7c45881975 #x234f5af0a0d9b395
                #x698a7f1a3acf6ced #xbe6230566cc2e241 #x243bbdaff6fac14d #xfedb86ae539c91fa
                #x8d05b6a8738ecaa1 #xb811686024f1103d #x1e8565fdf0ab7d5f #x98b25b852fd2a3fd
                #xc4cd81a4d4afe81e #x365609f75340c0a2 #x07db0daff9247432 #xadecb9545d952921
                #x249a846d560b3c47 #x999541ad0ef8e45e #x3e810eed020bb970 #x61dec0f0dc716c18
                #x85cb0b04f11e5056 #xce4e1ee5402e48e8 #xb903304f3b435836 #xb62130e7be6d965d
                #x45d37d7aaaa2b7c8 #x7d0464d3b44b74e9 #x2514fae2b0d307fe #x5ec0a10fa9e5d1bd
                #xce1b8717bfa00778 #xaffc3d4ac0b86ac3 #x5e9fb2cd414717e4 #xa7c800f736be81fc
                #xf8d006415283fc9b #x875a2e1422244f11 #xa85fe4062494d745 #x5965dc63ac956fae
                #x1e6da0535f91be0b #x5c4ba6e4a7e67b53 #x974c0c4d434d05d9 #xb6af9618990e3d86
                #x3fa7386ebd6132ed #xbc562faa4eeb8880 #x2fd776e61e858112 #x7c651b483eecea05
                #x997963a6025fa112 #xdec9c9ad89d7e951 #xbd7c97babcb02f2d #x6c61000f00ff868a
                #x01712b73884b7fc9 #x08bbbf559fd67e3d #xfcccb21a29b9555b #x871559722ebcb60c
                #x04008a3153816879 #xd75add94fb752457 #xf7f3b8c08b9ee102 #x71782c0763a2cf6d
                #x91f3a6cf7eaaa8f3 #x282c736ec059215d #x5e4f515198f89e59 #x0213fbd610281399
                #x833e26b878a3c60b #xe917c78266dc270b #xce18f5541e44e9c4 #xee8429a5d1e585b7
                #x586ac5c6fe36d914 #x13926e747400defc #x3f3e1356ff74d8ba #x4ef09ddbaf30849e
                #xfdd5cb30ca607aa9 #x9282d82633920b3e #x77ae3b96352ad57b #x11734b1ce8a09a3a
                #xea8d6c0020c6d6ce #xdc289c69cb961312 #x0e926af0356aa522 #x4e5670a05774ba42
                #xee8eab7f260440b6 #xe1ef4111e9253758 #xd2b1518d52ab2003 #x4ef0a2d5032a16af
                #x1fb916551cd242b4 #x1469e769077163f1 #x1ec6cad49bf7a57c #x2c816597ce1b3f9c
                #x5fe76bb1fd74db00 #x965c3d556a053f11 #x1d150d86c7d99b26 #xae3f608d1e029a75
                #xe7774b97c36d3673 #x1c673b25e8b9b342 #x7404ab6be73e5d0d #x85e8eb1e607962f0
                #x6b7b3e9c53bb633b #x046e66e617e21d43 #xa2c4234f1398d63c #x6166af2cac44951e
                #xa22bfe9951ac3939 #xe06799fd8c1307fb #x96396168a9f0e855 #x411ea46d8f454a94
                #x2d726057d5d55567 #x577fec80cbec84ce #x0406ab2193737ed8 #x38c9db00a6998a62
                #x29a646e6ccbf3d26 #x2f679137ff583247 #x13af0309ead2dd34 #x3413dac778f1f38e
                #x13741feb096c43a4 #x132d35b07c8cbab9 #x7731dabdb790d978 #x50a85e9140c99b75
                #x3289cabb4eb677b8 #x9efa217b1dbba5d2 #x2209747057235d9e #xe800460d841ac53c
                #xdb564c62bdf47d9b #xf65c7efbc43ef5b8 #x302b505b2630fd15 #x87f51f982403a8a2
                #xca4bc9468e26626f #x4649c529f55ef68f #xe6e43dd44f4da2d4 #x2abd8b83f9d6f873
                #x7428264ae43b5c9f #x85ae12e1446bbe93 #x1e94277ae230ff71 #x9cc78d9e93b2ffa5
                #x55476a1fbd78cc57 #x5989d3f7831cfb3b #xd9fdbc39f86f3e17 #xacb3c24ced3ad37b
                #x07db7504f57414d5 #xfb960b36fd352fbf #xa9359b8ddfa35bc1 #x8d7e4beb3b580c1c
                #x500ca4eec94c1016 #x8234cd97f2d9f936 #x367fd497944e78d0 #x11e109722511bf05
                #xce7b0143c6fc788f #xbd715f9d3b539ffb #xcbf3ddc7a597b366 #x439a333cda8df2a5
                #x669c86c28cf7ce93 #x82f188b5aa07b9a0 #x6c3b71ccc59b4098 #xe434384c94d6af48
                #x1e6d6aa04e366934 #xfcb6df76bc99ba3e #x2d571fc450926607 #x0ecb41a33c45bdaf
                #x99bae435c588c037 #x7fc04ebea62d341d #xbcbb8ec5ecfb229a #x2253c1a974018b8b
                #x370cdf75c172efbc #xd8abf7ac374e204c #x757836e21fdf90cd #xb0df6b5943e0d537
                #x4bc655e073a72372 #x6da106c75584da1c #x882f69c3f575ae9c #x8ab50b2c1344a177
                #x62e0163e3de6d3b3 #x02ebea7c91d56226 #x95a315c32f9a8979 #xf8f32699a6fed9f1
                #x5b6b8523ab08f10f #x7b6abce5aae62e11 #x236aa87f80df7681 #x421f2561c476d11e
                #xe3309e38d28cdaa9 #x27509e684fea4ccf #xc171b0fbf2556073 #x24032bc35a459879
                #x510c6ee43af1054b #x760372312f1dec16 #x95fe36a2e7a3523f #x0b8dc3689b3b9a73
                #x29d88c1e6768b07b #x7ab7428b26ccc07c #x6a0284263089f814 #x00d838aced2ce130
                #x5b463864697fb476 #x50628d31d0372571 #x8183ccb802d2ab28 #xda037ff4dec4482e
                #x1e64e612a402e239 #xe1b12a0d346ee707 #xc00b95e9e760b87a #xc7d5d74a05f4f493
                #x958d16af13a84b13 #x2e0805efd3c8af13 #x404497c15103acfa #x43e7b09655b28d1b
                #xcced27843bd41cb5 #x06a5c76e0cc9f663 #x8151f51b1a821778 #x4d55b584361f4f2a
                #x7438c5f425dffbcf #xdef4caa22991b32e #xce5bc5e027638acd #xa8d64e78c344ab5a
                #xa1abc89849839d20 #x7c21d26747eb5288 #x7ba09a368a5162ae #xbe90b2305c65f510
                #x0f54afc0cd603ee1 #x907ac47274360cfd #xcc6449e49515889e #x25296e4a8cb8abf7
                #x3a691cb1b7d728ab #xaeb652c1e1b05bb9 #xc991faa030fa6ea6 #x3f0f512f729ba262
                #x8e2c71954458e0a7 #xc2df264a38e2aa17 #x59f6910e0b060771 #x7e0eada0d04b2899
                #xc5063aa82ec33318 #x17879f7ee51c12fe #x73bf6f7eabc1ed80 #x5487fe1ffa1bbf79
                #x3e3878b994626060 #xb7163b598f724a50 #xc37ef5403613b00c #x6b96e55f74fe2d1a
                #x448166ae7f0db561 #x3ef8148feda279e9 #x94fbe50b126a0ad1 #x8fd023d071401fd8
                #xb0cce9bdfd93344c #x7eee243517a96a64 #xe9caa57bce3f3d84 #x530abef6fdb5ee45
                #xd868c1e6d185fa84 #xbc17f9aeb2b3bc6f #x525bd9870abe6aa7 #x42a7f7678187d32d
                #xe7fab13096bed98c #x2a67c445b5eb1673 #x092d9edafddb9a97 #xf05cc6a00867dfc4
                #xf05ec621942f8051 #x924a23d150c69dc8 #xb39912c2a064154b #xa0eec89547f541a8
                #xf2ca644fe2410bd3 #xcec7d44020aa7c3c #x090363fccb86acfb #x493e3a1fbf83617f
                #xc90e03a79af5914f #xb5a5d8aabb94d75a #x08292135d7e51140 #xeb7a788c0d8fa00c
                #xf93dbd5e9c5999ed #x27c11d3b9e20ee71 #x30e12f1b1c970cd7 #x29d674bbc63c4be4
                #xd4b31d0fc6f2533f #xa4b491cd7ed728d6 #xbe85ba3f4f4fa92b #x0ec7379aff8cc9c8
                #x8adc00d2e186cff9 #x706eef18994df805 #xfb4b6914d5d3ad1d #x30372224a473e515
                #x0f5495c120dbb5a6 #x42893301e614ad8b #x030c22c758a20f90 #x8c1aeef7f2d846ed
                #x55c17ec823d4bde4 #xad5ef3ddc8ad65be #x7cbbcc60ecdfd9cb #xa5b5c46a6c006cc9
                #x8c69f55e7afecb06 #x0dd2926811de8f8c #x180bc5cca4d5e10e #x7e09c15b17c6d4ba
                #xd59d229b00c0bf66 #xe15b2d822f493274 #x1612068889762049 #x13478ad8a09e2552
                #x85b827811f601746 #xf597350b3175d7a5 #x0209e790f4d41536 #x169caa06ca22208f
                #xb984bfbf999ec37b #x3e9438bb1cd41cb1 #xc12f685c82274650 #x12a3f2903d3ebfe7
                #xe87daf005d8ce676 #x6aac650298155183 #x9548abc4fd6cc93c #xdb384a513b100a08
                #xd7febc19653de6b9 #x523cb990a5779d3d #x156c5ee7a1fe4066 #x203c66dd7120cc7c
                #x69aec19a14662012 #x04332c17efc2a916 #x574223e908171df0 #xb13010c9b345ab72
                #x33febcc56f10f5bc #x85a824a523af5612 #x8092c0e43493ee0d #xd98c03f868d39766
                #xabef4ceecf271d10 #xb9a6453e62643a6c #x141bf7b34ad8b44e #x20b443035e4100eb
                #x3f2a686849522db7 #x1c0df98341368869 #x12e5e9f7b1bb44bb #x21cbaad529b7aa06
                #x9fba9bb3b0cab46c #xceb056ae8bad8d9d #xcff851850c93247c #xffc0ba1045214ce8
                #x6c1f066975aa0aa2 #x5ef0c93dc13ee99f #x10a46ae0fa5f31b6 #xfd8a4af141079e01
                #x8d6d5354f1d27ea8 #x3fe0bbdf179c5c6e #xfdaf18ffb2dd93d3 #x322bdc69b040b01f
                #xa5dd12c47dd33819 #x797ae6a80a1ec64b #xb1298135b821422e #x21dbd67551a5feb8
                #x361044620f02f335 #xa9526e3b7367b984 #xa5fbc023c98750f7 #xb2babe1ced5592f7
                #xc53882a5fca62875 #xc463bf4c691d24ef #x7009611c017c8df7 #xf2490f4ca0185aa2
                #x965a413acfeb3bce #x585cfe22cfbb5027 #xd8d4951b66c16117 #x3bc994f4f5da9be8
                #x2a0ceae6544ba622 #xee38412eeba2e08e #xe0b7cb2b5ea5138a #xa6070ffae68d672c
                #x1492aa4a2646d10f #x66b0223963d3b133 #x365d6df4af90f4c9 #x29b279688c86711b
                #x7d134adbbabb228c #xb60c5e347246c3c4 #x7c7987ebbb0f6e8f #x640b423d087e7983
                #x4427a81f244e2620 #x63b342fa78ab7347 #x62f263ad7d61d29a #x4e5f299864b3d645
                #x6c695a4d19dcec91 #xff1bc7cdfed4426a #xafca28a0b0d2ce13 #x58e7e84db514c06a
                #xd12ee3742909d2c5 #x7f9476e5ed42d325 #x026c795eb302aee3 #x003ff9875a94b845
                #x5ad1996c23af78fe #xbf2a5bd7e2646b46 #x45d3bdbfc05b6de2 #xb48807369b64cb14
                #x08b38acaa8df80c0 #x56de6009ebab880b #x6b955fe977b17c34 #xb8980819590387d7
                #x9a25e39ccd91f942 #x5f9df34dd2ef9a40 #x4d21368c686e925b #xc47ce6d0a10d961c
                #xde68c334ecbd1434 #xe72e109e4a4e05d8 #xb8f8183687f91106 #x3270be2595d8dfc4
                #x0915e73a11649bf9 #xcd07ed5a4bd87d28 #xe6778baa1306c144 #x61dc10d0f0128853
                #xfb8b7e9cf26655b1 #xc043f4bb84d20696 #x0a60466a8e07bfa3 #x1db4b7577b2026ff
                #xc039e6c8014f3042 #xe4d139af02d86cc8 #x7af0bfc881dd9e85 #x8025e311f0e921c7
                #x45bf441eb7b41a0a #x18c02a8f07c9c6b7 #x32c9a855d843760b #xb9ddc02bea1dacfb
                #xa3abf9a341029854 #x9351dc932bd53ef0 #xd606147eee1871fb #xb3573cfe11bf238f
                #xff8afbba8a8676df #xb7dccda0d4621ab1 #x1626ae162f74d1ac #xfa5dc7af5197c0a5
                #xcacf34a03ea0e677 #x83df797f6b620979 #x6c2400ea31403b42 #xea62ff90b1f549de
                #x6be0f77a5cca503e #x51ee56209dc196cd #x3c91c1032faad3c7 #x5ff38875a2ae8991
                #x31963f04e070a029 #x4c6eec81bc95c92e #x546ba4ac7888db12 #x2ec21328eab7c9f9
                #x771be5aff0cb6004 #xa088ca4104438635 #xffb6fd657ff98314 #xf0d0caf45da8a2d0
                #x73dc7c8b9695851d #xacc9bcc6b0759734 #xb5e68689b3901643 #x9f892b391985c511
                #x9b9b6cb20a01834d #x36c7615cf2e16a91 #xcb03ddd6b0f94f20 #xa57930f5b6dffe84
                #xc20cf0b48e6f239b #xe7ce748fa734025a #xaa805b5361f3c455 #x8deb8820ca180621

                #x1b6ac93bdef14453 #xc5b2681e71ff6ad7 #x355492b1a1d9afff #x33797b77fe464ef9
                #x83d72162bf5536a7 #xe45a3e10de28213b #xbfc9e6df43a861b1 #x9b104732e83d2a5f
                #xf40046c08581c0f6 #x9f16fc3ef9b83e92 #x647633311a591a3b #x43797f326eeb0789
                #x185be451c6189f69 #x204f4ffe7a714d54 #x03791ab955659787 #x38ab7a13f670b32a
                #x000c4a7e2f6b7a44 #xb810bbb38bd26432 #x4b2361062c1bea85 #x1b73819fca612654
                #x520891b834cd0b38 #xad409572140a8eb3 #xf62482769a435e8f #x8dff2f025cc72ad1
                #x6699bf3ce7285783 #xa89a56057c4301b7 #xcaeaa73fb9dfd838 #xc8a64bec12d1419f
                #xc8d8aa844eb6a5c9 #x5d4e32f99f8e233a #x98fa9383ec211216 #xa3cd12ff3f7de81d
                #x345c0347929567bf #x72ca51bc410ca7f7 #x19ea340acb5f4ba8 #x8f31b558db40edf6
                #x85618dc521018879 #x43b5699e775a1a2b #x519b9a787b9bd3ee #xc66ae32fb7d58a51
                #x16f767799cdd6cd0 #xa9a0d78b948a3aa1 #xbfcf39939d7f92cd #xe163635b2f845fd1
                #x849704d9c3d76792 #x657d9b6874d4c71e #x77d75b8a76ece121 #x763feefff8d4ca92
                #x3f63cc3cf59d67f5 #x9062553e29c2846c #xb7f2dec843a399e0 #x01c3c8efdfac2fbe
                #x02a106aacfad226f #xed7944f60ceed12d #x8efa35ec98fa341b #x925fdf78427211d3
                #xa92b203e3fbeefaf #xff62e5746c109e86 #x6155c790853214c3 #xd24068d4a390c7b3
                #x527adbcd39d82676 #xf6d501a7cb9d6569 #xadda29ee40f16f67 #x60406410ba9962e5
                #xeeed72a0d939fdc2 #x02c501aaa9ec36d4 #xc372de3063301722 #xc2c1e51d97ff8774
                #xc382588be622bf0c #x339af8631db35866 #x6e0aff84f33415f5 #x376de9e3d5b2eff6
                #x6bce7eff32d52a69 #x6e416c81c39d8fc8 #x349e093a117612aa #x2a8dbeccd6229a14
                #x27341841b825e3da #x8be554fa8172424e #xc23fa4d55633f759 #x0108e1afa5eadb45
                #x922489683d8169f5 #xd67f9e6f9dca9b0a #xfca5c6aa328fa1f7 #x291df694c9eae1a4
                #xd0e114771c5985bf #x8635617b1287178e #x3acb260483127eda #xdb407e22eafc7f25
                #xa530078a97eb2fc1 #x7bbcab9658432630 #x0ab7f671111ba324 #x9d9ccdf40879aaba
                #x313afd3cfbba172a #x81c8a3e6e4feff3e #x8181b3645557e512 #xdfe746222f539567
                #xdf784dc0e96ab272 #x13216d340be466e3 #xdfd1d9a9846bbb00 #x6c56bb16fd806951
                #x8da9f7428bbced3f #x5f34c098a56cb688 #x12794599d197727f #x7cf5a694a3c1b06d
                #xe58adbf8ff2509bb #xeb2803e1d3cc118e #x275ddb683179a53f #xbeb90d9b5dfaa5a0
                #x55e0274e22f62455 #x41eb1c7191bdbbe5 #x419f61c9cb1d2c7d #x1c99259f6e4cd51a
                #xefaa4b1b21d1e6f9 #x4135436db3d702cb #x6905ec662519ddc9 #xc337b517cf23f9d6
                #xde13741e150a79b1 #x8e5745d8dd044b92 #x9e243da705e6dfa1 #xe43b2e18127ca7ee
                #x8e54164708795315 #xab67782fab30d6ea #x9b5309b1f95589df #x1709f757b1f5a532
                #x24f03480eed544d3 #x1938e7528ab416c0 #xefba1fd926ef062a #xa6f61184f3f098d9
                #x3eb9a5197bbe9b71 #x3fa9de58de25e576 #xa304a4163be48e4d #x9b4f0e789bfe4367
                #x1ee2f074c6904944 #x545444a64c263e23 #x245e445281da7e81 #xb521cd2e8bfcf0c0
                #xe934c678b87494c7 #x1c9a2958a9dc08dd #x5db50099b2f4130c #x7ac47cbed86040bd
                #xd6751724edc8693f #xfcf8ac9cf2649294 #x8bf03a6d52ccabaa #xda7cfa283586952d
                #xd3607b713774ca2d #x206240f26ca0982e #xe944ec8ef3cc3273 #xdea167e94a6e1e39
                #xdcd959f807246c3c #x85683e82cad0f6e6 #xa1eb90092eb2665e #x90846d21ec9be9ec
                #x4b16d01b6fe3641d #x1532915c11935f17 #xb3308477446387ed #x328d5da00aedeb52
                #x3ae96998f11b1f14 #x5760a0fa6842d81a #xf532eb5bdb34b604 #x40da700408ed091a
                #x6f859f7e3d794e52 #xd433502358fb3aaf #x9cff08f3abd54f03 #x779af7338b21b443
                #x77aedcd69cbf64c4 #xd04dee6a66298504 #x6d6be7995ce8e60d #xb69d047e2e4fc0e9
                #xce015a3aee582da2 #x491a39ffa4191d7d #x8ff01681b681ff95 #x3942649d9f37c38f
                #x97d200555dbb6ca1 #x77c4914a5b6cccac #xfbab5627ddf83448 #x15390771edb97df4
                #x4334b8ead8d4f8f3 #x654e0b84f01e01b2 #xf0dd29762663c4aa #xd76ab3507753eddf
                #xe13600719f11284b #x53caff7043804f61 #x56a53764ffd30584 #x754a741d935a1b68
                #xc2c38e1345059273 #x22c8eb8e005d3232 #x70717c5e4d2818e8 #xedb8e0c16752c450
                #xae54e398eaadac28 #x6589bd076f2c8e3f #x5c355a05521d9cbe #x7abd4cf01f52509d
                #x986e146101fa04b0 #x89f2505a3aa95931 #x4d7a284356aa5485 #x474328a76c8da41d
                #xdb5d9bd5d52d7f80 #xe7a4e6ef24e7dd2e #x9c270e7a17003671 #x30c69c6fff21835a
                #xe87bf534be06b7b0 #x1d2c853f0d4f32b1 #x662a079b11929c3d #xd1073939219e3a0e
                #x74fabed7a59e6cd3 #x975798f18659ed06 #x831a224d182ee28d #xb6ffba43f98f7b44
                #x16722ba17006d33d #xad202c7fa84c05e9 #x27cda36d850e902c #x24cfded99f4dced4
                #x1823fedbd1390f15 #x9adf0dd59082086e #x88c4c64186d6274b #xb4198026d40febcc
                #x3a11a71f73869f79 #x7dfe2aa04708d6ed #x1eed3a0553823296 #x71d52c97df5afd61
                #x5d2287c87fafd75d #xe26ac434b918c329 #xbc00990d7fb61513 #xa3ab6d5395e0bafd
                #x3af17c0bd3ebf4f8 #x8fdab76650d1bfcb #x35931e85b86c4282 #x509ed1bdb818b05e
                #xc0c26fe5ed229258 #x3c5a9bc6e5e22900 #xa34effe2468613d8 #x0b4f4d65b9149437
                #xd3f046dca3ac12e7 #x62724e1ed65aa788 #x3f0974a9d068991e #x0ea9aa7f6e53e8c8
                #x4d6741955ebd08b4 #x6e987c26747d1fd3 #x9dd87567f4229547 #x5924ac5525c23b1f
                #xc129b8e678b72d01 #xe91a8fdfce2beda5 #xdc6175090e1b3f43 #x3b1e902682872ecf
                #xfca2f41001e966cd #x29ecba124cdfb73d #xc911d7808158083e #x21cb97f853e13e78
                #x100db98066923d67 #x68cd614dc9442cb9 #xb6cacb6ec06977c1 #x46de6540ba7a721b
                #x86218280d3c16161 #x2ac6e4e09f45660a #x1e3684a4580bc5b7 #x4f00cd80dbd65afa
                #x5829758af35fae2f #x10ce5d55b25551c2 #xd577347883477d8b #x0d16f4a584222617
                #x7197b588bfbd54d2 #xee9af5f7410e637d #xd28c59ea632c49e4 #xa6b718c523c8e28d
                #xfd8abdd185b4824e #x84c92e122d1fe8a5 #xaf01fdef374417d5 #x68e63878c34e530a
                #x664fbacb39ac17ff #x68d88d1d6bf17821 #x29af5db40eeda7b5 #x6913e83a177d9115
                #xdffdc9391c4641be #x638a4f6582b38f62 #xf6329163060f2b43 #x3f5919570ffea220
                #xc4fb003eb7bd3b34 #xbb790927b48fdb87 #x75ee10749d8ece24 #xd666d211a4c1d739
                #x64179d57d1ca655d #xb2e4aafb63a5186b #xfe197e70dca00f92 #xd7416ff306fa2048
                #xe0b0ca9044f77fb5 #xf5dc9de466de6cc8 #x3daccca2b4a8fe71 #xc5fdb46ad35681fd
                #x6c8b5b21da7653ef #x2949c2539b38dd77 #x2541822e4395903c #x8d60084d9e96387a
                #xbbe791b77cbe5b7a #x2e1595c78a556c46 #xbff60b038ad06574 #x0211a7ea73215afc
                #x0a576246c767d38c #xd9c0815b32b8b0cf #x4ea3fca3b0b1d355 #x40890028cc2334e0
                #x42120195433d8e2c #xd1d04f52e6725e85 #x924b79347a8c6c55 #x5ff783a24a688465
                #x15d242051dcf45fb #x108bda8502c00b34 #x9818b0e392bf85e1 #x46199948d99a7f0a
                #xabd891c743a209fe #x1359f15ab0b2c290 #xc99b9a9428503bc4 #xdade71add639c5b6
                #x417708639c79b12c #x67be76eef4dd2a50 #x2c98b9360ecde7a2 #xa0215c6072875529
                #xe5e344759dfdfc15 #xf150d2ad59669805 #x6d249f65e554fb7a #x483d84aec7aa97e0
                #xb1feace8f0a44982 #x7fbd117f99977f5a #xb566f893157f952d #x8d727e1ea2313941
                #xdfa85a541c245272 #x20f7adf12105f5b9 #x5e14775de0b64ef2 #x5a3293ce8aa0f6b2
                #x40292a2e85fabfc6 #xc08c437e167cec3d #x82b92134aad4f3a7 #xf132c3501aa9741e
                #xe5ec134704919f1e #x0e4bb19e18acb02f #xb7f6aff7fb04a906 #x15a2db6e32e81395
                #x345fef8b30be69c1 #xc984d9f4479e6f6a #x099ae16a2a94418e #x9368166c70c9e05e
                #x76c42403aea239da #x8f05b70db9a288b1 #xc3a8c3d473c37985 #x60aa57a43ae764a6
                #xd0ed7d16c3b2490c #x30e287fca9883bc5 #x78d1ce5023de649f #x530a0d13f0563de7
                #x9183a029cabfc5b4 #xac1292d2765530a2 #xbe106570aec2b169 #x19a8dc03c8018ea9
                #x9f06be4007c1e333 #x3b65d03c75dbff3a #x5c7c1e498183b1c7 #x6cd24b5cca1896a1
                #x9d312f52871fbbef #x9bc2461a948d1f71 #x46a34225f25c51e1 #x2f7c30015a784320
                #xf5bc6e8fd2a7d691 #xdae08b1247eda554 #xc9657eb1fa1bac53 #x7a7d913e7ab2884f
                #x204119d715986f2b #x668797e37c672164 #x07161eed1168bf5e #xfe88c060bd4f680a
                #xc3f51ed64081cb49 #x16389c4b9b2bf0c5 #xc6c35266a02650b2 #x18731ea5eb49f9a0
                #xe21bdfcd17fa3f5a #x21a6024953cc1e65 #x245b448e7a91997a #x18006060e80798e1
                #x2f2c62299a50c114 #x0fccb37de3221374 #x140c8db6bab75d8d #xf5e00d263816bf68
                #x29601e4df5a36539 #xd73635b7247c51be #x06bff3c6d2529f26 #x4ba775e33f23cf01
                #xb30e8bb4ece195af #x7a9af61dd72b8a3a #xc6b7334ac8b79d80 #xb8380739cd0c8043
                #x589193c0cf980887 #x0ad07cf678c3c216 #x916effd35cb6f2b2 #x4826e1870bedb4cb
                #x4f766c6174e93fce #x2ccbd928bd6ebc90 #xd9d2199e59e45bf9 #x3efd446a3a69a316
                #xaba01cdf4ae1548a #x48c21610bd66e938 #xcba2a463b0a0aafa #x827d555a3ac39ded
                #x5abb7b51d3ead308 #x5d4d23f8115c3797 #x68ffbd8ef1f60308 #x9f9a1ff28f2dee8d
                #x38f4c6a5bd7f8584 #x44129bde4601b256 #x283040e2beefce50 #xcb4ae64dfa984448
                #xf79e2de9416488e7 #x60a2869792bbd285 #x3dc050e80daf30cd #xdb65aa6f80fc2547
                #xc139c24b5b11fc8d #xccbbfa411cb3cf10 #x4d614190ffe3a77c #x72ec8166974ecaf8
                #x960d1bb08a5accdf #xf8d614a836710a1b #xcfb6f703776a9d0e #x22fc12b4a7be9bf1
                #xd5520a20ae4cd1fa #x71c97f0af062c436 #xc5d4e63fd9b3a07a #x05e3cb819ea6e9b8
                #x60febd1fba1b9d77 #x8864a1cb5ebe4954 #x4a82e9929d449ab0 #x69ec2c62011fbccb
                #x89be9a9da41002ce #x1eb112b251af8cd2 #x6360bfe6fbb218ac #x4d3f1405426c2936
                #xf10fd017bbbdb6f4 #x528da864f5227139 #xea20297cea00cf34 #x1d37bc19a420f1b2
                #x4bbc09c74344976a #x4aed53de869104f4 #xfe1010031f8dfff0 #x077d21e0d3d446f0
                #xe63c481ef818acd7 #x79a7e50eed3fcef6 #xdf73d8bfba325b45 #x199aba3a797b5474
                #x8a80f79fa8902d0e #x5f31006214573a22 #xa70123cab8cb27e1 #x383cdb2a73797ef9
                #x8b36092f22fd775c #x44aa7b6182e550b4 #x0bb5ad1170e458d5 #xf0e732af77911d44
                #x8032aa92885f9f94 #xaf410ae03ccb607e #xc15a0471d5e51e74 #x828c1a92487279b7
                #xf336d5ab8f34baa6 #xfcae191366a945eb #xaa94a90f43541d51 #xee2a743374eb87ec
                #x591b27545f053972 #xb2f56b96355ffa30 #x3903a61d94738015 #x9301d0abc2a82904
                #x2eaa5490bc2dad27 #x3359698b97aff396 #x509f377b7082c41a #xa787321de644a550
                #xaeb3d319c044254b #x05a4c0055c6ae502 #xaf1433329bb9e937 #xefde4c478db97469
                #xa50c1273aa4293ef #x0a63b052c2b90309 #x1edb60b578fd4e2d #x134307496cb88858
                #x702e6ab920e37dcc #x6bb6c0639396e85f #x1fe66b57c6a32ba2 #x607bc1329bd6b076
                #xf4ac5b62ae40947d #xc387fec23a9d6c60 #xa144c6a563c78753 #x86e9dcb51e1efd75
                #x7e7644cd063bce5c #xa11131710662dd5a #x247507c1d4055f2b #xe08ce0893b6af590
                #x047795db8f1e5376 #x080341ed49cfb1a2 #x8765a14560ebd1e2 #xf8536859fdc51a6e
                #x56b88c660f56b9c0 #x37eb965becc2212f #xc98c6d95f7a19dff #x7bbfe7412927a27b
                #x8df99408fa3c3b69 #xe0e122b6ea40645e #x4cf4648a99bd7da5 #x4837fc6e80ba4f48
                #xca2b7c271dd2d150 #x9d0421e84f7a0544 #xbf138b45ace85676 #xbdb3e1f49880d030
                #xcaef92de97a63ad1 #xe8009dc196610dd5 #xb471130e28ff89a4 #x2fe916098e0b7ca7
                #xe9f87b04687306fc #x31e230ac364619f2 #x5c6c7d637fb2a593 #xd5aa184f83b1c708
                #xd44da700cb466aec #xb0e2e27b79e5bb07 #x1360a28f014b3aac #x8a31e6774d944d1e
                #xf9d4fade64195256 #x6d3ee8a7097c32d3 #x75123366db12d568 #xe4a80e2b42c9cb14
                #xc159cf09e419d7e4 #x5de095b0cdde1e53 #x8d2d8a3554b9049f #x2391ee75268d79ba
                #x8c7c1e270fcee68c #xe732f63cea23bf5f #xf206422edb6b5139 #xcfeb43ed80c17856
                #xdb65e22048807716 #x9e73d775cf0055d4 #x0ae03f44504606d9 #x4ea9dd97d5260149
                #x2d7c49110419c7e7 #x288734cf2e609ca1 #x7813934c21ce4ee5 #xab98c043b322f0d5
                #x23d2382fab95346d #x69a8477824adf0cf #xa7f4eee02cd3e0aa #x13c90e8731d17cac
                #x3048949481245dfa #x49c9b381d35fdec6 #x37f9fe9f3e229a5c #x6c388a2c526153ad
                #xceccb17346596f48 #x44a2a4da9ceb18fd #x61b3d95c7d2f48bf #x9e040352c1406944
                #x3a6faecacbcdca44 #x2c3f7a545b5cbcba #x150d1e520204244c #xa9006754a1cac445
                #xf612bc5634afda26 #xf165605a466bc8b7 #x0e28d51297427909 #x631a7a445110c87e
                #xdb11a4d25d908cc2 #xeb6cb43675cc051b #xf78fdbd815ea90c4 #x995ac250553aaff2
                #x13ba86cf3ce12827 #x6c98dae0019837d6 #xfcb4582f0e1f2310 #xf5a3e867ff148dea
                #x52be3e53b208d022 #x9bae6203a8248eb5 #x72525264e68d41eb #xeca21f7c300b40bb
                #x5df1f39c9fdb6756 #x1f4b1b19085dc7e3 #x105eaff9f2374f24 #x59312744d384337b
                #x9b577d26235efc48 #x474eb88fca73a0af #x6538743731d6e78b #xf75f18fb1cc74e12
                #xfb3c42de64ec469c #x707342f5f761f68b #xb80f66587825c5f0 #x8c191cd6944c6933
                #x7bbd9b48f877b119 #x5bc1007ab3f0de5b #x05454b91d8a192ae #xfd683c865c570bdd
                #xbaf42ef182c1ae3b #x76e95419113b30e1 #x0de6d28836837ecb #x38689fe8ed9f3030
                #x82da01432be9148a #xca10cc0f53bd73fc #x6ffa7e661ecc6eb5 #xd14ead2f54a0f690
                #x69a10d93a70d446a #x0a58c086d575abac #x5b6304e55ed6b5ec #xa1cf191e53387c24
                #x34b20c2ff90b808d #x6dc3d05b6d1a090e #x61d7588925f11e41 #x7cad25c8ba139a37
                #xe342fa84e05bb296 #x1087c401b775cfd7 #xf7d5380f00f5601f #xd6f0d333a75386d6
                #xdc9549717f9f97a0 #x8bc71c979faf415c #xf675b5b0c0526d74 #x23700b3abe7e7cb1
                #xe53c313d376af9fc #x44d89b31c4a347d4 #x3a0ca05f3d25cfe6 #xa67ea6a9bc9173ea
                #xb5475573c7b5036b #xf455beff9fa6fe1f #xf26917817ff27256 #x85b810f52724bf87
                #x2becd1452471382e #x37236045cde4af2f #x7bad8e6f7a612934 #x756dc160d4b77ccf
                #x2ea24697b54b4495 #x0eb61f75210f4ded #xf4f9042674e2446b #x2dc8e7fb5b2eab2d
                #xb7b3b659ced0b241 #x84486c8e248d1706 #xc7b3d1360547f82a #xd284180dbc4c6ae2
                #x59530283a97339a7 #xba4640c4fb069072 #x29cb2a69c41a3514 #xad7834105535ce7a
                #x9c07b231db3de2bf #x18547d250ad13575 #x5b00f751f4fa32c5 #x0e6f89dd3bbffe7e
                #x84c720d71fedac7a #x63a324cf5a6de32b #xbcb911b0c178eec7 #x46ff646193145697
                #x1f5763c825a32908 #xdb14f0d6885cc7b0 #xd1624bc8eeca51b9 #xbf05ab71838f8dcc
                #x823f5d14c811dabe #x464b1e4114eca755 #x678a4fbceafcfad2 #x42fbc35f90a39240
                #xf936492c317d5c38 #x3df02ae648e11c28 #xf9b8a6f234797e65 #xe4f89d9d18355fec
                #xb50fbb6eea222a6e #x195ec24b04b7cc8b #x3c4586e3eb241739 #x64df96c9748d20aa
                #x3ccbfebd27ab91e9 #x0be2754e5847c616 #x7df880223f0ad99b #xd5d6b5cc88f2404f
                #x98e3c558c17fd507 #x49a3c8b673b5c692 #x992b80bbf576a643 #x2fd619d9cb126d92
                #x3e78136f9abeab5e #x61cb7c8504031891 #x6be166d33e32b896 #xfeb33a4456aa7916
                #x8c6a475ddf571d03 #x508e536bfa049e0d #x4f6e5b34991b4c8a #xd83a511db285465d
                #xf81b0e86bc3155ea #x00b64fcf911d4f79 #x9eab4c19c8311c01 #x7024ec26a01cf0af
                #xde92f1cd012df577 #xeb4288b4222b01f9 #xa88750baaeab657d #x79fc3ef97d5ba5f1
                #x8d8f2a87e1528d41 #xa88e8c7eb5a6fdbf #x7b9265ae213c02b1 #xfcedbdaf3317d609
                #x61594ca683b49ffc #xd7ceab40df76c5fc #xccc7656dfc64b618 #x495f57df32b30b34
                #xf48b5b8633d34478 #xcc321f1e7c7ffc08 #xd66dfc19f7695c21 #xb1db5c8bcc546d34
                #x3bf9ec841aa6929f #x800de1a5ed61fc9b #xd953e13c99096bbb #xf34fdcfde1eb5a60
                #x624b2f22fafca75d #x3ea4deca02280ed1 #x8b2843021d95a4e7 #xa999cf8a10a5a219
                #xb132c911e848bf81 #x39279fe1ffb93c36 #xe66d60ce24121f65 #xce4d7e422b6bae07
                #x83e51e51a81bb5a0 #xccab4e3b144d2cca #x2f2b39b0925b80cd #x5e0836ee82c43162
                #x0bc53e48fe1dcb65 #xe5c5283f4690575b #xe7c51167825c7948 #xeb2329f644cdaf67
                #x3a8fc6a296ba04c1 #xa13c579e6275eac2 #xc935d1832fa3531e #x34991bed17a6033b
                #xae73b1da82403cb8 #xc4bfbe0cf6def79e #x1a3202c49882f8c4 #x35302b9fc7e93aad
                #xef27abb9235a276a #x176d6fb7d082aee6 #xcee79203b5911001 #xfc4df64f97df1bc0
                #x49c3f6da46a8819e #xf692062f52e63115 #x64dd637418406527 #x69c245b3fd70845c
                #x8215c153ad9f293a #x74d6991d2c475c88 #x5285aecf38cdbe90 #x38c273859f290265
                #x8433cb93db1ec23d #xdded8e8c45f942f0 #x00daf45ba27e4605 #x48191edd8f1b84bb
                #x7e90a370012a43de #x08472ed1013c7cd7 #x8e68f08520ab8e51 #xf6f6cef32de20e0f
                #x0cfcae1c5c6491d9 #x7b91b833aa03e4d1 #xe72a7e9a02664683 #x8dffd663d898dd6a
                #xb88e89327a3480d2 #xf6e0cfc7d5e6cea0 #xb1b2f56f96b9f551 #x70369cf387d2c14c
                #x167075eb209a095a #x2b29563012d58926 #xed428f877f7c1dfd #x037df722a7e62e7c
                #xd3b8130395dce9bc #x79563982c449b4b5 #x22fa1ad79f6b0db5 #xa9a540cbcd32e0af
                #x384dcfee80a007c1 #xb1b71afc6a3791fd #xa856ecaa501d74d0 #xd6e7c28f0693b07e
                #x02c42d2dced21279 #x129a1086d5425bd4 #x8a56696a6214ddbd #x3026c64c38949694
                #x9a7744e25389b0a7 #x98de55e5f9333584 #xf17c168055712a6c #xd2ff6b38a182f5f4
                #xdef247453dc009d4 #xc7d14f8186043de8 #x0ad0886df2a314b4 #xd49b908660bba81d
                #xe75c1bee2044172c #x02858c765fa994f2 #x7f349b5a5d42c809 #xbb4f7d3be3633be2
                #xb5007f9903d0fac4 #x8e9811ae67694236 #x0e22e551485cf4ec #x9dfb578458acfb8b
                #x6015cc52a09a5f97 #x3ef7286f85600561 #x25ad64311e98709b #xec1bd8280253b74a
                #x72b4301b9fc80cba #xa53ba10d3dbc2832 #xbf941f33cf1621bf #xf0b4a3d893590e7b
                #xc42d4f021a83ebfc #x83f7d1d00e8ae8b4 #xc82066e4ded6cbc3 #x99e0e70bd4846aac
                #xbfc3b0652caa27b3 #xbeeb91d71b0a2e89 #x40164149c3cdabee #x1f68e5299c15b39b
                #xc3b835cfecdfbe50 #xc251934f162cb3c8 #x577a98f4e747335c #x60eaea5a9ae00ca0
                #x62a678486363cfa0 #x776257f7b870f8c6 #xa9cfa393b160a040 #x8cbc1af43d0f779a
                #xf834513af00d64cd #xfe020ebd7acdb680 #x8496fd0c503fa86a #x95e09b87b9f4d126
                #xf02d64e8607a5fe4 #xc9f051e478dfc453 #x74f5637925ec1f11 #x8567ffa887f42069
                #x1b5687bc09cc7fc4 #x5b42794c6b725904 #xeb55591a0276fecc #xe693a851f887a783
                #xd61f5738a48f3238 #x33ce99814e3482d0 #x51d616fa32e16234 #x2a9da1b086501200
                #xd2f883f1c3a7eca3 #x24f0c4d7d93c3d4c #x9787eb02a8dced2e #x89fdf13c41373698
                #x097c730ab093240a #xe6c378243ca211e0 #xba02a04c047123f0 #x6c603ec46b5b4d30
                #x25cdd801f77d36c5 #x4ab0e1205e66eb6f #xa595590a8afca930 #x96371967bcbd9f56
                #x2dafad6ff3fb7aa1 #xcf69083c17bc4daf #x9c844ebc1b9f6606 #x4ad5f3638c87799e
                #x5aa93bdf49ff28a7 #x0473b52ed3f1ecaa #xb95744a3b6cb6f80 #x50ad355c420ccd82
                #xfba8bfb952ebc4e4 #x0a53c18579df5c19 #x50777951117b899e #xb41f1f86e12b54b9
                #x2da7909b8bf8c861 #x12e29aa6595bae67 #xb6562eea4f80829a #x8ae8a9ac790e6bc7
                #xe39e02407db48aaa #xa01c8ac4984c36a3 #xaaf1646bf9bda412 #x4a13019fdf90015f
                #x00205ffd7638471a #x60933eef594a9c8a #x3d7a8671f9d0581f #x5914257994d6a676
                #x08305b05aa363813 #x6070e42d6ebcfcf6 #xddc4dc5f094c982b #x400d417ac9a1990f
                #xf7e48c3700d017ed #xd1491cbe9afc54dd #xc4055ede2210c878 #xdbc80d465cdf9119
                #xd680edf0a82526dc #xb9d1ae95f3e41d92 #x7bff2a3a2657a42d #x7ad7a0c580c66a2e
                #x66ed0d9b90dc33fa #x088ab9cbb450798c #xf84c9f0e0b328f90 #x649938c48b87afa3
                #x151c0aba95e3a5e1 #xd42b5cee52426546 #x2a4f74ffebe65e4b #xab1d4ce84e1fe402
                #x6e52995c1e168d7c #xb9f9a00c5f33b6b8 #xf0fb283e4a6f380c #x38dd6c361f605acd
                #x3f3e089c74afb0b5 #x3ef8af1016e56f60 #x16ea0ce670d4610e #x2ce9346bd56f4877
                #x0343991b23f172e3 #xf1ce4f552f7a07e9 #xfaa2155610baa592 #xd98229d1dfcfdbd5
                #x2e1ffe46698af38f #xd01a7ba57a06bd2c #x8c929269a9547e67 #xedfc6c131b016d29
                #x4ebf2ce95caa4733 #xe22e686c612db031 #xb098a5a0a0e068c2 #xc08f5fc57ca6d34e
                #x28983ae61a31ce38 #x1b7c8ca427c1d49d #x8b637ff09cf2151f #xd244c2a4d21ceec3
                #x8b8e770c319eec46 #xa629c6cb824079e8 #xb3d6135dfa6cf9b2 #xa5c8da9f21f82b7c
                #xe4583186313a2d13 #xf17f4a684b5d6a36 #x31de958fff8d9146 #x03b432ef0306a821
                #x80989763c214581d #xf773ef47e27b50bf #xe3b17ce2030ace66 #x0cfa0f6ca036dfd1
                #xf53d200026222e62 #x9ee2d4f3157accad #xc355a5fe77fb21ae #x7d51569e3e6e0b8a
                #x9b9706ccc07eb9b8 #xcc9535def17dad8e #x78590b3a4cd34c23 #x045d7a518db4d8f8
                #xe69621ea553bb3f4 #x6136e271054d2b36 #x74571f3f4cbf3cda #x83eebf147ad20e2f
                #xf4aa8fe09a2a8d4e #xd526f708a0ef3636 #xc7f1379e62506178 #x86c1560b5779edfc
                #x4a0875808d08e67f #x8f2405ece54058b3 #xf87cb489b12fc7f7 #xc34dbb162f6aa966
                #xc15d87c936518f45 #xbc889636c3144ecc #x1bc459354120c953 #x834ab1917c7b9839
                #xdafdcf21e874ec37 #xe7d9296dd5f72ecf #x9f868dcd5075135b #x24f0d831e240193d
                #xfedfb0c6d97fe3f0 #x8753f6cc6022209e #x705bb05b79238193 #x0f40bcce9a6c3b04
                #x84c0cf2ec905b354 #xd3a9bab617093ea7 #x2511519ccd67e6e4 #xb2186c546446039b
                #x1b1bfb924f5de842 #xdd8692ec9d97a72a #x7e7b84fc01e02bd1 #xd00a9cd38bd130b0
                #x6627da8b09663754 #xee2bf833c2f6bf6f #x38da3e722c8fed8c #x8746d66df4356b6b
                #xc840c289f1eeb1a7 #x4c28b45068c73796 #xbc96f298c0833532 #xa74d7c18cc0c2a0b
                #x0672790abf0cd398 #x3b49ef89d15c6b64 #xadde06b5ca7c2f52 #x8e8cbf0356024e68
                #xcac85066d336d318 #x1ceca218a96cb0d1 #x752683f5deb86a6d #xc9cb107c955bcfe7
                #x4b2c71002481b921 #x2e533a052407036b #xf8246367ec998bdd #xbf317a7677f200ef
                #x9859918a736b33ee #x8f4c16f9561cac50 #xc2327c285450cb07 #xfcb7b01c53938e6c
                #x53f08bb7484176a0 #x6965eba1b4bbb673 #x1cb5297e980be6ab #xe39aca9ee9fb44e2
                #x3d30532b39a628e1 #xc83c082f5c8aa9be #x21fe80d8734eac10 #x5c14952f0d5c5a5e
                #x4704ab5f37588319 #xdb64e0564d735232 #xc4b092c290d3045a #x4ceb60040d302252
                #x2770f88714131ee8 #x99d92b20f32f0fd5 #x5c0d9d443d89da85 #x81ef4b09b40ec52e
                #xdc04b74f6bc5666b #x26ba5c59333c3585 #xd28d3aaaa3f93218 #xf1b9d4a90bbc8ee0
                #x70e2577b764527ff #xe68827436a5d84bd #x513c31248fd4dbe1 #x730ed9a340a94a99
                #xfffc08d156201516 #x2c0e52bdf77a041f #x52eb033cd4d7c2d0 #xa6a1ae92e0f37545
                #xe37bbcb5254aaabf #x3b7da79dbeaccb2a #x8e769fcaae5fe74e #x756cba0e66db2baa
                #xd4d1ac38ec67cf11 #xb1384f6c75a0a7a0 #x808fb455b6eb3698 #x8ee0735805372bee
                #xc3e4668e01aedc6d #x503ad0aca8a2398e #x27b52abdc65ab00a #x75e631fd8ec5c0d7
                #x91cd2cacc9357ce6 #xed61b310cd16b48a #xab13a9075153393c #x913f03cd3767abc1
                #x63dab4a6d3c4662b #xdc227738fda66c3f #x28e08f0a14d533fd #xfe3c2164497fa7e6))
  :test 'equalp)

(defmacro next-32 (index u8)
  `(the uint32 (aref +table-32+ (+ ,u8 (ash (ldb (byte 2 0) ,index) 8)))))

(defmacro next-64 (index u8)
  `(the uint64 (aref +table-64+ (+ ,u8 (ash (ldb (byte 3 0) ,index) 8)))))

(declaim (ftype (function (octet-array uint32) uint32) tabhash/32))
(defun tabhash/32 (buffer size)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (loop for index of-type uint32 from 0 below size
        with hash of-type uint32 = #.+seed-32+
        do (setf hash (logxor hash (next-32 index (aref buffer index))))
        finally (return hash)))

(declaim (ftype (function (octet-array uint32) uint64) tabhash/64))
(defun tabhash/64 (buffer size)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (loop for index of-type uint32 from 0 below size
        with hash of-type uint64 = #.+seed-64+
        do (setf hash (logxor hash (next-64 index (aref buffer index))))
        finally (return hash)))

(declaim (ftype (function (octet-array uint32) fixnum) tabhash/fixnum))
(defun tabhash/fixnum (buffer size)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (loop for index of-type uint32 from 0 below size
        with hash of-type uint64 = #.+seed-64+
        do (setf hash (logxor hash (next-64 index (aref buffer index))))
        finally (return (mfix hash))))
