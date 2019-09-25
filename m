Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A71BD652
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633827AbfIYCLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 22:11:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38075 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633816AbfIYCLU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 22:11:20 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190925021117epoutp010542c0e9e3e96e81ba7437b3dc6188ac~HjIAmE69u0289602896epoutp01G
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 02:11:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190925021117epoutp010542c0e9e3e96e81ba7437b3dc6188ac~HjIAmE69u0289602896epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569377477;
        bh=VDVXq7IxSweeNsC/J6QvU1m/j6KrjZrXRBglDbAyZxI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wsm1gMXHqcfhP518caymH5muq11OqQTmvX2T5Qk5Cm5eLn8uM5JZkgg0kAtsANTXt
         ANpwnGc8YK7cou57OcOl47MzhANhXN+ClYvjk8266GjjDztBfNLYxOrcQhkI8uq7Fl
         P8LOVIDf+ascU8bZBnFGxCCUQPSLJ0uxkB/fn44k=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190925021116epcas1p4d00682476f01f11b0402276f59af2887~HjIAEzIaR2206122061epcas1p4C;
        Wed, 25 Sep 2019 02:11:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46dM41633rzMqYkk; Wed, 25 Sep
        2019 02:11:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.63.04224.1CCCA8D5; Wed, 25 Sep 2019 11:11:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925021113epcas1p2ac23b18f9d1285b6af984657183c952e~HjH9En7D60134301343epcas1p24;
        Wed, 25 Sep 2019 02:11:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925021113epsmtrp128f8e2e67ade04cba255e4e03066612b~HjH9DqeVR1655016550epsmtrp1a;
        Wed, 25 Sep 2019 02:11:13 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-b9-5d8accc11a1d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.78.03889.1CCCA8D5; Wed, 25 Sep 2019 11:11:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925021112epsmtip28e98ea100e68dcd6d501346db5544235~HjH8rFlwW0843508435epsmtip2d;
        Wed, 25 Sep 2019 02:11:12 +0000 (GMT)
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <40885624-8f11-4eea-d5bf-d6bb50fa44dd@samsung.com>
Date:   Wed, 25 Sep 2019 11:15:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmvu7BM12xBl/nGVocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4AeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZyy9V1Uw0b5ixvxOpgbGc0ZdjBwcEgImErPfOXYxcnEICexg
        lDi4+DAjhPOJUWLRmbvsEM43Ron3X/eww3Q8naYMEd/LKLH131qooveMEnd/HGLrYuTkEBaw
        kfh/9SMbSEJEYDWjRMvSO4wgCWaBJ8wSe9bLg9hsAloS+1/cAGvgF1CUuPrjMVgNr4CdxJtL
        J8BsFgFViYYdK5hAbFGBCIlPDw6zQtQISpyc+YQFxOYUiJNo2DyPFWK+uMStJ/OZIGx5ieat
        s5lBjpAQOMUu8XXGGiaIF1wkVq30AqmREBCWeHV8CzuELSXxsr8Nyq6WWHnyCBtEbwejxJb9
        F1ghEsYS+5dOBpvDLKApsX6XPkRYUWLn77lQP/JJvPvawwqxileio00IokRZ4vKDu0wQtqTE
        4vZOtgmMSrOQfDMLyQezkHwwC2HZAkaWVYxiqQXFuempxYYFJshxvYkRnMS1LHYw7jnnc4hR
        gINRiYfXgbUrVog1say4MvcQowQHs5II7ywZoBBvSmJlVWpRfnxRaU5q8SFGU2BgT2SWEk3O
        B2aYvJJ4Q1MjY2NjCxNDM1NDQyVxXo/0hlghgfTEktTs1NSC1CKYPiYOTqkGRktl7axpT78c
        Sm8/HR3Qld1W+DJO4qylyqeUMjkPoVePyjXE2mcmVE2sCPgpkBE76X+Xi8LtZZpClcw9Qp+/
        Tv/GyJ9dqZ7F0qOhsdx9nr/4RVvBCXmaH5+pbz/dt7qosPWe/ezkBaGfTh6P7AzaV37iB+fd
        oGAWa6Er4TEc3zdc66irjRVTYinOSDTUYi4qTgQAZ0SkpfgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSvO7BM12xBsd/ClocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgylt6rKphoXzFjfidTA+M5oy5GDg4J
        AROJp9OUuxi5OIQEdjNKrLg1jaWLkRMoLikx7eJRZogaYYnDh4shat4ySjw68gGsRljARuL/
        1Y9sILaIwFpGiTnnHUBsZoFnzBIndqVBNDxilJjUu4oRJMEmoCWx/8UNsAZ+AUWJqz8eg8V5
        Bewk3lw6AWazCKhKNOxYwQRiiwpESBzeMQuqRlDi5MwnYIs5BeIkGjbPY4VYpi7xZ94lZghb
        XOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswt
        Ls1L10vOz93ECI5nLa0djCdOxB9iFOBgVOLhdWDtihViTSwrrsw9xCjBwawkwjtLBijEm5JY
        WZValB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBkefr6pbGz7ZMl/4u
        ucIjsaqj6ybnarunhstvPBUPeZ3kn9BdZlIpdppvyo5mhvK9IeERs9XfTUiOLfqsqSd1b/o/
        jQQr5lS5O243foXXTuizq0p0XGkrIsslddNpwqdPpfGF/5Zu/6N05PaVxYbbprDqL/ZON3+1
        aEIUn/QevilHNUXWyS36rMRSnJFoqMVcVJwIAHRynM/jAgAA
