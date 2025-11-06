Return-Path: <linux-pm+bounces-37564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D989C3D5DA
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 21:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A1FF4E31A8
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 20:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35CC2BCF75;
	Thu,  6 Nov 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijEBfZXW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B8302CB9
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461215; cv=none; b=WE73bUxTvL+zE7A/dMERfWHcLF9SOxqvoF2Ns2y3bpmFbLM5tVJnGRNArh3QktvIcxPafCgPrTlSiz5y87Qpr/lopYmoIXceDkWw3bxHlvTvhNOQQBYm3r070WnDtbmpWykScHQTdBf5OV7pR70CqXlwQXdKa8rcid9MTxjjKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461215; c=relaxed/simple;
	bh=CJ2dYk5PvD62IstMYlqDa53vApAeh8kL4W1u9kFZg8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meHMCFGuCaHsttVd+yGXETlhWDAKgb8QWRX9xMJpKnIAWlIlaUmv8eovRJPd6PkmYTOofuzxYEC597K4KnfvF9RGE1zWLgA8TC3TQUv4p4NZtQJ7wxalDOX/B1bjN5ouoydt8k6IJyNLul7FMOjocTKHihZzXvuvkR8Qkzmkkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijEBfZXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BD2C4CEF7
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762461215;
	bh=CJ2dYk5PvD62IstMYlqDa53vApAeh8kL4W1u9kFZg8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ijEBfZXW4MzUjRZQmMLdO1OkCgVbBHnaCyGAveBuSX7jMKhj3WDFqqLzy/sx7cqlS
	 u2xf0+MCsuI/zOInzedRr9++rRJ5fl+lhM6VSg5DOq/LrD5w0eRxJ8vVFalsc3W2id
	 F14SW5DO+ZJTQD1O9HqMfWW/V5Qily4/tnwy5ONGDtHRVKEq98mUx0lv18a5H56jFd
	 u7PqPTNkPA64//TuiMvK21eMRxiywxBCEELXiEN16t5HnozNlUZ1GDw/QzriN2yknt
	 WubG3Ib/CIcYyiLKVaWhKenk27GKDb06q2qGhrBhCNexxox21bkBvk0mgikjt6XyRI
	 KxBfv92KhGa1Q==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-656c665749bso18270eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 12:33:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd4YJ9Hjez6MA33Y8ovqJVLkQ05vBs95sghLIXCSDfqvb9okG350mGjceJgYAsi3n5tIQt5l53iA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEc/Y01CRG3fg2Xga5IEr95QxAZlEnicWRDkgtCcdQrYLcaoaV
	VZnQS9tpU/QnAGpHYQI1KZnhUnPtUiqaVuezkHhkyo5ET35y7jbMkl72OdwIToMhYVrYR0+9fHJ
	mJa7//HMckNHYW4OHKlFQMmLkRT6ghK8=
X-Google-Smtp-Source: AGHT+IFM9vcoXtFCIi2ide7DNVP2Jw7aPwj2TzZlkBnMZRuPAizLWg3H28HZR53lWwbsLg2JF1H1XIX8VwjOyTzG76A=
X-Received: by 2002:a05:6808:1b12:b0:44f:f747:f9f with SMTP id
 5614622812f47-45015ee5347mr446090b6e.36.1762461214427; Thu, 06 Nov 2025
 12:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com> <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com> <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com>
In-Reply-To: <b910a35c-83aa-4050-9c6c-de40f13a2a55@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Nov 2025 21:33:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
X-Gm-Features: AWmQ_bnj7_rmiHIL_VMin9RGc8EAf5P2nm6FP6tIkuOhEQ_iNmpuIbLYYpdSrE8
Message-ID: <CAJZ5v0h6qAgWkEad5OGM-V-HOE-1PwD_XqgsDWbnJNxLWOKDfA@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:13=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/5/25 20:48, Rafael J. Wysocki wrote:
> > On Wed, Nov 5, 2025 at 12:24=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/4/25 09:03, Christian Loehle wrote:
> >>> On 11/4/25 03:36, Reka Norman wrote:
> >>>> Hi,
> >>>>
> >>>> I=E2=80=99m seeing a regression in the TEO governor between 6.6 and =
6.12. At
> >>>> 6.12, when the system is idle it=E2=80=99s spending almost 100% of t=
ime in
> >>>> WFI, compared to about 6% at 6.6. At mainline it has improved compar=
ed
> >>>> to 6.12 but is still a lot worse than 6.6, spending about 50% in WFI=
.
> >>>>
> >>>> The system is a ChromeOS device with Mediatek MT8196.
> >>>>
> >>>> Bisecting showed the specific commit which caused the regression is:
> >>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> >>>>
> >>>> I=E2=80=99ve attached sysfs dumps showing the issue. All were taken =
a couple
> >>>> of minutes after boot, with the device having been idle since boot.
> >>>> The cases tested are:
> >>>> cpuidle_6_6.txt      =3D 6.6 kernel
> >>>> cpuidle_6_12.txt     =3D 6.6 kernel with teo commits up to 6.12
> >>>> cpuidle_mainline.txt =3D 6.6 kernel with teo commits up to mainline
> >>>>
> >>>> Summary of the percentage time spent in each state (averaged across =
CPUs):
> >>>>
> >>>> |            |   6.6 |  6.12 | mainline |
> >>>> |------------|------:|------:|---------:|
> >>>> | WFI        |  6.02 | 99.94 |    56.84 |
> >>>> | cpuoff     | 11.02 |     0 |     0.65 |
> >>>> | clusteroff | 82.96 |  0.05 |    42.51 |
> >>>> | s2idle     |     0 |     0 |        0 |
> >>>>
> >>>> Any help would be much appreciated. Let me know if there's any other
> >>>> debugging information I should provide.
> >>>>
> >>>
> >>> That's not good.
> >>> If the system is mostly idle (only boot activity but dumps are taken =
after
> >>> ~3mins?), what is causing the wakeups? Even in 6.6 There are definite=
ly more
> >>> than I would've expected?
> >>> I noticed that clusteroff and cpuoff have equal residency, which is
> >>> obviously a bit awkward for cpuidle, but shouldn't be relevant to you=
r issue.
> >>>
> >>> I'm a bit puzzled by your bisect results.
> >>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> >>> made the intercept logic *less* prone to count (false) intercepts, ye=
t it
> >>> seems to count more of them? (resulting in more WFI).
> >>> I'll think about it some more, for now of course a trace would be ver=
y
> >>> helpful. (cpuidle events, ipi_raise, irqs?)
> >>> Are there ever any latency constraints set?
> >>>
> >>> FWIW the mainline results look the most reasonable, from a 30000 feet=
 view
