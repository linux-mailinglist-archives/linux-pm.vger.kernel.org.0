Return-Path: <linux-pm+bounces-41094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DCFD3A828
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 387A330360FF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44835B12C;
	Mon, 19 Jan 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm+jJSQ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38035B121
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824565; cv=none; b=AKkJgC37HQ7bJPutzYKHBVYY/NdmMT6BMNjyfgizhsWibizz90hGbmYgKQVK020/xPp9khCIFYNKNu0sNFv84dZX/9CM1p5AY5TkWWm75QOMvmzN6TCV2eObH1TwCEMouWSk2Hc4eg7DSaz+sW7ucAoZmQyUTigjDYvClxvZdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824565; c=relaxed/simple;
	bh=Wh3e1gq/W9c1cAJRIR37pk//QRztl+Hb7LSo5A/8f10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p04VqKvw6voYW2Jt1Dr05tiAAEwu56jlybcClLcebKwmDZZoMPcvA5+rOjXOS3VHHwJab87HAmQi53UrMxh3gdDyBjhxxfrQtoH/BXkCLxMWw7mzceihlU+jcHKxKNC7iXtUSgxKV3Q3pDXxxpbt6BsfVL8X5Vsv8NQbTrFYZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm+jJSQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D89FC4AF0B
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768824563;
	bh=Wh3e1gq/W9c1cAJRIR37pk//QRztl+Hb7LSo5A/8f10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lm+jJSQ84HIsRksMIDIU8QAKuub48QMOmJMRgJdULJNuWAD4T+dfWrZQ9s8wgK/aA
	 E2Wxz4ycPZS4JGF322hNJActp+xeK1UKe8j9oeaJwT9rNRJqfhGAf2JiUAbWFhIZco
	 9Kr7qBFoIjC6QkJFUu2gbPnY528Hxh+jO/ZuWgc9oizLSF0CaURF9vcUfFeOBK3vc4
	 U/+qaDCf90q3LE/KzjOeAWnvO/jgm8cHNzFmfEMJSL00dt27mJw0H/7BblE4rJshQH
	 AleUUCs7iD8REx9OVdYWXo5OgBQJHbioBVmoGEvadIG2rIzNX5PyOpRbIE0EQWl3tM
	 qgWQyqQkyltyw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-661084916c0so2091300eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 04:09:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCU4/dHclSjRagBw49nLX6vjBZXUK7W6D/eavgGsPFHAm9naXqu5FCOLRIOna0XiQuphtgHeXvtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyecDQbdXTJhv2ndaBxnwtcx5fnRCDupSKvqYx2+iApKlZEMnqn
	Hk86gGyuPxX2M+eEJlat+bLTx63EfRZa9ubYQTBOSDkdSleLiRFCgfBKiUo/BsM01FNeDdaajn2
	z61opIUefF68t+6bjt0ybsqcJ0vJaXYQ=
X-Received: by 2002:a05:6820:1694:b0:65c:f14f:91ca with SMTP id
 006d021491bc7-66118924792mr4550602eaf.49.1768824562263; Mon, 19 Jan 2026
 04:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2257365.irdbgypaU6@rafael.j.wysocki> <0532f98b-1f33-418b-ae94-d9bb57fb259a@arm.com>
 <CAJZ5v0iGKZH_Zg1M_pXSizoPMHt5fuZOPbDeWhmXHatimjZBCQ@mail.gmail.com> <9b61f36f-f92d-478a-834c-1aa9d74d9d9e@arm.com>
