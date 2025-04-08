Return-Path: <linux-pm+bounces-24959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF9A812D2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 18:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8517F880CF0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D92233141;
	Tue,  8 Apr 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYTfwWCk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08922D4F1
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130895; cv=none; b=kvrEERJfkD+x6U2MSCo2Rm/7F/V52I2VkgNOguTv5iYnyUAItoz05i3J7HrildLYikbm5pOOZSzgu07JPcqNjE2JGz1eZ4W9Wsg7tOyabtFESw977MvaspHMp/Z3xfjg8nbvzC2z7gLTMsUVHVnyzPG/0i5MeH2VlSIfvFY5CA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130895; c=relaxed/simple;
	bh=lTrymym2rrGYaqBy9yJd3cPCcu5Ep4WurEWujyQcWLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQf9a998bsnTsUzofIu2Ozxc6CzeIAuYPC8NuBHnGhDcbd9ezdW29dewtHmhMOz4i6agLWYVdjf2fB9J5r1zMfGusnXV8Tw3SPCCmCQrxmA4v9BqmXv/rgW2wQrPjEGEjH/I2p9LeV1sGH/gnguHwrvmeXd6X4fEdx+YEkjZb50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KYTfwWCk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso6332694f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Apr 2025 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744130891; x=1744735691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH69wZLBWd1Oynbh8Im74vg1R73prpWDquGK8HkahZ4=;
        b=KYTfwWCk2cf7krmaG26DHsi4LosjAi9GgWqycCTydWJSLflTZs3z92EWVsmP+C1ZWB
         fupdTcWa7PksL9tTV7esB6EghVg6PFDja4sSsktI3NZtwzv1mkuBhBrdFNzCiuxNVdxZ
         5kiuw/lgHRbHCFBXG9FqgRd9zGJgHquwvTaIS0XfDdozPNuC5GwuiHvlhTmYV0dKYPN8
         NkVi9Vv+O+4jkdHKVvjCiKIzihv0V6FqdW58S8YJkv1wddMayaBv9Ck7GjpePEdAas6h
         0T40+s2wVnFJgaWpBmFR7qGH9Mu8uGjpCiOhOQmihdL/ZGgQHCN7nKrEo8QWe1XoyKTU
         pn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744130891; x=1744735691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH69wZLBWd1Oynbh8Im74vg1R73prpWDquGK8HkahZ4=;
        b=IItKX39ZldaWeKNnWrp7M+O075v1kkVNLnLfPOVBVC/in5VXiJKRTawSAQdY4Pz9xr
         XJ0JaG2Y3dpkxWej1kZGiSaFOsd/ZlRMYVO4HuKP14+LHq50xPKxh7mPMEKBFQBqtI4c
         xa5JIQl+UdirxgbTHR5f7k+mW2F3jpdASTuR/Y1VK1ESgvWTu3umL7XnCdW7iTnTd1x4
         P7rlnPBmjh3hkmISdLI8WB7gomTFcl/AUTqdchaAzeSKRQ7h1TA7hBH6EDMTt8y7SatA
         Cfp/bd1fg8u/+Wnp8Jn6BJhaVjRkUYT8hiZJDpi9bbYg7p/FyZeqz7p3IyHW9M38/gW6
         /V2g==
X-Forwarded-Encrypted: i=1; AJvYcCUlKYpatcrNgCye5P+vXc+j47iox5CHh5HkC0G3kv1Y82YrEv0gBNuTdqxYrHYmqGCQjwjAMNdBog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDp+1ag9WhoqKHr6QaEdHgUnKVX5iUi6XdaK1qfaIDafoyxLSZ
	2FgKleENPhg5nvZo4wU3Wbb712rK6i7GpfhCsWz8xvUg9koEXOglFRyCwVZM79o=
X-Gm-Gg: ASbGncuSPD6Rz1+J6HeOzqAlZ6dGK1KqU01ssqaMhnGH06ecI6vjiDu404B+ePSdISY
	VesIb6RLRlHmVRuYwHZeTn2vnUWXE2Gkd6Ak2ApGZwbpF8Ubp2nW8fkHl0B+LqsYhYUKsz1mEfJ
	b06En8szdeXKLscJMh/w6hM99ssHrBfhC9yY0zp573M3vz6gM5hOEkkYiGqo/fVz1Qkx/Y9phlq
	u4ChwFZJmwYWnA0p7t19pBP8SbC45adRtk3WBsQcZhrj4xAfXTbz25u0A9k+YsMO+CV4Fm+GpEO
	ngkSWsjrS1R3px9dLGgF1TmLC6V5VqY5Id1QSmhNPvSxKAlBiIaerAzCxkRgHpUb5A==
X-Google-Smtp-Source: AGHT+IHSzK+dGRzFBDxjG+Uj3o+//o2NWHxEIylC5K277J2t1PoewelaAf/YIHhbKuxuCTDG/s0cgQ==
X-Received: by 2002:a5d:5f48:0:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-39d6fc4930amr11405943f8f.17.1744130891381;
        Tue, 08 Apr 2025 09:48:11 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:49a4:221:16c1:a5bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096bb2sm15531713f8f.12.2025.04.08.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 09:48:10 -0700 (PDT)
