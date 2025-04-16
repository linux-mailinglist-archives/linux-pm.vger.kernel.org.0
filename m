Return-Path: <linux-pm+bounces-25554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53701A8B99B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97D7188F82B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1972035959;
	Wed, 16 Apr 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxE1NU6F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8E29B0;
	Wed, 16 Apr 2025 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807834; cv=none; b=n8bAwV+tx7akEOTrBDZfEuBWLly2IawS3ARZ/vN9X6yglFh7Q67YsAmzBr2r/AGvdmE0i1CeXUtATBZVNnRKGlahA51rZ8OBj+0cvf6zzy1gSL4Q5aefsOe1nCwYH2DTgG9VJI4y6H3C+sHpRKnv56bsRA86l6A3ml1naEJYRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807834; c=relaxed/simple;
	bh=m85edLrgYOpCuH9RY8jTUlsIABgDyR5sOCgCHHhO2CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6HSRMBxeOCuqwEPRFS4gznHp1u/4i8qQ1OnmBqAa8q9ihsjiZ9YtzpBtYCH2PmPkmqA34CJ7KPS4QiXy4TldnZCxgPSRmLbAR8oNprktx4Lj8p6jGmHt93cQHcEGrbaOtdZ+P3X2dZ32JJPNAcDwrZ9iBV/0L1vrZFmCNWqu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxE1NU6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F597C4CEF1;
	Wed, 16 Apr 2025 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744807833;
	bh=m85edLrgYOpCuH9RY8jTUlsIABgDyR5sOCgCHHhO2CE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QxE1NU6FqFFp5y3x4SHXvKrMbm9wCozH52NlQLesG54KRjNJ5tqVuu/tYR4rVV5/1
	 /t9UnqFASVv5RnRsE64IJMxx1GhUKt6oxvwX50ZJvjkletR1fgBYgWs81XWv2puJpX
	 tINma92XmHRfxMSLmReqbo+GkBBp4JcIOO9TnvQK298AY+mHh+JYlPlhf1e17VMyfQ
	 dyLuoxzo5hWYjYcPvU+sKKHjgRg4rApE9meibpLlIFO3CWFCdh/XFxul+5C0W+i5fW
	 UG7P5KD80utpl5RttzZWShJS7/5u9HgVPyzvh1WFyNeMqd37C75sshhKY1sFRVibX0
	 u0W/0zhHMTLRQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2d0920ce388so1551561fac.0;
        Wed, 16 Apr 2025 05:50:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNjB+BvL8B86ULpakdx/r3negBsI53MrI5RkfQN5hVIHQVN2uH0+lQkOiGHqx+sW7Q/cUmk/TnVac=@vger.kernel.org, AJvYcCWn/YQvbKW6GMinzKZMjgHJu+3B04x6n5F3lX5zz+J/Co7tHbZXtjkFn3kXyzmhBhCCg1Pg/a/0SzylGhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGxzvkUNRW6DBkyLXJvl6g6T/Iw4zpD/bxsHpgrKTQWU1kykM
	PIgHyn+8ROi/71+lsxiI2G7UiY3BB4SS1wrxiff7R09KRDFjeGWRd2YEMEUtpr9vHEIhzmnzUaJ
	rdmIbH5pWbkDzzBS8ZJymCDcIK6M=
X-Google-Smtp-Source: AGHT+IFloA20LKesYLmCQHzeShZduxofnSsitaMMsx9pIR3K0v52YtgLr2vyNeDFMenxQjyxofcKN0jjIkH5MCUD1iI=
X-Received: by 2002:a05:6871:d087:b0:2bc:7342:1a6c with SMTP id
 586e51a60fabf-2d4d2b37e45mr822829fac.19.1744807832563; Wed, 16 Apr 2025
 05:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6171293.lOV4Wx5bFT@rjwysocki.net> <9458818.CDJkKcVGEf@rjwysocki.net>
 <ce438098-ee9c-4808-b409-bb57b62794f0@arm.com>
In-Reply-To: <ce438098-ee9c-4808-b409-bb57b62794f0@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 14:50:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihGrXrOhA+1iwwrr6+SzmQ=3xuy5+F+zLgDZdS7brbCQ@mail.gmail.com>
X-Gm-Features: ATxdqUH2UA1kSoFJSl3o91Sn5JLarYcLvJRtcvNYEorPqaUL6Fe039KBAJBi-2s
Message-ID: <CAJZ5v0ihGrXrOhA+1iwwrr6+SzmQ=3xuy5+F+zLgDZdS7brbCQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cpufreq: Avoid using inconsistent policy->min and policy->max
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Sultan Alsawaf <sultan@kerneltoast.com>, Peter Zijlstra <peterz@infradead.org>, 
	Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:39=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/15/25 11:04, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since cpufreq_driver_resolve_freq() can run in parallel with
