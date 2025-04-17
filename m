Return-Path: <linux-pm+bounces-25671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C8A92B78
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 21:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404B216F747
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D11DEFEC;
	Thu, 17 Apr 2025 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+J4pIQM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496E189902;
	Thu, 17 Apr 2025 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916757; cv=none; b=lHcLEUhWqGj9lwdLXa7ENOWuLU+Rn29pzptZNQP770ETpAeeoYWCOB2ZQziK6fZHceTRNrjQ/arHrJ57FOXM7ZdbSwFIB+fymtItLumDg6wbXH5uYm7hxb1am/mTL2hdbxxN9X7G9ENEDtxJxv7J1SSOf5p0sp0OZyFh3MOCbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916757; c=relaxed/simple;
	bh=/BCjaY1lgSir+NBWUyZER/El8fVAEsfe5Vsl+nEQkUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbhtmrArCpxNb1tvsp5k33mz6ia9gCP1GEjKDguE81oJkQpwUSh8HBUTEDcjSDrCF4WJ+gkL9snOH+M514t0t4Gn6P5sMPEiwi0di9nn7sdpD6Y8OAfLeTWWbZMQoVvCe8T+vzw3sjaGXc16J4CdJC62/9AHWozCKB48xJ9VhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+J4pIQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117F8C4CEF1;
	Thu, 17 Apr 2025 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744916757;
	bh=/BCjaY1lgSir+NBWUyZER/El8fVAEsfe5Vsl+nEQkUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y+J4pIQMFTBaapaDGJvvBZeQZgzXbJ7F4NZLQ/j02VXO5KfqrN+O0qujcTgtx9/Hh
	 HYbQCoFD/r3FLmCkIw0Toj9FugS7q03XTgj8efITGkj7D8jgLJY08MeYDH0SFzT3Lq
	 5nzF2h5i+9YLhg9KJr78HhluuFE/jcqGuan+cRf5+NZdsOn5khFvZjlr/Ndth66prZ
	 30KLjZzbNRBTqwBbo+n45z7lcBsrgLXrCiEfmlMZAwfHJ7cBpMmAxrHDWLxaOZswtK
	 Yu9pjMr6hv7or1PLTm9DXnSF7pnLWO7DUVro2D7mV64Q217GiPHfBByyDEO9V60gy/
	 yJ4RQXwONRiKA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c2504fa876so322521fac.0;
        Thu, 17 Apr 2025 12:05:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCzx0GWMvSKJtaVZJpGgeo0bp44vtwrRXiz1j6B1W1RfHd2OiNpIzEjVfdhAv892Rp7M3o6rCCY8Z55I0=@vger.kernel.org, AJvYcCVWpITVOfmv0INM7nU2VMjCUsdArh9ZXzJuI8vgdbXXHm1wuYZbb/mbN4xizRBR8eT40l+M6DnCqDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwPvlNaqCk3znvGNlb90XwGbaePpojNTfk+E887a8eJ7N0k8q6
	G706EInnMbjJH7UyD3+KVa1ilD9VZ3NxbBiKVPkR7KWvqeI9Gm4epwYOmZJNUHMSXvmjbpPP/TQ
	iCWqPWUnEKOC78W1xOS+x9rSpHXk=
X-Google-Smtp-Source: AGHT+IF0MFZBYctxFNIVlnAm6Oxp5Mpyp7UeFm7NFC0Q0S5p9XpD9LVPSudh9x2WR+PcQBIMTDocgUbmEvHV76GoSzo=
X-Received: by 2002:a05:6870:704b:10b0:2d5:230f:b34d with SMTP id
 586e51a60fabf-2d526824aadmr55149fac.1.1744916756142; Thu, 17 Apr 2025
 12:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4661520.LvFx2qVVIh@rjwysocki.net> <2239639.irdbgypaU6@rjwysocki.net>
 <1c0c6caa-e56c-454a-a976-81303dee1852@arm.com> <CAJZ5v0g-=DB_W5jkxxCERy22jz9a_V1Tcj8hiVwL6_R+xSM=gQ@mail.gmail.com>
 <76d5c5ba-6be0-405b-83dd-038f016af12b@arm.com> <CAJZ5v0hVRg0P+E1Ux9tOkr+g6wF36Bf52UT4f3BEAePMUM85Lw@mail.gmail.com>
 <b4835a2d-d855-403f-b3c1-c169faa1a9b4@arm.com>
