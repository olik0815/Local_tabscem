addpath(fullfile(pwd, 'utils'));

files = ["data/Radar_Front_Left12", "data/Radar_Front_Left44", ...
    "data/Radar_Front_Right41", "data/Radar_Front_Left44" , "data/Radar_Rear_Left42", ...
    "data/Radar_Rear_Left44", "data/Radar_Rear_Right42", "data/Radar_Rear_Right44", ...
    "data/Radar_Front_Center81"];
%"data/Radar_Front_Left11", 
serverList = ["T2_T1", "T3_T2", "T3_T1", "T4_T3","T5_T4", "T7_T6", "T8_T7", "T8_T6"];
resolution = 10^9;  % ns to s;

% test results from MCET, BCET, WCET, Alcuri, global TBASCEM
values_delay_T2_T1 = [36.5363706440758,26.3332253167936,30.6993750453186,26.3332253167936,...
                      41.4866696628158,35.8599147546391,29.9811282507699,27.8746527402517,15.8315984183248, ...
                      753.110153044358,505.120853128488,577.332419940093,505.120853128488,737.008006274878, ...
                      714.576371755444,694.044404225316,750.263159678569,162.921570174492,...
                      53514.7633431143,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,...
                      2.111812905430354,4.123869801087635,5.276010960724184,4.123869801087635,3.993638344226430,...
                      4.008337721610048,3.659370506473562,3.912965340179505,0.999999999999452, ...
                      1.000001166325402,1.000000449582070,1.000000372010173,1.000000449582070,1.000000599551098,...
                      1.000000387886910,1.000000500466936,1.000000395414130,1.000000861961851];
values_delay_T3_T2 = [2.862348248209856e+02,1.568739182444977e+02,21.128416405720710,1.568739182444977e+02,...
                      20.920555512754316,49.265864429003110,36.300497072244625,35.604817747202860,17.367410466363930,...
                      5.962265859425549e+03,5.354341642657445e+03,6.241936037558161e+02,5.354341642657445e+03,...
                      5.639558791239873e+02,2.288215303711754e+03,1.093182507382424e+03,2.110954721487222e+03,...
                      2.944856290000165e+02,5.326341143409812e+04,5.436444152812280e+04,6.042969248312807e+04,...
                      5.436444152812280e+04,6.049431445766539e+04,5.832009395078464e+04,6.006437583345133e+04,...
                      5.877357403715692e+04,Inf,1,1.000000000049885,1.000000000001572,1.000000000049885,...
                      1.000000000000000,1.000000000001603,1.000000000007405,1.000000000005360,1.000000000000000,...
                      1.000001438993545,1.000016033811011,1.000000959225371,1.000016033811011,1.000001242068783,...
                      1.000005434154186,1.000001329291629,1.000001443354721,1.000001033299573];
values_delay_T3_T1 = [47.910712669845424,30.100073968289113,34.569398107189514,30.100073968289113,46.632778366184780,...
                      38.692819326260380,33.897288800837890,29.505916017204330,17.080230121831963,9.962585204947471e+02,...
                      6.426008139447865e+02,6.993691423523327e+02,6.426008139447865e+02,8.820682438052539e+02,...
                      8.596969927186572e+02,8.212642724058866e+02,8.758548058880360e+02,1.847080786868028e+02,...
                      5.511719264990949e+04,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,2.090725126479689,4.111701648496156,...
                      5.273706896550515,4.111701648496156,3.988348839231668,4.001137457344856,3.603898145238194,...
                      3.850537995968149,0.999999999999510,1.000001114829521,1.000000452557956,1.000000371990258,...
                      1.000000452557956,1.000000597286747,1.000000390164936,1.000000509492990,1.000000406289544,1.000000859781430];
values_delay_T4_T3 = [Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,5.308016447266450e+02,4.791200700587500e+02,...
                      5.139849407261340e+02,4.791200700587500e+02,5.186894695478758e+02,4.742400944570288e+02,...
                      5.106030240687277e+02,4.711409148592787e+02,4.309948749740864e+02,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,...
                      0.999999999999959,0.999999999999956,0.999999999999934,0.999999999999956,0.999999999999736,0.999999999999995,...
                      1.000000000000010,0.999999999999839,0.999999999999981,1.000000790251327,1.000001064829828,1.000000829468118,...
                      1.000001064829828,1.001341010865879,1.000001050514185,1.000235140273701,1.000001054460941,1.000001009812477];
