Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E63114677
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 19:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfLESC4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 13:02:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41408 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLESC4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 13:02:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id s18so1958280pfd.8
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NntSUoTKX+q7nGQOHdsVUrXLAyg3WVr9iYiJ9osLXaU=;
        b=QaH9pSXa0aFHDT/rdpGomSfvyEcjfPzyM1IESGhiv0uXXJNybSdQv2rdA3gSC+gl6A
         R/WS5UokvUczEkcQnWoJ3I67VSPi7IZJs2FNE6YNYzH1C46pRANxKz19t3Z6qn7EP3I4
         J4fi0BqApaI7+Cz3QjSEVzI8b2u2ezbiR2BJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NntSUoTKX+q7nGQOHdsVUrXLAyg3WVr9iYiJ9osLXaU=;
        b=WNtMueLvCZWZM6RV5GeaqYYR0lQtCxF18BT6G+co5rZkVuuSqdaxVT9pn52a5WhDgp
         0AWgYs9cgSzgOn7qQQFkWB6UZ7q4aayvei0zcdDuRlPR9L5J/YLBlrq8dDBue7QDODPY
         i/FDnuLyIHtJd4j1TRgK2DNi0D5lzmCB8mVlzziASn6uuB5V6/Y7tsihRT9iUu4ydc1Q
         pTZaYFPdZJUlZdZZw/qFcDMJh1hvYhhias1I/otYLqMSYdkLvC1nmizcQzM440N0WF6m
         meQE+894zG1sNMEO3+tx1BfxCzven5sDjGtfp271w4J3VOt9V7QrHYama6EDXIMb/Huo
         42Sg==
X-Gm-Message-State: APjAAAW1cuI1kIyJVcn5WVTeFL8fEmvR34qmDGhHVbqeNTjYeQ2wlThK
        mQF5qshk9prI6TmmjTqGt1u/rA==
X-Google-Smtp-Source: APXvYqx7PiemGSUQeZz4xakKD7Li6c726xm7L7hqG1m4RJTC1fjYw1mSg4p1ltuzy6c835BWLfMdWg==
X-Received: by 2002:a63:5056:: with SMTP id q22mr10570932pgl.20.1575568975339;
        Thu, 05 Dec 2019 10:02:55 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p16sm12368615pgm.8.2019.12.05.10.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:02:54 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:02:53 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PM / devfreq: Use PM QoS for sysfs min/max_freq
Message-ID: <20191205180253.GN228856@google.com>
References: <cover.1575540224.git.leonard.crestez@nxp.com>
 <2b9eeb4e576c45269c01826f13c7811b876faa57.1575540224.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b9eeb4e576c45269c01826f13c7811b876faa57.1575540224.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 05, 2019 at 12:05:07PM +0200, Leonard Crestez wrote:
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
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 76 ++++++++++++++++++++++++++++++---------
>  include/linux/devfreq.h   |  9 ++---
>  2 files changed, 64 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e8b943fc4259..bcb286509547 100644
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
>  	*max_freq = min(*max_freq, devfreq->scaling_max_freq);
>  
>  	if (*min_freq > *max_freq)
> @@ -703,10 +699,23 @@ static void devfreq_dev_release(struct device *dev)
>  					 DEV_PM_QOS_MIN_FREQUENCY);
>  	if (err && err != -ENOENT)
>  		dev_warn(dev->parent,
>  			"Failed to remove min_freq notifier: %d\n", err);
>  
> +	if (dev_pm_qos_request_active(&devfreq->user_max_freq_req)) {
> +		err = dev_pm_qos_remove_request(&devfreq->user_max_freq_req);
> +		if (err)
> +			dev_warn(dev->parent,
> +				"Failed to remove max_freq request: %d\n", err);
> +	}
> +	if (dev_pm_qos_request_active(&devfreq->user_min_freq_req)) {
> +		err = dev_pm_qos_remove_request(&devfreq->user_min_freq_req);
> +		if (err)
> +			dev_warn(dev->parent,
> +				"Failed to remove min_freq request: %d\n", err);
> +	}
> +
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
> @@ -776,19 +785,17 @@ struct devfreq *devfreq_add_device(struct device *dev,
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
> @@ -825,10 +832,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
>  	mutex_unlock(&devfreq->lock);
>  
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_min_freq_req,
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +	if (err < 0)
> +		goto err_devfreq;
> +	err = dev_pm_qos_add_request(dev, &devfreq->user_max_freq_req,
> +				     DEV_PM_QOS_MAX_FREQUENCY,
> +				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
> +	if (err < 0)
> +		goto err_devfreq;
> +
>  	devfreq->nb_min.notifier_call = qos_min_notifier_call;
>  	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
>  				      DEV_PM_QOS_MIN_FREQUENCY);
>  	if (err)
>  		goto err_devfreq;
> @@ -1418,18 +1435,26 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  	unsigned long value;
>  	int ret;
>  
> +	/*
> +	 * Protect against theoretical sysfs writes between
> +	 * device_add and dev_pm_qos_add_request
> +	 */
> +	if (!dev_pm_qos_request_active(&df->user_min_freq_req))
> +		return -EINVAL;

The error code -EINVAL is a bit misleading. I guess it's not super
important, especially since this is a very rare case. In case you
re-spin you could consider returning -EAGAIN ('Resource temporarily
unavailable') in this case from min/max_freq_store/show()

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
