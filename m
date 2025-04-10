Return-Path: <linux-pm+bounces-25058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10245A8361A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 03:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BF018952AC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 01:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6331AF0BB;
	Thu, 10 Apr 2025 01:52:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D23596F;
	Thu, 10 Apr 2025 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249948; cv=none; b=ZB5gPxm3JeTV12cKiRf1w0WKjDpeT/si4ZSoawsg2VbEjBqoOd/e4MHWZbCz/fN2XD6b3J3d9fNd06kmTN0/bFW7kNhvVrMUutccctdh+MqfhowCmHoPdRCUUvY3DfU7ynVRnShq2WLvLku8K/ATTmD56FDCqV8bi7t84UC9DQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249948; c=relaxed/simple;
	bh=vKLzshF1zBPzzTMXiGt8BdyQZzHIDPA5ufOZaf1gACk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/ieysIhYXTVRH8l6BuaH/9upOUGY6dSfXVlxcYcyVFGZDUTVzr5jFM1tVYYsY+XgbxQfZA0ijYhvdk4p9qiu4Rr24KLN0GTxnicgZnXwY1fdrrBaNEeV3z1lBJyhYJdOmfOE2hn5EbhyhRSDfG58P+0+jZPEJO3wqEw7jiSZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2254e0b4b79so3792565ad.2;
        Wed, 09 Apr 2025 18:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744249944; x=1744854744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaJxqLk3V06ArQnoQFKz5rLPJR/azvazadpvaNzDZW8=;
        b=PQIEkQX0ucShjrpg8ZrCh+3wri4vk5AToyfIAtrkQ58fdieZdfDlQBhY0mjpycrmcP
         OLJJl5HhFYGmTu1Qz17edVMf9c9ffNHrBlDAZoUbdOqYy/S/B0WhK0MfgpGVzfkVWk4a
         UTRRpjpmcq/XZWyDicmMrnH4HgnPs36O+WFrxZyo+0uytkP5a6B4USJWYLDycJBW0lkk
         +id/P0Ool00T+j+P90PBN+nYJ3UEosbgvW8KcaLXzoSxSxYBgnHekrXmSFmYTUGgy+Pu
         qeqykfog2P1br3hLK2/4o4iP1/jsAELGkVuuYzt3+98K4bVraxxzNPaYBncCvimemrZc
         M0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUVvwoWoIMCYI1DEL6eI0sfTb7PluPnLIg6HaIR/i+OSn0skz/+Iphf72/vjH+VWe2ihzwdASHfNBp61Pc=@vger.kernel.org, AJvYcCXkXWxeP4dADW52GAk8bhvNHYiGUnXJ/nf7LJKpfU4JISYKcO44UoxjB4eGcDGJwKCBYMrBec+RQf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBqVmlSdRg3cVc1A8Y8PL+0QIEdYa4jldji4yE+6Corf1NZUu
	LUqBvdPf6y6yqoU1En+NvncGnftyWtE0S2wDqRsmn79AAPopzKbe
X-Gm-Gg: ASbGnctULVsmlToqsvGJXC4uKNXmQc7Urqgzh/1o6/Ty5PilbI6B2SC75/NkiqRBf1i
	80rbmX/9KyX8m705RMsOru5ApToS8J1txAWQmZZCmAQ/VrT4U/Nhr1JIahmFLWpaNi25dz/tPW9
	6ZR+mfu1FAygSI8YmTCDD8n1C8l2S8rz+hASjOHcW5QVPqVQYhTACuYk6gSktNi4TZQN7uK2Zsm
	wpYNOy62Jtl8GtjYH742rWp7TF2O9x5iZatmKlztwMx7CvYTVE2wEQISwb1Kg7tB1n2CInSrEcj
	Y830VfmJhcJRBA6pJjcoYFlm2fNhvzCRsLv52m72F4IgPw5urhJEOIpT0aI=
X-Google-Smtp-Source: AGHT+IH5DMA8QYKm1WbSD1sLTN8mlWGKoMcvZflMV5qQELvdqIA+8gtpJaS3iupJUAV6K+BCGVRtRg==
X-Received: by 2002:a17:902:f64d:b0:21f:164d:93fe with SMTP id d9443c01a7336-22be04199b5mr8933505ad.53.1744249944613;
        Wed, 09 Apr 2025 18:52:24 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10dc40sm2679257a91.9.2025.04.09.18.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 18:52:24 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:52:20 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused
 by need_freq_update
Message-ID: <Z_ckVIK5zAeHHyVb@sultan-box.localdomain>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
 <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>
 <Z_VTRspvmOUfrawh@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_VTRspvmOUfrawh@linaro.org>

