Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D18BEA01
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2019 03:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfIZBVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 21:21:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25706 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfIZBVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 21:21:08 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190926012102epoutp03c40c4ccdf735db95a0450530151c907a~H2FbYWYMA1843818438epoutp03X
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2019 01:21:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190926012102epoutp03c40c4ccdf735db95a0450530151c907a~H2FbYWYMA1843818438epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569460862;
        bh=cm88/wbEsdELV6/DGPsnqb/EqXyjKyHvpbmMUKU3qcc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LxFr8O65Kul0sEnt+M83wfFV0H39f//7Is0yl+AEDAnuCfEx0pvhn5VbiN8U+ZRB0
         e1LXL+cRN1LaYSgkF0+6Xb7a5fALoi+V+VIQMVf+Hz0WTjn8KX2n+L+azwTlNTbhWA
         lcvWSkbjalfvAqhoPJMnIujW7+dpO1EpOlcr+WnM=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190926012102epcas1p4fae9fd51f64656beb49be9f74645a9e4~H2Fa1tNLD1486114861epcas1p4s;
        Thu, 26 Sep 2019 01:21:02 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46dxvb3FMZzMqYkd; Thu, 26 Sep
        2019 01:20:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.E0.04135.B721C8D5; Thu, 26 Sep 2019 10:20:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190926012059epcas1p15dbac986a9c237de45d4ac8fd6ba0681~H2FYEZKaA3166631666epcas1p1r;
        Thu, 26 Sep 2019 01:20:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926012059epsmtrp2510519fdd37d3da4636d6406393e0381~H2FYDcoj31264812648epsmtrp2I;
        Thu, 26 Sep 2019 01:20:59 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-b8-5d8c127bf2f7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.FE.03889.A721C8D5; Thu, 26 Sep 2019 10:20:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190926012058epsmtip28a5842e98ad4015d79ba3cce17fe2dc7~H2FX0a-er0166801668epsmtip2C;
        Thu, 26 Sep 2019 01:20:58 +0000 (GMT)
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
Message-ID: <81b136fc-0613-08f8-cb26-6243e7be621b@samsung.com>
Date:   Thu, 26 Sep 2019 10:25:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925164513.GM133864@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmvm61UE+swdp1ohaHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWF
        vMTcVFslF58AXbfMHKBHlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5
        xaV56XrJ+blWhgYGRqZAhQnZGU33drAUtPtXbPn+kqWB8ZJ9FyMnh4SAicSLZ5/Yuhi5OIQE
        djBKdH9fwgaSEBL4xCix92AaROIbo8SOKV+YYDoeLb7LCJHYyyix7cV1qPb3jBIXL21kBakS
        FvCW2PR/DtgoEQENiSe/z4N1MAs8Z5FY13+CHSTBJqAlsf/FDbAifgFFias/HjOC2LwCdhKP
        X2wDi7MIqErMbW1jBrFFBSIkPj04zApRIyhxcuYTFhCbU8BQYsHDs2C9zALiEreezGeCsOUl
        mrfOZgZZLCFwjl3i9o3bbBA/uEhMmtvICGELS7w6voUdwpaS+PxuL1RNtcTKk0fYIJo7GCW2
        7L/ACpEwlti/dDLQBg6gDZoS63fpQ4QVJXb+ngt1BJ/Eu689rCAlEgK8Eh1tQhAlyhKXH9yF
        BqOkxOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBUbI0b2JEZzKtcx2MC46
        53OIUYCDUYmH90BYd6wQa2JZcWXuIUYJDmYlEd5ZMl2xQrwpiZVVqUX58UWlOanFhxhNgaE9
        kVlKNDkfmGfySuINTY2MjY0tTAzNTA0NlcR53dMbYoUE0hNLUrNTUwtSi2D6mDg4pRoY45dN
        fimyyLgz7MbEjd6aC59u+MMY9aB29t+A3YsFig7LKHy93RdTee6Q7e+w58E/3XY1X55zzs9E
        7/KCstkPDx95Pa9Loq/QaJPrF7MZH+a3Kz1P4lv5u1S4WXYf1+kpu11WvPnnFxLDJlu0VfD0
        krXfHwinFuqxZ3udconLPfkv6m6yvLDtRSWW4oxEQy3mouJEACLSz5f7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvG61UE+swclQi0PHtrJbfD19itFi
        2aWjjBbT925iszh/fgO7xdmmN+wWtxpkLFbc/chqsenxNVaLrl8rmS0+9x5htPi84TGjxe3G
        FWwWq88dZLPoOvSXzWLjVw8HAY/3N1rZPWY3XGTxWLCp1GPTqk42jzvX9rB5bF5S77Hx3Q4m
        j4Pv9jB59G1ZxejxeZNcAFcUl01Kak5mWWqRvl0CV0bTvR0sBe3+FVu+v2RpYLxk38XIySEh
        YCLxaPFdxi5GLg4hgd2MEhMOvWKHSEhKTLt4lLmLkQPIFpY4fLgYouYto8TxhnNMIDXCAt4S
        m/7PYQOxRQQ0JJ78Ps8IYjMLvGaR6DurAdGwj0niyJTXYEPZBLQk9r+4AdbAL6AocfXHY7AG
        XgE7iccvtoHFWQRUJea2tjGD2KICERKHd8yCqhGUODnzCQuIzSlgKLHg4VmoZeoSf+ZdYoaw
        xSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc
        4tK8dL3k/NxNjOCI1tLawXjiRPwhRgEORiUeXonI7lgh1sSy4srcQ4wSHMxKIryzZLpihXhT
        EiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTBqLVm8V770t0vF
        3Prgqfx9v8TXO6UH/txkxe+eW98WGi91/jb3iXz16s/23momPv8dck4zPRAMOPFh/cMZ6dJK
        x4Tlf8js9OhZJjf9WvxW609Xn+63nfdkgWI1U+yaqz2z5M6sTPGdvv54Vubu854TVkhHTttW
        3Z/U9LL22ZPLme+9eo42XxdVYinOSDTUYi4qTgQADkRJCOQCAAA=
