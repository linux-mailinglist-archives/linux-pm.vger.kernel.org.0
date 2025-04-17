Return-Path: <linux-pm+bounces-25647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C5A92152
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 17:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00798A20C1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88218253928;
	Thu, 17 Apr 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipTGDybS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC37253326;
	Thu, 17 Apr 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903315; cv=none; b=o8doAoImcynKSMpxjJOzJcfaMFg7jQAdkm7ZiDIjHvaZE0c9ETUmx4A+l2W32biGWDd4Vezxx2KYUYo5B3C37MPAanHK1dBmm0VfCrJiiDF9AskU8MIiQfwxSkiQTcfbzSk2UEcEE7e/KsABoE1FneQtEatpt3Nd8hWDN+arU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903315; c=relaxed/simple;
	bh=CJchBNw/TCUjkOAoUrHlrUI9IZCdv307P1cHqFnK9ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpXUoJw2VQc/NGoc8wqbxd7QAd1sVM7gx6MnCwAtEBEvgeWvBPCwoQ6L6PVdr+1JcMyOn4vkkwHtwKeEzsirGOi1Tk6YLwPEbxYLDxg0wCUyYJLBr22cY98kc733hbu+5l0arXuBkZcR2I0GYt6uFVWB1WlnSKNLuoi7Xa7YjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipTGDybS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D22C4CEEC;
	Thu, 17 Apr 2025 15:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903314;
	bh=CJchBNw/TCUjkOAoUrHlrUI9IZCdv307P1cHqFnK9ZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ipTGDybSxj2xZqd2ri+kW9corAb2jL5VjBKQ1l5cq8p+BP8JMODq3GpidPZwGAIwW
	 M5Ch+WUTRWRS1NMhOICYBHh8S+u7hhAf9mLn4TeWIs+V3BohCqVL4kLWRa2M444mOE
	 Gc6wqRYA8t3e4lxHdw6iGD9SUEAGgAIuQOYgAoG3bYWc1XTmGm9haFj7EKY1fxDC/s
	 kcKtLYgLvCJGSvovYjTf1pNEnoGLUzTNiVCd5vgwUcK2oWVbyc26PDrOwIWElkwjf8
	 wrso0XDd/sKijGArX+KIMEuN4+sjos/tbpxLkn2O3KP5NA5CpELl7PyvISb6+LrcPl
	 6Mu5IpftZhKlw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2d4f832069bso354771fac.3;
        Thu, 17 Apr 2025 08:21:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJFrv2BDYIMuC5roBMb51r3grUflhYCD41sTyup7Y5IAY2BAOJgq1cJRJ/J42slJ7ixJ+sIPpnEcUxHx0=@vger.kernel.org, AJvYcCWUs9g+82MHeH8UrceJjifsK8wVsp0939K7Br2eknYmEUEMumk5xuLdCXSxe1lzuN/P6Nl9Aez4elk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVW8mURVrkaQKsPjWsW4zLct9Ux8OPY4kej77ibHGFXR1XzV8U
	ji/bmmSwLZ+pkqDXna3J3ZHLx+lATNJCJT3kLG1zkqSp51PGvxI0MCl+xVSraap7yeIaA47Ozgi
	wd8Bpy2gLRKhT91Gxvjjx3W9WvQU=
X-Google-Smtp-Source: AGHT+IHeb+g2g9s+QuPf/9r+zAo9BJ+HF3XcrAzHYaM47XkbjdOZ0AKG2xPGndtO56+/wHMoTDLrzEMh4h+ee+bCepk=
X-Received: by 2002:a05:6871:689:b0:2b7:f8d9:d5f7 with SMTP id
 586e51a60fabf-2d4d2b7a43emr3753500fac.19.1744903314033; Thu, 17 Apr 2025
 08:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4661520.LvFx2qVVIh@rjwysocki.net> <2239639.irdbgypaU6@rjwysocki.net>
 <1c0c6caa-e56c-454a-a976-81303dee1852@arm.com> <CAJZ5v0g-=DB_W5jkxxCERy22jz9a_V1Tcj8hiVwL6_R+xSM=gQ@mail.gmail.com>
 <76d5c5ba-6be0-405b-83dd-038f016af12b@arm.com>
