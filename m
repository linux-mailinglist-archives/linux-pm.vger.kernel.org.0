Return-Path: <linux-pm+bounces-38304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF4C7450B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 14:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE4CA348188
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1594233FE12;
	Thu, 20 Nov 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldUotjns"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958433EB10
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645900; cv=none; b=jJCtT6ozRTI+mwHXUXAcO3gB96sR2of7QQQIoBp90fTXx4qbhHyLdyI4EV7U5Ble7kJ+7fxR2hRImjevjZ72Xkh14DNb5a9GG/F/iz8goOk/w1d1x2BsSSRvpyIlp+P9NPBvidq1UME+BJ1Ak1dPh+UGKxuCFI6dVU0L+mtO6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645900; c=relaxed/simple;
	bh=yt/tauTFw2tqpdTB/Yf0Wa9YOpWm5YUfYBSdiGo1Tb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3T7H5dPF+5feTNA/7/2bpw0KzVf7ZCz+6NFylNd3RgwMiMM8ebkWu1OUqxPTnHO4h58TjAMn1SXQ5jU5RiN3Q9VWfIbWEH2urxPrhYih1UiV+vTPu8C0PVSZFxy+J9O/K3Xbk3k2Zf47lx7FY9xyHg2tIZNvWTdaPo+bpEdiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldUotjns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95233C19422
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763645900;
	bh=yt/tauTFw2tqpdTB/Yf0Wa9YOpWm5YUfYBSdiGo1Tb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ldUotjnsFGaXL/OgwzV3O9CvYT7YFOYcQIbIme2EsCrY48D78N2DE/nKDfKKRBl3N
	 tL5TceAUYW/nHC2rl0ZL1K/mcfAa68fYlQCGZILBf+Px31uPFyjycaAmTy4Qy/zjbn
	 4knk70KWGYCQzrscdCzzsMvoSZP/47vXT1akevgTwmcEvlZqi0f4mbvccPI436OhRU
	 bwTBouW2DkWEfIoKbHnIwTBvLjadiYHh0bykAOgF7rJhYwftAR1ZvkCFRL9FgXu1DC
	 /Fu2lCHpstkwz79uqtyEKezzcAitd4RplCpXebhdrzXQkXF2dZS2pknet3xmK7D04v
	 FjRXzxyHlEwPg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65763315216so347031eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 05:38:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVz7CGLVRW7bCcvuvYKOflWdPZ5PTpCygpW5n4Ib6vTiSq8KTjEvBzZCVUtNtRLOP7ITu1JyCR/Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgj0Y1DM15QiXbGUtnpxjo3LQup6gaGDE4K95pDEUUjcETt5WP
	UJwZX2t08RNt9fnWKfohoSadxQpct8uWVJAWfAkmT7NmnnqAt4L77SlKiLyAh+0KSmg/YU2VQAi
	1hZMXnDQdr2x2DxhIqpAQ0oY/UYl6cbU=
X-Google-Smtp-Source: AGHT+IHV2h+/0/fRmb9qYFKLVFUDFyCra4r7GC6vnuyYQwTydRACpQgqGThvP7y6Ge1rV3oHxIiLKbW9KEQ2wlljGD8=
X-Received: by 2002:a4a:e904:0:b0:657:7272:e011 with SMTP id
 006d021491bc7-657849dfe0bmr1186702eaf.5.1763645899852; Thu, 20 Nov 2025
 05:38:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
 <003f01dc59a7$2bd98b40$838ca1c0$@telus.net> <CAJZ5v0ic91RriXEHJkEFn0EkPKykmdEANimbKjAtdR0SwCZ4OA@mail.gmail.com>
 <f46bb011-83b1-4037-bc6f-eb7e72800e38@arm.com>