values_delay_T5_T4 = [2.887840813003891e+02,83.451108345570030,31.996959028972830,83.451108345570030,64.167005252963730,...
                      64.587688536905290,58.449206716947465,29.451640460963910,15.367072694694070,2.415803641871131e+03,...
                      1.061228211047376e+03,8.121581123870919e+02,1.061228211047376e+03,7.080206175245673e+02,6.607178519096932e+02,...
                      6.266041237478648e+02,3.567520945184672e+02,1.530736050252820e+02,5.840603182237506e+04,5.999190575276566e+04,...
                      6.029138514620046e+04,5.999190575276566e+04,6.038663323143077e+04,6.044486307136490e+04,6.048156041496661e+04,...
                      6.078457925067382e+04,Inf,1.000000000007405,0.999999999990451,1.000000000019733,0.999999999990451,1.000000000014728,...
                      0.999999999997772,1.000000000013242,0.999999999988781,1.000000000000578,1.000001806230884,1.000001349454853,...
                      1.000001054346374,1.000001349454853,1.000001317450153,1.000001248979952,1.000001305309941,1.000001147992425,1.000001031605235];
values_delay_T7_T6 = [5.886134604995099,10.458376068033909,2.101005563770674,10.458376068033909,2.508945780940747,8.947537423543633,...
                      2.320519293825156,5.091340643001394,2.014074609254121,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,...
                      0.999999999999945,1.001538131349291,1.000000000000077,1.001538131349291,1.000000000000090,1.000000000000058,0.999999999999980,...
                      1.000000000000346,1.000000000000021,1.010239503514236,1.003169580484321,1.032647334136664,1.003169580484321,1.001976744430837,...
                      1.002705802892654,1.002889966005941,1.011435098597425,1.000000824334071];
values_delay_T8_T7 = [6.788583128276502,79.560864770499720,26.313244665635622,79.560864770499720,89.432757422411400,45.733980961221070,...
                      92.920895016061860,80.773470550479910,1.653029881322655e+02,1.151708174485741e+02,9.611694866158794e+02,7.328688714512712e+02,...
                      9.611694866158794e+02,1.015966148179509e+03,5.275950811560856e+02,1.042501538660614e+03,1.032660027362706e+03,2.411720626422482e+03,...
                      Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,0.999999999999852,1.000000000000626,0.999999999999563,1.000000000000626,0.999999999999890,...
                      1.000000000000180,0.999999999999806,1.000000000000286,0.999999999999890,1.000001233839614,1.000001151741101,1.000028162199178,...
                      1.000001151741101,1.000082027969413,1.000001131193152,1.000285086079418,1.000277650585096,1.000000862836626];
values_delay_T8_T6 = [10.345348846000736,26.309461544685270,8.901847620974442,26.309461544685270,24.632213187397920,26.458810045592863,...
                      23.359395617158300,24.586127640525590,15.267468883307295,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,...
                      1.000000000000310,1.000209592342898,1.000000000000058,1.000209592342898,1.000000000000104,1.000000000000083,0.999999999999978,...
                      1.000000000000268,1.000000000000036,1.010193382977209,1.003118351992969,1.032675466015506,1.003118351992969,1.002057684854503,...
                      1.002450497579412,1.003174638596144,1.011714789607440,1.000000821402812];
values_backlog_T2_T1 = [1.928368918692303,1.731763894839841,1.679787591108532,1.731763894839841,2.295638981403890,1.988030253929680,2.036402544807958,...
                        1.798050227423789,4.232684518092169,16.279748059217997,13.626161313465749,12.943185316029819,13.626161313465749,22.314816098145087,...
                        19.360777818932636,22.891733214696020,20.764733981184810,34.002468298160885,1.070826751881177e+03,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,...
                        1.273070833983089,1.216812491200013,1.197990032003532,1.216812491200013,1.266834472694867,1.221439769506366,1.266448748771825,...
                        1.223646866861710,1.348111855330264,1.235852072902562,1.129631103625019,1.101582173054189,1.129631103625019,1.166670326166625,...
                        1.135983237484899,1.170277095246764,1.138293512159678,1.182728791537625];
