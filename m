Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C098BC201
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 08:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfIXGrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 02:47:53 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43155 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfIXGrx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 02:47:53 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190924064750epoutp04057e546a7ba5f802af37518aee6dd376~HTQLwaF1n1344313443epoutp04j
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 06:47:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190924064750epoutp04057e546a7ba5f802af37518aee6dd376~HTQLwaF1n1344313443epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569307670;
        bh=DZV1TxgKw+t8rHFL/30Eqfw7PZJtp9s6p6WlQwPnG0M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cZMoiUEVDcDpVSmMR5n4a/jNUBD+JdOIgHZzfVWtflcvqUEUaX8kRo6RZJtswF940
         5r32uFmPfK7Ei93tjhxgKsN8A2YyXexdcYdl+xy/QeAKr+VzYZxlDVbim2pDQ6wLDM
         rLTaVB9IcbA7Gcb8pqShtzg33YkPoVRta330n9Gc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190924064749epcas1p33d7bb5aa1161a8d5fd2085a3ebcb102b~HTQLCnLUJ1621716217epcas1p3j;
        Tue, 24 Sep 2019 06:47:49 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46csFZ1t4DzMqYkh; Tue, 24 Sep
        2019 06:47:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.B7.04135.21CB98D5; Tue, 24 Sep 2019 15:47:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190924064745epcas1p173dda62a954610d36e9549ab1e45bd12~HTQHqnA5_1302613026epcas1p1V;
        Tue, 24 Sep 2019 06:47:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924064745epsmtrp1ef4d32f913f10fae5f360352d9eebd14~HTQHppidi0398303983epsmtrp1m;
        Tue, 24 Sep 2019 06:47:45 +0000 (GMT)
X-AuditID: b6c32a36-7fbff70000001027-8d-5d89bc125b0a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.54.03889.11CB98D5; Tue, 24 Sep 2019 15:47:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924064745epsmtip25ad020aecb02f9bbd8cb8e9ed34b1639~HTQHLbg1t1824318243epsmtip2g;
        Tue, 24 Sep 2019 06:47:45 +0000 (GMT)
Subject: Re: [PATCH v7 5/6] PM / devfreq: Add PM QoS support
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
        Martin Kepplinger <martink@posteo.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3eb36ce6-a9df-7f9a-1492-8747f2648e78@samsung.com>