X-CMS-MailID: 20190926012059epcas1p15dbac986a9c237de45d4ac8fd6ba0681
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 26. 오전 1:45, Matthias Kaehlcke wrote:
> On Wed, Sep 25, 2019 at 11:41:07AM +0900, Chanwoo Choi wrote:
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
>>>  drivers/devfreq/devfreq.c | 46 ++++++++++++++++++++++++---------------
>>>  include/linux/devfreq.h   |  9 ++++----
>>>  2 files changed, 33 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 784f3e40536a..8bb7efd821ab 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -137,14 +137,10 @@ static void get_freq_range(struct devfreq *devfreq,
>>>  	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>>>  					     DEV_PM_QOS_MIN_FREQUENCY);
>>>  	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>>>  	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>>>  
>>> -	/* constraints from sysfs */
>>> -	*min_freq = max(*min_freq, devfreq->min_freq);
>>> -	*max_freq = min(*max_freq, devfreq->max_freq);
>>> -
>>>  	/* constraints from OPP interface */
>>>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>>>  	/* scaling_max_freq can be zero on error */
>>>  	if (devfreq->scaling_max_freq)
>>>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
>>> @@ -679,10 +675,12 @@ static void devfreq_dev_release(struct device *dev)
>>>  			DEV_PM_QOS_MIN_FREQUENCY);
>>>  
>>>  	if (devfreq->profile->exit)
>>>  		devfreq->profile->exit(devfreq->dev.parent);
>>>  
>>> +	dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
>>> +	dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
>>
>> Please check the return value if error happen, just print the err with dev_err()
>> without stopping the release steps.
> 
> I wonder if dev_warn() would be more appropriate, since the current operation
> is not aborted.
> 
>>>  	kfree(devfreq->time_in_state);
>>>  	kfree(devfreq->trans_table);
>>>  	mutex_destroy(&devfreq->lock);
>>>  	kfree(devfreq);
>>>  }
>>> @@ -747,18 +745,25 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>>>  	if (!devfreq->scaling_min_freq) {
>>>  		err = -EINVAL;
>>>  		goto err_dev;
>>>  	}
>>> -	devfreq->min_freq = devfreq->scaling_min_freq;
>>>  
>>>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>>>  	if (!devfreq->scaling_max_freq) {
>>>  		err = -EINVAL;
>>>  		goto err_dev;
>>>  	}
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
>>>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>>  	atomic_set(&devfreq->suspend_count, 0);
>>>  
>>>  	devfreq->trans_table = kzalloc(
>>> @@ -843,10 +848,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  err_dev:
>>>  	/*
>>>  	 * Cleanup path for errors that happen before registration.
>>>  	 * Otherwise we rely on devfreq_dev_release.
>>>  	 */
>>> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
>>> +		dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
>>
>> Please check the return value if error happen, just print the err with dev_err()
>> without stopping the release steps.
>>
>> 	dev_err(... "failed to remove request of DEV_PM_QOS_MAX_FREQUENCY\n");
> 
> dev_warn() for the same reason as above?

Actually, I think that is not critical error but need to print the error
So, I think that dev_err() is enough. If this thing is critical,
better to use dev_warn.

> 
> I think the message would be better with a slight change:
> 
> "failed to remove DEV_PM_QOS_MAX_FREQUENCY request\n"

OK.

> 
>>
>>> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
>>> +		dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
>> 	
>> 	dev_err(... "failed to remove request of DEV_PM_QOS_MIN_FREQUENCY\n");
> 
> ditto
> 
>>>  	kfree(devfreq->time_in_state);
>>>  	kfree(devfreq->trans_table);
>>>  	kfree(devfreq);
>>>  err_out:
>>>  	return ERR_PTR(err);
>>> @@ -1407,14 +1416,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>  
>>>  	ret = sscanf(buf, "%lu", &value);
>>>  	if (ret != 1)
>>>  		return -EINVAL;
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
> 
> it should be kHz, with a lower-case 'k', as in the original comment.

Good.

> 
>> 	 * which is closed to user request.
>>  	 */
> 
> The comment you suggest doesn't provide any information about why the
> conversion to kHz is done, in this sense the original comment that
> mentions PM QoS provides more value.
> 
> With whatever we end up, I suggest to use 'convert' instead of
> 'round down'.

I agree to use 'convert' instead of 'round down'
if some expression indicates the correct meaning.

> 
>>> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
>>> +					value / HZ_PER_KHZ);
>>> +	if (ret < 0)
>>> +		return ret;
>>>  
>>>  	return count;
>>>  }
>>>  
>>>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>>> @@ -1439,19 +1449,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>  
>>>  	ret = sscanf(buf, "%lu", &value);
>>>  	if (ret != 1)
>>>  		return -EINVAL;
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
> 
> kHz
> 
>> 	 * which is closed to user request. If value is zero,
>> 	 * the user does not care.
> 
> "the user does not care" is still very casual you didn't like initially.
> How about "A value of zero is interpreted as 'no limit'."?
> 
> As for the min freq, I think PM QoS should be mentioned to make clear why
> the conversion to kHz is needed.

