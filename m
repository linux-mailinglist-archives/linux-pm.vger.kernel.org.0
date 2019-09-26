Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E594BE9E1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfIZBHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:07:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18332 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfIZBHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:07:38 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190926010733epoutp03be0875197d6b072a0e77b9ab26f7d7f7~H15puWeD10411904119epoutp03M
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:07:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190926010733epoutp03be0875197d6b072a0e77b9ab26f7d7f7~H15puWeD10411904119epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569460053;
        bh=02LRQzc3zq1yjJmRI4y3xLH0J6Posi4QJAQSb0tVl7s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a5f8GKDyMbPxMPVYKN+6/FlkL6zFaQ7ApLWJtuiXO2hl4R92ZW1Ua46vDMTQHV4Nc
         lYsY9q7SShcrCFmy1HK6l5a1dTYqEGCXVaP83J7V9yP/lFcVgTO2mjea9nYOLM2L6O
         3jiT5s4rGRRkausT+5xCrSxcZoQgJqa7iGZYTlQs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190926010732epcas1p3e4701a99601072a165c1ca9cb15d1407~H15o-PdUe1268112681epcas1p3Y;
        Thu, 26 Sep 2019 01:07:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46dxc22Q7FzMqYkg; Thu, 26 Sep
        2019 01:07:30 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.1D.04068.F4F0C8D5; Thu, 26 Sep 2019 10:07:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190926010727epcas1p13f39ec7c0046e513397b6e3315d40b7d~H15kJVqen2973229732epcas1p1K;
        Thu, 26 Sep 2019 01:07:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190926010727epsmtrp19b8a5e165b7490d088e6ea08ea791861~H15kIWp401337013370epsmtrp1h;
        Thu, 26 Sep 2019 01:07:27 +0000 (GMT)
X-AuditID: b6c32a39-3b9219c000000fe4-90-5d8c0f4fa560
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.5D.04081.F4F0C8D5; Thu, 26 Sep 2019 10:07:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926010727epsmtip212f5f43eda3120dbd64939bc91d5f21f~H15j5WGbu2624026240epsmtip2d;
        Thu, 26 Sep 2019 01:07:27 +0000 (GMT)
