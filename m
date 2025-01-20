Return-Path: <linux-pm+bounces-20676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F7A1680A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 09:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410633A9B54
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75118FDAA;
	Mon, 20 Jan 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OOmKIHFV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7CA47F4A;
	Mon, 20 Jan 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361069; cv=none; b=YfKYbp6ivdacwUZKFBJ/xgMaR5j/uVBPHJ9sEJnZiQjrAK9EeXMzotQistf9GqrPjAsLoUcvrAnvQX32729HTTGyDfBenOyDOTaSJvMdMKT0fCeflA263d1s1e2ZcuGcrNj9oUdqPOAJO42llRGo63+r5dKh7MLTCx+nkE0vtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361069; c=relaxed/simple;
	bh=zKl6Txaebv4SK/khNmkZmV2TLbiSBGewzLhe7zeDjRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=k8V7aMcjydnuH1BrVudkSBJKaGCJgaXrVg3blgQmR6PJ9M8s3ziTpjV1Dlv/vA4Z0bYFvUhYF0qw+AppheH/us/zlDKZ02L7VNocYFCY2k/XUv17xWSv84rGiO0NUmHddZxQe5Phkom39E0SPq0zsZVrjbwVexsalurn3ubor9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OOmKIHFV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7WirJ010503;
	Mon, 20 Jan 2025 08:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u3reHC
	Uh/PKj1xmYcvbaCnUSs8DHNyqw3B+ATtodj04=; b=OOmKIHFVDCCst4BcPoiLaF
	7gz/AKdtHhaHSUARsGsJngcwWEU2s+P6JtqeM+lQ8tWWnIlwQoXlv5QVPpBrkR17
	qoagEee7gLE4fNrMryRbzzar85WVxKfRV+Z8SB7PMX5/KnzZ/wqt5iYMzZN4+49h
	dmsYBajrji8VAlYXSzYLgFMU5ibD4pvo8wCLevCBE9Qrn1tNWnK/TlyzhTfaoO0o
	H12czawoWOgA71soQKo9st8AyEmezm9UdtvBWFL67+MWlOGazxFOTXgBjPJxrWfs
	lsnTSBHQSM5xmc9oCwGEHFVatR7uIZOqXFFByLroWuFwXSr3q74gS/DvXnwGlkMg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n85qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 08:17:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K708Mk019261;
	Mon, 20 Jan 2025 08:17:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pms5kd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 08:17:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50K8Hcfq53412334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 08:17:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE0D58062;
	Mon, 20 Jan 2025 08:17:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F131258056;
	Mon, 20 Jan 2025 08:17:35 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 08:17:35 +0000 (GMT)
Message-ID: <2007eace0fa9f591917cdd228c2cb66f045480d0.camel@linux.ibm.com>
Subject: Re: [PATCH v1 0/9] cpuidle: teo: Cleanups and very frequent wakeups
 handling update
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J. Wysocki"
	 <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano
 <daniel.lezcano@linaro.org>,
        Artem Bityutskiy
 <artem.bityutskiy@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Date: Mon, 20 Jan 2025 13:47:29 +0530
In-Reply-To: <d095149c-fb76-40e8-a459-05e4d2e50cf5@arm.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
	 <d095149c-fb76-40e8-a459-05e4d2e50cf5@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KC6sgpC3RDXuWPtwvC0_sZKevp4A44Ng
X-Proofpoint-ORIG-GUID: KC6sgpC3RDXuWPtwvC0_sZKevp4A44Ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200066

