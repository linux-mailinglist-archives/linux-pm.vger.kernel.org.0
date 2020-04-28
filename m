Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF411BC3BE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgD1Pbv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 11:31:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbgD1Pbu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Apr 2020 11:31:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0538B30E;
        Tue, 28 Apr 2020 08:31:50 -0700 (PDT)
Received: from [10.37.12.125] (unknown [10.37.12.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0ACA3F305;
        Tue, 28 Apr 2020 08:31:44 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
 <20200414220837.9284-4-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <db4eeecf-2126-e455-ef02-fc034c631e09@arm.com>
Date:   Tue, 28 Apr 2020 16:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200414220837.9284-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/14/20 11:08 PM, Daniel Lezcano wrote:
> The cpuidle driver can be used as a cooling device by injecting idle
> cycles. The DT binding for the idle state added an optional
> 
> When the property is set, register the cpuidle driver with the idle
> state node pointer as a cooling device. The thermal framework will do
> the association automatically with the thermal zone via the
> cooling-device defined in the device tree cooling-maps section.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/cpuidle/cpuidle-arm.c  | 5 +++++
>   drivers/cpuidle/cpuidle-psci.c | 5 +++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 9e5156d39627..2406ac0ae134 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -8,6 +8,7 @@
>   
>   #define pr_fmt(fmt) "CPUidle arm: " fmt
>   
> +#include <linux/cpu_cooling.h>
>   #include <linux/cpuidle.h>
>   #include <linux/cpumask.h>
>   #include <linux/cpu_pm.h>
> @@ -124,6 +125,10 @@ static int __init arm_idle_init_cpu(int cpu)
>   	if (ret)
>   		goto out_kfree_drv;
>   
> +	ret = cpuidle_cooling_register(drv);
> +	if (ret)
> +		pr_err("Failed to register the idle cooling device: %d\n", ret);

This and similar from cpuidle-psci.c might produce a lot of error log
entries. The 'return 0' below does not take into account that we failed
to register cpuidle cooling. Thus, I would rather ignore the return from 
cpuidle_cooling_register and move this print into
cpuidle_cooling_register function, changing it also to debug level.

> +
>   	return 0;
>   
>   out_kfree_drv:
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index edd7a54ef0d3..8e805bff646f 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -9,6 +9,7 @@
>   #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>   
>   #include <linux/cpuhotplug.h>
> +#include <linux/cpu_cooling.h>
>   #include <linux/cpuidle.h>
>   #include <linux/cpumask.h>
>   #include <linux/cpu_pm.h>
> @@ -305,6 +306,10 @@ static int __init psci_idle_init_cpu(int cpu)
>   	if (ret)
>   		goto out_kfree_drv;
>   
> +	ret = cpuidle_cooling_register(drv);
> +	if (ret)
> +		pr_err("Failed to register the idle cooling device: %d\n", ret);
> +

The same here. I would change it into one line:
+	cpuidle_cooling_register(drv);

>   	return 0;
>   
>   out_kfree_drv:
> 

Regards,
Lukasz
