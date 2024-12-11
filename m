Return-Path: <linux-pm+bounces-19008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44059ECB30
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1892528686F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4EE238E0B;
	Wed, 11 Dec 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK50pNOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBB238E00;
	Wed, 11 Dec 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916560; cv=none; b=MLdXQ7lxpE0DoZurdKRGR28aZhnTgnHT1mmEcUqudTJRNg5nJ/fsUQsRx31nZJ7yh9UbX/UxKxjue/CLniezlZNJswJl6SQEUaWpq352zOB3bsaULw46iUUtGAUgtU7Pm7J6jcHoJoNK5agxCqrUaJq3kG5dl9o/D3VDnCM5ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916560; c=relaxed/simple;
	bh=ChFMD/TJZoNYCCTjWR4VQwXawEd4b6Oh3ancYuOGsr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJRash8NwMQDrA98A4foFOorth7fOsBLmjUDI06fczXlm3ZXJ/p3zUELERNi4XzEBEgPfKOFBBcDkD6+gs3ilxIQ9wLnXMT33l+N+Chx9P2T3VvsE57S5oMY1f/NRN4Q97g/5lioVHw4zsDEM5H6+2AdbozhIgkMibaOafmVEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK50pNOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA84C4CED2;
	Wed, 11 Dec 2024 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733916559;
	bh=ChFMD/TJZoNYCCTjWR4VQwXawEd4b6Oh3ancYuOGsr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lK50pNOb0nHGGkW4mVV5bhiz7bsspcKoFcLfREHmOv3A5xAbt3MNSo6Gpfedw3PHD
	 znTkzfMS0mV5wTqSohyfMvTPpQctVwcnSBIZTN3j/hFYnSHa7MChSh22IymBauKqhA
	 UUbc9528OEkRAr36ok7yR5ztFCq5cPIM/M/XkEyWiaD65xWVWAHzYEUaTgkH7T4h2b
	 5YVxZY/SmBgRB+mHIqOy+sh7BUyDquHFu/TNC6yOgRs/A7H7fTJMDTVUli9t3zmNs9
	 jSxR/ADi2+7VgIYqGeqvT7HL77p1a0xJU3pCsGWypPJDhnWJyui8SnL8Fg2ps8UemU
	 Z0DYW9VYCXoMA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f2b21a0784so860185eaf.1;
        Wed, 11 Dec 2024 03:29:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWP/Hay9yawJLgD+hJUamfSIzULilCZ/8Lm1eHMqCDWMSNzNVcp89JlANLH+R5VysAbnaDoW/YWbTrNA4w=@vger.kernel.org, AJvYcCXMpkCijqIpntktlrwAzCjvAd1SpBI4MJ8q4hdjbeKsRtoWyBSPXdeBNwDLZDJWy4NyrY6QlXyZ4CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2e59wxJdm7KsUe320AT0f/aq2Uwl65HJBaaR6nR5GKXy/ykQ
	oPyMrWfM3+AbeGasBAYz0QezUEhR5LCI0gcNpyagmlPUh3eYA83lwy1M8H29Smwv4/Uof5lL7Kz
	hXUkxO+ySdvDUuvHEiQWhUiG2Cic=
X-Google-Smtp-Source: AGHT+IFFnbgug8nncq+ouFS3/0JGDsX7Q+Z5N9j8cezEiUxBqsYNlT9f8b/01L/qti7+aHS/rt6e3udOpnKthL8J2yE=
X-Received: by 2002:a05:6820:2701:b0:5f2:37de:5839 with SMTP id
 006d021491bc7-5f2da14850amr1061762eaf.7.1733916559116; Wed, 11 Dec 2024
 03:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com>
In-Reply-To: <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Dec 2024 12:29:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
Message-ID: <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:33=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/29/24 16:00, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make it possible to use EAS with cpufreq drivers that implement the
> > :setpolicy() callback instead of using generic cpufreq governors.
> >
> > This is going to be necessary for using EAS with intel_pstate in its
> > default configuration.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > This is the minimum of what's needed, but I'd really prefer to move
> > the cpufreq vs EAS checks into cpufreq because messing around cpufreq
> > internals in topology.c feels like a butcher shop kind of exercise.
>
> Makes sense, something like cpufreq_eas_capable().
>
> >
> > Besides, as I said before, I remain unconvinced about the usefulness
> > of these checks at all.  Yes, one is supposed to get the best results
> > from EAS when running schedutil, but what if they just want to try
> > something else with EAS?  What if they can get better results with
> > that other thing, surprisingly enough?
>
> How do you imagine this to work then?
> I assume we don't make any 'resulting-OPP-guesses' like
> sugov_effective_cpu_perf() for any of the setpolicy governors.
> Neither for dbs and I guess userspace.
> What about standard powersave and performance?
> Do we just have a cpufreq callback to ask which OPP to use for
> the energy calculation? Assume lowest/highest?
> (I don't think there is hardware where lowest/highest makes a
> difference, so maybe not bothering with the complexity could
> be an option, too.)

In the "setpolicy" case there is no way to reliably predict the OPP
that is going to be used, so why bother?

In the other cases, and if the OPPs are actually known, EAS may still
make assumptions regarding which of them will be used that will match
the schedutil selection rules, but if the cpufreq governor happens to
choose a different OPP, this is not the end of the world.

Yes, you could have been more energy-efficient had you chosen to use
schedutil, but you chose otherwise and that's what you get.

> >
> > ---
> >  kernel/sched/topology.c |   10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/kernel/sched/topology.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/kernel/sched/topology.c
> > +++ linux-pm/kernel/sched/topology.c
> > @@ -217,6 +217,7 @@ static bool sched_is_eas_possible(const
> >       bool any_asym_capacity =3D false;
> >       struct cpufreq_policy *policy;
> >       struct cpufreq_governor *gov;
> > +     bool cpufreq_ok;
> >       int i;
> >
> >       /* EAS is enabled for asymmetric CPU capacity topologies. */
> > @@ -251,7 +252,7 @@ static bool sched_is_eas_possible(const
> >               return false;
> >       }
> >
> > -     /* Do not attempt EAS if schedutil is not being used. */
> > +     /* Do not attempt EAS if cpufreq is not configured adequately */
> >       for_each_cpu(i, cpu_mask) {
> >               policy =3D cpufreq_cpu_get(i);
> >               if (!policy) {
> > @@ -261,11 +262,14 @@ static bool sched_is_eas_possible(const
> >                       }
> >                       return false;
> >               }
> > +             /* Require schedutil or a "setpolicy" driver */
> >               gov =3D policy->governor;
> > +             cpufreq_ok =3D gov =3D=3D &schedutil_gov ||
> > +                             (!gov && policy->policy !=3D CPUFREQ_POLI=
CY_UNKNOWN);
> >               cpufreq_cpu_put(policy);
> > -             if (gov !=3D &schedutil_gov) {
> > +             if (!cpufreq_ok) {
> >                       if (sched_debug()) {
> > -                             pr_info("rd %*pbl: Checking EAS, scheduti=
l is mandatory\n",
> > +                             pr_info("rd %*pbl: Checking EAS, unsuitab=
le cpufreq governor\n",
> >                                       cpumask_pr_args(cpu_mask));
> >                       }
> >                       return false;
>
> The logic here looks fine to me FWIW.
>
>

