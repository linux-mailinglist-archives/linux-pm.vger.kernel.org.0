Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFEBBC276
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409254AbfIXHWW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 03:22:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10747 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390221AbfIXHWV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 03:22:21 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190924072218epoutp043a0bc3d9a4d0b21cefec91f7a8337140~HTuRktdDB1700917009epoutp04d
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 07:22:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190924072218epoutp043a0bc3d9a4d0b21cefec91f7a8337140~HTuRktdDB1700917009epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569309738;
        bh=rRsnrALXAW189oCam7GkRkg9BHuclInrGVs6DyomnC0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lvkG76mtIl1fnhXver+ToDtTkDXJlB1nKIzak3uuUBhobXxdF4D8769LLJ5Tdd8eq
         9sTg8ZtzfXvnHS0Bec10Wetyq6SRd7iim/CGNpVQ3NOPGufvNBijOdsqAwegRsGsqw
         yXQ0c3dp8KbK9T0ZaFiZV5r0WTAeG1scJdtDwzR4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190924072217epcas1p2a60f815b21ca1fe3bb3da2027eba46d2~HTuQpwefb2727727277epcas1p2M;
        Tue, 24 Sep 2019 07:22:17 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46ct1L4P2FzMqYlh; Tue, 24 Sep
        2019 07:22:14 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.B5.04068.624C98D5; Tue, 24 Sep 2019 16:22:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190924072214epcas1p30cdb6ef23b33890b2f4f235bfb2072dc~HTuOHKYrl3188131881epcas1p3y;
        Tue, 24 Sep 2019 07:22:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924072214epsmtrp1dc8d0d1ac404efe193b4f9175f9e44e6~HTuOFuXxx2627126271epsmtrp1r;
        Tue, 24 Sep 2019 07:22:14 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-fd-5d89c426cd7d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.67.04081.624C98D5; Tue, 24 Sep 2019 16:22:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924072213epsmtip2e0a2c83038aeee819fa61b3ea3529ebd~HTuNnAx8x0922309223epsmtip2d;
        Tue, 24 Sep 2019 07:22:13 +0000 (GMT)
Subject: Re: [PATCH v7 6/6] PM / devfreq: Use PM QoS for sysfs min/max_freq
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
        Martin Kepplinger <martink@posteo.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9ca017ca-57cc-684b-976f-25d9d9bc6306@samsung.com>
Date:   Tue, 24 Sep 2019 16:26:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00747fe09746282ef4d99ffd2a4e58e592ba4f66.1569272883.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmga7akc5Yg4/LlS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi2oqJrBaf
        NzxmtLjduILNYvW5g2wWXYf+slls/OrhIOjx/kYru8fshossHgs2lXpsWtXJ5nHn2h42j81L
        6j02vtvB5HHw3R4mj1+HRT36tqxi9Pi8SS6AOyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7U
        zMBQ19DSwlxJIS8xN9VWycUnQNctMwfoIyWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJq
        QUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbDGX0sBQ12FeemX2FsYJxs1MXIySEhYCIx
        YfUUpi5GLg4hgR2MEm/3/IByPjFKbPu0iw2kSkjgG6PEgwvMXYwcYB27t8hD1OxllNgyeQEz
        hPOeUWLl6dXsIA3CAt4SPQf3sIMkRARWM0q0LL3DCOIwC/SySOy438ECUsUmoCWx/8UNsBX8
        AooSV388ZgSxeQXsJJYd3A9WwyKgKrF6RyOYLSoQIfHpwWFWiBpBiZMzn4DFOQXiJBYc+ADW
        yywgLnHryXwmCFteonnrbLDzJATusUvMevuRBeJrF4kLa76xQ9jCEq+Ob4GypSRe9rdB2dUS
        K08eYYNo7gB6dP8FVoiEscT+pZOZQIHBLKApsX6XPkRYUWLn77lQR/BJvPvawwoJL16JjjYh
        iBJlicsP7jJB2JISi9s72SYwKs1C8s4sJC/MQvLCLIRlCxhZVjGKpRYU56anFhsWmCJH9yZG
        cHLXstzBeOyczyFGAQ5GJR7egh0dsUKsiWXFlbmHGCU4mJVEeDdptcUK8aYkVlalFuXHF5Xm
        pBYfYjQFhvZEZinR5Hxg5skriTc0NTI2NrYwMTQzNTRUEuf1SG+IFRJITyxJzU5NLUgtgulj
        4uCUamCM/PihJlZAfFHJlaj1B61L3sw41LT1cMV+16UG7JZmvJucxFRNWVgzGJ8+X2oq+z0g
        4ofe9EOFE7mkKytipiROfqF35vGUopNb7p7ZHvfj85qa1ivNTyecePxi7QfhlxtDDkZXfPtz
        zzvklPrNaP9T3lK7XZ/MrXGYlD5TqS3jV+mtgoIMltwpSizFGYmGWsxFxYkAYX4TMgQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCSvK7akc5Yg62PuCwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW9xqkLFYcfcjq8Wmx9dYLbp+rWS2+Nx7hNHi2oqJrBaf
        NzxmtLjduILNYvW5g2wWXYf+slls/OrhIOjx/kYru8fshossHgs2lXpsWtXJ5nHn2h42j81L
        6j02vtvB5HHw3R4mj1+HRT36tqxi9Pi8SS6AO4rLJiU1J7MstUjfLoEr4+GMPpaCBruKc9Ov
        MDYwTjbqYuTgkBAwkdi9Rb6LkYtDSGA3o8TUq79Zuhg5geKSEtMuHmWGqBGWOHy4GKLmLaPE
        sj8H2EBqhAW8JXoO7mEHsUUE1jJKzDnvAFLELNDLItF0cAVYQkjgEaPEo/+RIDabgJbE/hc3
        wJr5BRQlrv54zAhi8wrYSSw7uB9sMYuAqsTqHY1gtqhAhMThHbOgagQlTs58AhbnFIiTWHDg
        A1icWUBd4s+8S8wQtrjErSfzmSBseYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJyb
        nltsWGCYl1quV5yYW1yal66XnJ+7iREc41qaOxgvL4k/xCjAwajEw1uwoyNWiDWxrLgy9xCj
        BAezkgjvJq22WCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4
        pRoY502Ru7Z+23//eQw3tqjy1URLn2bdG8+8svjr6ZY8OYktj6a/dbCPn9S+p+vKv1yHsH+n
        5lS+4GgwX/IxfPWu6lT+zJgZrcmHDqx7d+PgcuW2ezoL9jw7V3DgiRb3PruQ+FcG2a1qDeE7
        0vY2eSe6WkxTP5MUuGdf0fcaI82JC28ctb+5tuPTaiWW4oxEQy3mouJEAHkrHmjtAgAA
