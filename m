Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E2D11223B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 05:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDExT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 23:53:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43837 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfLDExS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 23:53:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so5922908qkn.10
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 20:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25PHq8jadl5BtU/vRs/uN5qxizEanUmGzYAYzQ3sAzg=;
        b=wN+PrPzlJvaz1wKkNZm/hMDVgmdkinzagrcad8iKB7M2MVWSjRJcO1Nn9QgM3Y+BOi
         /hTn+gNq5V2I/P+2HvHReWcEN7FeIwcNs8LiZoZZ5hJpgsyfwE3iou+WD+U9bYcEuqPm
         sec81U0aUbWGJMXHrCORHMmcSzyYF9uuFYZcAYTd7jVnnP/KDXXabaB9mk5S+n+SLG8L
         JCMTWY5TB4NH2M8F0CNgNOI/4WBZRaqoGTX79EuB7VntOhLlKvsuSZVReNZQ8hRgdtZV
         5Lh0MD5sGjQMi04/mrEwbYiGjfvKXhNBWZVQ/rRDYQZhCBaraPgU7gTOUF59yuo1bNJG
         Z70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25PHq8jadl5BtU/vRs/uN5qxizEanUmGzYAYzQ3sAzg=;
        b=Nw6xNuYLyPU5jNpSASb1vCNMXJA9oDJL2GeauR3VWUlMIIlh8TPrCkEt//yQ2wqaJw
         8yySUxZadaMeMDguVDlIZ+TKAGGBJmTS1fSxxcJhoW2PTJb2hIb/rFi3R0nHx5ECZq0U
         CfGYHJKdNpY8Fxz0tSHSCrer5uPb4Vqc7fIJzU2Xf1sAaRbG/fCJ+N4X6sFfxEC1uCkH
         ngRlg5jmblucQ3y33cvbFggKEEgl1ZbB3c5A47Vz4KrnCQB9cahjBiq3nxFZIUmkcTEO
         8AiYoyEka/XU1PTDElkqoLNABc5rmGMMd3sJUiLe2odHl80onkR3wG3xW+G0ZKF3Fv9O
         DfkQ==
X-Gm-Message-State: APjAAAX229Q6ymVLX5nJ0ZdeAzLXzXJlVd389xfSwOTrFQtC9Jf4lNGR
        Dx3SFn7FYhwsWKENP8kFk/3cEDU8Pu0p0njDKKS9jw==
X-Google-Smtp-Source: APXvYqxzeJfFJHqpqB1OnniuFj2w/WXSc5zhhN5ZF4gsBo1o0PIVTkjrAuOkO/IbaOd93+msc+fHpklm0xhJl2L/OeE=
X-Received: by 2002:a05:620a:15d0:: with SMTP id o16mr1103150qkm.106.1575435197161;
 Tue, 03 Dec 2019 20:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20191203093704.7037-1-daniel.lezcano@linaro.org> <20191203093704.7037-3-daniel.lezcano@linaro.org>
In-Reply-To: <20191203093704.7037-3-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 4 Dec 2019 10:23:06 +0530
Message-ID: <CAP245DUvBz8exsQzCZB4RdB3rcVG8dDGmspSQdJwFjKop=EScQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 3, 2019 at 3:07 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The cpu idle cooling device offers a new method to cool down a CPU by
> injecting idle cycles at runtime.
>
> It has some similarities with the intel power clamp driver but it is
> actually designed to be more generic and relying on the idle injection
> powercap framework.
>
> The idle injection cycle is fixed while the running cycle is variable. That
> allows to have control on the device reactivity for the user experience.

