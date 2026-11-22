-- Word Generator | Client-only Roblox LocalScript
-- Includes 4967 common English word entries from a frequency-based spelling list.
-- Client-only: no server Script, RemoteFunction, HTTP request, or API key is needed.
-- Source: TextBlob en-spelling data; see source notes above.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Common English vocabulary selected from TextBlob's frequency spelling list.
-- Source notes in TextBlob identify public-domain Project Gutenberg material,
-- Wiktionary frequency lists, and the British National Corpus.
-- Entries are lowercase alphabetic words with frequency count >= 20.
-- This is a practical common-word list, not a complete dictionary.
local WORD_DATA = {
    a = [[abandon abandoned abandoning abdomen abdominal able abnormal abolished abolition about above abroad abscess abscesses absence absent absolute absolutely absorbed absorption absurd abundant abuses accept accepted access accident accidentally accompanied accompany accomplished accord according accordingly account accounts accumulation accused accustomed acid acquaintance acquaintances acquainted acquired acres across act acted acting action actions active activities activity acts actual actually acute adams add added adding addition additional address addressed addressing adenoma adherent adhesions adjacent adjutant adjutants administration admission admit admitted admitting adopted adoption adult adults advance advanced advancing advantage advantages adventure advertisement advice advised advocates aet affair affairs affect affected affecting affection affectionate affections affects afford afforded afraid africa after afternoon afterwards again against age aged agent agents agitated agitation ago agree agreeable agreed agreement agricultural agriculture ah ahead aid aide aim aims air alabama alarm alarmed alcohol alexander alexeevich alien alike alive all alleged alliance allied allies allow allowed almost alone along aloud alpatych already also altered although altogether always am ambassador amendment america american americans amiable amid among amount amputation amused amusing an anaesthesia anaesthetic analysis anatole anatomical anatomy ancient and andrew aneurysm angel anger angioma angle angrily angry animal animals animated animation ankle ankylosis anna annexation announced announcement annual another answer answered answering answers anterior anteroom anthrax anti antiseptic anxiety anxious anxiously any anybody anyone anything anywhere aorta apart apparent apparently appeal appear appearance appearances appeared appearing appears applicable application applications applied apply applying appointed appointment appreciated approach approached approaching appropriate approval approve approved april apt arakcheev arbitration archive are area areas argument arguments arise arkansas arm armchair armed armies arms army arose around aroused arrange arranged arrangement arrangements arrest arrested arrival arrive arrived art arterial arteries arterio artery arthritis arthur article articles articular artificial artillery artisans as aseptic ashamed aside ask asked asking asks asleep aspect aspects assembled assemblies assembly assistance assistant associated association assume assumed assumes assumption assurance assure assured astonishment at ate atlantic atmosphere atrophy attached attack attacked attacking attacks attain attained attempt attempted attempts attend attendance attended attention attentively attitude attracted attractive attributed audible audience august aunt austerlitz austria austrian author authorities authority authorized autumn available avenue avoid avoided avoiding awaited awaiting awake aware away awful awkward axilla axillary axis]],
    b = [[baby bacilli bacillus back backward bacteria bacterial bad badly bag baggage bagration baker balaga balance balashev bald ball ballot ballroom balls band bandage bandaged bands bank banking banks bar barclay bare barrier base based basis bath battalion battalions battery battle battlefield battles bay be bear beard bearing beast beat beaten beating beausset beautiful beauty became because become becomes becoming bed bedroom been bees before beg began begged begin beginning begins begun behalf behind being belief believe believed bell bells belong belonged belonging below bench bending beneath benefactor benefit bennigsen bent berg beside besides best better between beyond bezukhov bezukhova bier big bilibin bill bills bind bird birth bismuth bit bite bitter black blame bleed bleeding blind blister blisters blockade blocked blocking blood blow blue bluish blushed blushing board bodies body bogucharovo bold boldly bolkonski bonaparte bond bonds bone bones bony book books boot boots border bore boris born borne borodino borzois bosom boston both bottle bottom bought bound boundary bourienne bow bowed bowing box boy boys brachial brain branch branches brave breach bread break breakfast breaking breast breath breathing breeches bridge brief bright brightly brilliant bring bringing britain british broad broke broken brother brothers brought brow brown brows bruised brushed bryan building built bullet bullets bundles buonaparte burden buried burke burn burned burning burns bursa bursae burst bushes business busy but buttock buy by]],
    c = [[cab cadet caleche calhoun california call called callender calling calls calm calmly came camp campaign campaigns campfires can canada canal canals cancer candidate candidates candle candles cannon cannot cap capable capacity capillary capital capsule captain capture captured carbolic card cards care career careful carefully cares caries carolina carotid carpet carriage carriages carried carry carrying cart cartilage cartilaginous carts case cases cast catch catgut catherine cattle caught cause caused causes causing cavalry cavities cavity cease ceased celebrated cellar cells cellular cellulitis cent center centers central centre century certain certainly cervical chain chair chairs challenge chamber chance chancre change changed changes changing chapter character characterised characteristic characters charge charged charles charleston charm charming charter chase check checked cheek cheeks cheerful chemical cher chest chicago chief chiefly child childhood childish childlike children chin china chinese choice chondroma choose choosing chose chosen christ christmas chronic church churches cicatricial circle circles circular circulating circulation circumscribed circumstances cities citizen citizens city civil civilization claim claimed claims clair class classes clavichord clavicle clay clean clear cleared clearing clearly clerk cleveland clever client clinical clinically cloak clock close closed closely closer closing clot cloth clothes clothing cloud clouds club co coach coachman coal coarse coast coat coats coffee coin cold coldly collar collateral collect collected collection collective college colonel colonial colonies colonists colony color colored colour coloured column columns combination combinations combined come comes comfort comfortable coming command commanded commander commanders commanding commands commerce commercial commission commissions committed committee committees common commonest commonly commons communication community compact companies companion company comparatively compare compared comparison compelled competition complaint complete completed completely complex complicated complications composed compound compressed compression compromise comrade comrades conceal concealed concentrated conception concern concerned concerning concluded conclusion condemned condition conditions conduct conducted confederacy confederate confederation conference conferred confess confidence confident confined confirmed conflict confused confusion congenital congestion congratulate congress connected connecticut connection connections connective conquest conscience conscious consciousness consent consequence consequently conservative consider considerable consideration considerations considered considering consist consisted consisting consists constant constantly constitute constitutes constitution constitutional constitutions constructed construction contact contain contained containing contains contemporaries contempt content contents contest continent continental continually continue continued continues continuing continuity continuous contract contracted contraction contracture contradiction contrary contrast control controlled controversy convenient convention conventions conversation conversations conveyed conviction convinced convoy cook cooperation copies copper copy copyright cord cords corn corner coronet corporal corporation corporations corps correct correspondence corresponding corridor cossack cossacks cost cotton could council count counted countess countries country countrymen couple courage courier course court courtiers courts cousin cover covered covering crack created creating creature credit creditors cried cries crime crimes criminal crisis critical criticism crop crops cross crossed crossing crowd crowded crowds crown cruel cruelty crush crushed crushing cry crying cuba culture cunning cup cure curiosity curious curly currency current curtain custom cut cutaneous cutting cyst cystic cysts]],
    d = [[daily dam damage damaged damages damp dance danced dancing danger dangerous daniel dare dared daring dark darkness darling dashed date daughter daughters davout dawn day days de dead deal dealing dealt dear dearest death debate debt debts december decide decided decision decisive declaration declare declared declaring decline decree deed deep deeper deeply defeat defeated defect defective defects defend defended defending defense defined definite definitely definition deformans deformities deformity degeneration degree degrees delaware delay delayed delegates deliberately delicate delight delighted delightful delirium delivered demand demanded demands democracy democratic democrats demonstrated denied denisov denounced dense department departure depend depended dependent depends deposit depressed depression deprive deprived depth depths derived dermoids descended describe described description desert deserted designed desire desired desires despair desperate despite dessalles destined destiny destroy destroyed destroying destruction destructive detached detachment detail details detected determination determine determined develop developed development devil devised devoted devotion diagnosis did didn die died difference different differential differently difficult difficulties difficulty diffuse dignity dilated dim diminished dimly dining dinner diphtheria diplomacy diplomatic direct directed direction directions directly dirty disability disappear disappearance disappeared discharge discipline discover discovered discovery discuss discussed discussion disease diseased diseases disliked dislocation dismay dismounted disorder dispatch displaced displacement disposition dispositions dispute disputes dissatisfied dissolution distal distance distant distinct distinctly distinguish distinguished distorted distress distribute distributed distribution district disturbance disturbed divided divine division divisions dmitrievna do doctor doctors doctrine document does doesn dog dogs doing dokhturov dolgorukov dollars dolokhov domain domestic dominion don donations done door doors dorsum dose doses double doubt doubts douglas down downstairs downwards dozen dr draft dragged dragging dragoons drainage drank drastic draw drawing drawn dreadful dream dress dressed dresses dressing dressings drew dried drift drink drinking drissa drive driven driver driving dron drop dropped drops drove drug drunk drunken dry duct due duel duke dull dunyasha duration during dust dutch duties duty dying]],
    e = [[each eager eagerly ear earlier early ears earth ease easier easily east eastern easy eat eating ebook ebooks economic economy edge edges edinburgh edition educated education effect effected effective effects efficient effort efforts effusion eh eight eighteen eighteenth eighth eighty either elapsed elastic elbow elbows elder elderly eldest elected election elections electoral electors electric electronic element elements elephantiasis elevated eleven else elsewhere elson emancipation embarrassed embedded embolism embraced emotion empereur emperor emperors empire employed employees employers employment empress empty en enable enacted encounter encourage encouraged end ended endless ends endure enemies enemy energetic energy enforce enforcement engaged engagement england english englishman enjoy enjoyed enjoyment enlarged enlargement enormous enough ensue ensues enter entered entering enterprise enthusiasm entire entirely entrance entrusted entry envelope epidermis epiphysial epiphysis epithelial epithelioma epithelium equal equality equally equipment ermolov erosion erysipelas esaul escape escaped escapes especially essence essential est establish established establishing establishment estate estates etc eternal europe european eve even evening event events eventually ever every everybody everyone everything everywhere evidence evident evidently evil exact exactly exaggerated examination examine examined examining example examples exceedingly excellency excellent except exception exceptional excess excessive exchange exchanged excised excision excited excitement exclaimed excluded exclusively excuse executed execution executive exercise exhausted exist existed existence existing exists expansion expect expected expecting expedition expense expenses experience experienced experiment explain explained explaining explanation exposed exposure express expressed expressing expression extend extended extending extends extension extensive extent external extra extraordinary extreme extremely extremities extremity exudate eye eyebrows eyed eyes]],
    f = [[face faced faces facing fact factor factories factors factory facts fail failed failing fails failure fair fairly faith faithful fall fallen falling falls false familiar families family famous fancy far farm farmer farmers farms farther fascia fashion fast faster fat fatal fate father fatherland fatty fault favor favorable favored favorite favour favourable fear feared fearing fears feather feature features february fed federal federalist federalists federation fee feeble feel feeling feelings feels feet fell fellow fellows felt femoral femur fence fetch fever feverish few ff fibres fibroma fibromatosis fibrous field fields fifteen fifth fifty fig fight fighting figure figures file fill filled filling final finally finance financial find finding finds fine finger fingers finish finished finishing fire fired fires firing firm firmly firmness first fish fit fitted fitting five fix fixed flag flames flank flap flat fleches fled fleet flesh flew flexed flexor flight floor florida flourishing flow flowed flowing fluid flung flushed fly flying focus foe fog fold folded folk follow followed followers following follows fond food fool foolish foot footman footmen footsteps for forbidden forbidding force forced forces forearm forehead foreign foreigners foreseen forest forests forever forget forgetting forgive forgot forgotten form formal formation formed former formerly formidable forming forms forth fortnight fortunate fortune fortunes forty forward fought foul found foundation foundations founded four fourteen fourteenth fourth fox fracture fractures fragments frame framework france francis frank franklin frankly free freedom freehold freely freemasonry french frenchman frenchmen frequency frequent frequently fresh friend friendly friends friendship frightened from front frontier frost frown frowned frowning fruit fulfill fulfilled full fully fun function functions fundamental funds funny fur furnish furnished furniture further future]],
    g = [[gaily gain gained gains gallop galloped galloping game ganglion gangrene gap garden gate gates gathered gathering gauze gave gay gaze gazed gazing general generally generals generation generations generous genius gentle gentleman gentlemen gently george georgia gerasim german germans germany gesture get gets getting giant gigantic girl girls give given gives giving glad glance glanced glances glancing gland glands glass glasses glittering gloom gloomy glory gloves glow go goal god goes going gold golden gone good goodness goods goose gossip got gouty governed government governments governor governors gown grace gracious gradual gradually grafting grafts grain grand grant granted grants granulation granulations grasp grass grateful gratitude grave gravity gray great greater greatest greatly greatness green greeted greeting grew grey grief groin groom gross ground grounds group groups grow growing grown grows growth growths guard guards guessed guests guide guilty gumma gummatous gun guns gutenberg]],
    h = [[ha habit habits habitual had haemorrhage hair haired half hall halt halted hamilton hampshire hand handed handkerchief handle hands handsome hanging happen happened happening happens happily happiness happy hard hardly hare harm harmful harness harrison harsh hart has haste hastened hastily hat hate hated hatred have haven having hay he head headed headquarters heads heal healing health healthy hear heard hearing heart hearts heat heaven heavily heavy heel heels height heights held helene help helped helpless hence hendrikhovna henry her here hero heroes heroic hers herself hesitation hid hidden hide hiding high higher highest highly highness highroad hill hills him himself hip hippolyte his historian historians historic historical history hit hitherto hive hoarse hold holder holding hollow holmes holy home homes homestead honest honor honorable honored hoofs hope hoped hopes hoping horizon horrible horror horse horses hosmer hospital host hostess hostile hostility hot hotel hounds hour hours house household houses how however http huge hum human humanity humerus hundred hundreds hung hunger hungry hunt hunter hunting huntsman hurrah hurried hurriedly hurry hurrying hurt husband hussar hussars hut hydrops hyperaemia]],
    i = [[ice icon icons idea ideal ideas if ii iii ilagin iliac ill illinois illness illustration ilya ilyin imagination imagine imagined immediate immediately immense immigrants immigration impaired impairment impending imperial implicated importance important imposed impossible impressed impression impressions improve improved improvement improvements impulse in incessantly incident incised incision inclined include included including income incomprehensible inconvenience increase increased increases increasing indeed indefinite independence independent independently index india indian indiana indians indicate indicated indicating indication indifference indifferent individual individuals indolent induce induced indurated induration industrial industries industry inevitability inevitable inevitably infantry infants infected infection infections infective infiltration infinite inflamed inflammation inflammatory inflicted influence influenced influences inform information informed inhabitants inherited initiative injected injection injections injured injuries injury inn inner innocent innumerable inoculation inquired inquiries inquiring inquiringly inquiry inserted inside insignificant insisted inspector instance instances instant instantly instead instinct institution institutions instructions instrument instruments intact intellectual intelligent intended intense intention intentions intently interest interested interesting interests interfere interfered interference interior internal international interrupted interstate interval intervals intervention interview intestine intimate into intra introduce introduced introduction invariably invasion investigation invisible invited involuntarily involuntary involve involved involves iodine iodoform iowa irish iron irony irregular irresistible irrigation irritation is island islands isn isolated issue issued issues it italian italy its itself iv ivanovich ivanovna ix]],
    j = [[jacket jackson jacksonian james january japan jaw jealous jefferson jersey john johnson join joined joint joints joke jones joseph journey joy joyful joyfully joyous judge judges judging judgment judicial julie july jumped junction june jury just justice justify]],
    k = [[kaluga kansas karataev keen keep keeping kentucky kept key kidney kill killed killing kind kindly kinds king kingdom kings kiss kissed kissing knee knees knew knife knights knocked knoll know knowing knowledge known knows krasnoe kremlin kuragin kutuzov kuzminichna]],
    l = [[la labor laborers lack lad ladies lads lady laid lake lamp land lands lane language large largely larger largest larynx last lasted late lately later lateral latter laugh laughed laughing laughter lavrushka law laws lay layer layers laying le lead leader leaders leadership leading leads league leaned leaning learn learned learning least leather leave leaves leaving led lee left leg legal legislation legislative legislature legislatures legs length lent lesion lesions less lesser lessons lest lestrade let letter letters letting leucocytes leucocytosis level liability liable liberal liberty license lie lies lieutenant life lift lifted lifting ligament ligaments ligation ligature light lightly lights like liked likely likewise limb limbs lime limit limited limits lincoln line lined linen lines lining lip lipoma lips lise list listen listened listening lit literary little live lived lively liver lives living ll loaded local localised located lock locked lodge lofty log logical london long longed longer look looked looking looks loose lord lose losing loss losses lost lot loud louder loudly louis louisiana love loved lovely lover loves loving low lower lowered loyal luck lumen lungs lupus lying lymph lymphangitis lymphatic lymphatics]],
    m = [[ma macdonald machine machinery mack mad madam madame made mademoiselle madison maid maids main maine mainly maintain maintained majestic majesty major majority make makes making male malignant mamma man manage managed management maneuvers manhood manifest manifestations mankind manner manners manufacturers manufactures manufacturing many map march marched marching margin margins mark marked market markets marriage married marrow marry marrying marshal marshall marshals mary marya maryland mason mass massachusetts massage masses master masters match material materials matter matters mavra maximum may mccarthy mckinley me mean meaning means meant meanwhile measure measured measures mechanical mechanics medial median medical medicine medium medullary meet meeting meetings melancholy member members membrane membranes memorable memories memory men mental mentally mention mentioned merchant merchants mercury mercy mere merely merit merrily merry message messenger met metal method methods mexican mexico michael michaud michigan middle midnight midst might mighty migration mikhaylovna mild mile miles military militia militiamen milk million millions mills miloradovich mind minded minds mine mines mingled minimum minister ministers minor minute minutes misfortune miss missed missing mission mississippi missouri mist mistake mistaken mistress mixed mob moderate modern modified moist moment moments mon monarch monarchy money monroe monsieur month months mood moon moral more moreover morning morrow moscow most mother motion motionless motor mountains mounted mouth move moved movement movements moves moving mozhaysk mr mrs much mucous mud multiple murat murder muscle muscles muscular museum music musketry muskets must mustache muttered muttering mutual my myeloma myself mysterious mystery]],
    n = [[naevus nail nails naive naked name named namely names napoleon narrative narrow nasal natasha nation national nationalism nations native natural naturally nature natured naval navy near nearer nearest nearly nebraska necessarily necessary necessity neck necrosis need needed needle needles needs negative negotiations negro negroes neighbor neighboring neighbors neither nephew nerve nerves nervous nesvitski net neuritis neuro neuroma never nevertheless new newly news newspaper newspapers next nice nicholas niece niemen night nights nine nineteenth no nobility noble nobody nodded nodules noise nominated non none nonsense nor normal north northern northwest nose not note notes nothing notice noticed noticing novel november now nowhere nullification number numbers numerous nurse nursery]],
    o = [[oak oath obey object obligations obliged observation observe observed observing obtain obtained obvious obviously occasion occasional occasionally occupation occupations occupied occupy occur occurred occurrence occurring occurs october odour oedema oedematous of off offended offensive offer offered offering office officer officers offices official officials often ogg oh ohio oil old older olmutz on once one ones only onset onto open opened opening openly operate operating operation operations operative opinion opinions opium opponent opponents opportunity opposed opposing opposite opposition or orange orbit order ordered orderly orders ordinary oregon org organism organisms organization organized organs origin original originate originates orleans osseous ossification ossifying osteoma osteomyelitis other others otherwise otradnoe ought our ours ourselves out outcome outer outline outside over overcoat overcome overgrowth overlying overthrow owe owing own owner owners ownership]],
    p = [[pace paced paces pacific pacing pack packed packing pad page paid pain paine painful painfully pains painted pair palace pale palm panama panic papa paper papers parade paraffin paragraph paralysis pardon parents paris parliament part parted partial particular particularly parties partly partner parts party pas pass passage passed passes passing passion passionate passionately passions passive past patches path pathological patience patient patients patriotic pause paused pavlograd pavlovna pay paying payment peace peaceful peasant peasants peculiar pelvis pen pennsylvania people peoples per perfect perfectly perform performed perhaps peri period periods periosteal periosteum peripheral perish perished permanent permanently permission permit permitted perplexity persist persistent person personal personally persons peter petersburg petition petya pfuel phalanx phase phenomena philadelphia philippines photograph phrase physical physically pick picked picture pictures piece pieces pierre pilgrims pillow pink pioneers pipe pistol pity place placed places placing plain plainly plan plans plantations planters planting platform platon play played playing plea pleasant please pleased pleasure plenty plexus plump pocket point pointed pointing points poisoning poland pole police policies policy polish political politics pond pool poor popliteal popular population porch porter portion portions porto portrait ports pose position positions positive possessed possession possibility possible possibly post posted posterior posts pounds pour poured poverty powder power powerful powers pp practical practically practice pray prayed prayer precious precisely prefer preferred preoccupied preparation preparations prepare prepared preparing prepuce prescribed presence present presented presents preserve presidency president presidential press pressed pressing pressure pretext pretty prevent prevented preventing previous previously price prices pride priest primary prince princess principal principle principles print printed prison prisoner prisoners private privileges probable probably problem problems procedure process processes proclamation produce produced produces producing production products profession professional profit profits profound profuse prognosis program progress progressive project projecting projects prolonged prominent promise promised promoted promptly pronounced proof proper properly property proportion proposal propose proposed proprietary prosperity protect protected protection protective protested protests proud prove proved proves provide provided providence providing province provinces provincial provision provisions prussia public puckered pull pulled pulling pulsation pulse punctured punish punished punishment purchase pure purely puritans purple purpose purposes purse pursued pursuit purulent pus pushed pushing put putting pyaemia pyogenic]],
    q = [[qualifications qualities quantity quarrel quarter quarters queen question questioned questioning questions quick quickly quiet quietly quite]],
    r = [[race radial radiant radical radiogram radium raevski rage railway railways rain raise raised raising ran rang range rank ranks rapid rapidity rapidly rapturous rare rarely rate rates rather ratification ratified raw ray rays re reach reached reaches reaching reaction read readily readiness reading ready real reality realize realized really realm rear reason reasonable reasoning reasons rebellion recall recalled recalling receive received receiving recent recently reception reckoned recognised recognition recognize recognized recognizing recollection recommended reconstruction record recorded records recourse recover recovered recovery rectum recurrent red redness redoubt reduce reduced reduction reference references referred reflected reflection reform reformers refrain refund refusal refuse refused regard regarded regarding regeneration regiment regimental regiments region regions regret regular regulation reign reins rejected relapse relate related relation relations relative release reliable relief relieve relieved religion religious reluctantly remain remained remaining remains remark remarkable remarkably remarked remarks remedy remember remembered remembering reminded removal remove removed removing render rendered renewed repair repeal repeat repeated repeatedly repeating replaced replacement replied reply replying report reported reports representation representative representatives represented representing reproach republic republican republicans reputation request require required requirements research resemble resembles resembling reserve resist resistance resolute resolutely resolution resolutions resolved resources respect respected respectful respectfully respects respiration responded response responsibility responsible rest rested resting restless restoration restore restored restrain restricted restrictions result resulted resulting results resumed retain retained retire retired retreat retreating return returned returning returns revealed revenue review revolt revolution revolutionary reward rhetor rheumatism rhode rice rich rickets rico rid ridden ride riding right rights rigid ring ringing rise risen rises rising risk river rivers road roads roar robert rode rodent role roll rolled rolling roof room rooms roosevelt root rose rostopchin rostov rostova rostovs rosy rough round rounded roused route routine row rows royal roylott rubbed rubber rubbing rubles rucastle ruin ruined rule ruler rules rumors run running runs rupture rush rushed rushing russia russian russians ryazan]],
    s = [[saber sac sacred sacrifice sad saddle safe safety said sailors sake sale saline sallow salt same samovar samuel san sang sank sarcoma sat satisfaction satisfactory satisfied save saved saving saw say saying says scale scalp scapula scar scarcely scarlet scars scattered scene scheme school schools sciatic science sclerosis scotch scott scoundrel scraped screamed sea seaboard search searching seas seat seated seats sebaceous secession second secondary secondly seconds secret secretary section sections secure secured securing security see seeing seek seeking seem seemed seems seen sees seize seized seizing seldom select selected self sell senate senator senators send sending sensation sense senseless sensibility sensitive sent sentence sentiment separate separated separation september septic sequestrum serene serfs sergeant series serious seriously serous serum servant servants serve served service services serving servitude set setting settle settled settlement settlements settlers seven seventy several severe severely severity shade shadow shaft shaking shall shame shape shaped share shared sharing sharp sharply shawl she sheath sheaths shed sheep sheet shell sherlock sherman shevardino shining shinshin ship shipping ships shirt shock shoes shone shook shop shops short shortly shot shots should shoulder shoulders shout shouted shouting shouts show showed showing shown shows shrugged shut shy sick side sides sigh sighed sight sign signal signed significance significant signs silence silent silently silk silver similar simon simple simplicity simply simultaneously sin since sincere sincerely sing singing single singular sinking sinus sinuses sir sire sister sit site sitting situated situation situations six sixteen sixth sixty size skeleton skill skilled skin skull sky slave slavery slaves sleep sleeping sleepy sleeve sleeves sleigh slender slept slight slightest slightly slip slipped slipping slope slough sloughs slow slowly small smaller smart smell smile smiled smiling smilingly smith smoke smolensk smooth snow snuffbox so sobbing sobs social society sofa soft softened softly soil sold soldier soldiers sole solemn solemnly solid solitary solution some somebody someone something sometimes somewhat somewhere son song sons sonya soon sooner sore sores sorrow sorry sort sorts sought soul sound sounded sounds source sources south southern sovereign sovereignty space spaces spain spanish spare spasms speak speaker speaking special specially specific spectacles speech speed spend spent speranski sphere spinal spine spirit spirits spiritual spite splendid splints spoils spoke spoken spongy spoon spot sprang spread spreading spreads spring spurs squadron square st stable staff stage stages stain stained stairs stake stamp stand standard standards standing star stared stars start started starting state stated statement states statesmen station stationed status stay stayed staying steadily steady steam steel step stepfather stepped stepping steps sterilised stern sternly steward stick stiff stiffness still stir stirred stock stolen stomach stone stood stop stopped stopping stores stories storm story stout straight strain strange strangely stranger straw stream street streets strength strengthen stretched stretching strict strike striking stroke strong stronger strongly struck structure structures struggle struggling stuck studies study stump stupid sub subclavian subcutaneous subject subjected subjects submission submit submitted subsequent subsequently substance substances subtle succeeded success successful successfully such suction sudden suddenly suffer suffered suffering sufferings sufficient sufficiently suffrage sugar suggest suggested suggestion suit suitable suite sum summer summoned sums sun sunk sunshine superficial superior supervision supper supplied supplies supply support supported suppose supposed supposing suppuration suppurative supremacy supreme sure surely surface surfaces surgeon surgery surgical surprise surprised surrender surrendered surrounded surrounding surroundings suspected suspicion sustained suture sutures suvorov swayed swaying sweet swelling swellings swept swift swiftly swollen sword sympathetic sympathy symptom symptoms synovial synovitis syphilis syphilitic system]],
    t = [[table taft tail take taken takes taking tale talk talked talking tall tariff tarutino task taste taught tax taxation taxes tea teach tear tearing tears teeth tell telling tells telyanin temper temperature temple temporarily temporary ten tend tendency tender tenderness tendon tendons tends tennessee tense tension tent tenure term terminal terms terrible terribly territories territory terror tertiary test tetanus texas text th than thank thanks that the theater thee their them themselves then theodore theories theory there thereby therefore thereof these they thick thickened thickening thigh thin thing things think thinking thinks third thirds thirteen thirty this thomas thoracic thoroughly those thou though thought thoughtful thoughts thousand thousands threatened threatening three threw throat thrombosis thrombus throne through throughout throw throwing thrown thrust thumb thus thy thyreoid tibia tide tied ties tight tightly tikhon till time times timid timidly timokhin tiny tiptoe tired tissue tissues title tm to tobacco today toe toes together told toll tomorrow tone tones tongue too took tooth top topics tormented torn total touch touched touching tourniquet toward towards town towns toxins trace traces track trade trademark trading traffic train trained trains traitor tranquil transfer transferred transformed transmitted transport transportation trap traumatic travel traveling treason treasury treat treated treaties treating treatment treaty tree trees trembled trembling trial tried triumph trivial troops trophic trot trouble troubles trousers true trunk trunks trust trusts truth try trying tsar tube tubercle tuberculosis tuberculous tumour tumours turkey turn turned turner turning turns tushin twelve twenty twice twisted two type types typhoid typical]],
    u = [[uhlans ulcer ulceration ulcers ultimately unable uncertain uncle uncomfortable uncommon unconscious unconsciously under undergo understand understanding understood undertaking underwood undoubtedly unexpected unexpectedly unfortunate unhappy uniform uniforms union unions unite united universal university unknown unless unlike unnatural unnecessary unpleasant until unusual up upon upper upset upstairs upwards urged urine us use used useful useless using usual usually utah utter uttered utterly]],
    v = [[vague vain vainly valet valley valuable value valves vanished varicose varies varieties variety various varix vary varying vascular vasili vast ve vehicles vein veins venous ventured vera vereshchagin verses vertebrae very vessel vessels vested vexation vexed vi vice vicinity vicomte victory vienna view viewed views vigorous vigorously vii viii village villages vilna violence violent virginia virtue virus visible visit visited visitor visitors vital vitality vividly vodka voice voices void vol vols volume volunteers vote voted voters votes vous vyazma]],
    w = [[wages wagon wagons waistcoat wait waited waiting wake walk walked walking wall walls want wanted wants war warfare warm warmly warning wars was wash washed washing washington waste wasted watch watched watching water waters watson wave waved wax way ways we weak weaker weakness wealth wealthy weapon wear wearing weary weather web webster wedding week weeks weep weight welcomed welfare well went wept were west western westward wet weyrother what whatever wheat wheel wheels when whence whenever where wherever whether which whigs while whip whisper whispered whistle whistling white whitlow who whole whom whose why wide widely widespread wife wild will willarski william willing wilson win wind windibank window windows wine wing winter wire wisconsin wisdom wise wish wished wishes wishing with withdraw withdrawn within without witness witnessed woke wolf wolzogen woman women won wonder wonderful wood wooden woods wool word words wore work worked workers working works world worn worse worst worth worthy would wouldn wound wounded wounds wrapped wretched wrinkled wrist write writers writes writing written wrong wrote www]],
    x = [[xi xii xiii xiv xv xvi]],
    y = [[yard yards year years yellow yes yesterday yet yield yielding york you young younger your yours yourself youth]],
    z = [[zeal zherkov zone]],
}

