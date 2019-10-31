Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68D3EA95B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJaCzh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:55:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:60687 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfJaCzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:55:36 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191031025533epoutp04d4da591c26e126b89117f74d8445104e~Sm88hE6BK0937809378epoutp04i
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 02:55:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191031025533epoutp04d4da591c26e126b89117f74d8445104e~Sm88hE6BK0937809378epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572490533;
        bh=sspSSTqpzNiYjZffVd3hhHbrR/X1IETvBAP6ijeDJvM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l/kkKlDusoR6ip0qLiU7BP4AonCOGaiRnkzEy7hWLO7sjc7VIehsp/h6ZBMRkk88p
         d9aQJvg9TBbjjwU7ttAWkkb5BL8jQ0zjZQDZUF6UmJCucnW4DyBMu0OwM/iphHZhh6
         GYOFJ5ADUCSMNKQtPkW8S1ziK4xeTlXFEO+N/iiM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191031025533epcas1p1c3536e718da10fd71e5a684a2f082f2a~Sm88E52jc3144531445epcas1p1a;
        Thu, 31 Oct 2019 02:55:33 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 473VLV5533zMqYkZ; Thu, 31 Oct
        2019 02:55:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.BC.04085.22D4ABD5; Thu, 31 Oct 2019 11:55:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191031025529epcas1p41580433643982bb082673d91dcc9b9ce~Sm84z03j30530705307epcas1p4b;
        Thu, 31 Oct 2019 02:55:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191031025529epsmtrp25d7fabbed6701e99a9adb642c00f89c7~Sm84y86QN1072710727epsmtrp2Q;
        Thu, 31 Oct 2019 02:55:29 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-f6-5dba4d226ecd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.4D.24756.12D4ABD5; Thu, 31 Oct 2019 11:55:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191031025529epsmtip24d93453850093c3825fa77ab3061516b~Sm84kxec72027120271epsmtip2X;
        Thu, 31 Oct 2019 02:55:29 +0000 (GMT)