In-Reply-To: <76d5c5ba-6be0-405b-83dd-038f016af12b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 17:21:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVRg0P+E1Ux9tOkr+g6wF36Bf52UT4f3BEAePMUM85Lw@mail.gmail.com>
X-Gm-Features: ATxdqUFi105tbnPrAaOWWVsIfFP_B1hAt3lu6Densv5_JVrdiTnEk84bDvay7v0
Message-ID: <CAJZ5v0hVRg0P+E1Ux9tOkr+g6wF36Bf52UT4f3BEAePMUM85Lw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpuidle: teo: Refine handling of short idle intervals
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Doug Smythies <dsmythies@telus.net>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 1:58=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/16/25 16:28, Rafael J. Wysocki wrote:
> > On Wed, Apr 16, 2025 at 5:00=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 4/3/25 20:18, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Make teo take all recent wakeups (both timer and non-timer) into
> >>> account when looking for a new candidate idle state in the cases
> >>> when the majority of recent idle intervals are within the
> >>> LATENCY_THRESHOLD_NS range or the latency limit is within the
> >>> LATENCY_THRESHOLD_NS range.
> >>>
> >>> Since the tick_nohz_get_sleep_length() invocation is likely to be
> >>> skipped in those cases, timer wakeups should arguably be taken into
> >>> account somehow in case they are significant while the current code
> >>> mostly looks at non-timer wakeups under the assumption that frequent
> >>> timer wakeups are unlikely in the given idle duration range which
> >>> may or may not be accurate.
> >>>
> >>> The most natural way to do that is to add the "hits" metric to the
> >>> sums used during the new candidate idle state lookup which effectivel=
y
> >>> means the above.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Hi Rafael,
> >> I might be missing something so bare with me.
> >> Quoting the cover-letter too:
> >> "In those cases, timer wakeups are not taken into account when they ar=
e
> >> within the LATENCY_THRESHOLD_NS range and the idle state selection may
> >> be based entirely on non-timer wakeups which may be rare.  This causes
> >> the prediction accuracy to be low and too much energy may be used as
> >> a result.
> >>
> >> The first patch is preparatory and it is not expected to make any
> >> functional difference.
> >>
> >> The second patch causes teo to take timer wakeups into account if it
> >> is about to skip the tick_nohz_get_sleep_length() invocation, so they
> >> get a chance to influence the idle state selection."
> >>
> >> If the timer wakeups are < LATENCY_THRESHOLD_NS we will not do
> >>
> >> cpu_data->sleep_length_ns =3D tick_nohz_get_sleep_length(&delta_tick);
> >>
> >> but
> >>
> >> cpu_data->sleep_length_ns =3D KTIME_MAX;
> >>
> >> therefore
> >> idx_timer =3D drv->state_count - 1
> >> idx_duration =3D some state with residency < LATENCY_THRESHOLD_NS
> >>
> >> For any reasonable system therefore idx_timer !=3D idx_duration
> >> (i.e. there's an idle state deeper than LATENCY_THRESHOLD_NS).
> >> So hits will never be incremented?
> >
> > Why never?
> >
> > First of all, you need to get into the "2 * cpu_data->short_idles >=3D
> > cpu_data->total" case somehow and this may be through timer wakeups.
>
> Okay, maybe I had a too static scenario in mind here.
> Let me think it through one more time.

Well, this is subtle and your question is actually a good one.

> >
> >> How would adding hits then help this case?
> >
> > They may be dominant when this condition triggers for the first time.
>
> I see.
>
> Anything in particular this would help a lot with?

So I've been trying to reproduce my own results using essentially the
linux-next branch of mine (6.15-rc2 with some material on top) as the
baseline and so far I've been unable to do that.  There's no
significant difference from these patches or at least they don't help
as much as I thought they would.

> There's no noticeable behavior change in my usual tests, which is
> expected, given we have only WFI in LATENCY_THRESHOLD_NS.
>
> I did fake a WFI2 with residency=3D5 latency=3D1, teo-m is mainline, teo
> is with series applied:
>
> device   gov    iter   iops    idles     idle_misses  idle_miss_ratio  be=
lows   aboves   WFI       WFI2
> -------  -----  -----  ------  --------  ------------  ----------------  =
--------  -------  --------  --------
> nvme0n1  teo    0      80223   8601862   1079609       0.126             =
918363    161246   205096    4080894
> nvme0n1  teo    1      78522   8488322   1054171       0.124             =
890420    163751   208664    4020130
> nvme0n1  teo    2      77901   8375258   1031275       0.123             =
878083    153192   194500    3977655
> nvme0n1  teo    3      77517   8344681   1023423       0.123             =
869548    153875   195262    3961675
> nvme0n1  teo    4      77934   8356760   1027556       0.123             =
876438    151118   191848    3971578
> nvme0n1  teo    5      77864   8371566   1033686       0.123             =
877745    155941   197903    3972844
> nvme0n1  teo    6      78057   8417326   1040512       0.124             =
881420    159092   201922    3991785
> nvme0n1  teo    7      78214   8490292   1050379       0.124             =
884528    165851   210860    4019102
> nvme0n1  teo    8      78100   8357664   1034487       0.124             =
882781    151706   192728    3971505
> nvme0n1  teo    9      76895   8316098   1014695       0.122             =
861950    152745   193680    3948573
> nvme0n1  teo-m  0      76729   8261670   1032158       0.125             =
845247    186911   237147    3877992
> nvme0n1  teo-m  1      77763   8344526   1053266       0.126             =
867094    186172   237526    3919320
> nvme0n1  teo-m  2      76717   8285070   1034706       0.125             =
848385    186321   236956    3889534
> nvme0n1  teo-m  3      76920   8270834   1030223       0.125             =
847490    182733   232081    3887525
> nvme0n1  teo-m  4      77198   8329578   1044724       0.125             =
855438    189286   240947    3908194
> nvme0n1  teo-m  5      77361   8338772   1046903       0.126             =
857291    189612   241577    3912576
> nvme0n1  teo-m  6      76827   8346204   1037520       0.124             =
846008    191512   243167    3914194
> nvme0n1  teo-m  7      77931   8367212   1053337       0.126             =
866549    186788   237852    3930510
> nvme0n1  teo-m  8      77870   8358306   1056011       0.126             =
867167    188844   240602    3923417
> nvme0n1  teo-m  9      77405   8338356   1046012       0.125             =
856605    189407   240694    3913012
>
> The difference is small, but it's there even though this isn't
> a timer-heavy workload at all.

This is interesting, so thanks for doing it, but the goal really was
to help with the polling state usage on x86 and that doesn't appear to
be happening, so I'm going to drop these patches at least for now.

