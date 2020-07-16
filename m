Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3E2221F4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgGPL4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 07:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgGPL4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 07:56:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE92C061755;
        Thu, 16 Jul 2020 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9J/2b3b7YX/w3J/Y99T7XKn5p5MncV/hBcAxZFSpP/o=; b=md/+XRNjQfIIl04ga7+CuiYGkD
        23HE25+cL7oCCu6eiZqV11gN85lh57Bkl4/WYxZwIgXB8CZvL1CW1FkvES3ed5bEGaP9TXuxYf6vJ
        DVU5QYkHxxERZLAvUooucsUg3WwPRcwHjKrfaHvkynBJUGJx4iNl3AXt/miZSxgpEGJZOIQkkhmVi
        mG4eLrjSTMqhBbCZadjsGFvWlh4KqSQyph6U+CR4WeE0QlKEO7G1XKRkqtN/gUo8xt0bRX+MPuaWO
        GKq925mMwcrX6jiBbzU/hDLiN3KDpijvwTtrM9tbFAznWJtSb3sbu3iRGAuYir0aJ6WwhbndTLE2X
        qNyjyVjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw2Ug-0006Cm-Rk; Thu, 16 Jul 2020 11:56:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 474A0305DD1;
        Thu, 16 Jul 2020 13:56:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27ACE20D27ABC; Thu, 16 Jul 2020 13:56:05 +0200 (CEST)
Date:   Thu, 16 Jul 2020 13:56:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200716115605.GR10769@hirez.programming.kicks-ass.net>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 12:06:53PM +0530, Viresh Kumar wrote:
>  /**
> + * get_load() - get current load for a cpu
>   * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
>   * @cpu:	cpu number
> + * @cpu_idx:	index of the cpu
>   *
> + * Return: The current load of cpu @cpu in percentage.
>   */
>  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>  		    int cpu_idx)
>  {
> +	unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> +	unsigned long max = arch_scale_cpu_capacity(cpu);
>  
> +	util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);
> +	return (util * 100) / max;
>  }

So there's a number of things... let me recap a bunch of things that
got mentioned on IRC earlier this week and then continue from there..

So IPA* (or any other thermal governor) needs energy estimates for the
various managed devices, cpufreq_cooling, being the driver for the CPU
device, needs to provide that and in return receives feedback on how
much energy it is allowed to consume, cpufreq_cooling then dynamically
enables/disables OPP states.

There are actually two methods the thermal governor will use:
get_real_power() and get_requested_power().

The first isn't used anywhere in mainline, but could be implemented on
hardware that has energy counters (like say x86 RAPL).

The second attempts to guesstimate power, and is the subject of this
patch.

Currently cpufreq_cooling appears to estimate the CPU energy usage by
calculating the percentage of idle time using the per-cpu cpustat stuff,
which is pretty horrific.

This patch then attempts to improve upon that by using the scheduler's
cpu_util(ENERGY_UTIL) estimate, which is also used to select OPP state
and improves upon avg idle. This should be a big improvement as higher
frequency consumes more energy, but should we not also consider that:

	E = C V^2 f

The EAS energy model has tables for the OPPs that contain this, but in
this case we seem to be assuming a linear enery/frequency curve, which
is just not the case.

I suppose we could do something like **:

	100 * util^3 / max^3

which assumes V~f.

Another point is that cpu_util() vs turbo is a bit iffy, and to that,
things like x86-APERF/MPERF and ARM-AMU got mentioned. Those might also
have the benefit of giving you values that match your own sampling
interval (100ms), where the sched stuff is PELT (64,32.. based).

So what I've been thinking is that cpufreq drivers ought to be able to
supply this method, and only when they lack, can the cpufreq-governor
(schedutil) install a fallback. And then cpufreq-cooling can use
whatever is provided (through the cpufreq interfaces).

That way, we:

 1) don't have to export anything
 2) get arch drivers to provide something 'better'


Does that sounds like something sensible?




[*] I always want a beer when I see that name :-)

[**] I despise code that uses percentages, computers suck at
/100 and there is no reason not to use any other random fraction, so why
pick a bad one.

