Return-Path: <linux-pm+bounces-20699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400E4A1701C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60118168AC6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7781E9B3D;
	Mon, 20 Jan 2025 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/MM51JF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5719BA6;
	Mon, 20 Jan 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390304; cv=none; b=MeFURHp5WGvizsfEGaiAJPX/Nprvsfx56lqumZazptqQtcYO86bRcpyyZcZewlp2R8ZbaVG4HNprS0O6q8VT+sH1XF/LixrdNni0RpfdBa/w65byZRasx6Q4nO8/naqgZjPylNbdYSl7a9rguqJzFfZNOTuaCDoIAw7xDozNcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390304; c=relaxed/simple;
	bh=7ZzqyichqoiwkTcfnPJ4A94FUOoESHk4egTLW0r3VGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1EhqTIymaPHlKQtwIlHODWXpRZxjqJBytpEnmLjcN+fsfECIYj7ETcIH4DG/iC53F6MC2EI8oruLpd3cBfmpqdN2IWBRrqrPEagvku2yaMmdfvd+VJ4U3SMAJm4QScI4uDwRQEFDe7z0yTZkkX5srRWeRnzyNQ8bx/U3ZAu5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/MM51JF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929BDC4CEE3;
	Mon, 20 Jan 2025 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737390303;
	bh=7ZzqyichqoiwkTcfnPJ4A94FUOoESHk4egTLW0r3VGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P/MM51JFchF5ZJTkyzTCEBxZk1SoOpUWlAQP73lO/4+7F3SnCWeSKDrU7707Mg0e2
	 C3bK7wrB7VJEaLmKrlqHM+hpSUWfic2iMzD7QvIxR0qCz3GNbViTncEkeRV2qzglKq
	 yEoyXSdv/nNtcTansbXQTwMQFKyp96mx7qhvUN2fstOHr+Tjped68lNp3N9hTyWvt0
	 dyCJi3GSQxJzSvtZsJKlMQDq6xWah5yRtNWx7ovWdnR0EAsa8dB6agVdyBM2uQ9Y3/
	 kdx+Iw9Dp7y7PPbCeU32WpWqoop+TEGQPx/96cJuLDM7U73X99U/6KHlzGpqCQgZf5
	 8E3y+LN+H8wNg==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb9ba53f90so1231518b6e.1;
        Mon, 20 Jan 2025 08:25:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg15TK2wTKa6VEGAnQ5PLgoe2jfIezqwTQnSl2Dibn5PVUr/gNFJSHF0OQhkMcXxIYduucmyc8pYo+6oQ=@vger.kernel.org, AJvYcCWKJEcpW+MmHTmnc072wZ9iNhYua9HvuMpofUp9ZHTn+QDsC9vSLcxfvTH0gtf/tUzqL0t3Sh/yzjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Bwr5z1QeB3RUeNo1JA3o8j4vaYmb5fy3yfZcbAE5/mO6IwyU
	Q8skP6LgY6ClTw2C6UzWbr9QXEug2EUDesUQhBVybVsTwJygWPeUXxWZirndha3kTCAKiBYTCf4
	dBjoMe59isuMonZ/zEfyTmLvNPyA=
X-Google-Smtp-Source: AGHT+IH8Wq4tbKkaILyw/NKYz6CriUgdQ8M9eISBK+wqgvAvFDVjbtFER4NItYT11Zj1TcZGGS/qCfjuFMTw1pFhH5U=
X-Received: by 2002:a05:6808:8413:b0:3ea:582a:f68 with SMTP id
 5614622812f47-3f19fd28c47mr6802049b6e.26.1737390302766; Mon, 20 Jan 2025
 08:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6116275.lOV4Wx5bFT@rjwysocki.net> <d095149c-fb76-40e8-a459-05e4d2e50cf5@arm.com>
In-Reply-To: <d095149c-fb76-40e8-a459-05e4d2e50cf5@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 17:24:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0guCNRFcU1Xa6ekpWxguKmUcHNvfSdY2Wph13mFPMcs0w@mail.gmail.com>
X-Gm-Features: AbW1kvYmzLOmWpyqNdkOp4fq706ecIBXvdPkzt7pl3Fx4LYap4e-_z2C8SznBeY
Message-ID: <CAJZ5v0guCNRFcU1Xa6ekpWxguKmUcHNvfSdY2Wph13mFPMcs0w@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] cpuidle: teo: Cleanups and very frequent wakeups
 handling update
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 3:52=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/13/25 18:32, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This supersedes
> >
> > https://lore.kernel.org/linux-pm/4953183.GXAFRqVoOG@rjwysocki.net/
> >
> > but because the majority of patches in it are new, I've decided to coun=
t
> > version numbers back from 1.
> >
> > This addresses a relatively recently added inconsistency in behavior of=
 the teo
