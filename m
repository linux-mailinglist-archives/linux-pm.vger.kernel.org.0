Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC73E57F1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhHJKF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 06:05:26 -0400
Received: from foss.arm.com ([217.140.110.172]:52810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232974AbhHJKFZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 06:05:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CFFC6D;
        Tue, 10 Aug 2021 03:05:03 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE0B83F70D;
        Tue, 10 Aug 2021 03:05:01 -0700 (PDT)
Subject: Re: [PATCH 8/8] cpufreq: vexpress: Use auto-registration for energy
 model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d3629cc7-d9db-0e54-94e9-278e308b7e8e@arm.com>
Date:   Tue, 10 Aug 2021 11:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 8:36 AM, Viresh Kumar wrote:
> Use the CPUFREQ_REGISTER_WITH_EM flag to allow cpufreq core to
> automatically register with the energy model.
> 
> This allows removal of boiler plate code from the driver and fixes the
> unregistration part as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/vexpress-spc-cpufreq.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 51dfa9ae6cf5..28c4c3254337 100644
> --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -442,8 +442,6 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>   	policy->freq_table = freq_table[cur_cluster];
>   	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
>   
> -	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
> -
>   	if (is_bL_switching_enabled())
>   		per_cpu(cpu_last_req_freq, policy->cpu) =
>   						clk_get_cpu_rate(policy->cpu);
> @@ -487,7 +485,8 @@ static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
>   static struct cpufreq_driver ve_spc_cpufreq_driver = {
>   	.name			= "vexpress-spc",
>   	.flags			= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> -					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +				  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +				  CPUFREQ_REGISTER_WITH_EM,
>   	.verify			= cpufreq_generic_frequency_table_verify,
>   	.target_index		= ve_spc_cpufreq_set_target,
>   	.get			= ve_spc_cpufreq_get_rate,
> 

I can see that this driver calls explicitly the
of_cpufreq_cooling_register()
It does this in the cpufreq_driver->ready() callback
implementation: ve_spc_cpufreq_ready()

With that in mind, the new code in the patch 1/8, which
registers the EM, should be called even earlier, above:
---------------------8<---------------------------------
/* Callback for handling stuff after policy is ready */
	if (cpufreq_driver->ready)
		cpufreq_driver->ready(policy);
------------------->8----------------------------------

This also triggered a question:
If this new flag can be set in the cpufreq driver which hasn't set
CPUFREQ_IS_COOLING_DEV
?
I can only see one driver (this one in the patch) which has such
configuration.

