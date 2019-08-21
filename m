Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9909096EFD
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHUBkh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:40:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42200 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUBkh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:40:37 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190821014034epoutp02834719ce81510d33408e46b6041e5fed~8zINCFnl30868708687epoutp02V
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 01:40:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190821014034epoutp02834719ce81510d33408e46b6041e5fed~8zINCFnl30868708687epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566351634;
        bh=DBTVMSu9gjD00QxVLNLWHsfEe/nOQp9LMblnarsdGZU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Dqlp97qdq7V56qH6sZFU5MK1kClGrtIeiPgfzkwjEOwYTzLgCctu4vrAQhRaC0Z4W
         tme/Sh4yDC6IQlDB2rqchjxyzphhzR+TUpJW9zWeVGWYDJxTlUiKghjuvSjngUZc6c
         teCnaJI87nSbtGNEYSvyNoOgwlFh1npKDur4ivr4=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190821014033epcas1p48b2358de31df3fcbc5f6a0e2b2e95495~8zIMTAW9z2474824748epcas1p4Q;
        Wed, 21 Aug 2019 01:40:33 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46Cr2l0LxtzMqYkV; Wed, 21 Aug
        2019 01:40:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.02.04075.E01AC5D5; Wed, 21 Aug 2019 10:40:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821014030epcas1p15e37fce54c5d53709b891517c898ab88~8zIJNKIW73080930809epcas1p1Q;
        Wed, 21 Aug 2019 01:40:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821014030epsmtrp1ebf8aefe17129646b68c54037246b0d4~8zIJLrEbB0616906169epsmtrp1X;
        Wed, 21 Aug 2019 01:40:30 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-e8-5d5ca10ef8f4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.3D.03638.E01AC5D5; Wed, 21 Aug 2019 10:40:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821014030epsmtip1d12af424cb4a47030c61a944604ee49f~8zII1V1Oi2170721707epsmtip1J;
        Wed, 21 Aug 2019 01:40:30 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6134bb9e-9a16-b432-c191-c91f93844319@samsung.com>
