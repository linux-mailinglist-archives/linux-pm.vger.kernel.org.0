Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DDBBFCEB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 03:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfI0By2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Sep 2019 21:54:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54431 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfI0By2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2019 21:54:28 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190927015424epoutp01d5f96829a72249ebe70e1a4b112507df~IKL2EO-BJ3126631266epoutp01W
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 01:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190927015424epoutp01d5f96829a72249ebe70e1a4b112507df~IKL2EO-BJ3126631266epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569549264;
        bh=oTIs5jhpV0cZGp+SP62iHX4U9IeVKU9t20jX+zjQj2g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OaHJTEqM5Sc6EDwMKjWSo01QgiqRyK/4UfrKLls9iHti4F/KTwp5RyNIDogxKH0i2
         9R6148xVKLbho+WjLsNl6otJM0y7PQu7YNNKWGWYiaALwsDQrkjG7REy46XMb9TZu9
         CvBYUR81ps/B0tyxT2PmYDMbtqVpEjNBDT/nypCU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190927015423epcas1p3ed36e789fb7d12f68dff88f6ad8261dd~IKL1bEaI20231702317epcas1p3p;
        Fri, 27 Sep 2019 01:54:23 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46fZbd5d8fzMqYlr; Fri, 27 Sep
        2019 01:54:21 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.DF.04135.ACB6D8D5; Fri, 27 Sep 2019 10:54:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190927015418epcas1p4b17b57935588d2677d32bda3eeba7d99~IKLwLFKbm2215422154epcas1p4j;
        Fri, 27 Sep 2019 01:54:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190927015418epsmtrp174af30536079716a6ac7eaa8ceb153a3~IKLwKF0Bv2177321773epsmtrp1U;
        Fri, 27 Sep 2019 01:54:18 +0000 (GMT)
X-AuditID: b6c32a36-7fbff70000001027-e4-5d8d6bcacdbe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.2E.03889.ACB6D8D5; Fri, 27 Sep 2019 10:54:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190927015417epsmtip25764ed72c1e8f6b56cc0b7df031ebaed~IKLvvyAym1320013200epsmtip2u;
        Fri, 27 Sep 2019 01:54:17 +0000 (GMT)
Subject: Re: [PATCH v8 6/6] PM / devfreq: Use PM QoS for sysfs min/max_freq
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <824e3297-e41e-c33c-2c24-26d6c02e84ed@samsung.com>
Date:   Fri, 27 Sep 2019 10:58:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926160445.GO133864@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmvu6p7N5Yg42rNCwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyMw5c+8Zc8D6yomGNYQNji2cXIyeHhICJROukNqYuRi4OIYEd
        jBLvX75ihnA+MUocf7iMEcL5xiix5X8XO0zL8icz2SESexklJsyexwrhvGeUeNbdxAxSJSzg
        LbHp/xw2EFtEQEPiye/zYKOYBZ6zSKzrPwE2ik1AS2L/ixtgRfwCihJXfzxmBLF5Bewk3t5+
        ztLFyMHBIqAqsfGjJkhYVCBC4tODw6wQJYISJ2c+YQGxOQUMJY58Ww+2l1lAXOLWk/lMELa8
        RPPW2WD/SAicYpf4u3sj1AsuElf+vGSBsIUlXh3fAhWXknjZ3wZlV0usPHmEDaK5A+j//RdY
        IRLGEvuXTmYCOY5ZQFNi/S59iLCixM7fcxkhFvNJvPvawwpSIiHAK9HRJgRRoixx+cFdJghb
        UmJxeyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwIj5NjexAhO5FpmOxgXnfM5
        xCjAwajEwztjVU+sEGtiWXFl7iFGCQ5mJRFe30igEG9KYmVValF+fFFpTmrxIUZTYGBPZJYS
        Tc4HZpm8knhDUyNjY2MLE0MzU0NDJXFe9/SGWCGB9MSS1OzU1ILUIpg+Jg5OqQbGnNtPJogx
        O1X2KjPmrDAo+u3otkp+rqvV9ekW9dd3Lq5xk5G4u7VTpC08TbfZdMZt5klPzINqF2YZrzJ5
        5W+x0uvdD9Vbv1bvv/GxeJvnwq/bvW7qVna9zWv79O+gzqL3t2R71TOk64Mz3EMNKt15rkZe
        i/I/lCgoomFUFSJxeXqVurfgekclluKMREMt5qLiRACobbee+gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSvO6p7N5Yg4MT2SwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUVw2Kak5mWWpRfp2CVwZB659Yy54H1nRsMawgbHFs4uRk0NC
        wERi+ZOZ7F2MXBxCArsZJWZOfs4IkZCUmHbxKHMXIweQLSxx+HAxRM1bRolrF5cwg9QIC3hL
        bPo/hw3EFhHQkHjy+zxYL7PAaxaJvrMaEA2zmCWet58EK2IT0JLY/+IGmM0voChx9cdjsAZe
        ATuJt7efs4AsYxFQldj4URMkLCoQIXF4xyyoEkGJkzOfsIDYnAKGEke+rWeG2KUu8WfeJShb
        XOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswt
        Ls1L10vOz93ECI5nLa0djCdOxB9iFOBgVOLhnbGqJ1aINbGsuDL3EKMEB7OSCK9vJFCINyWx
        siq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMHp1QD49Lnb1ZLWL1TtGSd
        G1aS47Di4AHGea7/w4tld3FMEO2e2rqnNVlGnX3f3y2mUeUqc3Jv+H3MsAh4wRnSaSd0xqV6
        qt5rq+hnf+R/L/m2/Fs4o9pF3lMLXP/ayn3YOS/VOzfii0XozeWiO+KTracWrAy+zvG6XPz/
        8sDQaSzZBbNLr/mdfZ/1TomlOCPRUIu5qDgRAIXCTyLjAgAA
