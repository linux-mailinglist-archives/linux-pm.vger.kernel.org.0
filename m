Return-Path: <linux-pm+bounces-8709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CD8FE681
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507511F232B6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2585195815;
	Thu,  6 Jun 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYe3t5Kh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8113BC26;
	Thu,  6 Jun 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676974; cv=none; b=rzyTpb9LGpEu7wNKzRb4A2/NnvabnwRMS4bIG8rpguSyPejG5yBKQgjCtOFQI6n93KGDeFEU5A0GDjebVrbUCPj/psJ7rkiGb2kzFpHfSKMutO9cknxQ41xVr5zpqr2xG9g9YV+j2BMHrk2orApiaxzSFcKZMNQqRmzjsPQqogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676974; c=relaxed/simple;
	bh=JO4vDkKzVOm9/jAngDSnL/wZZ/H903NWD2H/iKOdhmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVmmpv9050IGJlRsigvYlphkmZgdnw3MggsbxQQPVBuX+lMyB9c8ym+u45nFlh9f/ihehS+u68HPrit1YroQURH1/Z01bhtN8I3Jda/SX9eRWrb5unUaSTWIevg271WUd0RBiWhHHVuesYSt6vntmY/nHNkq1mGs7sw/K7/ImWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYe3t5Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F54AC4AF09;
	Thu,  6 Jun 2024 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717676974;
	bh=JO4vDkKzVOm9/jAngDSnL/wZZ/H903NWD2H/iKOdhmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NYe3t5KhM8lKZqW6tqbZxzIzUNv/SNU2jHCKAzqgMp8FehE6z0RN2rHWC4YEI/nb7
	 I61Nia0R6AfR3QQQmokT0kO9s3lyc1+xa9il1VvrYUSOssLDc6kVYr9lb9uXeO48iJ
	 MkYqrRS8jAsVAfKasccDVUqMrsuuACKMBfss6Q9hcrYEXaQaUTz2VBpYXY2ev4H5P8
	 5mF0lUdpJQsk0WhFnwmCB6Fuj24sLIWmn1b3eWQAMzGpphXmw4E7sGcVb4I/Vjnw9x
	 naeoEkqskttOgPlvYoJTUz4CGO/F1aOta+BNJAbg+5eKnCgLCJkVhkHctaa1UX1fS4
	 kyCK9BX86sVNg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ba8e1b9018so29315eaf.0;
        Thu, 06 Jun 2024 05:29:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9CFRv7oN6hJxfYw97XBFhzhCjVt/QGzQCvqnPfYIfaWaZhVgpohDWDdZdCOm2Gg8hP99SoMdcJX9/TLn4BPYpu0dA0q2xnCjeBmbA
X-Gm-Message-State: AOJu0Yzzu3O+JnHL3MN6nqRzvgJ9nUiB0qhjmWyJHkq3sicmBmtzTXVQ
	nA/1OcjI41/hnHTMfKjioHde1stIaY1O44LflonP7QUQah7SafG0GlWvV+gAKYqBaN7sOJCwvJ7
	M4j+H23vxyyVJ2eTrvxApnUXxwIM=
X-Google-Smtp-Source: AGHT+IFflVdDofvlZikYC453cpn9M5lxdPlj8Zr3KvTocqS02keXZVD0wH3Wm7R2a2yg9AUZ1eR96KwhSFqti9AD550=
X-Received: by 2002:a4a:a7c9:0:b0:5ba:6669:ba6e with SMTP id
 006d021491bc7-5ba78ff8903mr5616041eaf.1.1717676973358; Thu, 06 Jun 2024
 05:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606090050.327614-1-christian.loehle@arm.com> <db984b92-549a-46e1-ae3a-0e1fb4f2e5b2@arm.com>
In-Reply-To: <db984b92-549a-46e1-ae3a-0e1fb4f2e5b2@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Jun 2024 14:29:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmg4Vz4=pDoaZmToBGMxMoVDt8qDm-+RMHCh46nPW31Q@mail.gmail.com>
Message-ID: <CAJZ5v0jmg4Vz4=pDoaZmToBGMxMoVDt8qDm-+RMHCh46nPW31Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] cpuidle: teo: fixes and improvements
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org, 
	daniel.lezcano@linaro.org, anna-maria@linutronix.de, 
	kajetan.puchalski@arm.com, lukasz.luba@arm.com, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 1:59=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 6/6/24 10:00, Christian Loehle wrote:
