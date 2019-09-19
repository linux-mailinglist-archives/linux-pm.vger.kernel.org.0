Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7649EB820B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbfIST7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 15:59:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46452 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390537AbfIST7H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 15:59:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so2459826pgm.13
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hhfYGawXnW6uZYoOjBbGCOHapRV4NV4Ipk+mhG/LMb4=;
        b=cMPAoE2CVW4AHsyImxaghCHK23cQoodnjiTjkJtwnGtLNE2+IHxFvKJ9H04OIAyo2S
         4/nNZzIBT1UIoxQVEGfj+dfnHnOBETTXEjCXbrxMDswzMk8cBD3rBOUkvUDgZLiRRuF7
         HCfQaDrV6cM/MdqhbD36FvXKfn+XsMM+BYuB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hhfYGawXnW6uZYoOjBbGCOHapRV4NV4Ipk+mhG/LMb4=;
        b=slzjX2StTJPzyBmyksAeEFztn4/hhggfvB1ROLeZrtRruLrI99EjwOdMJAKFP7BJcn
         zwAy78bURbk3aoZfOcuE/xq7E7t7pneIFX4dXhHCEa/07Y/anbQl36JEfIPlb8wyhheq
         nIjKanNlzXruF1wQ1EtDQ4jkZjUTCJj0kqe6l/bFUfaEhDENP8PNITCwOicj5XhlpLE2
         mgc3ltbobcPOKX7Y9Kp5p/wAr3f7xRr6FdV1NQpwhAOkMO5BT/XF6Honw6RpsWw2jCJ+
         3IsBPTIkorxsQvodz1Ht6kYGtReBC1BgVshcG9U9fUibKS+Xs5jPdDko3z49T9uR0Ptq
         TtgA==
X-Gm-Message-State: APjAAAWfu0Zit+68/4POrMzS99qcbUrbCnVGLUOcECtzshkb/PCbbXmt
        sLgtRamgxtih3XApUCUIeu9aUw==
X-Google-Smtp-Source: APXvYqzHI02bCChGq61Le1kggMWELJvMhyYhBSfPs7Bhm47tqwyAWhdAowbHugKpU4p0XwGvghPeJQ==
X-Received: by 2002:a63:ba47:: with SMTP id l7mr10690493pgu.201.1568923144882;
        Thu, 19 Sep 2019 12:59:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j4sm11101737pfn.29.2019.09.19.12.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:59:04 -0700 (PDT)
Date:   Thu, 19 Sep 2019 12:59:02 -0700
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
Subject: Re: [PATCH 7/8] PM / devfreq: Use dev_pm_qos for sysfs min/max_freq
Message-ID: <20190919195902.GX133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <a80dae0a1aec9932689aaadff68bcabc94a816be.1568764439.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a80dae0a1aec9932689aaadff68bcabc94a816be.1568764439.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 03:18:26AM +0300, Leonard Crestez wrote:
> Switch the handling of min_freq and max_freq from sysfs to use the
> dev_pm_qos interface.

nit: PM QoS?

if you agree please change all instances in comments.

> Since dev_pm_qos handles frequencies as kHz this change reduces the
> precision of min_freq and max_freq. This shouldn't introduce problems
> because frequencies which are not an integer number of kHz are likely
> not an integer number of Hz either.
> 
> Try to ensure compatibilitity by rounding min values down and rounding
> max values up.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++--------------
>  include/linux/devfreq.h   |  9 ++++---
>  2 files changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index d8d57318b12c..7977bad93949 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -132,14 +132,10 @@ static void devfreq_get_freq_range(struct devfreq *devfreq,
>  	*min_freq = max(*min_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
>  				devfreq->dev.parent, DEV_PM_QOS_MIN_FREQUENCY));
>  	*max_freq = min(*max_freq, HZ_PER_KHZ * (unsigned long)dev_pm_qos_read_value(
>  				devfreq->dev.parent, DEV_PM_QOS_MAX_FREQUENCY));
>  
> -	/* constraints from sysfs: */
> -	*min_freq = max(*min_freq, devfreq->min_freq);
> -	*max_freq = min(*max_freq, devfreq->max_freq);
> -
>  	/* constraints from opp interface: */
>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>  	/* scaling_max_freq can be zero on error */
>  	if (devfreq->scaling_max_freq)
>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> @@ -675,10 +671,12 @@ static void devfreq_dev_release(struct device *dev)
>  			DEV_PM_QOS_MIN_FREQUENCY);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	dev_pm_qos_remove_request(&devfreq->max_freq_req);
> +	dev_pm_qos_remove_request(&devfreq->min_freq_req);

mega-nit: keep common mix/max order since it doesn't really matter here?

>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  }
> @@ -743,18 +741,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> +	/* dev_pm_qos requests for min/max freq from sysfs */
> +	err = dev_pm_qos_add_request(dev, &devfreq->min_freq_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (err < 0) {
> +		goto err_dev;
> +	}

no curly braces needed for single line.

> +	err = dev_pm_qos_add_request(dev, &devfreq->max_freq_req,
> +				     DEV_PM_QOS_MAX_FREQUENCY, S32_MAX);
> +	if (err < 0) {
> +		goto err_dev;
> +	}

ditto

>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
>  	devfreq->trans_table = kzalloc(
> @@ -833,10 +841,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_unlock(&devfreq_list_lock);
>  err_devfreq:
>  	devfreq_remove_device(devfreq);
>  	return ERR_PTR(err);
>  err_dev:
> +	if (dev_pm_qos_request_active(&devfreq->max_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->max_freq_req);
> +	if (dev_pm_qos_request_active(&devfreq->min_freq_req))
> +		dev_pm_qos_remove_request(&devfreq->min_freq_req);
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
> @@ -1397,14 +1409,17 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
> +	if (value)
> +		value = value / HZ_PER_KHZ;
> +
> +	ret = dev_pm_qos_update_request(&df->min_freq_req, value);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> @@ -1429,19 +1444,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
> +	if (value)
> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
> +	else
> +		value = S32_MAX;
>  
> -	df->max_freq = value;
> -	update_devfreq(df);
> -	mutex_unlock(&df->lock);
> +	ret = dev_pm_qos_update_request(&df->max_freq_req, value);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  static DEVICE_ATTR_RW(min_freq);
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index dac0dffeabb4..4b5cc80abbe3 100644
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

'(0: none)' is not correct anymore.

Maybe also say that it's a PM QoS request?

Since you are already changing the variable name it could be a good
opportunity to make it more specific, i.e. make clear that it's the
userspace constraint.

e.g.

min_freq_req_user
user_min_freq_req
min_freq_user_req

or

struct {
       struct {
       	      min;
	      max;
       } user;

       struct {
       	      min;
       	      max;
       } scaling; // not a great name, but that's what it is currently ...
} freq_constraints;

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
