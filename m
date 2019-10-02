Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA3C943A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJBWWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 18:22:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36938 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBWWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 18:22:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so469807pgg.4
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2019 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3x/uZ2v71nKiHuA1l2DLcOV85Xrl9imqXxC2tU0hDMw=;
        b=hR9aWMd5pKusA+wHVRJNRRWVzPz+qr4HunnVe91cwtFPelEbZktHUtr5+vSPPcfDsu
         PYmDHm41tnPVdQi28Uklr56atWOpQyADGJlAFczs/pYzdnGVDVIxqH8Ecm4acVq32DeV
         fSph0hl0nRPQVYiN6lpYroFTsxw323ud+3/PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3x/uZ2v71nKiHuA1l2DLcOV85Xrl9imqXxC2tU0hDMw=;
        b=J7yfA77twE2ZvfJEwLn7Gt5fYx/qgJhyY8f9LE4UCV7KXZE9FQvIHwEufcazDg21of
         y3fEeE61LACnfoMwGRXNe3FTJ7r9bFFd0NoyJsK1DiVs0opUXwBVO3iGgjSRvh4RNaCs
         hnoBibQyJxvRxp8cEWLbgg2hay/aTBMWlHIkpxeIMHOD0Ln9vgMkT+MXDpNiMT5LVN43
         fzNoM1rginBqIODG6OBBWzLBKGWPu/8FJFKAxGTNhdeLwWrKIIqoSWbc9zzzGJSKEAKU
         ExuFx2sZc98OoGoU3DWC9FHHPMyol510WnvHMgYWno0EEIgnPws/2Yrn33kj3MU1XhNe
         8F0Q==
X-Gm-Message-State: APjAAAU+VtstlwP9H7UKgeJUgWe1vFUU90pJetxtbGkk+wKApqeG99yg
        nuVYK2eel8FjfkoL2Vbrp4YiPw==
X-Google-Smtp-Source: APXvYqyapDZF1vl7OezgrPQxbYLRW5ZBT4xBGiXszd9TZ689nKIydgzuV820CjSU+L1nBVKs3AHKSw==
X-Received: by 2002:a63:c306:: with SMTP id c6mr3863239pgd.253.1570054927673;
        Wed, 02 Oct 2019 15:22:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z29sm447812pff.23.2019.10.02.15.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 15:22:06 -0700 (PDT)
Date:   Wed, 2 Oct 2019 15:22:04 -0700
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
Message-ID: <20191002222204.GH87296@google.com>
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

I was concerned there might be a race where the notifier is still
running, but I confirmed that dev_pm_qos_mtx is held by
dev_pm_qos_remove_notifier() and also when the notifiers are called.

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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