X-CMS-MailID: 20190925021113epcas1p2ac23b18f9d1285b6af984657183c952e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924101145epcas4p37f7d25b8743c25520b33fa392cd80d45
References: <cover.1569319738.git.leonard.crestez@nxp.com>
        <CGME20190924101145epcas4p37f7d25b8743c25520b33fa392cd80d45@epcas4p3.samsung.com>
        <58fdd2c226a4e76a3d9427baab7dd5c23af842ab.1569319738.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> No notifiers are added by this patch but PM QoS constraints can be
> imposed externally (for example from other devices).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index eee403e70c84..784f3e40536a 100644
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
> +	unsigned long qos_min_freq, qos_max_freq;
>  
>  	lockdep_assert_held(&devfreq->lock);
>  
>  	/*
>  	 * Init min/max frequency from freq table.
> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>  	} else {
>  		*min_freq = freq_table[devfreq->profile->max_state - 1];
>  		*max_freq = freq_table[0];
>  	}
>  
> +	/* constraints from PM QoS */

As I commented on patch4,
'constraints' -> 'Constraint' because first verb have to be used
as the sigular verbs.

I prefer to use following comments: 

	/* Constraint minimum/maximum frequency from PM QoS constraints */

> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MIN_FREQUENCY);
> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
> +					     DEV_PM_QOS_MIN_FREQUENCY);
> +	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
> +	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
> +
>  	/* constraints from sysfs */
>  	*min_freq = max(*min_freq, devfreq->min_freq);
>  	*max_freq = min(*max_freq, devfreq->max_freq);
>  
>  	/* constraints from OPP interface */
> @@ -606,10 +618,49 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	mutex_unlock(&devfreq->lock);
>  
>  	return ret;
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
> +				"failed to update frequency for PM QoS constraints (%d)\n",

Is it not over 80 char?

> +				err);
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
> @@ -620,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
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

Just print error with dev_err() without stopping the release step.

I prefer to handle the return value if kernel API provides
the error code.

>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
> @@ -733,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	if (err) {
>  		put_device(&devfreq->dev);
>  		goto err_out;
>  	}
>  
> +	/*
> +	 * Register notifiers for updates to min/max_freq after device is
> +	 * initialized (and we can handle notifications) but before the
> +	 * governor is started (which should do an initial enforcement of
> +	 * constraints).
> +	 */

My previous comment is not enough why I prefer to remove it. Sorry.
Actually, until now, the devfreq_add_device() don't have the detailed
comments because the line code is not too long. But, at the present time,
devfreq_add_device() is too long. It means that the detailed comment
are necessary. 

So, I'll add the detailed comment for each step of devfreq_add_device()
on separate patch to keep the same style. I'll send the patch to you
for the review.

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
> @@ -760,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> index c3cbc15fdf08..dac0dffeabb4 100644
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
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
