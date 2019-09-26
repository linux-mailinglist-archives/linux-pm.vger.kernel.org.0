Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147B7BE9F5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfIZBOm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:14:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:21771 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfIZBOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:14:41 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190926011438epoutp01a032568cdd5cb818480542f8e58b406d~H1-1hOA090104501045epoutp01C
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:14:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190926011438epoutp01a032568cdd5cb818480542f8e58b406d~H1-1hOA090104501045epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569460478;
        bh=AesaqjDo0YbWP27vWCIaz9cMDJ9+CQh/g3Zywou/rt4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EfyEfTVTcD9uXEC/6g/Xh/ISBweQ1JhRHBraPEtQoQlMsb6rxiBRWpsW4FDdGucbO
         NyuEAy1NEaT3Q5h7h36itf9/6yI1KIYMq5QQb7cS9KyAH/IofwRZpPYVZSYtHpmJHZ
         3vdpHn3vCcYYXp0jpHU/Y83081I7rIcJL4xU7cg8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190926011437epcas1p3689c1103b3624d494cfd8f1ec1540295~H1-0uOr8G2749427494epcas1p3g;
        Thu, 26 Sep 2019 01:14:37 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46dxmB6w7lzMqYkX; Thu, 26 Sep
        2019 01:14:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.6F.04068.AF01C8D5; Thu, 26 Sep 2019 10:14:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190926011434epcas1p4fad14708395e5735db9d9ee09f7b13d0~H1-xiIfbM1342313423epcas1p4L;
        Thu, 26 Sep 2019 01:14:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190926011434epsmtrp16dc8cd010679c943b67f56486c17f53f~H1-xgw6cX1961419614epsmtrp1X;
        Thu, 26 Sep 2019 01:14:34 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-a5-5d8c10fac2f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.CD.04081.9F01C8D5; Thu, 26 Sep 2019 10:14:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926011433epsmtip21b64d1f76168dd7fa8ab3c1188222f4f~H1-xMX7EG2820028200epsmtip2u;
        Thu, 26 Sep 2019 01:14:33 +0000 (GMT)
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
Message-ID: <10b7f567-3d07-d4b0-b555-48c03a26461e@samsung.com>
Date:   Thu, 26 Sep 2019 10:19:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023573BA3D5C5D521DB689CEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmnu4vgZ5Yg19zzS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyM9bfuMtU8Mq9Yu7HQywNjPstuxg5OSQETCRu3zrM3MXIxSEk
        sINRYv2SaWwQzidGiZZt1xlBqoQEvjFK7F3EBdOxZUE7VNFeRomXiw+yQjjvGSUO/LzMClIl
        LGAj8f/qRzYQW0QgVOLL00vMIDazQBOrxKcjZSA2m4CWxP4XN8Bq+AUUJa7+eAy2jVfATmLZ
        3V9ANgcHi4CqxNOTUSBhUYEIiU8PDrNClAhKnJz5hAXE5hSIlbi4/iArxHhxiVtP5jNB2PIS
        zVtng70mIXCNXeLB8qOsIDMlBFwk1j3Th3hGWOLV8S3sELaUxMv+Nii7WmLlySNsEL0djBJb
        9l9ghUgYS+xfOpkJZA6zgKbE+l1QcxQldv6eywixl0/i3dceqFW8Eh1tQhAlyhKXH9xlgrAl
        JRa3d7JNYFSaheSbWUg+mIXkg1kIyxYwsqxiFEstKM5NTy02LDBFjutNjOAkrmW5g/HYOZ9D
        jAIcjEo8vBKR3bFCrIllxZW5hxglOJiVRHhnyXTFCvGmJFZWpRblxxeV5qQWH2I0BYb1RGYp
        0eR8YIbJK4k3NDUyNja2MDE0MzU0VBLn9UhviBUSSE8sSc1OTS1ILYLpY+LglGpg1A00cPOT
        cym2SD40V2jy4w+1n74EGr5OWf7f8/Hf72a7Fl0RK/jxbY78tm8MT2WVGipCao0XdlgUM7yc
        3eu2t/uA1vWb1jlS+94uZhKasXnNciXp6+0qMhJ3j0gmXS56x7Nh23HWPe0aAYme55M5P/K/
        e8hRmK6ju3s252fm0+KBloyJD+dMU2Ipzkg01GIuKk4EABjinqH4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSvO5PgZ5YgyknrS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUVw2Kak5mWWpRfp2CVwZ62/cZSp45V4x9+MhlgbG/ZZdjJwc
        EgImElsWtLN1MXJxCAnsZpR4+mcyI0RCUmLaxaPMXYwcQLawxOHDxRA1bxklpt/dxAxSIyxg
        I/H/6kc2EFtEIFTiT+dyVpAiZoEmVomu79cZITpeMUkcvtjHClLFJqAlsf/FDbAOfgFFias/
        HoNt4xWwk1h29xcjyDYWAVWJpyejQMKiAhESh3fMgioRlDg58wkLiM0pECtxcf1BsJHMAuoS
        f+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOCY1tLcwXh5SfwhRgEORiUe3gNh3bFCrIllxZW5hxglOJiVRHhn
        yXTFCvGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cCooPCw
        1Oxxlo3Ty7g9n1SXvJt+VeFn7TPXHUrvDv86NkH4OZ9EGUek8Hdr21nTb7ocduDQL7poV6Gw
        ospC9P931dtHL0qxOWyqehS+KMbm2Z2Qi2oiu+ceTnygLWN1kn2JHmtWs1LPiVlrZnm67Dtk
        Vb/62v9tfBNn7DkQWFq/sDC1zThu+fXFSizFGYmGWsxFxYkA/TvVgeUCAAA=
X-CMS-MailID: 20190926011434epcas1p4fad14708395e5735db9d9ee09f7b13d0
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

I want to make it within 80 char. How about following comment?

		dev_err(devfreq->dev.parent,
			"failed to update frequency from PM QoS (%d)\n",

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
