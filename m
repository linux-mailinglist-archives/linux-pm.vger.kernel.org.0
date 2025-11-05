Return-Path: <linux-pm+bounces-37480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E86C37C79
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1534F564
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD1E2D4B71;
	Wed,  5 Nov 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMpa0q86"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F02D3EE3
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375695; cv=none; b=pAujonn7yTtMSxO+cVjLpK9TynIg1jNNjIvxVXGzcVB00p781al3Dz1/ZBlsducAQa1KLCZlHwJiu4e6SdgVJJWWtV5Uzw/FVM+25FDCwa8wfl1D6N3OOxwcI9gJBeeSiQCVX2pU1A0PZ8hXJ1ImV/AG11BEu+CLQg7MpvzJ0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375695; c=relaxed/simple;
	bh=JTg+bvRiNn5UFdTygaB109vTbehpdMctAz277/oudVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2G4LKdU8qeXCDIorK2Q3VkAFRQk/+5SHiIocsoMcsLXEVd+LmWKEJ3k6mCDvj/cEB6yMucpmIvsQWzl+77OCaH1+zDmV93NvWY18BjcikANdCQutHym3/vAnZQCN0x3rOC3LzWdWTJqQMTKygqAYKFlz+oLSBPLX9vMv9DM/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMpa0q86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5731C116D0
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762375694;
	bh=JTg+bvRiNn5UFdTygaB109vTbehpdMctAz277/oudVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BMpa0q869YETfxcZU22s+JKyrIH0G/rcGe2js31PwkhgQZuipUHj2iP5M/ZIfvvOG
	 wliDDMqHS/Qg4soYF9zp1VSmtOvi+22Mn9+Y6FCRWBAzyt41CWZUwCeJwD03Q5gmUc
	 ddtHTZ9EjiRm6TVK/lfBb+H1xmfmYvpcTNNb1pelE658Hx0ld9UzYPdeGb0euq0WMB
	 fE646ToX+RW1uSJRoB+Bc7GrZYilmPU6SI0aZ0gBY5SWXU2Ma6wRxKTYAgP2u8MLVC
	 2WdKZS84LapmILR9bi5eZ6L7N7p9DA8ZUn14Uid1eW/pmzkESyI4ddRm554Z3H2a/Q
	 CoZk8FWZ335Qg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6504c33afb1so130003eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 12:48:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAkVDaj38qKYVcKplAdkrGWCVo0sWnQs11CvbwCPoj4ieaC3MFNc7cLWcVzrnW87s4XneSe8LXeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1VtJKvofZjDH7di2qvDPGA4KkNw2vn5NENr+Et8BG3iLjw/B
	7TXjh1b3BCvXWWf6OL4PLRohNQK1Wh/4x5XWVr/8PMWLnTg8pZAhZj6na/E3PdEIh/tl2LVugqg
	nTgT5x5D+/3ToKUIuhCZHmDF8bR9v0tk=
X-Google-Smtp-Source: AGHT+IGTF0w/KUSIJrwMfiUpRJMd9hORSn2HDMxoBKX227bqy0ph3H0jWas3aeRyqGLR2+TMmIokwt7+VKWuKyhE+mI=
X-Received: by 2002:a05:6820:22a6:b0:61e:16d0:9ea2 with SMTP id
 006d021491bc7-656c48942e3mr414366eaf.3.1762375694106; Wed, 05 Nov 2025
 12:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com> <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