s/cycle/period/ ? Since you use that in your documentation.

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
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  V3:
>    - Add missing parameter documentation (Viresh Kumar)
>    - Fixed function description (Viresh Kumar)
>    - Add entry in MAINTAINER file
>  V2:
>    - Remove idle_duration_us field and use idle_inject API instead (Viresh Kumar)
>    - Fixed function definition wheh CPU_IDLE_COOLING is not set
>    - Inverted the initialization in the init function (Viresh Kumar)
> ---
>  MAINTAINERS                       |   3 +
>  drivers/thermal/Kconfig           |   7 +
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/cpuidle_cooling.c | 234 ++++++++++++++++++++++++++++++
>  include/linux/cpu_cooling.h       |  22 +++
>  5 files changed, 267 insertions(+)
>  create mode 100644 drivers/thermal/cpuidle_cooling.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c570f0204b48..d2e92a0360f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16187,12 +16187,15 @@ F:    Documentation/devicetree/bindings/thermal/
>
>  THERMAL/CPU_COOLING
>  M:     Amit Daniel Kachhap <amit.kachhap@gmail.com>
> +M:     Daniel Lezcano <daniel.lezcano@linaro.org>
>  M:     Viresh Kumar <viresh.kumar@linaro.org>
>  M:     Javi Merino <javi.merino@kernel.org>
>  L:     linux-pm@vger.kernel.org
>  S:     Supported
>  F:     Documentation/driver-api/thermal/cpu-cooling-api.rst
> +F:     Documentation/driver-api/thermal/cpu-idle-cooling.rst
>  F:     drivers/thermal/cpu_cooling.c
> +F:     drivers/thermal/cpuidle_cooling.c
>  F:     include/linux/cpu_cooling.h
>
>  THINKPAD ACPI EXTRAS DRIVER
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 4e3ee036938b..4ee9953ba5ce 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -169,6 +169,13 @@ config CPU_FREQ_THERMAL
>           This will be useful for platforms using the generic thermal interface
>           and not the ACPI interface.
>
> +config CPU_IDLE_THERMAL
> +       bool "CPU idle cooling device"
> +       depends on IDLE_INJECT
> +       help
> +         This implements the CPU cooling mechanism through
> +         idle injection. This will throttle the CPU by injecting
> +         idle cycle.
>  endif
>
>  config CLOCK_THERMAL
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index d3b01cc96981..9c8aa2d4bd28 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -20,6 +20,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)     += power_allocator.o
>
>  # cpufreq cooling
>  thermal_sys-$(CONFIG_CPU_FREQ_THERMAL) += cpu_cooling.o
> +thermal_sys-$(CONFIG_CPU_IDLE_THERMAL) += cpuidle_cooling.o
>
>  # clock cooling
>  thermal_sys-$(CONFIG_CLOCK_THERMAL)    += clock_cooling.o
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> new file mode 100644
> index 000000000000..7d91a1b298d4
> --- /dev/null
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -0,0 +1,234 @@
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
> + * @state: an normalized integer giving the state of the cooling device

s/an/a/

