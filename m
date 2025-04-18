Return-Path: <linux-pm+bounces-25735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9DA93FD8
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 00:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B798A4BBA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE222405F5;
	Fri, 18 Apr 2025 22:22:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CD41760;
	Fri, 18 Apr 2025 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014929; cv=none; b=cAD1oMQwFQdHxe3die+C/EAsCJVX4U/uEQzLHFJPD2UbSs96PTHP7KOkarAd3c24dzKddi/2PbKUh+ejNYA1yroZgGwmwW0NzROBVpUJbPh+pgmZ5ruxhGIeeji/UM7ijLkyH5XjPdpy7tRtXA3BqyUGuKrTm2dOZjXPVxKul74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014929; c=relaxed/simple;
	bh=RbSmogPRq03S1EPlow0+8nJKH8FH3eT3MJxT+Xwpt1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwj8y9+m5EJknDjhyNGmHrHhDspVRdAhFYmYj1KHXFGODCChpVm6Nq8CbetnPfwXoSqw8nrHrbFJUZ4aj5TBjyttCoNRpTUffQlU/FuQvkjLw61fLHmQtj/K3OEprmh03BqtftVzEnmQsDHKmeq0bqaApjXz2O8doPc8gkFlSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33677183so27292335ad.2;
        Fri, 18 Apr 2025 15:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014926; x=1745619726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQgwKDl//CnIDRtw8/S7OK5nwyWUJtfy6hYtu6E+PdE=;
        b=Kxv/pCylqS2T5QYkqXPv3hH6Jhr6YULw4QjEMv8+JO9Zlif+SpzBAXaYBUbgelmNeB
         2tovsEqWzlOQshis13xxIWvA9ElyOVZwJRANTtdgbvPro5711uxm8WuTZSSkfoeJsEwt
         KeowJiJzQ+QUXPfd66FTaTUoR+IYeB8ixRpyDxYoJinuCyi7jtm0ANKEm6o3IbWTel33
         M9Ikb5zPUUGGYalntzmeCvXNQXpba7LtZzd2i121e2tVGSM1DBaPYC6UaYy4C8NHc1oz
         XpxrqC4cXaNBx2jp08D22Ss+lu1O/zpJlTXqOPaBJiV6GfGHHWMlhJ3c7VaYcs0XTZVG
         kUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVjPvB8vye3t69M/4PuLYOWP/dId4ti0uM+f2ImftaBtD7/ZhrZV8407aNgUsbHdA/4JtgcR7CrnU=@vger.kernel.org, AJvYcCXcInAhFukmoX0xHC/ydl4EbQ6ydiS4/D7lY8dYlEvTc1ctuLMfyy2RuEPs4+dSI/cLn031Bl9xT7wuI7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXt2RkaLCcWR4aqy+EGuqDrDP0xsJTMPjDSonqNbO4nMiKEdV
	l6KMbhE/OwrE4TrlbfJ5ibmv2t3Ao7ggwoY1Q4O+IEnY6TneO77y
X-Gm-Gg: ASbGncsz044WBjItaB9aNTANjw2Bd58y4v0NqId7SSV+w9rvlTtXqKvb522TPPcEppg
	cNObhOHZPBngXoeogh+ePlG1GXt9HEgyAP+GGvh3ZVma6DdgcCtqLdvaFOKLASgzTrkZqwk75+R
	G2fud50NhorpGMEkZ+xkplW4pM5exciERFbNEZVkgtQyOpyJKbuH+IXVV8G+bIDpEiGPslfihnM
	BXq+2JEyaIhgFgGehfV3EtRJvX5iGzNnsUrg+myr37L6IcVhWG1daWvHj9tZsuEkVka41K15vUA
	LhVB9jfZvUCkXm7zDpTTziZYngeVlYGDczc2LWad/Rgtscrv3jBMyi3q8/AYPdoQR79R7jnLfhT
	rLHjPC5Wv/iFSnQtZLcfcNqVlxU1F
X-Google-Smtp-Source: AGHT+IFgg7Dy3Bc4wEzF0iIjxprDDwNN6zcLJ/LL7OHL8evDMJrmgRU7kPuckPEtWD8Jhve37+9hEA==
X-Received: by 2002:a17:902:f682:b0:224:912:153 with SMTP id d9443c01a7336-22c53573d25mr65655805ad.5.1745014926366;
        Fri, 18 Apr 2025 15:22:06 -0700 (PDT)