Date:   Tue, 24 Sep 2019 15:52:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e9868310f9543b4f4a6c7bbe5d4d015da9a0e71d.1569272883.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJsWRmVeSWpSXmKPExsWy7bCmnq7Qns5Yg+ZdXBaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmhxbcVEVovP
        Gx4zWtxuXMFmsfrcQTaLrkN/2Sw2fvVwEPR4f6OV3WN2w0UWjwWbSj02repk87hzbQ+bx+Yl
        9R4b3+1g8jj4bg+Tx6/Doh59W1YxenzeJBfAHZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0kZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO6P771ymgukuFS/fHGdrYFxu1sXIySEhYCKx
        4fYl5i5GLg4hgR2MErsm/WCDcD4xSjy8BpP5xihx4vluFpiWc+ueMEEk9jJKvJ63mRXCec8o
        cfrzXHaQKmEBG4kTB5aCzRIRWM0o0bL0DiOIwyzQyyKx434H2Cw2AS2J/S9usIHY/AKKEld/
        PGYEsXkF7CRm7v8PZrMIqEosf7mDFcQWFYiQ+PTgMCtEjaDEyZlPwOZwCsRJrOqYCVbPLCAu
        cevJfCYIW16ieetssCckBB6xS3zd+4cd4gkXiT+vJrNC2MISr45vgYpLSbzsb4OyqyVWnjzC
        BtHcwSixZf8FqAZjif1LJwNt4ADaoCmxfpc+RFhRYufvuVBH8Em8+9rDClIiIcAr0dEmBFGi
        LHH5wV0mCFtSYnF7J9sERqVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAiPkCN/ECE7w
        WmY7GBed8znEKMDBqMTDW7CjI1aINbGsuDL3EKMEB7OSCO8mrbZYId6UxMqq1KL8+KLSnNTi
        Q4ymwNCeyCwlmpwPzD55JfGGpkbGxsYWJoZmpoaGSuK87ukNsUIC6YklqdmpqQWpRTB9TByc
        Ug2Mavv/P5KYxfnqxH6zNrYnCwTsryaF8LeuOlG8LCG18uFJPxvZVcrPmvYXXHvc8H3/a+Pf
        9nt28JTc8LfxnNDSsi8/hNNA5u9U3ieVVis/pMnvaP/dKPjuf57vSwWvyq8hv7827rDMVav8
        6D6v9EjfrY4dC3mOrfpzcb1BiS9r4m1H7dwb0XcYlViKMxINtZiLihMB4UC0PAYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7bCSvK7gns5Yg3eT1S0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi2oqJrBaf
        NzxmtLjduILNYvW5g2wWXYf+slls/OrhIOjx/kYru8fshossHgs2lXpsWtXJ5nHn2h42j81L
        6j02vtvB5HHw3R4mj1+HRT36tqxi9Pi8SS6AO4rLJiU1J7MstUjfLoEro/vvXKaC6S4VL98c
        Z2tgXG7WxcjJISFgInFu3ROmLkYuDiGB3YwS12csYoRISEpMu3iUuYuRA8gWljh8uBii5i2j
        xMQZs5lBaoQFbCROHFjKBmKLCKxllJhz3gGkiFmgl0Wi6eAKdoiOR4wSj09PAZvKJqAlsf/F
        DbAOfgFFias/HoPFeQXsJGbu/w9mswioSix/uYMVxBYViJA4vGMWVI2gxMmZT1hAbE6BOIlV
        HTPB4swC6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi
        3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4DjX0trBeOJE/CFGAQ5GJR5eiW0dsUKsiWXFlbmH
        GCU4mJVEeDdptcUK8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi
        4JRqYNSrVava4LebWWrmssnT3DkPFBxs2bc46qt7zdlDzlfOF21kqu7fILJ/wpRzU2I9b7V+
        LmNs+3jEWm959coyl+t33X+0v5/IPmXHVfcrOT5zZ780Tlt7OdnKPmeVO6dDZKRqhorh7jdW
        3AZm63T1Tq/dfoa3axHfW/2+GzP2aLhvrLz2VoFP9qASS3FGoqEWc1FxIgDu23n17wIAAA==
X-CMS-MailID: 20190924064745epcas1p173dda62a954610d36e9549ab1e45bd12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923211052epcas4p2ab1e4a6a1f50048752d2b90274ff6abf
References: <cover.1569272883.git.leonard.crestez@nxp.com>
        <CGME20190923211052epcas4p2ab1e4a6a1f50048752d2b90274ff6abf@epcas4p2.samsung.com>
        <e9868310f9543b4f4a6c7bbe5d4d015da9a0e71d.1569272883.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 24. 오전 6:10, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> No notifiers are added by this patch but PM QoS constraints can be
> imposed externally (for example from other devices).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 76 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7f152a582e78..9887408f23bb 100644
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

You have to remove it on patch4.

>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>  
> +#define HZ_PER_KHZ	1000> +
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
> +	/* constraints from PM QoS */

I think that it is not necessary. But, if you think it is required,
Please add the detailed comment with consistent comment style.

> +	*min_freq = max(*min_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY));
> +	*max_freq = min(*max_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
> +				devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY));

If you use the separate variable for getting the value from dev_pm_qos_read_value(),
you can add this line under 80 char. If there are any special reason,
I prefer to keep the line under 80 char.