values_backlog_T3_T2 = [64.903055810587230,82.121967245686530,1.040428775504312e+02,82.121967245686530,79.046463255122000,81.155616206526030,...
                        78.622916784000700,80.056400366746160,96.230095624579770,2.791793803547793e+02,3.081136982987173e+02,3.199764580244791e+02,...
                        3.081136982987173e+02,3.235590093499520e+02,3.290829432220985e+02,3.349276824623578e+02,3.245420103960370e+02,...
                        3.750628223528515e+02,54.410305364741340,75.719815577729680,97.288030341197920,75.719815577729680,70.440772019026740,...
                        76.212526323453090,70.449637506616810,76.374359038732010,80.238325872737630,2.061198746167116e+03,2.433212879432961e+03,...
                        2.166435406683093e+04,2.433212879432961e+03,2.724496461692646e+04,6.517491499116711e+03,1.460211751148979e+04,6.982286101502621e+03,...
                        Inf,54.405877951304200,75.676470176138000,96.932439459375900,75.676470176138000,69.996375998217320,76.102013583237350,...
                        70.210349801767170,76.258587110869210,79.262902168022210];
values_backlog_T3_T1 = [2.167718920490229,1.827977748936214,1.760616595178477,1.827977748936214,2.446582391704704,2.063467144515486,2.176679160097816,...
                        1.854768725998971,4.486394288782583,21.389446347436984,17.095778921270230,15.478022586947855,17.095778921270230,...
                        26.541498615111795,23.137053548639027,27.304311490510802,24.470916425885058,38.418345253548410,1.116440481508907e+03,...
                        Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,1.273163048694802,1.216888752693935,1.198131769430695,1.216888752693935,1.266942174827164,...
                        1.221569862643269,1.266568974407800,1.223833034626775,1.348208303690444,1.236606867394347,1.129615402728596,1.101602665212368,...
                        1.129615402728596,1.166757990692962,1.135978751514430,1.170324684561472,1.138320427980248,1.183166173636063];
values_backlog_T4_T3 = [Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,3.405179031265403e+02,3.086488163088714e+02,3.098814660478867e+02,3.086488163088714e+02,...
                        3.338280846829022e+02,3.067907308531127e+02,3.282029411639049e+02,3.038725630026780e+02,2.778587075519074e+02,...
                        Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,1.875820343030482,2.360706548701661,2.661506713525676,2.360706548701661,2.231533745223266,...
                        2.373049658625947,2.235522885342081,2.374644631602209,2.442172363847315,1.538558155916143,1.720116683112622,2.064889919237752,...
                        1.720116683112622,1.590967787149503,1.734888113776523,1.595831259349125,1.734731007231592,1.806008804415533];
values_backlog_T5_T4 = [82.201520938047120,86.924124828868160,1.024065970048471e+02,86.924124828868160,83.067689669320520,...
                        90.638753674165770,84.451645179130620,88.040448013152340,96.361692906873590,1.903657224184365e+02,...
                        2.212451424424810e+02,2.396736750682474e+02,2.212451424424810e+02,2.172303237796635e+02,...
                        2.248298422681513e+02,2.251520502155541e+02,2.207141898898173e+02,2.502634654200155e+02,3.030620501479476e+03,...
                        8.295565497531768e+03,1.067059137923525e+04,8.295565497531768e+03,1.262263252882155e+04,1.364673439833566e+04,...
                        1.501186274244474e+04,2.465146012192236e+04,Inf,67.741264947062300,75.815532791910870,97.217347120652920,...
                        75.815532791910870,70.110749328891130,76.553021154224620,70.441176571891900,76.726123557160860,...
                        80.573260990853290,67.704230570571470,75.686237238823920,97.051537779508760,75.686237238823920,...
                        69.913985912199240,76.331915212116160,70.201137554473760,76.330562849645790,79.483487521720190];
values_backlog_T7_T6 = [3.293314846806982,6.023614430189686,3.645958754922404,6.023614430189686,3.579974461543342,...
                        5.266676820369775,3.893964213867155,4.675950208784462,2.702050601076936,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,...
                        Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,2.405757513460954,2.191908480283038,3.324289823378702,...
                        2.191908480283038,2.865223766576329,2.155603088161734,3.152135054370218,2.907962117539757,...
                        1.977848552238763,2.216870693443937,1.771149474706850,2.762093778397054,1.771149474706850,...
                        2.330260528284551,1.746097101639208,2.533067778598589,2.437551942534702,1.272597129197127];
