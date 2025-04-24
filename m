Return-Path: <linux-pm+bounces-26136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D9A9B443
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F8F4A140E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA228A1EE;
	Thu, 24 Apr 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLe4Mxhr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D728A1DE;
	Thu, 24 Apr 2025 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512678; cv=none; b=Myma/DVjQYjWl404R+VGpL5uumzloadyhuscDWhmOtOyQpdsGJDO5aV2jyd0oAdVasMvNWnjwOCxkFOqfXUUVVXnsOskMMokekGKmrxl86RKPrj643bSw4smYjqRxxVpG4CKm1tAXYvjMs8xBvDV9Z+vauTYAguKT4lezT3HoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512678; c=relaxed/simple;
	bh=75jln6LEMO03hVH9iAYUgykLezto+kBXZ6oxvXwQCyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wfg9GHXUCmYe1x3XEzIozrlb+sKNQwCOgpEDxFiPC9NutI4VPDZieOrLoaAA8tWjpMmsa9BIwVBE38YFICZxOvhLh9f6FOhE+K4ybyKbNQSiPg0o3imP6wjzknhsaV55q939wHhXWbL8u/XFoQrvzCbaOof7oNPbDORuGUYrVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLe4Mxhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED0C4AF0D;
	Thu, 24 Apr 2025 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745512678;
	bh=75jln6LEMO03hVH9iAYUgykLezto+kBXZ6oxvXwQCyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QLe4MxhrV+PoRvaSjlnZbkHpTk3oAGaVl0HQxVNTAdZFo6KWRVwL2C9eb9/uyunLO
	 1bC4A+C5ZwPZYqOm1k2Jf2vug11Hkyk4IIZTEC6slvOubTsLdqN4EJTPbW0kze+alr
	 DmSuLXQwtpotQlyZ/v9WH0KrG8sIM+E+dUaZEMIoTHcMV0JhMtcaNrOgAPqve8LQGu
	 A3r0/x1BB/FA8o2kEWxYsnQBCdxzc5L0wYF/1er/r0D7KU0LDlDEWqVRJPjOgWSqt0
	 Q3Zq6ACNeQvkVvfl8xDFy1sFRxBG0vn21/F3FsPVB7MtnrpEVveaP7X5dAeksPK9f1
	 bdnn67kC5WFNA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c759bf1b2eso727858fac.1;
        Thu, 24 Apr 2025 09:37:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr40Ttng4mhuth2jCgeafJ6mF/hZTtcOT2Swc8usTgPHA2TByXFJ9rUtAF4YYlqAChsntenCygTCE=@vger.kernel.org, AJvYcCVwNdB2rFjbGxwUPPp6kC6P6QFKjjODViyIpxFG4OnJzYhc/Se74wh5/qbd1VLc0z9apgSapnMZeFpUA/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3+vkBHql0k06j32vFknGxNijhl0PVK+Xpl3Gl7XZ3hE4DuR7
	ftWeeb39CmqWbomLs+5D5zuCfnHv4Ecb3+mQQJ7vN7t7fbxd7EunJUdGCE1UmA68Sx24l/YT8sW
	GLNEbxBc7f3jl8GHFbYueuK+rKv4=
X-Google-Smtp-Source: AGHT+IEg1J5xXm9XOkaHWMAYzrmv33gOLU3mzP0WDBnJLhDt0R6tb2NbVVIcbImspZHlJ5HflQfWMBci+tJa/An5b3U=
X-Received: by 2002:a05:6870:3922:b0:2c2:588a:70a3 with SMTP id
 586e51a60fabf-2d9944a79c2mr277187fac.24.1745512677229; Thu, 24 Apr 2025
 09:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5907080.DvuYhMxLoT@rjwysocki.net> <aAplED3IA_J0eZN0@linaro.org>
