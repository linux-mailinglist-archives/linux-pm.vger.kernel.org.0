Return-Path: <linux-pm+bounces-22806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA5A41FD1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A393A8F35
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77923373F;
	Mon, 24 Feb 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSWDJXed"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6670192B95;
	Mon, 24 Feb 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401840; cv=none; b=MSqloXefiWddBmNN+xUScstxDDEj6gih0t5xqltj/X7Q6yfqcCclov5TEdfjXAVET5GkydDT5RRcGPfcIA8rTIULcm3lu0zysPpbwoTNYKDW38QeibMTxcOmpLBFLyaVCDjs/Ly/vVySrs4V42GBVcCsER78h607yAvf+OjX5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401840; c=relaxed/simple;
	bh=FwrrGbodEXZWB1mjRa0Sv3Et/wD31AqFlgcJW4s177g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5Tl40UWdD4KyHdfSrVrl2vsPVvH3UVWck/wxMJiOGA7W8158AzUMz/QrP77nuindBUoY1JpLPu+llmOwcxGvUZ/OW8BfgkKzpp6owK4dH6wOAeQpXN6cfMOwMB5RReUy4227osszKj0Z5xtyCEjZErro8s/mwFnG6HLsciqiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSWDJXed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0A0C4CED6;
	Mon, 24 Feb 2025 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740401840;
	bh=FwrrGbodEXZWB1mjRa0Sv3Et/wD31AqFlgcJW4s177g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oSWDJXedtbGXpoi/WAs0Sh/cv4OCD5pT6OsNjIOMrgxNco2BqCW0XC02ey9XodFiu
	 OtXNl+QL9E4txiVOl0yRWg5xskmxVfj2/v1z1odzy6UYU3WkdKySKxtelf5/antRYn
	 BZjpFSFY+OZDA65mO9/q7gphd8qSc4rIAo99nCsWnn9lK2lEQvB094UGSOyS5tTcEU
	 h34j1rMuQNBXoxLLfEy3dzYYrbUm6AiCyDHoVTqFdS2KACjg2/ZYea1xDlqarziDvN
	 YHbpeCn4m15UmkISUPcNX5CIL21fvLIFZcWDFqPYU2vznghgoNu4zHo3z4lo+X41Se
	 V8yjv+9Rs2JyA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bcf9d9b60aso634909fac.3;
        Mon, 24 Feb 2025 04:57:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWI2P0P/YfwbspK0E/2nSLnKn0wGP7lezf31dJPI1eqJv+oeQLPjQx5QoN7tPyhEYtomORrCUJ6gd4=@vger.kernel.org, AJvYcCWnQbTHivcWzOHX2zkzOQkg8rjvH1/QNdyyNPAh85lZ9Je9JLM6jJb5xB3NQ+91lyDtTEj8ZMQKlFj2API=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9Oj868dHKPOZ2piGi+HSY1xr73tRdeDBKzdZq6ahh+E3jPwg
	eDskmaMLKJ8AzqSXkIf3Q798jCDOD3UCskm4brcaffz6cnv3bOvFJhPRjil1oMHKmlli6GflTzV
	ga2TvCDFDzccFHTL5vJRKO70HV2E=
X-Google-Smtp-Source: AGHT+IGXFrjtxiZ3TCpWE6A9is3KPcYc7VLzGi4g9K4ePj9VOS1qVL71VRuXi5hSaFWV49VpegR6ZA4ak7Hc3d0pSD4=
X-Received: by 2002:a05:6870:9123:b0:296:e6d9:a2e1 with SMTP id
 586e51a60fabf-2bd5159fcbfmr9326496fac.11.1740401839492; Mon, 24 Feb 2025
 04:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4998484.31r3eYUQgx@rjwysocki.net> <86756d5c-ce47-4a91-afff-480b82207516@arm.com>
In-Reply-To: <86756d5c-ce47-4a91-afff-480b82207516@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Feb 2025 13:57:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jHw0h1hOViiZtHwiaFhTZDmKaFpiTVQwu3ACFG5FQbgA@mail.gmail.com>
X-Gm-Features: AWEUYZmZhfOpNDafqsXpyne7v2es-nkHTxXc2E6tySKlImH-7-C1MwX4svSIfNo
Message-ID: <CAJZ5v0jHw0h1hOViiZtHwiaFhTZDmKaFpiTVQwu3ACFG5FQbgA@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: menu: Update documentation after previous changes
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:41=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/20/25 20:13, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The documentaion of the menu cpuidle governor needs to be updated
> s/documentaion/documentation/
> > to match the code bevavior after some changes made recently.
>
> s/bevavior/behavior/
>
> >
> > No functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/admin-guide/pm/cpuidle.rst |   27 ++++++++++++++++------=
-----
> >  drivers/cpuidle/governors/menu.c         |   29 ++++++++++------------=
-------
> >  2 files changed, 26 insertions(+), 30 deletions(-)
> >
> > --- a/Documentation/admin-guide/pm/cpuidle.rst
> > +++ b/Documentation/admin-guide/pm/cpuidle.rst
> > @@ -275,20 +275,25 @@
> >  and variance of them.  If the variance is small (smaller than 400 squa=
re
> >  milliseconds) or it is small relative to the average (the average is g=
reater
> >  that 6 times the standard deviation), the average is regarded as the "=
typical
> > -interval" value.  Otherwise, the longest of the saved observed idle du=
ration
> > +interval" value.  Otherwise, either the longest or the shortest (depen=
ding on
> > +which one is farther from the average) of the saved observed idle dura=
tion
> >  values is discarded and the computation is repeated for the remaining =
ones.
> > +
> >  Again, if the variance of them is small (in the above sense), the aver=
age is
> >  taken as the "typical interval" value and so on, until either the "typ=
ical
> > -interval" is determined or too many data points are disregarded, in wh=
ich case
> > -the "typical interval" is assumed to equal "infinity" (the maximum uns=
igned
> > -integer value).
> > +interval" is determined or too many data points are disregarded.  In t=
he latter
> > +case, if the size of the set of data points still under consideration =
is
> > +sufficiently large, the next idle duration is not likely to be above t=
he largest
> > +idle duration value still in that set, so that value is taken as the p=
redicted
> > +next idle duration.  Finally, if the set of data points still under
> > +consideration is too small, no prediction is made.
> >
> > -If the "typical interval" computed this way is long enough, the govern=
or obtains
> > -the time until the closest timer event with the assumption that the sc=
heduler
> > -tick will be stopped.  That time, referred to as the *sleep length* in=
 what follows,
