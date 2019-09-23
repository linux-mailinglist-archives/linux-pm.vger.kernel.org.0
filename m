Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6216FBBBCA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfIWSry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 14:47:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44569 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfIWSry (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 14:47:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so9632088pfn.11
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0CBkmXcDAyhOIJqhA2ULW0sHJ2yoexO3BhmE1zV/RMg=;
        b=IYUeEtJXp7RVmhOXjjhxUXjVjWFTgGkRXaUGQ0di134k5x9Mwm/JDvEu242RNxyoXm
         fPblK8yjEFZnouwPLm9MDga24tjCFS13RKja4XHC1rVPLb6/9ssRB/25XPo2xidjSEf5
         8iowXvgKdkzq8LEW3hFSSNPtdqfeGetOY8cxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0CBkmXcDAyhOIJqhA2ULW0sHJ2yoexO3BhmE1zV/RMg=;
        b=YjshJS3FZuB9J6Clu6E3UqG9IH3D3lY2PcCbalS44e/RFrZ5rD9Hn0RRWOSDKOGa6F
         Ej0FX6bt6KV4qQrytYbkZXe3icn21rVz7BRluVS0yrWuvY/et0MpJnaZDq0hR6iABh3C
         72JmbBMdKmwaFSQXrFdSKHwekcWz5/lWOlLDWfjS74cKh7mXyaC8MfYhtnIYyhDhZOpe
         liJaMD9v36uy0RY8gicXm1KQfS3kkgUlL+UI5M790HWiysz4azz/V5JgByZN03hk+LD9
         bMo4nDC4mOti+G3Y910ntWWiK9fzHj8NeiQGIvtelIDs8a/Rc3MZ9H0wUjQ0rcTEVDYA
         gvHw==
X-Gm-Message-State: APjAAAVgu3eja3lJaDC/Sf8QXyBBoB+0G8o2sNzmyQtCExy57cjGrhf+
        ERX4L+IUwiTqUbSys7KX94tEtw==
X-Google-Smtp-Source: APXvYqwY4PIF+uaXM+GJQN/H4ktQnNEgQ3czxz00rTi2CUVRwIag2ol+YEKs+3UJsBpl44llMWgg9w==
X-Received: by 2002:a62:32c5:: with SMTP id y188mr1072011pfy.97.1569264473646;
        Mon, 23 Sep 2019 11:47:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t68sm11213382pgt.61.2019.09.23.11.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:47:53 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:47:50 -0700
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
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v6 6/6] PM / devfreq: Use PM QoS for sysfs min/max_freq
Message-ID: <20190923184750.GB133864@google.com>
References: <cover.1569252537.git.leonard.crestez@nxp.com>
 <d103b4b19b63640233bd449486466e0c24232e35.1569252537.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d103b4b19b63640233bd449486466e0c24232e35.1569252537.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 06:51:09PM +0300, Leonard Crestez wrote:
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
> ---
>  drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++++--------------
>  include/linux/devfreq.h   |  9 +++----
>  2 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index a4c7dde17a06..4c58fbf7d4e4 100644
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
>  	/* constraints from OPP interface: */
>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>  	/* scaling_max_freq can be zero on error */
>  	if (devfreq->scaling_max_freq)
>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> @@ -674,10 +670,12 @@ static void devfreq_dev_release(struct device *dev)
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
> @@ -742,18 +740,26 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> @@ -837,10 +843,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  err_dev:
>  	/*
>  	 * Cleanup path for errors that happen before registration.
>  	 * Otherwise we rely on devfreq_dev_release
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
> @@ -1401,14 +1411,17 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req, value);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> @@ -1433,19 +1446,19 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
> + * @user_max_freq_req:	PM QoS max frequency request from user (via sysfs)
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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
