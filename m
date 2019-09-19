Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF095B8093
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392010AbfISSH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 14:07:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38223 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391305AbfISSH1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 14:07:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so2332027pgi.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6zOXFEBSPDZErMe9LV7l8EKhi6rWrhgSCyFAiesvqHY=;
        b=Dr2/UNlNG3sv0cx7PB+rSh4YJYAyZuRnRj20BMJkFtIVY13eSorTbe31N66kTu2+rL
         ivGfQuS8py4c7wiZLTrme+D2Ln2F5DvEhuk1N/mDeECEyc8E7Emb/awKK8T7ajiiB9ui
         qIpewSGPBDXuBhdcAkJAYnXcyi9XA4KQW9LWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6zOXFEBSPDZErMe9LV7l8EKhi6rWrhgSCyFAiesvqHY=;
        b=jMmye28r80zQsbhs3hda/qNi8Qnq8fMGPIRzrFU5T/TmdWD0d5Dnyw2Q7LexB51IMn
         3Yb6o1x/OnPlLKV4DWQ8EEMUpZR7U2g7ODl6BRzOuHVoBGdsEP73c3zlhgee/JTFSFg0
         +sFXe3IrcsgmoxYcSu0wDP405BtrLM8lm6tI5Lz0B5CqNnP0jcSZrTV9vKy3IkPlmOXU
         0+k2DZ4/pgckxlMacbqGXLmzs8TR78FWRRZTuruOEX1EFBqRT/zb0G+4j78OeBSR8uMA
         NbEp59iiCFUIu2DjITGKZGvRDrGh/JhGcRvIOGoc4pvCyOEXkCrS+4AkIS2vNAuG0WlE
         yFEA==
X-Gm-Message-State: APjAAAXF6Zxw+NN8tvd1qoVyfXu/WapYIi7sTKbHKt1kpIKU7V5NUUf7
        IFbs92w6pu6FugASrrplsjuU+g==
X-Google-Smtp-Source: APXvYqwxu4qKbBsqkCVgsollebgqQKv9fNb34P5+qEIWvXb5p2z0UPMn14XUI3+rXP6gBriLWKt2FA==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr10896199pgl.333.1568916445963;
        Thu, 19 Sep 2019 11:07:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l23sm8059715pgj.53.2019.09.19.11.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 11:07:24 -0700 (PDT)
Date:   Thu, 19 Sep 2019 11:07:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/8] PM / devfreq: Introduce devfreq_get_freq_range
Message-ID: <20190919180722.GT133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <730613d6f7182c6a6784fd509d6324f28be2cac3.1568764439.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <730613d6f7182c6a6784fd509d6324f28be2cac3.1568764439.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On Wed, Sep 18, 2019 at 03:18:24AM +0300, Leonard Crestez wrote:
> Moving handling of min/max freq to a single function and call it from
> update_devfreq and for printing min/max freq values in sysfs.
> 
> This changes the behavior of out-of-range min_freq/max_freq: clamping
> is now done at evaluation time. This means that if an out-of-range
> constraint is imposed by sysfs and it later becomes valid then it will
> be enforced.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 111 +++++++++++++++++++++-----------------
>  1 file changed, 63 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 860cbbab476c..51a4179e2c69 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -24,10 +24,12 @@
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define HZ_PER_KHZ 1000
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
> +				   unsigned long *min_freq,
> +				   unsigned long *max_freq)
> +{
> +	unsigned long *freq_table = devfreq->profile->freq_table;
> +
> +	lockdep_assert_held(&devfreq->lock);
> +
> +	/* Init min/max frequency from freq table */
> +	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
> +		*min_freq = freq_table[0];
> +		*max_freq = freq_table[devfreq->profile->max_state - 1];
> +	} else {
> +		*min_freq = freq_table[devfreq->profile->max_state - 1];
> +		*max_freq = freq_table[0];
> +	}
> +
> +	/* constraints from sysfs: */
> +	*min_freq = max(*min_freq, devfreq->min_freq);
> +	*max_freq = min(*max_freq, devfreq->max_freq);
> +
> +	/* constraints from opp interface: */

nit: OPP

> +	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
> +	/* scaling_max_freq can be zero on error */
> +	if (devfreq->scaling_max_freq)
> +		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> +
> +	/* max_freq takes precedence over min_freq */
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
>  	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
>  	if (freq > max_freq) {
> @@ -1293,40 +1327,28 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
> +	devfreq_get_freq_range(df, &min_freq, &max_freq);
> +	mutex_unlock(&df->lock);
> +
> +	return sprintf(buf, "%lu\n", min_freq);
>  }
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
>  {
> @@ -1338,40 +1360,33 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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

Nice, having the constraint evaluation in a single function makes it
easier to follow the code. Clamping userspace constraints at runtime
makes sense.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

I plan to take a look at the rest of the series, but probably won't
find time for all of it before next week.