values_backlog_T8_T7 = [91.294337829225060,3.475710352407033e+02,71.849766036745780,3.475710352407033e+02,...
                        3.968954555314588e+02,3.680767667261471e+02,4.044834907050222e+02,3.499549419889354e+02,...
                        9.169122024013022e+02,5.083934915789072e+02,3.470304367599023e+03,1.287671789410998e+03,...
                        3.470304367599023e+03,3.881542277709546e+03,3.543862520719706e+03,3.916136751318337e+03,...
                        3.678590458058243e+03,1.241833114956369e+04,69.667479967591940,74.152878201414990,...
                        31.137186742575725,74.152878201414990,68.866061447815770,77.972250490453750,69.353877103572070,...
                        75.782798683625510,95.461131166364540,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,65.826550339913410,...
                        70.618934866306600,29.419011934317684,70.618934866306600,65.109579346477400,71.408263792029940,...
                        65.660204728287010,72.290478061714310,90.561902733211280];
values_backlog_T8_T6 = [4.141915694101606,12.948184456774170,7.502871459853517,12.948184456774170,...
                        15.431124104408810,12.502438258298625,16.300549488946423,13.930826965802522,14.145181744285226,...
                        Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,Inf,2.406105826142658,...
                        2.201436052159762,3.327758125840472,2.201436052159762,2.868181130007285,2.157890140036298,...
                        3.039630493651707,2.911085085328581,1.952772926910542,2.216582413769887,1.771149474706850,...
                        2.761767251174168,1.771149474706850,2.330260528284551,1.745930959633279,2.439236896048381,...
                        2.437234965689119,1.257872359827318];
values_time_T2_T1 = [0.002454300000000,0.003329700000000,0.002792400000000,0.003339900000000,0.002601600000000,...
                     0.002469100000000,0.001980700000000,0.004549200000000,0.001655800000000,0.010084700000000,...
                     0.011423600000000,0.009054200000000,0.009110200000000,0.007884500000000,0.008486000000000,...
                     0.007054800000000,0.010188000000000,0.004812200000000,0.006055200000000,0.008291000000000,...
                     0.006906500000000,0.006662100000000,0.005921800000000,0.005832000000000,0.005173300000000,...
                     0.008811200000000,0.003914000000000,4.039117900000000,6.489373300000001,6.300007800000000,...
                     6.281340300000000,5.524623999999999,5.560203500000000,4.953758700000000,4.937121900000000,...
                     3.566273800000000,0.232342800000000,0.163658500000000,0.157082700000000,0.151378100000000,...
                     0.154842200000000,0.116616100000000,0.144085600000000,0.154918600000000,0.126805300000000];
values_time_T3_T2 = [0.002418600000000,0.004273300000000,0.002688400000000,0.002904200000000,0.002606300000000,...
                     0.005843200000000,0.004022000000000,0.002662700000000,0.003427100000000,0.008018300000000,...
                     0.014714000000000,0.010190500000000,0.010936500000000,0.009357600000000,0.020129300000000,...
                     0.014035700000000,0.009902200000000,0.010807400000000,0.005963100000000,0.008150900000000,...
                     0.007148600000000,0.011702000000000,0.008080900000000,0.012428100000000,0.009934100000000,...
                     0.007457100000000,0.008365100000000,4.272862000000000,7.040472400000000,6.300471500000000,...
                     6.733518000000000,6.423314200000000,5.882139000000001,5.868585899999999,6.368569600000000,...
                     6.474547200000000,0.097341700000000,0.144904800000000,0.140825500000000,0.122986600000000,...
                     0.117726700000000,0.140339900000000,0.138039300000000,0.141344200000000,0.127037300000000];
values_time_T3_T1 = [0.004633300000000,0.006982400000000,0.007216000000000,0.007330400000000,0.006784800000000,...
                     0.005816600000000,0.005060200000000,0.004755200000000,0.004145100000000,0.016701500000000,...
                     0.036558400000000,0.021191300000000,0.023096500000000,0.028064000000000,0.021925100000000,...
                     0.016461800000000,0.020344800000000,0.015242200000000,0.013742800000000,0.026208500000000,...
                     0.015733500000000,0.015404800000000,0.020089300000000,0.014849900000000,0.012946300000000,...
                     0.016639000000000,0.010515500000000,4.982388299999999,6.243721300000000,5.797584600000000,...
                     6.226608100000000,5.399166600000000,5.434789200000000,4.329248199999999,4.420553700000000,...
                     3.559512300000000,0.142412000000000,0.126982500000000,0.131477100000000,0.157678700000000,...
                     0.127428200000000,0.169174400000000,0.170392800000000,0.153174100000000,0.130672000000000];