> > governor regarding the handling of very frequent wakeups handling (patc=
h [7/9])
> > and makes some other changes that may be regarded as cleanups.
> >
> > Please review.
>
> Hi Rafael,
> that looks promising. I'll review the individual patches in detail now, b=
ut
> I let a few tests run overnight and can report that there's no significan=
t
> behaviour change with the series on an arm64 (no polling state, rk3399), =
which
> is my expected result.
>
> I'll get something running on a system with a polling state as well.
> (I don't have a POWER system, so that will just be x86, adding Aboorva.)
>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> for the entire series

Thanks, much appreciated!

> I'll just dump some of the raw results here for reference.
> teo-X is teo with everything up to X/9 applied. teo-m is mainline, teo is
> the entire series (equivalent to teo-9).
>
> Everything is done with fio direct random4k read. Range of real devices
> with varying latency, mapper/slow is 51ms timer delay, nullb0 is
> essentially CPU-bound, few intercepts expected.
> --
>
> device   gov     iter    iops    idles   idle_misses     idle_miss_ratio =
        belows  aboves
> mmcblk1         menu    0       1284    344126  106309  0.309   89264   1=
7045
> mmcblk1         menu    1       1340    358646  109469  0.305   91726   1=
7743
> mmcblk1         menu    2       1316    348812  106773  0.306   89845   1=
6928
> mmcblk1         teo     0       2023    559551  30053   0.054   2962    2=
7091
> mmcblk1         teo     1       2007    548422  25816   0.047   2113    2=
3703
> mmcblk1         teo     2       2010    557120  29434   0.053   2782    2=
6652
> mmcblk1         teo-m   0       2010    542790  23336   0.043   1720    2=
1616
> mmcblk1         teo-m   1       2009    554912  29239   0.053   2750    2=
6489
> mmcblk1         teo-m   2       2013    548384  26444   0.048   2180    2=
4264
> mmcblk1         teo-1   0       2030    524056  3571    0.007   610     2=
961
> mmcblk1         teo-1   1       2022    559304  27074   0.048   3373    2=
3701
> mmcblk1         teo-1   2       2009    554744  27406   0.049   2964    2=
4442
> mmcblk1         teo-2   0       2012    542886  18233   0.034   2140    1=
6093
> mmcblk1         teo-2   1       2010    554094  27680   0.050   2957    2=
4723
> mmcblk1         teo-2   2       2010    555222  28549   0.051   3085    2=
5464
> mmcblk1         teo-3   0       2011    556816  28708   0.052   3076    2=
5632
> mmcblk1         teo-3   1       2015    546998  20280   0.037   2414    1=
7866
> mmcblk1         teo-3   2       2020    549758  20802   0.038   2662    1=
8140
> mmcblk1         teo-4   0       2026    536464  11692   0.022   1457    1=
0235
> mmcblk1         teo-4   1       2031    557978  25464   0.046   2928    2=
2536
> mmcblk1         teo-4   2       2012    553812  26323   0.048   2943    2=
3380
> mmcblk1         teo-5   0       2021    557966  3454    0.006   3003    4=
51
> mmcblk1         teo-5   1       2027    546630  18400   0.034   2303    1=
6097
> mmcblk1         teo-5   2       2012    554390  28013   0.051   2990    2=
5023
> mmcblk1         teo-6   0       2037    539956  12764   0.024   1701    1=
1063
> mmcblk1         teo-6   1       2019    556202  29074   0.052   3071    2=
6003
> mmcblk1         teo-6   2       2017    555004  26814   0.048   2869    2=
3945
> mmcblk1         teo-7   0       2028    545802  23806   0.044   1625    2=
2181
> mmcblk1         teo-7   1       2019    557030  29913   0.054   2990    2=
6923
> mmcblk1         teo-7   2       2018    553236  28534   0.052   2657    2=
5877
> mmcblk1         teo-8   0       2018    554662  28595   0.052   2660    2=
5935
> mmcblk1         teo-8   1       2014    554646  28947   0.052   2721    2=
6226
> mmcblk1         teo-8   2       2014    543828  29379   0.054   2915    2=
6464
> mmcblk1         teo-9   0       2013    555356  28867   0.052   2719    2=
6148
> mmcblk1         teo-9   1       2015    557254  29709   0.053   2836    2=
6873
> mmcblk1         teo-9   2       2030    559272  29321   0.052   3052    2=
6269
> mmcblk2         menu    0       2885    434990  140864  0.324   123507  1=
7357
> mmcblk2         menu    1       2766    450918  152931  0.339   135384  1=
7547
> mmcblk2         menu    2       2960    407712  125573  0.308   109224  1=
6349
> mmcblk2         teo     0       5677    741006  24131   0.033   2233    2=
1898
> mmcblk2         teo     1       5652    714494  24412   0.034   2680    2=
1732
> mmcblk2         teo     2       5660    752410  20497   0.027   1809    1=
8688
> mmcblk2         teo-m   0       5683    855232  23454   0.027   1934    2=
1520
> mmcblk2         teo-m   1       5588    517234  32016   0.062   5443    2=
6573
> mmcblk2         teo-m   2       5654    668648  29108   0.044   3171    2=
5937
> mmcblk2         teo-1   0       5666    773452  25740   0.033   3430    2=
2310
> mmcblk2         teo-1   1       5638    668190  27619   0.041   4150    2=
3469
> mmcblk2         teo-1   2       5689    866340  28191   0.033   3122    2=
5069
> mmcblk2         teo-2   0       5769    859462  2116    0.002   1835    2=
81
> mmcblk2         teo-2   1       5577    611956  25490   0.042   8647    1=
6843
> mmcblk2         teo-2   2       5665    721308  25826   0.036   2876    2=
2950
> mmcblk2         teo-3   0       5677    805946  30345   0.038   3877    2=
6468
> mmcblk2         teo-3   1       5752    855840  14392   0.017   2588    1=
1804
> mmcblk2         teo-3   2       5740    825580  27403   0.033   3750    2=
3653
> mmcblk2         teo-4   0       5664    777848  3435    0.004   3229    2=
06
> mmcblk2         teo-4   1       5660    728926  25796   0.035   2871    2=
2925
> mmcblk2         teo-4   2       5689    774342  7844    0.010   2838    5=
006
> mmcblk2         teo-5   0       5672    781618  2733    0.003   2551    1=
82
> mmcblk2         teo-5   1       5693    866530  28658   0.033   3332    2=
5326
> mmcblk2         teo-5   2       5687    837294  12172   0.015   2338    9=
834
> mmcblk2         teo-6   0       5859    892798  5226    0.006   3566    1=
660
> mmcblk2         teo-6   1       5696    864197  24962   0.029   2796    2=
2166
> mmcblk2         teo-6   2       5671    788200  26612   0.034   3157    2=
3455
> mmcblk2         teo-7   0       5617    525864  30143   0.057   3739    2=
6404
> mmcblk2         teo-7   1       5732    802794  25553   0.032   3240    2=
2313
> mmcblk2         teo-7   2       5838    858620  12661   0.015   188     1=
2473
> mmcblk2         teo-8   0       5696    780894  24440   0.031   2928    2=
1512
> mmcblk2         teo-8   1       5868    862794  12978   0.015   187     1=
2791
> mmcblk2         teo-8   2       5607    660124  31632   0.048   6728    2=
4904
> mmcblk2         teo-9   0       5652    669318  28330   0.042   2692    2=
5638
> mmcblk2         teo-9   1       5657    710892  29291   0.041   3233    2=
6058
> mmcblk2         teo-9   2       5594    740988  37086   0.050   10275   2=
6811
> nvme0n1         menu    0       4775    384186  70675   0.184   54346   1=
6329
> nvme0n1         menu    1       5211    409374  69545   0.170   53484   1=
6061
> nvme0n1         menu    2       7213    535088  81312   0.152   64253   1=
7059
> nvme0n1         teo     0       10655   754882  29476   0.039   2960    2=
6516
> nvme0n1         teo     1       10627   755322  29324   0.039   3011    2=
6313
> nvme0n1         teo     2       10559   749498  29850   0.040   3265    2=
6585
> nvme0n1         teo-m   0       10353   738802  29937   0.041   2996    2=
6941
> nvme0n1         teo-m   1       10629   748148  27076   0.036   2349    2=
4727
> nvme0n1         teo-m   2       10477   743256  28193   0.038   2645    2=
5548
> nvme0n1         teo-1   0       10947   772905  24896   0.032   3150    2=
1746
> nvme0n1         teo-1   1       10412   732894  21868   0.030   2423    1=
9445
> nvme0n1         teo-1   2       10530   748377  26338   0.035   3479    2=
2859
> nvme0n1         teo-2   0       10570   751961  5195    0.007   2853    2=
342
> nvme0n1         teo-2   1       10482   732428  18667   0.025   2102    1=
6565
> nvme0n1         teo-2   2       10829   768292  26400   0.034   3189    2=
3211
> nvme0n1         teo-3   0       10493   746638  26371   0.035   3320    2=
3051
> nvme0n1         teo-3   1       10445   742924  27871   0.038   3027    2=
4844
> nvme0n1         teo-3   2       10920   775112  25646   0.033   3520    2=
2126
> nvme0n1         teo-4   0       10500   734792  18125   0.025   2283    1=
5842
> nvme0n1         teo-4   1       11091   783828  25904   0.033   3031    2=
2873
> nvme0n1         teo-4   2       10413   736248  23786   0.032   2660    2=
1126
> nvme0n1         teo-5   0       10479   744340  26933   0.036   3096    2=
3837
> nvme0n1         teo-5   1       10740   764188  27065   0.035   3062    2=
4003
> nvme0n1         teo-5   2       10500   747060  25962   0.035   3233    2=
2729
> nvme0n1         teo-6   0       10715   757772  2186    0.003   1872    3=
14
> nvme0n1         teo-6   1       10485   734878  17620   0.024   2174    1=
5446
> nvme0n1         teo-6   2       10478   744106  26909   0.036   3007    2=
3902
> nvme0n1         teo-7   0       10549   750022  30416   0.041   3320    2=
7096
> nvme0n1         teo-7   1       10611   752182  29877   0.040   3332    2=
6545
> nvme0n1         teo-7   2       11170   791572  30790   0.039   3453    2=
7337
> nvme0n1         teo-8   0       10622   752523  29002   0.039   2745    2=
6257
> nvme0n1         teo-8   1       10424   739904  28641   0.039   2756    2=
5885
> nvme0n1         teo-8   2       10533   731440  22101   0.030   1280    2=
0821
> nvme0n1         teo-9   0       10367   727768  24895   0.034   1820    2=
3075
> nvme0n1         teo-9   1       10815   766230  29378   0.038   3136    2=
6242
> nvme0n1         teo-9   2       10426   739224  28173   0.038   2563    2=
5610
> sda     menu    0       872     526240  175645  0.334   159373  16272
> sda     menu    1       900     536434  188122  0.351   170749  17373
> sda     menu    2       901     534826  189778  0.355   171745  18033
> sda     teo     0       1687    999108  16015   0.016   1249    14766
> sda     teo     1       1668    1007551         31316   0.031   5809    2=
5507
> sda     teo     2       1682    985830  18784   0.019   1003    17781
> sda     teo-m   0       1676    969984  25825   0.027   3191    22634
> sda     teo-m   1       1682    995266  30340   0.030   4040    26300
> sda     teo-m   2       1681    940562  20830   0.022   1508    19322
> sda     teo-1   0       1680    996214  15553   0.016   2192    13361
> sda     teo-1   1       1674    1050168         28033   0.027   4011    2=
4022
> sda     teo-1   2       1665    808202  35292   0.044   8873    26419
> sda     teo-2   0       1689    1013360         546     0.001   243     3=
03
> sda     teo-2   1       1672    1033806         29432   0.028   4363    2=
5069
> sda     teo-2   2       1667    1046100         31110   0.030   6395    2=
4715
> sda     teo-3   0       1625    922694  40891   0.044   22925   17966
> sda     teo-3   1       1670    894480  27946   0.031   3045    24901
> sda     teo-3   2       1658    1009366         28514   0.028   8887    1=
9627
> sda     teo-4   0       1674    977280  3605    0.004   3279    326
> sda     teo-4   1       1677    960990  2861    0.003   1058    1803
> sda     teo-4   2       1660    1016592         33894   0.033   7687    2=
6207
> sda     teo-5   0       1678    1033470         16996   0.016   2163    1=
4833
> sda     teo-5   1       1667    873077  25011   0.029   4393    20618
> sda     teo-5   2       1672    1042020         24589   0.024   3858    2=
0731
> sda     teo-6   0       1680    962686  7255    0.008   1797    5458
> sda     teo-6   1       1682    1055472         28602   0.027   5081    2=
3521
> sda     teo-6   2       1675    989244  19110   0.019   5620    13490
> sda     teo-7   0       1618    1001000         51178   0.051   26011   2=
5167
> sda     teo-7   1       1666    1047310         34032   0.032   6520    2=
7512
> sda     teo-7   2       1676    982046  28788   0.029   2836    25952
> sda     teo-8   0       1618    975930  52929   0.054   26386   26543
> sda     teo-8   1       1678    1023796         16182   0.016   2191    1=
3991
> sda     teo-8   2       1633    981693  43520   0.044   18782   24738
> sda     teo-9   0       1661    1029494         32423   0.031   5855    2=
6568
> sda     teo-9   1       1678    969400  17843   0.018   2763    15080
> sda     teo-9   2       1679    1055060         32288   0.031   5607    2=
6681
> mtdblock3       menu    0       180     278442  80547   0.289   65714   1=
4833
> mtdblock3       menu    1       167     379840  109168  0.287   93460   1=
5708
> mtdblock3       menu    2       155     373948  126262  0.338   107799  1=
8463
> mtdblock3       teo     0       256     663190  29333   0.044   4836    2=
4497
> mtdblock3       teo     1       257     808114  29394   0.036   2742    2=
6652
> mtdblock3       teo     2       257     456150  25812   0.057   2468    2=
3344
> mtdblock3       teo-m   0       257     624492  24678   0.040   2326    2=
2352
> mtdblock3       teo-m   1       256     734548  31165   0.042   4307    2=
6858
> mtdblock3       teo-m   2       257     812004  30479   0.038   3510    2=
6969
> mtdblock3       teo-1   0       253     759708  34146   0.045   10081   2=
4065
> mtdblock3       teo-1   1       254     730160  23105   0.032   7156    1=
5949
> mtdblock3       teo-1   2       253     721558  32848   0.046   10028   2=
2820
> mtdblock3       teo-2   0       257     666426  4948    0.007   782     4=
166
> mtdblock3       teo-2   1       256     682046  25126   0.037   4886    2=
0240
> mtdblock3       teo-2   2       253     639950  36029   0.056   11074   2=
4955
> mtdblock3       teo-3   0       252     709122  37198   0.052   12603   2=
4595
> mtdblock3       teo-3   1       257     709680  30000   0.042   3670    2=
6330
> mtdblock3       teo-3   2       254     540408  32696   0.061   9035    2=
3661
> mtdblock3       teo-4   0       256     442356  28281   0.064   3785    2=
4496
> mtdblock3       teo-4   1       254     588362  16934   0.029   5663    1=
1271
> mtdblock3       teo-4   2       257     628776  28300   0.045   3667    2=
4633
> mtdblock3       teo-5   0       250     762594  43008   0.056   16752   2=
6256
> mtdblock3       teo-5   1       256     586098  29744   0.051   4035    2=
5709
> mtdblock3       teo-5   2       262     903736  375     0.000   139     2=
36
> mtdblock3       teo-6   0       250     795274  42742   0.054   17160   2=
5582
> mtdblock3       teo-6   1       256     800172  28195   0.035   4016    2=
4179
> mtdblock3       teo-6   2       257     523365  26260   0.050   2788    2=
3472
> mtdblock3       teo-7   0       261     944626  31616   0.033   5090    2=
6526
> mtdblock3       teo-7   1       258     647048  28997   0.045   2728    2=
6269
> mtdblock3       teo-7   2       260     901858  18521   0.021   3698    1=
4823
> mtdblock3       teo-8   0       256     914076  27272   0.030   6844    2=
0428
> mtdblock3       teo-8   1       256     809113  31696   0.039   4672    2=
7024
> mtdblock3       teo-8   2       252     798396  40223   0.050   13270   2=
6953
> mtdblock3       teo-9   0       259     726886  30515   0.042   4002    2=
6513
> mtdblock3       teo-9   1       262     892854  9411    0.011   1686    7=
725
> mtdblock3       teo-9   2       259     909528  16583   0.018   3054    1=
3529
> nullb0  menu    0       107364  86086   20668   0.240   2604    18064
> nullb0  menu    1       107701  85072   20251   0.238   2808    17443
> nullb0  menu    2       107976  85178   20591   0.242   3063    17528
> nullb0  teo     0       105758  84464   28872   0.342   3429    25443
> nullb0  teo     1       106892  87122   30255   0.347   3722    26533
> nullb0  teo     2       107080  83374   27911   0.335   2918    24993
> nullb0  teo-m   0       107702  88337   29824   0.338   2956    26868
> nullb0  teo-m   1       108218  88130   29710   0.337   3038    26672
> nullb0  teo-m   2       106993  86866   30033   0.346   3664    26369
> nullb0  teo-1   0       106416  82936   23635   0.285   3186    20449
> nullb0  teo-1   1       107570  87425   27682   0.317   3220    24462
> nullb0  teo-1   2       107832  75656   19434   0.257   2775    16659
> nullb0  teo-2   0       106320  88182   28603   0.324   3213    25390
> nullb0  teo-2   1       107316  79968   21643   0.271   3081    18562
> nullb0  teo-2   2       108007  84018   25244   0.300   3034    22210
> nullb0  teo-3   0       106989  85160   24558   0.288   3601    20957
> nullb0  teo-3   1       107325  83582   24994   0.299   2963    22031
> nullb0  teo-3   2       107063  77066   18978   0.246   2913    16065
> nullb0  teo-4   0       107990  86156   25012   0.290   3404    21608
> nullb0  teo-4   1       107352  75750   15096   0.199   2671    12425
> nullb0  teo-4   2       107685  87644   26047   0.297   3825    22222
> nullb0  teo-5   0       106687  87788   13428   0.153   2937    10491
> nullb0  teo-5   1       107820  86442   25703   0.297   3686    22017
> nullb0  teo-5   2       108319  81498   22895   0.281   2713    20182
> nullb0  teo-6   0       107784  84364   24239   0.287   3459    20780
> nullb0  teo-6   1       108762  83854   24017   0.286   3289    20728
> nullb0  teo-6   2       106024  88238   27778   0.315   3253    24525
> nullb0  teo-7   0       106041  86354   30076   0.348   3420    26656
> nullb0  teo-7   1       108039  79564   26805   0.337   2924    23881
> nullb0  teo-7   2       107389  88264   30713   0.348   3156    27557
> nullb0  teo-8   0       106465  87924   29679   0.338   2958    26721
> nullb0  teo-8   1       107215  81348   27038   0.332   2916    24122
> nullb0  teo-8   2       108238  87070   29284   0.336   2971    26313
> nullb0  teo-9   0       107220  84508   28894   0.342   3411    25483
> nullb0  teo-9   1       107400  86920   29945   0.345   3579    26366
> nullb0  teo-9   2       107845  87686   30439   0.347   3784    26655
> mapper/dm-slow  menu    0       19      85216   20060   0.235   2478    1=
7582
> mapper/dm-slow  teo     0       19      86454   28959   0.335   2860    2=
6099
> mapper/dm-slow  teo-m   0       19      84740   28056   0.331   2582    2=
5474
> mapper/dm-slow  teo-1   0       19      88698   28945   0.326   3210    2=
5735
> mapper/dm-slow  teo-2   0       19      83138   24326   0.293   2589    2=
1737
> mapper/dm-slow  teo-3   0       19      86416   27274   0.316   2998    2=
4276
> mapper/dm-slow  teo-4   0       19      89286   29369   0.329   3151    2=
6218
> mapper/dm-slow  teo-5   0       19      88516   29213   0.330   3163    2=
6050
> mapper/dm-slow  teo-6   0       19      87896   24675   0.281   3113    2=
1562
> mapper/dm-slow  teo-7   0       19      83986   27976   0.333   2788    2=
5188
> mapper/dm-slow  teo-8   0       19      88072   29667   0.337   2962    2=
6705
> mapper/dm-slow  teo-9   0       19      87260   29428   0.337   2923    2=
6505
>

