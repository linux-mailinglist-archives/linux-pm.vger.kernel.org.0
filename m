Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86085BEA05
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfIZBW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:22:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26056 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbfIZBW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:22:27 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190926012221epoutp011e65191f58ba8172544d89e80804c4aa~H2Gko5wNv0834408344epoutp01r
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190926012221epoutp011e65191f58ba8172544d89e80804c4aa~H2Gko5wNv0834408344epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569460941;
        bh=3LpT0FtbC6gko0dnsPtaxVEJVxaGjwLiSOvRKWBQDE4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oi8mZ76/f4MaN6FVofXgS5xpU9vVuffE40EtP3zPT10Sb8IsR8qQglOc868Qry/Qk
         AMREj5h/Wy8n6BsLfiVsvGhJwaCFQ1C+Z1V9Bs+bIs27tIAorNT9MfuuoENbxtUo1V
         /XJv7YX9juOVGOaJ7bM9Bb3QxLtjbKqRWFGEJxqc=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190926012220epcas1p33ef0f66acaf989fbccb4d69630a3c388~H2Gj-wNAv0576805768epcas1p3G;
        Thu, 26 Sep 2019 01:22:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46dxx54p9bzMqYkk; Thu, 26 Sep
        2019 01:22:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.6B.04144.9C21C8D5; Thu, 26 Sep 2019 10:22:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190926012217epcas1p3fe0aea776ce2bed348e06a7dfddfe49a~H2Gg2ssqY0810508105epcas1p3J;
        Thu, 26 Sep 2019 01:22:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926012217epsmtrp280602f70b8359501adb02cb51872ef63~H2Gg1qPVS1333913339epsmtrp22;
        Thu, 26 Sep 2019 01:22:17 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-dc-5d8c12c9c6f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.2F.04081.9C21C8D5; Thu, 26 Sep 2019 10:22:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926012216epsmtip24b47d64420178885149db5712740c386~H2GglC_pN0328403284epsmtip2f;
        Thu, 26 Sep 2019 01:22:16 +0000 (GMT)
Subject: Re: [PATCH v8 6/6] PM / devfreq: Use PM QoS for sysfs min/max_freq
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
Message-ID: <61182b47-f207-d556-0043-81ed5b32a001@samsung.com>
Date:   Thu, 26 Sep 2019 10:26:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023A6F6F6DF39FC273F020AEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmnu5JoZ5Yg6n96haHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKBHlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5
        xaV56XrJ+blWhgYGRqZAhQnZGT9u3WEsuONW8bS9n7WB8ZxFFyMnh4SAicT21S+Zuxi5OIQE
        djBKrF32kAnC+cQosfzPBlYI5xujxIK2K4wwLTeOXodK7GWUuNNyjwXCec8o0bJpARtIlbCA
        t8Sm/3PAbBGBUIkvTy8xg9jMAk2sEp+OlIHYbAJaEvtf3ACr4RdQlLj64zHYBl4BO4lF918B
        3cHBwSKgKjF7eTRIWFQgQuLTg8OsECWCEidnPmEBsTkFYiUObZ7EBDFeXOLWk/lQtrxE89bZ
        YL9JCFxil9hyAOIeCQEXic2TvkLZwhKvjm9hh7ClJD6/2wsVr5ZYefIIG0RzB6PElv0XWCES
        xhL7l04GO45ZQFNi/S59iLCixM7fcxkhFvNJvPvawwpSIiHAK9HRJgRRoixx+cFdJghbUmJx
        eyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJD5NjexAhO5FqmOxinnPM5xCjA
        wajEwysR2R0rxJpYVlyZe4hRgoNZSYR3lkxXrBBvSmJlVWpRfnxRaU5q8SFGU2BgT2SWEk3O
        B2aZvJJ4Q1MjY2NjCxNDM1NDQyVxXo/0hlghgfTEktTs1NSC1CKYPiYOTqkGxsnKv0+WHl6y
        O/qNrsvvo/HsL4S2LJ64QPXH9ml7hH4r5ypes+1RvxPlVutX+EDIs6Db6dehmOJb8/KmvShP
        Z157quVNSkr/hYhTCy4YnD+8hSGw45pd68EIxnkXhNYtUhNz0hLkCJe3bw+2LVmSsiTo1pJg
        Bn0t0Ut3PG+V/jihUbrh14cz25RYijMSDbWYi4oTAQ2fvZD6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSvO5JoZ5Ygxu/OS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUVw2Kak5mWWpRfp2CVwZP27dYSy441bxtL2ftYHxnEUXIyeH
        hICJxI2j11m7GLk4hAR2M0qsefSZCSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSXx98ZwepERbw
        ltj0fw4biC0iECrxp3M52CBmgSZWia7v1xkhOl4xSTRf3AVWxSagJbH/xQ0wm19AUeLqj8eM
        IDavgJ3EovuvmEC2sQioSsxeHg0SFhWIkDi8YxZUiaDEyZlPWEBsToFYiUObJ4EdyiygLvFn
        3iVmCFtc4taT+VBxeYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCYl1qu
        V5yYW1yal66XnJ+7iREc01qaOxgvL4k/xCjAwajEw3sgrDtWiDWxrLgy9xCjBAezkgjvLJmu
        WCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoY9dbeP25x
        VoMz1cPnTfae455VixmXdBmH/3Q4HVjm3Pswd5Or3XyxprrCq3sMuZ6ICYQu38AwJ2mVXPg2
        HtmCQ7GewRmy005dW5gfd5H19r5VCcsU25YWtMY+M5hlcjOAseOjqfPmt6evFynHKz59JiSf
        rrTpA8+bCjkdtx1PtGxYF507I1anxFKckWioxVxUnAgAYUDHwuUCAAA=
