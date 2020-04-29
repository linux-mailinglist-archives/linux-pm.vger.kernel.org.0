Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ECC1BE80D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 22:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgD2UCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 16:02:47 -0400
Received: from foss.arm.com ([217.140.110.172]:44232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2UCm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 16:02:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A581063;
        Wed, 29 Apr 2020 13:02:41 -0700 (PDT)
Received: from [10.37.12.43] (unknown [10.37.12.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330973F68F;
        Wed, 29 Apr 2020 13:02:39 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
Date:   Wed, 29 Apr 2020 21:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200429103644.5492-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/29/20 11:36 AM, Daniel Lezcano wrote:
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
>   - V4:
>     - Do not check the return value as the function does no longer return one
> ---
>   drivers/cpuidle/cpuidle-arm.c  | 3 +++
>   drivers/cpuidle/cpuidle-psci.c | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 9e5156d39627..8c758920d699 100644
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
> @@ -124,6 +125,8 @@ static int __init arm_idle_init_cpu(int cpu)
>   	if (ret)
>   		goto out_kfree_drv;
>   
> +	cpuidle_cooling_register(drv);
> +
>   	return 0;
>   
>   out_kfree_drv:
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index bae9140a65a5..1f38e0dfc9b2 100644
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
> @@ -313,6 +314,8 @@ static int __init psci_idle_init_cpu(int cpu)
>   	if (ret)
>   		goto out_kfree_drv;
>   
> +	cpuidle_cooling_register(drv);
> +
>   	return 0;
>   
>   out_kfree_drv:
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
