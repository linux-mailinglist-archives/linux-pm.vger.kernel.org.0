Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94DC42F8
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfJAVuw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 17:50:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20585 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfJAVuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 17:50:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191001215046epoutp023cf4fbdb5f8bc8ba3879214471caf807~JpFjtlQDv0986409864epoutp02O
        for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2019 21:50:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191001215046epoutp023cf4fbdb5f8bc8ba3879214471caf807~JpFjtlQDv0986409864epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569966647;
        bh=ssPXOm9Za62an3KBa6ca/tmeSetWaQ7nq92aRkL8xvQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=G4oIy0ZEhtg3UZPbmn3nBzR8FbM3jjWdNC/2t4p+Iodrgg0qAFUTO7x9n8v5TOKbm
         Mr4A12TMn/XU/i6RnQz307O3eQoWKvImd3f63/teDcPq6oNJzVSVd//yh8Bq5U8tn3
         9DuJB5ckDeCJKITy7ZQqQxODbUR6Athd4+Dg2HBw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191001215046epcas1p34c255de0bad8c71375fba926c7171ce2~JpFjCmIDG3209032090epcas1p3D;
        Tue,  1 Oct 2019 21:50:46 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46jXyD0VGKzMqYll; Tue,  1 Oct
        2019 21:50:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.E0.04144.33AC39D5; Wed,  2 Oct 2019 06:50:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191001215043epcas1p272c6545368f976bb22ae753343a64cfe~JpFgZM2mU2044620446epcas1p2R;
        Tue,  1 Oct 2019 21:50:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191001215043epsmtrp16e0b5a77b5e1a3d795ba79be4b0e2f87~JpFgV_UZE0564805648epsmtrp1N;
        Tue,  1 Oct 2019 21:50:43 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-50-5d93ca33800c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.20.04081.33AC39D5; Wed,  2 Oct 2019 06:50:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191001215042epsmtip2ed04c306e3e9f835eea137605827f4ba~JpFgBNwEc1636616366epsmtip2P;
        Tue,  1 Oct 2019 21:50:42 +0000 (GMT)
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
Message-ID: <99758b12-5917-ee53-cbcd-4df8cf69d98d@samsung.com>
Date:   Wed, 2 Oct 2019 06:55:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023C82B1F961BAF859831E3EE9D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmnq7xqcmxBhMeWVocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4AeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZzzc9Jqt4Gp9xbeFp5kaGDvTuxg5OSQETCTOndjI0sXIxSEk
        sINRYvqDW2wQzidGicsnLzNCON8YJSZvX8MK0/Lt4Aqolr2MEic/TGGCcN4zSizetJ4dpEpY
        wEbi/9WPbCC2iECoxJenl5hBbGaBJlaJT0fKQGw2AS2J/S9ugNXwCyhKXP3xmBHE5hWwk7j+
        7AwLiM0ioCJx8/pjMFtUIELi04PDrBA1ghInZz4Bi3MKxEpMmPudFWK+uMStJ/OZIGx5ieat
        s5lBjpMQuMQu8enLJTaIF1wk5v7/xgRhC0u8Or6FHcKWknjZ3wZlV0usPHmEDaK5g1Fiy/4L
        UP8bS+xfOhmomQNog6bE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO7UGsl
        JRa3d7JNYFSaheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBEju5NjOBUrmW6g3HKOZ9D
        jAIcjEo8vDdCJscKsSaWFVfmHmKU4GBWEuG1+TMpVog3JbGyKrUoP76oNCe1+BCjKTC0JzJL
        iSbnA/NMXkm8oamRsbGxhYmhmamhoZI4r0d6Q6yQQHpiSWp2ampBahFMHxMHp1QDo37LtXU7
        3F4+3VjPv9pW5nMe77Ir6ho/HuofXPI6/E6Fy5kL/QxBh86LLLiwckPa26VCi0JOb7WeG+1m
        U//25Yf/M1ebL3l4pFZ59k7GhS+eawTa5s3UtDUpd1JU7n0tym8lwPRjOf86J8Nd+1lfPyla
        Lupe8+eR1TlNm6WFEnn729KOx1S/mKnEUpyRaKjFXFScCABhZ2sy+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvK7xqcmxBgcuClgcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyHm56zVZwtb7i28LTTA2MneldjJwc
        EgImEt8OrmDpYuTiEBLYzShx69EmdoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKPJ7WxAZSIyxg
        I/H/6kcwW0QgVOJP53JWkCJmgSZWia7v1xkhOprYJE7sv8MCUsUmoCWx/8UNsA5+AUWJqz8e
        M4LYvAJ2EtefnQGrYRFQkbh5/TGYLSoQIXF4xyyoGkGJkzOfgMU5BWIlJsz9zgpiMwuoS/yZ
        d4kZwhaXuPVkPhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL
        9YoTc4tL89L1kvNzNzGCo1pLcwfj5SXxhxgFOBiVeHgbgibHCrEmlhVX5h5ilOBgVhLhtfkz
        KVaINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxqwnW6cc
        1M62ZlfIKPSr/PbhburEVbcX77gXttvHimmOb9+5Mj+drIvMe6YulGW9peK2R94tIOvoqy27
        Hi6I14rVNp1xeZPTQaszdfZB/3dFfDVNd8veH33ao4j1yawp3ZKqPvrB2uy7T1fP0NXp2PeO
        /f76O9Kva94JMpbf15Q09T2TwBafocRSnJFoqMVcVJwIACWQ27rmAgAA