In-Reply-To: <aAplED3IA_J0eZN0@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Apr 2025 18:37:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7-LuBX5VCwn_LhyT=RkmQMn6qv3duc+RViXxJBwk2LA@mail.gmail.com>
X-Gm-Features: ATxdqUGAHUK_pyq-9k1XpMPUGY7m0PyuBYwh8znLEMssnOVhN3IZGJ2kqSWcPkw
Message-ID: <CAJZ5v0i7-LuBX5VCwn_LhyT=RkmQMn6qv3duc+RViXxJBwk2LA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: Avoid using inconsistent policy->min and policy->max
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Sultan Alsawaf <sultan@kerneltoast.com>, Peter Zijlstra <peterz@infradead.org>, 
	Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>, regressions@lists.linux.dev, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 24, 2025 at 6:21=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> Hi Rafael,
>
> On Wed, Apr 16, 2025 at 04:12:37PM +0200, Rafael J. Wysocki wrote:
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
> > This replaces the last 3 patches in
> >
> > https://lore.kernel.org/linux-pm/6171293.lOV4Wx5bFT@rjwysocki.net/
> >
> > v2 -> v3:
> >    * Fold 3 patches into one.
> >    * Drop an unrelated white space fixup change.
> >    * Fix a typo in a comment (Christian).
> >
> > v1 -> v2: Cosmetic changes
> >
> > ---
> >  drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++++++++++-------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -495,8 +495,6 @@
> >  {
> >       unsigned int idx;
> >
> > -     target_freq =3D clamp_val(target_freq, policy->min, policy->max);
> > -
> >       if (!policy->freq_table)
> >               return target_freq;
> >
> > @@ -520,7 +518,22 @@
> >  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy=
,
> >                                        unsigned int target_freq)
> >  {
> > -     return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
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
> > @@ -2338,6 +2351,7 @@
> >       if (cpufreq_disabled())
> >               return -ENODEV;
> >
> > +     target_freq =3D clamp_val(target_freq, policy->min, policy->max);
> >       target_freq =3D __resolve_freq(policy, target_freq, relation);
> >
> >       pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kH=
z\n",
> > @@ -2631,11 +2645,15 @@
> >        * Resolve policy min/max to available frequencies. It ensures
> >        * no frequency resolution will neither overshoot the requested m=
aximum
> >        * nor undershoot the requested minimum.
> > +      *
> > +      * Avoid storing intermediate values in policy->max or policy->mi=
n and
> > +      * compiler optimizations around them because they may be accesse=
d
> > +      * concurrently by cpufreq_driver_resolve_freq() during the updat=
e.
> >        */
> > -     policy->min =3D new_data.min;
> > -     policy->max =3D new_data.max;
> > -     policy->min =3D __resolve_freq(policy, policy->min, CPUFREQ_RELAT=
ION_L);
> > -     policy->max =3D __resolve_freq(policy, policy->max, CPUFREQ_RELAT=
ION_H);
> > +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUF=
REQ_RELATION_H));
> > +     new_data.min =3D __resolve_freq(policy, new_data.min, CPUFREQ_REL=
ATION_L);
> > +     WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max =
: new_data.min);
>
> I've tested the cpufreq throttling again in 6.15-rc3 to check your fix
> for the schedutil CPUFREQ_NEED_UPDATE_LIMITS regression I reported [1].
> The CPU frequency is now being throttled correctly when reaching high
> temperatures. Thanks for fixing this!
>
> Unfortunately, the opposite case has now regressed with this patch:
> After the CPU frequency has been throttled due to high temperature and
> the device cools down again, the CPU frequency is stuck at minimum until
> you reboot. policy->max will never restore to the maximum frequency.
>
> I've confirmed that this causes unexpected slowness after temperature
> throttling on a Qualcomm X1E laptop, and Johan has confirmed that e.g.
> the ThinkPad X13s is also affected. I would expect that most devices
> using cpufreq cooling in the kernel are affected.
>
> Looking at the code, I think the problem is that __resolve_freq() ->
> cpufreq_frequency_table_target() -> cpufreq_table_find_index*() and
> cpufreq_is_in_limits() are still using the old policy->min/max value.
> In this patch, you have only moved the clamp_val() usage directly in
> __resolve_freq().

You are right, that's the problem.

The fix is basically straightforward, pass min and max to
cpufreq_frequency_table_target() and propagate downward, but making
that change may be somewhat error-prone.

I'll try to cut a patch to test tomorrow.

Thanks!