In-Reply-To: <f46bb011-83b1-4037-bc6f-eb7e72800e38@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 14:38:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i2hf_npzB+btX53VBDP+29Xy3sbuo5y36mOTZVe39O+Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnpCwy8vQjxqST9NxiOT35HorIsSRJDiUFsOoCYQOQCSbM9Q-wA9QCWH_U
Message-ID: <CAJZ5v0i2hf_npzB+btX53VBDP+29Xy3sbuo5y36mOTZVe39O+Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Reka Norman <rekanorman@chromium.org>, Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:35=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/20/25 11:02, Rafael J. Wysocki wrote:
> > On Wed, Nov 19, 2025 at 11:52=E2=80=AFPM Doug Smythies <dsmythies@telus=
.net> wrote:
> >>
> >> On 2025.11.13 07:22 Christian Loehle wrote:
> >>> On 11/12/25 16:21, Rafael J. Wysocki wrote:
> >>>> Hi,
> >>>>
> >>>> This is a bunch of teo cpuidle governor improvements, some of which =
are related
> >>>> to a bug report discussed recently:
> >>>>
> >>>> https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57T=
HQsU_qdcCx1m4w5g@mail.gmail.com/
> >>>>
> >>>> The first patch fixes a bug that may cause an overly deep idle state
> >>>> to be selected when the scheduler tick has been already stopped.
> >>>>
> >>>> Patch [2/4] removes an unnecessary function argument.
> >>>>
> >>>> Patch [3/4] makes teo_update() to use s64 as the data type for its l=
ocal
> >>>> variables more consistently.
> >>>>
> >>>> The last patch reworks the governor's decay implementation to also d=
ecay
> >>>> metric values lower than 8.
> >>>>
> >>>
> >>> Tested-by: Christian Loehle <christian.loehle@arm.com>
> >>>
> >>> Test results below, although there really isn't anything interesting =
in there.
> >>> teo-1 to teo-4 (patches 1 to 4 respectively are essentially indisting=
uishable from
> >>> teo-m =3D mainline)
> >>
> >> I tested the 4 patch set also, and also found no differences in result=
s above
> >> repeatability noise levels.
> >>
> >> Additionally, I added another patch (patch 5 of 4):
> >> "cpuidle: governors: teo: Rework the handling of tick wakeups" [1]
> >> Similar findings.
> >>
> >> Additionally, I added another patch (patch 6 of 4):
> >> "sched/idle: disable tick in idle=3Dpoll idle entry" [2]
> >> And found only one significant improvement, for only one test,
> >> but only for the TEO idle governor:
> >>
> >> Kernel 6.18-rc4:
> >> For a 6 pair fast ping-pong test (meaning no work per token stop):
> >> teo: 5.53 uSec per loop, reference test
> >> 4 of 4 patches: 5.53 uSec per loop, 0%
> >> 5 of 4 patches: 5.54 uSec per loop, 0.2% (noise)
> >> 6 of 4 patches: 4.77 uSec per loop, 13% better
> >> 6 of 4 patches (again): 4.81 uSec per loop, 13% better
> >> menu: 5.29 uSec per loop, 4.4% better
> >> menu + patch 6 of 4: 5.28 uSec per loop, 4.5% better
> >>
> >> Idle state 0 usage:
> >> 18% with patch 6, teo
> >> 11% with menu
> >> ~1% with mainline and not patch 6, teo.
> >>
> >> Idle state 1 usage:
> >> almost 0 with patch 6, teo
> >> ~6% with menu
> >> 27% with mainline and not patch 6, teo.
> >>
> >> Power: About 100 watts. Patch 6 and teo does increase power use by abo=
ut a watt or 2.
> >>
> >> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
> >>
> >> For clarity my branch log:
> >> 3993913d7f81 (HEAD -> rjw-teo) sched/idle: disable tick in idle=3Dpoll=
 idle entry
> >> d9b12b8d62bf cpuidle: governors: teo: Rework the handling of tick wake=
ups
> >> e47178c87272 cpuidle: governors: teo: Decay metrics below DECAY_SHIFT =
threshold
> >> 7fe32e411c2b cpuidle: governors: teo: Use s64 consistently in teo_upda=
te()
> >> 490e6118e45d cpuidle: governors: teo: Drop redundant function paramete=
r
> >> 8f627f86062e cpuidle: governors: teo: Drop incorrect target residency =
check
> >> 6146a0f1dfae (tag: v6.18-rc4, origin/master, origin/HEAD, master) Linu=
x 6.18-rc4
> >>
> >> [1] https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysoc=
ki/
> >> [2] https://lore.kernel.org/linux-pm/aQiWfnnSzxsnwa2o@tpad/
> >
> > Thanks for the feedback, much appreciated!
> >
> > I will likely have some more teo updates in the next cycle.
>
> You're welcome, looking forward to reviewing them too.
> I haven't tried to see what this would ideally look like for the -stable =
branches.
> Just backport everything until the most recent applicable Fixes:?

I've added a list to this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dlinux-next&id=3D14c66155c4609f1a1207d4e716c5e722b8bf920e

