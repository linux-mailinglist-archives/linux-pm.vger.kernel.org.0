Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8FCC13E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfJDREx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 13:04:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41067 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbfJDREx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 13:04:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so4073130pgv.8
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KhkqAIY0k94dgHo1jB/Vv2pJIDzyfrngfxICnM3UhIk=;
        b=oKDL7vXewTCQ6flY9+GhG6ANFwAYC5RUKT0iI62i33VnnHbij+UaW7lDV/TUjHWVTC
         19kG6Xk2LgbBP6cwlfRiOVa3CUxh+EbCsZnzqaPNAbSpu4A7PlSAppWqne8EtOt8sa4J
         W/d/70+j/heKSxOi2CqsWs6j6c+p/3r6Tstc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KhkqAIY0k94dgHo1jB/Vv2pJIDzyfrngfxICnM3UhIk=;
        b=lErxerdGPgxbDx7VYZuyxk80bcC+MB24gqkkbzBbuCxqIJLN78rgN6GB0cexZx16OU
         JSFBUopnewzPMW7PdVuf0rJn7qafRIgGeIFR6DKZr5PEHicMPkEtYj5ayCeu9QvLGlRG
         0W/Mvra46sMpG/s7Pho4Txpr8D3UllRsNsYDA6rbG5lN2oFZ51H5qbER895iARHthQhl
         im1e7ShOvSU5w4FdlWvxX7/GjkwR8Z2o2nHoDULlsEjG8M9m1fKn47LsdLXmIbFKiztw
         6Vd/aH0weTntcNAlQtnRwcGXK40yIdDe7/M7eVJYa/SK5lpbnJUfYxtjiqPWMBoAvjYe
         mbPg==
X-Gm-Message-State: APjAAAXOnAo9YNOshEbF3A77h0BsY2aKzrgM1US/Q1kHfInVkNgo1tfQ
        GPWNus4pVwgQaIsRXd7vU8xCWbC/bjM=
X-Google-Smtp-Source: APXvYqwuIe0ULUTkIv0WHmr2b0f1ybCo+KvmxqbU1VCA3X3UU+MplnLxh6ZQ29vyCrbjgx1EQjNUMw==
X-Received: by 2002:a17:90a:25a9:: with SMTP id k38mr18712120pje.12.1570208692216;
        Fri, 04 Oct 2019 10:04:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b4sm5066197pju.16.2019.10.04.10.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:04:51 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:04:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 7/8] PM / devfreq: Add PM QoS support