Subject: Re: [PATCH v8 5/6] PM / devfreq: Add PM QoS support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5f12931b-92f8-15d8-8498-f02a7c2e999f@samsung.com>
Date:   Thu, 26 Sep 2019 10:12:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023573BA3D5C5D521DB689CEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfWwTZRzHfXq9azetPJYhPxbEcgYiMxs9Rscz3IhEJGeYsmgIU1LHsV26
        pa/ptQvIH+swTFYRpsboSowzzkpHJrSMOQnNsq4Op8gYbGMpYKabTohZaWeVlxBoexL33+d5
        7vO77/O9FzWlnWHy1fU2l+i0CRaWyVX2DKwqLNy64KBR3+MvIpHBUyqS+ulHRPwXv0fkk3CI
        IcPDJ1Tk531/qUjMs5QcvZagSWhqnCbeOwGKzL0fRWTuxBQiV5qOMuTY+X6GeCP3GBJM8S9g
        Pj6xX8Uf8Ywo+faQmw91tjD81fEzDH+yo5EPzvYq+P7ZMwr+UHcn4udCyypz3zSX1YlCrejU
        ibYae229zVTObnm9+sVqQ4meK+RKyTpWZxOsYjm7qaKycHO9JV2E1TUIFnd6q1KQJHb1hjKn
        3e0SdXV2yVXOio5ai6PUUSQJVsltMxXV2K3rOb1+jSEt7jTX3QgcohwJfnf7sFfhQR3rvShH
        DXgtBDv8Ki/KVWtxL4J4/A9GXiQR7P+iCWUsLf4HQfCe8+FE55VmhSyFEfx74TotL+IIWu5/
        S2eshbgM7o8lmAzn4W3w9+8XqQxTeB8NyWhDhhlcAH1/TmSdBXg5jN2ayqZp8AbwpyayvhKv
        gMHEQNZZhKsgOTlAy84TMNQ2rcxwDjbCyPF+Wr7/YohNf66Q+Wl459QRKnM4wOMq+KF1RClX
        2ASXj7VRMi+EG2e7VTLnw/XDzf/xXggMRRl5+ACC7r4LtHyhGPq++iidoE4nrILjp1fL28vh
        u7ufITn4cZhNHaQzCmANHGjWysozcGnymkLmJfDluy1MK2J98+r45lXwzavg+z+sHSk70ZOi
        Q7KaRIlzGOa/7RDKfuQFpb1o8HxFBGE1Yh/TwBvvGbW00CDtsUYQqCk2T+Nb6jVqNbXCnrdF
        p73a6baIUgQZ0k/7Ayp/UY09/cvYXNWcYU1xcTFZy5UYOI5drOFNHqMWmwSXaBZFh+h8OKdQ
        5+R70EuHdd6K8ZUnY+GqV0fdergabby942ag7bdv6BWTT21c1ppTEPn47PBAT0N4++zQjHmX
        cac/OEhvZneNCo/ejhke+bCEvrT9ly2Jl1/riuub3gpfTlbFzkW+7to2c67Ru+P5cNdY6vTW
        V54j0ybFs/zETSla0oc+zQskh1aOmos2/soqpTqBK6CckvAAogp0TfoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvK4/f0+swbaFYhaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuKC6blNSczLLUIn27BK6MVyv7mAs+elQsON/F1MC4xKqLkZND
        QsBEYtXtNqYuRi4OIYHdjBJ7N/9ihUhISky7eJS5i5EDyBaWOHy4GKLmLaNE06xJbCA1wgI2
        Ev+vfgSzRQRCJf50LmcFKWIWaGKV6Pp+nRGi4xWTxOGLfWBT2QS0JPa/uAHWwS+gKHH1x2NG
        EJtXwE5i2dcbzCA2i4CqxLGPh8FqRAUiJA7vmAVVIyhxcuYTFhCbUyBW4uL6g2AzmQXUJf7M
        u8QMYYtL3HoynwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanl
        esWJucWleel6yfm5mxjBUa2luYPx8pL4Q4wCHIxKPLwHwrpjhVgTy4orcw8xSnAwK4nwzpLp
        ihXiTUmsrEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBccHDJ7zb
        0pJsp5xx3HcicGZJx3yrQ0cn/c/uqP0nsHNP+WmHBt6ZxYX9n1fEPmmbs7Xj7PnnBTlfjW05
        ivf1vN8l+tDMYutj8faJl/q9vnbZBRnsrH98IX/37Vt/ovfZ6iauD54hd9j+ddxE9UlhVcuq
        Q+1cn+qc0Gx6vP/2zEeb6z9eDU/56aPEUpyRaKjFXFScCAAA7bW85gIAAA==
X-CMS-MailID: 20190926010727epcas1p13f39ec7c0046e513397b6e3315d40b7d
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
        <40885624-8f11-4eea-d5bf-d6bb50fa44dd@samsung.com>
        <VI1PR04MB7023573BA3D5C5D521DB689CEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 26. 오전 6:18, Leonard Crestez wrote:
> On 25.09.2019 05:11, Chanwoo Choi wrote:
>> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
>>> Register notifiers with the PM QoS framework in order to respond to
>>> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
>>>
>>> No notifiers are added by this patch but PM QoS constraints can be
>>> imposed externally (for example from other devices).
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>   drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>>>   include/linux/devfreq.h   |  5 +++
>>>   2 files changed, 80 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index eee403e70c84..784f3e40536a 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -22,15 +22,18 @@
>>>   #include <linux/platform_device.h>
>>>   #include <linux/list.h>
>>>   #include <linux/printk.h>
>>>   #include <linux/hrtimer.h>
>>>   #include <linux/of.h>
>>> +#include <linux/pm_qos.h>
>>>   #include "governor.h"
>>>   
>>>   #define CREATE_TRACE_POINTS
>>>   #include <trace/events/devfreq.h>
>>>   
>>> +#define HZ_PER_KHZ	1000
>>> +
>>>   static struct class *devfreq_class;
>>>   
>>>   /*
>>>    * devfreq core provides delayed work based load monitoring helper
>>>    * functions. Governors can use these or can implement their own
>>> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>   static void get_freq_range(struct devfreq *devfreq,
>>>   			   unsigned long *min_freq,
>>>   			   unsigned long *max_freq)
>>>   {
>>>   	unsigned long *freq_table = devfreq->profile->freq_table;
>>> +	unsigned long qos_min_freq, qos_max_freq;
>>>   
>>>   	lockdep_assert_held(&devfreq->lock);
>>>   
>>>   	/*
>>>   	 * Init min/max frequency from freq table.
>>> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>>>   	} else {
>>>   		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>>   		*max_freq = freq_table[0];
>>>   	}
>>>   
>>> +	/* constraints from PM QoS */
>>
>> As I commented on patch4,
>> 'constraints' -> 'Constraint' because first verb have to be used
>> as the sigular verbs.
> 
> Already discussed for another patch; I will modify to "Apply constraints 
> from PM QoS" instead.

I agree the new comment with 'Apply constraints ... '.

> 
>> I prefer to use following comments:
>>
>> 	/* Constraint minimum/maximum frequency from PM QoS constraints */
>>
>>> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>> +	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>>> +	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>>> +
>>>   	/* constraints from sysfs */
>>>   	*min_freq = max(*min_freq, devfreq->min_freq);
>>>   	*max_freq = min(*max_freq, devfreq->max_freq);
>>>   
>>>   	/* constraints from OPP interface */
>>> @@ -606,10 +618,49 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>>>   	mutex_unlock(&devfreq->lock);
>>>   
>>>   	return ret;
>>>   }
>>>   
>>> +/**
>>> + * qos_notifier_call() - Common handler for QoS constraints.
>>> + * @devfreq:    the devfreq instance.
>>> + */
>>> +static int qos_notifier_call(struct devfreq *devfreq)
>>> +{
>>> +	int err;
>>> +
>>> +	mutex_lock(&devfreq->lock);
>>> +	err = update_devfreq(devfreq);
>>> +	mutex_unlock(&devfreq->lock);
>>> +	if (err)
>>> +		dev_err(devfreq->dev.parent,
>>> +				"failed to update frequency for PM QoS constraints (%d)\n",
>>
>> Is it not over 80 char?
> 
> Yes but coding style explicitly forbids breaking strings.
> 
>>> +				err);
>>> +
>>> +	return NOTIFY_OK;
>>> +}
>>> +
>>> +/**
>>> + * qos_min_notifier_call() - Callback for QoS min_freq changes.
>>> + * @nb:		Should be devfreq->nb_min
>>> + */
>>> +static int qos_min_notifier_call(struct notifier_block *nb,
>>> +					 unsigned long val, void *ptr)
>>> +{
>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_min));
>>> +}
>>> +
>>> +/**
>>> + * qos_max_notifier_call() - Callback for QoS max_freq changes.
>>> + * @nb:		Should be devfreq->nb_max
>>> + */
>>> +static int qos_max_notifier_call(struct notifier_block *nb,
>>> +					 unsigned long val, void *ptr)
>>> +{
>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_max));
>>> +}
>>> +
>>>   /**
>>>    * devfreq_dev_release() - Callback for struct device to release the device.
>>>    * @dev:	the devfreq device
>>>    *
>>>    * Remove devfreq from the list and release its resources.
>>> @@ -620,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
>>>   
>>>   	mutex_lock(&devfreq_list_lock);
>>>   	list_del(&devfreq->node);
>>>   	mutex_unlock(&devfreq_list_lock);
>>>   
>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>> +			DEV_PM_QOS_MAX_FREQUENCY);
>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>> +			DEV_PM_QOS_MIN_FREQUENCY);
>>> +
>>
>> Just print error with dev_err() without stopping the release step.
>>
>> I prefer to handle the return value if kernel API provides
>> the error code.

How about?

>>
>>>   	if (devfreq->profile->exit)
>>>   		devfreq->profile->exit(devfreq->dev.parent);
>>>   
>>>   	kfree(devfreq->time_in_state);
>>>   	kfree(devfreq->trans_table);
>>> @@ -733,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>   	if (err) {
>>>   		put_device(&devfreq->dev);
>>>   		goto err_out;
>>>   	}
>>>   
>>> +	/*
>>> +	 * Register notifiers for updates to min/max_freq after device is
>>> +	 * initialized (and we can handle notifications) but before the
>>> +	 * governor is started (which should do an initial enforcement of
>>> +	 * constraints).
>>> +	 */
>>
>> My previous comment is not enough why I prefer to remove it. Sorry.
>> Actually, until now, the devfreq_add_device() don't have the detailed
>> comments because the line code is not too long. But, at the present time,
>> devfreq_add_device() is too long. It means that the detailed comment
>> are necessary.
>>
>> So, I'll add the detailed comment for each step of devfreq_add_device()
>> on separate patch to keep the same style. I'll send the patch to you
>> for the review.
> 
> This is very likely to result in merge conflicts, maybe wait for my 
> series to go in first?

