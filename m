Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE357CC14A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfJDRFQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 13:05:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44351 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfJDRFP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 13:05:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so4230751pfn.11
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7WcSZZeD+MKzcdOOdX6Ec/KkIbWWrsXycEBp6qCNW+Q=;
        b=WQlg5gH4TvsQj9MdH4CAkIkHVJMDvTHUa1YRY+efOo3XiTfU6eTv2KLfpwnZYiAnbh
         jsXNgUsvXEB2E9vHUz2xCUS2XUKcvEkrCkmEdyApnsA387upCYAadenA2X35WNE+fTAy
         bBsDLobadqgjfr43OVSLRRI70rCdpJO/95hiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7WcSZZeD+MKzcdOOdX6Ec/KkIbWWrsXycEBp6qCNW+Q=;
        b=fn8UpsYVqFHj8TgXPL82/hc/OjizY8+RyThBkb40ozTFU5JgGsKyaKzpAJ266CE0Rf
         4GMOvDvnMWqleZ8ItAkhl4MoZU+GKEN7+Y50QmVLnknegZ28Kh4TqiDYYBuW2jt2uy0I
         M1rU7VNRFzON3TGAsZ/PeThymMiGIeT22D3tiS+9nGiyvSwfz9/zg565B0D2mB/aWFi2
         24ysYd/fQ6WDbmQto2P5nJKLbn3AVeYK4E+am9Zka7JymtasNdWJQkxc1jPJlvaexwmL
         OWX5PZOuqsnOcT+WUcwSB/tg7eGgfnUJqe8rU9pXt6uflAv/xkUCHYg42kVWLOP0AAKg
         IomA==
X-Gm-Message-State: APjAAAWnJTzsO+6tod2gaNqb8URtrR19qt1viT08atkaB4gfG1SrXVzx
        LwQuTRG7KGOkXeTGLh9WcHYA1Q==
X-Google-Smtp-Source: APXvYqy+j0NZduXbdpAQagE8KCfWd4oDirEpNCra7THfxwooAIXXxa3Zu96+oAGzHo6st6ZVEDRlvw==
X-Received: by 2002:a62:8142:: with SMTP id t63mr18450323pfd.246.1570208714816;
        Fri, 04 Oct 2019 10:05:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 196sm12053609pfz.99.2019.10.04.10.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 10:05:14 -0700 (PDT)
Date:   Fri, 4 Oct 2019 10:05:12 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 8/8] PM / devfreq: Use PM QoS for sysfs min/max_freq
Message-ID: <20191004170512.GM87296@google.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
 <62584a1e5c08d0f9254df505883fb220ba53d57b.1570044052.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <62584a1e5c08d0f9254df505883fb220ba53d57b.1570044052.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 10:25:11PM +0300, Leonard Crestez wrote:
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
>  drivers/devfreq/devfreq.c | 63 ++++++++++++++++++++++++++++-----------
>  include/linux/devfreq.h   |  9 +++---
>  2 files changed, 51 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 46f699b84a22..4ff5fbc4ee85 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -139,14 +139,10 @@ static void get_freq_range(struct devfreq *devfreq,
>  	*min_freq = max(*min_freq, (unsigned long)HZ_PER_KHZ * qos_min_freq);
>  	if (qos_max_freq != PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE)
>  		*max_freq = min(*max_freq,
>  				(unsigned long)HZ_PER_KHZ * qos_max_freq);
>  
> -	/* Apply constraints from sysfs */
> -	*min_freq = max(*min_freq, devfreq->min_freq);
> -	*max_freq = min(*max_freq, devfreq->max_freq);
> -
>  	/* Apply constraints from OPP interface */
>  	*min_freq = max(*min_freq, devfreq->scaling_min_freq);
>  	/* scaling_max_freq can be zero on error */
>  	if (devfreq->scaling_max_freq)
>  		*max_freq = min(*max_freq, devfreq->scaling_max_freq);
> @@ -690,10 +686,18 @@ static void devfreq_dev_release(struct device *dev)
>  			 err);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	err = dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> +	if (err)
> +		dev_warn(dev->parent, "Failed to remove DEV_PM_QOS_MAX_FREQUENCY request: %d\n",
> +			 err);
> +	err = dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
> +	if (err)
> +		dev_warn(dev->parent, "Failed to remove DEV_PM_QOS_MIN_FREQUENCY request: %d\n",
> +			 err);
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
> @@ -758,18 +762,26 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> +				     DEV_PM_QOS_MAX_FREQUENCY,
> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> +	if (err < 0)
> +		goto err_dev;
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
>  	devfreq->trans_table = kzalloc(
> @@ -848,10 +860,16 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  err_dev:
>  	/*
>  	 * Cleanup path for errors that happen before registration.
>  	 * Otherwise we rely on devfreq_dev_release.
>  	 */
> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req))
> +		if (dev_pm_qos_remove_request(&devfreq->user_max_freq_req))
> +			dev_warn(dev, "Failed to remove DEV_PM_QOS_MAX_FREQUENCY request\n");
> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req))
> +		if (dev_pm_qos_remove_request(&devfreq->user_min_freq_req))
> +			dev_warn(dev, "Failed to remove DEV_PM_QOS_MIN_FREQUENCY request\n");
>  	kfree(devfreq->time_in_state);
>  	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
> @@ -1392,14 +1410,15 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -	df->min_freq = value;
> -	update_devfreq(df);
> -	mutex_unlock(&df->lock);
> +	/* Round down to kHz for PM QoS */
> +	ret = dev_pm_qos_update_request(&df->user_min_freq_req,
> +					value / HZ_PER_KHZ);
> +	if (ret < 0)
> +		return ret;
>  
>  	return count;
>  }
>  
>  static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
> @@ -1424,18 +1443,28 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&df->lock);
> -
> -	if (!value)
> -		value = ULONG_MAX;
> +	/*
> +	 * PM QoS frequencies are in kHz so we need to convert. Convert by
> +	 * rounding upwards so that the acceptable interval never shrinks.
> +	 *
> +	 * For example if the user writes "666666666" to sysfs this value will
> +	 * be converted to 666667 kHz and back to 666667000 Hz before an OPP
> +	 * lookup, this ensures that an OPP of 666666666Hz is still accepted.
> +	 *
> +	 * A value of zero means "no limit".
> +	 */
> +	if (value)
> +		value = DIV_ROUND_UP(value, HZ_PER_KHZ);
> +	else
> +		value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
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
> index 8b92ccbd1962..fb376b5b7281 100644
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
> + * @user_min_freq_req:	PM QoS minimum frequency request from user (via sysfs)
> + * @user_max_freq_req:	PM QoS maximum frequency request from user (via sysfs)
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
> -- 
> 2.17.1
> 

Tested-by: Matthias Kaehlcke <mka@chromium.org>