In-Reply-To: <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Nov 2025 21:48:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
X-Gm-Features: AWmQ_bkGhWkVOXmMVDDhnCwrmB6uRYE2Py3ShZxZlrbZm3odvkgKRGirfpJSNkc
Message-ID: <CAJZ5v0g9Jndez5y5i4pPW1C+qfj=4iiu51HV7Eb1dBGd1jg-CA@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>
Cc: Reka Norman <rekanorman@chromium.org>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:24=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/4/25 09:03, Christian Loehle wrote:
> > On 11/4/25 03:36, Reka Norman wrote:
> >> Hi,
> >>
> >> I=E2=80=99m seeing a regression in the TEO governor between 6.6 and 6.=
12. At
> >> 6.12, when the system is idle it=E2=80=99s spending almost 100% of tim=
e in
> >> WFI, compared to about 6% at 6.6. At mainline it has improved compared
> >> to 6.12 but is still a lot worse than 6.6, spending about 50% in WFI.
> >>
> >> The system is a ChromeOS device with Mediatek MT8196.
> >>
> >> Bisecting showed the specific commit which caused the regression is:
> >> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> >>
> >> I=E2=80=99ve attached sysfs dumps showing the issue. All were taken a =
couple
> >> of minutes after boot, with the device having been idle since boot.
> >> The cases tested are:
> >> cpuidle_6_6.txt      =3D 6.6 kernel
> >> cpuidle_6_12.txt     =3D 6.6 kernel with teo commits up to 6.12
> >> cpuidle_mainline.txt =3D 6.6 kernel with teo commits up to mainline
> >>
> >> Summary of the percentage time spent in each state (averaged across CP=
Us):
> >>
> >> |            |   6.6 |  6.12 | mainline |
> >> |------------|------:|------:|---------:|
> >> | WFI        |  6.02 | 99.94 |    56.84 |
> >> | cpuoff     | 11.02 |     0 |     0.65 |
> >> | clusteroff | 82.96 |  0.05 |    42.51 |
> >> | s2idle     |     0 |     0 |        0 |
> >>
> >> Any help would be much appreciated. Let me know if there's any other
> >> debugging information I should provide.
> >>
> >
> > That's not good.
> > If the system is mostly idle (only boot activity but dumps are taken af=
ter
> > ~3mins?), what is causing the wakeups? Even in 6.6 There are definitely=
 more
> > than I would've expected?
> > I noticed that clusteroff and cpuoff have equal residency, which is
> > obviously a bit awkward for cpuidle, but shouldn't be relevant to your =
issue.
> >
> > I'm a bit puzzled by your bisect results.
> > 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> > made the intercept logic *less* prone to count (false) intercepts, yet =
it
> > seems to count more of them? (resulting in more WFI).
> > I'll think about it some more, for now of course a trace would be very
> > helpful. (cpuidle events, ipi_raise, irqs?)
> > Are there ever any latency constraints set?
> >
> > FWIW the mainline results look the most reasonable, from a 30000 feet v=
iew
> > anyway:
> > Cluster       State           above   below   usage   above%  below%
> > LITTLE        cpuoff-l        ~75     ~65     ~140    23%     20%
> > LITTLE        clusteroff-l    ~800    0       ~100    89%     0%
> > MID   cpuoff-m        ~3=E2=80=934    ~15     ~20     15%     55%
> > MID   clusteroff-m    ~1300   0       ~4000   24%     0%
> > BIG   cpuoff-b        0       1       1       =E2=80=94       =E2=80=94
> > BIG   clusteroff-b    ~800    0       ~1900   30%     0%
> >
> > (WFI seems mostly the correct choice for little CPUs, that's fine, the =
energy
> > savings compared to cpuoff should be marginal anyway.)
> >
> > Do you mind trying:
> > 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeups are=
 very frequent
> > on 6.12?
> >
>
> So just thinking out loud, the only case I can actually thing of to expla=
in your
> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercept=
s")
> is that the workload essentially changed dramatically because of our call=
s
> to tick_nohz_get_sleep_length() now.
> I'm not sure how likely I think that is, but I'm lacking imagination for =
another
> cause. That's why results with
> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups are=
 very frequent")
> would be interesting.

My current theory is that this issue is related to the
tick_nohz_get_sleep_length() overhead and the way "intercepts" are
distinguished from "hits" in teo.

Namely, teo assumes that its own overhead is negligible and so it
counts a given event as an "intercept" if the measured time spent in
the idle state (with the exit latency roughly taken into account)
falls into a different "state bin" than the sleep length (the expected
time till the next timer).  However, the sleep length is computed as a
difference between the upcoming timer wakeup event time and
ts->idle_entrytime, so it actually includes the time taken by
tick_nohz_next_event().  If the latter is significant, it may
contribute to the difference seen by teo_update() and cause extra
"intercepts" to appear.

