Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29902C28E9
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 23:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfI3Vh5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 17:37:57 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31627 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3Vh5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 17:37:57 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190930213753epoutp02b9fb9737a910d8cba9d3e771f913b259~JVRA7ZLjV3209932099epoutp02R
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 21:37:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190930213753epoutp02b9fb9737a910d8cba9d3e771f913b259~JVRA7ZLjV3209932099epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569879473;
        bh=xctg9QCHHtSYU4rAlmiDiZZ1n/FEDhJYyLv9c4xeb78=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NRz2kc+/wQnY5iPmcXViK4sNEwstgkohRFRKNPBF4zgy2wvIU0n0TANTjYKxJUOWP
         Ze/8AqP5yUwRfcwSRH7cI6k29x8cZrnMGaHw4nXb0G7roXDH3Dhjw9nTfG06VGKZ4p
         +AzzOpKEF/QTRSHNXyk4LNXy+wgBqTndNqBHqPmQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190930213752epcas1p495dbd28c6c7ce1cc3201783b10db98f9~JVQ-wtLau0336703367epcas1p4W;
        Mon, 30 Sep 2019 21:37:52 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46hwjn6WmVzMqYkV; Mon, 30 Sep
        2019 21:37:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.34.04068.DA5729D5; Tue,  1 Oct 2019 06:37:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190930213749epcas1p155d5fa97aa022b5c6449052cb5c606f9~JVQ9RpSQD1948919489epcas1p1G;
        Mon, 30 Sep 2019 21:37:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190930213749epsmtrp1753cd7af1ffce13052a724b504f2bbd4~JVQ9Q4QN_0609306093epsmtrp1r;
        Mon, 30 Sep 2019 21:37:49 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-56-5d9275ad53f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.E8.04081.DA5729D5; Tue,  1 Oct 2019 06:37:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190930213749epsmtip17d3ab96ce86609733702bf32aa146ca3~JVQ87t72u1777817778epsmtip1B;
        Mon, 30 Sep 2019 21:37:49 +0000 (GMT)
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
Message-ID: <bb942624-f6ad-56c8-5a7c-32ed77d1f789@samsung.com>
Date:   Tue, 1 Oct 2019 06:42:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023F003BBE96894FEB0C7AFEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmru7a0kmxBrNWmlocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4AeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZzx+fZylYGtBxbl/ixkbGLdFdTFyckgImEh8uP6TFcQWEtjB
        KDH7IHsXIxeQ/YlRYsvOB2wQzjdGibZJuxlhOlZPXckM0bGXUeLbEmeIoveMEtfnnwIrEhaw
        kfh/9SMbiC0iECrx5eklsAZmgSZWiU9HykBsNgEtif0vboDV8AsoSlz98Riol4ODV8BOYnaX
        PEiYRUBFYueZDWDXiQpESHx6cBjM5hUQlDg58wkLiM0pECuxtXsFE8R4cYlbT+ZD2fISzVtn
        M4PcJiFwjV3i3ZOVLBAPuEhs+P6DHcIWlnh1fAuULSXxsr8Nyq6WWHnyCBtEcwcwKPZfYIVI
        GEvsXzqZCeRQZgFNifW79CHCihI7f89lhFjMJ/Huaw8rSImEAK9ER5sQRImyxOUHd5kgbEmJ
        xe2dbBMYlWYheWcWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LTJHjehMjOIlrWe5gPHbO5xCj
        AAejEg/vhJcTY4VYE8uKK3MPMUpwMCuJ8IozTIgV4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKi
        yfnADJNXEm9oamRsbGxhYmhmamioJM7rkd4QKySQnliSmp2aWpBaBNPHxMEp1cDo+OjcN9MV
        upvXJJ5xPnONWak46sMX3wfcpnNb+uR13lnsuT6pp/TaAt8upXPbDbYJqt2vc53KHn8mYcKf
        9hmJ3AdPOijcm7G9pORs5pqMo6dPOrvsCHo2qVT9v5XijAU2Ni4xWiWf1f742a+4Gbl6nUGJ
        48HD0pwzlZufv+dafvQ8t+c1Lt4YJZbijERDLeai4kQAwszWt/gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSnO7a0kmxBvvPClocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyHr8+zlKwtaDi3L/FjA2M26K6GDk5
        JARMJFZPXcncxcjFISSwm1Hi98Y+FoiEpMS0i0eBEhxAtrDE4cPFEDVvGSXuL+9hA6kRFrCR
        +H/1I5gtIhAq8adzOStIEbNAE6tE1/frjBAdv1gkrt07BDaVTUBLYv+LG2Ad/AKKEld/PGYE
        2cArYCcxu0seJMwioCKx88wGVhBbVCBC4vCOWYwgNq+AoMTJmU/AxnAKxEps7V7BBGIzC6hL
        /Jl3iRnCFpe49WQ+VFxeonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOal
        lusVJ+YWl+al6yXn525iBMe0luYOxstL4g8xCnAwKvHwTng5MVaINbGsuDL3EKMEB7OSCK84
        w4RYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhgn67ac
        +P6i5t6htqc3fjJ7Zi+fY8qS/fSW1IxZ9sv61+adP7hWsSTOfdnB4LaTPe5ntN46pHHOZ+vK
        uBd6f8XfmLn+JqWWkec3z5XcxNx5Q3fR6gv2K95kvrNiWPtUZ//7mEyed3EHv1QzhYa6cN5P
        PPD6hKFeFOcNTZssBcmIo7kxEWv2zIpRYinOSDTUYi4qTgQAmY0MLOUCAAA=