On Tue, Apr 08, 2025 at 06:48:06PM +0200, Stephan Gerhold wrote:
> Hi Sultan,
> 
> On Tue, Apr 08, 2025 at 08:22:20AM -0700, Sultan Alsawaf wrote:
> > On Tue, Apr 08, 2025 at 10:59:31AM +0200, Stephan Gerhold wrote:
> > > On Wed, Dec 11, 2024 at 05:57:32PM -0800, Sultan Alsawaf wrote:
> > > > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> > > > 
> > > > A redundant frequency update is only truly needed when there is a policy
> > > > limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> > > > 
> > > > In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive a
> > > > frequency update _all the time_, not just for a policy limits change,
> > > > because need_freq_update is never cleared.
> > > > 
> > > > Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also leads
> > > > to a redundant frequency update, regardless of whether or not the driver
> > > > specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is the
> > > > same as the current one.
> > > > 
> > > > Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> > > > when there's a policy limits change, and clearing need_freq_update when a
> > > > requisite redundant update occurs.
> > > > 
> > > > This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS test
> > > > and instead setting need_freq_update to false in sugov_update_next_freq().
> > > > 
> > > > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> > > > ---
> > > >  kernel/sched/cpufreq_schedutil.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > index 28c77904ea74..e51d5ce730be 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > > >  
> > > >  	if (unlikely(sg_policy->limits_changed)) {
> > > >  		sg_policy->limits_changed = false;
> > > > -		sg_policy->need_freq_update = true;
> > > > +		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > >  		return true;
> > > >  	}
> > > >  
> > > > @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > > >  				   unsigned int next_freq)
> > > >  {
> > > >  	if (sg_policy->need_freq_update)
> > > > -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > > +		sg_policy->need_freq_update = false;
> > > >  	else if (sg_policy->next_freq == next_freq)
> > > >  		return false;
> > > >  
> > > 
> > > This patch breaks cpufreq throttling (e.g. for thermal cooling) for
> > > cpufreq drivers that:
> > > 
> > >  - Have policy->fast_switch_enabled/fast_switch_possible set, but
> > >  - Do not have CPUFREQ_NEED_UPDATE_LIMITS flag set
> > > 
> > > There are several examples for this in the tree (search for
> > > "fast_switch_possible"). Of all those drivers, only intel-pstate and
> > > amd-pstate (sometimes) set CPUFREQ_NEED_UPDATE_LIMITS.
> > > 
> > > I can reliably reproduce this with scmi-cpufreq on a Qualcomm X1E
> > > laptop:
> > > 
> > >  1. I added some low temperature trip points in the device tree,
> > >     together with passive cpufreq cooling.
> > >  2. I run a CPU stress test on all CPUs and monitor the temperatures
> > >     and CPU frequencies.
> > > 
> > > When using "performance" governor instead of "schedutil", the CPU
> > > frequencies are being throttled as expected, as soon as the temperature
> > > trip points are reached.
> > > 
> > > When using "schedutil", the CPU frequencies stay at maximum as long as
> > > the stress test is running. No throttling happens, so the device heats
> > > up far beyond the defined temperature trip points. Throttling is applied
> > > only after stopping the stress test, since this forces schedutil to
> > > re-evaluate the CPU frequency.
> > > 
> > > Reverting this commit fixes the problem.
> > > 
> > > Looking at the code, I think the problem is that:
> > >  - sg_policy->limits_changed does not result in
> > >    sg->policy->need_freq_update without CPUFREQ_NEED_UPDATE_LIMITS
> > >    anymore, and
> > >  - Without sg->policy->need_freq_update, get_next_freq() skips calling
> > >    cpufreq_driver_resolve_freq(), which would normally apply the policy
> > >    min/max constraints.
> > > 
> > > Do we need to set CPUFREQ_NEED_UPDATE_LIMITS for all cpufreq drivers
> > > that set policy->fast_switch_possible? If I'm reading the documentation
> > > comment correctly, that flag is just supposed to enable notifications if
> > > the policy min/max changes, but the resolved target frequency is still
> > > the same. This is not the case here, the target frequency needs to be
> > > throttled, but schedutil isn't applying the new limits.
> > > 
> > > Any suggestions how to fix this? I'm happy to test patches with my
> > > setup.
> > 
> > Thank you for reporting this. As I see it, sg_policy->need_freq_update is
> > working correctly now; however, sg_policy->limits_changed relied on the broken
> > behavior of sg_policy->need_freq_update and therefore sg_policy->limits_changed
> > needs to be fixed.
> 
> Thanks for the quick reply and the patch!
> 
> > 
> > Can you try this patch:
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 1a19d69b91ed3..f37b999854d52 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  		return false;
> >  
> >  	if (unlikely(sg_policy->limits_changed)) {
> > -		sg_policy->limits_changed = false;
> >  		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> >  		return true;
> >  	}
> > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  	freq = get_capacity_ref_freq(policy);
> >  	freq = map_util_freq(util, freq, max);
> >  
> > -	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > +	if (freq == sg_policy->cached_raw_freq && !sg_policy->limits_changed &&
> > +	    !sg_policy->need_freq_update)
> >  		return sg_policy->next_freq;
> >  
> > +	sg_policy->limits_changed = false;
> >  	sg_policy->cached_raw_freq = freq;
> >  	return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> > 
> 
> This is working correctly for me, CPU frequency is being throttled again
> when the temperature trip points are reached.

Great to hear, thanks for testing that so quickly!

> If you send this, feel free to add:
> 
> Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>

I'll do Reported-and-tested-by if you don't mind. :-)

> 
> Thanks!
> Stephan

Thanks,
Sultan

