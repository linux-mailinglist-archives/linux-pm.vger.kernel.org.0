Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F73BD66A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411397AbfIYCgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 22:36:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:35861 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389764AbfIYCgv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 22:36:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190925023647epoutp0485f6d3559584789338c02b78fb946d54~HjeR9HiSA2178421784epoutp04X
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 02:36:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190925023647epoutp0485f6d3559584789338c02b78fb946d54~HjeR9HiSA2178421784epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569379007;
        bh=ixSJ+t+rOXxl2U2U22Cm17tP1wruhompX1IDfduWXSE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DLEJyLiThSfQMY3jHNfqnR5zdsAs1ENE05zRxlby/GonUXtmXg3hKaEGJzlAGYdLJ
         czstQPYkbmIQMruwcJnVguJBgEhS+LoLCzjI9v9UBmAHFF7ZjNUJ8jUjy8gikZcBYj
         cXUJ/tQ964BwsGi5zz/JEQWlfjRIh5MFG8aHEwps=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925023646epcas1p191a942ef6718320e06bb981fef3f9e24~HjeRQJODr0336003360epcas1p19;
        Wed, 25 Sep 2019 02:36:46 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46dMdS1HPzzMqYlr; Wed, 25 Sep
        2019 02:36:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.96.04144.CB2DA8D5; Wed, 25 Sep 2019 11:36:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190925023643epcas1p3b8c185c16a093ea18b3c2981e42d303e~HjeOOr0N30288402884epcas1p3M;
        Wed, 25 Sep 2019 02:36:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925023643epsmtrp1b8f6c7b2793d147d92471dc486d04963~HjeONxj2S0154201542epsmtrp1y;
        Wed, 25 Sep 2019 02:36:43 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-2f-5d8ad2bc132d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.7B.04081.BB2DA8D5; Wed, 25 Sep 2019 11:36:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925023643epsmtip2e0152512d85a80522dbcb323712b5d09~HjeN1PJkj2945629456epsmtip29;
        Wed, 25 Sep 2019 02:36:43 +0000 (GMT)
