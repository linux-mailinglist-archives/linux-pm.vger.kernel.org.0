Return-Path: <linux-pm+bounces-36381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC310BECEC9
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 13:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D8E620DA9
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39F23BCEE;
	Sat, 18 Oct 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP+doxyO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BAB21A434
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760788009; cv=none; b=ugq8WnpPlJxsEjS2O6ji/JfkVgg9Tl3l7AMJTIBGrtvUXmFMi/+tGJB0Np+BnBhqRgWgOlPNOdH/U7EI7pnna4EMa2DNXrN8rQR3bzvNnNBkL9DZrhhu/8bfHzId7vPvoV6rtzi/WmdnGOqlMQv2pkECupN9RrUYSkGXlqFp/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760788009; c=relaxed/simple;
	bh=6CXt2WoBSPpYfzMJB6wZKfudaHXk53V5XAwPHxMaOTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIKs3nRACRiC/7uaWT+WhtZ8sI/cuczr/OjLDkf3NLVA8hTKRuk8p+Ocrb0j9ZJ25pjDjGfdYUuks+CR50KRrcX/nXQ2LylzeUh/BBy8WFIELkFWnx0kGEBpKK9dyksQDLmn5k+XZih2ihqRYLJKozVj/Rd0nyeEn9N09hCpC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP+doxyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAB1C4CEFE
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760788008;
	bh=6CXt2WoBSPpYfzMJB6wZKfudaHXk53V5XAwPHxMaOTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NP+doxyOFh8geMbWu6V6rQfrgFZugRcPByNIqly9NlvCocpXH1JKkZX+HPvHhIhwH
	 I5wBcWlIsK0aDHWBB5NioWwhFruGwxXeO/UhxiEEUOA8WWvAw2cOK2e71nPLuVGJMj
	 era0GYf/35HzIKqNRDXDJ7ycJ2kCR/fKmaVCHY4h01CgVQPelBz1xxkPzPrCvx1WDC
	 BWaezMCMoTZ9pwjl3VJO2AAEmh96NZ8vQPu3lo3/IMs4bfZ0bCrAdpUZYaOdz0/DcF
	 4u+2CZnHQp+bqcshM1Ko1oGoSKlct3YG3mGMQDVOZyMEp7B/boFakRlMp21cJzVuKk
	 31lNFSmeuXHXg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-441de7ba142so1581278b6e.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 04:46:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/8YOJER26XDSFrTqUnzsYxJSVVi14Cxsmf2mCa0aoYySCnglr95ycLOh3SN7li8qSozIMPW1Hlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5dJqVhkGnbw9JuM5qwA2LnZlIeVjfXSyuxijXH5Ti5YkZiAX
	P5NUXlR69TPu94wJcvMT0I7cEQd3Eko1WhYa82+dqn8s8zCU+xOdM30xngl8Z8rbiF/geRgwddR
	vSDOr6V1ezkCMskI3bACf/h1XafTQPTw=
X-Google-Smtp-Source: AGHT+IGfmDQSfPbSYs8f803/Sl+JWn2jNXGcu/ypNvsXEKv+bABRyWjZp/y8ntX1+XwoEUJruD4K0WbHHsX4U3IBiKA=
X-Received: by 2002:a05:6808:219a:b0:43f:648b:dcb2 with SMTP id
 5614622812f47-443a2ec98camr3165318b6e.8.1760788007954; Sat, 18 Oct 2025
 04:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4687373.LvFx2qVVIh@rafael.j.wysocki> <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
 <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com> <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
In-Reply-To: <28ecb23b-ecee-409a-9771-24f801081d07@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 18 Oct 2025 13:46:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
X-Gm-Features: AS18NWBrzzr4jet5h9WoMnvad54yvwS2xgqwfndHEk8wWuGlEhh4-XYopiEH4QI
Message-ID: <CAJZ5v0jMoEVUaYYPx6EtHFxsg6TF-QtDWJGrasGK7C2C+JxOFw@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, LKML <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Tomasz Figa <tfiga@chromium.org>, 
	Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 8:37=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/17/25 10:39, Rafael J. Wysocki wrote:
> > On Fri, Oct 17, 2025 at 10:22=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 10/16/25 17:25, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discar=
ding
> >>> useful information") led to a performance regression on Intel Jasper =
Lake
> >>> systems because it reduced the time spent by CPUs in idle state C7 wh=
ich
> >>> is correlated to the maximum frequency the CPUs can get to because of=
 an
> >>> average running power limit [1].
> >>> [snip]
> >> [snip]
> >> Anyway, the patch makes sense, let me run some tests and get back.
> >
> > Thanks!
>
> Unfortunately this patch regresses my tests about as much as a revert of
> 85975daeaa4d would.
> (menu-1 is $SUBJECT, menu-m current mainline, menu-r mainline with
> 85975daeaa4d reverted):
>
>
> device   gov     iter    iops    idles   idle_misses     idle_miss_ratio =
        belows  aboves
