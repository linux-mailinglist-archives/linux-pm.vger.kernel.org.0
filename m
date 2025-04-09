Return-Path: <linux-pm+bounces-25019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E7A82862
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6034A0F48
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEEC2641DA;
	Wed,  9 Apr 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5O90Lv0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B841991CD;
	Wed,  9 Apr 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209696; cv=none; b=nClpo10qnoCpI2YWqktOyI/nlXTvFeDMVP6GiK0v0t9HaLWD0nK5VDWQ1KYHesIl1qw+H81dgxcgrCkSGc0nZutLxTr765Murqbkh7RD928r8LL4P6cz5QwURcXskZdu8bJcZW8s3JoYuG/PV5Wox9iPHZTn316VssDST0OF95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209696; c=relaxed/simple;
	bh=Y7HPtnBiJxbFByypFlQ8ifKikXhcytg0iemqCheXGa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUagv+a4WnlpAvxS9T20iZ7x6fis9ndjSlzqK/BCJ8Tv39+Rpiv4CwIoA9cpcsJ2qidKn2o0yqxjPkX35EZf7Tj0vAZIbpagPw39G9lhJzPSAcyad97voFDPyg/iFApQfj71/7JwABBMr5F9urmd38gZV7BWtpwOX3Zne50KUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5O90Lv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C9C4CEE7;
	Wed,  9 Apr 2025 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209696;
	bh=Y7HPtnBiJxbFByypFlQ8ifKikXhcytg0iemqCheXGa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k5O90Lv0MdahTE7nTCsdxV4smw6KUx3WI9PGkmI7grzEiMX4KxwBnM13c/zJvTf4R
	 GLOiGB7kGMAxnCYlGRZpVOVOJwVipd28bI9pzN9wv8bas3ma26pS+TjQDY4zW4+za9
	 cRwOrXsXPTjxxTm/8LIirVDf1hKb0XJ8hmsjF2GKNqbwYieryMLNynE44/fQ5OCCiH
	 46FJ2brZbYhKTTV0WT+PZucCj44xNOlwUAlxj29siahmjA7yi9CEyxdHYcLGaD5Bxs
	 4rQmKxUptNPtjwf/jkUtFovhbkpg6phABvl8uW7iJwQ9Nh6Ks0VGDjNUTKtNc/M3ZP
	 Gk5syH85lkZzw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so479997fac.0;
        Wed, 09 Apr 2025 07:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKlr8sze82U9vA2dRHK9meYaLnHCRZAqJuPS5/88eI+uKT7bhF5t3mAQGp2CVWarAvpRP/zuJ6zcwkOuA=@vger.kernel.org, AJvYcCVuWP4I+eI7oa1sEzHJlFg5E+7iniN2yaMoO3Ct/C7R6Y7+EyW6IF0YqQ838Nf505pn8jU+NOBhBjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fzbzlSrvkJB5nr839nQ6M9UzuGHzqd6rGZOaJ5DS1uc2daN5
	xbpbs969ktZepyJL4fVC9Jvn7UEY7gvQjwROwR9f6H69S0fbly6D6y1H3aDci5jgcEcaWRkO6S9
	ZIiZXKjDwviJsmS1h1b7o2gnRdeU=
X-Google-Smtp-Source: AGHT+IFxVQW3etEu3+hZaZeVVL2Mt8q3IgpF69CrQf6PbF8GKM2eE8Qw/f5IB4bU34fgXkRlwbyHcRVfoxKTGcCA+x0=
X-Received: by 2002:a05:6870:a453:b0:297:683:8b5b with SMTP id
 586e51a60fabf-2d0649db395mr4669768fac.10.1744209695393; Wed, 09 Apr 2025
 07:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4661520.LvFx2qVVIh@rjwysocki.net> <000f01dba95c$d0504b10$70f0e130$@telus.net>
In-Reply-To: <000f01dba95c$d0504b10$70f0e130$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 16:41:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4wOJMgmF8uscGd=hoV8ZabuN_4onO6rHdy-WX02KS1g@mail.gmail.com>
X-Gm-Features: ATxdqUGUQLD0QfelpdMEq249AMTKNTvJZfnDBnOdiZ-7W3bFIBsYTujM9_kmjzI
Message-ID: <CAJZ5v0j4wOJMgmF8uscGd=hoV8ZabuN_4onO6rHdy-WX02KS1g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] cpuidle: teo: Refine handling of short idle intervals
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 4:36=E2=80=AFPM Doug Smythies <dsmythies@telus.net> =
wrote:
>
> On 2025.04.03 12:16 Rafael J. Wysocki wrote:
>
> > Hi Everyone,
>
> Hi Rafael,
>
> > This series is intended to address an issue with overly aggressive sele=
ction
> > of idle state 0 (the polling state) in teo on x86 in some cases when ti=
mer
> > wakeups dominate the CPU wakeup pattern.
> >
> > In those cases, timer wakeups are not taken into account when they are
> > within the LATENCY_THRESHOLD_NS range and the idle state selection may
> > be based entirely on non-timer wakeups which may be rare.  This causes
> > the prediction accuracy to be low and too much energy may be used as
> > a result.
> >
> > The first patch is preparatory and it is not expected to make any
> > functional difference.
> >
> > The second patch causes teo to take timer wakeups into account if it
> > is about to skip the tick_nohz_get_sleep_length() invocation, so they
> > get a chance to influence the idle state selection.
> >
> > I have been using this series on my systems for several weeks and obser=
ved
> > a significant reduction of the polling state selection rate in multiple
> > workloads.
>
> I ran many tests on this patch set.
> In general, there is nothing significant to report.
>
> There seemed to be a little less power use for the adrestia test and it t=
ook a little longer to execute, but the average wakeup latency was the same=
.
>
> I am still having noise and repeatability issues with my main periodic te=
sts, where CPU is swept from low to high at serveral work sleep frequencies=
.
> But I didn't observe anything significant.
>
> In order to use more shallow idle states with a periodic workflow, I laun=
ched 2000 threads with each at 113 Hertz work/sleep frequency and almost no=
 work to do for each work packet.
> The patched version used between 1 and 1.5 less processor package power, =
at around 85 watts.
> The patched version spent about 3.5% in idle state 0 verses about 5% for =
the unpatched version.
> The patched version spent about 31.8% in idle state 1 verses about 30.2% =
for the unpatched version.
>
> Test computer:
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> Distro: Ubuntu 24.04.1, server, no desktop GUI.
> CPU frequency scaling driver: intel_pstate
> HWP: disabled.
> CPU frequency scaling governor: performance
> Ilde driver: intel_idle
> Idle governor: teo
> Idle states: 4: name : description:
>   state0/name:POLL                desc:CPUIDLE CORE POLL IDLE
>   state1/name:C1_ACPI          desc:ACPI FFH MWAIT 0x0
>   state2/name:C2_ACPI          desc:ACPI FFH MWAIT 0x30
>   state3/name:C3_ACPI          desc:ACPI FFH MWAIT 0x60
>
> ... Doug

Thank you!

