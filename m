Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E005B6FFF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfISAUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 20:20:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38040 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbfISAUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 20:20:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so803835pgi.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tHO8idxYvCXO7Xl0b0Brpx8nnJ3dAZiCIzv0ysrkpR8=;
        b=J0Do6o5AerwDtZyl8dLc9miEApIwpFWAOanu8xKsifMz54iwBW/mgpw+1gwHLYcYhb
         GfIBEIxKedStctxiR2NJ+SRy5b/TDIbRGkDJV9aMApwkXSq8rUwJJlnrm7Cs9dl6FfEE
         CpXtOy7mw+Gop6f/TGdPWDRX0OAHy3Ib5A/Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tHO8idxYvCXO7Xl0b0Brpx8nnJ3dAZiCIzv0ysrkpR8=;
        b=IeOrc102NNZkr1SC3ehfo/+e9/6thnHDf9vlusigCz2Ft8B029R6Otl6783UeZ9YHC
         gKHVEtwGwfe0F/Ko1gHVCXiBErQlaUpFmmPhmMXCpOWWFtjgqmwwo1sT2tH3oA0m59Uc
         m8yxWfu5bQgPqJ1TQAm5BTxA0pfbHGXtZFx4Ah9o7y6KgwZya8ivD4lKNNbznjS68nLy
         UIxFhuQS1Fb4zwbpNJlk/BZv8OP41XV4C4GPIppDhvjYZHcz/+U11hZ5v5uNgXxHSXg9
         I85hDfFrsN3Hu9JB41bq/tA2Myd5SD0koaViLMtrSwQ7T7009bLmJ+cqDkoyuuy/sRAX
         76JQ==
X-Gm-Message-State: APjAAAXHIIqbolSjWOVkm/lKOCp0PVveWu2pAxmqvmivz+MlzBd6F+85
        QOdNlz3s+JKJVyu0UO5wqCnJRA==
X-Google-Smtp-Source: APXvYqxQXGfAj7Tm6yt4FaTaG/b5TVZyScNcObutnzEEg2k7jmyKhq+EBKSb/IemFBLdTCyPk6sZrA==
X-Received: by 2002:a63:4857:: with SMTP id x23mr6593458pgk.142.1568852417268;
        Wed, 18 Sep 2019 17:20:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 1sm7888373pff.39.2019.09.18.17.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 17:20:15 -0700 (PDT)
Date:   Wed, 18 Sep 2019 17:20:13 -0700
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
Subject: Re: [PATCH 4/8] PM / devfreq: Don't take lock in devfreq_add_device
Message-ID: <20190919002013.GR133864@google.com>
References: <cover.1568764439.git.leonard.crestez@nxp.com>
 <2fe8d1000bed5de70b08ed77fc8360d159ae4434.1568764439.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fe8d1000bed5de70b08ed77fc8360d159ae4434.1568764439.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 03:18:23AM +0300, Leonard Crestez wrote:
> A device usually doesn't need to lock itself during initialization
> because it is not yet reachable from other threads.
> 
> This simplifies the code and helps avoid recursive lock warnings.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 57a217fc92de..860cbbab476c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -634,11 +634,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
>  
>  	mutex_init(&devfreq->lock);
> -	mutex_lock(&devfreq->lock);
>  	devfreq->dev.parent = dev;
>  	devfreq->dev.class = devfreq_class;
>  	devfreq->dev.release = devfreq_dev_release;
>  	INIT_LIST_HEAD(&devfreq->node);
>  	devfreq->profile = profile;
> @@ -647,28 +646,24 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
> -		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
>  			goto err_dev;
> -		mutex_lock(&devfreq->lock);
>  	}
>  
>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>  	if (!devfreq->scaling_min_freq) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
>  	devfreq->min_freq = devfreq->scaling_min_freq;
>  
>  	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>  	if (!devfreq->scaling_max_freq) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
> @@ -679,20 +674,18 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  			array3_size(sizeof(unsigned int),
>  				    devfreq->profile->max_state,
>  				    devfreq->profile->max_state),
>  			GFP_KERNEL);
>  	if (!devfreq->trans_table) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_dev;
>  	}
>  
>  	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
>  					 sizeof(unsigned long),
>  					 GFP_KERNEL);
>  	if (!devfreq->time_in_state) {
> -		mutex_unlock(&devfreq->lock);
>  		err = -ENOMEM;
>  		goto err_dev;
>  	}
>  
>  	devfreq->last_stat_updated = jiffies;
> @@ -701,17 +694,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);
>  	if (err) {
> -		mutex_unlock(&devfreq->lock);
>  		put_device(&devfreq->dev);
>  		goto err_out;
>  	}
>  
> -	mutex_unlock(&devfreq->lock);
> -
>  	mutex_lock(&devfreq_list_lock);
>  
>  	governor = try_then_request_governor(devfreq->governor_name);
>  	if (IS_ERR(governor)) {
>  		dev_err(dev, "%s: Unable to find governor for the device\n",

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
