Return-Path: <linux-pm+bounces-26190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1672A9C6A3
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D017C4C4CF2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8CF219305;
	Fri, 25 Apr 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oByanJhM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AADC23E235;
	Fri, 25 Apr 2025 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579014; cv=none; b=GhjfOCPL1wT1LrXkzapGTwpzaJsjsWigNpAydfeqZyKCt5T9GBk56c0G6jg6/ilfYf3QKcNNB5wc2C/vPUO1GwqqVNrBSLYat/GS+/kRBsD5gbW2imPlQ40MzlB0G/dV8DiJ/FemcmPZMIJ6IL8eIcZpg0J8P9NmqZbqa7ZWX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579014; c=relaxed/simple;
	bh=53F6fAKEqiAEBwV0oYCLetHRtRnA9Hp2t7gbv8+IcH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRA5yTvaf1+6UiHQctz//lQ2P+wmfUYQKPUZu603sXCnSPWWAT1wrnxW754D53aR3R34xp7c6oaHoS2wN4QSoaOozIZpErdCiJCiN1DVTf6Zyy2MmUK5z99zimEQPUWUtz4me/IVkSVgPDWzsLO7Ga/JQqgo5nfkBYI3bKrCNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oByanJhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775DDC4CEEF;
	Fri, 25 Apr 2025 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579013;
	bh=53F6fAKEqiAEBwV0oYCLetHRtRnA9Hp2t7gbv8+IcH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oByanJhMS/MqzXwI6xVMvTQ2gpY5dT1UdRqHhnPFMuYDWlrGfAXUvbsfsaXKYU6xY
	 bx19V2vSLb8LWOWdPxeFO1Ba6po1geOvIfB7Nmf4tjTo3tJWz7dYqu8NvacqYbE9MP
	 Z1DEBNZeIA/oMgCyx49fsXNCi3qrl0hDvJmRefs5/7ZtG09dShhevwtfb/o3Ai6BDh
	 I6jAvb0JnjULZlouO/b0kbFKy3DQY1lozlZ7E4ho5aeu1gVSN22FN6zV8EPU8qx2Zp
	 27BhWjjm7vlUn5ArlbLdm2IXkUfFGfXgbYgG1vRu3qV75dYfn8PAvT/uewf7wk4tkf
	 TJ0J/+jwydiQA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2cc57330163so1428339fac.2;
        Fri, 25 Apr 2025 04:03:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVypDyEfucNEhF+kxrkyOxsRaCpdfiXAeDYR39ugveJCzIJEPdBCFWoh/MUHELvM3L+S+7+HKCaxms8hGA=@vger.kernel.org, AJvYcCXzZXAhv6hARQAArU70zcqzxiBkkHP0T9L1lH3cjHmGbcAs5qpMsMSGxhnUb75sR74Wf39OArCu2GU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2v/3wUO2wlEEvJ55qOF/h8/fV079U9cI4CDfMR1pQG53iNqi
	BIm5JY++0HUhpuNgi5Gyk9yX9nqSXJFNrtiKR2Qg+hLZ7jkNqAjjvrPeZa5GmMB2MoAc1DkVDPZ
	Zuxd+HAfZtD/XGvVt1Cu5EEG3nIo=
X-Google-Smtp-Source: AGHT+IHrcrYjE1ggxwUYvjR9ha03ZKu+8Bsgk/bdz1CrmUYmRwOt7sEsQPl8gIa/4t3Ye5EJGa3Ye57mC87sUMoO4DE=
X-Received: by 2002:a05:6871:5807:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2d9a3575ca3mr954235fac.36.1745579012693; Fri, 25 Apr 2025
 04:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5907080.DvuYhMxLoT@rjwysocki.net> <aAplED3IA_J0eZN0@linaro.org>
 <CAJZ5v0i7-LuBX5VCwn_LhyT=RkmQMn6qv3duc+RViXxJBwk2LA@mail.gmail.com> <12665363.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12665363.O9o76ZdvQC@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 13:03:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icLndnA=mQEDabMtxRn942PiRthV3u12PB4eorTCLjDg@mail.gmail.com>
X-Gm-Features: ATxdqUGOyTC_-puYKqRGPCiWoUPzRa0Z1dchrr3piVjbjYhRop7C8qldP09Ntuk
Message-ID: <CAJZ5v0icLndnA=mQEDabMtxRn942PiRthV3u12PB4eorTCLjDg@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: Avoid using inconsistent policy->min and policy->max
To: Stephan Gerhold <stephan.gerhold@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Sultan Alsawaf <sultan@kerneltoast.com>, Peter Zijlstra <peterz@infradead.org>, 
	Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>, regressions@lists.linux.dev, 
	Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 9:36=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> On Thursday, April 24, 2025 6:37:46 PM CEST Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Thu, Apr 24, 2025 at 6:21=E2=80=AFPM Stephan Gerhold
