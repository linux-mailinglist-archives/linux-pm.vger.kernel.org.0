Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7928FEA942
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJaCg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:36:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61498 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJaCg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:36:59 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191031023656epoutp03062a6b9ae7724416fef3388378978ad1~Smsr7yKi33138731387epoutp030
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 02:36:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191031023656epoutp03062a6b9ae7724416fef3388378978ad1~Smsr7yKi33138731387epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572489416;
        bh=iehrdFm5CutsFXROtsw4VE1utE2XL17fTyD0RjmlvyU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b4yBKbkVjOXJLDP5kph9CQu8jWxp/eLUCgXRhxWpm78BnknebDGK2FLyThdmzX6ur
         c5Ghvdd/eRMMk3Or0/5ItuuH6cieC76ihvoLBj+F0uFtowEsHpol+IDxaPxC+qLd/S
         s98URe5WbwmYOTKpIzGRQKx7MIC54cCH5a5uANwo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191031023655epcas1p1a1893c38891f40dfa3affca92c87992c~SmsrblChl2081620816epcas1p1r;
        Thu, 31 Oct 2019 02:36:55 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 473Tx12t4yzMqYlp; Thu, 31 Oct
        2019 02:36:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.AA.04144.5C84ABD5; Thu, 31 Oct 2019 11:36:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191031023653epcas1p2c9723f4c6074a3782c96239402df9459~SmsoszM3H1285412854epcas1p2W;
        Thu, 31 Oct 2019 02:36:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191031023653epsmtrp139bea8c5d015e1fe0ed2c70ad1d9fb88~SmsorHSTz2319823198epsmtrp1v;
        Thu, 31 Oct 2019 02:36:52 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-e4-5dba48c57b18
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.2C.24756.4C84ABD5; Thu, 31 Oct 2019 11:36:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191031023652epsmtip277f3036a6db630096e96a115ae534cf4~SmsoWrmZE0651806518epsmtip2k;
        Thu, 31 Oct 2019 02:36:52 +0000 (GMT)
Subject: Re: [PATCH v9 6/8] PM / devfreq: Introduce get_freq_range helper
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a4b4c295-b230-5f15-61a2-d0e826584393@samsung.com>
Date:   Thu, 31 Oct 2019 11:42:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmru5Rj12xBitXClocOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht1hx9yOrxabH11gtun6tZLb43HuE0eLzhseMFrcbV7BZ
        rD53kM2i69BfNouNXz0c+D3e32hl95jdcJHFY8GmUo9NqzrZPO5c28PmsXlJvcfGdzuYPA6+
        28Pk0bdlFaPH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmp
        tkouPgG6bpk5QE8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS
        9ZLzc60MDQyMTIEKE7Iz5sz5xF5w0qhiz72sBsbn6l2MnBwSAiYSd5d2snUxcnEICexglLjY
        9x3K+cQoMa3rGSOE841R4ubmHSwwLd9+XWIFsYUE9jJKHLhhA1H0nlFiRcNLsCJhAU+JzUs7
        2EFsEYE6iVuLTzCDFDELPGeWeHpwJjNIgk1AS2L/ixtsIDa/gKLE1R+PGUFsXgE7iQkdN5hA
        bBYBVYnnkx8AxTk4RAUiJE5/TYQoEZQ4OfMJ2C5OgTiJ3Wd3g+1iFhCXuPVkPhOELS/RvHU2
        2F4JgXPsEu2PnrFCfOAicaHpBxOELSzx6vgWdghbSuJlfxuUXS2x8uQRNojmDkaJLfsvQDUb
        S+xfOpkJ5CBmAU2J9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQAr0RHmxBEibLE5Qd3odZKSixu
        72SbwKg0C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlpsWGCIHNmbGMHpW8t0B+OUcz6HGAU4
        GJV4eCeU7YwVYk0sK67MPcQowcGsJML7zQYoxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OB
        uSWvJN7Q1MjY2NjCxNDM1NBQSZzXcfnSWCGB9MSS1OzU1ILUIpg+Jg5OqQbGlDsSuf2T51iI
        xhacOTM5/P3irNNntskqSmuy1S072sNaPntu5Tm93Nq7ZzkEb9brPtl606FGpWPNLeVJpn19
        z+Qu6LO+1Gia+ftSUUnLqjNrs6+oOSb2Gdh/kuqRNVzVeHii6EpGPQa+iRyyG71UEkrZitre
        V9b9qeiMqL7z0IHroFed7WMlluKMREMt5qLiRABHhF4v9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSvO4Rj12xBievmVkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht1hx9yOrxabH11gtun6tZLb43HuE0eLzhseMFrcbV7BZ
        rD53kM2i69BfNouNXz0c+D3e32hl95jdcJHFY8GmUo9NqzrZPO5c28PmsXlJvcfGdzuYPA6+
        28Pk0bdlFaPH501yAVxRXDYpqTmZZalF+nYJXBlz5nxiLzhpVLHnXlYD43P1LkZODgkBE4lv
        vy6xdjFycQgJ7GaUWND9hg0iISkx7eJR5i5GDiBbWOLw4WKImreMEquW/GQGqREW8JTYvLSD
        HcQWEaiT+PN8HxNIEbPAc2aJDfe/soIkhAQeMUpMf5wKYrMJaEnsf3EDbAG/gKLE1R+PGUFs
        XgE7iQkdN5hAbBYBVYnnkx+AxUUFIiSeb78BVSMocXLmExYQm1MgTmL32d1gi5kF1CX+zLvE
        DGGLS9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwZGspbmD8fKS+EOMAhyMSjy8E8p2xgqxJpYVV+YeYpTgYFYS4f1mAxTi
        TUmsrEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBMejSfyuZpH09
        x3PXuqq0rlv4K8Jzz7q/ms+q8sWDyz8GRn9hkxKK/upu8sefi2mlVf/FDCv+6BctPa0l4uan
        51kePuV3ytpCIVakbr/0p9/n51nZXku8lGjwIHnnotNzfM5yFfSbVEe4BzZKKqh16U14Pe9f
        VpfnGt3tJ8+1zTRwuaj02cZSiaU4I9FQi7moOBEAEvxHU+ACAAA=