X-CMS-MailID: 20191001215043epcas1p272c6545368f976bb22ae753343a64cfe
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
        <bb942624-f6ad-56c8-5a7c-32ed77d1f789@samsung.com>
        <VI1PR04MB7023C82B1F961BAF859831E3EE9D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 1. 오후 6:39, Leonard Crestez wrote:
> On 2019-10-01 12:37 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> On 19. 9. 30. 오후 10:16, Leonard Crestez wrote:
>>> On 2019-09-27 4:45 AM, Chanwoo Choi wrote:
>>>> On 19. 9. 26. 오후 10:43, Leonard Crestez wrote:
>>>>> On 2019-09-26 4:07 AM, Chanwoo Choi wrote:
>>>>>> On 19. 9. 26. 오전 6:18, Leonard Crestez wrote:
>>>>>>> On 25.09.2019 05:11, Chanwoo Choi wrote:
>>>>>>>> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
>>>>>>>>> Register notifiers with the PM QoS framework in order to respond to
>>>>>>>>> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
>>>>>>>>>
>>>>>>>>> No notifiers are added by this patch but PM QoS constraints can be
>>>>>>>>> imposed externally (for example from other devices).
>>>>>>>>>
>>>>>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>>>>>> ---
>>>>>>>>>      drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++
>>>>>>>>>      include/linux/devfreq.h   |  5 +++
>>>>>>>>>      2 files changed, 80 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>>>> index eee403e70c84..784f3e40536a 100644
>>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>>> @@ -22,15 +22,18 @@
>>>>>>>>>      #include <linux/platform_device.h>
>>>>>>>>>      #include <linux/list.h>
>>>>>>>>>      #include <linux/printk.h>
>>>>>>>>>      #include <linux/hrtimer.h>
>>>>>>>>>      #include <linux/of.h>
>>>>>>>>> +#include <linux/pm_qos.h>
>>>>>>>>>      #include "governor.h"
>>>>>>>>>      
>>>>>>>>>      #define CREATE_TRACE_POINTS
>>>>>>>>>      #include <trace/events/devfreq.h>
>>>>>>>>>      
>>>>>>>>> +#define HZ_PER_KHZ	1000
>>>>>>>>> +
>>>>>>>>>      static struct class *devfreq_class;
>>>>>>>>>      
>>>>>>>>>      /*
>>>>>>>>>       * devfreq core provides delayed work based load monitoring helper
>>>>>>>>>       * functions. Governors can use these or can implement their own
>>>>>>>>> @@ -109,10 +112,11 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>>>>>>>      static void get_freq_range(struct devfreq *devfreq,
>>>>>>>>>      			   unsigned long *min_freq,
>>>>>>>>>      			   unsigned long *max_freq)
>>>>>>>>>      {
>>>>>>>>>      	unsigned long *freq_table = devfreq->profile->freq_table;
>>>>>>>>> +	unsigned long qos_min_freq, qos_max_freq;
>>>>>>>>>      
>>>>>>>>>      	lockdep_assert_held(&devfreq->lock);
>>>>>>>>>      
>>>>>>>>>      	/*
>>>>>>>>>      	 * Init min/max frequency from freq table.
>>>>>>>>> @@ -125,10 +129,18 @@ static void get_freq_range(struct devfreq *devfreq,
>>>>>>>>>      	} else {
>>>>>>>>>      		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>>>>>>>>      		*max_freq = freq_table[0];
>>>>>>>>>      	}
>>>>>>>>>      
>>>>>>>>> +	/* constraints from PM QoS */
>>>>>>>>
>>>>>>>> As I commented on patch4,
>>>>>>>> 'constraints' -> 'Constraint' because first verb have to be used
>>>>>>>> as the sigular verbs.
>>>>>>>
>>>>>>> Already discussed for another patch; I will modify to "Apply constraints
>>>>>>> from PM QoS" instead.
>>>>>>
>>>>>> I agree the new comment with 'Apply constraints ... '.
>>>>>>
>>>>>>>
>>>>>>>> I prefer to use following comments:
>>>>>>>>
>>>>>>>> 	/* Constraint minimum/maximum frequency from PM QoS constraints */
>>>>>>>>
>>>>>>>>> +	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>>>> +	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>>>>>> +					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>>>> +	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>>>>>>>>> +	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>>>>>>>>> +
>>>>>>>>>      	/* constraints from sysfs */
>>>>>>>>>      	*min_freq = max(*min_freq, devfreq->min_freq);
>>>>>>>>>      	*max_freq = min(*max_freq, devfreq->max_freq);
>>>>>>>>>      
>>>>>>>>>      	/* constraints from OPP interface */
>>>>>>>>> @@ -606,10 +618,49 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
>>>>>>>>>      	mutex_unlock(&devfreq->lock);
>>>>>>>>>      
>>>>>>>>>      	return ret;
>>>>>>>>>      }
>>>>>>>>>      
>>>>>>>>> +/**
>>>>>>>>> + * qos_notifier_call() - Common handler for QoS constraints.
>>>>>>>>> + * @devfreq:    the devfreq instance.
>>>>>>>>> + */
>>>>>>>>> +static int qos_notifier_call(struct devfreq *devfreq)
>>>>>>>>> +{
>>>>>>>>> +	int err;
>>>>>>>>> +
>>>>>>>>> +	mutex_lock(&devfreq->lock);
>>>>>>>>> +	err = update_devfreq(devfreq);
>>>>>>>>> +	mutex_unlock(&devfreq->lock);
>>>>>>>>> +	if (err)
>>>>>>>>> +		dev_err(devfreq->dev.parent,
>>>>>>>>> +				"failed to update frequency for PM QoS constraints (%d)\n",
>>>>>>>>
>>>>>>>> Is it not over 80 char?
>>>>>>>
>>>>>>> Yes but coding style explicitly forbids breaking strings.
>>>>>>>
>>>>>>>>> +				err);
>>>>>>>>> +
>>>>>>>>> +	return NOTIFY_OK;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +/**
>>>>>>>>> + * qos_min_notifier_call() - Callback for QoS min_freq changes.
>>>>>>>>> + * @nb:		Should be devfreq->nb_min
>>>>>>>>> + */
>>>>>>>>> +static int qos_min_notifier_call(struct notifier_block *nb,
>>>>>>>>> +					 unsigned long val, void *ptr)
>>>>>>>>> +{
>>>>>>>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_min));
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +/**
>>>>>>>>> + * qos_max_notifier_call() - Callback for QoS max_freq changes.
>>>>>>>>> + * @nb:		Should be devfreq->nb_max
>>>>>>>>> + */
>>>>>>>>> +static int qos_max_notifier_call(struct notifier_block *nb,
>>>>>>>>> +					 unsigned long val, void *ptr)
>>>>>>>>> +{
>>>>>>>>> +	return qos_notifier_call(container_of(nb, struct devfreq, nb_max));
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>      /**
>>>>>>>>>       * devfreq_dev_release() - Callback for struct device to release the device.
>>>>>>>>>       * @dev:	the devfreq device
>>>>>>>>>       *
>>>>>>>>>       * Remove devfreq from the list and release its resources.
>>>>>>>>> @@ -620,10 +671,15 @@ static void devfreq_dev_release(struct device *dev)
>>>>>>>>>      
>>>>>>>>>      	mutex_lock(&devfreq_list_lock);
>>>>>>>>>      	list_del(&devfreq->node);
>>>>>>>>>      	mutex_unlock(&devfreq_list_lock);
>>>>>>>>>      
>>>>>>>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>>>>>>>> +			DEV_PM_QOS_MAX_FREQUENCY);
>>>>>>>>> +	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>>>>>>>> +			DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>>>> +
>>>>>>>>
>>>>>>>> Just print error with dev_err() without stopping the release step.
>>>>>>>>
>>>>>>>> I prefer to handle the return value if kernel API provides
>>>>>>>> the error code.
>>>>>>
>>>>>> How about?
>>>>>
>>>>> Modified to dev_warn. This also applies to PATCH 6 so I replied there.
>>>>>
>>>>>>>>>      	if (devfreq->profile->exit)
>>>>>>>>>      		devfreq->profile->exit(devfreq->dev.parent);
>>>>>>>>>      
>>>>>>>>>      	kfree(devfreq->time_in_state);
>>>>>>>>>      	kfree(devfreq->trans_table);
>>>>>>>>> @@ -733,10 +789,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>>>>      	if (err) {
>>>>>>>>>      		put_device(&devfreq->dev);
>>>>>>>>>      		goto err_out;
>>>>>>>>>      	}
>>>>>>>>>      
>>>>>>>>> +	/*
>>>>>>>>> +	 * Register notifiers for updates to min/max_freq after device is
>>>>>>>>> +	 * initialized (and we can handle notifications) but before the
>>>>>>>>> +	 * governor is started (which should do an initial enforcement of
>>>>>>>>> +	 * constraints).
>>>>>>>>> +	 */
>>>>>>>>
>>>>>>>> My previous comment is not enough why I prefer to remove it. Sorry.
>>>>>>>> Actually, until now, the devfreq_add_device() don't have the detailed
>>>>>>>> comments because the line code is not too long. But, at the present time,
>>>>>>>> devfreq_add_device() is too long. It means that the detailed comment
>>>>>>>> are necessary.
>>>>>>>>
>>>>>>>> So, I'll add the detailed comment for each step of devfreq_add_device()
>>>>>>>> on separate patch to keep the same style. I'll send the patch to you
>>>>>>>> for the review.
>>>>>>>
>>>>>>> This is very likely to result in merge conflicts, maybe wait for my
>>>>>>> series to go in first?
>>>>>>
>>>>>> I'll send the separate patch after finished the review of these patches.
>>>>>> So, if you agree, please remove this comment on this patch.
>>>>>>
>>>>>> You can review the detailed comments on separate patch when I send.
>>>>> This patch already contains comments and they explain the code being
>>>>> added. Doesn't it make more sense for comments and code to go in together?
>>>>>
>>>>> I think the comment is a resonable explanation as to why notifiers are
>>>>> registered at that specific step in the initialization sequence.
>>>>
>>>> If you add this comment on this patch, OK. just I have some comments.
>>>>
>>>> 	/*
>>>> 	 * Register notifiers for updates to min/max_freq after device is
>>>> 	 * initialized (and we can handle notifications) but before the
>>>>
>>>> I think that 'device is initialized' is not needed.
>>>> It is always true, it don't need to add the additional comments.
>>>> because dev_pm_qos_add_notifier() must need the 'devfreq->dev'.
>>>> The this code prove the call sequence between them.
>>>
>>> In theory if a notifier is registered too soon then it could crash on a
>>> NULL pointer. But looking at the code it first checks that "governor !=
>>> NULL) so it would be harmless.
>>>
>>>>
>>>> About 'us', don't use 'we'. The subject is 'devfreq' or other device instead of us.
>>>>
>>>> 	 * governor is started (which should do an initial enforcement of
>>>> 	 * constraints).
>>>>    	 */
>>>>
>>>> Actually, it doesn't matter the initialization step between governor
>>>> and PM_QOS registration.
>>>
>>> In theory PM QoS constraints could be modified between governor startup
>>> and notifier registration and that update would be lost (until the next
>>> one).
>>
>> Don't lose the any of PM QoS request. User can request the any frequency
>> through PMQoS at the any time and then devfreq consider the constraints
>> from PM QoS.
>>
>> Also, after finished the registration of devfreq device,
>> the user (other device driver required the min/max freq)
>> can request the PM QoS on real use-case.
>>
>> It is impossible to get the devfreq instance before finished
>> the devfreq_add_device() because the user can access the devfreq instance
>> devfreq_get_devfreq_by_phandle() which use 'devfreq_list'.
>>
>> If devfreq_add_device() is not finished, the user cannot get
>> the any devfreq device from 'devfreq_list'.
> 
> PM QoS constraints are not on devfreq->dev but on the parent so in 
> theory it's possible to add constraints during devfreq initialization.
> 
> Making PM QoS requests doesn't require fetching devfreq instances, I 
> think you could call of_find_device_by_node with a phandle and register 
> constraints that way.

You're right.

My comment was not enough. I mean that PM QoS depends on the devfreq->dev.parent.
If probe() of devfreq device requires the PMQoS request, it is possible to
register PM QoS. On the other hand, the other device device regardless
the devfreq device driver, they can request PM QoS constraints
after registering the parent device (devfreq->dev.parent). 

Your patch already registered the PM QoS notifier before governor start.
It is enough to show the your intention. I don't any objection of this code.
Just, the too more detailed comment make the devfreq core complicated.
As I commented, I think t hat the simple comment is enough for devfreq user.

Thanks for your explanation.

> 
>>>> If start governor and then register PM_QOS,
>>>> the governor can decide the new frequency. And then PM_QOS request
>>>> the new constraints for min/max frequency. On request time of PM_QOS,
>>>> devfreq can detect this time and then apply the constraints from PM_QOS.
>>>> The user of devfreq's PM_QOS must need the phandle or device instance
>>>> of devfreq deivce. It means that user of devfreq's PM_QOS can request
>>>> the any constraints of PM_QOS_MIN/MAX through PM_QOS interface.
>>>>
>>>> So, it doesn't need to add the following comments
>>>> because following comment is not always mandatory.
>>>> " governor is started (which should do an initial enforcement of constraints)."
>>>>
>>>> Also, you don't need to use parentheses on comments.
>>>>
>>>> Actually, I think that following comments are enough.
>>>>
>>>> 	/* Register PM QoS notifiers for updating to min/max freq */
>>>
>>> I thought that explaning why it's done at this particular step but I'll
>>> just remove it, devfreq_add_device can get more comments later.
>>
>> OK. Thanks.
>> I think that if the comment contains what is meaning of the code,
>> it is enough.
>>
>> Although change the sequence between dev_pm_qos_add_notifier() and
>> try_then_request_governor(), in the real-case, the any issue
>> would not happen. Because as I commented above, the other device-driver
>> cannot get the devfreq instance before finished the devfreq_add_device.
>> It means that the user device driver cannot request the any PM QoS
>> constraints.
>>
>>>
>>>>>>>>> +	devfreq->nb_min.notifier_call = qos_min_notifier_call;
>>>>>>>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
>>>>>>>>> +				      DEV_PM_QOS_MIN_FREQUENCY);
>>>>>>>>> +	if (err)
>>>>>>>>> +		goto err_devfreq;
>>>>>>>>> +
>>>>>>>>> +	devfreq->nb_max.notifier_call = qos_max_notifier_call;
>>>>>>>>> +	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
>>>>>>>>> +				      DEV_PM_QOS_MAX_FREQUENCY);
>>>>>>>>> +	if (err)
>>>>>>>>> +		goto err_devfreq;
>>>>>>>>> +
>>>>>>>>>      	mutex_lock(&devfreq_list_lock);
>>>>>>>>>      
>>>>>>>>>      	governor = try_then_request_governor(devfreq->governor_name);
>>>>>>>>>      	if (IS_ERR(governor)) {
>>>>>>>>>      		dev_err(dev, "%s: Unable to find governor for the device\n",
>>>>>>>>> @@ -760,10 +834,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>>>>      
>>>>>>>>>      	return devfreq;
>>>>>>>>>      
>>>>>>>>>      err_init:
>>>>>>>>>      	mutex_unlock(&devfreq_list_lock);
>>>>>>>>> +err_devfreq:
>>>>>>>>>      	devfreq_remove_device(devfreq);
>>>>>>>>>      	return ERR_PTR(err);
>>>>>>>>>      
>>>>>>>>>      err_dev:
>>>>>>>>>      	/*
>>>>>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>>>>>> index c3cbc15fdf08..dac0dffeabb4 100644
>>>>>>>>> --- a/include/linux/devfreq.h
>>>>>>>>> +++ b/include/linux/devfreq.h
>>>>>>>>> @@ -134,10 +134,12 @@ struct devfreq_dev_profile {
>>>>>>>>>       * @total_trans:	Number of devfreq transitions
>>>>>>>>>       * @trans_table:	Statistics of devfreq transitions
>>>>>>>>>       * @time_in_state:	Statistics of devfreq states
>>>>>>>>>       * @last_stat_updated:	The last time stat updated
>>>>>>>>>       * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
>>>>>>>>> + * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>>>>>>>>> + * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>>>>>>>>>       *
>>>>>>>>>       * This structure stores the devfreq information for a give device.
>>>>>>>>>       *
>>>>>>>>>       * Note that when a governor accesses entries in struct devfreq in its
>>>>>>>>>       * functions except for the context of callbacks defined in struct
>>>>>>>>> @@ -176,10 +178,13 @@ struct devfreq {
>>>>>>>>>      	unsigned int *trans_table;
>>>>>>>>>      	unsigned long *time_in_state;
>>>>>>>>>      	unsigned long last_stat_updated;
>>>>>>>>>      
>>>>>>>>>      	struct srcu_notifier_head transition_notifier_list;
>>>>>>>>> +
>>>>>>>>> +	struct notifier_block nb_min;
>>>>>>>>> +	struct notifier_block nb_max;
>>>>>>>>>      };
>>>>>>>>>      
>>>>>>>>>      struct devfreq_freqs {
>>>>>>>>>      	unsigned long old;
>>>>>>>>>      	unsigned long new;
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
