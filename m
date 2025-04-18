Return-Path: <linux-pm+bounces-25731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E22A93E5D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D9464D47
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A682253A4;
	Fri, 18 Apr 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j44HsLKw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD4217654;
	Fri, 18 Apr 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005348; cv=none; b=Gc6jYf2a5/ycZJzBT8T/VMgDp560RmbbN/Ago1EVnBgc5PmSufmGDgshCPay9Ev7myxgszWlranX5g+nG7/AgYu5dj6rhjabm9ItRldn2Y3vk0B32/fJFLc9gYWI3vRzwQOjm6uwCb8Ocum3XV6YMJWaibRdgem5RzqAGpZ41t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005348; c=relaxed/simple;
	bh=hsZc2Jrdk3ZQU6oGB8uLyQMj60LyoYdoedZoeCoBLbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4EiVWJCHmtgo5dviExz4yOCQJDboU4n7gBab5/LGeKF8IC3d4mHJshyzYyVS0LWX49muOtiQ1tUfrMfsgFOH/W7ytA9FZbsRR8WHcqzJl2nQJbSGr8By96I6s9vQhJPgg1pPVoBRD6L2Pn4ruFXGqf7zeUruXGFQd9TG8ZvKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j44HsLKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC742C4AF09;
	Fri, 18 Apr 2025 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745005347;
	bh=hsZc2Jrdk3ZQU6oGB8uLyQMj60LyoYdoedZoeCoBLbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j44HsLKwwgkR9k2Vtqd/rzm7RgTcbMdrX2gR0JK0ZxoFaX8ckSltT+4CPyi+xA8ix
	 C3t4XwFlluNp7g4cjHpjrXQ1/pW2WH63q7KLtKjBU7YzXFt9NREIuHwc1TEqRJyzfR
	 NvjuMQBnM+kWfApCCGGp8C4SeHAyUxNvT7065mJ280Gk2L2eVbzL4IimREBN2aZeBs
	 HCX8+L6KQUYotxd7jLQ8yqe2qRDsaiXaSwc9eYG/MAe15Eio5MD5kLT4GSmy6xuEz8
	 jkDyp4JGGG76eq5NfcH2sGzIqOXbLbQSBYrO/ufqMKOtGpzmzD9HUVNwvkO2F3eX7Z
	 tuo/dJWgsjKXA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d540239367so103868fac.0;
        Fri, 18 Apr 2025 12:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNUDo/WvxosGa4kcXrbWmL3AdkMR9ccci39gJCLLjrjS+q5Vuq17xrk2kasVkTSXoN8Vhdb2BmcbI=@vger.kernel.org, AJvYcCXn2MQsNUWqAaFUOaYS2sv29Bp8SH/QKFMnIcKug1E3/O/UQBcUYigoMyOvdPpFK71Wy9exCRwjnIf+0do=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXISvxZWs1Gnk1LzGqdpRrfKKkqrSdB4ZAa/2vVVYpNb1GvXUa
	aNOgPVyQj289g0WJPcmOoYKhxmsouRmpk/Bo1ikYEIUE0QKWm2oAphxzl4w/QGi8ARAuGp08Etq
	l888A0hdxnRtfIX1ml51TEsjDgEQ=
X-Google-Smtp-Source: AGHT+IGaMyJkOtfdVBIZXsi9oIA4F721iQBvUNXd6UeiFN2Jf9LHo/6zITV9MiO24JowGNjVtCUW70mLnVtuqHgeRpA=
X-Received: by 2002:a05:6870:9195:b0:29e:2ce2:94d with SMTP id
 586e51a60fabf-2d526a654cemr2312301fac.14.1745005346942; Fri, 18 Apr 2025
 12:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6171293.lOV4Wx5bFT@rjwysocki.net> <9458818.CDJkKcVGEf@rjwysocki.net>
 <aAIm48RPmm1d_Y6u@sultan-box.localdomain>
In-Reply-To: <aAIm48RPmm1d_Y6u@sultan-box.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Apr 2025 21:42:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAmutVUQtMP_yThRx2J39Ng96osv1BMHX0gRf-8oJ3TA@mail.gmail.com>
X-Gm-Features: ATxdqUH8iL8v0BTCOD0WXMq4RC0-Tvvyp0rra5OoZR26RcOX4bWhBzgPIqRilNo
Message-ID: <CAJZ5v0iAmutVUQtMP_yThRx2J39Ng96osv1BMHX0gRf-8oJ3TA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cpufreq: Avoid using inconsistent policy->min and policy->max
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 12:18=E2=80=AFPM Sultan Alsawaf <sultan@kerneltoast=
.com> wrote:
>
> On Tue, Apr 15, 2025 at 12:04:21PM +0200, Rafael J. Wysocki wrote:
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
>
> I don't think this is sufficient, because this still permits an incoheren=
t
> policy->min and policy->max combination, which makes it possible for sche=
dutil
> to honor the incoherent limits; i.e., schedutil may observe old policy->m=
in and
> new policy->max or vice-versa.

Yes, it may, as stated in the new comment in cpufreq_driver_resolve_freq().

> We also can't permit a wrong freq to be propagated to the driver and then=
 send
> the _right_ freq afterwards; IOW, we can't let a bogus freq slip through =
and
> just correct it later.

The frequency is neither wrong nor bogus, it is only affected by one
of the limits that were in effect previously or will be in effect
going forward.  They are valid limits in either case.

> How about using a seqlock?

This would mean extra overhead in the scheduler path pretty much for no gai=
n.

