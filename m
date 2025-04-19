Return-Path: <linux-pm+bounces-25744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412AA942E1
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15E3189CA1A
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6D41CDFCE;
	Sat, 19 Apr 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DByg3oXk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA61465B4;
	Sat, 19 Apr 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059202; cv=none; b=L4+CCcaHj49qHFWwwwUa+7Mmu1I3gPXvtrIzM4xyxMdob9mOelUWLO2iJs9EPzG9YVTz05M47WAe+/ipPYUx0JMQncUznEQjlGOxj00hKQFJPXI38eDHlpUuvcazXOGiKKyhLVAGOyHBBwSgGhmSvn56rLW/jwpGmPxXNbm8W3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059202; c=relaxed/simple;
	bh=eYoL2HRlTi4nkVgsZZkYjpGbwZdeJRxraw4+Ko+KH2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKDx4mJt/pNPkJpiQB9HhZtJUgb2+558KVJJc5yCDwirkes7zthN1MO3UOqAYr28sP0bwKc0tKqLT1b4hAj2G03GG/kuoVMf7bnm1dnTMo1BlPj/YVoDlhJk1w4WG6D3P3mi/YCRVwNexqJzK+CRonhSoPtDTgyC8wshuDxxuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DByg3oXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E83CC4CEEB;
	Sat, 19 Apr 2025 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745059201;
	bh=eYoL2HRlTi4nkVgsZZkYjpGbwZdeJRxraw4+Ko+KH2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DByg3oXkqdLlrnB4ZHNAuosYyFa96JmLbITPI6cb9g2oSibE4GPJqQQ0SSo+vDt9X
	 vfqnJwWAcYNHiAve1a6XHD0HHtPdiaALf/6uhOVUClEZhKSb/awrsK7KITy2albjGx
	 Jv3jq+TYcu7q5/Ajcapmvg39tRMAibQ01dqcAIpCV2dsuTulUIUfvftLFspMR9DpA5
	 a5RmkdLaZDJvVVq5s4KM05iYYDc0O2ZOkrS0/c/G8EyDkrkJsEUdHpfmiP0ISWoXa0
	 FJyhMB5w8wRAQpb/T6Xv1qLuLump9Gs+tciKEbmTZ6c7PlZM099yquSNpRunBDrVmJ
	 o1z8omXVeplXQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b8e2606a58so1395940fac.0;
        Sat, 19 Apr 2025 03:40:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4IgqP40pQ4xkIFcCR6vEr78f13azZNkGYyop1pn+TazYoOAEfW4SE9H9k/zBj7LCLReDS14k0UC4d+CE=@vger.kernel.org, AJvYcCXPMw2+Y+GoKRIy9OVPJr7A7pL/rreM0Rssy3SyORb3s1iypXyu+FUXwAsrDoLq2Mad0fs0DdCrjYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFW0PjAiHtZQ/StVQxd2UNN8R9D/0yoAAwrEHENIkN0jc5orq
	VLRFdPy7cJpgTT91Gx04493iWmSnJ8Ns1Gx9dwSAYj6Wrt+gQsaijOguBw4vvF9bucyJc+x4fwn
	F3mjDsANtkeSugdElKtlYB62q08I=
X-Google-Smtp-Source: AGHT+IF/uA6ql4KVflAPx0wLSjwKsbCbwuDvhl6ZQw8kEAXWsQEHWFsk60EXfKtqS28heH/ktZcwLNYymiWbSWek68Q=
X-Received: by 2002:a05:6870:1b15:b0:2d4:dc79:b8b with SMTP id
 586e51a60fabf-2d526a2e937mr3323443fac.10.1745059200845; Sat, 19 Apr 2025
 03:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6171293.lOV4Wx5bFT@rjwysocki.net> <9458818.CDJkKcVGEf@rjwysocki.net>
 <aAIm48RPmm1d_Y6u@sultan-box.localdomain> <CAJZ5v0iAmutVUQtMP_yThRx2J39Ng96osv1BMHX0gRf-8oJ3TA@mail.gmail.com>
 <aALQhEi609NQAV7S@sultan-box.localdomain>