Agree. I expect that Leonard will mention that.

> 
>>  	 */
>>
>>
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
>>>  	return count;
>>>  }
>>>  static DEVICE_ATTR_RW(min_freq);
>>>  
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index dac0dffeabb4..7849fe4c666d 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -11,10 +11,11 @@
>>>  #define __LINUX_DEVFREQ_H__
>>>  
>>>  #include <linux/device.h>
>>>  #include <linux/notifier.h>
>>>  #include <linux/pm_opp.h>
>>> +#include <linux/pm_qos.h>
>>>  
>>>  #define DEVFREQ_NAME_LEN 16
>>>  
>>>  /* DEVFREQ governor name */
>>>  #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
>>> @@ -121,12 +122,12 @@ struct devfreq_dev_profile {
>>>   *		devfreq.nb to the corresponding register notifier call chain.
>>>   * @work:	delayed work for load monitoring.
>>>   * @previous_freq:	previously configured frequency value.
>>>   * @data:	Private data of the governor. The devfreq framework does not
>>>   *		touch this.
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
>>
>>>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>   * @stop_polling:	 devfreq polling status of a device.
>>>   * @suspend_freq:	 frequency of a device set during suspend phase.
>>>   * @resume_freq:	 frequency of a device set in resume phase.
>>> @@ -161,12 +162,12 @@ struct devfreq {
>>>  	unsigned long previous_freq;
>>>  	struct devfreq_dev_status last_status;
>>>  
>>>  	void *data; /* private data for governors */
>>>  
>>> -	unsigned long min_freq;
>>> -	unsigned long max_freq;
>>> +	struct dev_pm_qos_request user_min_freq_req;
>>> +	struct dev_pm_qos_request user_max_freq_req;
>>>  	unsigned long scaling_min_freq;
>>>  	unsigned long scaling_max_freq;
>>>  	bool stop_polling;
>>>  
>>>  	unsigned long suspend_freq;
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
