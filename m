Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF1BC13C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409023AbfIXFJI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 01:09:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58428 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409007AbfIXFJI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 01:09:08 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190924050904epoutp03aa237edf05e2f81e9cbe6db8cde0d19f~HR59FZKDp0986509865epoutp03G
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 05:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190924050904epoutp03aa237edf05e2f81e9cbe6db8cde0d19f~HR59FZKDp0986509865epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569301744;
        bh=b73FgEfXE10YC+KSaEs4tPAQu12P0kC5+J3rv2iL/Ds=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=erTqGVgT2/QTmxfRUT4iKtZ+Q+UYtJg1tL5Cs4pi6jplURVM+yS7KfypYomaGJ8jz
         47KAXyFfRd4Ze8jor4kqjHVMuWz7BmMOO2blRUIINai5wWxicVWhKdOYgwL/szPGgQ
         Rv3nLUqyv4ikCj3ejQ/7Vu9yGE1dwAt+zUyj6MHE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190924050903epcas1p2d6c1689fbf4b6e2186e648996089c369~HR58PvFni0587605876epcas1p2i;
        Tue, 24 Sep 2019 05:09:03 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46cq3H6FYszMqYm5; Tue, 24 Sep
        2019 05:08:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.A3.04144.BD4A98D5; Tue, 24 Sep 2019 14:08:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190924050843epcas1p4a27cfce9cfb41ca9d1077a4268c8efb3~HR5parfXr0913209132epcas1p4F;
        Tue, 24 Sep 2019 05:08:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190924050843epsmtrp2f705e97a54e811e28152bf2434437ab0~HR5pZduy_0149201492epsmtrp2r;
        Tue, 24 Sep 2019 05:08:43 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-93-5d89a4db14fe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.BB.03889.BD4A98D5; Tue, 24 Sep 2019 14:08:43 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190924050842epsmtip1653b9f85fa39d975dc06398a4c8caaa5~HR5o_C2AI0629406294epsmtip1F;
        Tue, 24 Sep 2019 05:08:42 +0000 (GMT)
Subject: Re: [PATCH v7 4/6] PM / devfreq: Introduce devfreq_get_freq_range
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
Message-ID: <e8d1d04a-1e8e-0765-179f-2146271787bb@samsung.com>
Date:   Tue, 24 Sep 2019 14:13:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <15e599188c5b50edad3efc37787dc2b70d6efead.1569272883.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmge7tJZ2xBi+3GlkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPFtRUTWS0+
        b3jMaHG7cQWbxepzB9ksug79ZbPY+NXDQdDj/Y1Wdo/ZDRdZPBZsKvXYtKqTzePOtT1sHpuX
        1HtsfLeDyePguz1MHr8Oi3r0bVnF6PF5k1wAd1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QR0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iy+cx2MBeusK74cXcrawHhMr4uRk0NCwERi
        4f925i5GLg4hgR2MEiu/LWSBcD4xSiy8+o8NwvnGKPHswTbWLkYOsJY5+4sg4nsZJQ7sncsE
        MkpI4D2jxK77biC2sICXRNu0ZWDNIgKrGSValt5hBHGYBXpZJHbc72ABqWIT0JLY/+IGG4jN
        L6AocfXHY0YQm1fATmLxzidsINtYBFQlZuzSAgmLCkRIfHpwmBWiRFDi5MwnYGM4BeIktv2b
        DHYEs4C4xK0n86FseYnmrbOZIf58xC7R9VkAwnaR2Nw+GSouLPHq+BZ2CFtK4vO7vWwQdrXE
        ypNHwB6QEOhglNiy/wIrRMJYYv9SkGUcQAs0Jdbv0ocIK0rs/D2XEWIvn8S7rz3QwOKV6GgT
        gihRlrj84C4ThC0psbi9k20Co9IsJN/MQvLBLCQfzEJYtoCRZRWjWGpBcW56arFhgSFyZG9i
        BCd2LdMdjFPO+RxiFOBgVOLhLdjRESvEmlhWXJl7iFGCg1lJhHeTVlusEG9KYmVValF+fFFp
        TmrxIUZTYFhPZJYSTc4HZp28knhDUyNjY2MLE0MzU0NDJXFej/SGWCGB9MSS1OzU1ILUIpg+
        Jg5OqQbGGSw7G9ZskpJdr+l4fsWHzCe2ngc5Y6UNxM7Vv533qCR86t59G931emsPbQqak1Zz
        c/a5p3sClh/+knhAQfnXVXanhRLyi25UKj4zsk2N5dt5+mepkHuRfPaW6lVXnS0Z3J4zfTp7
        jynp5r7S42K/3hk9/8518VIZh9khno/XhQMEdHlmvG4UUWIpzkg01GIuKk4EACutOaACBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCSnO7tJZ2xBk+3CFscOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht7jVIGOx4u5HVotNj6+xWnT9Wsls8bn3CKPFtRUTWS0+
        b3jMaHG7cQWbxepzB9ksug79ZbPY+NXDQdDj/Y1Wdo/ZDRdZPBZsKvXYtKqTzePOtT1sHpuX
        1HtsfLeDyePguz1MHr8Oi3r0bVnF6PF5k1wAdxSXTUpqTmZZapG+XQJXRt+5DsaCddYVX44u
        ZW1gPKbXxcjBISFgIjFnf1EXIxeHkMBuRonp+y4zdTFyAsUlJaZdPMoMUSMscfhwMUTNW0aJ
        v11bwWqEBbwk2qYtYwOxRQTWMkrMOe8AUsQs0Msi0XRwBTtExyNGiZ0zz7KCVLEJaEnsf3ED
        rINfQFHi6o/HjCA2r4CdxOKdT9hAtrEIqErM2KUFEhYViJA4vGMWVImgxMmZT1hAbE6BOIlt
        /yaDHcEsoC7xZ94lZghbXOLWk/lQcXmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCc
        m55bbFhglJdarlecmFtcmpeul5yfu4kRHONaWjsYT5yIP8QowMGoxMMrsa0jVog1say4MvcQ
        owQHs5II7yattlgh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwc
        nFINjPEliyc65fJHR/n5Wm113fLA6C6X8tmdZ89tmHS743hcXdhG+Z1hBiFnGS5XbdnwL0R2
        8ZpXdtouM9d0mzN8OCnHGPdr8YUv516t2yuh/p2XfcKs4JS0/I0HWxqLPba/0n/06431hIhY
        /gudNounPJtbxrxU3XpKslnc+lda9/m+Vf24+qQ464ESS3FGoqEWc1FxIgDx7oP+7QIAAA==