I'll send the separate patch after finished the review of these patches.
So, if you agree, please remove this comment on this patch.

You can review the detailed comments on separate patch when I send.

> 
>>> +	devfreq->nb_min.notifier_call = qos_min_notifier_call;
>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>> +				      DEV_PM_QOS_MIN_FREQUENCY);
>>> +	if (err)
>>> +		goto err_devfreq;
>>> +
>>> +	devfreq->nb_max.notifier_call = qos_max_notifier_call;
>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>> +				      DEV_PM_QOS_MAX_FREQUENCY);
>>> +	if (err)
>>> +		goto err_devfreq;
>>> +
>>>   	mutex_lock(&devfreq_list_lock);
>>>   
>>>   	governor = try_then_request_governor(devfreq->governor_name);
>>>   	if (IS_ERR(governor)) {
>>>   		dev_err(dev, "%s: Unable to find governor for the device\n",
>>> @@ -760,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>   
>>>   	return devfreq;
>>>   
>>>   err_init:
>>>   	mutex_unlock(&devfreq_list_lock);
>>> +err_devfreq:
>>>   	devfreq_remove_device(devfreq);
>>>   	return ERR_PTR(err);
>>>   
>>>   err_dev:
>>>   	/*
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index c3cbc15fdf08..dac0dffeabb4 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -134,10 +134,12 @@ struct devfreq_dev_profile {
>>>    * @total_trans:	Number of devfreq transitions
>>>    * @trans_table:	Statistics of devfreq transitions
>>>    * @time_in_state:	Statistics of devfreq states
>>>    * @last_stat_updated:	The last time stat updated
>>>    * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>> + * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>>> + * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>>>    *
>>>    * This structure stores the devfreq information for a give device.
>>>    *
>>>    * Note that when a governor accesses entries in struct devfreq in its
>>>    * functions except for the context of callbacks defined in struct
>>> @@ -176,10 +178,13 @@ struct devfreq {
>>>   	unsigned int *trans_table;
>>>   	unsigned long *time_in_state;
>>>   	unsigned long last_stat_updated;
>>>   
>>>   	struct srcu_notifier_head transition_notifier_list;
>>> +
>>> +	struct notifier_block nb_min;
>>> +	struct notifier_block nb_max;
>>>   };
>>>   
>>>   struct devfreq_freqs {
>>>   	unsigned long old;
>>>   	unsigned long new;
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