> > cpufreq_set_policy() and there is no synchronization between them,
> > the former may access policy->min and policy->max while the latter
> > is updating them and it may see intermediate values of them due
> > to the way the update is carried out.  Also the compiler is free
> > to apply any optimizations it wants both to the stores in
> > cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
> > which may result in additional inconsistencies.
> >
> > To address this, use WRITE_ONCE() when updating policy->min and
> > policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> > them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
> > in cpufreq_set_policy() to avoid storing intermediate values in
> > policy->min and policy->max with the help of the observation that
> > their new values are expected to be properly ordered upfront.
> >
> > Also modify cpufreq_driver_resolve_freq() to take the possible reverse
> > ordering of policy->min and policy->max, which may happen depending on
> > the ordering of operations when this function and cpufreq_set_policy()
> > run concurrently, into account by always honoring the max when it
> > turns out to be less than the min (in case it comes from thermal
> > throttling or similar).
> >
> > Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> > Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Just so I understand, the reason you don't squish 4-6 into one is
> because this is the only fix? I do get that, but doesn't the fact
> that it could easily be picked for backports make up for the additional
> refactor?

Yeah, I think I'll just merge them together and resend.

> Actual changes from patches 4-6 look good to me.

OK, thanks!

> > ---
> >
> > v1 -> v2: Minor edit in the subject
> >
> > ---
> >  drivers/cpufreq/cpufreq.c |   46 ++++++++++++++++++++++++++++++++++++-=
---------
> >  1 file changed, 36 insertions(+), 10 deletions(-)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -490,14 +490,12 @@
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
> >
> > -static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *poli=
cy,
> > -                                        unsigned int target_freq,
> > -                                        unsigned int relation)
> > +static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> > +                                unsigned int target_freq,
> > +                                unsigned int relation)
> >  {
> >       unsigned int idx;
> >
> > -     target_freq =3D clamp_val(target_freq, policy->min, policy->max);
> > -
> >       if (!policy->freq_table)
> >               return target_freq;
> >
> > @@ -507,6 +505,15 @@
> >       return policy->freq_table[idx].frequency;
> >  }
> >
> > +static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *poli=
cy,
> > +                                        unsigned int target_freq,
> > +                                        unsigned int relation)
> > +{
> > +     target_freq =3D clamp_val(target_freq, policy->min, policy->max);
> > +
> > +     return __resolve_freq(policy, target_freq, relation);
> > +}
> > +
> >  /**
> >   * cpufreq_driver_resolve_freq - Map a target frequency to a driver-su=
pported
> >   * one.
> > @@ -521,7 +528,22 @@
> >  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy=
,
> >                                        unsigned int target_freq)
> >  {
> > -     return clamp_and_resolve_freq(policy, target_freq, CPUFREQ_RELATI=
ON_LE);
> > +     unsigned int min =3D READ_ONCE(policy->min);
> > +     unsigned int max =3D READ_ONCE(policy->max);
> > +
> > +     /*
> > +      * If this function runs in parallel with cpufreq_set_policy(), i=
t may
> > +      * read policy->min before the update and policy->max after the u=
pdate
> > +      * or the other way around, so there is no ordering guarantee.
> > +      *
> > +      * Resolve this by always honoring the max (in case it comes from
> > +      * thermal throttling or similar).
> > +      */
> > +     if (unlikely(min > max))
> > +             min =3D max;
> > +
> > +     return __resolve_freq(policy, clamp_val(target_freq, min, max),
> > +                           CPUFREQ_RELATION_LE);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> >
> > @@ -2632,11 +2654,15 @@
> >        * Resolve policy min/max to available frequencies. It ensures
> >        * no frequency resolution will neither overshoot the requested m=
aximum
> >        * nor undershoot the requested minimum.
> > +      *
> > +      * Avoid storing intermediate values in policy->max or policy->mi=
n and
> > +      * compiler optimizations around them because them may be accesse=
d
>
> s/them/they/

Yup, thanks!

> > +      * concurrently by cpufreq_driver_resolve_freq() during the updat=
e.
> >        */
> > -     policy->min =3D new_data.min;
> > -     policy->max =3D new_data.max;
> > -     policy->min =3D clamp_and_resolve_freq(policy, policy->min, CPUFR=
EQ_RELATION_L);
> > -     policy->max =3D clamp_and_resolve_freq(policy, policy->max, CPUFR=
EQ_RELATION_H);
> > +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUF=
REQ_RELATION_H));
> > +     new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ_REL=
ATION_L);
> > +     WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max =
: new_data.min);
> > +
> >       trace_cpu_frequency_limits(policy);
> >
> >       cpufreq_update_pressure(policy);

Thanks for all the reviews!

