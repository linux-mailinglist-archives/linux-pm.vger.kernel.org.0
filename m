Return-Path: <linux-pm+bounces-24949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8AA80FE3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC54C170005
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37112227EBD;
	Tue,  8 Apr 2025 15:22:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A91D5CCD;
	Tue,  8 Apr 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125749; cv=none; b=J8NFDCSijDkzsp9IGsbbz6NxN1wX4+YkkuWzQmbKIUOCuJ6m31MBLu+xHFUNrDJ8zehVQ3KuuV6O5iu3D/hp5cLlKx2EIQHrmpTqDw5o8cEXewRsyZx6qA4PY7xklY9xw3R55EbkMH+63w1XlyNNT9uLywTRG1tyifHLR2dGgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125749; c=relaxed/simple;
	bh=Zd9NWY8CeLpfatz1dGJTJYTsqlKS4JB6NgIxmQhqYb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJTrLPK3SusgIOaiLlGXSYp6pr+r67C4799KhxOug4bgLqxrso/SZkhbCiF8pUk9wcrVFOF8QhkLmDC2CaO4MZt5wgMWOZkC2ivJcotjY0W8KXz/7hFI8j+bZRSaJafKF1u0owYUiQPRiDHAG792AnX0qWSakPfBKAXuJdM38d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227b828de00so56901375ad.1;
        Tue, 08 Apr 2025 08:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125745; x=1744730545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lm+t/vI8lVFf9WHLlENTbYY2NK46dgivCLq/xG2L0k=;
        b=ADdZBZgR9R0yRZ9O/wRNA5sVD0BNxfaCLXizYEdaoiXRItXmciWtEzN+nPEF/YR8gH
         5Of0BAcO1PJ/va/ictd/hrRNqQybpx/OiMBxhd4SlxuaYSN58mRVXXFeVblt5Gk+nK3a
         /LVinOYLgcmiNawNYCxHeJuGEPfnacFM9uODJEbkWW6txc8uP4xThn6s1Ari7/7cJUNa
         4x0iRXly2eY/dnNpgnQvlDRjWL4VW5/OEjoJj48i7x9nUBhQYbsHuI3jLnHqvaVgzS6s
         Xa3GNwUoOHGrHXYDwwSoPK2iCnqBPsxqPKFw2/CXaRdOEMbMiY/UdPbI7C0Zdxv5T2YX
         q4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWuaPcW8kf6VPMZmK++VKx3zKxd4tidZbLJirO8fY/KIYqepcfdBa0qEYmrdNjpu8CLdbqzTHdI34=@vger.kernel.org, AJvYcCWbhA4ujpNzuLoesPlmzCzP48g3fiz9kc4XyKYspBrfuZ+UrkNZN3KNETKhqWq/iz/lPZD+mL4lGktJn4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBdp5Ckj7MxLCI17uII+QvlNQE6OdWY7vt6v6Y/R6h/URYTf1
	MDY4mPUU4NVSRYudao51RfgNRfFXsXM+enGGAQOZlQqG95I19HyT
X-Gm-Gg: ASbGncsUBRgV1O3CCZUf+aEjg8g2KiUsUjmpY3Z5eBmt46tlzUtP9FdecyouUhzVadA
	Rm3FNKpr7wny8yHcTT52X9DXZt5/+rGPCpiJyTTNbatE1aTbfCdb5QpvqS15P4+ccutlNvBLBb/
	3Z6EYyqia942Vl5S9Qjfeq7JX/C7MsiKllZQEWsHpazYlqh9G9Z0lva9UiQHyP8fXvKsx7WdR+N
	vV8XL92/OQ4Weg3+4nQoObwi3sChKGnLdQoY5dhIKeX9DFyNmmhukuDLZYkl9UNs0hYzEa7lhWI
	S+Z434DpYeMVkX1Q296f/YkrBvbD98SWWYdFRloBL79Ao+Z9wKTCaN6oxyarCFOvh4/DaR1nnQ=
	=
X-Google-Smtp-Source: AGHT+IFinU7HdbOjTqhDEfAVUeUY/1h2L7SL99XFLsfwYhOW3YO5nfnKCUYKpUDfuOdjnSMmkDy6zA==
X-Received: by 2002:a17:902:e785:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22a9552b138mr193548115ad.19.1744125745135;
        Tue, 08 Apr 2025 08:22:25 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865bdaesm101468625ad.111.2025.04.08.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:22:24 -0700 (PDT)