X-CMS-MailID: 20191031023653epcas1p2c9723f4c6074a3782c96239402df9459
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191002192528epcas4p4d6fd2e70c8ffe0fd319990c744ddd8d2
References: <cover.1570044052.git.leonard.crestez@nxp.com>
        <CGME20191002192528epcas4p4d6fd2e70c8ffe0fd319990c744ddd8d2@epcas4p4.samsung.com>
        <c453bb60a74b41a5192e270f286dfc81c1088449.1570044052.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 3. 오전 4:25, Leonard Crestez wrote:
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
>  drivers/devfreq/devfreq.c | 110 +++++++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 87eff789ce24..2d63692903ff 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -96,10 +96,53 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  		dev_pm_opp_put(opp);
>  
>  	return max_freq;
>  }
>  
> +/**
> + * get_freq_range() - Get the current freq range
> + * @devfreq:	the devfreq instance
> + * @min_freq:	the min frequency
> + * @max_freq:	the max frequency
> + *
> + * This takes into consideration all constraints.
> + */
> +static void get_freq_range(struct devfreq *devfreq,
> +			   unsigned long *min_freq,
> +			   unsigned long *max_freq)
> +{
> +	unsigned long *freq_table = devfreq->profile->freq_table;
> +
> +	lockdep_assert_held(&devfreq->lock);
> +
> +	/*
> +	 * Initialize minimum/maximum frequency from freq table.
> +	 * The devfreq drivers can initialize this in either ascending or
> +	 * descending order and devfreq core supports both.
> +	 */
> +	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
> +		*min_freq = freq_table[0];
> +		*max_freq = freq_table[devfreq->profile->max_state - 1];
> +	} else {
> +		*min_freq = freq_table[devfreq->profile->max_state - 1];
> +		*max_freq = freq_table[0];
> +	}
> +
> +	/* Apply constraints from sysfs */
> +	*min_freq = max(*min_freq, devfreq->min_freq);
> +	*max_freq = min(*max_freq, devfreq->max_freq);
> +
> +	/* Apply constraints from OPP interface */
> +	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
> +	/* scaling_max_freq can be zero on error */
> +	if (devfreq->scaling_max_freq)

nitpick:
This if statement is necessary?

The patch3 in this series initializes the 'devfreq->scaling_max_freq'
is ULONG_MAX if failed to get the available frequency from find_available_max_freq.

> +		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> +
> +	if (*min_freq > *max_freq)
> +		*min_freq = *max_freq;
> +}
> +
>  /**
>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>   * @devfreq:	the devfreq instance
>   * @freq:	the target frequency
>   */
> @@ -348,20 +391,11 @@ int update_devfreq(struct devfreq *devfreq)
>  
>  	/* Reevaluate the proper frequency */
>  	err = devfreq->governor->get_target_freq(devfreq, &freq);
>  	if (err)
>  		return err;
> -
> -	/*
> -	 * Adjust the frequency with user freq, QoS and available freq.
> -	 *
> -	 * List from the highest priority
> -	 * max_freq
> -	 * min_freq
> -	 */
> -	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
> -	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
> +	get_freq_range(devfreq, &min_freq, &max_freq);
>  
>  	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
> @@ -1281,40 +1315,28 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
> -
>  	df->min_freq = value;
>  	update_devfreq(df);
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
> +	get_freq_range(df, &min_freq, &max_freq);
> +	mutex_unlock(&df->lock);
> +
> +	return sprintf(buf, "%lu\n", min_freq);
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -1326,40 +1348,32 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
> +	get_freq_range(df, &min_freq, &max_freq);
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

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