X-CMS-MailID: 20190924050843epcas1p4a27cfce9cfb41ca9d1077a4268c8efb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923211045epcas1p2358d39cbc6f38af8ae0b7923550d919e
References: <cover.1569272883.git.leonard.crestez@nxp.com>
        <CGME20190923211045epcas1p2358d39cbc6f38af8ae0b7923550d919e@epcas1p2.samsung.com>
        <15e599188c5b50edad3efc37787dc2b70d6efead.1569272883.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 9. 24. 오전 6:10, Leonard Crestez wrote:
> Moving handling of min/max freq to a single function and call it from
> update_devfreq and for printing min/max freq values in sysfs.
> 
> This changes the behavior of out-of-range min_freq/max_freq: clamping
> is now done at evaluation time. This means that if an out-of-range
> constraint is imposed by sysfs and it later becomes valid then it will
> be enforced.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 111 +++++++++++++++++++++-----------------
>  1 file changed, 63 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1cec816d3d00..7f152a582e78 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -24,10 +24,12 @@
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define HZ_PER_KHZ 1000

It is not used on this patch. If it is used on later patch,
move it to other patch.

> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/devfreq.h>
>  
>  static struct class *devfreq_class;
>  
> @@ -96,10 +98,50 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  		dev_pm_opp_put(opp);
>  
>  	return max_freq;
>  }
>  
> +/**
> + * devfreq_get_freq_range() - Get the current freq range
> + * @devfreq:	the devfreq instance
> + * @min_freq:	the min frequency
> + * @max_freq:	the max frequency
> + *
> + * This takes into consideration all constraints.
> + */
> +static void devfreq_get_freq_range(struct devfreq *devfreq,

This function is used in the only devfreq core.
I think that the internal function doesn't need to add 'devfreq' prefix.
Also, when I developed the patches, I didn't use 'devfreq' prefix
for internal function.

> +				   unsigned long *min_freq,
> +				   unsigned long *max_freq)
> +{
> +	unsigned long *freq_table = devfreq->profile->freq_table;
> +
> +	lockdep_assert_held(&devfreq->lock);
> +
> +	/* Init min/max frequency from freq table */

I think that the comments in the devfreq_get_freq_range(),
it is not necessary. But if you think that it is necessary,
please add more detailed description like as following:

	/*
	 * The devfreq recommend that freq_table must be generated
	 * in ascending order but, some devfreq driver used the descending order
	 * for freq_table. In order to support all cases, check the order
	 * of freq_table and then initialize the min/max frequency from freq_table.
	 */

> +	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
> +		*min_freq = freq_table[0];
> +		*max_freq = freq_table[devfreq->profile->max_state - 1];
> +	} else {
> +		*min_freq = freq_table[devfreq->profile->max_state - 1];
> +		*max_freq = freq_table[0];
> +	}
> +
> +	/* constraints from sysfs */

