Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4412EC2879
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 23:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfI3VQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 17:16:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58897 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfI3VQ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 17:16:26 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190930211622epoutp03c536c38146ea58cd1374f2b2ff239832~JU_PKIdwk0953109531epoutp03j
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 21:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190930211622epoutp03c536c38146ea58cd1374f2b2ff239832~JU_PKIdwk0953109531epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569878182;
        bh=Y8TesGzN6CSsQhSACPzJXpS6DJNzW02UCdaYTqgBDzY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fnnm2Kx+6BMBFuJDb4hOFOV+APWkT7mvpbnwAMhV3h0Z+wrwRnXGEt2XrnDjqQ2v1
         4LN9yzECBeyCXLjwpjXuV2UlhQ1DFoGRy1hfURsSozs6iGr1Gxli9Vio3jcXir6V7N
         hG8F7bO7o6CTiJClPVa+h0lIarrd2R8lHStbCF8o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190930211621epcas1p316edfd8556b7c1d2984a836563d9d27d~JU_OPZB6C3028730287epcas1p32;
        Mon, 30 Sep 2019 21:16:21 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46hwDz5F83zMqYkY; Mon, 30 Sep
        2019 21:16:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.75.04135.3A0729D5; Tue,  1 Oct 2019 06:16:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190930211619epcas1p12f21744446ae27b280e23b6a062fa57b~JU_LiBT7A3028630286epcas1p1Y;
        Mon, 30 Sep 2019 21:16:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190930211619epsmtrp26ac093d9737260e677356e24e24482a1~JU_LhIjHE0341903419epsmtrp2N;
        Mon, 30 Sep 2019 21:16:19 +0000 (GMT)
X-AuditID: b6c32a36-7fbff70000001027-ef-5d9270a37c7a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.29.03889.2A0729D5; Tue,  1 Oct 2019 06:16:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190930211618epsmtip2e614c8e0098fa826722aa102b0ca40d3~JU_LOuU820415104151epsmtip2K;
        Mon, 30 Sep 2019 21:16:18 +0000 (GMT)
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
Message-ID: <2e6d165e-a7b9-80fa-3d44-eaf8cdc109c0@samsung.com>
Date:   Tue, 1 Oct 2019 06:21:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023FDB02BCC9E4248F05CF9EE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmge7igkmxBm0LlC0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyMxZ+mc5W0BZQMWP6cZYGxgkOXYycHBICJhIz57QxdTFycQgJ
        7GCUODL9NjOE84lRovXTEajMN0aJo+cmM8K07Ds7Dyqxl1Fi/+PpjBDOe0aJc+u3soNUCQvY
        SPy/+pENxBYRCJX48vQSM4jNLNDEKvHpSBmIzSagJbH/xQ2wGn4BRYmrPx4DDeLg4BWwk7h9
        SwAkzCKgInH943MWEFtUIELi04PDrCA2r4CgxMmZT8DinAKxEvevrGKCGC8ucevJfChbXqJ5
        62ywdyQErrFLLL6ylg3iAxeJQ1tXMEPYwhKvjm9hh7ClJD6/2wtVUy2x8uQRNojmDkaJLfsv
        sEIkjCX2L53MBHIos4CmxPpd+hBhRYmdv+cyQizmk3j3tYcVpERCgFeio00IokRZ4vKDu0wQ
        tqTE4vZOtgmMSrOQvDMLyQuzkLwwC2HZAkaWVYxiqQXFuempxYYFRsixvYkRnMi1zHYwLjrn
        c4hRgINRiYd3wsuJsUKsiWXFlbmHGCU4mJVEeMUZJsQK8aYkVlalFuXHF5XmpBYfYjQFhvZE
        ZinR5HxglskriTc0NTI2NrYwMTQzNTRUEud1T2+IFRJITyxJzU5NLUgtgulj4uCUamCMP7aT
        S1+8ddq9pycv/l4559Fh31Ofda+tCmu97CXR/3Zz06Sf1jqB87n4r/AKpkSd0RXUtel2bdt/
        Y+HLFY+PK6yy8qsVWslisqcl+WZ+q+o6kanPlFcGHXEsfnp7w5SMIwYf7iYt0pUKK98VtZll
        lewPw6f1r761z227y3Nm5d2YlIsl8xcWKLEUZyQaajEXFScCAKDftpz6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSvO6igkmxBoufW1ocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyFn6ZzlbQFlAxY/pxlgbGCQ5djJwc
        EgImEvvOzmPqYuTiEBLYzShxf9ErJoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKPDo5mwWkRljA
        RuL/1Y9sILaIQKjEn87lrCBFzAJNrBJd368zQnR8YpaYc76PGaSKTUBLYv+LG2Ad/AKKEld/
        PGYE2cArYCdx+5YASJhFQEXi+sfnYAtEBSIkDu+YxQhi8woISpyc+QQszikQK3H/yiqwQ5kF
        1CX+zLvEDGGLS9x6Mh8qLi/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGCY1pLawfjiRPxhxgFOBiVeHgnvJwYK8SaWFZcmXuIUYKDWUmE
        V5xhQqwQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGRg+N
        yzxuq98tVJSUZMj53rcoaZHinreTHWdunrhKXiyHV+Bw/oc9+c818+5fKTxv013Bxjj10TXH
        EJ5NteeD2Mt5dq1gmbPPeIZk35vOtRMl+Zqr9OPmFl77v37Py6ieA8eMYtlsjF68XvBaZtcv
        W2C6yldwruYReMfcKCcdmjO1smvTSdckJZbijERDLeai4kQATv8IteUCAAA=
