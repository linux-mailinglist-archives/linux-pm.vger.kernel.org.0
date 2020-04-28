Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEBC1BC2FF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgD1PUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 11:20:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgD1PUk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 11:20:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 252C230E;
        Tue, 28 Apr 2020 08:20:40 -0700 (PDT)
Received: from [10.37.12.125] (unknown [10.37.12.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD30A3F305;
        Tue, 28 Apr 2020 08:20:33 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] thermal/drivers/cpuidle_cooling: Change the
 registration function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
 <20200414220837.9284-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4a8483a5-b481-5e97-9d03-f1ad3ae163d5@arm.com>
Date:   Tue, 28 Apr 2020 16:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200414220837.9284-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

I have checked the patches and run them on Juno.
Please find my comments below.

On 4/14/20 11:08 PM, Daniel Lezcano wrote:
> Today, there is no user for the cpuidle cooling device. The targetted
> platform is ARM and ARM64.
> 
> The cpuidle and the cpufreq cooling device are based on the device tree.
> 
> As the cpuidle cooling device can have its own configuration depending
> on the platform and the available idle states. The DT node description
> will give the optional properties to set the cooling device up.
> 
> Do no longer rely on the CPU node which is prone to error and will
> lead to a confusion in the DT because the cpufreq cooling device is
> also using it. Let initialize the cpuidle cooling device with the DT
> binding.
> 
> This was tested on:
>   - hikey960
>   - hikey6220
>   - rock960
>   - db845c
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/cpuidle_cooling.c | 58 +++++++++++++++++++++++++------
>   include/linux/cpu_cooling.h       |  7 ----
>   2 files changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 0bb843246f59..b2c81c427f05 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -10,6 +10,7 @@
>   #include <linux/err.h>
>   #include <linux/idle_inject.h>
>   #include <linux/idr.h>
> +#include <linux/of_device.h>
>   #include <linux/slab.h>
>   #include <linux/thermal.h>
>   
> @@ -154,22 +155,25 @@ static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
>   };
>   
>   /**
> - * cpuidle_of_cooling_register - Idle cooling device initialization function
> + * __cpuidle_cooling_register: register the cooling device
>    * @drv: a cpuidle driver structure pointer
> - * @np: a node pointer to a device tree cooling device node
> + * @np: a device node structure pointer used for the thermal binding
>    *
> - * This function is in charge of creating a cooling device per cpuidle
> - * driver and register it to thermal framework.
> + * This function is in charge of allocating the cpuidle cooling device
> + * structure, the idle injection, initialize them and register the
> + * cooling device to the thermal framework.
>    *
> - * Return: zero on success, or negative value corresponding to the
> - * error detected in the underlying subsystems.
> + * Return: zero on success, a negative value returned by one of the
> + * underlying subsystem in case of error
>    */
> -int cpuidle_of_cooling_register(struct device_node *np,
> -				struct cpuidle_driver *drv)
> +static int __cpuidle_cooling_register(struct device_node *np,
> +				      struct cpuidle_driver *drv)
>   {
>   	struct idle_inject_device *ii_dev;
>   	struct cpuidle_cooling_device *idle_cdev;
>   	struct thermal_cooling_device *cdev;
> +	unsigned int idle_duration_us = TICK_USEC;
> +	unsigned int latency_us = UINT_MAX;
>   	char dev_name[THERMAL_NAME_LENGTH];
>   	int id, ret;
>   
> @@ -191,7 +195,11 @@ int cpuidle_of_cooling_register(struct device_node *np,
>   		goto out_id;
>   	}
>   
> -	idle_inject_set_duration(ii_dev, TICK_USEC, TICK_USEC);
> +	of_property_read_u32(np, "duration", &idle_duration_us);

This probably is 'duration-us' according to DT bindings.

> +	of_property_read_u32(np, "latency", &latency_us);

the same here s/latency/exit-latency-us/

> +
> +	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
> +	idle_inject_set_latency(ii_dev, latency_us);
>   
>   	idle_cdev->ii_dev = ii_dev;
>   
> @@ -204,6 +212,9 @@ int cpuidle_of_cooling_register(struct device_node *np,
>   		goto out_unregister;
>   	}
>   
> +	pr_info("%s: Idle injection set with idle duration=%u, latency=%u\n",
> +		dev_name, idle_duration_us, latency_us);

1. It is more like a 'debug' rather than 'info', I would change it.
2. This is going to be printed for every CPU which has the
'thermal-idle' feature in DT. For platforms with many CPUs, it's a lot
of log entries

> +
>   	return 0;
>   
>   out_unregister:
> @@ -221,12 +232,37 @@ int cpuidle_of_cooling_register(struct device_node *np,
>    * @drv: a cpuidle driver structure pointer
>    *
>    * This function is in charge of creating a cooling device per cpuidle
> - * driver and register it to thermal framework.
> + * driver and register it to the thermal framework.
>    *
>    * Return: zero on success, or negative value corresponding to the
>    * error detected in the underlying subsystems.
>    */
>   int cpuidle_cooling_register(struct cpuidle_driver *drv)
>   {
> -	return cpuidle_of_cooling_register(NULL, drv);
> +	struct device_node *cooling_node;
> +	struct device_node *cpu_node;
> +	int cpu, ret;
> +
> +	for_each_cpu(cpu, drv->cpumask) {
> +
> +		cpu_node = of_cpu_device_node_get(cpu);
> +
> +		cooling_node = of_get_child_by_name(cpu_node, "idle-thermal");

In DT binding this is 'thermal-idle'.

> +
> +		of_node_put(cpu_node);
> +
> +		if (!cooling_node)
> +			continue;

This 'continue' is suspicious because it won't tell if there was no
node "idle-thermal" but still the function will return 0. This was
my case when I tried to enable it on Juno.

Maybe a debug print that the node hasn't been found would be a
good idea. Or somehow return different value than 0 taking into
account that every CPU was skipped.

> +
> +		ret = __cpuidle_cooling_register(cooling_node, drv);
> +
> +		of_node_put(cooling_node);
> +
> +		if (ret)
> +			return ret;
> +
> +		cooling_node = NULL;
> +	}
> +
> +	return 0;
>   }
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 65501d8f9778..4d7b4a303327 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -64,18 +64,11 @@ struct cpuidle_driver;
>   
>   #ifdef CONFIG_CPU_IDLE_THERMAL
>   int cpuidle_cooling_register(struct cpuidle_driver *drv);
> -int cpuidle_of_cooling_register(struct device_node *np,
> -				struct cpuidle_driver *drv);
>   #else /* CONFIG_CPU_IDLE_THERMAL */
>   static inline int cpuidle_cooling_register(struct cpuidle_driver *drv)
>   {
>   	return 0;
>   }
> -static inline int cpuidle_of_cooling_register(struct device_node *np,
> -					      struct cpuidle_driver *drv)
> -{
> -	return 0;
> -}
>   #endif /* CONFIG_CPU_IDLE_THERMAL */
>   
>   #endif /* __CPU_COOLING_H__ */
> 

Apart from that, looks good to me.

Regards,
Lukasz
