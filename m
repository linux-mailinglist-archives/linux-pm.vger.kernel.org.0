Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00A1099E8
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 09:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfKZIDW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 03:03:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43377 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfKZIDV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 03:03:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so3584910plr.10
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 00:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Q0EDEuSC1u9SRsCtaYMm2HqYxfYcQCWFv26nwXdP88=;
        b=TSNPciRPB+Wn14eBFRY9yhgWXttjm8ce5Jh2h/hUX30QdqmCAVDr0uZagN3zl6AqFG
         Axdlr+zAukr8VHLEVmK2VRtWBTuRndYriMhf8KoC+Foy/b9Iy48QHhkW7ZD3Ws8YUwHp
         oBBEsNviGPm9kmUgTSuX295kNHgIlo3umvGj6f/9MHetnh1ZuZDT31D8JSD/sVhSiRE0
         TuAb3swJ3bVi4TbVCvWTv3tdtvfXt3ugCajw8IARxZuVlY+OfwLRHzrjWG9GykLBXC72
         CDdirefiXfPcD6BqlT2F8yhtW2oTO9rYBD0Gl/gI1irlh42JWoaVZs1DAni3Oj+x1cxY
         WneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Q0EDEuSC1u9SRsCtaYMm2HqYxfYcQCWFv26nwXdP88=;
        b=f1ItPu+XiPSJnbmW0ZXLsBpgmyd5sj8lp8Mwwtibhrd9qwKX6BaB3Nqa8F9Xp0/FxE
         amzkgQXPg0Ja1pdfQ+pWDG8GW6/8KMVONJhO4ft3+/x8RBlfV7vh/6KD/hrOmscp2MR8
         b2YwmRbrOHSse3iMqpJQ9m9GWmEzjfW+P72uBu0T0XGTHlhC3Mt/j0aXFlrTRwTFS8uq
         HfvreAw+FEVP5Bzbq4fB5DltiV1IaBkosGgmZs1DYfJ2t3d+Ke+zZGLk8mJr6OsU1bl+
         UIO/xHkDbNOhCgnedTCL//jUfmliBe4u/vnoDsfNB56NlhZ1SyLehxIA7aYEjYu8XDR/
         FdlQ==
X-Gm-Message-State: APjAAAWtuYGl1VBwuYH9YZmZbWNgYrYXodLv3kGnFFNnvybnaM5v7zyH
        G4wSOfxrqsJVYaH+s9Izx7zfWQ==
X-Google-Smtp-Source: APXvYqwGuYe6wNEFduKxK/jznJLleNsDVzbsINjaQFryXM06oPnryx0LV3AOZ3dRyy33jwQEkxJRXw==
X-Received: by 2002:a17:902:a410:: with SMTP id p16mr32541741plq.184.1574755399008;
        Tue, 26 Nov 2019 00:03:19 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id k5sm1927711pju.14.2019.11.26.00.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 00:03:17 -0800 (PST)
Date:   Tue, 26 Nov 2019 13:33:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
Message-ID: <20191126080315.zc5rllbsc5utuhzq@vireshk-i7>
References: <20191113084042.5707-1-daniel.lezcano@linaro.org>
 <20191113084042.5707-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113084042.5707-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-11-19, 09:40, Daniel Lezcano wrote:
> The cpu idle cooling device offers a new method to cool down a CPU by
> injecting idle cycles at runtime.
> 
> It has some similarities with the intel power clamp driver but it is
> actually designed to be more generic and relying on the idle injection
> powercap framework.
> 
> The idle injection cycle is fixed while the running cycle is variable. That
> allows to have control on the device reactivity for the user experience.
> 
> An idle state powering down the CPU or the cluster will allow to drop
> the static leakage, thus restoring the heat capacity of the SoC. It
> can be set with a trip point between the hot and the critical points,
> giving the opportunity to prevent a hard reset of the system when the
> cpufreq cooling fails to cool down the CPU.
> 
> With more sophisticated boards having a per core sensor, the idle
> cooling device allows to cool down a single core without throttling
> the compute capacity of several cpus belonging to the same clock line,
> so it could be used in collaboration with the cpufreq cooling device.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig           |   7 +
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/cpuidle_cooling.c | 233 ++++++++++++++++++++++++++++++
>  include/linux/cpu_cooling.h       |  22 +++
>  4 files changed, 263 insertions(+)
>  create mode 100644 drivers/thermal/cpuidle_cooling.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 2b82c4861091..00d69906c508 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -168,6 +168,13 @@ config CPU_FREQ_THERMAL
>  	  This will be useful for platforms using the generic thermal interface
>  	  and not the ACPI interface.
>  
> +config CPU_IDLE_THERMAL
> +	bool "CPU idle cooling device"
> +	depends on IDLE_INJECT
> +	help
> +	  This implements the CPU cooling mechanism through
> +	  idle injection. This will throttle the CPU by injecting
> +	  idle cycle.
>  endif
>  
>  config CLOCK_THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index d3b01cc96981..9c8aa2d4bd28 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -20,6 +20,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
>  
>  # cpufreq cooling
>  thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o

