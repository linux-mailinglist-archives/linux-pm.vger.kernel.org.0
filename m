Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A86BE9DB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfIZBCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:02:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14915 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZBCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:02:06 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190926010203epoutp0376038398d5d1658a063188e770fcd3c9~H102yYF7Y3143831438epoutp031
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190926010203epoutp0376038398d5d1658a063188e770fcd3c9~H102yYF7Y3143831438epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569459723;
        bh=GxdOq21yZAtQuxibZhaUbRIp7a7SZeXrBBOpYiSeG9k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Np6iPbwcmu6Yu7+ANXKDuZSQEKCYT3FKQX6UOM+AU32QzZq2f57OF5W53IqXK6vZQ
         3lJuxZ1ora8tGVy2fwjasyHPdakcG18Yt4x+5LnzHl+JFkwYmmQWjBqNaWcdpKb75+
         4D6TOX185z7VctqSxZi7F88hLKj/c5cmdT6Yg1wk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190926010203epcas1p4a947ad92794a87974afef2da70215bd5~H102LiIvJ0839108391epcas1p4l;
        Thu, 26 Sep 2019 01:02:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46dxTh613yzMqYkV; Thu, 26 Sep
        2019 01:02:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.0B.04068.80E0C8D5; Thu, 26 Sep 2019 10:02:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190926010159epcas1p13094a3dbd4ced250c61d06444e5a24a8~H10zHzhs_1837518375epcas1p1w;
        Thu, 26 Sep 2019 01:01:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926010159epsmtrp21e6bed08826017c7da87dfe64f3885e2~H10zGsVZy3253832538epsmtrp22;
        Thu, 26 Sep 2019 01:01:59 +0000 (GMT)
X-AuditID: b6c32a39-3b9219c000000fe4-61-5d8c0e083a7c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.0D.04081.70E0C8D5; Thu, 26 Sep 2019 10:01:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926010159epsmtip276d211487a978ff6ce91b014951135a4~H10y0zR5-2177821778epsmtip2b;
        Thu, 26 Sep 2019 01:01:59 +0000 (GMT)
