Return-Path: <linux-pm+bounces-20700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58996A17024
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B952F3A52E7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9F1E9B19;
	Mon, 20 Jan 2025 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWPFKJD/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C91E98E6;
	Mon, 20 Jan 2025 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390394; cv=none; b=gp1yXX1jhbPnFVrX4IbpjhTShGEUS+mLXp3txuQNWj3zbkpQC0ozik1VUR0e8RaQ3uuqvHuFQvVeAr+6PuWUC8slDkCB0kxL9N4dDT7x2NwArbRnus6blszNxtFz0qUJw5oi6PsN0MjVVaJsxmKOX3H/yzUmXq08zrKTgKuyHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390394; c=relaxed/simple;
	bh=ETbJq8dU4q87jQt1++VBArfsan8YoscgZTS2ZEDmBf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQjSMcRyC7jJ4q4kuQPH6W3pC/Gev7NtWD7LucYDkB+7jtDcF4C+CeTg+ZB1c+LfN2AdrJ8biWED7Z1AZY+WCc+hFzUFDo7FZTl6LKsc5O1X81vuYzR89yb1kgqcCyK8/B6gwr2GaQpSn++m4eKvFMb2sf7CsOKh9LnIr7HutJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWPFKJD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0FFC4CEDD;
	Mon, 20 Jan 2025 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737390393;
	bh=ETbJq8dU4q87jQt1++VBArfsan8YoscgZTS2ZEDmBf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GWPFKJD/WFHwtxb5GL0IbqWmKqdsocC0jAZz+AK0UTL1Jej0wKxapkgLKWHWV4W9F
	 HYa6tuEZmwlOExPf0IZLcSaYM4GVs5vfK0s2n2IHoxDHHf0b7sI6KfzlFaLrTil4jM
	 EbMLgDwevBK89NlRBwDhBPq5LO+V7xf0j53+MbRUeXRsxiMA2jL4PKqxfQUXiEgajw
	 zkPROsW7q+toXOgOoAEJaV0i+Rf1DiEeEzopN5KIOq6HR1PARZ80mKeg9yw9GaB9MY
	 V14vHVF4d3pYJUqILYoBewIgkXflGDkLCmANdcBOdULRNOy7xtxwLnn9z45M9mNOMw
	 4k+WAxIvrzI/g==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-723442fd88aso1377579a34.3;
        Mon, 20 Jan 2025 08:26:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW40nBzHE5TD76FKqXEu2N6u6q4MIsPtnPDpnpzTJqu2qo0NXXFlE2XRwz8Wvwd9hEwhiScQz2aQVz0+Q0=@vger.kernel.org, AJvYcCXnqB74fH0eAx4Z3ow6PApjEGSG4P2BHEm7QPokvKkeO0CBpznOIRBTlmv9ggtP6nMsQTnMQI+n1qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTFuRLZXTR/9OImvrz/jFMV7gj1pygzcwu9VWEhzGODwca6qN
	XkXTs3PtWJ01CDKTaCropoe+7pfaFKSnH3MygFQWNKMA4B1j0bMfydX5VNcDORL06UycMsWMPZE
	b1YHxsynS/dzMCOuHQpZYnsTF4bc=
X-Google-Smtp-Source: AGHT+IHNGfeESwwph0ktCv0j06GjXDqKrzDtbQzM4AYs1qoRfxXEUFwcmg76bhI+YrJ6/zov548nr9DeKmrOH9GT4OU=
X-Received: by 2002:a05:6830:610e:b0:718:615:462d with SMTP id
 46e09a7af769-7249da8fb2cmr8783593a34.13.1737390392741; Mon, 20 Jan 2025
 08:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6116275.lOV4Wx5bFT@rjwysocki.net> <d095149c-fb76-40e8-a459-05e4d2e50cf5@arm.com>
 <2007eace0fa9f591917cdd228c2cb66f045480d0.camel@linux.ibm.com>