> >>> anyway:
> >>> Cluster       State           above   below   usage   above%  below%
> >>> LITTLE        cpuoff-l        ~75     ~65     ~140    23%     20%
> >>> LITTLE        clusteroff-l    ~800    0       ~100    89%     0%
> >>> MID   cpuoff-m        ~3=E2=80=934    ~15     ~20     15%     55%
> >>> MID   clusteroff-m    ~1300   0       ~4000   24%     0%
> >>> BIG   cpuoff-b        0       1       1       =E2=80=94       =E2=80=
=94
> >>> BIG   clusteroff-b    ~800    0       ~1900   30%     0%
> >>>
> >>> (WFI seems mostly the correct choice for little CPUs, that's fine, th=
e energy
> >>> savings compared to cpuoff should be marginal anyway.)
> >>>
> >>> Do you mind trying:
> >>> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeups a=
re very frequent
> >>> on 6.12?
> >>>
> >>
> >> So just thinking out loud, the only case I can actually thing of to ex=
plain your
> >> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent interc=
epts")
> >> is that the workload essentially changed dramatically because of our c=
alls
> >> to tick_nohz_get_sleep_length() now.
> >> I'm not sure how likely I think that is, but I'm lacking imagination f=
or another
> >> cause. That's why results with
> >> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups =
are very frequent")
> >> would be interesting.
> >
> > My current theory is that this issue is related to the
> > tick_nohz_get_sleep_length() overhead and the way "intercepts" are
> > distinguished from "hits" in teo.
> >
> > Namely, teo assumes that its own overhead is negligible and so it
> > counts a given event as an "intercept" if the measured time spent in
> > the idle state (with the exit latency roughly taken into account)
> > falls into a different "state bin" than the sleep length (the expected
> > time till the next timer).  However, the sleep length is computed as a
> > difference between the upcoming timer wakeup event time and
> > ts->idle_entrytime, so it actually includes the time taken by
> > tick_nohz_next_event().  If the latter is significant, it may
> > contribute to the difference seen by teo_update() and cause extra
> > "intercepts" to appear.
>
> Right, additionally with psci pc-mode and the exposed clusteroff states w=
e end
> up vastly exaggerating the wakeup latency (i.e. underestimating the actua=
l idle time)
> for three reasons:
> - wakeup latency =3D entry+exit latency (worst case: pay full latencies o=
n both
> even though for most cases we don't incur the entry latency)
> - Wakeup latency is a worst-case and often is more like 2x-3x of the aver=
age.
> - We use the (higher) clusteroff values even though the clusteroff state =
couldn't
> possibly have been entered as not the entire cluster is idle.
>
> Nonetheless these are all just a "intercept counting is significantly mor=
e likely"
> while the results show not a single state >0 entered =3D> the intercept l=
ogic
> probably triggers every cpuidle entry.

It has to for this to happen, if timers are not frequent enough.

> Feels like there should be an issue in the feedback loop.

I'm wondering what the issue could be though.  The change in commit
4b20b07ce72f only affects the cases when idle state 0 is about to be
selected and it only really changes the sleep length value from
KTIME_MAX to something more realistic (but it still may be KTIME_MAX).

It may turn an "intercept" into a "hit", but only if the CPU is not
woken up by the tick because those cases had been already counted as
"hits" before commit 4b20b07ce72f.

Now, if the majority of wakeups in the workload are tick wakeups, the
only real difference appears to be the presence of
tick_nohz_get_sleep_length() in that code path.

Frankly, I would try to remove the update of cpu_data->sleep_length_ns
right before the "goto out_tick" statement (in 6.12 that should be
line 426) and see what happens.

> Anyway I'll try to reproduce what Reka is seeing.

That would help too, of course.