X-CMS-MailID: 20190930211619epcas1p12f21744446ae27b280e23b6a062fa57b
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
        <10b7f567-3d07-d4b0-b555-48c03a26461e@samsung.com>
        <VI1PR04MB7023FDB02BCC9E4248F05CF9EE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 30. 오후 9:43, Leonard Crestez wrote:
> On 2019-09-26 4:14 AM, Chanwoo Choi wrote:
>> On 19. 9. 26. 오전 6:18, Leonard Crestez wrote:
>>> On 25.09.2019 05:11, Chanwoo Choi wrote:
>>>> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
>>>>> Register notifiers with the PM QoS framework in order to respond to
>>>>> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
>>>>>
>>>>> No notifiers are added by this patch but PM QoS constraints can be
>>>>> imposed externally (for example from other devices).
>>>>>
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>> ---
>>>>>    drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>>>>>    include/linux/devfreq.h   |  5 +++
>>>>>    2 files changed, 80 insertions(+)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index eee403e70c84..784f3e40536a 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -22,15 +22,18 @@
>>>>>    #include <linux/platform_device.h>
>>>>>    #include <linux/list.h>
>>>>>    #include <linux/printk.h>
>>>>>    #include <linux/hrtimer.h>
>>>>>    #include <linux/of.h>
>>>>> +#include <linux/pm_qos.h>
>>>>>    #include "governor.h"
>>>>>    
>>>>>    #define CREATE_TRACE_POINTS
>>>>>    #include <trace/events/devfreq.h>
>>>>>    
>>>>> +#define HZ_PER_KHZ	1000
>>>>> +
>>>>>    static struct class *devfreq_class;
>>>>>    
>>>>>    /*
>>>>>     * devfreq core provides delayed work based load monitoring helper
>>>>>     * functions. Governors can use these or can implement their own
>>>>> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>>>    static void get_freq_range(struct devfreq *devfreq,
>>>>>    			   unsigned long *min_freq,
>>>>>    			   unsigned long *max_freq)
>>>>>    {
>>>>>    	unsigned long *freq_table = devfreq->profile->freq_table;
>>>>> +	unsigned long qos_min_freq, qos_max_freq;
>>>>>    
>>>>>    	lockdep_assert_held(&devfreq->lock);
>>>>>    
>>>>>    	/*
>>>>>    	 * Init min/max frequency from freq table.
>>>>> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>>>>>    	} else {
>>>>>    		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>>>>    		*max_freq = freq_table[0];
>>>>>    	}
>>>>>    
>>>>> +	/* constraints from PM QoS */
>>>>
>>>> As I commented on patch4,
>>>> 'constraints' -> 'Constraint' because first verb have to be used
>>>> as the sigular verbs.
>>>
>>> Already discussed for another patch; I will modify to "Apply constraints
>>> from PM QoS" instead.
>>>
>>>> I prefer to use following comments:
>>>>
>>>> 	/* Constraint minimum/maximum frequency from PM QoS constraints */
>>>>
>>>>> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>> +	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>>>>> +	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>>>>> +
>>>>>    	/* constraints from sysfs */
>>>>>    	*min_freq = max(*min_freq, devfreq->min_freq);
>>>>>    	*max_freq = min(*max_freq, devfreq->max_freq);
>>>>>    
>>>>>    	/* constraints from OPP interface */
>>>>> @@ -606,10 +618,49 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>>>>>    	mutex_unlock(&devfreq->lock);
>>>>>    
>>>>>    	return ret;
>>>>>    }
>>>>>    
>>>>> +/**
>>>>> + * qos_notifier_call() - Common handler for QoS constraints.
>>>>> + * @devfreq:    the devfreq instance.
>>>>> + */
>>>>> +static int qos_notifier_call(struct devfreq *devfreq)
>>>>> +{
>>>>> +	int err;
>>>>> +
>>>>> +	mutex_lock(&devfreq->lock);
>>>>> +	err = update_devfreq(devfreq);
>>>>> +	mutex_unlock(&devfreq->lock);
>>>>> +	if (err)
>>>>> +		dev_err(devfreq->dev.parent,
>>>>> +				"failed to update frequency for PM QoS constraints (%d)\n",
>>>>
>>>> Is it not over 80 char?
>>>
>>> Yes but coding style explicitly forbids breaking strings.
>>
>> I want to make it within 80 char. How about following comment?
>>
>> 		dev_err(devfreq->dev.parent,
>> 			"failed to update frequency from PM QoS (%d)\n",
> 
> Yes, shrinking the comment and aligning with open parenthesis can keep 
> it under 80 chars. Maybe it could be shrunk further to
> 
>      "failed update for PM QoS"

I think that we need to specify what do update something like 'frequency'.
So, it is more proper as following:

	"failed to update frequency from PM QoS\n",

> 
>>>>> +				err);
>>>>> +
>>>>> +	return NOTIFY_OK;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * qos_min_notifier_call() - Callback for QoS min_freq changes.
>>>>> + * @nb:		Should be devfreq->nb_min
>>>>> + */
>>>>> +static int qos_min_notifier_call(struct notifier_block *nb,
>>>>> +					 unsigned long val, void *ptr)
>>>>> +{
>>>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_min));
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * qos_max_notifier_call() - Callback for QoS max_freq changes.
>>>>> + * @nb:		Should be devfreq->nb_max
>>>>> + */
>>>>> +static int qos_max_notifier_call(struct notifier_block *nb,
>>>>> +					 unsigned long val, void *ptr)
>>>>> +{
>>>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_max));
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * devfreq_dev_release() - Callback for struct device to release the device.
>>>>>     * @dev:	the devfreq device
>>>>>     *
>>>>>     * Remove devfreq from the list and release its resources.
>>>>> @@ -620,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
>>>>>    
>>>>>    	mutex_lock(&devfreq_list_lock);
>>>>>    	list_del(&devfreq->node);
>>>>>    	mutex_unlock(&devfreq_list_lock);
>>>>>    
>>>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>>>> +			DEV_PM_QOS_MAX_FREQUENCY);
>>>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>>>> +			DEV_PM_QOS_MIN_FREQUENCY);
>>>>> +
>>>>
>>>> Just print error with dev_err() without stopping the release step.
>>>>
>>>> I prefer to handle the return value if kernel API provides
>>>> the error code.
>>>>
>>>>>    	if (devfreq->profile->exit)
>>>>>    		devfreq->profile->exit(devfreq->dev.parent);
>>>>>    
>>>>>    	kfree(devfreq->time_in_state);
>>>>>    	kfree(devfreq->trans_table);
>>>>> @@ -733,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>    	if (err) {
>>>>>    		put_device(&devfreq->dev);
>>>>>    		goto err_out;
>>>>>    	}
>>>>>    
>>>>> +	/*
>>>>> +	 * Register notifiers for updates to min/max_freq after device is
>>>>> +	 * initialized (and we can handle notifications) but before the
>>>>> +	 * governor is started (which should do an initial enforcement of
>>>>> +	 * constraints).
>>>>> +	 */
>>>>
>>>> My previous comment is not enough why I prefer to remove it. Sorry.
>>>> Actually, until now, the devfreq_add_device() don't have the detailed
>>>> comments because the line code is not too long. But, at the present time,
>>>> devfreq_add_device() is too long. It means that the detailed comment
>>>> are necessary.
>>>>
>>>> So, I'll add the detailed comment for each step of devfreq_add_device()
>>>> on separate patch to keep the same style. I'll send the patch to you
>>>> for the review.
>>>
>>> This is very likely to result in merge conflicts, maybe wait for my
>>> series to go in first?
>>>
>>>>> +	devfreq->nb_min.notifier_call = qos_min_notifier_call;
>>>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>>>> +				      DEV_PM_QOS_MIN_FREQUENCY);
>>>>> +	if (err)
>>>>> +		goto err_devfreq;
>>>>> +
>>>>> +	devfreq->nb_max.notifier_call = qos_max_notifier_call;
>>>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>>>> +				      DEV_PM_QOS_MAX_FREQUENCY);
>>>>> +	if (err)
>>>>> +		goto err_devfreq;
>>>>> +
>>>>>    	mutex_lock(&devfreq_list_lock);
>>>>>    
>>>>>    	governor = try_then_request_governor(devfreq->governor_name);
>>>>>    	if (IS_ERR(governor)) {
>>>>>    		dev_err(dev, "%s: Unable to find governor for the device\n",
>>>>> @@ -760,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>    
>>>>>    	return devfreq;
>>>>>    
>>>>>    err_init:
>>>>>    	mutex_unlock(&devfreq_list_lock);
>>>>> +err_devfreq:
>>>>>    	devfreq_remove_device(devfreq);
>>>>>    	return ERR_PTR(err);
>>>>>    
>>>>>    err_dev:
>>>>>    	/*
>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>> index c3cbc15fdf08..dac0dffeabb4 100644
>>>>> --- a/include/linux/devfreq.h
>>>>> +++ b/include/linux/devfreq.h
>>>>> @@ -134,10 +134,12 @@ struct devfreq_dev_profile {
>>>>>     * @total_trans:	Number of devfreq transitions
>>>>>     * @trans_table:	Statistics of devfreq transitions
>>>>>     * @time_in_state:	Statistics of devfreq states
>>>>>     * @last_stat_updated:	The last time stat updated
>>>>>     * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>>>> + * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>>>>> + * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>>>>>     *
>>>>>     * This structure stores the devfreq information for a give device.
>>>>>     *
>>>>>     * Note that when a governor accesses entries in struct devfreq in its
>>>>>     * functions except for the context of callbacks defined in struct
>>>>> @@ -176,10 +178,13 @@ struct devfreq {
>>>>>    	unsigned int *trans_table;
>>>>>    	unsigned long *time_in_state;
>>>>>    	unsigned long last_stat_updated;
>>>>>    
>>>>>    	struct srcu_notifier_head transition_notifier_list;
>>>>> +
>>>>> +	struct notifier_block nb_min;
>>>>> +	struct notifier_block nb_max;
>>>>>    };
>>>>>    
>>>>>    struct devfreq_freqs {
>>>>>    	unsigned long old;
>>>>>    	unsigned long new;
>>>>>
>>>>
>>>>
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
