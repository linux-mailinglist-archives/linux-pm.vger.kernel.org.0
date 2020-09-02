Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21DE25AFEE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgIBPr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 11:47:28 -0400
Received: from foss.arm.com ([217.140.110.172]:38082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgIBNav (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 09:30:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 510EE11B3;
        Wed,  2 Sep 2020 06:30:36 -0700 (PDT)
Received: from bogus (unknown [10.57.4.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD3AC3F68F;
        Wed,  2 Sep 2020 06:30:34 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:30:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] cpufreq: move invariance setter calls in cpufreq
 core
Message-ID: <20200902133032.GG25462@bogus>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200901205549.30096-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901205549.30096-3-ionela.voinescu@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 09:55:46PM +0100, Ionela Voinescu wrote:
> To properly scale its per-entity load-tracking signals, the task scheduler
> needs to be given a frequency scale factor, i.e. some image of the current
> frequency the CPU is running at. Currently, this scale can be computed
> either by using counters (APERF/MPERF on x86, AMU on arm64), or by
> piggy-backing on the frequency selection done by cpufreq.
> 
> For the latter, drivers have to explicitly set the scale factor
> themselves, despite it being purely boiler-plate code: the required
> information depends entirely on the kind of frequency switch callback
> implemented by the driver, i.e. either of: target_index(), target(),
> fast_switch() and setpolicy().
> 
> The fitness of those callbacks with regard to driving the Frequency
> Invariance Engine (FIE) is studied below:
> 
> target_index()
> ==============
> Documentation states that the chosen frequency "must be determined by
> freq_table[index].frequency". It isn't clear if it *has* to be that
> frequency, or if it can use that frequency value to do some computation
> that ultimately leads to a different frequency selection. All drivers
> go for the former, while the vexpress-spc-cpufreq has an atypical
> implementation which is handled separately.
> 
> Therefore, the hook works on the assumption the core can use
> freq_table[index].frequency.
> 
> target()
> =======
> This has been flagged as deprecated since:
> 
>   commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> 
> It also doesn't have that many users:
> 
>   gx-suspmod.c:439:       .target = cpufreq_gx_target,
>   s3c24xx-cpufreq.c:428:  .target = s3c_cpufreq_target,
>   intel_pstate.c:2528:    .target = intel_cpufreq_target,
>   cppc_cpufreq.c:401:     .target = cppc_cpufreq_set_target,
>   cpufreq-nforce2.c:371:  .target = nforce2_target,
>   sh-cpufreq.c:163:       .target = sh_cpufreq_target,
>   pcc-cpufreq.c:573:      .target = pcc_cpufreq_target,
> 
> Similarly to the path taken for target_index() calls in the cpufreq core
> during a frequency change, all of the drivers above will mark the end of a
> frequency change by a call to cpufreq_freq_transition_end().
> 
> Therefore, cpufreq_freq_transition_end() can be used as the location for
> the arch_set_freq_scale() call to potentially inform the scheduler of the
> frequency change.
> 
> This change maintains the previous functionality for the drivers that
> implement the target_index() callback, while also adding support for the
> few drivers that implement the deprecated target() callback.
> 
> fast_switch()
> =============
> This callback *has* to return the frequency that was selected.
> 
> setpolicy()
> ===========
> This callback does not have any designated way of informing what was the
> end choice. But there are only two drivers using setpolicy(), and none
> of them have current FIE support:
> 
>   drivers/cpufreq/longrun.c:281:	.setpolicy	= longrun_set_policy,
>   drivers/cpufreq/intel_pstate.c:2215:	.setpolicy	= intel_pstate_set_policy,
> 
> The intel_pstate is known to use counter-driven frequency invariance.
> 
> Conclusion
> ==========
> 
> Given that the significant majority of current FIE enabled drivers use
> callbacks that lend themselves to triggering the setting of the FIE scale
> factor in a generic way, move the invariance setter calls to cpufreq core.
> 
> As a result of setting the frequency scale factor in cpufreq core, after
> callbacks that lend themselves to trigger it, remove this functionality
> from the driver side.
> 
> To be noted that despite marking a successful frequency change, many
> cpufreq drivers will consider the new frequency as the requested
> frequency, although this is might not be the one granted by the hardware.
> 
> Therefore, the call to arch_set_freq_scale() is a "best effort" one, and
> it is up to the architecture if the new frequency is used in the new
> frequency scale factor setting (determined by the implementation of
> arch_set_freq_scale()) or eventually used by the scheduler (determined
> by the implementation of arch_scale_freq_capacity()). The architecture
> is in a better position to decide if it has better methods to obtain
> more accurate information regarding the current frequency and use that
> information instead (for example, the use of counters).
> 
> Also, the implementation to arch_set_freq_scale() will now have to handle
> error conditions (current frequency == 0) in order to prevent the
> overhead in cpufreq core when the default arch_set_freq_scale()
> implementation is used.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c           | 10 +---------
>  drivers/cpufreq/cpufreq.c              | 12 +++++++++++-
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  9 +--------
[...]

>  drivers/cpufreq/scmi-cpufreq.c         | 12 ++----------
>  drivers/cpufreq/scpi-cpufreq.c         |  6 +-----
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++----------

For above 3 files:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