X-CMS-MailID: 20190930213749epcas1p155d5fa97aa022b5c6449052cb5c606f9
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
        <2c0f7b6f-97df-9548-dde5-dda95f6a447c@samsung.com>
        <VI1PR04MB7023F003BBE96894FEB0C7AFEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 30. 오후 10:16, Leonard Crestez wrote:
> On 2019-09-27 4:45 AM, Chanwoo Choi wrote:
>> On 19. 9. 26. 오후 10:43, Leonard Crestez wrote:
>>> On 2019-09-26 4:07 AM, Chanwoo Choi wrote:
>>>> On 19. 9. 26. 오전 6:18, Leonard Crestez wrote:
>>>>> On 25.09.2019 05:11, Chanwoo Choi wrote:
>>>>>> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
>>>>>>> Register notifiers with the PM QoS framework in order to respond to
>>>>>>> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
>>>>>>>
>>>>>>> No notifiers are added by this patch but PM QoS constraints can be
>>>>>>> imposed externally (for example from other devices).
>>>>>>>
>>>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>>>> ---
>>>>>>>     drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>>>>>>>     include/linux/devfreq.h   |  5 +++
>>>>>>>     2 files changed, 80 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>> index eee403e70c84..784f3e40536a 100644
>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>> @@ -22,15 +22,18 @@
>>>>>>>     #include <linux/platform_device.h>
>>>>>>>     #include <linux/list.h>
>>>>>>>     #include <linux/printk.h>
>>>>>>>     #include <linux/hrtimer.h>
>>>>>>>     #include <linux/of.h>
>>>>>>> +#include <linux/pm_qos.h>
>>>>>>>     #include "governor.h"
>>>>>>>     
>>>>>>>     #define CREATE_TRACE_POINTS
>>>>>>>     #include <trace/events/devfreq.h>
>>>>>>>     
>>>>>>> +#define HZ_PER_KHZ	1000
>>>>>>> +
>>>>>>>     static struct class *devfreq_class;
>>>>>>>     
>>>>>>>     /*
>>>>>>>      * devfreq core provides delayed work based load monitoring helper
>>>>>>>      * functions. Governors can use these or can implement their own
>>>>>>> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>>>>>     static void get_freq_range(struct devfreq *devfreq,
>>>>>>>     			   unsigned long *min_freq,
>>>>>>>     			   unsigned long *max_freq)
>>>>>>>     {
>>>>>>>     	unsigned long *freq_table = devfreq->profile->freq_table;
>>>>>>> +	unsigned long qos_min_freq, qos_max_freq;
>>>>>>>     
>>>>>>>     	lockdep_assert_held(&devfreq->lock);
>>>>>>>     
>>>>>>>     	/*
>>>>>>>     	 * Init min/max frequency from freq table.
>>>>>>> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>>>>>>>     	} else {
>>>>>>>     		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>>>>>>     		*max_freq = freq_table[0];
>>>>>>>     	}
>>>>>>>     
>>>>>>> +	/* constraints from PM QoS */
>>>>>>
>>>>>> As I commented on patch4,
>>>>>> 'constraints' -> 'Constraint' because first verb have to be used
>>>>>> as the sigular verbs.
>>>>>
>>>>> Already discussed for another patch; I will modify to "Apply constraints
>>>>> from PM QoS" instead.
>>>>
>>>> I agree the new comment with 'Apply constraints ... '.
>>>>
>>>>>
>>>>>> I prefer to use following comments:
>>>>>>
>>>>>> 	/* Constraint minimum/maximum frequency from PM QoS constraints */
>>>>>>
>>>>>>> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>> +	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>>>>>>> +	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>>>>>>> +
>>>>>>>     	/* constraints from sysfs */
>>>>>>>     	*min_freq = max(*min_freq, devfreq->min_freq);
>>>>>>>     	*max_freq = min(*max_freq, devfreq->max_freq);
>>>>>>>     
>>>>>>>     	/* constraints from OPP interface */
>>>>>>> @@ -606,10 +618,49 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>>>>>>>     	mutex_unlock(&devfreq->lock);
>>>>>>>     
>>>>>>>     	return ret;
>>>>>>>     }
>>>>>>>     
>>>>>>> +/**
>>>>>>> + * qos_notifier_call() - Common handler for QoS constraints.
>>>>>>> + * @devfreq:    the devfreq instance.
>>>>>>> + */
>>>>>>> +static int qos_notifier_call(struct devfreq *devfreq)
>>>>>>> +{
>>>>>>> +	int err;
>>>>>>> +
>>>>>>> +	mutex_lock(&devfreq->lock);
>>>>>>> +	err = update_devfreq(devfreq);
>>>>>>> +	mutex_unlock(&devfreq->lock);
>>>>>>> +	if (err)
>>>>>>> +		dev_err(devfreq->dev.parent,
>>>>>>> +				"failed to update frequency for PM QoS constraints (%d)\n",
>>>>>>
>>>>>> Is it not over 80 char?
>>>>>
>>>>> Yes but coding style explicitly forbids breaking strings.
>>>>>
>>>>>>> +				err);
>>>>>>> +
>>>>>>> +	return NOTIFY_OK;
>>>>>>> +}
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * qos_min_notifier_call() - Callback for QoS min_freq changes.
>>>>>>> + * @nb:		Should be devfreq->nb_min
>>>>>>> + */
>>>>>>> +static int qos_min_notifier_call(struct notifier_block *nb,
>>>>>>> +					 unsigned long val, void *ptr)
>>>>>>> +{
>>>>>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_min));
>>>>>>> +}
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * qos_max_notifier_call() - Callback for QoS max_freq changes.
>>>>>>> + * @nb:		Should be devfreq->nb_max
>>>>>>> + */
>>>>>>> +static int qos_max_notifier_call(struct notifier_block *nb,
>>>>>>> +					 unsigned long val, void *ptr)
>>>>>>> +{
>>>>>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_max));
>>>>>>> +}
>>>>>>> +
>>>>>>>     /**
>>>>>>>      * devfreq_dev_release() - Callback for struct device to release the device.
>>>>>>>      * @dev:	the devfreq device
>>>>>>>      *
>>>>>>>      * Remove devfreq from the list and release its resources.
>>>>>>> @@ -620,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
>>>>>>>     
>>>>>>>     	mutex_lock(&devfreq_list_lock);
>>>>>>>     	list_del(&devfreq->node);
>>>>>>>     	mutex_unlock(&devfreq_list_lock);
>>>>>>>     
>>>>>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>>>>>> +			DEV_PM_QOS_MAX_FREQUENCY);
>>>>>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>>>>>> +			DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>> +
>>>>>>
>>>>>> Just print error with dev_err() without stopping the release step.
>>>>>>
>>>>>> I prefer to handle the return value if kernel API provides
>>>>>> the error code.
>>>>
>>>> How about?
>>>
>>> Modified to dev_warn. This also applies to PATCH 6 so I replied there.
>>>
>>>>>>>     	if (devfreq->profile->exit)
>>>>>>>     		devfreq->profile->exit(devfreq->dev.parent);
>>>>>>>     
>>>>>>>     	kfree(devfreq->time_in_state);
>>>>>>>     	kfree(devfreq->trans_table);
>>>>>>> @@ -733,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>>     	if (err) {
>>>>>>>     		put_device(&devfreq->dev);
>>>>>>>     		goto err_out;
>>>>>>>     	}
>>>>>>>     
>>>>>>> +	/*
>>>>>>> +	 * Register notifiers for updates to min/max_freq after device is
>>>>>>> +	 * initialized (and we can handle notifications) but before the
>>>>>>> +	 * governor is started (which should do an initial enforcement of
>>>>>>> +	 * constraints).
>>>>>>> +	 */
>>>>>>
>>>>>> My previous comment is not enough why I prefer to remove it. Sorry.
>>>>>> Actually, until now, the devfreq_add_device() don't have the detailed
>>>>>> comments because the line code is not too long. But, at the present time,
>>>>>> devfreq_add_device() is too long. It means that the detailed comment
>>>>>> are necessary.
>>>>>>
>>>>>> So, I'll add the detailed comment for each step of devfreq_add_device()
>>>>>> on separate patch to keep the same style. I'll send the patch to you
>>>>>> for the review.
>>>>>
>>>>> This is very likely to result in merge conflicts, maybe wait for my
>>>>> series to go in first?
>>>>
>>>> I'll send the separate patch after finished the review of these patches.
>>>> So, if you agree, please remove this comment on this patch.
>>>>
>>>> You can review the detailed comments on separate patch when I send.
>>> This patch already contains comments and they explain the code being
>>> added. Doesn't it make more sense for comments and code to go in together?
>>>
>>> I think the comment is a resonable explanation as to why notifiers are
>>> registered at that specific step in the initialization sequence.
>>
>> If you add this comment on this patch, OK. just I have some comments.
>>
>> 	/*
>> 	 * Register notifiers for updates to min/max_freq after device is
>> 	 * initialized (and we can handle notifications) but before the
>>
>> I think that 'device is initialized' is not needed.
>> It is always true, it don't need to add the additional comments.
>> because dev_pm_qos_add_notifier() must need the 'devfreq->dev'.
>> The this code prove the call sequence between them.
> 
> In theory if a notifier is registered too soon then it could crash on a 
> NULL pointer. But looking at the code it first checks that "governor != 
> NULL) so it would be harmless.
> 
>>
>> About 'us', don't use 'we'. The subject is 'devfreq' or other device instead of us.
>>
>> 	 * governor is started (which should do an initial enforcement of
>> 	 * constraints).
>>   	 */
>>
>> Actually, it doesn't matter the initialization step between governor
>> and PM_QOS registration.
> 
> In theory PM QoS constraints could be modified between governor startup 
> and notifier registration and that update would be lost (until the next 
> one).

