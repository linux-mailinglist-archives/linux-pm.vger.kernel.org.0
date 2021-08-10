Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6F3E5720
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhHJJhW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 05:37:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhHJJhV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 05:37:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0DD11063;
        Tue, 10 Aug 2021 02:36:59 -0700 (PDT)
Received: from [10.57.9.181] (unknown [10.57.9.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51F413F718;
        Tue, 10 Aug 2021 02:36:58 -0700 (PDT)
Subject: Re: [PATCH 1/8] cpufreq: Auto-register with energy model if asked
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <b48e2c944db072c220a1b0ae0c3d94eb1c4da7ab.1628579170.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f96f852f-0d73-7ad2-d7a9-eab6a5b7f454@arm.com>
Date:   Tue, 10 Aug 2021 10:36:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b48e2c944db072c220a1b0ae0c3d94eb1c4da7ab.1628579170.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/10/21 8:36 AM, Viresh Kumar wrote:
> Many cpufreq drivers register with the energy model for each policy and
> do exactly the same thing. Follow the footsteps of thermal-cooling, to
> get it done from the cpufreq core itself.
> 
> Provide a cpufreq driver flag so drivers can ask the cpufreq core to
> register with the EM core on their behalf. This allows us to get rid of
> duplicated code in the drivers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 9 +++++++++
>   include/linux/cpufreq.h   | 6 ++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 06c526d66dd3..a060dc2aa2f2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -23,6 +23,7 @@
>   #include <linux/kernel_stat.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/pm_opp.h>
>   #include <linux/pm_qos.h>
>   #include <linux/slab.h>
>   #include <linux/suspend.h>
> @@ -1511,6 +1512,11 @@ static int cpufreq_online(unsigned int cpu)
>   	if (cpufreq_thermal_control_enabled(cpufreq_driver))
>   		policy->cdev = of_cpufreq_cooling_register(policy);

The of_cpufreq_cooling_register() should be called after the EM
is present for the CPU device. When you check that function,
you will see that we call
em_cpu_get(policy->cpu)
to get the EM pointer. Otherwise IPA might fail.

>   
> +	if (cpufreq_driver->flags & CPUFREQ_REGISTER_WITH_EM) {
> +		dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> +					  policy->related_cpus);
> +	}
> +

So please move these new code above the thermal registration few lines
above.

>   	pr_debug("initialization complete\n");
>   
>   	return 0;
> @@ -1602,6 +1608,9 @@ static int cpufreq_offline(unsigned int cpu)
>   		goto unlock;
>   	}
>   
> +	if (cpufreq_driver->flags & CPUFREQ_REGISTER_WITH_EM)
> +		dev_pm_opp_of_unregister_em(get_cpu_device(cpu));
> +

Here is similar situation. Move the EM unregister after the thermal is
done. For consistency it's OK, the real EM struct won't be freed
for CPUs (due to scheduler reasons), though.

>   	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
>   		cpufreq_cooling_unregister(policy->cdev);
>   		policy->cdev = NULL;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9fd719475fcd..f11723cd4cca 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -424,6 +424,12 @@ struct cpufreq_driver {
>    */
>   #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
>   
> +/*
> + * Set by drivers that want the core to automatically register the CPU device
> + * with Energy Model.
> + */
> +#define CPUFREQ_REGISTER_WITH_EM		BIT(7)
> +
>   int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>   int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>   
> 