Date: Tue, 8 Apr 2025 18:48:06 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Sultan Alsawaf <sultan@kerneltoast.com>
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
Message-ID: <Z_VTRspvmOUfrawh@linaro.org>
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com>
 <Z_Tlc6Qs-tYpxWYb@linaro.org>
 <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_U_LN0AtH_n4YtE@sultan-box.localdomain>

Hi Sultan,

On Tue, Apr 08, 2025 at 08:22:20AM -0700, Sultan Alsawaf wrote:
> On Tue, Apr 08, 2025 at 10:59:31AM +0200, Stephan Gerhold wrote:
> > On Wed, Dec 11, 2024 at 05:57:32PM -0800, Sultan Alsawaf wrote:
> > > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> > > 
> > > A redundant frequency update is only truly needed when there is a policy
> > > limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> > > 
> > > In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive a
> > > frequency update _all the time_, not just for a policy limits change,
> > > because need_freq_update is never cleared.
> > > 
> > > Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also leads
> > > to a redundant frequency update, regardless of whether or not the driver
> > > specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is the
> > > same as the current one.
> > > 
> > > Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> > > when there's a policy limits change, and clearing need_freq_update when a
> > > requisite redundant update occurs.
> > > 
> > > This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS test
> > > and instead setting need_freq_update to false in sugov_update_next_freq().
> > > 
> > > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 28c77904ea74..e51d5ce730be 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > >  
> > >  	if (unlikely(sg_policy->limits_changed)) {
> > >  		sg_policy->limits_changed = false;
> > > -		sg_policy->need_freq_update = true;
> > > +		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > >  		return true;
> > >  	}
> > >  
> > > @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > >  				   unsigned int next_freq)
> > >  {
> > >  	if (sg_policy->need_freq_update)
> > > -		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > +		sg_policy->need_freq_update = false;
> > >  	else if (sg_policy->next_freq == next_freq)
> > >  		return false;
> > >  
> > 
> > This patch breaks cpufreq throttling (e.g. for thermal cooling) for
> > cpufreq drivers that:
> > 
> >  - Have policy->fast_switch_enabled/fast_switch_possible set, but
> >  - Do not have CPUFREQ_NEED_UPDATE_LIMITS flag set
> > 
> > There are several examples for this in the tree (search for
> > "fast_switch_possible"). Of all those drivers, only intel-pstate and
> > amd-pstate (sometimes) set CPUFREQ_NEED_UPDATE_LIMITS.
> > 
> > I can reliably reproduce this with scmi-cpufreq on a Qualcomm X1E
> > laptop:
> > 
> >  1. I added some low temperature trip points in the device tree,
> >     together with passive cpufreq cooling.
> >  2. I run a CPU stress test on all CPUs and monitor the temperatures
> >     and CPU frequencies.
> > 
> > When using "performance" governor instead of "schedutil", the CPU
> > frequencies are being throttled as expected, as soon as the temperature
> > trip points are reached.
> > 
> > When using "schedutil", the CPU frequencies stay at maximum as long as
> > the stress test is running. No throttling happens, so the device heats
> > up far beyond the defined temperature trip points. Throttling is applied
> > only after stopping the stress test, since this forces schedutil to
> > re-evaluate the CPU frequency.
> > 
> > Reverting this commit fixes the problem.
> > 
> > Looking at the code, I think the problem is that:
> >  - sg_policy->limits_changed does not result in
> >    sg->policy->need_freq_update without CPUFREQ_NEED_UPDATE_LIMITS
> >    anymore, and
> >  - Without sg->policy->need_freq_update, get_next_freq() skips calling
> >    cpufreq_driver_resolve_freq(), which would normally apply the policy
> >    min/max constraints.
> > 
> > Do we need to set CPUFREQ_NEED_UPDATE_LIMITS for all cpufreq drivers
> > that set policy->fast_switch_possible? If I'm reading the documentation
> > comment correctly, that flag is just supposed to enable notifications if
> > the policy min/max changes, but the resolved target frequency is still
> > the same. This is not the case here, the target frequency needs to be
> > throttled, but schedutil isn't applying the new limits.
> > 
> > Any suggestions how to fix this? I'm happy to test patches with my
> > setup.
> 
> Thank you for reporting this. As I see it, sg_policy->need_freq_update is
> working correctly now; however, sg_policy->limits_changed relied on the broken
> behavior of sg_policy->need_freq_update and therefore sg_policy->limits_changed
> needs to be fixed.

Thanks for the quick reply and the patch!

> 
> Can you try this patch:
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 1a19d69b91ed3..f37b999854d52 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  		return false;
>  
>  	if (unlikely(sg_policy->limits_changed)) {
> -		sg_policy->limits_changed = false;
>  		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
>  		return true;
>  	}
> @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	freq = get_capacity_ref_freq(policy);
>  	freq = map_util_freq(util, freq, max);
>  
> -	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> +	if (freq == sg_policy->cached_raw_freq && !sg_policy->limits_changed &&
> +	    !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
>  
> +	sg_policy->limits_changed = false;
>  	sg_policy->cached_raw_freq = freq;
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
> 

This is working correctly for me, CPU frequency is being throttled again
when the temperature trip points are reached. If you send this, feel
free to add:

Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks!
Stephan