X-CMS-MailID: 20190927015418epcas1p4b17b57935588d2677d32bda3eeba7d99
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
        <20190925164513.GM133864@google.com>
        <81b136fc-0613-08f8-cb26-6243e7be621b@samsung.com>
        <20190926160445.GO133864@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 27. 오전 1:04, Matthias Kaehlcke wrote:
> On Thu, Sep 26, 2019 at 10:25:41AM +0900, Chanwoo Choi wrote:
>> On 19. 9. 26. 오전 1:45, Matthias Kaehlcke wrote:
>>> On Wed, Sep 25, 2019 at 11:41:07AM +0900, Chanwoo Choi wrote:
>>>> On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
>>>>> Switch the handling of min_freq and max_freq from sysfs to use the
>>>>> dev_pm_qos_request interface.
>>>>>
>>>>> Since PM QoS handles frequencies as kHz this change reduces the
>>>>> precision of min_freq and max_freq. This shouldn't introduce problems
>>>>> because frequencies which are not an integer number of kHz are likely
>>>>> not an integer number of Hz either.
>>>>>
>>>>> Try to ensure compatibility by rounding min values down and rounding
>>>>> max values up.
>>>>>
>>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>> ---
>>>>>  drivers/devfreq/devfreq.c | 46 ++++++++++++++++++++++++---------------
>>>>>  include/linux/devfreq.h   |  9 ++++----
>>>>>  2 files changed, 33 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index 784f3e40536a..8bb7efd821ab 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -137,14 +137,10 @@ static void get_freq_range(struct devfreq *devfreq,
>>>>>  	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>>>  					     DEV_PM_QOS_MIN_FREQUENCY);
>>>>>  	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>>>>>  	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>>>>>  
>>>>> -	/* constraints from sysfs */
>>>>> -	*min_freq = max(*min_freq, devfreq->min_freq);
>>>>> -	*max_freq = min(*max_freq, devfreq->max_freq);
>>>>> -
>>>>>  	/* constraints from OPP interface */
>>>>>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>>>>>  	/* scaling_max_freq can be zero on error */
>>>>>  	if (devfreq->scaling_max_freq)
>>>>>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
>>>>> @@ -679,10 +675,12 @@ static void devfreq_dev_release(struct device *dev)
>>>>>  			DEV_PM_QOS_MIN_FREQUENCY);
>>>>>  
>>>>>  	if (devfreq->profile->exit)
>>>>>  		devfreq->profile->exit(devfreq->dev.parent);
>>>>>  
>>>>> +	dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
>>>>> +	dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
>>>>
>>>> Please check the return value if error happen, just print the err with dev_err()
>>>> without stopping the release steps.
>>>
>>> I wonder if dev_warn() would be more appropriate, since the current operation
>>> is not aborted.
>>>
>>>>>  	kfree(devfreq->time_in_state);
>>>>>  	kfree(devfreq->trans_table);
>>>>>  	mutex_destroy(&devfreq->lock);
>>>>>  	kfree(devfreq);
>>>>>  }
>>>>> @@ -747,18 +745,25 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>>>>>  	if (!devfreq->scaling_min_freq) {
>>>>>  		err = -EINVAL;
>>>>>  		goto err_dev;
>>>>>  	}
>>>>> -	devfreq->min_freq = devfreq->scaling_min_freq;
>>>>>  
>>>>>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>>>>>  	if (!devfreq->scaling_max_freq) {
>>>>>  		err = -EINVAL;
>>>>>  		goto err_dev;
>>>>>  	}
>>>>> -	devfreq->max_freq = devfreq->scaling_max_freq;
>>>>> +
>>>>> +	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
>>>>> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
>>>>> +	if (err < 0)
>>>>> +		goto err_dev;
>>>>> +	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
>>>>> +				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
>>>>> +	if (err < 0)
>>>>> +		goto err_dev;
>>>>>  
>>>>>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>>>>  	atomic_set(&devfreq->suspend_count, 0);
>>>>>  
>>>>>  	devfreq->trans_table = kzalloc(
>>>>> @@ -843,10 +848,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>  err_dev:
>>>>>  	/*
>>>>>  	 * Cleanup path for errors that happen before registration.
>>>>>  	 * Otherwise we rely on devfreq_dev_release.
>>>>>  	 */
>>>>> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
>>>>> +		dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
>>>>
>>>> Please check the return value if error happen, just print the err with dev_err()
>>>> without stopping the release steps.
>>>>
>>>> 	dev_err(... "failed to remove request of DEV_PM_QOS_MAX_FREQUENCY\n");
>>>
>>> dev_warn() for the same reason as above?
>>
>> Actually, I think that is not critical error but need to print the error
>> So, I think that dev_err() is enough. If this thing is critical,
>> better to use dev_warn.
> 
> We agree that this is not critical, but not when to use dev_err()
> and dev_warn(). You seem to imply that dev_warn() is more severe
> than dev_err(), however it's the other way around:
> 
> #define KERN_ERR        KERN_SOH "3"    /* error conditions */
> #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
> #define KERN_NOTICE     KERN_SOH "5"    /* normal but significant condition */
> 
> I think in this case you can go either way, it's certainly an error,
> but the driver continues with the normal execution path.

I agree to use dev_warn. Thanks for detailed explanation.

> 
>>>
>>> I think the message would be better with a slight change:
>>>
>>> "failed to remove DEV_PM_QOS_MAX_FREQUENCY request\n"
>>
>> OK.
>>
>>>
>>>>
>>>>> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
>>>>> +		dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
>>>> 	
>>>> 	dev_err(... "failed to remove request of DEV_PM_QOS_MIN_FREQUENCY\n");
>>>
>>> ditto
>>>
>>>>>  	kfree(devfreq->time_in_state);
>>>>>  	kfree(devfreq->trans_table);
>>>>>  	kfree(devfreq);
>>>>>  err_out:
>>>>>  	return ERR_PTR(err);
>>>>> @@ -1407,14 +1416,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>  
>>>>>  	ret = sscanf(buf, "%lu", &value);
>>>>>  	if (ret != 1)
>>>>>  		return -EINVAL;
>>>>>  
>>>>> -	mutex_lock(&df->lock);
>>>>> -	df->min_freq = value;
>>>>> -	update_devfreq(df);
>>>>> -	mutex_unlock(&df->lock);
>>>>> +	/* round down to kHz for PM QoS */
>>>>
>>>> I prefer more detailed description as following:
>>>>
>>>> 	/*
>>>> 	 * Round down to KHz to decide the proper minimum frequency
>>>
>>> it should be kHz, with a lower-case 'k', as in the original comment.
>>
>> Good.
>>
>>>
>>>> 	 * which is closed to user request.
>>>>  	 */
>>>
>>> The comment you suggest doesn't provide any information about why the
>>> conversion to kHz is done, in this sense the original comment that
>>> mentions PM QoS provides more value.
>>>
>>> With whatever we end up, I suggest to use 'convert' instead of
>>> 'round down'.
>>
>> I agree to use 'convert' instead of 'round down'
>> if some expression indicates the correct meaning.
>>
>>>
>>>>> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
>>>>> +					value / HZ_PER_KHZ);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>>  
>>>>>  	return count;
>>>>>  }
>>>>>  
>>>>>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>>>>> @@ -1439,19 +1449,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>  
>>>>>  	ret = sscanf(buf, "%lu", &value);
>>>>>  	if (ret != 1)
>>>>>  		return -EINVAL;
>>>>>  
>>>>> -	mutex_lock(&df->lock);
>>>>> -
>>>>> -	/* Interpret zero as "don't care" */
>>>>> -	if (!value)
>>>>> -		value = ULONG_MAX;
>>>>> +	/* round up to kHz for PM QoS and interpret zero as "don't care" */
>>>>
>>>> I think that "don't care" comment style is not good.
>>>>
>>>> I referred to the Documentation/ABI/testing/sysfs-class-devfreq file.
>>>> I prefer more detailed description as following:
>>>> 	/*
>>>> 	 * Round up to KHz to decide the proper maximum frequency
>>>
>>> kHz
>>>
>>>> 	 * which is closed to user request. If value is zero,
>>>> 	 * the user does not care.
>>>
>>> "the user does not care" is still very casual you didn't like initially.
>>> How about "A value of zero is interpreted as 'no limit'."?
>>>
>>> As for the min freq, I think PM QoS should be mentioned to make clear why
>>> the conversion to kHz is needed.
>>
>> Agree. I expect that Leonard will mention that.
>>
>>>
>>>>  	 */
>>>>
>>>>
>>>>> +	if (value)
>>>>> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
>>>>> +	else
>>>>> +		value = S32_MAX;
>>>>>  
>>>>> -	df->max_freq = value;
>>>>> -	update_devfreq(df);
>>>>> -	mutex_unlock(&df->lock);
>>>>> +	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>>  
>>>>>  	return count;
>>>>>  }
>>>>>  static DEVICE_ATTR_RW(min_freq);
>>>>>  
>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>> index dac0dffeabb4..7849fe4c666d 100644
>>>>> --- a/include/linux/devfreq.h
>>>>> +++ b/include/linux/devfreq.h
>>>>> @@ -11,10 +11,11 @@
>>>>>  #define __LINUX_DEVFREQ_H__
>>>>>  
>>>>>  #include <linux/device.h>
>>>>>  #include <linux/notifier.h>
>>>>>  #include <linux/pm_opp.h>
>>>>> +#include <linux/pm_qos.h>
>>>>>  
>>>>>  #define DEVFREQ_NAME_LEN 16
>>>>>  
>>>>>  /* DEVFREQ governor name */
>>>>>  #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
>>>>> @@ -121,12 +122,12 @@ struct devfreq_dev_profile {
>>>>>   *		devfreq.nb to the corresponding register notifier call chain.
>>>>>   * @work:	delayed work for load monitoring.
>>>>>   * @previous_freq:	previously configured frequency value.
>>>>>   * @data:	Private data of the governor. The devfreq framework does not
>>>>>   *		touch this.
>>>>> - * @min_freq:	Limit minimum frequency requested by user (0: none)
>>>>> - * @max_freq:	Limit maximum frequency requested by user (0: none)
>>>>> + * @user_min_freq_req:	PM QoS min frequency request from user (via sysfs)
>>>>
>>>> min -> minimum and then remove parenthesis as following:
>>>> 	PM QoS minimum frequency request by user via sysfs
>>>>
>>>>> + * @user_max_freq_req:	PM QoS max frequency request from user (via sysfs)
>>>>
>>>> ditto. max -> maximum
>>>> 	PM QoS maximum frequency request by user via sysfs
>>>>
>>>>>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>>>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>>>   * @stop_polling:	 devfreq polling status of a device.
>>>>>   * @suspend_freq:	 frequency of a device set during suspend phase.
>>>>>   * @resume_freq:	 frequency of a device set in resume phase.
>>>>> @@ -161,12 +162,12 @@ struct devfreq {
>>>>>  	unsigned long previous_freq;
>>>>>  	struct devfreq_dev_status last_status;
>>>>>  
>>>>>  	void *data; /* private data for governors */
>>>>>  
>>>>> -	unsigned long min_freq;
>>>>> -	unsigned long max_freq;
>>>>> +	struct dev_pm_qos_request user_min_freq_req;
>>>>> +	struct dev_pm_qos_request user_max_freq_req;
>>>>>  	unsigned long scaling_min_freq;
>>>>>  	unsigned long scaling_max_freq;
>>>>>  	bool stop_polling;
>>>>>  
>>>>>  	unsigned long suspend_freq;
>>>>>
>>>>
>>>>
>>>> -- 
>>>> Best Regards,
>>>> Chanwoo Choi
>>>> Samsung Electronics
>>>
>>>
>>
>>
>> -- 
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