values_time_T4_T3 = [6.090999999999999e-04,4.285000000000000e-04,3.329000000000000e-04,5.413000000000000e-04,...
                     7.210000000000000e-04,3.517000000000000e-04,5.635999999999999e-04,8.671000000000000e-04,...
                     4.644000000000000e-04,0.001834900000000,0.001606300000000,9.803000000000000e-04,0.001774700000000,...
                     0.002406800000000,0.001323900000000,0.001891000000000,0.001741200000000,0.002225100000000,...
                     0.001073900000000,9.294000000000000e-04,5.043000000000000e-04,0.001172600000000,...
                     0.001771300000000,8.836000000000000e-04,0.001236700000000,9.720999999999999e-04,0.001804600000000,...
                     0.668554600000000,0.614200400000000,0.331847100000000,0.647851600000000,0.650899300000000,...
                     0.655937400000000,0.601582300000000,0.637402100000000,0.534680400000000,0.149138100000000,...
                     0.149608400000000,0.122975900000000,0.134255100000000,0.161758700000000,0.170869800000000,...
                     0.122690900000000,0.141060300000000,0.121882500000000];
values_time_T5_T4 = [0.002909200000000,0.002904300000000,0.003333900000000,0.004129200000000,0.002691400000000,...
                     0.003064700000000,0.003033600000000,0.003086700000000,0.002810200000000,0.010498500000000,...
                     0.010588600000000,0.019135800000000,0.011455100000000,0.012646600000000,0.010687600000000,...
                     0.010817100000000,0.011516300000000,0.010112700000000,0.015472900000000,0.009717900000000,...
                     0.009674300000000,0.007762500000000,0.008202600000000,0.010010200000000,0.007888100000000,...
                     0.010349100000000,0.007926700000000,5.979351400000001,6.723468700000001,6.194626500000000,...
                     6.220455700000001,6.795648100000000,6.019877500000001,5.993602900000000,6.276848700000000,...
                     6.521870100000000,0.195195400000000,0.149096200000000,0.181660700000000,0.138445600000000,...
                     0.143556200000000,0.134711100000000,0.131374100000000,0.134796500000000,0.166281900000000];
values_time_T7_T6 = [4.695000000000000e-04,8.461000000000000e-04,5.820000000000000e-04,0.001123000000000,...
                     0.001300700000000,9.238000000000000e-04,0.001076200000000,5.744000000000000e-04,...
                     3.931000000000000e-04,0.001758000000000,0.003578900000000,0.001751700000000,0.004011500000000,...
                     0.004343200000000,0.002341900000000,0.003657200000000,0.002012000000000,0.001352600000000,...
                     0.001242500000000,0.002846100000000,0.001566100000000,0.002461600000000,0.003105900000000,...
                     0.001827700000000,0.002887400000000,0.001685100000000,9.002000000000000e-04,0.860211900000000,...
                     1.895158700000000,1.403961100000000,1.745060700000000,3.742109900000000,1.534496200000000,...
                     3.173709800000000,1.488745400000000,0.647020900000000,0.138407000000000,0.154406200000000,...
                     0.128141500000000,0.157242600000000,0.141733300000000,0.133321600000000,0.127238700000000,...
                     0.134851000000000,0.118311700000000];
values_time_T8_T7 = [0.003146100000000,0.003621900000000,0.002560000000000,0.003102000000000,0.002364300000000,...
                     0.003080000000000,0.002999400000000,0.002697200000000,0.003663100000000,0.011292000000000,...
                     0.011315900000000,0.009323000000000,0.015144100000000,0.010400800000000,0.013544300000000,...
                     0.009530100000000,0.014306500000000,0.010024000000000,0.007793100000000,0.008065700000000,...
                     0.007017600000000,0.008544400000000,0.012870000000000,0.014316300000000,0.007002000000000,...
                     0.011022500000000,0.006715300000000,6.650669799999999,7.063377500000000,6.364012600000000,...
                     6.976770400000000,6.615079600000000,6.380080100000000,6.280761500000000,6.492465200000000,...
                     6.349627900000000,0.176547400000000,0.143747700000000,0.156517200000000,0.146879100000000,...
                     0.156502500000000,0.147401800000000,0.146113200000000,0.150372700000000,0.150516000000000];
