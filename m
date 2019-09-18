Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1AB6FAF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 01:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfIRX3J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 19:29:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36672 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbfIRX3J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 19:29:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id m29so751967pgc.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xkSAHLojjpoJjVoNc1BW0mr4HJS6Pbtg1jwjCnh3QCI=;
        b=hAauSUP5UaViSzCRq0EKIC4YzU2nskkSrg4ZGnVbrYp/XXBzJ46HAMnj9EAwu4YtKp
         E4KIFQ2BKRpP3DO3CyNDa365WBPB47eW6TCcZz3bN4tW+duJrvt3NZtzScga2H9iReAX
         EGYcbu3JXWAkSMh6SwY7BnXff/BrhjvptGwvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xkSAHLojjpoJjVoNc1BW0mr4HJS6Pbtg1jwjCnh3QCI=;
        b=Rx2XZLVBNazTLxvTqyEHD3wFmRxhOEwj5sYTZ44+RrYanY0anf+HhZZKzv4Ikzrtsm
         YXQh3/v/KxekH8TY/S9QhoK4IH4RMNtaXQBBsmfofmpYeUCuM+kt5gs76sxxY2CZyJh2
         hzXDyd2GCIVAuEwlCJI9vjZjsPj8dC74eozdXXVote0iDvYZW7g2LTn/sLqs18QddBBX
         8wjp5h0zTN48WcJJVaGuYMJg8r633YIfv7O1tGceJmk/OlwfHvvxQLKNMYZEnF71o5At
         pmTxtJ+8jQ+9w6p2AbzCi2LJJADvdSkiEHTF50ZU/9B/OcpRZMhL2A3wBKGVSZj7fdCS
         GLZw==
X-Gm-Message-State: APjAAAUQdhW2IAzJ67F+KyZceEy2+zohgQPhLzLkJOtm+pn5sQNnpIGw
        SebeDvFtbPieV3FOf2rSWjvnZA==
X-Google-Smtp-Source: APXvYqwCuTM1Y/zo1nM7wFA2UvVoZjRZ/YbI8o0M/84ds1jVpWuIesSxUztoUh6l6JOlD1ZVb8OAyA==
X-Received: by 2002:a63:211c:: with SMTP id h28mr6301450pgh.372.1568849347203;
        Wed, 18 Sep 2019 16:29:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k13sm7533807pfa.138.2019.09.18.16.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 16:29:06 -0700 (PDT)
Date:   Wed, 18 Sep 2019 16:29:04 -0700
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
Subject: Re: [PATCH 3/8] PM / devfreq: Move more initialization before
 registration
Message-ID: <20190918232904.GP133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <59bd0d871fad520eb417ca46943fa7f86ef9186a.1568764439.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59bd0d871fad520eb417ca46943fa7f86ef9186a.1568764439.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On Wed, Sep 18, 2019 at 03:18:22AM +0300, Leonard Crestez wrote:
> In general it is a better to initialize an object before making it
> accessible externally (through device_register).
> 
> This make it possible to avoid relying on locking a partially
> initialized object.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index a715f27f35fd..57a217fc92de 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -589,10 +589,12 @@ static void devfreq_dev_release(struct device *dev)
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
>  	mutex_destroy(&devfreq->lock);
> +	kfree(devfreq->time_in_state);
> +	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  }
>  
>  /**
>   * devfreq_add_device() - Add devfreq feature to the device
> @@ -671,44 +673,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
>  	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	atomic_set(&devfreq->suspend_count, 0);
>  
> -	dev_set_name(&devfreq->dev, "devfreq%d",
> -				atomic_inc_return(&devfreq_no));
> -	err = device_register(&devfreq->dev);
> -	if (err) {
> -		mutex_unlock(&devfreq->lock);
> -		put_device(&devfreq->dev);
> -		goto err_out;
> -	}
> -
> -	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
> +	devfreq->trans_table = kzalloc(
>  			array3_size(sizeof(unsigned int),
>  				    devfreq->profile->max_state,
>  				    devfreq->profile->max_state),
>  			GFP_KERNEL);
>  	if (!devfreq->trans_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
> -		goto err_devfreq;
> +		goto err_dev;
>  	}
>  
> -	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
> -			devfreq->profile->max_state,
> -			sizeof(unsigned long),
> -			GFP_KERNEL);
> +	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
> +					 sizeof(unsigned long),
> +					 GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
> -		goto err_devfreq;
> +		goto err_dev;
>  	}
>  
>  	devfreq->last_stat_updated = jiffies;
>  
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
> +	dev_set_name(&devfreq->dev, "devfreq%d",
> +				atomic_inc_return(&devfreq_no));
> +	err = device_register(&devfreq->dev);
> +	if (err) {
> +		mutex_unlock(&devfreq->lock);
> +		put_device(&devfreq->dev);
> +		goto err_out;

  		goto err_dev;

> +	}
> +
>  	mutex_unlock(&devfreq->lock);
>  
>  	mutex_lock(&devfreq_list_lock);
>  
>  	governor = try_then_request_governor(devfreq->governor_name);
> @@ -734,14 +735,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	return devfreq;
>  
>  err_init:
>  	mutex_unlock(&devfreq_list_lock);
> -err_devfreq:
>  	devfreq_remove_device(devfreq);
> -	devfreq = NULL;
> +	return ERR_PTR(err);

The two return paths in the unwind part are unorthodox, but I
see why they are needed. Maybe add an empty line between the two paths
to make it a bit more evident that they are separate.

>  err_dev:

This code path should include

	mutex_destroy(&devfreq->lock);

That was already missing in the original code though.

Actually with the later device registration the mutex could be
initialized later and doesn't need to be held. This would
obsolete the mutex_unlock() calls in the error paths.