Received: from sultan-box.localdomain (n122-107-215-46.sbr1.nsw.optusnet.com.au. [122.107.215.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb491asm21752865ad.116.2025.04.18.15.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 15:22:05 -0700 (PDT)
Date: Sat, 19 Apr 2025 08:21:56 +1000
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 5/6] cpufreq: Avoid using inconsistent policy->min and
 policy->max
Message-ID: <aALQhEi609NQAV7S@sultan-box.localdomain>
References: <6171293.lOV4Wx5bFT@rjwysocki.net>
 <9458818.CDJkKcVGEf@rjwysocki.net>
 <aAIm48RPmm1d_Y6u@sultan-box.localdomain>
 <CAJZ5v0iAmutVUQtMP_yThRx2J39Ng96osv1BMHX0gRf-8oJ3TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iAmutVUQtMP_yThRx2J39Ng96osv1BMHX0gRf-8oJ3TA@mail.gmail.com>

On Fri, Apr 18, 2025 at 09:42:15PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 18, 2025 at 12:18 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > On Tue, Apr 15, 2025 at 12:04:21PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Since cpufreq_driver_resolve_freq() can run in parallel with
> > > cpufreq_set_policy() and there is no synchronization between them,
> > > the former may access policy->min and policy->max while the latter
> > > is updating them and it may see intermediate values of them due
> > > to the way the update is carried out.  Also the compiler is free
> > > to apply any optimizations it wants both to the stores in
> > > cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
> > > which may result in additional inconsistencies.
> > >
> > > To address this, use WRITE_ONCE() when updating policy->min and
> > > policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> > > them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
> > > in cpufreq_set_policy() to avoid storing intermediate values in
> > > policy->min and policy->max with the help of the observation that
> > > their new values are expected to be properly ordered upfront.
> > >
> > > Also modify cpufreq_driver_resolve_freq() to take the possible reverse
> > > ordering of policy->min and policy->max, which may happen depending on
> > > the ordering of operations when this function and cpufreq_set_policy()
> > > run concurrently, into account by always honoring the max when it
> > > turns out to be less than the min (in case it comes from thermal
> > > throttling or similar).
> > >
> > > Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> > > Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2: Minor edit in the subject
> > >
> > > ---
> > >  drivers/cpufreq/cpufreq.c |   46 ++++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > >
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -490,14 +490,12 @@
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
> > >
> > > -static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
> > > -                                        unsigned int target_freq,
> > > -                                        unsigned int relation)
> > > +static unsigned int __resolve_freq(struct cpufreq_policy *policy,
> > > +                                unsigned int target_freq,
> > > +                                unsigned int relation)
> > >  {
> > >       unsigned int idx;
> > >
> > > -     target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > -
> > >       if (!policy->freq_table)
> > >               return target_freq;
> > >
> > > @@ -507,6 +505,15 @@
> > >       return policy->freq_table[idx].frequency;
> > >  }
> > >
> > > +static unsigned int clamp_and_resolve_freq(struct cpufreq_policy *policy,
> > > +                                        unsigned int target_freq,
> > > +                                        unsigned int relation)
> > > +{
> > > +     target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > +
> > > +     return __resolve_freq(policy, target_freq, relation);
> > > +}
> > > +
> > >  /**
> > >   * cpufreq_driver_resolve_freq - Map a target frequency to a driver-supported
> > >   * one.
> > > @@ -521,7 +528,22 @@
> > >  unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> > >                                        unsigned int target_freq)
> > >  {
> > > -     return clamp_and_resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
> > > +     unsigned int min = READ_ONCE(policy->min);
> > > +     unsigned int max = READ_ONCE(policy->max);
> > > +
> > > +     /*
> > > +      * If this function runs in parallel with cpufreq_set_policy(), it may
> > > +      * read policy->min before the update and policy->max after the update
> > > +      * or the other way around, so there is no ordering guarantee.
> > > +      *
> > > +      * Resolve this by always honoring the max (in case it comes from
> > > +      * thermal throttling or similar).
> > > +      */
> > > +     if (unlikely(min > max))
> > > +             min = max;
> > > +
> > > +     return __resolve_freq(policy, clamp_val(target_freq, min, max),
> > > +                           CPUFREQ_RELATION_LE);
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> > >
> > > @@ -2632,11 +2654,15 @@
> > >        * Resolve policy min/max to available frequencies. It ensures
> > >        * no frequency resolution will neither overshoot the requested maximum
> > >        * nor undershoot the requested minimum.
> > > +      *
> > > +      * Avoid storing intermediate values in policy->max or policy->min and
> > > +      * compiler optimizations around them because them may be accessed
> > > +      * concurrently by cpufreq_driver_resolve_freq() during the update.
> > >        */
> > > -     policy->min = new_data.min;
> > > -     policy->max = new_data.max;
> > > -     policy->min = clamp_and_resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
> > > -     policy->max = clamp_and_resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
> > > +     WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
> > > +     new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
> > > +     WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
> >
> > I don't think this is sufficient, because this still permits an incoherent
> > policy->min and policy->max combination, which makes it possible for schedutil
> > to honor the incoherent limits; i.e., schedutil may observe old policy->min and
> > new policy->max or vice-versa.
> 
> Yes, it may, as stated in the new comment in cpufreq_driver_resolve_freq().

Thanks for pointing that out; I had ignored that hunk while reviewing.

But I ignored it because schedutil still accesses policy->min/max unprotected
via cpufreq_policy_apply_limits() and __cpufreq_driver_target(). The race still
affects those calls.

> > We also can't permit a wrong freq to be propagated to the driver and then send
> > the _right_ freq afterwards; IOW, we can't let a bogus freq slip through and
> > just correct it later.
> 
> The frequency is neither wrong nor bogus, it is only affected by one
> of the limits that were in effect previously or will be in effect
> going forward.  They are valid limits in either case.

I would argue that limits only make sense as a pair, not on their own. Checking
for min > max only covers the case where the new min exceeds the old max; this
means that, when min is raised without exceeding the old max, a thermal throttle
attempt could instead result in a raised frequency floor:

	1. policy->min == 100000, policy->max == 2500000
	2. Policy limit update request: new min of 400000, new max of 500000
	3. schedutil observes policy->min == 400000, policy->max == 2500000

Raising the min freq while lowering the max freq can be a valid thermal throttle
scheme. But it only makes sense if both limits are applied simultaneously.

> > How about using a seqlock?
> 
> This would mean extra overhead in the scheduler path pretty much for no gain.

Or there's the slightly cursed approach of using a union to facilitate an atomic
64-bit store of policy->min and max at the same time, since min/max are 32 bits.

Sultan