In-Reply-To: <2007eace0fa9f591917cdd228c2cb66f045480d0.camel@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 17:26:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g54OGuUJYazM4yhn=Y0WM0TegYJnxZwoTcVgGD7mpXug@mail.gmail.com>
X-Gm-Features: AbW1kvaDT7V1QSwrV_Hf7js2LBofrRasHm1_t2IjPms30dzzF1asnKEy4Ab6LsU
Message-ID: <CAJZ5v0g54OGuUJYazM4yhn=Y0WM0TegYJnxZwoTcVgGD7mpXug@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] cpuidle: teo: Cleanups and very frequent wakeups
 handling update
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 9:17=E2=80=AFAM Aboorva Devarajan
<aboorvad@linux.ibm.com> wrote:
>
> On Wed, 2025-01-15 at 14:52 +0000, Christian Loehle wrote:
> > On 1/13/25 18:32, Rafael J. Wysocki wrote:
> > > Hi Everyone,
> > >
> > > This supersedes
> > >
> > > https://lore.kernel.org/linux-pm/4953183.GXAFRqVoOG@rjwysocki.net/
> > >
> > > but because the majority of patches in it are new, I've decided to co=
unt
> > > version numbers back from 1.
> > >
> > > This addresses a relatively recently added inconsistency in behavior =
of the teo
> > > governor regarding the handling of very frequent wakeups handling (pa=
tch [7/9])
> > > and makes some other changes that may be regarded as cleanups.
> > >
> > > Please review.
> >
> > Hi Rafael,
> > that looks promising. I'll review the individual patches in detail now,=
 but
> > I let a few tests run overnight and can report that there's no signific=
ant
> > behaviour change with the series on an arm64 (no polling state, rk3399)=
, which
> > is my expected result.
> >
> > I'll get something running on a system with a polling state as well.
> > (I don't have a POWER system, so that will just be x86, adding Aboorva.=
)
>
>
> Christian,
>
> Thanks for adding me to the thread.
>
> Rafael,
>
> I did some tests with the patch on a Pseries Power10 system:
>
> Here are the system details:
>
> -------------------------------------------------------------------------=
-------
> Architecture:                         ppc64le
> Byte Order:                           Little Endian
> CPU(s):                               48
> On-line CPU(s) list:                  0-47
> Model name:                           POWER10 (architected), altivec supp=
orted
> Model:                                2.0 (pvr 0080 0200)
> Thread(s) per core:                   8
> Core(s) per socket:                   6
> Socket(s):                            1
> Physical sockets:                     8
> Physical chips:                       1
> Physical cores/chip:                  10
>
> -------------------------------------------------------------------------=
-------
> # cpupower idle-info
> CPUidle driver: pseries_idle
> CPUidle governor: menu
> analyzing CPU 5:
>
> Number of idle states: 2
> Available idle states: snooze Shared Cede
> snooze:
> Flags/Description: snooze
> Latency: 0
> Usage: 1411724
> Duration: 27481504
> Shared Cede:
> Flags/Description: Shared Cede
> Latency: 10
> Usage: 326573
> Duration: 31098864616
> -------------------------------------------------------------------------=
-------
>
> How to infer the results:
>
> Above Diff (%) and Below Diff (%) represent the number of cpuidle misses,
> indicating how frequently the selected cpuidle state was either too deep =
or
> too shallow. So, these values should not be too high.
> -------------------------------------------------------------------------=
-------
>
> The below test is done using a predictable timer and non-timer benchmark =
[1]:
>
> -------------------------------------------------------------------------=
-------
> Menu Governor:
> -------------------------------------------------------------------------=
-------
>
> With pipe wakeup (non-timer):
>
> -------------------------------------------------------------------------=
-------------------------------
>    Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  To=
tal Below Diff  Below Diff (%)
> -------------------------------------------------------------------------=
-------------------------------
> 0           5.980           1656304                 2        0.000121    =
             0        0.000000
> 1          10.959            901972              1954        0.216636    =
             0        0.000000
> -------------------------------------------------------------------------=
-------------------------------
> 2          15.726            243971            237112       97.188600    =
             0        0.000000
> 3          20.813            232069            227258       97.926910    =
             0        0.000000
> 4          30.896            209884            206492       98.383869    =
             0        0.000000
> 5          40.991            216704            213642       98.587013    =
             0        0.000000
> 6          51.002            195632            192963       98.635704    =
             0        0.000000
> 7          61.014            163726            161506       98.644076    =
             0        0.000000
> 8          71.006            140739            138809       98.628667    =
             0        0.000000
> 9          81.008            123386            120725       97.843353    =
             0        0.000000
> 10        101.020             98974             81235       82.077111    =
             0        0.000000
> -------------------------------------------------------------------------=
-------------------------------
> 11        111.044             90018              1513        1.680775    =
            12        0.013331
> 12        121.015             82704               189        0.228526    =
            77        0.093103
> 13        131.028             76534               272        0.355398    =
           321        0.419421
> 14        141.008             71610               698        0.974724    =
           693        0.967742
> 15        151.021             66869               666        0.995977    =
           656        0.981023
> 16        161.027             62709               611        0.974342    =
           605        0.964774