local WORDS = {}
local used = {}
for letter, text in pairs(WORD_DATA) do
    WORDS[letter] = string.split(text, " ")
    used[letter] = {}
end

local gui = Instance.new("ScreenGui")
gui.Name = "TinyWordGenerator"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local purple = Color3.fromRGB(112, 65, 190)
local panelColor = Color3.fromRGB(19, 19, 24)
local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end
local function stroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Parent = obj
end
local function button(parent, text, size, pos, color, textSize)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = color
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = textSize or 10
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = true
    b.Parent = parent
    round(b, 5)
    return b
end

-- Compact main panel
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(190, 222)
main.Position = UDim2.new(0.5, -95, 0.5, -111)
main.BackgroundColor3 = panelColor
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
round(main, 8)
stroke(main, purple, 1)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -34, 0, 22)
title.Position = UDim2.fromOffset(7, 2)
title.BackgroundTransparency = 1
title.Text = "WORD GENERATOR"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 11
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = button(main, "X", UDim2.fromOffset(20, 18), UDim2.new(1, -24, 0, 4), Color3.fromRGB(145, 45, 55), 10)
local selected = "a"
local currentWord = nil

local letterLabel = Instance.new("TextLabel")
letterLabel.Size = UDim2.new(1, 0, 0, 16)
letterLabel.Position = UDim2.fromOffset(0, 25)
letterLabel.BackgroundTransparency = 1
letterLabel.Text = "LETTER: A"
letterLabel.TextColor3 = Color3.fromRGB(190, 170, 255)
letterLabel.TextSize = 10
letterLabel.Font = Enum.Font.GothamBold
letterLabel.Parent = main