Don't lose the any of PM QoS request. User can request the any frequency
through PMQoS at the any time and then devfreq consider the constraints
from PM QoS.

Also, after finished the registration of devfreq device,
the user (other device driver required the min/max freq)
can request the PM QoS on real use-case.

It is impossible to get the devfreq instance before finished
the devfreq_add_device() because the user can access the devfreq instance
devfreq_get_devfreq_by_phandle() which use 'devfreq_list'.

If devfreq_add_device() is not finished, the user cannot get
the any devfreq device from 'devfreq_list'.

> 
>> If start governor and then register PM_QOS,
>> the governor can decide the new frequency. And then PM_QOS request
>> the new constraints for min/max frequency. On request time of PM_QOS,
>> devfreq can detect this time and then apply the constraints from PM_QOS.
>> The user of devfreq's PM_QOS must need the phandle or device instance
>> of devfreq deivce. It means that user of devfreq's PM_QOS can request
>> the any constraints of PM_QOS_MIN/MAX through PM_QOS interface.
>>
>> So, it doesn't need to add the following comments
>> because following comment is not always mandatory.
>> " governor is started (which should do an initial enforcement of constraints)."
>>
>> Also, you don't need to use parentheses on comments.
>>
>> Actually, I think that following comments are enough.
>>
>> 	/* Register PM QoS notifiers for updating to min/max freq */
> 
> I thought that explaning why it's done at this particular step but I'll 
> just remove it, devfreq_add_device can get more comments later.

