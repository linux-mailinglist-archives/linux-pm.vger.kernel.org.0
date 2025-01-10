Return-Path: <linux-pm+bounces-20241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D456A094DB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A4616A36B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C554211468;
	Fri, 10 Jan 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7D0DrE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C6D210F7A;
	Fri, 10 Jan 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522276; cv=none; b=kQeOeIm0cPBdlGN+xZjv6ic9OLGCgEEU2K3lxDciWPP03aetYDq2a9oKirHGiQ7D+8RrbQbCLYuYaZ1VkpiGD8s3PMKfLOmX4YhZPavZ2GnRKRHfXzzz7p+Kdk0jJD4F1H5vX6sJjlWnyTwOAvYvDR1JnbettJToxnMlz1Xu+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522276; c=relaxed/simple;
	bh=5umKel3ID8KbXJWCbxZbcN+ZW/fw7Lo1yK7DspHD1uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqBfLBv2pfOSq3I1gna0kBENdKcgGwC/gcMmkePrVqAV4/9h2wAGRgzWBWindJBKEBbicWG9NXRB8NQltP93fIE350KKyPsytGncsJ0clUJs+3temtBuoRETqgSYkLj8TOsc/msjz5jNyDwvjO6ATh8WYploFY1tZXRBkWIUr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7D0DrE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D4C4CEE6;
	Fri, 10 Jan 2025 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736522275;
	bh=5umKel3ID8KbXJWCbxZbcN+ZW/fw7Lo1yK7DspHD1uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U7D0DrE/AOV+YexVglpLxTDiLXPjONO9O8N/xzkPv0QC4Giw4usXymWaknKHY89JG
	 bXZAuOPyGkDyS25DMtqupJkKqGD1zAASQAtIK8NKydDgbqewiXXDkknPXSLli+SCGS
	 A5Gbv4de83wAmKstJbHEju5UfqJh35nFmjQIc2bomc6DqncxiMgFLrUEDrh4ab0JDa
	 XbUxcZWIK1DAjV1mOMeo/NHmLZ8AvA5DymftwY8bz78cgEoS5woYZhTNlvOEHqcwf4
	 wYN8PPZEd7PqQyW/5nrQ481ADjbeO3aDXjIjxTsPt4F1fkX1kGD4MTzY8DH3OmiaUg
	 W4wF0N8JfKsVg==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e3eb8d224so553162a34.2;
        Fri, 10 Jan 2025 07:17:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8/Fxc+j6tFI1eH5TpWulXUROwiPA6A8ONbqBVURARLJRUHZf+LCJAKpNAol1tbbWFMd5Gw5q7mbjFHks=@vger.kernel.org, AJvYcCWC1m3n7yeP0vob1R75NuXtxSGehaCnFXGK+PndIG/l81WFuuzD3GJnE0DGD6Gw8GveaFEwJCv+cRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQuasQM5EUZTmdBjaEsFhwmC9vC2YrilaAwYBl54DgaOIVHhD
	9Pzd3sISlbCUbBYCBPV487FfJ1SNZ7P1/YprcDC+aG+BdZa6hPtrBcd9Zp04hFELoHziAvkRxMK
	GwXDSb+sTQK+j08dqw2YZLHcm1C8=
X-Google-Smtp-Source: AGHT+IFWSzuyE7cQE5Uy7qEs6wsV9CLXmZ6cNhpnDheTglx1GrYjJ1/i5UqI0REYv8rf4MAaYG/UMwfrnyxFGoQ5fnM=
X-Received: by 2002:a05:6870:ef82:b0:29e:51ca:68b4 with SMTP id
 586e51a60fabf-2aa0674f4f8mr5668297fac.19.1736522274873; Fri, 10 Jan 2025
 07:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4953183.GXAFRqVoOG@rjwysocki.net> <13679187.uLZWGnKmhe@rjwysocki.net>
 <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com> <CAJZ5v0hKZP7b8G+FJrb2kTSo90YK75XUsukExPMGVqhoZsSU7A@mail.gmail.com>
 <c976eae7-56f8-4b7b-821a-1ec4291b21dd@arm.com>