In-Reply-To: <aALQhEi609NQAV7S@sultan-box.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 19 Apr 2025 12:39:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gw5CobuPbn6wS5PtU7PB0mioJ8MX4zyvaLAwfsd5CiLg@mail.gmail.com>
X-Gm-Features: ATxdqUHe_0f0407jCaR25N4IdUzRrIE9RrSNfn3sPRG3kqzIGfNgrKNrhhZpE2M
Message-ID: <CAJZ5v0gw5CobuPbn6wS5PtU7PB0mioJ8MX4zyvaLAwfsd5CiLg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cpufreq: Avoid using inconsistent policy->min and policy->max
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 12:22=E2=80=AFAM Sultan Alsawaf <sultan@kerneltoast=
.com> wrote:
>
> On Fri, Apr 18, 2025 at 09:42:15PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Apr 18, 2025 at 12:18=E2=80=AFPM Sultan Alsawaf <sultan@kernelt=
oast.com> wrote:
> > >
> > > On Tue, Apr 15, 2025 at 12:04:21PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Since cpufreq_driver_resolve_freq() can run in parallel with
> > > > cpufreq_set_policy() and there is no synchronization between them,
> > > > the former may access policy->min and policy->max while the latter
> > > > is updating them and it may see intermediate values of them due
> > > > to the way the update is carried out.  Also the compiler is free
> > > > to apply any optimizations it wants both to the stores in
> > > > cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_fre=
q()
> > > > which may result in additional inconsistencies.
> > > >
> > > > To address this, use WRITE_ONCE() when updating policy->min and
> > > > policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> > > > them in cpufreq_driver_resolve_freq().  Moreover, rearrange the upd=
ate
> > > > in cpufreq_set_policy() to avoid storing intermediate values in
> > > > policy->min and policy->max with the help of the observation that
> > > > their new values are expected to be properly ordered upfront.
> > > >
> > > > Also modify cpufreq_driver_resolve_freq() to take the possible reve=
rse
> > > > ordering of policy->min and policy->max, which may happen depending=
 on
> > > > the ordering of operations when this function and cpufreq_set_polic=
y()
> > > > run concurrently, into account by always honoring the max when it
> > > > turns out to be less than the min (in case it comes from thermal
> > > > throttling or similar).
> > > >
> > > > Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirement=
s")
> > > > Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > v1 -> v2: Minor edit in the subject
> > > >
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c |   46 +++++++++++++++++++++++++++++++++=
+++----------
> > > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > > >
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -490,14 +490,12 @@
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
> > > >
> > > > -static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *=
policy,
> > > > -                                        unsigned int target_freq,
> > > > -                                        unsigned int relation)
> > > > +static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> > > > +                                unsigned int target_freq,
> > > > +                                unsigned int relation)
> > > >  {
> > > >       unsigned int idx;
> > > >
> > > > -     target_freq =3D clamp_val(target_freq, policy->min, policy->m=
ax);
> > > > -
> > > >       if (!policy->freq_table)
> > > >               return target_freq;
> > > >
> > > > @@ -507,6 +505,15 @@
> > > >       return policy->freq_table[idx].frequency;
> > > >  }
> > > >
> > > > +static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *=
policy,
> > > > +                                        unsigned int target_freq,
> > > > +                                        unsigned int relation)
> > > > +{
> > > > +     target_freq =3D clamp_val(target_freq, policy->min, policy->m=
ax);
> > > > +
> > > > +     return __resolve_freq(policy, target_freq, relation);
> > > > +}
> > > > +
> > > >  /**
> > > >   * cpufreq_driver_resolve_freq - Map a target frequency to a drive=
r-supported
> > > >   * one.
> > > > @@ -521,7 +528,22 @@
> > > >  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *po=
licy,
> > > >                                        unsigned int target_freq)
> > > >  {
> > > > -     return clamp_and_resolve_freq(policy, target_freq, CPUFREQ_RE=
LATION_LE);
> > > > +     unsigned int min =3D READ_ONCE(policy->min);
> > > > +     unsigned int max =3D READ_ONCE(policy->max);
> > > > +
> > > > +     /*
> > > > +      * If this function runs in parallel with cpufreq_set_policy(=
), it may
> > > > +      * read policy->min before the update and policy->max after t=
he update
> > > > +      * or the other way around, so there is no ordering guarantee=
.
> > > > +      *
> > > > +      * Resolve this by always honoring the max (in case it comes =
from
> > > > +      * thermal throttling or similar).
> > > > +      */
> > > > +     if (unlikely(min > max))
> > > > +             min =3D max;
> > > > +
> > > > +     return __resolve_freq(policy, clamp_val(target_freq, min, max=
),
> > > > +                           CPUFREQ_RELATION_LE);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> > > >
> > > > @@ -2632,11 +2654,15 @@
> > > >        * Resolve policy min/max to available frequencies. It ensure=
s
> > > >        * no frequency resolution will neither overshoot the request=
ed maximum
> > > >        * nor undershoot the requested minimum.
> > > > +      *
> > > > +      * Avoid storing intermediate values in policy->max or policy=
->min and
> > > > +      * compiler optimizations around them because them may be acc=
essed
> > > > +      * concurrently by cpufreq_driver_resolve_freq() during the u=
pdate.
> > > >        */
> > > > -     policy->min =3D new_data.min;
> > > > -     policy->max =3D new_data.max;
> > > > -     policy->min =3D clamp_and_resolve_freq(policy, policy->min, C=
PUFREQ_RELATION_L);
> > > > -     policy->max =3D clamp_and_resolve_freq(policy, policy->max, C=
PUFREQ_RELATION_H);
> > > > +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, =
CPUFREQ_RELATION_H));
> > > > +     new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ=
_RELATION_L);
> > > > +     WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->=
max : new_data.min);
> > >
> > > I don't think this is sufficient, because this still permits an incoh=
erent
> > > policy->min and policy->max combination, which makes it possible for =
schedutil
> > > to honor the incoherent limits; i.e., schedutil may observe old polic=
y->min and
> > > new policy->max or vice-versa.
> >
> > Yes, it may, as stated in the new comment in cpufreq_driver_resolve_fre=
q().
>
> Thanks for pointing that out; I had ignored that hunk while reviewing.
>
> But I ignored it because schedutil still accesses policy->min/max unprote=
cted
> via cpufreq_policy_apply_limits() and __cpufreq_driver_target(). The race=
 still
