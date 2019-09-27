Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462F2BFCC9
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 03:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfI0Bp0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 21:45:26 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36872 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfI0Bp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 21:45:26 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190927014522epoutp047502f6e6fea1a507ee83af64fe58e799~IKD9RthAo2370923709epoutp04x
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 01:45:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190927014522epoutp047502f6e6fea1a507ee83af64fe58e799~IKD9RthAo2370923709epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569548722;
        bh=hh9S73+ab0l4+mtLtEUuDDEwoDwH0mrTxk0MvLdMgzE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=O+RD0kyWDxX9HQ/wlYGxCbPc2oQPHyLYJEmPzHajgQqPSdqd152O8JFLjsMzOlau1
         4EIWzSkYsnCL9+JQrMqzAZEblzRTbYR3e28EcSVhNFcnc5JFuRbLKoeV9RLYPCebQQ
         tz1AbGJFs1WU5cYv6K3KvdSAKb8bviKJWBFu9u6Y=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190927014521epcas1p1c87413de7db0b1e8705a3210b81c0db2~IKD8vQvKX0269402694epcas1p1y;
        Fri, 27 Sep 2019 01:45:21 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46fZPC21ytzMqYkW; Fri, 27 Sep
        2019 01:45:19 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.9C.04135.CA96D8D5; Fri, 27 Sep 2019 10:45:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190927014515epcas1p4f4f5fb61b83b1740cf08e46e177b65e1~IKD3H6N1L0662106621epcas1p4-;
        Fri, 27 Sep 2019 01:45:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190927014515epsmtrp15aa5cea0c64426c776c93e5a950454dc~IKD3G9msd1559515595epsmtrp1s;
        Fri, 27 Sep 2019 01:45:15 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-6d-5d8d69acbb5f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.9D.03889.BA96D8D5; Fri, 27 Sep 2019 10:45:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190927014515epsmtip2af696beccc4cf01fa26080ab908b1a9b~IKD2ydnCA0559805598epsmtip2u;
        Fri, 27 Sep 2019 01:45:15 +0000 (GMT)
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
Message-ID: <2c0f7b6f-97df-9548-dde5-dda95f6a447c@samsung.com>
Date:   Fri, 27 Sep 2019 10:49:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB702397D04A0F2FFE8111E341EE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmnu6azN5Yg3cbjCwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyM46edyvYElvxtHkpYwPjH68uRk4OCQETia6jbewgtpDADkaJ
        9v8OXYxcQPYnRokFm/+zQjjfGCXONO5ihOmYs3cSE0RiL6PE2qPtLBDOe0aJe9OfMYNUCQvY
        SPy/+pENxBYRCJX48vQSWJxZoIlV4tORMhCbTUBLYv+LG2A1/AKKEld/PAbbwCtgJ3F7ywsW
        EJtFQFWibdd8MFtUIELi04PDrBA1ghInZz4BinNwcArESny6GA0xXlzi1pP5TBC2vETz1tnM
        ILdJCFxil/iw+CoLxAcuEv/ntbJC2MISr45vYYewpSRe9rdB2dUSK08eYYNo7mCU2LL/AlSD
        scT+pZOZQBYzC2hKrN+lDxFWlNj5ey4jxGI+iXdfe1hBSiQEeCU62oQgSpQlLj+4ywRhS0os
        bu9km8CoNAvJN7OQvDALyQuzEJYtYGRZxSiWWlCcm55abFhghBzXmxjBSVzLbAfjonM+hxgF
        OBiVeHhnrOqJFWJNLCuuzD3EKMHBrCTC6xsJFOJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5
        wAyTVxJvaGpkbGxsYWJoZmpoqCTO657eECskkJ5YkpqdmlqQWgTTx8TBKdXAaLGg18rl9btD
        5vJJCSoHpr98/MF64tHNTboijHead8v3XBBcX9O+6vRp1ld9/odsfmUFL0uPks7KW2y3xmEF
        259/OQqdCiXrvFc/1c5RTT+r5nnymNhDlSohLS57obc93Ran0zNrTIomCxnPerhO4uH/qXXF
        BfwXfcr4E7onRPo0HMiafy5NiaU4I9FQi7moOBEAt3R26/gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSvO7qzN5Yg1XtRhaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuKC6blNSczLLUIn27BK6Mo+fdCrbEVjxtXsrYwPjHq4uRk0NC
        wERizt5JTF2MXBxCArsZJY5s+skOkZCUmHbxKHMXIweQLSxx+HAxSFhI4C2jxLb7tiC2sICN
        xP+rH9lAbBGBUIk/nctZQeYwCzSxSnR9v84IMfQTs8S+bRPAhrIJaEnsf3EDrINfQFHi6o/H
        jCA2r4CdxO0tL1hAbBYBVYm2XfPBbFGBCInDO2ZB1QhKnJz5hAXkIE6BWIlPF6NBwswC6hJ/
        5l1ihrDFJW49mc8EYctLNG+dzTyBUXgWku5ZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCo7zU
        cr3ixNzi0rx0veT83E2M4HjW0trBeOJE/CFGAQ5GJR7eGat6YoVYE8uKK3MPMUpwMCuJ8PpG
        AoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUwrpL9Jn7q
        Tmlwc5THyur69K0TpL4JVVntuyPsxHXojcIfzZ3Fm9/wt3D8i8pdd8h/BxtrsuuhvdefxBtb
        5r463P9q9l5dkYjl3rxmDxk5vs588Pi2aayAeeSizx95P0Tr7XURnVadx6h9zIe3s9fRMZtf
        clbcXP6v1pOm3ji23DXg4wvv7D2rlViKMxINtZiLihMB4RsGT+MCAAA=