> 17        171.033             59063               593        1.004013    =
           593        1.004013
> 18        181.019             55819               571        1.022949    =
           541        0.969204
> 19        191.016             52998               641        1.209480    =
           628        1.184950
> 20        201.017             50353               551        1.094274    =
           501        0.994975
> 21        251.054             40535               289        0.712964    =
           398        0.981868
> 22        301.037             33966               252        0.741918    =
           330        0.971560
> 23        351.038             29279               216        0.737730    =
           294        1.004133
> 24        401.047             25765               190        0.737435    =
           262        1.016883
> 25        451.060             23021               185        0.803614    =
           187        0.812302
> 26        501.049             20831               150        0.720081    =
           216        1.036916
> 27       1001.076             10951                77        0.703132    =
           126        1.150580
>
> With timer wakeup:
>
> -------------------------------------------------------------------------=
-------------------------------
>    Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  To=
tal Below Diff  Below Diff (%)
> -------------------------------------------------------------------------=
-------------------------------
> 0           7.590           1310772                 0        0.000000    =
             0        0.000000
> 1          12.631            789377               780        0.098812    =
             0        0.000000
> 2          21.791            458001             52321       11.423774    =
             0        0.000000
> 3          22.648            440752                36        0.008168    =
             0        0.000000
> 4          32.644            305983                 0        0.000000    =
             0        0.000000
> 5          42.646            234305                 0        0.000000    =
             0        0.000000
> 6          52.647            189858                 2        0.001053    =
             0        0.000000
> 7          62.649            159561                10        0.006267    =
             0        0.000000
> 8          72.644            137643                 5        0.003633    =
             1        0.000727
> 9          82.666            120963                 5        0.004133    =
             0        0.000000
> 10        102.654             97442                 3        0.003079    =
           610        0.626013
> 11        145.805             69937               441        0.630568    =
          1345        1.923159
> 12        156.057             64511                75        0.116259    =
           439        0.680504
> 13        166.047             60765               215        0.353822    =
           534        0.878795
> 14        175.894             57564               178        0.309221    =
           687        1.193454
> 15        185.933             54471               255        0.468139    =
           638        1.171265
> 16        195.975             51403                98        0.190650    =
           212        0.412427
> 17        206.062             49281               174        0.353077    =
           577        1.170837
> 18        216.188             46980                33        0.070243    =
           571        1.215411
> 19        226.346             44879                30        0.066846    =
           543        1.209920
> 20        236.353             43081                27        0.062673    =
           516        1.197744
> 21        286.158             35782                 5        0.013974    =
           154        0.430384
> 22        336.730             30531                11        0.036029    =
           266        0.871246
> 23        386.730             26722                18        0.067360    =
           232        0.868198
> 24        436.770             23797                 9        0.037820    =
           196        0.823633
> 25        487.229             21359                13        0.060864    =
           229        1.072148
> 26        537.375             19557                13        0.066472    =
           259        1.324334
> 27       1037.871             10638                12        0.112803    =
           127        1.193833
>
> -------------------------------------------------------------------------=
-------
> Teo governor:
> -------------------------------------------------------------------------=
-------
>
> With pipe wakeup (non-timer):
>
> -------------------------------------------------------------------------=
-------------------------------
>    Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  To=
tal Below Diff  Below Diff (%)
> -------------------------------------------------------------------------=
-------------------------------
> 0           5.972           1657561                 6        0.000362    =
             0        0.000000
> 1          10.964            907279                 0        0.000000    =
             0        0.000000
> 2          15.977            623681                 0        0.000000    =
             0        0.000000
> 3          20.980            475385                 1        0.000210    =
             0        0.000000
> 4          30.981            322151                 0        0.000000    =
             0        0.000000
> 5          40.975            243749                 0        0.000000    =
             0        0.000000
> 6          50.977            195989                 0        0.000000    =
             0        0.000000
> 7          60.981            163876                 0        0.000000    =
             0        0.000000
> 8          70.978            140818                 0        0.000000    =
             0        0.000000
> 9          80.976            123460                 0        0.000000    =
             1        0.000810
> 10        100.970             99038                 0        0.000000    =
            16        0.016155
> -------------------------------------------------------------------------=
-------------------------------
> 11        111.027            106919              5388        5.039329    =
         16873       15.781105
> -------------------------------------------------------------------------=
-------------------------------
> 12        121.017             83074               381        0.458627    =
           443        0.533260
> 13        131.024             76588               323        0.421737    =
           373        0.487021
> 14        141.027             71592               695        0.970779    =
           695        0.970779