X-CMS-MailID: 20190924072214epcas1p30cdb6ef23b33890b2f4f235bfb2072dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923211046epcas5p40493e620f31fe8ceaba7585c85ffafcc
References: <cover.1569272883.git.leonard.crestez@nxp.com>
        <CGME20190923211046epcas5p40493e620f31fe8ceaba7585c85ffafcc@epcas5p4.samsung.com>
        <00747fe09746282ef4d99ffd2a4e58e592ba4f66.1569272883.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 24. 오전 6:10, Leonard Crestez wrote:
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
>  drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++++--------------
>  include/linux/devfreq.h   |  9 +++----
>  2 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 9887408f23bb..a00737e34d36 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -132,14 +132,10 @@ static void devfreq_get_freq_range(struct devfreq *devfreq,
>  	*min_freq = max(*min_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
>  				devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY));
>  	*max_freq = min(*max_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
>  				devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY));
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
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
> @@ -747,18 +745,26 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> +	/* PM QoS requests for min/max freq from sysfs */

The comment is important. But the devfreq_add_device() has usually
not added the comment for each step. I'm not sure to add the some
comments for only this. How about removing it?

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
> @@ -843,10 +849,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  err_dev:
>  	/*
>  	 * Cleanup path for errors that happen before registration.
>  	 * Otherwise we rely on devfreq_dev_release.
>  	 */
> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
> @@ -1387,14 +1397,17 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -	df->min_freq = value;
> -	update_devfreq(df);
> -	mutex_unlock(&df->lock);
> +	/* round down to kHz for dev_pm_qos */

Please remove it.

> +	if (value)
> +		value = value / HZ_PER_KHZ;

It doesn't be necessary.

> +
> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req, value);

Change it as following:
	ret = dev_pm_qos_update_request(&df->user_min_freq_req, (value / HZ_PER_KHZ));

> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> @@ -1419,19 +1432,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
> +	/* round up to kHz for dev_pm_qos and interpret zero as "don't care" */

Please remove it.

> +	if (value)
> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);

Why do you use 'DIV_ROUND_UP(value, HZ_PER_KHZ)'
instead of 'value / HZ_PER_KHZ' in min_freq_store()?

> +	else
> +		value = S32_MAX;> > -	df->max_freq = value;
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
> index 8b92ccbd1962..3162eb9b0954 100644
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
> + * @user_max_freq_req:	PM QoS max frequency request from user (via sysfs)

I think that 'user' prefix is not needed. You better to change it as following
	@min_freq_req:	PM QoS minimum frequency request by user via sysfs
	@max_freq_req:	PM QoS maximum frequency request by user via sysfs

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

ditto.

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