Subject: Re: [PATCH v8 6/6] PM / devfreq: Use PM QoS for sysfs min/max_freq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
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
Message-ID: <c521989f-51b6-84eb-b4f1-c4469494345e@samsung.com>
Date:   Wed, 25 Sep 2019 11:41:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3eb8a1d1e7d738f7599d54348d6b474196581693.1569319738.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmru6eS12xBj1/OSwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi84bHjBa3
        G1ewWaw+d5DNouvQXzaLjV89HAQ83t9oZfeY3XCRxWPBplKPTas62TzuXNvD5rF5Sb3Hxnc7
        mDwOvtvD5NG3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCPKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyM878b2YraHeueH1lBXsD4wrjLkZODgkBE4mP3xYxdzFycQgJ
        7GCUONu5hRXC+cQo8fTDBhYI5xujxP0v99hhWlp3TmSCSOxllDj5/S4bhPOeUeLTnK0sIFXC
        At4Sm/7PAUuICKxmlGhZeocRJMEs8IRZYs96eRCbTUBLYv+LG2wgNr+AosTVH4/BangF7CSm
        XtsFFmcRUJXYtvclM4gtKhAh8enBYVaIGkGJkzOfgC3jFIiT+D7hLjvEfHGJW0/mM0HY8hLN
        W2czQ5x9iV1iXYsQhO0i0fjvMiuELSzx6vgWqNekJF72t0HZ1RIrTx4Be0BCoINRYsv+C1AN
        xhL7l04GWsABtEBTYv0ufYiwosTO33OhfuSTePe1hxWkREKAV6KjDWqtssTlB3eZIGxJicXt
        nWwTGJVmIflmFpIPZiH5YBbCsgWMLKsYxVILinPTU4sNCwyRo3sTIziVa5nuYJxyzucQowAH
        oxIPrwNrV6wQa2JZcWXuIUYJDmYlEd5ZMkAh3pTEyqrUovz4otKc1OJDjKbAwJ7ILCWanA/M
        M3kl8YamRsbGxhYmhmamhoZK4rwe6Q2xQgLpiSWp2ampBalFMH1MHJxSDYwXZgTkfZKfOS1b
        X2/+trwusU8mM+83q2xWF3ATvVJgV6ZZn3G2102k5fqMKTe/KL+zfr/2TMEujrwJC9Ujryql
        K73e47DyyYYNJzZ/2P6ahdWpri38UtfjC1HyiS1PrWxfqm2RmCvFyfTi58Llx6am/JzyuucR
        j+uO589i5XY52M83Zvy1822YEktxRqKhFnNRcSIAecY8mPsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvO7uS12xBnd+yFgcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPF5w2PGS1u
        N65gs1h97iCbRdehv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyaNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyzvxvZitod654fWUFewPjCuMuRk4O
        CQETidadE5lAbCGB3YwSR5caQMQlJaZdPMrcxcgBZAtLHD5c3MXIBVTyllFi0oOnrCA1wgLe
        Epv+z2EDsUUE1jJKzDnvAGIzCzxjljixKw2i4RGjxIo7TewgCTYBLYn9L26ANfALKEpc/fGY
        EcTmFbCTmHptF1icRUBVYtvel8wgtqhAhMThHbOgagQlTs58wgJicwrESXyfcJcdYpm6xJ95
        l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vc
        rzgxt7g0L10vOT93EyM4orU0dzBeXhJ/iFGAg1GJh9eBtStWiDWxrLgy9xCjBAezkgjvLBmg
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYxMhx2jD25o
        iFTSyhNpWb9siZKAlNO8KYWO/z9piqlsbE9jmc6eaHZSyld1dbFo04lPG1JXpb9ecv+J6VnP
        lydDps5TX6bLpym055O0q1rsu29P/JynXEqWa662XmEjtccvZ31XiGaJ81vxj6uCTyg//nIy
        4e2vpb/OTnt0dH2hpWxL1ouP/xuUWIozEg21mIuKEwHta9KQ5AIAAA==
X-CMS-MailID: 20190925023643epcas1p3b8c185c16a093ea18b3c2981e42d303e
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
> Switch the handling of min_freq and max_freq from sysfs to use the
> dev_pm_qos_request interface.
> 
> Since PM QoS handles frequencies as kHz this change reduces the
> precision of min_freq and max_freq. This shouldn't introduce problems
> because frequencies which are not an integer number of kHz are likely
> not an integer number of Hz either.
> 
> Try to ensure compatibility by rounding min values down and rounding
> max values up.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 46 ++++++++++++++++++++++++---------------
>  include/linux/devfreq.h   |  9 ++++----
>  2 files changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 784f3e40536a..8bb7efd821ab 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -137,14 +137,10 @@ static void get_freq_range(struct devfreq *devfreq,
>  	qos_max_freq = dev_pm_qos_read_value(devfreq->dev.parent,
>  					     DEV_PM_QOS_MIN_FREQUENCY);
>  	*min_freq = max(*min_freq, HZ_PER_KHZ * qos_min_freq);
>  	*max_freq = min(*max_freq, HZ_PER_KHZ * qos_max_freq);
>  
> -	/* constraints from sysfs */
> -	*min_freq = max(*min_freq, devfreq->min_freq);
> -	*max_freq = min(*max_freq, devfreq->max_freq);
> -
>  	/* constraints from OPP interface */
>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>  	/* scaling_max_freq can be zero on error */
>  	if (devfreq->scaling_max_freq)
>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> @@ -679,10 +675,12 @@ static void devfreq_dev_release(struct device *dev)
>  			DEV_PM_QOS_MIN_FREQUENCY);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> +	dev_pm_qos_remove_request(&devfreq->user_min_freq_req);

Please check the return value if error happen, just print the err with dev_err()
without stopping the release steps.