local alphabet = Instance.new("Frame")
alphabet.Size = UDim2.new(1, -12, 0, 76)
alphabet.Position = UDim2.fromOffset(6, 43)
alphabet.BackgroundTransparency = 1
alphabet.Parent = main
local grid = Instance.new("UIGridLayout")
grid.CellSize = UDim2.fromOffset(24, 18)
grid.CellPadding = UDim2.fromOffset(1, 1)
grid.SortOrder = Enum.SortOrder.LayoutOrder
grid.Parent = alphabet

local word = Instance.new("TextLabel")
word.Size = UDim2.new(1, -12, 0, 35)
word.Position = UDim2.fromOffset(6, 123)
word.BackgroundColor3 = Color3.fromRGB(30, 29, 38)
word.Text = "Choose a letter"
word.TextColor3 = Color3.new(1, 1, 1)
word.TextSize = 17
word.Font = Enum.Font.GothamBold
word.TextWrapped = true
word.Parent = main
round(word, 5)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 14)
status.Position = UDim2.fromOffset(0, 160)
status.BackgroundTransparency = 1
status.Text = string.format("4967 COMMON WORDS LOADED", 4967)
status.TextColor3 = Color3.fromRGB(155, 155, 170)
status.TextSize = 8
status.Font = Enum.Font.Gotham
status.Parent = main

