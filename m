Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45F4F97EB
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 16:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiDHOYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiDHOYf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 10:24:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7692311;
        Fri,  8 Apr 2022 07:22:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA7AE1F85F;
        Fri,  8 Apr 2022 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649427749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQuvLLv/oeqhE1CFTiwRDAEpyUiaiX3r+MFr/YL55+k=;
        b=HjF+Xs/zPrhU4cNitPg5DsPChj7UhJDLgQj/IgT1KdVHo6AJjfKFcYvIcOW7NzfzzJHIqn
        RHCFRlBS6cjDb4Dl7VHQ7a4rsN6PNbXXEKoFOPWlUmhhlcP9Y71BxP+eVL2DdtSoW5cexU
        UaIvZDkxm00yjMnXmqJTnmuY/X/os0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649427749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQuvLLv/oeqhE1CFTiwRDAEpyUiaiX3r+MFr/YL55+k=;
        b=lox00S8KJWJgx+0pGdbpMnk7zIC2Qob68THbWF7T/MPGQiT545T6NmhJdOCKAtCiQkJaql
        MsIbB7O9JbAv5oDg==
Received: from [10.163.29.78] (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id 98B36A3B94;
        Fri,  8 Apr 2022 14:22:29 +0000 (UTC)
Message-ID: <36982e082159a77154cfc8a78039e4ce9e3b4770.camel@suse.cz>
Subject: Re: [PATCH] cpufreq: intel_pstate: Handle no_turbo in frequency
 invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
Date:   Fri, 08 Apr 2022 16:22:28 +0200
In-Reply-To: <20220407234258.569681-1-yu.c.chen@intel.com>
References: <20220407234258.569681-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2022-04-08 at 07:42 +0800, Chen Yu wrote:
> Problem statement:
> Once the user has disabled turbo frequency by
> echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo,
> the cfs_rq's util_avg becomes quite small when compared with
> CPU capacity.
> 
> Step to reproduce:
> 
> echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> 
> ./x86_cpuload --count 1 --start 3 --timeout 100 --busy 99
> would launch 1 thread and bind it to CPU3, lasting for 100 seconds,
> with a CPU utilization of 99%. [1]
> 
> top result:
> %Cpu3  : 98.4 us,  0.0 sy,  0.0 ni,  1.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> 
> check util_avg:
> cat /sys/kernel/debug/sched/debug | grep "cfs_rq\[3\]" -A 20 | grep util_avg
>   .util_avg                      : 611
> 
> So the util_avg/cpu capacity is 611/1024, which is much smaller than
> 98.4% shown in the top result.
> 
> This might impact some logic in the scheduler. For example, group_is_overloaded()
> would compare the group_capacity and group_util in the sched group, to
> check if this sched group is overloaded or not. With this gap, even
> when there is a nearly 100% workload, the sched group will not be regarded
> as overloaded. Besides group_is_overloaded(), there are also other victims.
> There is a ongoing work that aims to optimize the task wakeup in a LLC domain.
> The main idea is to stop searching idle CPUs if the sched domain is overloaded[2].
> This proposal also relies on the util_avg/CPU capacity to decide whether the LLC
> domain is overloaded.
> 
> Analysis:
> CPU frequency invariance has caused this difference. In summary,
> the util_sum of cfs rq would decay quite fast when the CPU is in
> idle, when the CPU frequency invariance is enabled.
> 
> The detail is as followed:
> 
> As depicted in update_rq_clock_pelt(), when the frequency invariance
> is enabled, there would be two clock variables on each rq, clock_task
> and clock_pelt:
> 
>    The clock_pelt scales the time to reflect the effective amount of
>    computation done during the running delta time but then syncs back to
>    clock_task when rq is idle.
> 
>    absolute time    | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
>    @ max frequency  ------******---------------******---------------
>    @ half frequency ------************---------************---------
>    clock pelt       | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> 
> The fast decay of util_sum during idle is due to:
> 1. rq->clock_pelt is always behind rq->clock_task
> 2. rq->last_update is updated to rq->clock_pelt' after invoking ___update_load_sum()
> 3. Then the CPU becomes idle, the rq->clock_pelt' would be suddenly increased
>    a lot to rq->clock_task
> 4. Enters ___update_load_sum() again, the idle period is calculated by
>    rq->clock_task - rq->last_update, AKA, rq->clock_task - rq->clock_pelt'.
>    The lower the CPU frequency is, the larger the delta =
>    rq->clock_task - rq->clock_pelt' will be. Since the idle period will be
>    used to decay the util_sum only, the util_sum drops significantly during
>    idle period.
> 
> Proposal:
> This symptom is not only caused by disabling turbo frequency, but it
> would also appear if the user limits the max frequency at runtime. Because
> if the frequency is always lower than the max frequency,
> CPU frequency invariance would decay the util_sum quite fast during idle.
> 
> As some end users would disable turbo after boot up, this patch aims to
> present this symptom and deals with turbo scenarios for now. It might
> be ideal if CPU frequency invariance is aware of the max CPU frequency
> (user specified) at runtime in the future.
> 
> [Previous patch seems to be lost on LKML, this is a resend, sorry for any
> inconvenience]
> 
> Link: https://github.com/yu-chen-surf/x86_cpuload.git #1
> Link: https://lore.kernel.org/lkml/20220310005228.11737-1-yu.c.chen@intel.com/ #2
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Giovanni Gherdovich <ggherdovich@suse.cz>

You're right, when turbo is disabled, the frequency invariance code needs to
know about it; it calculates freq_curr/freq_max and thinks that freq_max is
some turbo level. For example commit 918229cdd5ab ("x86/intel_pstate: Handle
runtime turbo disablement/enablement in frequency invariance") takes care of
this when global.turbo_disabled changes, but before your patch nothing checks
if the user disabled turbo from sysfs. Thanks for the fix!

Giovanni

> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 846bb3a78788..2216b24b6f84 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1322,6 +1322,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
>  	mutex_unlock(&intel_pstate_limits_lock);
>  
>  	intel_pstate_update_policies();
> +	arch_set_max_freq_ratio(global.no_turbo);
>  
>  	mutex_unlock(&intel_pstate_driver_lock);
>  

