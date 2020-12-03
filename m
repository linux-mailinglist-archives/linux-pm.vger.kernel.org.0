Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334CD2CD5AD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbgLCMmg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 07:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbgLCMmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 07:42:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C5C061A4F;
        Thu,  3 Dec 2020 04:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rcY1pTuzOztjgznyvJvtInjHpKkyW5kZe8ZvS4Mqiwo=; b=swl2bpoKojQhZhwjiyg7JMJngF
        PncZValpmxIZQ5xpwjLKsGr0/y+u9btEM6ialPYA4ySFjOnc2EFkyShoIbXs+72+STp1uSCPd99Co
        3hqjrdIjGLjqTfn52CmR/Prx8W9yE3Fi48MNrfs33S5tnBXwRzx3gyUjtwqewh85PEEu1Rd58yYA/
        rF+6EPe3SjSPlm6/7838UQKrxW9lT89DmrX2U0AwxwtwokPBGfgBaASdCbr6M7DYmsu8K5O10me0s
        hCMZrmo7Lhavv4GYAhJjzvOin3ChO5vv5TL15oT7cf8dRjwUnjbagMLgk67vtssawBdTpJiQu89in
        drfBZOZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kknvb-0004Vz-IS; Thu, 03 Dec 2020 12:41:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80A23300DAE;
        Thu,  3 Dec 2020 13:41:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A194223615CE; Thu,  3 Dec 2020 13:41:41 +0100 (CET)
Date:   Thu, 3 Dec 2020 13:41:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [RFC][PATCH 1/2] cpufreq: Add special-purpose fast-switching
 callback for drivers
Message-ID: <20201203124141.GP3021@hirez.programming.kicks-ass.net>
References: <1817571.2o5Kk4Ohv2@kreacher>
 <2174134.tL5yAn4CWt@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2174134.tL5yAn4CWt@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 07:37:01PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> First off, some cpufreq drivers (eg. intel_pstate) can pass hints
> beyond the current target frequency to the hardware and there are no

Everything CPPC, which is quite a bit these days.


> +	/*
> +	 * ->fast_switch() replacement for drivers that use an internal
> +	 * representation of performance levels and can pass hints other than
> +	 * the target performance level to the hardware.
> +	 */
> +	void		(*adjust_perf)(unsigned int cpu, bool busy,
> +				       unsigned long min_perf,
> +				       unsigned long target_perf,
> +				       unsigned long capacity);
>  

I'm not sure @busy makes sense, that's more a hack because @util had a
dip and should remain inside schedutil.


> @@ -454,6 +455,25 @@ static void sugov_update_single(struct u
>  	util = sugov_get_util(sg_cpu);
>  	max = sg_cpu->max;
>  	util = sugov_iowait_apply(sg_cpu, time, util, max);
> +
> +	/*
> +	 * This code runs under rq->lock for the target CPU, so it won't run
> +	 * concurrently on two different CPUs for the same target and it is not
> +	 * necessary to acquire the lock in the fast switch case.
> +	 */
> +	if (sg_policy->direct_fast_switch) {
> +		/*
> +		 * In this case, any optimizations that can be done are up to
> +		 * the driver.
> +		 */
> +		cpufreq_driver_adjust_perf(sg_cpu->cpu,
> +					   sugov_cpu_is_busy(sg_cpu),
> +					   map_util_perf(sg_cpu->bw_dl),
> +					   map_util_perf(util), max);
> +		sg_policy->last_freq_update_time = time;
> +		return;
> +	}

Instead of adding more branches, would it makes sense to simply set a
whole different util_hook in this case?