Date: Tue, 8 Apr 2025 08:22:20 -0700
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
Message-ID: <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
 <Z_Tlc6Qs-tYpxWYb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Tlc6Qs-tYpxWYb@linaro.org>

Hi Stephan,

On Tue, Apr 08, 2025 at 10:59:31AM +0200, Stephan Gerhold wrote:
> Hi,
> 
> On Wed, Dec 11, 2024 at 05:57:32PM -0800, Sultan Alsawaf wrote:
> > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> > 
> > A redundant frequency update is only truly needed when there is a policy
> > limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> > 
> > In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive a
> > frequency update _all the time_, not just for a policy limits change,
> > because need_freq_update is never cleared.
> > 
> > Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also leads
> > to a redundant frequency update, regardless of whether or not the driver
> > specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is the
> > same as the current one.
> > 
> > Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> > when there's a policy limits change, and clearing need_freq_update when a
> > requisite redundant update occurs.
> > 
> > This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS test
> > and instead setting need_freq_update to false in sugov_update_next_freq().
> > 
> > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 28c77904ea74..e51d5ce730be 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  
> >  	if (unlikely(sg_policy->limits_changed)) {
> >  		sg_policy->limits_changed = false;
> > -		sg_policy->need_freq_update = true;
> > +		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> >  		return true;
> >  	}
> >  
> > @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >  				   unsigned int next_freq)
> >  {
> >  	if (sg_policy->need_freq_update)
> > -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > +		sg_policy->need_freq_update = false;
> >  	else if (sg_policy->next_freq == next_freq)
> >  		return false;
> >  
> 
> This patch breaks cpufreq throttling (e.g. for thermal cooling) for
> cpufreq drivers that:
> 
>  - Have policy->fast_switch_enabled/fast_switch_possible set, but
>  - Do not have CPUFREQ_NEED_UPDATE_LIMITS flag set
> 
> There are several examples for this in the tree (search for
> "fast_switch_possible"). Of all those drivers, only intel-pstate and
> amd-pstate (sometimes) set CPUFREQ_NEED_UPDATE_LIMITS.
> 
> I can reliably reproduce this with scmi-cpufreq on a Qualcomm X1E
> laptop:
> 
>  1. I added some low temperature trip points in the device tree,
>     together with passive cpufreq cooling.
>  2. I run a CPU stress test on all CPUs and monitor the temperatures
>     and CPU frequencies.
> 
> When using "performance" governor instead of "schedutil", the CPU
> frequencies are being throttled as expected, as soon as the temperature
> trip points are reached.
> 
> When using "schedutil", the CPU frequencies stay at maximum as long as
> the stress test is running. No throttling happens, so the device heats
> up far beyond the defined temperature trip points. Throttling is applied
> only after stopping the stress test, since this forces schedutil to
> re-evaluate the CPU frequency.
> 
> Reverting this commit fixes the problem.
> 
> Looking at the code, I think the problem is that:
>  - sg_policy->limits_changed does not result in
>    sg->policy->need_freq_update without CPUFREQ_NEED_UPDATE_LIMITS
>    anymore, and
>  - Without sg->policy->need_freq_update, get_next_freq() skips calling
>    cpufreq_driver_resolve_freq(), which would normally apply the policy
>    min/max constraints.
> 
> Do we need to set CPUFREQ_NEED_UPDATE_LIMITS for all cpufreq drivers
> that set policy->fast_switch_possible? If I'm reading the documentation
> comment correctly, that flag is just supposed to enable notifications if
> the policy min/max changes, but the resolved target frequency is still
> the same. This is not the case here, the target frequency needs to be
> throttled, but schedutil isn't applying the new limits.
> 
> Any suggestions how to fix this? I'm happy to test patches with my
> setup.

Thank you for reporting this. As I see it, sg_policy->need_freq_update is
working correctly now; however, sg_policy->limits_changed relied on the broken
behavior of sg_policy->need_freq_update and therefore sg_policy->limits_changed
needs to be fixed.

Can you try this patch:

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1a19d69b91ed3..f37b999854d52 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return false;
 
 	if (unlikely(sg_policy->limits_changed)) {
-		sg_policy->limits_changed = false;
 		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 		return true;
 	}
@@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
-	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
+	if (freq == sg_policy->cached_raw_freq && !sg_policy->limits_changed &&
+	    !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
+	sg_policy->limits_changed = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }


> 
> Thanks,
> Stephan
> 
> #regzbot introduced: 8e461a1cb43d69d2fc8a97e61916dce571e6bb31

Thanks,
Sultan