>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
> @@ -747,18 +745,25 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>  	if (!devfreq->scaling_min_freq) {
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->min_freq = devfreq->scaling_min_freq;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>  	if (!devfreq->scaling_max_freq) {
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->max_freq = devfreq->scaling_max_freq;
> +
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (err < 0)
> +		goto err_dev;
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> +				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
> +	if (err < 0)
> +		goto err_dev;
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
>  	devfreq->trans_table = kzalloc(
> @@ -843,10 +848,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  err_dev:
>  	/*
>  	 * Cleanup path for errors that happen before registration.
>  	 * Otherwise we rely on devfreq_dev_release.
>  	 */
> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->user_max_freq_req);

Please check the return value if error happen, just print the err with dev_err()
without stopping the release steps.

	dev_err(... "failed to remove request of DEV_PM_QOS_MAX_FREQUENCY\n");

> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
	
	dev_err(... "failed to remove request of DEV_PM_QOS_MIN_FREQUENCY\n");

>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
> @@ -1407,14 +1416,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -	df->min_freq = value;
> -	update_devfreq(df);
> -	mutex_unlock(&df->lock);
> +	/* round down to kHz for PM QoS */

I prefer more detailed description as following:

	/*                                                                                                      
	 * Round down to KHz to decide the proper minimum frequency                                          
	 * which is closed to user request.
 	 */


> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
> +					value / HZ_PER_KHZ);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> @@ -1439,19 +1449,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -
> -	/* Interpret zero as "don't care" */
> -	if (!value)
> -		value = ULONG_MAX;
> +	/* round up to kHz for PM QoS and interpret zero as "don't care" */

I think that "don't care" comment style is not good.

I referred to the Documentation/ABI/testing/sysfs-class-devfreq file.
I prefer more detailed description as following:
	/*                                                                                                      
	 * Round up to KHz to decide the proper maximum frequency                                          
	 * which is closed to user request. If value is zero,                                                   
	 * the user does not care.                                                                              
 	 */


> +	if (value)
> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
> +	else
> +		value = S32_MAX;
>  
> -	df->max_freq = value;
> -	update_devfreq(df);
> -	mutex_unlock(&df->lock);
> +	ret = dev_pm_qos_update_request(&df->user_max_freq_req, value);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  static DEVICE_ATTR_RW(min_freq);
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index dac0dffeabb4..7849fe4c666d 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -11,10 +11,11 @@
>  #define __LINUX_DEVFREQ_H__
>  
>  #include <linux/device.h>
>  #include <linux/notifier.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  
>  #define DEVFREQ_NAME_LEN 16
>  
>  /* DEVFREQ governor name */
>  #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
> @@ -121,12 +122,12 @@ struct devfreq_dev_profile {
>   *		devfreq.nb to the corresponding register notifier call chain.
>   * @work:	delayed work for load monitoring.
>   * @previous_freq:	previously configured frequency value.
>   * @data:	Private data of the governor. The devfreq framework does not
>   *		touch this.
> - * @min_freq:	Limit minimum frequency requested by user (0: none)
> - * @max_freq:	Limit maximum frequency requested by user (0: none)
> + * @user_min_freq_req:	PM QoS min frequency request from user (via sysfs)

min -> minimum and then remove parenthesis as following:
	PM QoS minimum frequency request by user via sysfs

> + * @user_max_freq_req:	PM QoS max frequency request from user (via sysfs)

ditto. max -> maximum
	PM QoS maximum frequency request by user via sysfs

>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>   * @stop_polling:	 devfreq polling status of a device.
>   * @suspend_freq:	 frequency of a device set during suspend phase.
>   * @resume_freq:	 frequency of a device set in resume phase.
> @@ -161,12 +162,12 @@ struct devfreq {
>  	unsigned long previous_freq;
>  	struct devfreq_dev_status last_status;
>  
>  	void *data; /* private data for governors */
>  
> -	unsigned long min_freq;
> -	unsigned long max_freq;
> +	struct dev_pm_qos_request user_min_freq_req;
> +	struct dev_pm_qos_request user_max_freq_req;
>  	unsigned long scaling_min_freq;
>  	unsigned long scaling_max_freq;
>  	bool stop_polling;
>  
>  	unsigned long suspend_freq;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