We should really rename this as cpufreq_cooling now :)

> +thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
>  
>  # clock cooling
>  thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> new file mode 100644
> index 000000000000..6e911fa87c47
> --- /dev/null
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2019 Linaro Limited.
> + *
> + *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + */
> +#include <linux/cpu_cooling.h>
> +#include <linux/cpuidle.h>
> +#include <linux/err.h>
> +#include <linux/idle_inject.h>
> +#include <linux/idr.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +/**
> + * struct cpuidle_cooling_device - data for the idle cooling device
> + * @ii_dev: an atomic to keep track of the last task exiting the idle cycle
> + * @idle_duration_us: an integer defining the duration of the idle injection
> + * @state: an normalized integer giving the state of the cooling device
> + */
> +struct cpuidle_cooling_device {
> +	struct idle_inject_device *ii_dev;
> +	unsigned int idle_duration_us;

This field is set with TICK_USEC and nothing else. Why not just use TICK_USEC
instead at all the places and remove this field?

> +	unsigned long state;
> +};
> +
> +static DEFINE_IDA(cpuidle_ida);
> +
> +/**
> + * cpuidle_cooling_runtime - Running time computation
> + * @idle_duration_us: the idle cooling device
> + * @state: a percentile based number
> + *
> + * The running duration is computed from the idle injection duration
> + * which is fixed. If we reach 100% of idle injection ratio, that
> + * means the running duration is zero. If we have a 50% ratio
> + * injection, that means we have equal duration for idle and for
> + * running duration.
> + *
> + * The formula is deduced as the following:
> + *
> + *  running = idle x ((100 / ratio) - 1)
> + *
> + * For precision purpose for integer math, we use the following:
> + *
> + *  running = (idle x 100) / ratio - idle
> + *
> + * For example, if we have an injected duration of 50%, then we end up
> + * with 10ms of idle injection and 10ms of running duration.
> + *
> + * Returns an unsigned int for an usec based runtime duration.
> + */
> +static unsigned int cpuidle_cooling_runtime(unsigned int idle_duration_us,
> +					    unsigned long state)
> +{
> +	if (!state)
> +		return 0;
> +
> +	return ((idle_duration_us * 100) / state) - idle_duration_us;
> +}
> +
> +/**
> + * cpuidle_cooling_get_max_state - Get the maximum state
> + * @cdev  : the thermal cooling device
> + * @state : a pointer to the state variable to be filled
> + *
> + * The function always gives 100 as the injection ratio is percentile
> + * based for consistency accros different platforms.
> + *
> + * The function can not fail, it always returns zero.
> + */
> +static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *state)
> +{
> +	/*
> +	 * Depending on the configuration or the hardware, the running
> +	 * cycle and the idle cycle could be different. We want unify
> +	 * that to an 0..100 interval, so the set state interface will
> +	 * be the same whatever the platform is.
> +	 *
> +	 * The state 100% will make the cluster 100% ... idle. A 0%
> +	 * injection ratio means no idle injection at all and 50%
> +	 * means for 10ms of idle injection, we have 10ms of running
> +	 * time.
> +	 */
> +	*state = 100;
> +
> +	return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_get_cur_state - Get the current cooling state
> + * @cdev: the thermal cooling device
> + * @state: a pointer to the state
> + *
> + * The function just copy the state value from the private thermal
> + * cooling device structure, the mapping is 1 <-> 1.
> + *
> + * The function can not fail, it always returns zero.
> + */
> +static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
> +					 unsigned long *state)
> +{
> +	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
> +
> +	*state = idle_cdev->state;
> +
> +	return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_set_cur_state - Set the current cooling state
> + * @cdev: the thermal cooling device
> + * @state: the target state
> + *
> + * The function checks first if we are initiating the mitigation which
> + * in turn wakes up all the idle injection tasks belonging to the idle
> + * cooling device. In any case, it updates the internal state for the
> + * cooling device.
> + *
> + * The function can not fail, it always returns zero.
> + */
> +static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
> +					 unsigned long state)
> +{
> +	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
> +	struct idle_inject_device *ii_dev = idle_cdev->ii_dev;
> +	unsigned long current_state = idle_cdev->state;
> +	unsigned int runtime_us;
> +
> +	idle_cdev->state = state;
> +
> +	runtime_us = cpuidle_cooling_runtime(idle_cdev->idle_duration_us,
> +					     state);
> +
> +	idle_inject_set_duration(ii_dev, runtime_us,
> +				 idle_cdev->idle_duration_us);
> +
> +	if (current_state == 0 && state > 0) {
> +		idle_inject_start(ii_dev);
> +	} else if (current_state > 0 && !state)  {
> +		idle_inject_stop(ii_dev);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_ops - thermal cooling device ops
> + */
> +static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
> +	.get_max_state = cpuidle_cooling_get_max_state,
> +	.get_cur_state = cpuidle_cooling_get_cur_state,
> +	.set_cur_state = cpuidle_cooling_set_cur_state,
> +};
> +
> +/**
> + * cpuidle_of_cooling_register - Idle cooling device initialization function
> + * @drv: a cpuidle driver structure pointer
> + *
> + * This function is in charge of creating a cooling device per cpuidle
> + * driver and register it to thermal framework.
> + *
> + * Returns a valid pointer to a thermal cooling device, a PTR_ERR
> + * corresponding to the error detected in the underlying subsystems.
> + */
> +struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +				   struct cpuidle_driver *drv)
> +{
> +	struct idle_inject_device *ii_dev;
> +	struct cpuidle_cooling_device *idle_cdev;
> +	struct thermal_cooling_device *cdev;
> +	char dev_name[THERMAL_NAME_LENGTH];
> +	int id, ret;
> +
> +	ii_dev = idle_inject_register(drv->cpumask);
> +	if (IS_ERR(ii_dev)) {
> +		ret = PTR_ERR(ii_dev);
> +		goto out;
> +	}
> +

I am not sure what's the best way of doing this, but I would have done this
after allocating idle_cdev and id.

> +	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
> +	if (!idle_cdev) {
> +		ret = -ENOMEM;
> +		goto out_unregister;
> +	}
> +
> +	id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto out_kfree;
> +	}
> +
> +	idle_cdev->ii_dev = ii_dev;
> +	idle_cdev->idle_duration_us = TICK_USEC;
> +
> +	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
> +
> +	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
> +						  &cpuidle_cooling_ops);
> +	if (IS_ERR(cdev)) {
> +		ret = PTR_ERR(cdev);
> +		goto out_id;
> +	}
> +
> +	return cdev;
> +out_id:
> +	ida_simple_remove(&cpuidle_ida, id);
> +out_kfree:
> +	kfree(idle_cdev);
> +out_unregister:
> +	idle_inject_unregister(ii_dev);
> +out:
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * cpuidle_cooling_register - Idle cooling device initialization function
> + * @drv: a cpuidle driver structure pointer
> + *
> + * This function is in charge of creating a cooling device per cpuidle
> + * driver and register it to thermal framework.
> + *
> + * Returns a valid pointer to a thermal cooling device, a PTR_ERR
> + * corresponding to the error detected in the underlying subsystems.
> + */
> +struct thermal_cooling_device *
> +__init cpuidle_cooling_register(struct cpuidle_driver *drv)
> +{
> +	return cpuidle_of_cooling_register(NULL, drv);
> +}
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 3cdd85f987d7..7873ac2f740b 100644
> --- a/include/linux/cpu_cooling.h
> +++ b/include/linux/cpu_cooling.h
> @@ -60,4 +60,26 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  }
>  #endif /* CONFIG_CPU_FREQ_THERMAL */
>  
> +struct cpuidle_driver;
> +
> +#ifdef CONFIG_CPU_IDLE_THERMAL
> +extern struct thermal_cooling_device *
> +__init cpuidle_cooling_register(struct cpuidle_driver *drv);
> +extern struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +				   struct cpuidle_driver *drv);
> +#else /* CONFIG_CPU_IDLE_THERMAL */
> +static inline struct thermal_cooling_device *
> +__init cpuidle_cooling_register(struct cpuidle_driver *drv)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +extern struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +				   struct cpuidle_driver *drv)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +#endif /* CONFIG_CPU_IDLE_THERMAL */
> +
>  #endif /* __CPU_COOLING_H__ */
> -- 
> 2.17.1

-- 
viresh