> > <stephan.gerhold@linaro.org> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Wed, Apr 16, 2025 at 04:12:37PM +0200, Rafael J. Wysocki wrote:
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
> > > > This replaces the last 3 patches in
> > > >
> > > > https://lore.kernel.org/linux-pm/6171293.lOV4Wx5bFT@rjwysocki.net/
> > > >
> > > > v2 -> v3:
> > > >    * Fold 3 patches into one.
> > > >    * Drop an unrelated white space fixup change.
> > > >    * Fix a typo in a comment (Christian).
> > > >
> > > > v1 -> v2: Cosmetic changes
> > > >
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++++++++++-------
> > > >  1 file changed, 25 insertions(+), 7 deletions(-)
> > > >
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -495,8 +495,6 @@
> > > >  {
> > > >       unsigned int idx;
> > > >
> > > > -     target_freq =3D clamp_val(target_freq, policy->min, policy->m=
ax);
> > > > -
> > > >       if (!policy->freq_table)
> > > >               return target_freq;
> > > >
> > > > @@ -520,7 +518,22 @@
> > > >  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *po=
licy,
> > > >                                        unsigned int target_freq)
> > > >  {
> > > > -     return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_L=
E);
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
> > > > @@ -2338,6 +2351,7 @@
> > > >       if (cpufreq_disabled())
> > > >               return -ENODEV;
> > > >
> > > > +     target_freq =3D clamp_val(target_freq, policy->min, policy->m=
ax);
> > > >       target_freq =3D __resolve_freq(policy, target_freq, relation)=
;
> > > >
> > > >       pr_debug("target for CPU %u: %u kHz, relation %u, requested %=
u kHz\n",
> > > > @@ -2631,11 +2645,15 @@
> > > >        * Resolve policy min/max to available frequencies. It ensure=
s
> > > >        * no frequency resolution will neither overshoot the request=
ed maximum
> > > >        * nor undershoot the requested minimum.
> > > > +      *
> > > > +      * Avoid storing intermediate values in policy->max or policy=
->min and
> > > > +      * compiler optimizations around them because they may be acc=
essed
> > > > +      * concurrently by cpufreq_driver_resolve_freq() during the u=
pdate.
> > > >        */
> > > > -     policy->min =3D new_data.min;
> > > > -     policy->max =3D new_data.max;
> > > > -     policy->min =3D __resolve_freq(policy, policy->min, CPUFREQ_R=
ELATION_L);
> > > > -     policy->max =3D __resolve_freq(policy, policy->max, CPUFREQ_R=
ELATION_H);
> > > > +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, =
CPUFREQ_RELATION_H));
> > > > +     new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ=
_RELATION_L);
> > > > +     WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->=
max : new_data.min);
> > >
> > > I've tested the cpufreq throttling again in 6.15-rc3 to check your fi=
x
> > > for the schedutil CPUFREQ_NEED_UPDATE_LIMITS regression I reported [1=
].
> > > The CPU frequency is now being throttled correctly when reaching high
> > > temperatures. Thanks for fixing this!
> > >
> > > Unfortunately, the opposite case has now regressed with this patch:
> > > After the CPU frequency has been throttled due to high temperature an=
d
> > > the device cools down again, the CPU frequency is stuck at minimum un=
til
> > > you reboot. policy->max will never restore to the maximum frequency.
> > >
> > > I've confirmed that this causes unexpected slowness after temperature
> > > throttling on a Qualcomm X1E laptop, and Johan has confirmed that e.g=
.
> > > the ThinkPad X13s is also affected. I would expect that most devices
> > > using cpufreq cooling in the kernel are affected.
> > >
> > > Looking at the code, I think the problem is that __resolve_freq() ->
> > > cpufreq_frequency_table_target() -> cpufreq_table_find_index*() and
> > > cpufreq_is_in_limits() are still using the old policy->min/max value.
> > > In this patch, you have only moved the clamp_val() usage directly in
> > > __resolve_freq().
> >
> > You are right, that's the problem.
> >
> > The fix is basically straightforward, pass min and max to
> > cpufreq_frequency_table_target() and propagate downward, but making
> > that change may be somewhat error-prone.
> >
> > I'll try to cut a patch to test tomorrow.
>
> Actually, I have it already, so please find appended.
>
> Please give it a go as soon as you reasonably can.
>
> Thanks!
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] cpufreq: Fix setting policy limits when frequency tab=
les are used
>
> Commit 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and
> policy->max") overlooked the fact that policy->min and policy->max were
> accessed directly in cpufreq_frequency_table_target() and in the
> functions called by it and the changes made by that commit led to
> problems with setting policy limits.
>
> Address this by passing the target frequency limits to __resolve_freq()
> and cpufreq_frequency_table_target() and propagating them to the
> functions called by the latter.
>
> Fixes: 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and p=
olicy->max")
> Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c          |   22 ++++++----
>  drivers/cpufreq/cpufreq_ondemand.c |    3 -
>  drivers/cpufreq/freq_table.c       |    6 +-
>  include/linux/cpufreq.h            |   81 ++++++++++++++++++++++++------=
-------
>  4 files changed, 72 insertions(+), 40 deletions(-)
>
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -491,14 +491,18 @@
>  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
>
>  static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> -               unsigned int target_freq, unsigned int relation)
> +                                  unsigned int target_freq,
> +                                  unsigned int min, unsigned int max,
> +                                  unsigned int relation)
>  {
>         unsigned int idx;
>
>         if (!policy->freq_table)
>                 return target_freq;
>
> -       idx =3D cpufreq_frequency_table_target(policy, target_freq, relat=
ion);
> +       target_freq =3D clamp_val(target_freq, min, max);

This needs to be done before the freq_table check above or drivers
without freq tables will have a problem.

I'll send an update of this patch shortly.

Thanks!