> mmcblk1         menu-1  0       1523    402522  119988  0.298   98552   2=
1436
> mmcblk1         menu-1  1       1481    395766  118596  0.300   97640   2=
0956
> mmcblk1         menu-1  2       1503    396560  117876  0.297   97506   2=
0370
> mmcblk1         menu-m  0       2355    703732  22275   0.032   2628    1=
9647
> mmcblk1         menu-m  1       2359    637522  24815   0.039   4075    2=
0740
> mmcblk1         menu-m  2       2356    706980  23836   0.034   3208    2=
0628
> mmcblk1         menu-r  0       1490    388180  118294  0.305   97871   2=
0423
> mmcblk1         menu-r  1       1498    393402  119984  0.305   99187   2=
0797
> mmcblk1         menu-r  2       1462    388597  119504  0.308   98640   2=
0864
> mmcblk2         menu-1  0       3303    503938  170251  0.338   150276  1=
9975
> mmcblk2         menu-1  1       3310    480508  132132  0.275   114398  1=
7734
> mmcblk2         menu-1  2       3554    466884  113659  0.243   95841   1=
7818
> mmcblk2         menu-m  0       5746    706262  24618   0.035   3802    2=
0816
> mmcblk2         menu-m  1       5741    727174  24152   0.033   3737    2=
0415
> mmcblk2         menu-m  2       5777    836940  12424   0.015   335     1=
2089
> mmcblk2         menu-r  0       3241    463112  133052  0.287   114616  1=
8436
> mmcblk2         menu-r  1       3551    422006  100494  0.238   82425   1=
8069
> mmcblk2         menu-r  2       3523    508542  140085  0.275   122880  1=
7205
> nvme0n1         menu-1  0       5407    436834  74314   0.170   54133   2=
0181
> nvme0n1         menu-1  1       5763    459510  72673   0.158   51530   2=
1143
> nvme0n1         menu-1  2       6266    489570  78651   0.161   58609   2=
0042
> nvme0n1         menu-m  0       10786   767740  23840   0.031   2855    2=
0985
> nvme0n1         menu-m  1       10586   757540  23612   0.031   2933    2=
0679
> nvme0n1         menu-m  2       11805   834012  23528   0.028   2768    2=
0760
> nvme0n1         menu-r  0       5323    431906  77426   0.179   56166   2=
1260
> nvme0n1         menu-r  1       5484    438142  76033   0.174   55956   2=
0077
> nvme0n1         menu-r  2       5353    428826  77024   0.180   57016   2=
0008
> sda     menu-1  0       972     444116  149643  0.337   129023  20620
> sda     menu-1  1       954     557068  176479  0.317   159092  17387
> sda     menu-1  2       878     540360  196405  0.363   176792  19613
> sda     menu-m  0       1634    1017918         29614   0.029   8587    2=
1027
> sda     menu-m  1       1622    878140  25323   0.029   8238    17085
> sda     menu-m  2       1632    1027167         28798   0.028   8428    2=
0370
> sda     menu-r  0       918     531112  188314  0.355   168375  19939
> sda     menu-r  1       924     521378  185727  0.356   165327  20400
> sda     menu-r  2       880     529146  196391  0.371   176908  19483
> nullb0  menu-1  0       101419  88988   23923   0.269   3080    20843
> nullb0  menu-1  1       101610  88484   23678   0.268   2821    20857
> nullb0  menu-1  2       101369  89336   23711   0.265   2795    20916
> nullb0  menu-m  0       101696  88698   23860   0.269   2910    20950
> nullb0  menu-m  1       101103  88120   23294   0.264   3295    19999
> nullb0  menu-m  2       101880  86676   22730   0.262   2709    20021
> nullb0  menu-r  0       101856  87742   23493   0.268   3204    20289
> nullb0  menu-r  1       101514  89070   23653   0.266   2848    20805
> nullb0  menu-r  2       101754  86318   23163   0.268   3229    19934
> mtdblock3       menu-1  0       163     350284  115149  0.329   97166   1=
7983
> mtdblock3       menu-1  1       179     315948  99038   0.313   78243   2=
0795
> mtdblock3       menu-1  2       134     481584  160754  0.334   144150  1=
6604
> mtdblock3       menu-m  0       215     410034  70261   0.171   55445   1=
4816
> mtdblock3       menu-m  1       205     570150  109273  0.192   90189   1=
9084
> mtdblock3       menu-m  2       252     866616  23492   0.027   9717    1=
3775
> mtdblock3       menu-r  0       132     467365  161835  0.346   144056  1=
7779
> mtdblock3       menu-r  1       164     348682  117704  0.338   97859   1=
9845
> mtdblock3       menu-r  2       132     483300  165179  0.342   147164  1=
8015

Well, this means that in the majority of cases the maximum sample idle
time is so large that UINT_MAX may as well be returned instead.

The possible correlation between idle power and the max OPP a CPU can
get to has not been taken into account in cpuidle directly so far, but
it clearly isn't true that using shallow idle states more often always
improves performance.  It may hurt performance too.

Actually, this possible correlation appears to have a broader impact,
as it may affect CAS and EAS at least in principle, so it may be
advisable to allocate some time for discussing it during upcoming
conferences.

At this point I'm inclined to revert commit 85975daeaa4d because
anything else would be clearly artificial and likely ineffective at
least in some cases.

The systems that enjoyed better performance after that commit can
switch over to teo and continue to enjoy it and everybody else still
using menu should be able to continue to do so.