> > Hi all,
> > so my investigation into teo lead to the following fixes and
> > improvements. Logically they are mostly independent, that's why this
> > cover letter is quite short, details are in the patches.
> >
> > 1/6:
> > As discussed, the utilization threshold is too high, while
> > there are benefits in certain workloads, there are quite a few
> > regressions, too.
> > 2/6:
> > Especially with the new util threshold, stopping tick makes little
> > sense when utilized is detected, so don't.
> > 3/6:
> > Particularly with WFI, even if it's the only state, stopping the tick
> > has benefits, so enable that in the early bail out.
> > 4/6:
> > Stopping the tick with 0 cost (if the idle state dictates it) is too
> > aggressive IMO, so add 1ms constant cost.
> > XXX: This has the issue of now being counted as idle_miss, so we could
> > consider adding this to the states, too, but the simple implementation
> > of this would have the downside that the cost is added to deeper states
> > even if the tick is already off.
> > 5/6:
> > Remove the 'recent' intercept logic, see my findings in:
> > https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.c=
om/
> > I haven't found a way to salvage this properly, so I removed it.
> > The regular intercept seems to decay fast enough to not need this, but
> > we could change it if that turns out to be the case.
> > 6/6:
> > The rest of the intercept logic had issues, too.
> > See the commit.
> >
> > TODO: add some measurements of common workloads and some simple sanity
> > tests (like Vincent described in low utilization workloads if the
> > state selection looks reasonable).
> > I have some, but more (and more standardized) would be beneficial.
> >
> > Happy for anyone to take a look and test as well.
> >
> > Some numbers for context:
> > Maybe some numbers for context, I'll probably add them to the cover let=
ter.
> >
> > Comparing:
> > - IO workload (intercept heavy).
> > - Timer workload very low utilization (check for deepest state)
> > - hackbench (high utilization)
> > all on RK3399 with CONFIG_HZ=3D100.
> > target_residencies: 1, 900, 2000
> >
> > 1. IO workload, 5 runs, results sorted, in read IOPS.
> > fio --minimal --time_based --name=3Dfiotest --filename=3D/dev/nvme0n1 -=
-runtime=3D30 --rw=3Drandread --bs=3D4k --ioengine=3Dpsync --iodepth=3D1 --=
direct=3D1 | cut -d \; -f 8;
> >
> > teo fixed:
> > /dev/nvme0n1
> > [4597, 4673, 4727, 4741, 4756]
> > /dev/mmcblk2
> > [5753, 5832, 5837, 5911, 5949]
> > /dev/mmcblk1
> > [2059, 2062, 2070, 2071, 2080]
> >
> > teo mainline:
> > /dev/nvme0n1
> > [3793, 3825, 3846, 3865, 3964]
> > /dev/mmcblk2
> > [3831, 4110, 4154, 4203, 4228]
> > /dev/mmcblk1
> > [1559, 1564, 1596, 1611, 1618]
> >
> > menu:
> > /dev/nvme0n1
> > [2571, 2630, 2804, 2813, 2917]
> > /dev/mmcblk2
> > [4181, 4260, 5062, 5260, 5329]
> > /dev/mmcblk1
> > [1567, 1581, 1585, 1603, 1769]
> >
> > 2. Timer workload (through IO for my convenience ;) )
> > Results in read IOPS, fio same as above.
> > echo "0 2097152 zero" | dmsetup create dm-zeros
> > echo "0 2097152 delay /dev/mapper/dm-zeros 0 50" | dmsetup create dm-sl=
ow
> > (Each IO is delayed by timer of 50ms, should be mostly in state2)
> >
> > teo fixed:
> > 3269 cpu_idle total
> > 48 cpu_idle_miss
> > 30 cpu_idle_miss above
> > 18 cpu_idle_miss below
> >
> > teo mainline:
> > 3221 cpu_idle total
> > 1269 cpu_idle_miss
> > 22 cpu_idle_miss above
> > 1247 cpu_idle_miss below
> >
> > menu:
> > 3433 cpu_idle total
> > 114 cpu_idle_miss
> > 61 cpu_idle_miss above
> > 53 cpu_idle_miss below
> >
> > Residencies:
>
> Hmm, maybe actually including them would've been helpful too:
> (Over 5s workload, only showing LITTLE cluster)
> teo fixed:
> idle_state
> 2.0     4.813378
> -1.0    0.210820

Just to clarify, what does -1.0 mean here?

> 1.0     0.202778
> 0.0     0.062426
>
> teo mainline:
> idle_state
> 1.0     4.895766
> -1.0    0.098063
> 0.0     0.253069
>
> menu:
> idle_state
> 2.0     4.528356
> -1.0    0.241486
> 1.0     0.345829
> 0.0     0.202505
>
> >
> > tldr: overall teo fixed spends more time in state2 while having
> > fewer idle_miss than menu.
> > teo mainline was just way too aggressive at selecting shallow states.
> >
> > 3. Hackbench, 5 runs
> > for i in $(seq 0 4); do hackbench -l 100 -g 100 ; sleep 1; done
> >
> > teo fixed:
> > Time: 4.807
> > Time: 4.856
> > Time: 5.072
> > Time: 4.934
> > Time: 4.962
> >
> > teo mainline:
> > Time: 4.945
> > Time: 5.021
> > Time: 4.927
> > Time: 4.923
> > Time: 5.137
> >
> > menu:
> > Time: 4.991
> > Time: 4.884
> > Time: 4.880
> > Time: 4.946
> > Time: 4.980
> >
> > tldr: all comparable, teo mainline slightly worse
> >
> > Kind Regards,
> > Christian
> >
> > Christian Loehle (6):
> >   cpuidle: teo: Increase util-threshold
> >   cpuidle: teo: Don't stop tick on utilized
> >   cpuidle: teo: Don't always stop tick on one state
> >   cpuidle: teo: Increase minimum time to stop tick
> >   cpuidle: teo: Remove recent intercepts metric
> >   cpuidle: teo: Don't count non-existent intercepts
> >
> >  drivers/cpuidle/governors/teo.c | 121 +++++++++++++-------------------
> >  1 file changed, 48 insertions(+), 73 deletions(-)
> >
> > --
> > 2.34.1
> >
>
>