Subject: Re: [PATCH v8 4/6] PM / devfreq: Introduce get_freq_range helper
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e8ec6c2e-8536-b926-c1fc-468f9e9adca7@samsung.com>
Date:   Thu, 26 Sep 2019 10:06:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB70235A2C13E47029B3093D33EE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbZRTG8/be3hZi4bUMd2w37a7RBAxbO+h8mWMhbppLtimZiYHFBm/g
        piD9Sm873Uxmh0Ggso0F3bKiwiaSwYiM2k0kNJWCM9NtOJGPADNoSfYR08Y1GNQo3va6yH+/
        c85zzsnzfqgp7W1Gp65zeAS3g7exTCZ9eSzPWKDOarUYO6aNJHrlkoosf/ctIj0/fI3I6XCQ
        IRMTF1XkesOvKjLn20DO3/pNSYKxaSXx/9lLkeSxcUSSF2OIzB89z5ALN0YZ4o/+zZDBZa4U
        c4nZRhXX4btJc11BLxfsa2G4hekRhvu8+21uMD6k4EbjIwrueKgPccngY+WZB+p31Ap8jeA2
        CI5qZ02dw1rC7nm5aleVeZvRVGAqJs+wBgdvF0rY3XvLC16os0lGWMNB3uaVUuW8KLJbdu5w
        O70ewVDrFD0lrOCqsbmKXZtF3i56HdbN1U77dpPRuNUsCV+rr/05cIp2neDeXI20K3xoifhR
        hhpwESTvnEMp1uIhBCNNG/0oU+L7En9xTSkHvyNoHr+GHnRMrZ5VyYUwgsuxAamgloIEgqbS
        lCYHl0Fo/hiT0qzDkwgWPm6nUgGFG2hYaZMnMTgfIndmmRRn400wtRJL5zV4J8ysLlEppvGT
        cGG+P825uALuL44pZc3DcPXMEp3iDGyB7n/m0nMovB7mljoVMj8O71zqSC8GPK2C8EA3LVvY
        DV2JD1Qy58C9b0L/sQ6S8TAj81vQe3WckZubEYQi3yvlQiFEPm1XpCxTOA8GhrfI6U3w5V8f
        IXlxFsSXW5UpCWANNL+rlSVPwOTiLYXMj8InTS1MG2IDa+wE1lgIrLEQ+H9ZF6L70COCS7Rb
        BdHkMq+97SBKP/L84iF05cbeKMJqxD6kgcr3LFolf1A8ZI8iUFPsOk1gg9+i1dTwhw4LbmeV
        22sTxCgyS6d9ktLlVjulL+PwVJnMWwsLC0mRaZvZZGLXazirz6LFVt4j1AuCS3A/6FOoM3Q+
        NDahM8S6furcjyl9S+K5nudDRxuHge15+nRFxS8zlW3kQ7zxSGPusP7cK4M38/Tel/R73sjK
        ODHXH+zepRZndXG65NXSA5EjZyqfvXv3fTb7cO+LJ91f7X+9v3i0rPHe8Mq+zuvBzqLsxcnW
        cKJsKjnzR1GMyvnx+O3Ptgf0CxMNT7G0WMub8im3yP8LxWtfrPoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSvC47X0+swc1X+haHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuKC6blNSczLLUIn27BK6Mh7OmsRT0e1T83z+ZqYHxiUUXIyeH
        hICJxNX/C9lBbCGB3YwS52bKQ8QlJaZdPMrcxcgBZAtLHD5c3MXIBVTyllHi7/x3LCA1wgKe
        Eltu97KBJEQErjJKfFh3hR3EYRZoYpFY/KObDWLqKyaJCS+ZQGw2AS2J/S9ugMX5BRQlrv54
        zAhi8wrYSVz//4QZxGYRUJVYfXsNmC0qECFxeMcsqBpBiZMzn4Bt5hSIlVjy7xbYHGYBdYk/
        8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5q
        uV5xYm5xaV66XnJ+7iZGcExrae5gvLwk/hCjAAejEg/vgbDuWCHWxLLiytxDjBIczEoivLNk
        umKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYDSdpOwy
        x0hfWNPhzOVeM6aSpeeeXBe5tG/D9/Ybi6L2m/56udkjNH39hxkMAXc4p6zbHLNGiWnmbIm/
        1xpcLF84m89ZV6c25fqcpX0Je2S/Fhx6Ict8pvmyWZ+p+Ak2/+k3szeJr478rVZ77Vjodvel
        a5VWzNkRJJ73p6zBv0h2+xrJl4ahIVlKLMUZiYZazEXFiQBwqsgE5QIAAA==
X-CMS-MailID: 20190926010159epcas1p13094a3dbd4ced250c61d06444e5a24a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924101141epcas4p357c10af190e97f1c77098cd66cb313ab
References: <cover.1569319738.git.leonard.crestez@nxp.com>
        <CGME20190924101141epcas4p357c10af190e97f1c77098cd66cb313ab@epcas4p3.samsung.com>
        <674fe91065034083fd7c8c1810305cd01551bb80.1569319738.git.leonard.crestez@nxp.com>
        <fe6845b9-4e20-3dad-0178-97b216e858e7@samsung.com>
        <VI1PR04MB70235A2C13E47029B3093D33EE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 26. 오전 5:55, Leonard Crestez wrote:
> On 25.09.2019 04:32, Chanwoo Choi wrote:
>> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
>>> Moving handling of min/max freq to a single function and call it from
>>> update_devfreq and for printing min/max freq values in sysfs.
>>>
>>> This changes the behavior of out-of-range min_freq/max_freq: clamping
>>> is now done at evaluation time. This means that if an out-of-range
>>> constraint is imposed by sysfs and it later becomes valid then it will
>>> be enforced.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>   drivers/devfreq/devfreq.c | 112 ++++++++++++++++++++++----------------
>>>   1 file changed, 64 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 4a878baa809e..eee403e70c84 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -96,10 +96,54 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>>>   		dev_pm_opp_put(opp);
>>>   
>>>   	return max_freq;
>>>   }
>>>   
>>> +/**
>>> + * get_freq_range() - Get the current freq range
>>> + * @devfreq:	the devfreq instance
>>> + * @min_freq:	the min frequency
>>> + * @max_freq:	the max frequency
>>> + *
>>> + * This takes into consideration all constraints.
>>> + */
>>> +static void get_freq_range(struct devfreq *devfreq,
>>> +			   unsigned long *min_freq,
>>> +			   unsigned long *max_freq)
>>> +{
>>> +	unsigned long *freq_table = devfreq->profile->freq_table;
>>> +
>>> +	lockdep_assert_held(&devfreq->lock);
>>> +
>>> +	/*
>>> +	 * Init min/max frequency from freq table.
>>
>> Init -> Initialize
>> min/max -> minimum/maximum
>>
>>> +	 * Drivers can initialize this in either ascending or descending order
>>
>> Drivers -> devfreq drivers
>>
>>> +	 * and devfreq core supports both.
>>> +	 */
>>
>>
>> In result, I prefer to change the comments as following:
>> 	/*
>> 	 * Initialize the minimum/maximum frequency from freq_table.
>>   	 * The devfreq drivers can initialize freq_table in either
>> 	 * ascending or descending order and devfreq core supports both.
>> 	 */
> 
> OK
> 
>>> +	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
>>> +		*min_freq = freq_table[0];
>>> +		*max_freq = freq_table[devfreq->profile->max_state - 1];
>>> +	} else {
>>> +		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>> +		*max_freq = freq_table[0];
>>> +	}
>>> +
>>> +	/* constraints from sysfs */
>>
>> 'constraints' -> Constraint because first verb have to be used
>> as the sigular verbs. Also, I think that have to enhance the comments
>> I prefer to use following comments:
>>
>> 	 /* Constraint minimum/maximum frequency from user input via sysfs */
>>
>>
>>
>>> +	*min_freq = max(*min_freq, devfreq->min_freq);
>>> +	*max_freq = min(*max_freq, devfreq->max_freq);
>>> +
>>> +	/* constraints from OPP interface */
>>
>> ditto. I prefer to use following comments:
>>
>> 	/* Constraint minimum/maximum frequency from OPP interface */
>>
>>
>>> +	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>>> +	/* scaling_max_freq can be zero on error */
>>
>> Please remove it.
>>
>>> +	if (devfreq->scaling_max_freq)
>>
>> As I knew, devfreq->scaling_max_freq is never zero.
>> So, it is always true. This if statement is needed.
> 
> It can happen if find_available_max_freq encounters an error when called 
> from devfreq_notifier_call.

If you are wondering this case, I think that have to fix
the possible issue on there instead of this point.

> 
> Maybe that should be separately fixed to set scaling_max_freq to a 
> neutral value such as "ULONG_MAX" instead?

OK.

> 
> BTW: the devfreq_notifier_call function returns -EINVAL on error but it 
> should return one of the NOTIFY_OK/DONE/STOP values instead. The OPP 
> framework ignores notifier results but (-EINVAL & NOTIFY_STOP) evaluates 
> as true so other notifiers will be skipped unintentionally.

I agree. It is needed to fix the return value type.