Date:   Wed, 21 Aug 2019 10:44:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3b93af7e61a573ea2a123c353255645b5ad2a805.1566314535.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TWUwTURT1dTrTAa0+K8pLPwQGMYEE7VCLg4IxSswkEEX9cQHrBEYgdLPT
        Ii6JuEbrDiTEqgi4BEEDrVUQ0WpZFHGvCoqIET7UKCqIMW6x7WDk77xzz333nLeQmMJLKMlc
        g4U3GzgdRQRLLzdHx8aOr0jPUN1om8t42i7JmOGOO4B554lmSq85CebBgzoZc2/7BxlT1fMF
        Z5x9z3Bm6EALYLq3VRFMzf2bBGPz/CYYxzA7X85+6tolY8udVtZZvZdgXz5rItiLp7eyjoEG
        CXtzoEnCHnRVA3bIOTUtaFVeYg7PZfHmcN6QaczKNWQnUSnLtQu1mngVHUsnMLOpcAOn55Oo
        5NS02EW5Op9pKjyf01l9VBonCNTMeYlmo9XCh+cYBUsSxZuydKYE0wyB0wtWQ/aMTKN+Dq1S
        xWl8wrV5OfUdZ4GpNaXg445mvBAMJtpAEIngLFRU0yixgWBSARsA6uspJfwFBRwE6JVdKxa+
        AdT1tUv6r8NZ3DrScQ2gz0e8UnHxCaCqO6eAXzUJzkcDV+sDW4XANoBe/ND7RRh8I0G9f7wB
        EQFjkPttV0A0AUagp9/7ArwczkO3XQ7cBkhSCqNQe+liPz0ZrkCDr5txUTIRtR/tDzgKgmtQ
        94/iAMZgKHrRf1Ii4jC049IxzD8Xwesy9Lj7/EiEZPT+loMQ8SQfdslErETvDu0ewZvRufYW
        QmzeA5DL/RAXC2rkPlMs8ZvDYDSqbZwp0hHoys8TQMRyVOj4KRNNjEcDw/sDWfz8nt0KURKJ
        vK97JIdBpH1UHPuoCPZREez/h5UDaTWYwpsEfTYv0Ka40bftBIEHHRPfACrvp3oAJAE1Tt7w
        fHWGAufyhY16D0AkRoXIC46vylDIs7iNm3izUWu26njBAzS+wz6CKSdnGn3fw2DR0po4tVrN
        zKLjNTRNhcorvjMZCpjNWfg8njfx5n99EjJIWQiWhDqiVLYmNhLfRGxp0c+tq99Q0Lo4rnN9
        ybLQBdg+b0dvjOnJS3fjo/SOTtWWBNfdpKm/hnpVZbUXppfZjCXrpq1dKn3Ti9lSw8a+DSuZ
        PmZR8VaXR12zEvM2RoDH5DFPbnpI30f8t7Fi0C2b2Fk0YXtw6hhimyq5Ulk6bninQEmFHI6O
        wcwC9xcRsKzi5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnC7fwphYg9NPRSwOHdvKbvH19ClG
        i5eHNC2m793EZnH+/AZ2i7NNb9gtVtz9yGqx6fE1VovPvUcYLW43rmCzWH3uIJtF16G/bBYb
        v3o48Hq8v9HK7rFgU6nHplWdbB53ru1h89i8pN5j47sdTB4H3+1h8ujbsorR4/MmuQDOKC6b
        lNSczLLUIn27BK6M7aeXMRYc9a5423yYtYHxk00XIyeHhICJxKbJR5m6GLk4hAR2M0qsfHOF
        HSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSm+9vZQKpERZwkHi3ezsbSEJE4ASjxIola8AmMQs8
        YZL42/iDFaRKSOARo8TLriIQm01AS2L/ixtsIDa/gKLE1R+PGUFsXgE7iRNbNrKCbGMRUJU4
        Od0PJCwqECFxeMcsqBJBiZMzn7CA2JwCcRK3f00Gs5kF1CX+zLvEDGGLS9x6Mp8JwpaXaN46
        m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwbGq
        pbWD8cSJ+EOMAhyMSjy8O25GxwqxJpYVV+YeYpTgYFYS4a2YExUrxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgXGSQWnmxhU3Eh3a5+dYlJ4xzYy8EFV9
        ceKGT+KSRg5sL3ZXzpSZ+U2Pd827+ZZrErQVl5VFaLj5/b/B5WGhk3jhKpPjqmWGSRdeXo53
        D7mk8EpPy3//jc8XnJY9YLpepPHI9dKT5EWnXvKy/jOceWZamvYyDufFNvKzhaKtTZZwRgdm
        R36cNUGJpTgj0VCLuag4EQBo0Y/20QIAAA==
X-CMS-MailID: 20190821014030epcas1p15e37fce54c5d53709b891517c898ab88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190820152410epcas4p214cadab5d2acfb2c659a777f2caa002b
References: <cover.1566314535.git.leonard.crestez@nxp.com>
        <CGME20190820152410epcas4p214cadab5d2acfb2c659a777f2caa002b@epcas4p2.samsung.com>
        <3b93af7e61a573ea2a123c353255645b5ad2a805.1566314535.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 21. 오전 12:24, Leonard Crestez wrote:
> Add dev_pm_qos notifies to devfreq core in order to support frequency
> limits via the dev_pm_qos_add_request.
> 
> Unlike the rest of devfreq the dev_pm_qos frequency is measured in Khz,
> this is consistent with current dev_pm_qos usage for cpufreq and
> allows frequencies above 2Ghz (pm_qos expresses limits as s32).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 95 ++++++++++++++++++++++++++++++++++++---
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 95 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 784c08e4f931..58deffa52a37 100644
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
> @@ -96,10 +97,30 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  		dev_pm_opp_put(opp);
>  
>  	return max_freq;
>  }
>  
> +static unsigned long get_effective_min_freq(struct devfreq *devfreq)