On Wed, 2025-01-15 at 14:52 +0000, Christian Loehle wrote:
> On 1/13/25 18:32, Rafael J. Wysocki wrote:
> > Hi Everyone,
> > 
> > This supersedes
> > 
> > https://lore.kernel.org/linux-pm/4953183.GXAFRqVoOG@rjwysocki.net/
> > 
> > but because the majority of patches in it are new, I've decided to count
> > version numbers back from 1.
> > 
> > This addresses a relatively recently added inconsistency in behavior of the teo
> > governor regarding the handling of very frequent wakeups handling (patch [7/9])
> > and makes some other changes that may be regarded as cleanups.
> > 
> > Please review.
> 
> Hi Rafael,
> that looks promising. I'll review the individual patches in detail now, but
> I let a few tests run overnight and can report that there's no significant
> behaviour change with the series on an arm64 (no polling state, rk3399), which
> is my expected result.
> 
> I'll get something running on a system with a polling state as well.
> (I don't have a POWER system, so that will just be x86, adding Aboorva.)


Christian,

Thanks for adding me to the thread.

Rafael,

I did some tests with the patch on a Pseries Power10 system:

Here are the system details:

--------------------------------------------------------------------------------
Architecture:                         ppc64le
Byte Order:                           Little Endian
CPU(s):                               48
On-line CPU(s) list:                  0-47
Model name:                           POWER10 (architected), altivec supported
Model:                                2.0 (pvr 0080 0200)
Thread(s) per core:                   8
Core(s) per socket:                   6
Socket(s):                            1
Physical sockets:                     8
Physical chips:                       1
Physical cores/chip:                  10

--------------------------------------------------------------------------------
# cpupower idle-info
CPUidle driver: pseries_idle
CPUidle governor: menu
analyzing CPU 5:

Number of idle states: 2
Available idle states: snooze Shared Cede
snooze:
Flags/Description: snooze
Latency: 0
Usage: 1411724
Duration: 27481504
Shared Cede:
Flags/Description: Shared Cede
Latency: 10
Usage: 326573
Duration: 31098864616
--------------------------------------------------------------------------------

How to infer the results:

Above Diff (%) and Below Diff (%) represent the number of cpuidle misses, 
indicating how frequently the selected cpuidle state was either too deep or
too shallow. So, these values should not be too high.
--------------------------------------------------------------------------------

The below test is done using a predictable timer and non-timer benchmark [1]:

--------------------------------------------------------------------------------
Menu Governor:
--------------------------------------------------------------------------------

With pipe wakeup (non-timer):

--------------------------------------------------------------------------------------------------------
   Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  Total Below Diff  Below Diff (%)
--------------------------------------------------------------------------------------------------------
0           5.980           1656304                 2        0.000121                 0        0.000000
1          10.959            901972              1954        0.216636                 0        0.000000
--------------------------------------------------------------------------------------------------------
2          15.726            243971            237112       97.188600                 0        0.000000
3          20.813            232069            227258       97.926910                 0        0.000000
4          30.896            209884            206492       98.383869                 0        0.000000
5          40.991            216704            213642       98.587013                 0        0.000000
6          51.002            195632            192963       98.635704                 0        0.000000
7          61.014            163726            161506       98.644076                 0        0.000000
8          71.006            140739            138809       98.628667                 0        0.000000
9          81.008            123386            120725       97.843353                 0        0.000000
10        101.020             98974             81235       82.077111                 0        0.000000
--------------------------------------------------------------------------------------------------------
11        111.044             90018              1513        1.680775                12        0.013331
12        121.015             82704               189        0.228526                77        0.093103
13        131.028             76534               272        0.355398               321        0.419421
14        141.008             71610               698        0.974724               693        0.967742
15        151.021             66869               666        0.995977               656        0.981023
16        161.027             62709               611        0.974342               605        0.964774
17        171.033             59063               593        1.004013               593        1.004013
18        181.019             55819               571        1.022949               541        0.969204
19        191.016             52998               641        1.209480               628        1.184950
20        201.017             50353               551        1.094274               501        0.994975
21        251.054             40535               289        0.712964               398        0.981868
22        301.037             33966               252        0.741918               330        0.971560
23        351.038             29279               216        0.737730               294        1.004133
24        401.047             25765               190        0.737435               262        1.016883
25        451.060             23021               185        0.803614               187        0.812302
26        501.049             20831               150        0.720081               216        1.036916
27       1001.076             10951                77        0.703132               126        1.150580

With timer wakeup:

--------------------------------------------------------------------------------------------------------
   Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  Total Below Diff  Below Diff (%)
--------------------------------------------------------------------------------------------------------
0           7.590           1310772                 0        0.000000                 0        0.000000
1          12.631            789377               780        0.098812                 0        0.000000
2          21.791            458001             52321       11.423774                 0        0.000000
3          22.648            440752                36        0.008168                 0        0.000000
4          32.644            305983                 0        0.000000                 0        0.000000
5          42.646            234305                 0        0.000000                 0        0.000000
6          52.647            189858                 2        0.001053                 0        0.000000
7          62.649            159561                10        0.006267                 0        0.000000
8          72.644            137643                 5        0.003633                 1        0.000727
9          82.666            120963                 5        0.004133                 0        0.000000
10        102.654             97442                 3        0.003079               610        0.626013
11        145.805             69937               441        0.630568              1345        1.923159
12        156.057             64511                75        0.116259               439        0.680504
13        166.047             60765               215        0.353822               534        0.878795
14        175.894             57564               178        0.309221               687        1.193454
15        185.933             54471               255        0.468139               638        1.171265
16        195.975             51403                98        0.190650               212        0.412427
17        206.062             49281               174        0.353077               577        1.170837
18        216.188             46980                33        0.070243               571        1.215411
19        226.346             44879                30        0.066846               543        1.209920
20        236.353             43081                27        0.062673               516        1.197744
21        286.158             35782                 5        0.013974               154        0.430384
22        336.730             30531                11        0.036029               266        0.871246
23        386.730             26722                18        0.067360               232        0.868198
24        436.770             23797                 9        0.037820               196        0.823633
25        487.229             21359                13        0.060864               229        1.072148
26        537.375             19557                13        0.066472               259        1.324334
27       1037.871             10638                12        0.112803               127        1.193833

--------------------------------------------------------------------------------
Teo governor:
--------------------------------------------------------------------------------

With pipe wakeup (non-timer):

--------------------------------------------------------------------------------------------------------
   Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  Total Below Diff  Below Diff (%)
--------------------------------------------------------------------------------------------------------
0           5.972           1657561                 6        0.000362                 0        0.000000
1          10.964            907279                 0        0.000000                 0        0.000000
2          15.977            623681                 0        0.000000                 0        0.000000
3          20.980            475385                 1        0.000210                 0        0.000000
4          30.981            322151                 0        0.000000                 0        0.000000
5          40.975            243749                 0        0.000000                 0        0.000000
6          50.977            195989                 0        0.000000                 0        0.000000
7          60.981            163876                 0        0.000000                 0        0.000000
8          70.978            140818                 0        0.000000                 0        0.000000
9          80.976            123460                 0        0.000000                 1        0.000810
10        100.970             99038                 0        0.000000                16        0.016155
--------------------------------------------------------------------------------------------------------
11        111.027            106919              5388        5.039329             16873       15.781105
--------------------------------------------------------------------------------------------------------
12        121.017             83074               381        0.458627               443        0.533260
13        131.024             76588               323        0.421737               373        0.487021
14        141.027             71592               695        0.970779               695        0.970779
15        151.023             66874               669        1.000389               662        0.989921
16        161.026             62719               607        0.967809               595        0.948676
17        171.027             59064               581        0.983679               574        0.971827
18        181.020             55817               561        1.005070               532        0.953115
19        191.020             52883               523        0.988976               446        0.843371
20        201.025             50509               670        1.326496               645        1.277000
21        251.037             40544               280        0.690608               409        1.008781
22        301.033             33988               263        0.773803               349        1.026833
23        351.036             29285               221        0.754653               299        1.021001
24        401.042             25777               203        0.787524               272        1.055204
25        451.040             23029               174        0.755569               238        1.033480
26        501.048             20838               157        0.753431               224        1.074959
27       1001.097             10949                79        0.721527               134        1.223856

With timer wakeup:

--------------------------------------------------------------------------------------------------------
   Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  Total Below Diff  Below Diff (%)
--------------------------------------------------------------------------------------------------------
0           7.541           1319205                 0        0.000000                 0        0.000000
1          12.546            794464                 0        0.000000                 0        0.000000
2          17.540            568954                 0        0.000000                 0        0.000000
3          22.572            442307                 0        0.000000                 0        0.000000
4          32.583            306443                 0        0.000000                 1        0.000326
5          42.597            233238                 0        0.000000                 0        0.000000
6          52.587            190067                 0        0.000000                 0        0.000000
7          62.590            159714                 0        0.000000                 1        0.000626
8          72.574            137755                 0        0.000000                 2        0.001452
9          82.581            121081                 0        0.000000                 0        0.000000
10        102.589             97491                 0        0.000000              1912        1.961207
11        146.385             68906                47        0.068209               599        0.869300
12        156.548             64565                86        0.133199               670        1.037714
13        166.588             60562               100        0.165120               518        0.855322
14        176.676             57264               263        0.459276               642        1.121123
15        186.563             54262               293        0.539973               601        1.107589
16        195.986             51668               192        0.371603               526        1.018038
17        206.860             49028                97        0.197846               564        1.150363
18        216.899             46669                27        0.057854               460        0.985665
19        227.016             44528                22        0.049407               367        0.824201
20        237.055             42883                28        0.065294               507        1.182287
21        286.998             35665                 9        0.025235               283        0.793495
22        337.410             30439                 7        0.022997               264        0.867308
23        387.522             26652                18        0.067537               251        0.941768
24        437.570             23742                 8        0.033696               221        0.930840
25        487.804             21293                10        0.046964                94        0.441460
26        537.884             19505                 7        0.035888               243        1.245834
27       1038.863             10633                 4        0.037619               135        1.269632

--------------------------------------------------------------------------------
Teo Governor with patch
--------------------------------------------------------------------------------

With pipe wakeup (non-timer): 

--------------------------------------------------------------------------------------------------------
   Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  Total Below Diff  Below Diff (%)
--------------------------------------------------------------------------------------------------------
0           5.959           1661754                 5        0.000301                 0        0.000000
1          10.963            907497                 2        0.000220                 0        0.000000
2          15.968            623957                 2        0.000321                 0        0.000000
3          20.970            475574                 2        0.000421                 0        0.000000
4          30.974            321718                 2        0.000622                 0        0.000000
5          40.974            243714                 2        0.000821                 0        0.000000
6          50.983            195931                 2        0.001021                 0        0.000000
7          60.974            163876                 2        0.001220                 1        0.000610
8          70.973            140810                 2        0.001420                 1        0.000710
9          80.988            123420                 1        0.000810                 4        0.003241
10        100.994             99014                 2        0.002020                20        0.020199
--------------------------------------------------------------------------------------------------------
11        111.023            135597             11864        8.749456             45561       33.600301 => This is observed even
--------------------------------------------------------------------------------------------------------   without the patch,
12        121.035             82948               348        0.419540               352        0.424362    when the sleep interval
13        131.019             76342                82        0.107411                48        0.062875    is almost equal to the
14        141.028             70948                70        0.098664                57        0.080341    residency time of state1.
15        151.023             66278                81        0.122212                69        0.104107
16        161.021             62146                65        0.104592                51        0.082065
17        171.023             58509                64        0.109385                47        0.080330
18        181.026             55301                64        0.115730                48        0.086798
19        191.033             52407                67        0.127846                45        0.085866
20        201.024             49803                52        0.104411                48        0.096380
21        251.042             39911                39        0.097717                45        0.112751
22        301.040             33302                29        0.087082                40        0.120113
23        351.045             28572                37        0.129497                34        0.118998
24        401.057             25005                20        0.079984                27        0.107978
25        451.055             22246                21        0.094399                26        0.116875
26        501.053             20031                14        0.069892                25        0.124807
27       1001.099             10055                 7        0.069617                15        0.149180


With timer wakeup: 

--------------------------------------------------------------------------------------------------------
   Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  Total Below Diff  Below Diff (%)
--------------------------------------------------------------------------------------------------------
0           7.566           1314872                 0        0.000000                 0        0.000000
1          12.553            794091                 0        0.000000                 0        0.000000
2          17.573            567627                 0        0.000000                 0        0.000000
3          22.631            441084                 0        0.000000                 0        0.000000
4          32.633            306095                 0        0.000000                 0        0.000000
5          42.631            234377                 0        0.000000                 0        0.000000
6          52.634            189899                 0        0.000000                 0        0.000000
7          62.642            159572                 0        0.000000                 0        0.000000
8          72.645            137619                 0        0.000000                 1        0.000727
9          82.616            121037                 0        0.000000                 1        0.000826
10        102.636             97423                 0        0.000000              1047        1.074695
11        145.823             69245                43        0.062098               680        0.982020
12        155.912             64546                90        0.139435               478        0.740557
13        166.103             60709               219        0.360737               501        0.825248
14        176.036             57483               196        0.340970               639        1.111633
15        186.043             54448               250        0.459154               623        1.144211
16        195.552             51428               124        0.241114               230        0.447227
17        205.990             49270               141        0.286178               527        1.069616
18        216.300             46931                39        0.083101               545        1.161279
19        226.288             44884                23        0.051243               520        1.158542
20        236.372             43056                20        0.046451               493        1.145020
21        285.985             35724                 1        0.002799               119        0.333109
22        336.636             30526                11        0.036035               262        0.858285
23        386.522             26772                17        0.063499               218        0.814284
24        436.749             23857                26        0.108983               208        0.871862
25        487.204             21358                 9        0.042139               240        1.123701
26        537.312             19530                 7        0.035842               235        1.203277
27       1038.147             10610                 2        0.018850               119        1.121583
--------------------------------------------------------------------------------


I also did some tests with postgres (pgbench) - with the patch: 

+---------------------------+--------------------+------------------+
| Metric                    | Shared Cede        | Snooze           |
+---------------------------+--------------------+------------------+
| Total Usage Difference    | 119,453            | 20,472,846       |
| Total Time Difference     | 502.79 seconds     | 324.90 seconds   |
| Total Above Difference    | 74,500 (0.36%)     | 0                |
| Total Below Difference    | 0                  | 336,703 (1.64%)  |
+---------------------------+--------------------+------------------+

% Above Diff = 0.36% of total usage
% Below Diff = 1.64% of total usage


Using both the deterministic micro-benchmark and pgbench, I observed that the
teo governor with the patch as anticipated does not cause any noticable increase in the cpuidle
state prediction miss on PowerPC (pseries) (% above and below diff).

So, for the entire series:

Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>


[1]: https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidle/cpuidle_wakeup