In-Reply-To: <b4835a2d-d855-403f-b3c1-c169faa1a9b4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 21:05:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgL66VY74LvHCyS_C4r9jtfSS6ao7up8gNVnT+w0e-sA@mail.gmail.com>
X-Gm-Features: ATxdqUEuN7U6o4Ha2jazlW1EcqG88N92rWqPbN6aLJmlKcVeYupCcd7l590Jsjg
Message-ID: <CAJZ5v0hgL66VY74LvHCyS_C4r9jtfSS6ao7up8gNVnT+w0e-sA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cpuidle: teo: Refine handling of short idle intervals
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Doug Smythies <dsmythies@telus.net>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 7:18=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/17/25 16:21, Rafael J. Wysocki wrote:
> > On Thu, Apr 17, 2025 at 1:58=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 4/16/25 16:28, Rafael J. Wysocki wrote:
> >>> On Wed, Apr 16, 2025 at 5:00=E2=80=AFPM Christian Loehle
> >>> <christian.loehle@arm.com> wrote:
> >>>>
> >>>> On 4/3/25 20:18, Rafael J. Wysocki wrote:
> >>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>
> >>>>> Make teo take all recent wakeups (both timer and non-timer) into
> >>>>> account when looking for a new candidate idle state in the cases
> >>>>> when the majority of recent idle intervals are within the
> >>>>> LATENCY_THRESHOLD_NS range or the latency limit is within the
> >>>>> LATENCY_THRESHOLD_NS range.
> >>>>>
> >>>>> Since the tick_nohz_get_sleep_length() invocation is likely to be
> >>>>> skipped in those cases, timer wakeups should arguably be taken into
> >>>>> account somehow in case they are significant while the current code
> >>>>> mostly looks at non-timer wakeups under the assumption that frequen=
t
> >>>>> timer wakeups are unlikely in the given idle duration range which
> >>>>> may or may not be accurate.
> >>>>>
> >>>>> The most natural way to do that is to add the "hits" metric to the
> >>>>> sums used during the new candidate idle state lookup which effectiv=
ely
> >>>>> means the above.
> >>>>>
> >>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> Hi Rafael,
> >>>> I might be missing something so bare with me.
> >>>> Quoting the cover-letter too:
> >>>> "In those cases, timer wakeups are not taken into account when they =
are
> >>>> within the LATENCY_THRESHOLD_NS range and the idle state selection m=
ay
> >>>> be based entirely on non-timer wakeups which may be rare.  This caus=
es
> >>>> the prediction accuracy to be low and too much energy may be used as
> >>>> a result.
> >>>>
> >>>> The first patch is preparatory and it is not expected to make any
> >>>> functional difference.
> >>>>
> >>>> The second patch causes teo to take timer wakeups into account if it
> >>>> is about to skip the tick_nohz_get_sleep_length() invocation, so the=
y
> >>>> get a chance to influence the idle state selection."
> >>>>
> >>>> If the timer wakeups are < LATENCY_THRESHOLD_NS we will not do
> >>>>
> >>>> cpu_data->sleep_length_ns =3D tick_nohz_get_sleep_length(&delta_tick=
);
> >>>>
> >>>> but
> >>>>
> >>>> cpu_data->sleep_length_ns =3D KTIME_MAX;
> >>>>
> >>>> therefore
> >>>> idx_timer =3D drv->state_count - 1
> >>>> idx_duration =3D some state with residency < LATENCY_THRESHOLD_NS
> >>>>
> >>>> For any reasonable system therefore idx_timer !=3D idx_duration
> >>>> (i.e. there's an idle state deeper than LATENCY_THRESHOLD_NS).
> >>>> So hits will never be incremented?
> >>>
> >>> Why never?
> >>>
> >>> First of all, you need to get into the "2 * cpu_data->short_idles >=
=3D
> >>> cpu_data->total" case somehow and this may be through timer wakeups.
> >>
> >> Okay, maybe I had a too static scenario in mind here.
> >> Let me think it through one more time.
> >
> > Well, this is subtle and your question is actually a good one.
> >
> >>>
> >>>> How would adding hits then help this case?
> >>>
> >>> They may be dominant when this condition triggers for the first time.
> >>
> >> I see.
> >>
> >> Anything in particular this would help a lot with?
> >
> > So I've been trying to reproduce my own results using essentially the
> > linux-next branch of mine (6.15-rc2 with some material on top) as the
> > baseline and so far I've been unable to do that.  There's no
> > significant difference from these patches or at least they don't help
> > as much as I thought they would.
> >
> >> There's no noticeable behavior change in my usual tests, which is
> >> expected, given we have only WFI in LATENCY_THRESHOLD_NS.
> >>
> >> I did fake a WFI2 with residency=3D5 latency=3D1, teo-m is mainline, t=
eo
> >> is with series applied:
> >>
> >> device   gov    iter   iops    idles     idle_misses  idle_miss_ratio =
 belows   aboves   WFI       WFI2
> >> -------  -----  -----  ------  --------  ------------  ---------------=
-  --------  -------  --------  --------
> >> nvme0n1  teo    0      80223   8601862   1079609       0.126          =
   918363    161246   205096    4080894
> >> nvme0n1  teo    1      78522   8488322   1054171       0.124          =
   890420    163751   208664    4020130
> >> nvme0n1  teo    2      77901   8375258   1031275       0.123          =
   878083    153192   194500    3977655
> >> nvme0n1  teo    3      77517   8344681   1023423       0.123          =
   869548    153875   195262    3961675
> >> nvme0n1  teo    4      77934   8356760   1027556       0.123          =
   876438    151118   191848    3971578
> >> nvme0n1  teo    5      77864   8371566   1033686       0.123          =
   877745    155941   197903    3972844
> >> nvme0n1  teo    6      78057   8417326   1040512       0.124          =
   881420    159092   201922    3991785
> >> nvme0n1  teo    7      78214   8490292   1050379       0.124          =
   884528    165851   210860    4019102
> >> nvme0n1  teo    8      78100   8357664   1034487       0.124          =
   882781    151706   192728    3971505
> >> nvme0n1  teo    9      76895   8316098   1014695       0.122          =
   861950    152745   193680    3948573
> >> nvme0n1  teo-m  0      76729   8261670   1032158       0.125          =
   845247    186911   237147    3877992
> >> nvme0n1  teo-m  1      77763   8344526   1053266       0.126          =
   867094    186172   237526    3919320
> >> nvme0n1  teo-m  2      76717   8285070   1034706       0.125          =
   848385    186321   236956    3889534
> >> nvme0n1  teo-m  3      76920   8270834   1030223       0.125          =
   847490    182733   232081    3887525
> >> nvme0n1  teo-m  4      77198   8329578   1044724       0.125          =
   855438    189286   240947    3908194
> >> nvme0n1  teo-m  5      77361   8338772   1046903       0.126          =
   857291    189612   241577    3912576
> >> nvme0n1  teo-m  6      76827   8346204   1037520       0.124          =
   846008    191512   243167    3914194
> >> nvme0n1  teo-m  7      77931   8367212   1053337       0.126          =
   866549    186788   237852    3930510
> >> nvme0n1  teo-m  8      77870   8358306   1056011       0.126          =
   867167    188844   240602    3923417
> >> nvme0n1  teo-m  9      77405   8338356   1046012       0.125          =
   856605    189407   240694    3913012
> >>
> >> The difference is small, but it's there even though this isn't
> >> a timer-heavy workload at all.
> >
> > This is interesting, so thanks for doing it, but the goal really was
> > to help with the polling state usage on x86 and that doesn't appear to
> > be happening, so I'm going to drop these patches at least for now.
>
> Alright, well my testing on x86 is limited, but I assume you are
> referring to systems were we do have
> state0 latency=3D0 residency=3D0 polling
> state1 latency=3D1 residency=3D1
> in theory teo shouldn't be super aggressive on state0 then with the
> intercept logic, unless the idle durations are recorded as <1us.
> I wonder what goes wrong, any traces or workloads you recommend looking
> at?

I've observed state0 being selected too often and being too shallow
90% or so of the time.

I don't have anything showing this specifically in a dramatic fashion
and yes, state1 is usually selected much more often than state0.

