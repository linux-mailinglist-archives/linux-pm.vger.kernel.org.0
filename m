Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9311BB8137
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392294AbfISTNB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 15:13:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38052 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392291AbfISTNB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 15:13:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so2925233pfe.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fsOi0SFfSN2yoIxCUiiprAv5GXxCTBdV5Rjzv/QvUC4=;
        b=Ygfi5PLgvOdlLEUfSsLPZjXG42DiRLdkLAvpYnycAmGDmrUr/TIXlWJAcIxsfn79Bs
         YBh/r0Wba9QRQLdw5gxXI5Pltq2MPJ+fvVPdlXtvGRtMYKgmz+DmXdqNDUq1ZbxsfYxB
         W+0CLUNYBHYIdtx1phNl/6TFF/PDM/vFDeWxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fsOi0SFfSN2yoIxCUiiprAv5GXxCTBdV5Rjzv/QvUC4=;
        b=dsOkinn8xlJzdUyeyVrCx5uUacX1BeUaA+wKhEwB73B4sShNc8qj00St9f/TCrRAOZ
         nMutZmWXxLYy2U/AjFYM8qOSPvGppkDZfnYsNP5JGIZez2r5UPfXA3KU+pozkYHgS6bY
         Zsr3GxUn4LbfJ79DQIoFdg4Sto1yE/4AnwTqi27K0IAoB+LPEuqa87cHxkWQQJH1eJMe
         G2qxmuR+2LXLgaENSYr4tEpxCpwI5vlyljXTIVZeNZgJ/cJ92dNs796Nu1kZpVMuUH5k
         tsHQ0hBGBof0iva2inGe2Y7rg6VGRWiIbBhDe8FZiHwLWwdUowgY3EbOYQNvWcrt7Ny8
         mbng==
X-Gm-Message-State: APjAAAWaBDVi6ohJIIc7X0xPCp8dTFl+nstZK3BC/pw5KzQNfy6eIjLZ
        yEkmDdixx3YeTf3hh96M/xV0AA==
X-Google-Smtp-Source: APXvYqzCGWxfh2CHzGuU/6Ulwz6TII5MmWjYtAf1Fq1mgvskK7rVHoYdtG5FhPUFjK9ZNIeMNLYA7Q==
X-Received: by 2002:a63:9557:: with SMTP id t23mr10546733pgn.236.1568920380569;
        Thu, 19 Sep 2019 12:13:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 22sm11354771pfo.131.2019.09.19.12.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:12:59 -0700 (PDT)
Date:   Thu, 19 Sep 2019 12:12:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/8] PM / devfreq: Add dev_pm_qos support
Message-ID: <20190919191258.GU133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <feab364d702ba62102f212b7d415d9f768159163.1568764439.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feab364d702ba62102f212b7d415d9f768159163.1568764439.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 03:18:25AM +0300, Leonard Crestez wrote:
> Register notifiers with the pm_qos framework in order to respond to
> requests for MIN_FREQUENCY and MAX_FREQUENCY.

To make it clear that this change on it's own is a NOP maybe add
something like "No constraints are added for now though.", as in
67d874c3b2c6 ("cpufreq: Register notifiers with the PM QoS framework")

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 71 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 51a4179e2c69..d8d57318b12c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,17 +22,20 @@
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
> +#include <linux/pm_qos.h>
>  #include "governor.h"
>  
>  #define HZ_PER_KHZ 1000
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>  
> +#define HZ_PER_KHZ	1000
> +
>  static struct class *devfreq_class;
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
>   * functions. Governors can use these or can implement their own
> @@ -123,10 +126,16 @@ static void devfreq_get_freq_range(struct devfreq *devfreq,
>  	} else {
>  		*min_freq = freq_table[devfreq->profile->max_state - 1];
>  		*max_freq = freq_table[0];
>  	}
>  
> +	/* constraints from dev_pm_qos: */

nit: QoS constraints?

> +	*min_freq = max(*min_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY));
> +	*max_freq = min(*max_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY));
> +
>  	/* constraints from sysfs: */
>  	*min_freq = max(*min_freq, devfreq->min_freq);
>  	*max_freq = min(*max_freq, devfreq->max_freq);
>  
>  	/* constraints from opp interface: */
> @@ -605,10 +614,49 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	mutex_unlock(&devfreq->lock);
>  
>  	return ret;
>  }
>  
> +/**
> + * devfreq_qos_notifier_call() - Common handler for qos freq changes.

nit: QoS

s/freq/constraint/ ?

> + * @devfreq:    the devfreq instance.
> + */
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
> +/**
> + * devfreq_qos_min_notifier_call() - Callback for qos min_freq changes.

nit: QoS

> + * @nb:		Should to be devfreq->nb_min

s/to//

> + */
> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb,
> +					 unsigned long val, void *ptr)
> +{
> +	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_min);
> +
> +	return devfreq_qos_notifier_call(devfreq);
> +}
> +
> +/**
> + * devfreq_qos_max_notifier_call() - Callback for qos min_freq changes.

nit: QoS

s/min/max/

> + * @nb:		Should to be devfreq->nb_max

s/to//

> + */
> +static int devfreq_qos_max_notifier_call(struct notifier_block *nb,
> +					 unsigned long val, void *ptr)
> +{
> +	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_max);
> +
> +	return devfreq_qos_notifier_call(devfreq);
> +}
> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
>   *
>   * Remove devfreq from the list and release its resources.
> @@ -619,10 +667,15 @@ static void devfreq_dev_release(struct device *dev)
>  
>  	mutex_lock(&devfreq_list_lock);
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +			DEV_PM_QOS_MAX_FREQUENCY);
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +			DEV_PM_QOS_MIN_FREQUENCY);
> +

mega-nit: removing 'max' then 'min' does things in reverse order as
during initialization, which is common practice. But since the order
here doesn't really matter I'd stick to the common min/max order,
might readers save a few milli-seconds wondering why 'max' comes first.

>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq->time_in_state);
> @@ -732,10 +785,27 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	if (err) {
>  		put_device(&devfreq->dev);
>  		goto err_out;
>  	}
>  
> +	/*
> +	 * Register notifiers for updates to min_freq/max_freq after device is

nit: min/max_freq?

> +	 * initialized (and we can handle notifications) but before the governor
> +	 * is started (which should do an initial enforcement of constraints)
> +	 */
> +	devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +				      DEV_PM_QOS_MIN_FREQUENCY);
> +	if (err)
> +		goto err_devfreq;

IIUC you rely on the notifiers being removed by
devfreq_dev_release(). Does dev_pm_qos_remove_notifier() behave
gracefully if the notifier is not initialized/added or do we need
to use BLOCKING_NOTIFIER_INIT() or similar?