ditto. Need to add more detailed comment by keeping the comment style of devfreq.


> +	*min_freq = max(*min_freq, devfreq->min_freq);
> +	*max_freq = min(*max_freq, devfreq->max_freq);
> +
> +	/* constraints from OPP interface */

ditto.

> +	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
> +	/* scaling_max_freq can be zero on error */
> +	if (devfreq->scaling_max_freq)
> +		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> +
> +	/* max_freq takes precedence over min_freq */

It is not necessary. We can know that min_freq have to be
under max_freq without any comment.

> +	if (*min_freq > *max_freq)
> +		*min_freq = *max_freq;
> +}
> +
>  /**
>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:	the devfreq instance
>   * @freq:	the target frequency
>   */
> @@ -349,21 +391,13 @@ int update_devfreq(struct devfreq *devfreq)
>  
>  	/* Reevaluate the proper frequency */
>  	err = devfreq->governor->get_target_freq(devfreq, &freq);
>  	if (err)
>  		return err;
> +	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
>  
> -	/*
> -	 * Adjust the frequency with user freq, QoS and available freq.
> -	 *
> -	 * List from the highest priority
> -	 * max_freq
> -	 * min_freq
> -	 */
> -	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> -	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
> -
> +	/* max freq takes priority over min freq */

Please remove it. 

>  	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
>  	if (freq > max_freq) {
> @@ -1278,40 +1312,28 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -
> -	if (value) {
> -		if (value > df->max_freq) {
> -			ret = -EINVAL;
> -			goto unlock;
> -		}
> -	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> -
> -		/* Get minimum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> -			value = freq_table[0];
> -		else
> -			value = freq_table[df->profile->max_state - 1];
> -	}
> ->  	df->min_freq = value;>  	update_devfreq(df);
> -	ret = count;
> -unlock:
>  	mutex_unlock(&df->lock);
> -	return ret;
> +
> +	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	unsigned long min_freq, max_freq;
>  
> -	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
> +	mutex_lock(&df->lock);
> +	devfreq_get_freq_range(df, &min_freq, &max_freq);
> +	mutex_unlock(&df->lock);
> +
> +	return sprintf(buf, "%lu\n", min_freq);
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -1323,40 +1345,33 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
>  
> -	if (value) {
> -		if (value < df->min_freq) {
> -			ret = -EINVAL;
> -			goto unlock;
> -		}
> -	} else {
> -		unsigned long *freq_table = df->profile->freq_table;
> -
> -		/* Get maximum frequency according to sorting order */
> -		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> -			value = freq_table[df->profile->max_state - 1];
> -		else
> -			value = freq_table[0];
> -	}
> +	/* Interpret zero as "don't care" */

Please remove this comment.

> +	if (!value)
> +		value = ULONG_MAX;
>  
>  	df->max_freq = value;
>  	update_devfreq(df);
> -	ret = count;
> -unlock:
>  	mutex_unlock(&df->lock);
> -	return ret;
> +
> +	return count;
>  }
>  static DEVICE_ATTR_RW(min_freq);
>  
>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct devfreq *df = to_devfreq(dev);
> +	unsigned long min_freq, max_freq;
> +
> +	mutex_lock(&df->lock);
> +	devfreq_get_freq_range(df, &min_freq, &max_freq);
> +	mutex_unlock(&df->lock);
>  
> -	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
> +	return sprintf(buf, "%lu\n", max_freq);
>  }
>  static DEVICE_ATTR_RW(max_freq);
>  
>  static ssize_t available_frequencies_show(struct device *d,
>  					  struct device_attribute *attr,
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