> 15        151.023             66874               669        1.000389    =
           662        0.989921
> 16        161.026             62719               607        0.967809    =
           595        0.948676
> 17        171.027             59064               581        0.983679    =
           574        0.971827
> 18        181.020             55817               561        1.005070    =
           532        0.953115
> 19        191.020             52883               523        0.988976    =
           446        0.843371
> 20        201.025             50509               670        1.326496    =
           645        1.277000
> 21        251.037             40544               280        0.690608    =
           409        1.008781
> 22        301.033             33988               263        0.773803    =
           349        1.026833
> 23        351.036             29285               221        0.754653    =
           299        1.021001
> 24        401.042             25777               203        0.787524    =
           272        1.055204
> 25        451.040             23029               174        0.755569    =
           238        1.033480
> 26        501.048             20838               157        0.753431    =
           224        1.074959
> 27       1001.097             10949                79        0.721527    =
           134        1.223856
>
> With timer wakeup:
>
> -------------------------------------------------------------------------=
-------------------------------
>    Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  To=
tal Below Diff  Below Diff (%)
> -------------------------------------------------------------------------=
-------------------------------
> 0           7.541           1319205                 0        0.000000    =
             0        0.000000
> 1          12.546            794464                 0        0.000000    =
             0        0.000000
> 2          17.540            568954                 0        0.000000    =
             0        0.000000
> 3          22.572            442307                 0        0.000000    =
             0        0.000000
> 4          32.583            306443                 0        0.000000    =
             1        0.000326
> 5          42.597            233238                 0        0.000000    =
             0        0.000000
> 6          52.587            190067                 0        0.000000    =
             0        0.000000
> 7          62.590            159714                 0        0.000000    =
             1        0.000626
> 8          72.574            137755                 0        0.000000    =
             2        0.001452
> 9          82.581            121081                 0        0.000000    =
             0        0.000000
> 10        102.589             97491                 0        0.000000    =
          1912        1.961207
> 11        146.385             68906                47        0.068209    =
           599        0.869300
> 12        156.548             64565                86        0.133199    =
           670        1.037714
> 13        166.588             60562               100        0.165120    =
           518        0.855322
> 14        176.676             57264               263        0.459276    =
           642        1.121123
> 15        186.563             54262               293        0.539973    =
           601        1.107589
> 16        195.986             51668               192        0.371603    =
           526        1.018038
> 17        206.860             49028                97        0.197846    =
           564        1.150363
> 18        216.899             46669                27        0.057854    =
           460        0.985665
> 19        227.016             44528                22        0.049407    =
           367        0.824201
> 20        237.055             42883                28        0.065294    =
           507        1.182287
> 21        286.998             35665                 9        0.025235    =
           283        0.793495
> 22        337.410             30439                 7        0.022997    =
           264        0.867308
> 23        387.522             26652                18        0.067537    =
           251        0.941768
> 24        437.570             23742                 8        0.033696    =
           221        0.930840
> 25        487.804             21293                10        0.046964    =
            94        0.441460
> 26        537.884             19505                 7        0.035888    =
           243        1.245834
> 27       1038.863             10633                 4        0.037619    =
           135        1.269632
>
> -------------------------------------------------------------------------=
-------
> Teo Governor with patch
> -------------------------------------------------------------------------=
-------
>
> With pipe wakeup (non-timer):
>
> -------------------------------------------------------------------------=
-------------------------------
>    Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  To=
tal Below Diff  Below Diff (%)
> -------------------------------------------------------------------------=
-------------------------------
> 0           5.959           1661754                 5        0.000301    =
             0        0.000000
> 1          10.963            907497                 2        0.000220    =
             0        0.000000
> 2          15.968            623957                 2        0.000321    =
             0        0.000000
> 3          20.970            475574                 2        0.000421    =
             0        0.000000
> 4          30.974            321718                 2        0.000622    =
             0        0.000000
> 5          40.974            243714                 2        0.000821    =
             0        0.000000
> 6          50.983            195931                 2        0.001021    =
             0        0.000000
> 7          60.974            163876                 2        0.001220    =
             1        0.000610
> 8          70.973            140810                 2        0.001420    =
             1        0.000710
> 9          80.988            123420                 1        0.000810    =
             4        0.003241
> 10        100.994             99014                 2        0.002020    =
            20        0.020199
> -------------------------------------------------------------------------=
-------------------------------
> 11        111.023            135597             11864        8.749456    =
         45561       33.600301 =3D> This is observed even
> -------------------------------------------------------------------------=
-------------------------------   without the patch,
> 12        121.035             82948               348        0.419540    =
           352        0.424362    when the sleep interval
