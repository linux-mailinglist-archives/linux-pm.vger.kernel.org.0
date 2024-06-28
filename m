Return-Path: <linux-pm+bounces-10214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1291C65B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 21:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210B11F21F63
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCCF7347F;
	Fri, 28 Jun 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCgugXBT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A9D27E;
	Fri, 28 Jun 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601628; cv=none; b=cVrYQH3iDIz+aw6ppBHGAYJSj1OuLGJuCAbj1+Of6nCTppMmi2g+tbYYb7GQdmHN41XFoFe6bfxRs9l5NeraeU8zrHtqzs+7MocC7JyJyqE2HFE8gJuWGJi0y+paHCvgN4NGVAGBpk0vHH8Fmn/C4tNzgjOLUpxMiyPkeDpWDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601628; c=relaxed/simple;
	bh=RyPLhi7w8OO9gyuCrd5ByF7VZMJeWMWpNRSDkOtxo5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj3tjldOmk+3BkGHl7RUKI1ee3s4I8eC2op4QZf/GkOYDauwAY/pMyhkhhY0Sh2+A47HcoB1F3APHnH7sD/57pISFq7ZJfknLT8c9zgJpskGKuCLdDUI5lsCQnfiS9tMhPUpJGgNNfmyx8+35NfBZi6eRatAC0RG3r7he+cc3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCgugXBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33532C4AF0D;
	Fri, 28 Jun 2024 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719601628;
	bh=RyPLhi7w8OO9gyuCrd5ByF7VZMJeWMWpNRSDkOtxo5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oCgugXBTOWJhoHrdKScGOZEezZxFxvQ17x9WgEa9sdniy5b4IQ4VQqGmxYC1Eo/+T
	 crDc0D6eNycyjbvXwca0AfcoySWqEexYQfIa2P+JJHraI5aTdOZWaesE76PdRQ8zCT
	 TQX6D96uKVJhDkhShqHhwRCY9oOwv5qc/vW5DKGAFmpO0Bi7O+VGLDJ/wn1+pkxhRZ
	 zVagycpmhn10DAtJWybzRSQPA30B4bl/Cfs0LK0nStF4eC8cRL/R3jPIfYh/YtJkap
	 OCjZmEMdJYvpaunfsOxrNtWv3jsF9yewPq12KlUg93BJMwJ+uVjDm36bROXvK/tKwi
	 i/f2Wk71o9vNA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24c582673a5so131802fac.2;
        Fri, 28 Jun 2024 12:07:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4+/fxSnPOd7N2gQ4NERUy5ur1COv6xM1nTUO9PnjQpmkA9SLBFlYccazLrVCHCX2gVctFD1alueVW2GJJ/WGEUeuwoIa0TlAfwiTz
X-Gm-Message-State: AOJu0YyT3DPc022gLg9o3suwmHWzRirQP//HhicIevUCeCYWod88pshw
	3uVsoH4oeoKTPwAZMobWIYKL7KlBAUzZNO1oPKAbocteq6hgIoDR/aoVfG37D3WVvY05bKq4P0t
	yM8xXoF4vzvt6RuxNqtO7rYgKWV8=
X-Google-Smtp-Source: AGHT+IHgptNGEYMDc8VZ8L/UAWHsLquuhFvV/QDBvFlP2qT6gSAJeDmhjr3fHia7sZmPfECMkzWFulECjLdiiktMCqs=
X-Received: by 2002:a05:6870:4208:b0:25c:ad1f:b335 with SMTP id
 586e51a60fabf-25cf3fdb5f6mr20290991fac.4.1719601627441; Fri, 28 Jun 2024
 12:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628095955.34096-1-christian.loehle@arm.com>
In-Reply-To: <20240628095955.34096-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 21:06:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
Message-ID: <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
Subject: Re: [PATCHv3 0/3] cpuidle: teo: Fixing utilization and intercept logic
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org, 
	daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de, 
	dsmythies@telus.net, kajetan.puchalski@arm.com, lukasz.luba@arm.com, 
	dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:02=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Hi all,