In-Reply-To: <c976eae7-56f8-4b7b-821a-1ec4291b21dd@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Jan 2025 16:17:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iRoKvTLXrxJWNk8ooARQQ-ctPR8CjsOuQSEt7e5Ws33Q@mail.gmail.com>
X-Gm-Features: AbW1kvbpj5TWOzXVafD4AQ8CR5VRTQFjk-k4bf-88P0-MkiFRbmUnMojaqiCChk
Message-ID: <CAJZ5v0iRoKvTLXrxJWNk8ooARQQ-ctPR8CjsOuQSEt7e5Ws33Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early
 return path
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:52=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/10/25 13:34, Rafael J. Wysocki wrote:
> > On Fri, Jan 10, 2025 at 2:16=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 1/10/25 12:53, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> After commit 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_le=
ngth()
> >>> call in some cases") the teo governor behaves a bit differently on
> >>> systems where idle state 0 is a "polling" state (that is, it is not
> >>> really an idle state, but a loop continuously executed by the CPU).
> >>> Namely, on such systems it skips the tick_nohz_get_sleep_length() cal=
l
> >>> if the target residency of the current candidate idle state is small
> >>> enough.
> >>>
> >>> However, if state 0 itself was to be returned, it would be returned
> >>> right away without calling tick_nohz_get_sleep_length() even on syste=
ms
> >>> where it was not a "polling" state until commit 4b20b07ce72f ("cpuidl=
e:
> >>> teo: Don't count non-existent intercepts") that attempted to fix this
> >>> problem.
> >>>
> >>> Unfortunately, commit 4b20b07ce72f has made the governor always call
> >>> tick_nohz_get_sleep_length() when about to return state 0 early, even
> >>> if that state is a "polling" one, which is inconsistent and defeats
> >>> the purpose of commit 6da8f9ba5a87 in that case.
> >>>
> >>> Address this by adding a CPUIDLE_FLAG_POLLING check to the path where
> >>> state 0 is returned early to prevent tick_nohz_get_sleep_length() fro=
m
> >>> being called if it is a "polling" state.
> >>>
> >>> Fixes: 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercep=
ts")
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>  drivers/cpuidle/governors/teo.c |    3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> --- a/drivers/cpuidle/governors/teo.c
> >>> +++ b/drivers/cpuidle/governors/teo.c
> >>> @@ -422,7 +422,8 @@
> >>>                       first_suitable_idx =3D i;
> >>>               }
> >>>       }
> >>> -     if (!idx && prev_intercept_idx) {
> >>> +     if (!idx && prev_intercept_idx &&
> >>> +         !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
> >>>               /*
> >>>                * We have to query the sleep length here otherwise we =
don't
> >>>                * know after wakeup if our guess was correct.
> >>>
> >>>
> >>>
> >>
> >> But then you do run into the issue of intercepts not being detected if
> >> state0 is the right choice, don't you?
> >
> > That's true, but then on systems with a "polling" state 0 you still
> > have this problem if the state returned early is not state 0.  Say C1
> > on x86.>
> > The point here is that the behavior needs to be consistent, one way or =
another.
>
> Yes, gotcha. Why not be consistent 'in the other way' then?
>
> >
> > The exact point of commit 6da8f9ba5a87 was to avoid calling
> > tick_nohz_get_sleep_length() in some cases when the state to be
> > returned is shallow enough and obviously that includes a "polling"
> > state 0, possibly at the cost of being somewhat inaccurate in
> > prediction.
>
> Somewhat inaccurate meaning not making any prediction?
> cpu_data->sleep_length_ns =3D KTIME_MAX;

Yes, and the wakeup is going to be counted as an intercept which of
course may be inaccurate, but how inaccurate it really is depends on
the workload.  If the workload doesn't contain short timers, it
actually is as good as it gets.

> How much is the harm for calling tick_nohz_get_sleep_length() when
> polling anyway?

On x86, a lot, especially on systems with many cores.

This was the whole reason for doing commit 6da8f9ba5a87 in the first place.

> I know tick_nohz_get_sleep_length() is the majority of the usual
> cpuidle entry path, but for many scenarios where state0 is appropriate
> that should be pretty fast, no?

Not necessarily.

For single-digit exit latency idle states the
tick_nohz_get_sleep_length() evaluation time may exceed the state exit
latency and is comparable to the target residency, so calling it
pretty much doesn't make sense.

> >
> > Then you're seeing this intercept accumulation for state 0 when there
> > are only 2 states in the table (or all of the other states are much
> > higher target residency than state 0).
> >
> > Commit 4b20b07ce72f effectively caused tick_nohz_get_sleep_length() to
> > be called every time on systems without a "polling" state 0, which was
> > fair enough, but it also affected the other systems, which wasn't.
> >
> >> This would then enable intercept-detection only for <50% of the time,
> >> another option is to not allow intercepts selecting a polling state, b=
ut
> >> there were recent complaints about this exact behavior from Aboorva (+=
TO).
> >> They don't have a low-latency non-polling state.
> >>
> >> https://lore.kernel.org/lkml/20240809073120.250974-1-aboorvad@linux.ib=
m.com/
> >
> > If they don't have a "polling" state 0, they won't be affected by this
> > patch and after commit 4b20b07ce72f, they'll always call
> > tick_nohz_get_sleep_length(), so the current governor behavior is
> > generally unsuitable for them.
>
> They do though.
> commit 5ddcc03a07ae ("powerpc/cpuidle: Set CPUIDLE_FLAG_POLLING for snooz=
e state")
> So they have a polling 'snooze' and a relatively high latency (hundreds u=
secs)
> non-polling state and no deeper state.
>
> So if they don't query sleep length on snooze on a (1us)-interrupt-wakeup=
 heavy
> workload they will get 50% state0 and 50% state1 (because intercepts reco=
vered
> due to not querying sleep length).

Obviously.

OK, I guess I'll just do the other cleanups without this change to start wi=
th.

