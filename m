Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED5596F26
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 04:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfHUCBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 22:01:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47704 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfHUCBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 22:01:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190821020112epoutp0425321f62e455405d5b7b4ba0daf5a8dd~8zaOE0Zn43064230642epoutp04P
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 02:01:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190821020112epoutp0425321f62e455405d5b7b4ba0daf5a8dd~8zaOE0Zn43064230642epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566352872;
        bh=/AcPrVESwlm179pClqBxXXT6OAcBZTZz3gxcZv/mw9A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EeOT6aVYWGL1fF0ghscwRlGd+YddtLIANbX0s696nl2EXpXiTZuixBXdekQRFCDNZ
         PP/Ayz4gfru013yjufFY8XdfebbuAhmciqaeOwRbYGHO5MjrwqmvKbm6N7Bbdf1oUW
         49B2JDUPkRHKYLYDXoJLqtwEXg/TWoBRjl6Yov18=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821020111epcas1p2e22cb950722bdcf37284f1f0ccb69aa9~8zaNf9TP71362913629epcas1p2_;
        Wed, 21 Aug 2019 02:01:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46CrVR4tWfzMqYkh; Wed, 21 Aug
        2019 02:01:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.68.04088.8D5AC5D5; Wed, 21 Aug 2019 11:00:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190821020055epcas1p309280d930a702d1622be729fb3a2f28b~8zZ_kgl8R2788627886epcas1p3P;
        Wed, 21 Aug 2019 02:00:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821020055epsmtrp1c4e649101bf3e966a9c4ab00ab8c6724~8zZ_jmasa1823118231epsmtrp1i;
        Wed, 21 Aug 2019 02:00:55 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-e1-5d5ca5d82de9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.CD.03706.7D5AC5D5; Wed, 21 Aug 2019 11:00:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821020055epsmtip1d6c6912d337648a5aeff01ae0b522dc0~8zZ_PTH_s2979629796epsmtip1J;
        Wed, 21 Aug 2019 02:00:55 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Use dev_pm_qos for sysfs
 min/max_freq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e2ba9b0d-1930-0d2a-c262-72f0f85c86d0@samsung.com>
Date:   Wed, 21 Aug 2019 11:04:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmvu6NpTGxBudO6FocOraV3eLr6VOM
        Fi8PaVpM37uJzeL8+Q3sFmeb3rBbrLj7kdVi0+NrrBafe48wWtxuXMFmsfrcQTaLrkN/2Sw2
        fvVw4PV4f6OV3WPBplKPTas62TzuXNvD5rF5Sb3Hxnc7mDwOvtvD5NG3ZRWjx+dNcgGcUdk2
        GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBHKymUJeaU
        AoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM+bc
        vsFS8Min4vikPWwNjA9tuxg5OSQETCSm7nnA2MXIxSEksINRYuvX1SwQzidGiXvTLjJDON8Y
        JZY8+s3axcgB1jLvbwpEfC+jxPmuXjYI5z2jxPw3/xlBioQFAiVm70oDWSEicIxR4tavXJAa
        ZoFHTBL3/11mBEmwCWhJ7H9xgw3E5hdQlLj64zFYnFfATuLwrlusIDaLgKrEtu3T2EFsUYEI
        iU8PDrNC1AhKnJz5hAXE5hSIk1j0ahIziM0sIC5x68l8JghbXqJ562ywDyQEdrFL7Nu1mBni
        aReJ9Qu2MkHYwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2juYJTYsv8CK0TCWGL/0slMIF8yC2hK
        rN+lDxFWlNj5ey4jhM0r0bDxNzvEEXwS7772QEOOV6KjTQiiRFni8oO7TBMYlWcheWcWkhdm
        IXlhFsKyBYwsqxjFUguKc9NTiw0LDJFjexMjOEFrme5gnHLO5xCjAAejEg/vjpvRsUKsiWXF
        lbmHGCU4mJVEeCvmRMUK8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR5Hxg9sgriTc0NTI2NrYw
        MTQzNTRUEudd+MMiVkggPbEkNTs1tSC1CKaPiYNTqoHR3U+wl7nVSHlZg0CK5/+JC5/5XQ1n
        zW9Z+8pxX2eD28K/YYJ2Yg4XVe7frU5/e9o7kfvShtZJuls4nPg2fjjoO3vajhO72buybQrv
        FWVdWK4UohP4r6E4RzB+AnuOkbyy+IHTq1w1P+pUWMtNit1l9G7yln69GHHOiZem/ebLOetj
        F+kl463EUpyRaKjFXFScCAAuu+uj5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnO71pTGxBvunGFscOraV3eLr6VOM
        Fi8PaVpM37uJzeL8+Q3sFmeb3rBbrLj7kdVi0+NrrBafe48wWtxuXMFmsfrcQTaLrkN/2Sw2
        fvVw4PV4f6OV3WPBplKPTas62TzuXNvD5rF5Sb3Hxnc7mDwOvtvD5NG3ZRWjx+dNcgGcUVw2
        Kak5mWWpRfp2CVwZc27fYCl45FNxfNIetgbGh7ZdjBwcEgImEvP+pnQxcnEICexmlPi+YgN7
        FyMnUFxSYtrFo8wQNcIShw8XQ9S8ZZRY+nAXG0hcWCBQYvauNJC4iMAJRokVS9YwgTjMAk+Y
        JP42/mCF6HjEKHF04noWkKlsAloS+1/cYAOx+QUUJa7+eMwIYvMK2Ekc3nWLFcRmEVCV2LZ9
        GtgVogIREod3zIKqEZQ4OfMJ2BxOgTiJRa8mMYPYzALqEn/mXYKyxSVuPZnPBGHLSzRvnc08
        gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOBY1dLc
        wXh5SfwhRgEORiUe3h03o2OFWBPLiitzDzFKcDArifBWzImKFeJNSaysSi3Kjy8qzUktPsQo
        zcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoGxcs33HRomZWFfTh0R4rnSfGXFua6GQgYd
        wQlP8j7fn5b9OO38v2Xb//47vvmefkSbaVjJGhbzF0f+XSiYxH/xeY65fX3ie+MM9jZdvZX+
        z35OtrRw4Z1z/8XEwtBTW9zvTVtm67HocsUN65s25rZiP5mvz0k88H7aFLvX1Xt+q2+ReW3g
        UcnzU4mlOCPRUIu5qDgRAEJapKfRAgAA