> so my investigation into teo lead to the following fixes.
>
> 1/3:
> As discussed the utilization threshold is too high while
> there are benefits in certain workloads, there are quite a few
> regressions, too. Revert the Util-awareness patch.
> This in itself leads to regressions, but part of it can be offset
> by the later patches.
> See
> https://lore.kernel.org/lkml/CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VX=
RT2b5bg@mail.gmail.com/
> 2/3:
> Remove the 'recent' intercept logic, see my findings in:
> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com=
/
> I haven't found a way to salvage this properly, so I removed it.
> The regular intercept seems to decay fast enough to not need this, but
> we could change it if that turns out that we need this to be faster in
> ramp-up and decaying.
> 3/3:
> The rest of the intercept logic had issues, too.
> See the commit.
>
> Happy for anyone to take a look and test as well.
>
> Some numbers for context, comparing:
> - IO workload (intercept heavy).
> - Timer workload very low utilization (check for deepest state)
> - hackbench (high utilization)
> - Geekbench 5 on Pixel6 (high utilization)
> Tests 1 to 3 are on RK3399 with CONFIG_HZ=3D100.
> target_residencies: 1, 900, 2000
>
> 1. IO workload, 5 runs, results sorted, in read IOPS.
> fio --minimal --time_based --name=3Dfiotest --filename=3D/dev/nvme0n1 --r=
untime=3D30 --rw=3Drandread --bs=3D4k --ioengine=3Dpsync --iodepth=3D1 --di=
rect=3D1 | cut -d \; -f 8;
>
> teo fixed v2:
> /dev/nvme0n1
> [4599, 4658, 4692, 4694, 4720]
> /dev/mmcblk2
> [5700, 5730, 5735, 5747, 5977]
> /dev/mmcblk1
> [2052, 2054, 2066, 2067, 2073]
>
> teo mainline:
> /dev/nvme0n1
> [3793, 3825, 3846, 3865, 3964]
> /dev/mmcblk2
> [3831, 4110, 4154, 4203, 4228]
> /dev/mmcblk1
> [1559, 1564, 1596, 1611, 1618]
>
> menu:
> /dev/nvme0n1
> [2571, 2630, 2804, 2813, 2917]
> /dev/mmcblk2
> [4181, 4260, 5062, 5260, 5329]
> /dev/mmcblk1
> [1567, 1581, 1585, 1603, 1769]
>
>
> 2. Timer workload (through IO for my convenience =F0=9F=98=89 )
> Results in read IOPS, fio same as above.
> echo "0 2097152 zero" | dmsetup create dm-zeros
> echo "0 2097152 delay /dev/mapper/dm-zeros 0 50" | dmsetup create dm-slow
> (Each IO is delayed by timer of 50ms, should be mostly in state2, for 5s =
total)
>
> teo fixed v2:
> idle_state time
> 2.0     4.807025
> -1.0    0.219766
> 0.0     0.072007
> 1.0     0.169570
>
> 3199 cpu_idle total
> 38 cpu_idle_miss
> 31 cpu_idle_miss above
> 7 cpu_idle_miss below
>
> teo mainline:
> idle_state time
> 1.0     4.897942
> -1.0    0.095375
> 0.0     0.253581
>
> 3221 cpu_idle total
> 1269 cpu_idle_miss
> 22 cpu_idle_miss above
> 1247 cpu_idle_miss below
>
> menu:
> idle_state time
> 2.0     4.295546
> -1.0    0.234164
> 1.0     0.356344
> 0.0     0.401507
>
> 3421 cpu_idle total
> 129 cpu_idle_miss
> 52 cpu_idle_miss above
> 77 cpu_idle_miss below
>
> Residencies:
> teo mainline isn't in state2 at all, teo fixed is more in state2 than men=
u, but
> both are in state2 the vast majority of the time as expected.
>
> tldr: overall teo fixed spends more time in state2 while having
> fewer idle_miss than menu.
> teo mainline was just way too aggressive at selecting shallow states.
>
> 3. Hackbench, 5 runs
> for i in $(seq 0 4); do hackbench -l 100 -g 100 ; sleep 1; done
>
> teo fixed v2:
> Time: 4.937
> Time: 4.898
> Time: 4.871
> Time: 4.833
> Time: 4.898
>
> teo mainline:
> Time: 4.945
> Time: 5.021
> Time: 4.927
> Time: 4.923
> Time: 5.137
>
> menu:
> Time: 4.964
> Time: 4.847
> Time: 4.914
> Time: 4.841
> Time: 4.800
>
> tldr: all comparable, teo mainline slightly worse
>
> 4. Geekbench 5 (multi-core) on Pixel6
> (Device is cooled for each iteration separately)
> teo mainline:
> 3113, 3068, 3079
> mean 3086.66
>
> teo revert util-awareness:
> 2947, 2941, 2952
> mean 2946.66 (-4.54%)
>
> teo fixed v2:
> 3032, 3066, 3019
> mean 3039 (-1.54%)
>
>
> Changes since v2:
> - Reworded commits according to Dietmar's comments
> - Dropped the KTIME_MAX as hit part from 3/3 according to Dietmar's
> remark.
>
> Changes since v1:
> - Removed all non-fixes.
> - Do a full revert of Util-awareness instead of increasing thresholds.
> - Address Dietmar's comments.
> https://lore.kernel.org/linux-kernel/20240606090050.327614-2-christian.lo=
ehle@arm.com/T/
>
> Kind Regards,
> Christian
>
> Christian Loehle (3):
>   Revert: "cpuidle: teo: Introduce util-awareness"
>   cpuidle: teo: Remove recent intercepts metric
>   cpuidle: teo: Don't count non-existent intercepts
>
>  drivers/cpuidle/governors/teo.c | 189 +++++---------------------------
>  1 file changed, 27 insertions(+), 162 deletions(-)
>
> --

Patches [1-2/3] have been applied as 6.11 material.

Patch [3/3] looks like it may be improved slightly, see my reply to that pa=
tch.

Thanks!