In-Reply-To: <9b61f36f-f92d-478a-834c-1aa9d74d9d9e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Jan 2026 13:09:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jaAN+UF6u8WLVXmO5k0MfFNL1ToM46bS5RbZ+Gwp3EWA@mail.gmail.com>
X-Gm-Features: AZwV_QjZEdsZj3HV1W3yeswiLdLK2ttyqIlfEUk2dYgBKuFbJGoUlMIVLjVfCQw
Message-ID: <CAJZ5v0jaAN+UF6u8WLVXmO5k0MfFNL1ToM46bS5RbZ+Gwp3EWA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: governors: teo: Wakeup events
 classification change and some refinements
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 10:53=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/16/26 12:29, Rafael J. Wysocki wrote:
> > On Fri, Jan 16, 2026 at 12:52=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 1/14/26 19:42, Rafael J. Wysocki wrote:
> >>> Hi All,
> >>>
> >>> This material has been in my local queue for almost a full developmen=
t cycle,
> >>> so time to post it.
> >>>
> >>> The motivation for the changes in this series is mostly theoretical, =
but I do
> >>> see some idle power improvements from patch [4/5], for example, but n=
othing
> >>> specifically worth reporting.
> >>>
> >>> The first patch simply prevents idle states with zero-size bins from =
being
> >>> selected sometimes when teo_select() runs with stopped tick.
> >>>
> >>> Patch [2/5] avoids counting tick wakeups as intercepts unless there a=
re
> >>> sufficiently many intercepts within the tick period range to assume t=
hat
> >>> the tick wakeup may have clobbered a genuine intercept.
> >>>
> >>> Patch [3/5] simply updates a coefficient in one of the inequalities t=
o be
> >>> somewhat easier to interpret (this should be a cosmetic change).
> >>>
> >>> Patch [4/5] changes the criteria used for classifying wakeup events a=
s hits
> >>> or intercepts to (hopefully) make the classification work better for =
large
> >>> state bins.
> >>>
> >>> Patch [5/5] refines the idle state lookup based on intercepts to firs=
t
> >>> consider the state with the maximum intercepts metric, so that state =
is
> >>> always taken into consideration.
> >>>
> >>> Please see the individual patch changelogs for details.
> >>>
> >>> Thanks!
> >>>
> >>>
> >
> > Hi Christian,
> >
> >> Hi Rafael,
> >> I'll do the in-depth review, but have run some tests already.
> >> They are attached, platform is the usual rk3399.
> >> "teo" is mainline, "teo-$i" is with patches 1..$i applied.
> >
> > Thanks for testing!
> >
> >> There's a regression on teo-4 visible on the intercept heavy IO worklo=
ads,
> >> for idle misses that isn't strong enough to reflect in score changes e=
xcept
> >> for the very slow mtdblock device.
> >> interestingly though there also seems to be a regression in
> >> mapper/dm-slow (dm device with 51ms delay on each IO), which is not
> >> intercept heavy.
> >> Looking at the state residencies it overuses the deepest state2 in
> >> where state1 was preferred for the other teo variants.
> >> I've attached that too for reference.
> >> I'm assuming that is because of the new intercept-logic-exclusion clau=
se.
> >
> > So can you please restore that clause to its previous form, while
> > keeping the other changes in patch 4, and see if the regression is
> > still there?
> >
>
> Yep that restores it, I've attached the full results again with teo-4-p a=
nd teo-5-p
> being teo-4 and teo-5 but with
> -       if (2 * idx_intercept_sum > cpu_data->total) {
> +       if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>
> respectively.
>
> To highlight let me just quote the schbench results
> test       gov        i     score  %change    idles  idle_miss  miss_rt  =
 belows   aboves
> schbench   teo-4      0    295.87    +5.51%    29014     1309    0.045   =
  1168      141
> schbench   teo-4      1    302.20    +7.76%    31642     1408    0.044   =
  1105      303
> schbench   teo-4      2    301.07    +7.36%    29966     1602    0.053   =
  1393      209
> schbench   teo-4      3    297.00    +5.91%    29982     1529    0.051   =
  1266      263
> schbench   teo-4      4    297.20    +5.98%    29432     1419    0.048   =
  1194      225
> schbench   teo-4      5    299.47    +6.79%    30262     1381    0.046   =
  1189      192
> schbench   teo-4      6    301.23    +7.42%    29810     1469    0.049   =
  1234      235
> schbench   teo-4      7    301.00    +7.34%    29916     1511    0.051   =
  1355      156
> schbench   teo-4      8    299.17    +6.68%    29246     1444    0.049   =
  1296      148
> schbench   teo-4      9    297.77    +6.18%    30306     1399    0.046   =
  1195      204
> schbench   teo-4      10   304.03    +8.42%    30904     1346    0.044   =
  1163      183
> schbench   teo-4      11   300.73    +7.24%    30716     1276    0.042   =
  1089      187
> schbench   teo-4      12   298.13    +6.31%    29872     1314    0.044   =
  1081      233
> schbench   teo-4      13   298.73    +6.53%    30386     1288    0.042   =
  1092      196
> schbench   teo-4      14   300.77    +7.25%    30150     1323    0.044   =
  1074      249
> schbench   teo-4      15   296.23    +5.63%    32178     1328    0.041   =
  1061      267
> schbench   teo-4      16   283.50    +1.09%    27472     1282    0.047   =
  1126      156
> schbench   teo-4      17   300.53    +7.17%    29644     1552    0.052   =
  1375      177
> schbench   teo-4      18   302.23    +7.77%    31456     1418    0.045   =
  1194      224
> schbench   teo-4      19   307.43    +9.63%    32518     1259    0.039   =
   968      291
> schbench   teo-4-p    0    277.53    -1.03%    28054      503    0.018   =
   151      352
> schbench   teo-4-p    1    304.07    +8.43%    30650      553    0.018   =
   178      375
> schbench   teo-4-p    2    273.73    -2.39%    27120      509    0.019   =
   163      346
> schbench   teo-4-p    3    300.20    +7.05%    29932      528    0.018   =
   171      357
> schbench   teo-4-p    4    300.00    +6.98%    29580      584    0.020   =
   180      404
> schbench   teo-4-p    5    296.03    +5.56%    30176      514    0.017   =
   172      342
> schbench   teo-4-p    6    300.50    +7.16%    29806      550    0.018   =
   174      376
> schbench   teo-4-p    7    271.07    -3.34%    26934      472    0.018   =
   165      307
> schbench   teo-4-p    8    299.00    +6.62%    30568      564    0.018   =
   175      389
> schbench   teo-4-p    9    300.80    +7.26%    29660      482    0.016   =
   188      294
> schbench   teo-4-p    10   300.57    +7.18%    30384      634    0.021   =
   195      439
> schbench   teo-4-p    11   296.53    +5.74%    29590      599    0.020   =
   221      378
> schbench   teo-4-p    12   298.77    +6.54%    30664      599    0.020   =
   177      422
> schbench   teo-4-p    13   302.47    +7.86%    30200      559    0.019   =
   223      336
> schbench   teo-4-p    14   300.43    +7.13%    30326      562    0.019   =
   166      396
> schbench   teo-4-p    15   292.87    +4.44%    28798      524    0.018   =
   142      382
> schbench   teo-4-p    16   299.63    +6.85%    29718      535    0.018   =
   189      346
> schbench   teo-4-p    17   302.10    +7.73%    31122      584    0.019   =
   221      363
> schbench   teo-4-p    18   294.13    +4.89%    28312      560    0.020   =
   167      393
> schbench   teo-4-p    19   302.20    +7.76%    29872      556    0.019   =
   168      388
> schbench   teo-5      0    299.53    +6.81%    31198     1312    0.042   =
  1062      250
> schbench   teo-5      1    296.67    +5.79%    30090     1383    0.046   =
  1169      214
> schbench   teo-5      2    299.60    +6.84%    30010     1566    0.052   =
  1331      235
> schbench   teo-5      3    300.00    +6.98%    30764     1466    0.048   =
  1239      227
> schbench   teo-5      4    298.77    +6.54%    30002     1383    0.046   =
  1212      171
> schbench   teo-5      5    299.30    +6.73%    29848     1481    0.050   =
  1288      193
> schbench   teo-5      6    298.90    +6.59%    29586     1441    0.049   =
  1260      181
> schbench   teo-5      7    300.37    +7.11%    30672     1460    0.048   =
  1306      154
> schbench   teo-5      8    301.00    +7.34%    31454     1383    0.044   =
  1190      193
> schbench   teo-5      9    298.80    +6.55%    30042     1415    0.047   =
  1194      221
> schbench   teo-5      10   302.23    +7.77%    30986     1305    0.042   =
  1066      239
> schbench   teo-5      11   297.30    +6.02%    30112     1405    0.047   =
  1190      215
> schbench   teo-5      12   299.33    +6.74%    29536     1482    0.050   =
  1214      268
> schbench   teo-5      13   288.87    +3.01%    28754     1244    0.043   =
  1038      206
> schbench   teo-5      14   300.17    +7.04%    30232     1517    0.050   =
  1300      217
> schbench   teo-5      15   301.43    +7.49%    30578     1576    0.052   =
  1287      289
> schbench   teo-5      16   282.10    +0.60%    29106      996    0.034   =
   834      162
> schbench   teo-5      17   278.03    -0.86%    27432     1123    0.041   =
   926      197
> schbench   teo-5      18   304.40    +8.55%    29934     1526    0.051   =
  1296      230
> schbench   teo-5      19   276.50    -1.40%    28072     1158    0.041   =
   970      188
> schbench   teo-5-p    0    299.47    +6.79%    29994      587    0.020   =
   231      356
> schbench   teo-5-p    1    298.27    +6.36%    31600      555    0.018   =
   190      365
> schbench   teo-5-p    2    297.20    +5.98%    30350      543    0.018   =
   198      345
> schbench   teo-5-p    3    294.30    +4.95%    29962      523    0.017   =
   192      331
> schbench   teo-5-p    4    303.30    +8.16%    30366      480    0.016   =
   160      320
> schbench   teo-5-p    5    298.87    +6.58%    29838      541    0.018   =
   180      361
> schbench   teo-5-p    6    301.63    +7.56%    30022      480    0.016   =
   168      312
> schbench   teo-5-p    7    298.47    +6.43%    30210      581    0.019   =
   202      379
> schbench   teo-5-p    8    298.77    +6.54%    30636      529    0.017   =
   210      319
> schbench   teo-5-p    9    298.63    +6.49%    30474      564    0.019   =
   185      379
> schbench   teo-5-p    10   300.10    +7.01%    30808      577    0.019   =
   251      326
> schbench   teo-5-p    11   295.87    +5.51%    30190      565    0.019   =
   186      379
> schbench   teo-5-p    12   301.27    +7.43%    29958      466    0.016   =
   160      306
> schbench   teo-5-p    13   280.83    +0.14%    27916      494    0.018   =
   164      330
> schbench   teo-5-p    14   294.23    +4.92%    30330      611    0.020   =
   219      392
> schbench   teo-5-p    15   297.13    +5.96%    30728      656    0.021   =
   195      461
> schbench   teo-5-p    16   297.97    +6.25%    30242      524    0.017   =
   178      346
> schbench   teo-5-p    17   301.27    +7.43%    31004      524    0.017   =
   208      316
> schbench   teo-5-p    18   297.97    +6.25%    29864      565    0.019   =
   211      354
> schbench   teo-5-p    19   298.43    +6.42%    30462      519    0.017   =
   150      369
>
> The -p variants have less than half the idle_misses and fall into the sam=
e order of magnitude
> for this test than all the other teo variants.

Thanks for the data!

I'll send an update of patch 4 without the intercept-logic-exclusion clause=
.

I thought that it would be necessary, but that does not turn out to be the =
case.