OK. Thanks.
I think that if the comment contains what is meaning of the code,
it is enough.

Although change the sequence between dev_pm_qos_add_notifier() and
try_then_request_governor(), in the real-case, the any issue
would not happen. Because as I commented above, the other device-driver
cannot get the devfreq instance before finished the devfreq_add_device.
It means that the user device driver cannot request the any PM QoS
constraints.

> 
>>>>>>> +	devfreq->nb_min.notifier_call = qos_min_notifier_call;
>>>>>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>>>>>> +				      DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>> +	if (err)
>>>>>>> +		goto err_devfreq;
>>>>>>> +
>>>>>>> +	devfreq->nb_max.notifier_call = qos_max_notifier_call;
>>>>>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>>>>>> +				      DEV_PM_QOS_MAX_FREQUENCY);
>>>>>>> +	if (err)
>>>>>>> +		goto err_devfreq;
>>>>>>> +
>>>>>>>     	mutex_lock(&devfreq_list_lock);
>>>>>>>     
>>>>>>>     	governor = try_then_request_governor(devfreq->governor_name);
>>>>>>>     	if (IS_ERR(governor)) {
>>>>>>>     		dev_err(dev, "%s: Unable to find governor for the device\n",
>>>>>>> @@ -760,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>>     
>>>>>>>     	return devfreq;
>>>>>>>     
>>>>>>>     err_init:
>>>>>>>     	mutex_unlock(&devfreq_list_lock);
>>>>>>> +err_devfreq:
>>>>>>>     	devfreq_remove_device(devfreq);
>>>>>>>     	return ERR_PTR(err);
>>>>>>>     
>>>>>>>     err_dev:
>>>>>>>     	/*
>>>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>>>> index c3cbc15fdf08..dac0dffeabb4 100644
>>>>>>> --- a/include/linux/devfreq.h
>>>>>>> +++ b/include/linux/devfreq.h
>>>>>>> @@ -134,10 +134,12 @@ struct devfreq_dev_profile {
>>>>>>>      * @total_trans:	Number of devfreq transitions
>>>>>>>      * @trans_table:	Statistics of devfreq transitions
>>>>>>>      * @time_in_state:	Statistics of devfreq states
>>>>>>>      * @last_stat_updated:	The last time stat updated
>>>>>>>      * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>>>>>> + * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>>>>>>> + * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>>>>>>>      *
>>>>>>>      * This structure stores the devfreq information for a give device.
>>>>>>>      *
>>>>>>>      * Note that when a governor accesses entries in struct devfreq in its
>>>>>>>      * functions except for the context of callbacks defined in struct
>>>>>>> @@ -176,10 +178,13 @@ struct devfreq {
>>>>>>>     	unsigned int *trans_table;
>>>>>>>     	unsigned long *time_in_state;
>>>>>>>     	unsigned long last_stat_updated;
>>>>>>>     
>>>>>>>     	struct srcu_notifier_head transition_notifier_list;
>>>>>>> +
>>>>>>> +	struct notifier_block nb_min;
>>>>>>> +	struct notifier_block nb_max;
>>>>>>>     };
>>>>>>>     
>>>>>>>     struct devfreq_freqs {
>>>>>>>     	unsigned long old;
>>>>>>>     	unsigned long new;
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