> 13        131.019             76342                82        0.107411    =
            48        0.062875    is almost equal to the
> 14        141.028             70948                70        0.098664    =
            57        0.080341    residency time of state1.
> 15        151.023             66278                81        0.122212    =
            69        0.104107
> 16        161.021             62146                65        0.104592    =
            51        0.082065
> 17        171.023             58509                64        0.109385    =
            47        0.080330
> 18        181.026             55301                64        0.115730    =
            48        0.086798
> 19        191.033             52407                67        0.127846    =
            45        0.085866
> 20        201.024             49803                52        0.104411    =
            48        0.096380
> 21        251.042             39911                39        0.097717    =
            45        0.112751
> 22        301.040             33302                29        0.087082    =
            40        0.120113
> 23        351.045             28572                37        0.129497    =
            34        0.118998
> 24        401.057             25005                20        0.079984    =
            27        0.107978
> 25        451.055             22246                21        0.094399    =
            26        0.116875
> 26        501.053             20031                14        0.069892    =
            25        0.124807
> 27       1001.099             10055                 7        0.069617    =
            15        0.149180
>
>
> With timer wakeup:
>
> -------------------------------------------------------------------------=
-------------------------------
>    Sleep Interval  Total Usage Diff  Total Above Diff  Above Diff (%)  To=
tal Below Diff  Below Diff (%)
> -------------------------------------------------------------------------=
-------------------------------
> 0           7.566           1314872                 0        0.000000    =
             0        0.000000
> 1          12.553            794091                 0        0.000000    =
             0        0.000000
> 2          17.573            567627                 0        0.000000    =
             0        0.000000
> 3          22.631            441084                 0        0.000000    =
             0        0.000000
> 4          32.633            306095                 0        0.000000    =
             0        0.000000
> 5          42.631            234377                 0        0.000000    =
             0        0.000000
> 6          52.634            189899                 0        0.000000    =
             0        0.000000
> 7          62.642            159572                 0        0.000000    =
             0        0.000000
> 8          72.645            137619                 0        0.000000    =
             1        0.000727
> 9          82.616            121037                 0        0.000000    =
             1        0.000826
> 10        102.636             97423                 0        0.000000    =
          1047        1.074695
> 11        145.823             69245                43        0.062098    =
           680        0.982020
> 12        155.912             64546                90        0.139435    =
           478        0.740557
> 13        166.103             60709               219        0.360737    =
           501        0.825248
> 14        176.036             57483               196        0.340970    =
           639        1.111633
> 15        186.043             54448               250        0.459154    =
           623        1.144211
> 16        195.552             51428               124        0.241114    =
           230        0.447227
> 17        205.990             49270               141        0.286178    =
           527        1.069616
> 18        216.300             46931                39        0.083101    =
           545        1.161279
> 19        226.288             44884                23        0.051243    =
           520        1.158542
> 20        236.372             43056                20        0.046451    =
           493        1.145020
> 21        285.985             35724                 1        0.002799    =
           119        0.333109
> 22        336.636             30526                11        0.036035    =
           262        0.858285
> 23        386.522             26772                17        0.063499    =
           218        0.814284
> 24        436.749             23857                26        0.108983    =
           208        0.871862
> 25        487.204             21358                 9        0.042139    =
           240        1.123701
> 26        537.312             19530                 7        0.035842    =
           235        1.203277
> 27       1038.147             10610                 2        0.018850    =
           119        1.121583
> -------------------------------------------------------------------------=
-------
>
>
> I also did some tests with postgres (pgbench) - with the patch:
>
> +---------------------------+--------------------+------------------+
> | Metric                    | Shared Cede        | Snooze           |
> +---------------------------+--------------------+------------------+
> | Total Usage Difference    | 119,453            | 20,472,846       |
> | Total Time Difference     | 502.79 seconds     | 324.90 seconds   |
> | Total Above Difference    | 74,500 (0.36%)     | 0                |
> | Total Below Difference    | 0                  | 336,703 (1.64%)  |
> +---------------------------+--------------------+------------------+
>
> % Above Diff =3D 0.36% of total usage
> % Below Diff =3D 1.64% of total usage
>
>
> Using both the deterministic micro-benchmark and pgbench, I observed that=
 the
> teo governor with the patch as anticipated does not cause any noticable i=
ncrease in the cpuidle
> state prediction miss on PowerPC (pseries) (% above and below diff).
>
> So, for the entire series:
>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Thank you, much appreciated!

> [1]: https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidle/cp=
uidle_wakeup

