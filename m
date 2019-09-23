Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B7BBAFC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 20:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440341AbfIWSLG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 14:11:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33356 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438090AbfIWSLG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2019 14:11:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id i30so2692965pgl.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2019 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GhhEfz31mW+PGEj7W6BTGm1I2h8u/1sNMqll07GDL+o=;
        b=B7/uc71+COCmNXISDVfuToHc/7xx6ZbHiSybhzuIUp8h/Tt38f23peYPKn6WRkizxY
         e2rzZOXHikdJrasBPddOGEaZxJrHf7hv3/a4fvk/PoFHBY9wAdQxl+domZZ9HLso7x26
         5adXM1HlLH8vzy16lYKAJtMCAPZPzVJkkG1Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GhhEfz31mW+PGEj7W6BTGm1I2h8u/1sNMqll07GDL+o=;
        b=Ufq1NmPbujeXSVdva94oMeJNt7/82kkm+VyKhhAKxWbeFsFe/4hqOlye3Z+rQO+YXu
         NgIH7MndYNjP7YeHdHly8aVLugerqOnm7WyWEsDr/Ohj4nrtKREZ5nFQ+L0ayTO+SFAV
         QmoZWVbU4jvJUKqhTzkDI+fD/t8HD1Jh/cYVE1BDenLHTCjtEk6PKiEueuzJc5X245H2
         i7beg7YHsjAqwtlQOvHrYS0hnZrwyyodAtVMVRtL2ap8ANybTN9Nvm6BH4c38Ljj1hQD
         o6OWZPpPqm/jeahqUuoln/fvd8RENiY7HUmSEXE1Rao+lb9A0xnfWqK8JN/omFn1JYP5
         ls7g==
X-Gm-Message-State: APjAAAXb79tjj/1lQLh/bbTVnDM08/J8SC1vzSnJ0ynKknz/qTpN5v4I
        +j38RtHze2Kuj2PdaqU5K38lOA==
X-Google-Smtp-Source: APXvYqyEAISPVu49vXFMaEKnhfTAY2pgrrhfN6m8wDPmAHv/uMsb1KW1tng8IFPDpi2B77m4daL4jw==
X-Received: by 2002:a63:5652:: with SMTP id g18mr1124229pgm.393.1569262265523;
        Mon, 23 Sep 2019 11:11:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g12sm9678516pgb.26.2019.09.23.11.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:11:04 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:10:57 -0700
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
Subject: Re: [PATCH v6 2/6] PM / devfreq: Move more initialization before
 registration
Message-ID: <20190923181057.GY133864@google.com>
References: <cover.1569252537.git.leonard.crestez@nxp.com>
 <0ad496507cd7e6731e46249b1499dfdebe205c16.1569252537.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ad496507cd7e6731e46249b1499dfdebe205c16.1569252537.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 06:51:05PM +0300, Leonard Crestez wrote:
> In general it is a better to initialize an object before making it
> accessible externally (through device_register).
> 
> This makes it possible to avoid relying on locking a partially
> initialized object.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 43 +++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 323d43315d1e..b4d2bfebb140 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -587,10 +587,12 @@ static void devfreq_dev_release(struct device *dev)
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> +	kfree(devfreq->time_in_state);
> +	kfree(devfreq->trans_table);
>  	mutex_destroy(&devfreq->lock);
>  	kfree(devfreq);
>  }
>  
>  /**
> @@ -670,44 +672,43 @@ struct devfreq *devfreq_add_device(struct device *dev,
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

As per my comment on v5 I think the goto needs to go to 'err_dev'. The
device registration failed, hence devfreq_dev_release() won't be
called to free allocated memory.

> +	}
> +
>  	mutex_unlock(&devfreq->lock);
>  
>  	mutex_lock(&devfreq_list_lock);
>  
>  	governor = try_then_request_governor(devfreq->governor_name);
> @@ -733,14 +734,20 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	return devfreq;
>  
>  err_init:
>  	mutex_unlock(&devfreq_list_lock);
> -err_devfreq:
>  	devfreq_remove_device(devfreq);
> -	devfreq = NULL;
> +	return ERR_PTR(err);
> +
>  err_dev:
> +	/*
> +	 * Cleanup path for errors that happen before registration.
> +	 * Otherwise we rely on devfreq_dev_release

nit: add a period at the end of the second sentence.

> +	 */
> +	kfree(devfreq->time_in_state);
> +	kfree(devfreq->trans_table);
>  	kfree(devfreq);
>  err_out:
>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(devfreq_add_device);