values_time_T8_T6 = [0.004360900000000,0.004080700000000,0.003336100000000,0.003906900000000,0.004049200000000,...
                     0.003900100000000,0.004432200000000,0.003369400000000,0.003275900000000,0.015235700000000,...
                     0.012685800000000,0.010824000000000,0.012850100000000,0.013430600000000,0.011812400000000,...
                     0.018646200000000,0.011101400000000,0.013006600000000,0.011406500000000,0.009178900000000,...
                     0.008958200000000,0.012831000000000,0.009652300000000,0.010958400000000,0.012750200000000,...
                     0.013095700000000,0.013869400000000,0.854355800000000,2.045974900000000,1.400863000000000,...
                     1.929468000000000,2.926573400000000,1.594313500000000,2.717856000000000,1.154298700000000,...
                     0.653171600000000,0.245795200000000,0.137470900000000,0.121650200000000,0.112711100000000,...
                     0.169516500000000,0.145574400000000,0.145067600000000,0.133138900000000,0.141750200000000];

for iFile=1:length(files)
     file = files(iFile);
     try
         data = read_data(file);
         for iServer = 1:length(serverList)
            serverNum = strsplit(serverList{iServer}, '_');
            [sim_delay, sim_backlog] = calculate_sim_results(data, resolution, serverNum);
            tic
            [result_rl_local_tbascem, ~] = nc_calc_iterativ(data.(serverNum{2}), data.B0, data.(serverNum{1}), data.B0, resolution);
            time_local_tbascem = toc;
            % append results from local TBASCEM to the results of the other algorithms 
            if serverList{iServer} == "T2_T1"
                values_delay_T2_T1(end+1) = result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T2_T1(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T2_T1(end+1) = time_local_tbascem;
            elseif serverList{iServer} == "T3_T2"
                values_delay_T3_T2(end+1)= result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T3_T2(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T3_T2(end+1) = time_local_tbascem;
            elseif serverList{iServer} == "T3_T1"
                values_delay_T3_T1(end+1) = result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T3_T1(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T3_T1(end+1) = time_local_tbascem;
            elseif serverList{iServer} == "T4_T3"
                values_delay_T4_T3(end+1) = result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T4_T3(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T4_T3(end+1) = time_local_tbascem;
            elseif serverList{iServer} == "T5_T4"
                values_delay_T5_T4(end+1) = result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T5_T4(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T5_T4(end+1) = time_local_tbascem;
            elseif serverList{iServer} == "T7_T6"
                values_delay_T7_T6(end+1) = result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T7_T6(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T7_T6(end+1) = time_local_tbascem;
            elseif serverList{iServer} == "T8_T7"
                values_delay_T8_T7(end+1) = result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T8_T7(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T8_T7(end+1) = time_local_tbascem;
            elseif serverList{iServer} == "T8_T6"
                values_delay_T8_T6(end+1) = result_rl_local_tbascem.max_delay/sim_delay;
                values_backlog_T8_T6(end+1) = result_rl_local_tbascem.max_backlog/sim_backlog;
                values_time_T8_T6(end+1) = time_local_tbascem;
            end
         end
     catch err
         disp(getReport(err,'extended'));
     end
end

values_delay = cat(2,values_delay_T2_T1, values_delay_T3_T2, values_delay_T3_T1, values_delay_T4_T3, values_delay_T5_T4, values_delay_T7_T6, values_delay_T8_T7, values_delay_T8_T6);
values_delay = values_delay(:);
values_backlog = cat(2,values_backlog_T2_T1, values_backlog_T3_T2, values_backlog_T3_T1, values_backlog_T4_T3, values_backlog_T5_T4, values_backlog_T7_T6, values_backlog_T8_T7, values_backlog_T8_T6);
values_backlog = values_backlog(:);
values_time = cat(2,values_time_T2_T1, values_time_T3_T2, values_time_T3_T1, values_time_T4_T3, values_time_T5_T4, values_time_T7_T6, values_time_T8_T7, values_time_T8_T6);
values_time = values_time(:);

display_data(values_delay, values_backlog, values_time, length(files))