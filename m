Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8983214AB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 12:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBVLBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 06:01:17 -0500
Received: from foss.arm.com ([217.140.110.172]:40990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhBVLBL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Feb 2021 06:01:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B22E31FB;
        Mon, 22 Feb 2021 03:00:25 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508203F73B;
        Mon, 22 Feb 2021 03:00:25 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:00:23 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 2/2] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210222110023.GB4499@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <59f48538545d080cb1c7b201d2d779ab513d2c0c.1611829953.git.viresh.kumar@linaro.org>
 <20210218163538.GA3105@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218163538.GA3105@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

Some test results:

On Thursday 18 Feb 2021 at 16:35:38 (+0000), Ionela Voinescu wrote:
[..]
> > +static void __init cppc_freq_invariance_init(void)
> > +{
[..]
> > +
> > +		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
> > +		if (!ret)
> > +			per_cpu(cppc_fi->prev_perf_fb_ctrs, i) = fb_ctrs;
> 

After fixing this one:
			cppc_fi->prev_perf_fb_ctrs = fb_ctrs;

I got the following:

Platform:

 - Juno R2 (CPUs [0-3] are littles, CPUs [4-5] are bigs)
    + PMU counters, used by CPPC through FFH
    + userspace/schedutil


  - Verifying that with userspace governor we see a correct change in
    scale factor:

	root@buildroot:~# dmesg | grep FIE
	[    6.436770] AMU: CPUs[0-3]: AMU counters WON'T be used for FIE.
	[    6.436962] AMU: CPUs[4-5]: AMU counters WON'T be used for FIE.
	[    6.451510] CPPC:CPUs[0-5]: CPPC counters will be used for FIE.

	root@buildroot:~# echo 600000 > policy4/scaling_setspeed
	[  353.939495] CPU4: Invariance(cppc) scale: 512.
	[  353.939497] CPU5: Invariance(cppc) scale: 512.

	root@buildroot:~# echo 1200000 > policy4/scaling_setspeed
	[  372.683511] CPU5: Invariance(cppc) scale: 1024.
	[  372.683518] CPU4: Invariance(cppc) scale: 1024.

	root@buildroot:~# echo 450000 > policy0/scaling_setspeed
	[  641.495513] CPU2: Invariance(cppc) scale: 485.
	[  641.495514] CPU1: Invariance(cppc) scale: 485.
	[  641.495517] CPU0: Invariance(cppc) scale: 485.
	[  641.495542] CPU3: Invariance(cppc) scale: 485.

	root@buildroot:~# echo 950000 > policy0/scaling_setspeed
	[  852.015514] CPU2: Invariance(cppc) scale: 1024.
	[  852.015514] CPU1: Invariance(cppc) scale: 1024.
	[  852.015517] CPU0: Invariance(cppc) scale: 1024.
	[  852.015541] CPU3: Invariance(cppc) scale: 1024.

 - I ran some benchmarks as well (perf, hackbench, dhrystone) on the same
   platform, using the userspace governor at fixed frequency, to evaluate
   the impact of the work we do or don't do on the tick.

   ./perf bench sched pipe
   (10 iterations, higher is better, ops/s, comparisons with
   cpufreq-based FIE)

   cpufreq-based FIE    AMU-based FIE    CPPC-based FIE
   ----------------------------------------------------
   39498.8		40984.7		 38893.4
   std: 3.766%		std: 4.461%	 std: 0.575%
   			diff: 3.625%	 diff: -1.556%

   ./hackbench -l 1000
   (10 iterations, lower is better, seconds, comparison with
   cpufreq-based FIE)

   cpufreq-based FIE    AMU-based FIE    CPPC-based FIE
   ----------------------------------------------------
   6.4207		6.3386		 6.7841
   std: 7.298%		std: 2.252%	 std: 2.460%
   			diff: -1.295%	 diff: 5.356%

   This shows a small regression for the CPPC-based FIE, but within the
   standard deviation.

   I ran some dhrystone benchmarks (./dhrystone -t 2/34/5/6/ -l 5000) as
   well with schedutil governor to understand if an increase in accuracy
   with the AMU/CPPC counters makes a difference. Given the
   characteristics of the platform it's no surprise that the results
   were very similar between the three cases, so I won't bore you with
   the numbers.

Hope it helps,
Ionela.