local generate = button(main, "GENERATE", UDim2.fromOffset(108, 22), UDim2.fromOffset(6, 183), purple, 10)
local clear = button(main, "X", UDim2.fromOffset(62, 22), UDim2.fromOffset(120, 183), Color3.fromRGB(145, 45, 55), 10)

local function chooseWord(prefix)
    prefix = string.lower(prefix or selected)
    local matching = {}

    for _, list in pairs(WORDS) do
        for _, candidate in ipairs(list) do
            if string.sub(candidate, 1, #prefix) == prefix then
                table.insert(matching, candidate)
            end
        end
    end

    if #matching == 0 then
        word.Text = "No matching word"
        status.Text = "NO WORDS FOR " .. string.upper(prefix)
        return
    end

    used[prefix] = used[prefix] or {}
    local available = {}
    for _, candidate in ipairs(matching) do
        if not used[prefix][candidate] then
            table.insert(available, candidate)
        end
    end

    if #available == 0 then
        used[prefix] = {}
        available = table.clone(matching)
        status.Text = "WORD LIST RESET"
    end

    local chosen = available[math.random(1, #available)]
    used[prefix][chosen] = true
    currentWord = chosen
    word.Text = chosen
    status.Text = string.format("%d LEFT FOR %s", #available - 1, string.upper(prefix))
end

for i = 1, 26 do
    local letter = string.char(96 + i)
    local b = button(alphabet, string.upper(letter), UDim2.fromOffset(24, 18), UDim2.new(), Color3.fromRGB(43, 39, 54), 9)
    b.LayoutOrder = i
    b.Activated:Connect(function()
        selected = letter
        letterLabel.Text = "LETTER: " .. string.upper(letter)
        word.Text = "Ready to generate"
        status.Text = string.format("%d WORDS AVAILABLE", #WORDS[letter])
    end)
end

generate.Activated:Connect(function()
    chooseWord(selected)
end)
clear.Activated:Connect(function()
    chooseWord(selected)
end)
close.Activated:Connect(function() main.Visible = false end)

-- Automatically generate a word when the game's LetterEvent updates.
task.spawn(function()
    local folders = workspace:WaitForChild("MatchmakingFolders")
    local normal = folders:WaitForChild("Normal")
    local twoPlayers = normal:WaitForChild("2 Players")
    local base = twoPlayers:WaitForChild("Base")
    local underscoreFolder = base:WaitForChild("_")
    local letterEvent = underscoreFolder:WaitForChild("LetterEvent")

    letterEvent.OnClientEvent:Connect(function(action, payload)
        if action ~= "Update" then return end

        local incoming = payload
        if typeof(payload) == "table" then
            incoming = payload[1]
        end
        if typeof(incoming) ~= "string" then return end

        local prefix = string.upper(incoming):gsub("[^A-Z]", "")
        if #prefix < 1 or #prefix > 2 then return end

        selected = string.lower(prefix)
        letterLabel.Text = "LETTER: " .. prefix
        chooseWord(selected)
    end)
end)

-- Draggable circular open/close button
local toggle = button(gui, "W", UDim2.fromOffset(36, 36), UDim2.new(0, 14, 0.5, -18), purple, 15)
toggle.Name = "ToggleButton"
toggle.Text = "W"
toggle.Active = true
for _, child in ipairs(toggle:GetChildren()) do
    if child:IsA("UICorner") then child:Destroy() end
end
round(toggle, 18)
stroke(toggle, Color3.fromRGB(185, 150, 255), 1)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil
local wasDragged = false

toggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        wasDragged = false
        dragStart = input.Position
        startPos = toggle.Position
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if math.abs(delta.X) + math.abs(delta.Y) > 5 then wasDragged = true end
        toggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input == dragInput or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

toggle.Activated:Connect(function()
    if not wasDragged then main.Visible = not main.Visible end
end)

-- Randomize the starting word-selection state on each launch.
math.randomseed(os.clock() * 1000000)