X-CMS-MailID: 20190926012217epcas1p3fe0aea776ce2bed348e06a7dfddfe49a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924101141epcas4p37956967e2f06b8a857cb53ff12ca791b
References: <cover.1569319738.git.leonard.crestez@nxp.com>
        <CGME20190924101141epcas4p37956967e2f06b8a857cb53ff12ca791b@epcas4p3.samsung.com>
        <3eb8a1d1e7d738f7599d54348d6b474196581693.1569319738.git.leonard.crestez@nxp.com>
        <c521989f-51b6-84eb-b4f1-c4469494345e@samsung.com>
        <VI1PR04MB7023A6F6F6DF39FC273F020AEE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 26. 오전 7:11, Leonard Crestez wrote:
> On 25.09.2019 05:36, Chanwoo Choi wrote:
>> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
>>> Switch the handling of min_freq and max_freq from sysfs to use the
>>> dev_pm_qos_request interface.
>>>
>>> Since PM QoS handles frequencies as kHz this change reduces the
>>> precision of min_freq and max_freq. This shouldn't introduce problems
>>> because frequencies which are not an integer number of kHz are likely
>>> not an integer number of Hz either.
>>>
>>> Try to ensure compatibility by rounding min values down and rounding
>>> max values up.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>   drivers/devfreq/devfreq.c | 46 ++++++++++++++++++++++++---------------
>>>   include/linux/devfreq.h   |  9 ++++----
>>>   2 files changed, 33 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 784f3e40536a..8bb7efd821ab 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -137,14 +137,10 @@ static void get_freq_range(struct devfreq *devfreq,
>>>   	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>   					     DEV_PM_QOS_MIN_FREQUENCY);
>>>   	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>>>   	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>>>   
>>> -	/* constraints from sysfs */
>>> -	*min_freq = max(*min_freq, devfreq->min_freq);
>>> -	*max_freq = min(*max_freq, devfreq->max_freq);
>>> -
>>>   	/* constraints from OPP interface */
>>>   	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>>>   	/* scaling_max_freq can be zero on error */
>>>   	if (devfreq->scaling_max_freq)
>>>   		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
>>> @@ -679,10 +675,12 @@ static void devfreq_dev_release(struct device *dev)
>>>   			DEV_PM_QOS_MIN_FREQUENCY);
>>>   
>>>   	if (devfreq->profile->exit)
>>>   		devfreq->profile->exit(devfreq->dev.parent);
>>>   
>>> +	dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
>>> +	dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
>>
>> Please check the return value if error happen, just print the err with dev_err()
>> without stopping the release steps.
> 
> OK, will print errors
> 
>>>   	kfree(devfreq->time_in_state);
>>>   	kfree(devfreq->trans_table);
>>>   	mutex_destroy(&devfreq->lock);
>>>   	kfree(devfreq);
>>>   }
>>> @@ -747,18 +745,25 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>   	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>>>   	if (!devfreq->scaling_min_freq) {
>>>   		err = -EINVAL;
>>>   		goto err_dev;
>>>   	}
>>> -	devfreq->min_freq = devfreq->scaling_min_freq;
>>>   
>>>   	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>>>   	if (!devfreq->scaling_max_freq) {
>>>   		err = -EINVAL;
>>>   		goto err_dev;
>>>   	}
>>> -	devfreq->max_freq = devfreq->scaling_max_freq;
>>> +
>>> +	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
>>> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
>>> +	if (err < 0)
>>> +		goto err_dev;
>>> +	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
>>> +				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
>>> +	if (err < 0)
>>> +		goto err_dev;
>>>   
>>>   	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>>   	atomic_set(&devfreq->suspend_count, 0);
>>>   
>>>   	devfreq->trans_table = kzalloc(
>>> @@ -843,10 +848,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>   err_dev:
>>>   	/*
>>>   	 * Cleanup path for errors that happen before registration.
>>>   	 * Otherwise we rely on devfreq_dev_release.
>>>   	 */
>>> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
>>> +		dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
>>
>> Please check the return value if error happen, just print the err with dev_err()
>> without stopping the release steps.
> 
> OK, will print errors
> 
>>
>> 	dev_err(... "failed to remove request of DEV_PM_QOS_MAX_FREQUENCY\n");
>>
>>> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
>>> +		dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
>> 	
>> 	dev_err(... "failed to remove request of DEV_PM_QOS_MIN_FREQUENCY\n");
>>
>>>   	kfree(devfreq->time_in_state);
>>>   	kfree(devfreq->trans_table);
>>>   	kfree(devfreq);
>>>   err_out:
>>>   	return ERR_PTR(err);
>>> @@ -1407,14 +1416,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>   
>>>   	ret = sscanf(buf, "%lu", &value);
>>>   	if (ret != 1)
>>>   		return -EINVAL;
>>>   
>>> -	mutex_lock(&df->lock);
>>> -	df->min_freq = value;
>>> -	update_devfreq(df);
>>> -	mutex_unlock(&df->lock);
>>> +	/* round down to kHz for PM QoS */
>>
>> I prefer more detailed description as following:
>>
>> 	/*
>> 	 * Round down to KHz to decide the proper minimum frequency
>> 	 * which is closed to user request.
>>   	 */

How about this comment? and with Matthias comment on other reply thread.

>>
>>
>>> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
>>> +					value / HZ_PER_KHZ);
>>> +	if (ret < 0)
>>> +		return ret;
>>>   
>>>   	return count;
>>>   }
>>>   
>>>   static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>>> @@ -1439,19 +1449,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>   
>>>   	ret = sscanf(buf, "%lu", &value);
>>>   	if (ret != 1)
>>>   		return -EINVAL;
>>>   
>>> -	mutex_lock(&df->lock);
>>> -
>>> -	/* Interpret zero as "don't care" */
>>> -	if (!value)
>>> -		value = ULONG_MAX;
>>> +	/* round up to kHz for PM QoS and interpret zero as "don't care" */
>>
>> I think that "don't care" comment style is not good.
>>
>> I referred to the Documentation/ABI/testing/sysfs-class-devfreq file.
>> I prefer more detailed description as following:
>> 	/*
>> 	 * Round up to KHz to decide the proper maximum frequency
>> 	 * which is closed to user request. If value is zero,
>> 	 * the user does not care.
>>   	 */
> 
> OK, will update this comment
> 
>>> +	if (value)
>>> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
>>> +	else
>>> +		value = S32_MAX;
>>>   
>>> -	df->max_freq = value;
>>> -	update_devfreq(df);
>>> -	mutex_unlock(&df->lock);
>>> +	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
>>> +	if (ret < 0)
>>> +		return ret;
>>>   
>>>   	return count;
>>>   }
>>>   static DEVICE_ATTR_RW(min_freq);
>>>   
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index dac0dffeabb4..7849fe4c666d 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -11,10 +11,11 @@
>>>   #define __LINUX_DEVFREQ_H__
>>>   
>>>   #include <linux/device.h>
>>>   #include <linux/notifier.h>
>>>   #include <linux/pm_opp.h>
>>> +#include <linux/pm_qos.h>
>>>   
>>>   #define DEVFREQ_NAME_LEN 16
>>>   
>>>   /* DEVFREQ governor name */
>>>   #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
>>> @@ -121,12 +122,12 @@ struct devfreq_dev_profile {
>>>    *		devfreq.nb to the corresponding register notifier call chain.
>>>    * @work:	delayed work for load monitoring.
>>>    * @previous_freq:	previously configured frequency value.
>>>    * @data:	Private data of the governor. The devfreq framework does not
>>>    *		touch this.
>>> - * @min_freq:	Limit minimum frequency requested by user (0: none)
>>> - * @max_freq:	Limit maximum frequency requested by user (0: none)
>>> + * @user_min_freq_req:	PM QoS min frequency request from user (via sysfs)
>>
>> min -> minimum and then remove parenthesis as following:
>> 	PM QoS minimum frequency request by user via sysfs
>>
>>> + * @user_max_freq_req:	PM QoS max frequency request from user (via sysfs)
>>
>> ditto. max -> maximum
>> 	PM QoS maximum frequency request by user via sysfs
> 
> OK

Thanks.

> 
>>>    * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>    * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>    * @stop_polling:	 devfreq polling status of a device.
>>>    * @suspend_freq:	 frequency of a device set during suspend phase.
>>>    * @resume_freq:	 frequency of a device set in resume phase.
>>> @@ -161,12 +162,12 @@ struct devfreq {
>>>   	unsigned long previous_freq;
>>>   	struct devfreq_dev_status last_status;
>>>   
>>>   	void *data; /* private data for governors */
>>>   
>>> -	unsigned long min_freq;
>>> -	unsigned long max_freq;
>>> +	struct dev_pm_qos_request user_min_freq_req;
>>> +	struct dev_pm_qos_request user_max_freq_req;
>>>   	unsigned long scaling_min_freq;
>>>   	unsigned long scaling_max_freq;
>>>   	bool stop_polling;
>>>   
>>>   	unsigned long suspend_freq;
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