> + */
> +struct cpuidle_cooling_device {
> +       struct idle_inject_device *ii_dev;
> +       unsigned long state;
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

How about using the term 'duty cycle' instead of ratio? It describes
the on/off (running/idle) waveform better.

> + * means the running duration is zero. If we have a 50% ratio
> + * injection, that means we have equal duration for idle and for
> + * running duration.
> + *
> + * The formula is deduced as the following:

s/the following/follows/

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

s/an/a/ since usec is actually a shortform for microseconds.

> + */
> +static unsigned int cpuidle_cooling_runtime(unsigned int idle_duration_us,
> +                                           unsigned long state)
> +{
> +       if (!state)
> +               return 0;
> +
> +       return ((idle_duration_us * 100) / state) - idle_duration_us;
> +}
> +
> +/**
> + * cpuidle_cooling_get_max_state - Get the maximum state
> + * @cdev  : the thermal cooling device
> + * @state : a pointer to the state variable to be filled
> + *
> + * The function always gives 100 as the injection ratio is percentile

s/gives/returns/

Split the sentence after ratio.

> + * based for consistency accros different platforms.

Typo: across

> + *
> + * The function can not fail, it always returns zero.
> + */
> +static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
> +                                        unsigned long *state)
> +{
> +       /*
> +        * Depending on the configuration or the hardware, the running
> +        * cycle and the idle cycle could be different. We want unify

s/want/want to/

> +        * that to an 0..100 interval, so the set state interface will
> +        * be the same whatever the platform is.
> +        *
> +        * The state 100% will make the cluster 100% ... idle. A 0%
> +        * injection ratio means no idle injection at all and 50%
> +        * means for 10ms of idle injection, we have 10ms of running
> +        * time.
> +        */
> +       *state = 100;
> +
> +       return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_get_cur_state - Get the current cooling state
> + * @cdev: the thermal cooling device
> + * @state: a pointer to the state
> + *
> + * The function just copy the state value from the private thermal

s/copy/copies/

> + * cooling device structure, the mapping is 1 <-> 1.
> + *
> + * The function can not fail, it always returns zero.

Add the Return keyword at the beginning to conform to kernel-doc. And
all other function return values in this file.

> + */
> +static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
> +                                        unsigned long *state)
> +{
> +       struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
> +
> +       *state = idle_cdev->state;
> +
> +       return 0;
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
> +                                        unsigned long state)
> +{
> +       struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
> +       struct idle_inject_device *ii_dev = idle_cdev->ii_dev;
> +       unsigned long current_state = idle_cdev->state;
> +       unsigned int runtime_us, idle_duration_us;
> +
> +       idle_cdev->state = state;
> +
> +       idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
> +
> +       runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
> +
> +       idle_inject_set_duration(ii_dev, runtime_us, idle_duration_us);
> +
> +       if (current_state == 0 && state > 0) {
> +               idle_inject_start(ii_dev);
> +       } else if (current_state > 0 && !state)  {
> +               idle_inject_stop(ii_dev);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * cpuidle_cooling_ops - thermal cooling device ops
> + */
> +static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
> +       .get_max_state = cpuidle_cooling_get_max_state,
> +       .get_cur_state = cpuidle_cooling_get_cur_state,
> +       .set_cur_state = cpuidle_cooling_set_cur_state,
> +};
> +
> +/**
> + * cpuidle_of_cooling_register - Idle cooling device initialization function
> + * @drv: a cpuidle driver structure pointer
> + * @np: a node pointer to a device tree cooling device node
> + *
> + * This function is in charge of creating a cooling device per cpuidle
> + * driver and register it to thermal framework.
> + *
> + * Returns a valid pointer to a thermal cooling device or a PTR_ERR
> + * corresponding to the error detected in the underlying subsystems.
> + */
> +struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +                                  struct cpuidle_driver *drv)
> +{
> +       struct idle_inject_device *ii_dev;
> +       struct cpuidle_cooling_device *idle_cdev;
> +       struct thermal_cooling_device *cdev;
> +       char dev_name[THERMAL_NAME_LENGTH];
> +       int id, ret;
> +
> +       idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
> +       if (!idle_cdev) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
> +       if (id < 0) {
> +               ret = id;
> +               goto out_kfree;
> +       }
> +
> +       ii_dev = idle_inject_register(drv->cpumask);
> +       if (IS_ERR(ii_dev)) {
> +               ret = PTR_ERR(ii_dev);
> +               goto out_id;
> +       }
> +
> +       idle_inject_set_duration(ii_dev, 0, TICK_USEC);
> +
> +       idle_cdev->ii_dev = ii_dev;
> +
> +       snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
> +
> +       cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
> +                                                 &cpuidle_cooling_ops);
> +       if (IS_ERR(cdev)) {
> +               ret = PTR_ERR(cdev);
> +               goto out_unregister;
> +       }
> +
> +       return cdev;
> +
> +out_unregister:
> +       idle_inject_unregister(ii_dev);
> +out_id:
> +       ida_simple_remove(&cpuidle_ida, id);
> +out_kfree:
> +       kfree(idle_cdev);
> +out:
> +       return ERR_PTR(ret);
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
> +       return cpuidle_of_cooling_register(NULL, drv);
> +}
> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
> index 3cdd85f987d7..da0970183d1f 100644
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
> +                                  struct cpuidle_driver *drv);
> +#else /* CONFIG_CPU_IDLE_THERMAL */
> +static inline struct thermal_cooling_device *
> +__init cpuidle_cooling_register(struct cpuidle_driver *drv)
> +{
> +       return ERR_PTR(-EINVAL);
> +}
> +static inline struct thermal_cooling_device *
> +__init cpuidle_of_cooling_register(struct device_node *np,
> +                                  struct cpuidle_driver *drv)
> +{
> +       return ERR_PTR(-EINVAL);
> +}
> +#endif /* CONFIG_CPU_IDLE_THERMAL */
> +
>  #endif /* __CPU_COOLING_H__ */
> --
> 2.17.1
>