X-CMS-MailID: 20190927014515epcas1p4f4f5fb61b83b1740cf08e46e177b65e1
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
        <5f12931b-92f8-15d8-8498-f02a7c2e999f@samsung.com>
        <VI1PR04MB702397D04A0F2FFE8111E341EE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 26. 오후 10:43, Leonard Crestez wrote:
> On 2019-09-26 4:07 AM, Chanwoo Choi wrote:
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
>>
>> I agree the new comment with 'Apply constraints ... '.
>>
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
>>>
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
>>
>> How about?
> 
> Modified to dev_warn. This also applies to PATCH 6 so I replied there.
> 
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
>>
>> I'll send the separate patch after finished the review of these patches.
>> So, if you agree, please remove this comment on this patch.
>>
>> You can review the detailed comments on separate patch when I send.
> This patch already contains comments and they explain the code being 
> added. Doesn't it make more sense for comments and code to go in together?
> 
> I think the comment is a resonable explanation as to why notifiers are 
> registered at that specific step in the initialization sequence.

If you add this comment on this patch, OK. just I have some comments.

	/*
	 * Register notifiers for updates to min/max_freq after device is
	 * initialized (and we can handle notifications) but before the

I think that 'device is initialized' is not needed.
It is always true, it don't need to add the additional comments.
because dev_pm_qos_add_notifier() must need the 'devfreq->dev'.
The this code prove the call sequence between them.

About 'us', don't use 'we'. The subject is 'devfreq' or other device instead of us.

	 * governor is started (which should do an initial enforcement of
	 * constraints).
 	 */

Actually, it doesn't matter the initialization step between governor
and PM_QOS registration.

If start governor and then register PM_QOS,
the governor can decide the new frequency. And then PM_QOS request
the new constraints for min/max frequency. On request time of PM_QOS,
devfreq can detect this time and then apply the constraints from PM_QOS.

The user of devfreq's PM_QOS must need the phandle or device instance
of devfreq deivce. It means that user of devfreq's PM_QOS can request
the any constraints of PM_QOS_MIN/MAX through PM_QOS interface.

So, it doesn't need to add the following comments
because following comment is not always mandatory.
" governor is started (which should do an initial enforcement of constraints)."

Also, you don't need to use parentheses on comments.

Actually, I think that following comments are enough.

	/* Register PM QoS notifiers for updating to min/max freq */


> 
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


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
