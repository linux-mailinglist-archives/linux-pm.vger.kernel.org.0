Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AFD2D2B4F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 13:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgLHMof (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 07:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgLHMof (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 07:44:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A0BC061793;
        Tue,  8 Dec 2020 04:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QDdAEsOh8knc9vEyiJ/wrX2d0Mqw0DpBXQ+d0TXNCI4=; b=ALellYQKQFkmFFL01r4mkby+ay
        ToQoFzSlSzP5/o4sYMh/ws5VCuSjGv+lj3SLYXmZcWML/GndqjsJBHey9xIk0/zSCPc3Yh80kizR9
        nsSwBW6PB7PpQrxcoX1F3XoVYmEe2Hnw9RY3q/Hhr5KBnBKLifd0JMD5oXdfkgJbFekyF3ECun3zI
        G6XkprqkLMkyw4d9TbhPgR3H3w4VMLqHoqJXiOmYNnzxLbvDSwMBclVG+tGyexpEIlI0D1Chmbcvt
        7vCE9nVB4B0WvmFvib7oxbCziWIRFjf2c80TzouelZJzos/pMNHJV/4hOloyaFhCVi1DuPDy96kcg
        oeTz7P3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmcLL-0006xC-Cg; Tue, 08 Dec 2020 12:43:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83163305C1C;
        Tue,  8 Dec 2020 13:43:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6457A20819150; Tue,  8 Dec 2020 13:43:44 +0100 (CET)
Date:   Tue, 8 Dec 2020 13:43:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v1 4/4] cpufreq: intel_pstate: Implement the
 ->adjust_perf() callback
Message-ID: <20201208124344.GX2414@hirez.programming.kicks-ass.net>
References: <20360841.iInq7taT2Z@kreacher>
 <3342398.tGQZsKHvNY@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3342398.tGQZsKHvNY@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 07, 2020 at 05:38:58PM +0100, Rafael J. Wysocki wrote:

> +static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> +				      unsigned long min_perf,
> +				      unsigned long target_perf,
> +				      unsigned long capacity)
> +{
> +	struct cpudata *cpu = all_cpu_data[cpunum];
> +	int old_pstate = cpu->pstate.current_pstate;
> +	int cap_pstate, min_pstate, max_pstate, target_pstate;
> +
> +	update_turbo_state();
> +	cap_pstate = global.turbo_disabled ? cpu->pstate.max_pstate :
> +					     cpu->pstate.turbo_pstate;
> +
> +	/* Optimization: Avoid unnecessary divisions. */
> +
> +	target_pstate = cap_pstate;
> +	if (target_perf < capacity)
> +		target_pstate = DIV_ROUND_UP(cap_pstate * target_perf, capacity);
> +
> +	min_pstate = cap_pstate;
> +	if (min_perf < capacity)
> +		min_pstate = DIV_ROUND_UP(cap_pstate * min_perf, capacity);
> +
> +	if (min_pstate < cpu->pstate.min_pstate)
> +		min_pstate = cpu->pstate.min_pstate;
> +
> +	if (min_pstate < cpu->min_perf_ratio)
> +		min_pstate = cpu->min_perf_ratio;
> +
> +	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
> +	if (max_pstate < min_pstate)
> +		max_pstate = min_pstate;
> +
> +	target_pstate = clamp_t(int, target_pstate, min_pstate, max_pstate);
> +
> +	intel_cpufreq_adjust_hwp(cpu, min_pstate, max_pstate, target_pstate, true);

I'm confused... HWP doesn't do pstate, yet everything here is now called
pstate, help?

> +
> +	cpu->pstate.current_pstate = target_pstate;
> +	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
> +}