> 
>>> +		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
>>> +
>>> +	/* max_freq takes precedence over min_freq */
>>
>> As I said, almost people know that min_freq have be under than max_freq.
>> Please remove it. And until finishing the discussion on mailing list,
>> please don't send the next version. If you just replied from my comment
>> and then wait my next comment, we can save the time without replying
>> the repetitive and same comment for same point.
> 
> This series makes it possible to set a min_freq higher than max_freq 
> (for example via PM QoS from various devices).
> 
> It is not obvious that min_freq takes precedence over max_freq but the 
> code is self-evident so I will remove the comment.
> 
>>> +	if (*min_freq > *max_freq)
>>> +		*min_freq = *max_freq;
>>> +}
>>> +
>>>   /**
>>>    * devfreq_get_freq_level() - Lookup freq_table for the frequency
>>>    * @devfreq:	the devfreq instance
>>>    * @freq:	the target frequency
>>>    */
>>> @@ -349,20 +393,11 @@ int update_devfreq(struct devfreq *devfreq)
>>>   
>>>   	/* Reevaluate the proper frequency */
>>>   	err = devfreq->governor->get_target_freq(devfreq, &freq);
>>>   	if (err)
>>>   		return err;
>>> -
>>> -	/*
>>> -	 * Adjust the frequency with user freq, QoS and available freq.
>>> -	 *
>>> -	 * List from the highest priority
>>> -	 * max_freq
>>> -	 * min_freq
>>> -	 */
>>> -	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
>>> -	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
>>> +	get_freq_range(devfreq, &min_freq, &max_freq);
>>>   
>>>   	if (freq < min_freq) {
>>>   		freq = min_freq;
>>>   		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>>>   	}
>>> @@ -1298,40 +1333,28 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>   	ret = sscanf(buf, "%lu", &value);
>>>   	if (ret != 1)
>>>   		return -EINVAL;
>>>   
>>>   	mutex_lock(&df->lock);
>>> -
>>> -	if (value) {
>>> -		if (value > df->max_freq) {
>>> -			ret = -EINVAL;
>>> -			goto unlock;
>>> -		}
>>> -	} else {
>>> -		unsigned long *freq_table = df->profile->freq_table;
>>> -
>>> -		/* Get minimum frequency according to sorting order */
>>> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
>>> -			value = freq_table[0];
>>> -		else
>>> -			value = freq_table[df->profile->max_state - 1];
>>> -	}
>>> -
>>>   	df->min_freq = value;
>>>   	update_devfreq(df);
>>> -	ret = count;
>>> -unlock:
>>>   	mutex_unlock(&df->lock);
>>> -	return ret;
>>> +
>>> +	return count;
>>>   }
>>>   
>>>   static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>>>   			     char *buf)
>>>   {
>>>   	struct devfreq *df = to_devfreq(dev);
>>> +	unsigned long min_freq, max_freq;
>>> +
>>> +	mutex_lock(&df->lock);
>>> +	get_freq_range(df, &min_freq, &max_freq);
>>> +	mutex_unlock(&df->lock);
>>>   
>>> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
>>> +	return sprintf(buf, "%lu\n", min_freq);
>>>   }
>>>   
>>>   static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>   			      const char *buf, size_t count)
>>>   {
>>> @@ -1343,40 +1366,33 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>   	if (ret != 1)
>>>   		return -EINVAL;
>>>   
>>>   	mutex_lock(&df->lock);
>>>   
>>> -	if (value) {
>>> -		if (value < df->min_freq) {
>>> -			ret = -EINVAL;
>>> -			goto unlock;
>>> -		}
>>> -	} else {
>>> -		unsigned long *freq_table = df->profile->freq_table;
>>> -
>>> -		/* Get maximum frequency according to sorting order */
>>> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
>>> -			value = freq_table[df->profile->max_state - 1];
>>> -		else
>>> -			value = freq_table[0];
>>> -	}
>>> +	/* Interpret zero as "don't care" */
>>
>> Please remove it. Also, the detailed comment for user have to add
>> the documentation file.
> 
> OK
> 
>>
>>> +	if (!value)
>>> +		value = ULONG_MAX;
>>>   
>>>   	df->max_freq = value;
>>>   	update_devfreq(df);
>>> -	ret = count;
>>> -unlock:
>>>   	mutex_unlock(&df->lock);
>>> -	return ret;
>>> +
>>> +	return count;
>>>   }
>>>   static DEVICE_ATTR_RW(min_freq);
>>>   
>>>   static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>>>   			     char *buf)
>>>   {
>>>   	struct devfreq *df = to_devfreq(dev);
>>> +	unsigned long min_freq, max_freq;
>>> +
>>> +	mutex_lock(&df->lock);
>>> +	get_freq_range(df, &min_freq, &max_freq);
>>> +	mutex_unlock(&df->lock);
>>>   
>>> -	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
>>> +	return sprintf(buf, "%lu\n", max_freq);
>>>   }
>>>   static DEVICE_ATTR_RW(max_freq);
>>>   
>>>   static ssize_t available_frequencies_show(struct device *d,
>>>   					  struct device_attribute *attr,


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