> > -is the upper bound on the time before the next CPU wakeup.  It is used=
 to determine
> > -the sleep length range, which in turn is needed to get the sleep lengt=
h correction
> > -factor.
> > +If the preliminary prediction of the next idle duration computed this =
way is
> > +long enough, the governor obtains the time until the closest timer eve=
nt with
> > +the assumption that the scheduler tick will be stopped.  That time, re=
ferred to
> > +as the *sleep length* in what follows, is the upper bound on the time =
before the
> > +next CPU wakeup.  It is used to determine the sleep length range, whic=
h in turn
> > +is needed to get the sleep length correction factor.
> >
> >  The ``menu`` governor maintains an array containing several correction=
 factor
> >  values that correspond to different sleep length ranges organized so t=
hat each
> > @@ -302,7 +307,7 @@
> >  The sleep length is multiplied by the correction factor for the range =
that it
> >  falls into to obtain an approximation of the predicted idle duration t=
hat is
> >  compared to the "typical interval" determined previously and the minim=
um of
> > -the two is taken as the idle duration prediction.
> > +the two is taken as the final idle duration prediction.
> >
> >  If the "typical interval" value is small, which means that the CPU is =
likely
> >  to be woken up soon enough, the sleep length computation is skipped as=
 it may
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -41,7 +41,7 @@
> >   * the  C state is required to actually break even on this cost. CPUID=
LE
> >   * provides us this duration in the "target_residency" field. So all t=
hat we
> >   * need is a good prediction of how long we'll be idle. Like the tradi=
tional
> > - * menu governor, we start with the actual known "next timer event" ti=
me.
> > + * menu governor, we take the actual known "next timer event" time.
> >   *
> >   * Since there are other source of wakeups (interrupts for example) th=
an
> >   * the next timer event, this estimation is rather optimistic. To get =
a
> > @@ -50,30 +50,21 @@
> >   * duration always was 50% of the next timer tick, the correction fact=
or will
> >   * be 0.5.
> >   *
> > - * menu uses a running average for this correction factor, however it =
uses a
> > - * set of factors, not just a single factor. This stems from the reali=
zation
> > - * that the ratio is dependent on the order of magnitude of the expect=
ed
> > - * duration; if we expect 500 milliseconds of idle time the likelihood=
 of
> > - * getting an interrupt very early is much higher than if we expect 50=
 micro
> > - * seconds of idle time. A second independent factor that has big impa=
ct on
> > - * the actual factor is if there is (disk) IO outstanding or not.
> > - * (as a special twist, we consider every sleep longer than 50 millise=
conds
> > - * as perfect; there are no power gains for sleeping longer than this)
> > - *
> > - * For these two reasons we keep an array of 12 independent factors, t=
hat gets
> > - * indexed based on the magnitude of the expected duration as well as =
the
> > - * "is IO outstanding" property.
> > + * menu uses a running average for this correction factor, but it uses=
 a set of
> > + * factors, not just a single factor. This stems from the realization =
that the
> > + * ratio is dependent on the order of magnitude of the expected durati=
on; if we
> > + * expect 500 milliseconds of idle time the likelihood of getting an i=
nterrupt
> > + * very early is much higher than if we expect 50 micro seconds of idl=
e time.
> > + * For this reason, menu keeps an array of 6 independent factors, that=
 gets
> > + * indexed based on the magnitude of the expected duration.
> >   *
> >   * Repeatable-interval-detector
> >   * ----------------------------
> >   * There are some cases where "next timer" is a completely unusable pr=
edictor:
> >   * Those cases where the interval is fixed, for example due to hardwar=
e
> > - * interrupt mitigation, but also due to fixed transfer rate devices s=
uch as
> > - * mice.
> > + * interrupt mitigation, but also due to fixed transfer rate devices l=
ike mice.
> >   * For this, we use a different predictor: We track the duration of th=
e last 8
> > - * intervals and if the stand deviation of these 8 intervals is below =
a
> > - * threshold value, we use the average of these intervals as predictio=
n.
> > - *
> > + * intervals and use them to estimate the duration of the next one.
> >   */
>
> Assuming you fix up the typos in the commit message when applying:

I will.

> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thank you!