I'm not sure that 'effective' expression is correct.
From this function, the devfreq can get the final target frequency.

I think that we need to use the more correct expression
to give the meaning of function as following:

get_min_freq
get_max_freq

or

get_biggest_min_freq
get_biggest_max_freq

or

others if there are more proper function name.


> +{
> +	lockdep_assert_held(&devfreq->lock);
> +
> +	return max3(devfreq->scaling_min_freq, devfreq->min_freq,
> +		1000 * (unsigned long)dev_pm_qos_read_value(

I prefer to use 'KHZ' defintion instead of 1000.
The constant definition is more easy to inform
the correct meaning of constant.

> +				devfreq->dev.parent,
> +				DEV_PM_QOS_MIN_FREQUENCY));
> +}
> +
> +static unsigned long get_effective_max_freq(struct devfreq *devfreq)

ditto.

> +{
> +	lockdep_assert_held(&devfreq->lock);
> +
> +	return min3(devfreq->scaling_max_freq, devfreq->max_freq,
> +		1000 * (unsigned long)dev_pm_qos_read_value(

ditto.

> +				devfreq->dev.parent,
> +				DEV_PM_QOS_MAX_FREQUENCY));
> +}
> +
>  /**
>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:	the devfreq instance
>   * @freq:	the target frequency
>   */
> @@ -356,12 +377,12 @@ int update_devfreq(struct devfreq *devfreq)
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
> @@ -570,10 +591,37 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
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
> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb,
> +					 unsigned long val, void *ptr)
> +{
> +	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_min);
> +
> +	return devfreq_qos_notifier_call(devfreq);
> +}
> +
> +static int devfreq_qos_max_notifier_call(struct notifier_block *nb,
> +					 unsigned long val, void *ptr)
> +{
> +	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_max);
> +
> +	return devfreq_qos_notifier_call(devfreq);
> +}

Although the all functions has not the function description in devfreq.c,
You need to add the function description for newly added functions.

> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
>   *
>   * Remove devfreq from the list and release its resources.
> @@ -592,10 +640,14 @@ static void devfreq_dev_release(struct device *dev)
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +			DEV_PM_QOS_MAX_FREQUENCY);
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +			DEV_PM_QOS_MIN_FREQUENCY);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
>  
>  /**
> @@ -636,21 +688,40 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
>  	mutex_init(&devfreq->lock);
> -	mutex_lock(&devfreq->lock);

Basically, I think that it is safe to lock when touch
the variable of the devfreq.

it is not proper way for the dev_pm_qos because 
it breaks the existing locking reason of devfreq's variables. 

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
> +	if (err)
> +		goto err_dev;
> +
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +				      DEV_PM_QOS_MAX_FREQUENCY);
> +	if (err)
> +		goto err_dev;
> +
> +	mutex_lock(&devfreq->lock);
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
>  			goto err_dev;
> @@ -741,10 +812,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_unlock(&devfreq_list_lock);
>  err_devfreq:
>  	devfreq_remove_device(devfreq);
>  	devfreq = NULL;
>  err_dev:
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +				   DEV_PM_QOS_MAX_FREQUENCY);
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +				   DEV_PM_QOS_MIN_FREQUENCY);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(devfreq_add_device);
> @@ -1312,12 +1387,17 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	ssize_t ret;
> +
> +	mutex_lock(&df->lock);
> +	ret = sprintf(buf, "%lu\n", get_effective_min_freq(df));
> +	mutex_unlock(&df->lock);
>  
> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> +	return ret;
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -1357,12 +1437,17 @@ static DEVICE_ATTR_RW(min_freq);
>  
>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	ssize_t ret;
>  
> -	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
> +	mutex_lock(&df->lock);
> +	ret = sprintf(buf, "%lu\n", get_effective_max_freq(df));
> +	mutex_unlock(&df->lock);
> +
> +	return ret;
>  }
>  static DEVICE_ATTR_RW(max_freq);
>  
>  static ssize_t available_frequencies_show(struct device *d,
>  					  struct device_attribute *attr,
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
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
