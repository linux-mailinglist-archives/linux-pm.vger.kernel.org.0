Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A29330AA1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 10:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCHJyP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 04:54:15 -0500
Received: from foss.arm.com ([217.140.110.172]:35130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhCHJx6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 04:53:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D421331B;
        Mon,  8 Mar 2021 01:53:57 -0800 (PST)
Received: from [10.57.19.192] (unknown [10.57.19.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188F03F73C;
        Mon,  8 Mar 2021 01:53:55 -0800 (PST)
Subject: Re: [PATCH v5 1/4] PM / devfreq: Register devfreq as a cooling device
 on demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     cwchoi00@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210308091646.28096-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <c6d6781a-759c-0361-aaaa-28a625e4809b@arm.com>
Date:   Mon, 8 Mar 2021 09:53:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210308091646.28096-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

In general the approach is good. If there is a special GPU driver, which
would like to provide 'struct devfreq_cooling_power *' it would leave
'is_cooling_device=false' and register manually:
devfreq_cooling_em_register(df, dfc_power);

Please find only a few minor comments below.


On 3/8/21 9:16 AM, Daniel Lezcano wrote:
> Currently the default behavior is to manually having the devfreq
> backend to register themselves as a devfreq cooling device.
> 
> Instead of adding the code in the drivers for the thermal cooling
> device registering, let's provide a flag in the devfreq's profile to
> tell the common devfreq code to register the newly created devfreq as
> a cooling device.
> 
> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   V5:
>     - Changed subject prefix by:  PM / devfreq
>   V4:
>     - Replaced thermal_cooling_device_unregister() by
>       devfreq_cooling_unregister()
>   V3:
>     - Rebased on linux-pm branch without units.h
>     - Set the cdev to NULL in case of error
>     - Added description for the cdev field in the devfreq structure
>   V2:
>     - Added is_cooling_device boolean in profile structure
>     - Register cooling device when the is_cooling_device boolean is set
>     - Remove devfreq cooling device registration in the backend drivers
>   V1:
>     - Register devfreq as a cooling device unconditionnally
> ---
>   drivers/devfreq/devfreq.c | 13 +++++++++++++
>   include/linux/devfreq.h   |  8 ++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3047896e41..8a535d4d6083 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -11,6 +11,7 @@
>   #include <linux/kmod.h>
>   #include <linux/sched.h>
>   #include <linux/debugfs.h>
> +#include <linux/devfreq_cooling.h>
>   #include <linux/errno.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -26,6 +27,7 @@
>   #include <linux/hrtimer.h>
>   #include <linux/of.h>
>   #include <linux/pm_qos.h>
> +#include <linux/thermal.h>

Since the unregister is now called from devfreq_cooling.h, this header
here is not needed. It might rather be moved into the devfreq.h
where there is this new field: 'cdev' if we are going to use something
from it.

>   #include "governor.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -935,6 +937,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>   
>   	mutex_unlock(&devfreq_list_lock);
>   
> +	if (devfreq->profile->is_cooling_device) {
> +		devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
> +		if (IS_ERR(devfreq->cdev)) {
> +			dev_info(dev, "Failed to register devfreq "
> +				 "cooling device\n");

I would skip this print. Not every kernel config has DEVFREQ_THERMAL set
and the value ERR_PTR(-EINVAL) from header would be returned in such
case.
Inside the devfreq_cooling_em_register() (and others) there are prints
showing that something wrong happen and would be triggered if compiled.

> +			devfreq->cdev = NULL;
> +		}
> +	}
> +
>   	return devfreq;
>   
>   err_init:
> @@ -960,6 +971,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   	if (!devfreq)
>   		return -EINVAL;
>   
> +	devfreq_cooling_unregister(devfreq->cdev);
> +
>   	if (devfreq->governor) {
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..aba7ace11b72 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -98,11 +98,15 @@ struct devfreq_dev_status {
>    * @freq_table:		Optional list of frequencies to support statistics
>    *			and freq_table must be generated in ascending order.
>    * @max_state:		The size of freq_table.
> + *
> + * @is_cooling_device: A self-explanatory boolean giving the device a
> + *                     cooling effect property.
>    */
>   struct devfreq_dev_profile {
>   	unsigned long initial_freq;
>   	unsigned int polling_ms;
>   	enum devfreq_timer timer;
> +	bool is_cooling_device;
>   
>   	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>   	int (*get_dev_status)(struct device *dev,
> @@ -156,6 +160,7 @@ struct devfreq_stats {
>    * @suspend_count:	 suspend requests counter for a device.
>    * @stats:	Statistics of devfreq device behavior
>    * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @cdev:	Cooling device pointer if the devfreq has cooling property
>    * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>    * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>    *
> @@ -198,6 +203,9 @@ struct devfreq {
>   
>   	struct srcu_notifier_head transition_notifier_list;
>   
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;

The linux/thermal.h for 'cdev' would be needed in this header.

> +
>   	struct notifier_block nb_min;
>   	struct notifier_block nb_max;
>   };
> 

With this small changes:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