> affects those calls.
>
> > > We also can't permit a wrong freq to be propagated to the driver and =
then send
> > > the _right_ freq afterwards; IOW, we can't let a bogus freq slip thro=
ugh and
> > > just correct it later.
> >
> > The frequency is neither wrong nor bogus, it is only affected by one
> > of the limits that were in effect previously or will be in effect
> > going forward.  They are valid limits in either case.
>
> I would argue that limits only make sense as a pair, not on their own. Ch=
ecking
> for min > max only covers the case where the new min exceeds the old max;=
 this
> means that, when min is raised without exceeding the old max, a thermal t=
hrottle
> attempt could instead result in a raised frequency floor:
>
>         1. policy->min =3D=3D 100000, policy->max =3D=3D 2500000
>         2. Policy limit update request: new min of 400000, new max of 500=
000
>         3. schedutil observes policy->min =3D=3D 400000, policy->max =3D=
=3D 2500000

Until it runs next time that is.

> Raising the min freq while lowering the max freq can be a valid thermal t=
hrottle
> scheme.

Maybe theoretically.

All of the places in the kernel that use cpufreq for cooling I'm aware
of only set the max limit.

> But it only makes sense if both limits are applied simultaneously.

And they will, but only a bit later.

As a general rule, limits don't take effect immediately.  There's no
such promise, it has never been there and never will be.

The promise is that both limits will be taken into account when the
governor runs for the first time after a limits update, not that it
will pick up those limits immediately when it is running in parallel
with the update.

Whoever updates policy limits, they need to take that into account.

> > > How about using a seqlock?
> >
> > This would mean extra overhead in the scheduler path pretty much for no=
 gain.
>
> Or there's the slightly cursed approach of using a union to facilitate an=
 atomic
> 64-bit store of policy->min and max at the same time, since min/max are 3=
2 bits.

That's a possibility, but at this point I don't see why it would be necessa=
ry.

Point me to at least one remotely realistic use case that is broken as
a result of the race in question and I will reconsider it.

Thanks!