X-CMS-MailID: 20190821020055epcas1p309280d930a702d1622be729fb3a2f28b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1
References: <cover.1566314535.git.leonard.crestez@nxp.com>
        <CGME20190820152411epcas4p33e2ef4d271ddd82a4401c0286b53d2f1@epcas4p3.samsung.com>
        <af14021b98254032e856397b54329756c1cc59c0.1566314535.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 21. 오전 12:24, Leonard Crestez wrote:
> Now that devfreq supports dev_pm_qos requests we can use them to handle
> the min/max_freq values set by userspace in sysfs, similar to cpufreq.
> 
> Since dev_pm_qos handles frequencies as kHz this change reduces the
> precision of min_freq and max_freq. This shouldn't introduce problems
> because frequencies which are not an integer number of kHz are likely
> not an integer number of Hz either.
> 
> Try to ensure compatibilitity by rounding min values down and rounding
> max values up.
> 
> Simplify the {min,max}_freq_store code by setting "null" values of 0 and
> MAX_S32 respectively instead of clamping to what freq tables are
> actually supported. Values are already automatically clamped on
> readback.
> 
> Also simplify by droping the limitation that userspace min_freq must be
> lower than userspace max_freq, it is already documented that max_freq
> takes precedence.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 79 ++++++++++++++++-----------------------
>  include/linux/devfreq.h   |  9 +++--
>  2 files changed, 38 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 58deffa52a37..687deadd08ed 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -101,21 +101,21 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  
>  static unsigned long get_effective_min_freq(struct devfreq *devfreq)
>  {
>  	lockdep_assert_held(&devfreq->lock);
>  
> -	return max3(devfreq->scaling_min_freq, devfreq->min_freq,
> +	return max(devfreq->scaling_min_freq,
>  		1000 * (unsigned long)dev_pm_qos_read_value(
>  				devfreq->dev.parent,
>  				DEV_PM_QOS_MIN_FREQUENCY));
>  }
>  
>  static unsigned long get_effective_max_freq(struct devfreq *devfreq)
>  {
>  	lockdep_assert_held(&devfreq->lock);
>  
> -	return min3(devfreq->scaling_max_freq, devfreq->max_freq,
> +	return min(devfreq->scaling_max_freq,
>  		1000 * (unsigned long)dev_pm_qos_read_value(
>  				devfreq->dev.parent,
>  				DEV_PM_QOS_MAX_FREQUENCY));
>  }
>  
> @@ -644,10 +644,12 @@ static void devfreq_dev_release(struct device *dev)
>  
>  	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>  			DEV_PM_QOS_MAX_FREQUENCY);
>  	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
>  			DEV_PM_QOS_MIN_FREQUENCY);
> +	dev_pm_qos_remove_request(&devfreq->max_freq_req);
> +	dev_pm_qos_remove_request(&devfreq->min_freq_req);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
>  
>  /**
> @@ -698,10 +700,19 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
> +	err = dev_pm_qos_add_request(dev, &devfreq->min_freq_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (err < 0)
> +		goto err_dev;
> +	err = dev_pm_qos_add_request(dev, &devfreq->max_freq_req,
> +				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
> +	if (err < 0)
> +		goto err_dev;
> +

Please move them under dev_pm_qos_add_notifier()
because it seems that it request the qos without qos_notifier.

>  	/*
>  	 * notifier from pm_qos
>  	 *
>  	 * initialized outside of devfreq->lock to avoid circular warning
>  	 * between devfreq->lock and dev_pm_qos_mtx
> @@ -732,19 +743,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	if (!devfreq->scaling_min_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->min_freq = devfreq->scaling_min_freq;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>  	if (!devfreq->scaling_max_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->max_freq = devfreq->scaling_max_freq;
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
>  	dev_set_name(&devfreq->dev, "devfreq%d",
> @@ -816,10 +825,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  err_dev:
>  	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>  				   DEV_PM_QOS_MAX_FREQUENCY);
>  	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
>  				   DEV_PM_QOS_MIN_FREQUENCY);
> +	if (dev_pm_qos_request_active(&devfreq->max_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->max_freq_req);
> +	if (dev_pm_qos_request_active(&devfreq->min_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->min_freq_req);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(devfreq_add_device);
> @@ -1358,33 +1371,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -
> -	if (value) {
> -		if (value > df->max_freq) {
> -			ret = -EINVAL;
> -			goto unlock;
> -		}

Actually, the user can input the value they want.
So, the above code is not necessary because the devfreq->scaling_max_freq
is never overflow from supported maximum frequency. The devfreq->scaling_max_freq
is based on OPP entries from DT.

But, if we replace the existing request way of devfreq-cooling.c
with dev_pm_qos, devfreq->scaling_max_freq doesn't guarantee
the supported maximum frequency.

We need to keep the supported min_freq/max_freq value without dev_pm_qos
requirement because the dev_pm_qos requirement might have the overflow value.
the dev_pm_qos doesn't know the supported minimum and maximum frequency
of devfreq device.


> -	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> +	if (value)
> +		value = value / 1000;

Better to use KHZ definition instead of 1000 as I commented on patch1.

> +	else
> +		value = 0;
>  
> -		/* Get minimum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> -			value = freq_table[0];
> -		else
> -			value = freq_table[df->profile->max_state - 1];
> -	}
> +	ret = dev_pm_qos_update_request(&df->min_freq_req, value);
> +	if (ret < 0)
> +		return ret;
>  
> -	df->min_freq = value;
> -	update_devfreq(df);
> -	ret = count;
> -unlock:
> -	mutex_unlock(&df->lock);
> -	return ret;
> +	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -1407,33 +1407,20 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -
> -	if (value) {
> -		if (value < df->min_freq) {
> -			ret = -EINVAL;
> -			goto unlock;

> -		}
> -	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> +	if (value)
> +		value = DIV_ROUND_UP(value, 1000);
> +	else
> +		value = S32_MAX;
>  
> -		/* Get maximum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> -			value = freq_table[df->profile->max_state - 1];
> -		else
> -			value = freq_table[0];
> -	}
> +	ret = dev_pm_qos_update_request(&df->max_freq_req, value);
> +	if (ret < 0)
> +		return ret;
>  
> -	df->max_freq = value;
> -	update_devfreq(df);
> -	ret = count;
> -unlock:
> -	mutex_unlock(&df->lock);
> -	return ret;
> +	return count;
>  }
>  static DEVICE_ATTR_RW(min_freq);
>  
>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 8b92ccbd1962..d2c5bb7add0a 100644
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
> + * @min_freq_req:	Limit minimum frequency requested by user (0: none)
> + * @max_freq_req:	Limit maximum frequency requested by user (0: none)
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
> +	struct dev_pm_qos_request min_freq_req;
> +	struct dev_pm_qos_request max_freq_req;
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