Subject: Re: [PATCH v9 7/8] PM / devfreq: Add PM QoS support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <67149311-a716-b175-ee19-fdde3a40b28a@samsung.com>
Date:   Thu, 31 Oct 2019 12:01:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f538324afaeaef3256b3ea997e67562e940c2e3c.1570044052.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmrq6S765Yg6Vr1S0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW6y4+5HVYtPja6wWXb9WMlt87j3CaPF5w2NGi9uNK9gs
        Vp87yGbRdegvm8XGrx4O/B7vb7Sye8xuuMjisWBTqcemVZ1sHneu7WHz2Lyk3mPjux1MHgff
        7WHy6NuyitHj8ya5AK6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxU
        WyUXnwBdt8wcoCeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnp
        esn5uVaGBgZGpkCFCdkZL0+9YSr47lCxquUTewPje+MuRk4OCQETie1nljN1MXJxCAnsYJQ4
        de4EO0hCSOATo8TNKYUQiW+MEpPnXWKF6Wj++BWqYy+jxP8nN1ghnPeMEn9b9rGAVAkL2Ei8
        uXiVCcQWEaiTuLX4BDNIEbPAc2aJpwdnMoMk2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCT2Pr+
        KVgNi4CqxPptbUBxDg5RgQiJ018TIUoEJU7OfMICEuYUiJOY020CEmYWEJe49WQ+E4QtL9G8
        dTbYWgmBc+wSix/sYoT4wEVi69MFTBC2sMSr41vYIWwpic/v9rJB2NUSK08eYYNo7mCU2LL/
        AtT7xhL7l05mAlnMLKApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGWuPzgLtRa
        SYnF7Z1sExiVZiH5ZhaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkSN7EyM4fWuZ72DccM7n
        EKMAB6MSD++Esp2xQqyJZcWVuYcYJTiYlUR4v9kAhXhTEiurUovy44tKc1KLDzGaAsN6IrOU
        aHI+MLfklcQbmhoZGxtbmBiamRoaKonzOi5fGiskkJ5YkpqdmlqQWgTTx8TBKdXAKD5/3aOD
        QfXJX77xf5L6bstzil94jow926bbjBtnL7woXuArcFLE1I15nqnck6e6lY96fq+UclD44/Yj
        ZHVNyQ8Llzed29siDU/Mrsl2qjoTbSf/nDWXReE094drzZsWH5jULBwm8t1ik8l6c6d65SYF
        ryfmxQrBSgZ6+lZRTt7uK4wzJ9grsRRnJBpqMRcVJwIAcBlBUPUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSvK6i765Yg97LuhaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLVbc/chqsenxNVaLrl8rmS0+9x5htPi84TGjxe3GFWwW
        q88dZLPoOvSXzWLjVw8Hfo/3N1rZPWY3XGTxWLCp1GPTqk42jzvX9rB5bF5S77Hx3Q4mj4Pv
        9jB59G1ZxejxeZNcAFcUl01Kak5mWWqRvl0CV8bLU2+YCr47VKxq+cTewPjeuIuRk0NCwESi
        +eNXpi5GLg4hgd2MEjOm32KFSEhKTLt4lLmLkQPIFpY4fLgYouYto8SaN7vBaoQFbCTeXLzK
        BGKLCNRJ/Hm+D2wQs8BzZokN97+yQnQ8YpR43feSHaSKTUBLYv+LG2wgNr+AosTVH48ZQWxe
        ATuJre+fMoPYLAKqEuu3tYHFRQUiJJ5vvwFVIyhxcuYTFpCLOAXiJOZ0m4CEmQXUJf7Mu8QM
        YYtL3HoynwnClpdo3jqbeQKj8Cwk3bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJ
        ucWleel6yfm5mxjBsayluYPx8pL4Q4wCHIxKPLwTynbGCrEmlhVX5h5ilOBgVhLh/WYDFOJN
        SaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoFR70LjXbnSPOFj
        z6NyM0RnHK4LY/v+8ReXS0na5kzFaCddU7G6y0uZc9NFQle9ufWgca5IBFeCn1+3IvufSY8c
        7q8vajjjsrVqz8L55501ZK+JaqnMX1n4R4S75m/qa4OONtaQuRGXbSdbNrYxvj5uI/aw/P7+
        G+3lzGXH1osvTND+MeORw1IlluKMREMt5qLiRABqYeFw4QIAAA==
X-CMS-MailID: 20191031025529epcas1p41580433643982bb082673d91dcc9b9ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191002192529epcas3p3573b0d65d7b149fe3f2c073e2113a07f
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <CGME20191002192529epcas3p3573b0d65d7b149fe3f2c073e2113a07f@epcas3p3.samsung.com>
        <f538324afaeaef3256b3ea997e67562e940c2e3c.1570044052.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

It looks good to me. Thanks for your effort.
But, I have one minor comment related to 'over 80 char'.

In the devfreq_dev_release(), please edit this line
as following to protect the over 80 char on one line
if there are no specific reason.

		dev_warn(dev->parent,
			"Failed to remove DEV_PM_QOS_MAX_FREQUENCY notifier: %d\n",
			err);

		dev_warn(dev->parent,
			"Failed to remove DEV_PM_QOS_MIN_FREQUENCY notifier: %d\n",
			err);


If you edit them, feel free to add my reviewed-by tag:

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


On 19. 10. 3. 오전 4:25, Leonard Crestez wrote:
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

Please edit this line as following to protect the over 80 char
on one line if there are no specific reason.

		dev_warn(dev->parent,
			"Failed to remove DEV_PM_QOS_MAX_FREQUENCY notifier: %d\n",
			err);


> +	err = dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
> +			DEV_PM_QOS_MIN_FREQUENCY);
> +	if (err)
> +		dev_warn(dev->parent, "Failed to remove DEV_PM_QOS_MIN_FREQUENCY notifier: %d\n",
> +			 err);
> +

Please edit this line as following to protect the over 80 char
on one line if there are no specific reason.


		dev_warn(dev->parent,
			"Failed to remove DEV_PM_QOS_MIN_FREQUENCY notifier: %d\n",
			err);


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
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