> +
>  	/* constraints from sysfs */
>  	*min_freq = max(*min_freq, devfreq->min_freq);
>  	*max_freq = min(*max_freq, devfreq->max_freq);
>  
>  	/* constraints from OPP interface */
> @@ -605,10 +614,53 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>  	mutex_unlock(&devfreq->lock);
>  
>  	return ret;
>  }
>  
> +/**
> + * devfreq_qos_notifier_call() - Common handler for QoS constraints.
> + * @devfreq:    the devfreq instance.
> + */
> +static int devfreq_qos_notifier_call(struct devfreq *devfreq)

Also, as I commented on patch4, we better to remove 'devfreq' prefix
for internal function as following:
	devfreq_qos_notifier_call -> qos_notifier_call

> +{
> +	int err;
> +
> +	mutex_lock(&devfreq->lock);
> +	err = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +	if (err)
> +		dev_err(&devfreq->dev, "dvfs for QoS constraints"
> +				" failed with (%d) error\n", err);

'dvfs' is not full name. Also, the capital letter is more correct.
But, the devfreq used 'failed to ...' comment style on some points.

I suggest the comment as following:

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -628,8 +628,8 @@ static int devfreq_qos_notifier_call(struct devfreq *devfreq)
        err = update_devfreq(devfreq);
        mutex_unlock(&devfreq->lock);
        if (err)
-               dev_err(&devfreq->dev, "dvfs for QoS constraints"
-                               " failed with (%d) error\n", err);
+               dev_err(&devfreq->dev,
+                       "failed to update frequency with PMQoS (%d)\n", err);
 


> +
> +	/* QoS is best effort - let all notifiers run on error */

Please remove it.

> +	return NOTIFY_OK;
> +}
> +
> +/**
> + * devfreq_qos_min_notifier_call() - Callback for QoS min_freq changes.
> + * @nb:		Should be devfreq->nb_min
> + */
> +static int devfreq_qos_min_notifier_call(struct notifier_block *nb,

ditto.
	devfreq_qos_min_notifier_call -> qos_min_notifier_call

> +					 unsigned long val, void *ptr)
> +{
> +	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_min);
> +

nitpick. You can remove this line.

> +	return devfreq_qos_notifier_call(devfreq);
> +}
> +
> +/**
> + * devfreq_qos_max_notifier_call() - Callback for QoS max_freq changes.
> + * @nb:		Should be devfreq->nb_max
> + */
> +static int devfreq_qos_max_notifier_call(struct notifier_block *nb,

ditto.
	devfreq_qos_max_notifier_call -> qos_max_notifier_call


> +					 unsigned long val, void *ptr)
> +{
> +	struct devfreq *devfreq = container_of(nb, struct devfreq, nb_max);
> +

nitpick. You can remove this line.

> +	return devfreq_qos_notifier_call(devfreq);
> +}
> +
>  /**
>   * devfreq_dev_release() - Callback for struct device to release the device.
>   * @dev:	the devfreq device
>   *
>   * Remove devfreq from the list and release its resources.
> @@ -619,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
>  
>  	mutex_lock(&devfreq_list_lock);
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
> +			DEV_PM_QOS_MAX_FREQUENCY);
> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +			DEV_PM_QOS_MIN_FREQUENCY);

Even if devfreq_dev_release() is called at the end of device driver,
dev_pm_remove_notifier() have returned the value. Need to check
the return value for checking the error state.

> +
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
> @@ -732,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	if (err) {
>  		put_device(&devfreq->dev);
>  		goto err_out;
>  	}
>  
> +	/*
> +	 * Register notifiers for updates to min/max_freq after device is
> +	 * initialized (and we can handle notifications) but before the
> +	 * governor is started (which should do an initial enforcement of
> +	 * constraints).> +	 */

In the devfreq_add_device(), each step has not contained
the detailed comment. If possible, in order to keep the existing style,
please remove it. 

> +	devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +				      DEV_PM_QOS_MIN_FREQUENCY);
> +	if (err)
> +		goto err_devfreq;
> +
> +	devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
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
> @@ -759,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