Message-ID: <20191004170449.GL87296@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <f538324afaeaef3256b3ea997e67562e940c2e3c.1570044052.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f538324afaeaef3256b3ea997e67562e940c2e3c.1570044052.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 10:25:10PM +0300, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> No notifiers are added by this patch but PM QoS constraints can be
> imposed externally (for example from other devices).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 78 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2d63692903ff..46f699b84a22 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -22,15 +22,18 @@
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
> +#define HZ_PER_KHZ	1000
> +
>  static struct class *devfreq_class;
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
>   * functions. Governors can use these or can implement their own
> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  static void get_freq_range(struct devfreq *devfreq,
>  			   unsigned long *min_freq,
>  			   unsigned long *max_freq)
>  {
>  	unsigned long *freq_table = devfreq->profile->freq_table;
> +	s32 qos_min_freq, qos_max_freq;
>  
>  	lockdep_assert_held(&devfreq->lock);
>  
>  	/*
>  	 * Initialize minimum/maximum frequency from freq table.
> @@ -125,10 +129,20 @@ static void get_freq_range(struct devfreq *devfreq,
>  	} else {
>  		*min_freq = freq_table[devfreq->profile->max_state - 1];
>  		*max_freq = freq_table[0];
>  	}
>  
> +	/* Apply constraints from PM QoS */
> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MIN_FREQUENCY);
> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MAX_FREQUENCY);
> +	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
> +	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)
> +		*max_freq = min(*max_freq,
> +				(unsigned long)HZ_PER_KHZ * qos_max_freq);
> +
>  	/* Apply constraints from sysfs */
>  	*min_freq = max(*min_freq, devfreq->min_freq);
>  	*max_freq = min(*max_freq, devfreq->max_freq);
>  
>  	/* Apply constraints from OPP interface */
> @@ -608,24 +622,75 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  			err);
>  
>  	return NOTIFY_OK;
>  }
>  
> +/**
> + * qos_notifier_call() - Common handler for QoS constraints.
> + * @devfreq:    the devfreq instance.
> + */
> +static int qos_notifier_call(struct devfreq *devfreq)
> +{
> +	int err;
> +
> +	mutex_lock(&devfreq->lock);
> +	err = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +	if (err)
> +		dev_err(devfreq->dev.parent,
> +			"failed to update frequency from PM QoS (%d)\n",
> +			err);
> +
> +	return NOTIFY_OK;
> +}
> +
> +/**
> + * qos_min_notifier_call() - Callback for QoS min_freq changes.
> + * @nb:		Should be devfreq->nb_min
> + */
> +static int qos_min_notifier_call(struct notifier_block *nb,
> +					 unsigned long val, void *ptr)
> +{
> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_min));
> +}
> +
> +/**
> + * qos_max_notifier_call() - Callback for QoS max_freq changes.
> + * @nb:		Should be devfreq->nb_max
> + */
> +static int qos_max_notifier_call(struct notifier_block *nb,
> +					 unsigned long val, void *ptr)
> +{
> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_max));
> +}
> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
>   *
>   * Remove devfreq from the list and release its resources.
>   */
>  static void devfreq_dev_release(struct device *dev)
>  {
>  	struct devfreq *devfreq = to_devfreq(dev);
> +	int err;
>  
>  	mutex_lock(&devfreq_list_lock);
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> +	err = dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +					 DEV_PM_QOS_MAX_FREQUENCY);
> +	if (err)
> +		dev_warn(dev->parent, "Failed to remove DEV_PM_QOS_MAX_FREQUENCY notifier: %d\n",
> +			 err);
> +	err = dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +			DEV_PM_QOS_MIN_FREQUENCY);
> +	if (err)
> +		dev_warn(dev->parent, "Failed to remove DEV_PM_QOS_MIN_FREQUENCY notifier: %d\n",
> +			 err);
> +
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
> @@ -735,10 +800,22 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	if (err) {
>  		put_device(&devfreq->dev);
>  		goto err_out;
>  	}
>  
> +	devfreq->nb_min.notifier_call = qos_min_notifier_call;
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +				      DEV_PM_QOS_MIN_FREQUENCY);
> +	if (err)
> +		goto err_devfreq;
> +
> +	devfreq->nb_max.notifier_call = qos_max_notifier_call;
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +				      DEV_PM_QOS_MAX_FREQUENCY);
> +	if (err)
> +		goto err_devfreq;
> +
>  	mutex_lock(&devfreq_list_lock);
>  
>  	governor = try_then_request_governor(devfreq->governor_name);
>  	if (IS_ERR(governor)) {
>  		dev_err(dev, "%s: Unable to find governor for the device\n",
> @@ -762,10 +839,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	return devfreq;
>  
>  err_init:
>  	mutex_unlock(&devfreq_list_lock);
> +err_devfreq:
>  	devfreq_remove_device(devfreq);
>  	return ERR_PTR(err);
>  
>  err_dev:
>  	/*
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2bae9ed3c783..8b92ccbd1962 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -134,10 +134,12 @@ struct devfreq_dev_profile {
>   * @total_trans:	Number of devfreq transitions
>   * @trans_table:	Statistics of devfreq transitions
>   * @time_in_state:	Statistics of devfreq states
>   * @last_stat_updated:	The last time stat updated
>   * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
> + * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>   *
>   * This structure stores the devfreq information for a give device.
>   *
>   * Note that when a governor accesses entries in struct devfreq in its
>   * functions except for the context of callbacks defined in struct
> @@ -176,10 +178,13 @@ struct devfreq {
>  	unsigned int *trans_table;
>  	unsigned long *time_in_state;
>  	unsigned long last_stat_updated;
>  
>  	struct srcu_notifier_head transition_notifier_list;
> +
> +	struct notifier_block nb_min;
> +	struct notifier_block nb_max;
>  };
>  
>  struct devfreq_freqs {
>  	unsigned long old;
>  	unsigned long new;
> -- 
> 2.17.1
> 

Tested-by: Matthias Kaehlcke <mka@chromium.org>
