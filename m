Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6748464D
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfHGHvk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 03:51:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39185 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfHGHvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 03:51:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so39558584pls.6
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJ01oB8fetnELHlakoJbJRGKLzx2RhrbKps49zJ3zvk=;
        b=YRwpyIMaSA9nI21SqoH/tLOBvo7hBeE7y5X+uGi0Lej7O+etRQOBYDxMt3h9RT2jIw
         co9tDmCI+GC0ucaG+0zC1XFMSWb+Wro1qnKPEG8W3u++qcjoqMEcAzTVLgoLxXytVZ4i
         F9YVLY9xZ4nGb1993QYoU23ThJCK8e2Z09imw/q2JxbVMhObPlbZ0M8JG3qC7YcvJcn+
         KcSHp7k+xDmOVXGHKn96BvrUjsTtO0+7YRkClOnenKf1myHrFnmkl6SzQuzI0jiEUQFG
         5sobb4DaPNrDkVhCmouWlBV1Tb5m+KUcO91t17yJIfsbQXjZGcmagfz9pIH+Ed8Wtey8
         Nkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJ01oB8fetnELHlakoJbJRGKLzx2RhrbKps49zJ3zvk=;
        b=FD3+VUXybrr5KgBcDN2EFzsqnT36iBqu6km8zqOEnEEeoHpuq2SaZcDMvGLRdOEjtR
         +mdfcaKaICqpeb4MmPCM2rUT9YsF63dIqqrpyB7MAqJLEqc+nSUZoHv7qgB1+8GC+CBO
         eT3G9KClTnStDSMZ+Oe0Dn+N4c80szuFXneJ5Bs1J6MmBbwoxlt01EXQam2fkQRu/YRk
         Cm0XtAtNBJu9Z0213inShNLQUdyE5cCYr390xKjQ7a/EgH2tuFyxBCWWjrl+acYooiyj
         qSWk/4t8BlpNG091EcUBQMd/5onGPDjUuGuP+9FVSECnRLWCz3kX5wRwRbBaBEWRSBVI
         zZXw==
X-Gm-Message-State: APjAAAX1T1LcBMJL/4z0W1SB8sqmRUu1E9jkLW7rixSTctE46LDEp9rb
        JGgbZq5IaJX8vXsCwEiHWavFnA==
X-Google-Smtp-Source: APXvYqw64cHGNNM/bjb3jbhZ8YhI/HGuoMpyVK0MdmV3lGnZYsF4ecBqBVyBKVix2n9aV8aOdWQ/KA==
X-Received: by 2002:aa7:8b51:: with SMTP id i17mr8127762pfd.33.1565164298986;
        Wed, 07 Aug 2019 00:51:38 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id i14sm140097565pfk.0.2019.08.07.00.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 00:51:38 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:21:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add dev_pm_qos support
Message-ID: <20190807075136.m5xxuemojm2xebck@vireshk-i7>
References: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-08-19, 12:03, Leonard Crestez wrote:
> Add dev_pm_qos notifies to devfreq core in order to support frequency
> limits via dev_pm_qos_add_request and related APIs
> 
> Unlike the rest of devfreq the dev_pm_qos frequency is measured kHz:
> this is consistent with current dev_pm_qos usage for cpufreq and allows
> frequencies above 2Ghz.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 77 ++++++++++++++++++++++++++++++++++-----
>  include/linux/devfreq.h   |  3 ++
>  2 files changed, 71 insertions(+), 9 deletions(-)
> 
> This was inspired by recent changes adding dev_pm_qos limits for
> cpufreq: https://lkml.org/lkml/2019/7/4/118
> 
> The pm_qos code make deep assumptions that requests need to be
> expressed as "s32" through it's use of "plist". Handling freq as a kHz
> values seems the easiest solution for this, perhaps it should be
> documented in dev_pm_qos itself?
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 784c08e4f931..de9e825ae1f4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,10 +22,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
> +#include <linux/pm_qos.h>
>  #include "governor.h"
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>  
> @@ -96,10 +97,26 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  		dev_pm_opp_put(opp);
>  
>  	return max_freq;
>  }
>  
> +static unsigned long get_effective_min_freq(struct devfreq *devfreq)
> +{
> +	return max3(devfreq->scaling_min_freq, devfreq->min_freq,
> +		1000 * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent,
> +				DEV_PM_QOS_MIN_FREQUENCY));
> +}
> +
> +static unsigned long get_effective_max_freq(struct devfreq *devfreq)
> +{
> +	return min3(devfreq->scaling_max_freq, devfreq->max_freq,
> +		1000 * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent,
> +				DEV_PM_QOS_MAX_FREQUENCY));
> +}
> +
>  /**
>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:	the devfreq instance
>   * @freq:	the target frequency
>   */
> @@ -356,12 +373,12 @@ int update_devfreq(struct devfreq *devfreq)
>  	 *
>  	 * List from the highest priority
>  	 * max_freq
>  	 * min_freq
>  	 */
> -	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> -	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
> +	max_freq = get_effective_max_freq(devfreq);
> +	min_freq = get_effective_min_freq(devfreq);
>  
>  	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
> @@ -570,10 +587,31 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	mutex_unlock(&devfreq->lock);
>  
>  	return ret;
>  }
>  
> +static int devfreq_qos_notifier_call(struct devfreq *devfreq)
> +{
> +	int ret;
> +
> +	mutex_lock(&devfreq->lock);
> +	ret = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +
> +	return ret;
> +}
> +
> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb, unsigned long type, void *devp)
> +{
> +	return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_min));
> +}
> +
> +static int devfreq_qos_max_notifier_call(struct notifier_block *nb, unsigned long type, void *devp)
> +{
> +	return devfreq_qos_notifier_call(container_of(nb, struct devfreq, nb_max));
> +}
> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
>   *
>   * Remove devfreq from the list and release its resources.
> @@ -636,21 +674,46 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
>  	mutex_init(&devfreq->lock);
> -	mutex_lock(&devfreq->lock);
>  	devfreq->dev.parent = dev;
>  	devfreq->dev.class = devfreq_class;
>  	devfreq->dev.release = devfreq_dev_release;
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
> +	/*
> +	 * notifier from pm_qos
> +	 *
> +	 * initialized outside of devfreq->lock to avoid circular warning
> +	 * between devfreq->lock and dev_pm_qos_mtx
> +	 */
> +	devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
> +	devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
> +
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +				      DEV_PM_QOS_MIN_FREQUENCY);
> +	if (err) {
> +		dev_err(dev, "Failed to register MIN QoS notifier: %d\n", err);
> +		panic("fail\n");
> +		goto err_dev;
> +	}
> +
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +				      DEV_PM_QOS_MAX_FREQUENCY);
> +	if (err) {
> +		dev_err(dev, "Failed to register MAX QoS notifier: %d\n", err);

What about removing the earlier notifier ?

> +		panic("fail\n");
> +		goto err_dev;
> +	}
> +

I don't see you removing the notifiers anywhere, don't you need to do
that when the devices goes away ?

-- 
viresh
