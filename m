Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0878118EE66
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 04:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgCWDRi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Mar 2020 23:17:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32964 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgCWDRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Mar 2020 23:17:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id j1so4107524pfe.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2020 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4TZKS6d2y1eHYS1jppzyvKAfOVpYJMMu/Ehs0CdOMQ=;
        b=oy7AW0C4+1A9gMD6L/aMJGFCcFb+ub8nHaXwstcdSZj5UK6Y9WQ+dSQInkxvWPGAPd
         atYUGcC2fqdoRJ5YsVK179OZ8nyM4/echB2BWEutHssW5MMyq+XlnYsUpmOhpLTqfDe0
         nZdhu3YAprzsDcw9cwUm4ew/BH48l3O8LeP5Z98f/MBoKh9wzaJAVlX81QDORw+nHcly
         oD8AtOmIWuqEKOsIQjTVUuvkn8DmmB9MmBjHGq26desmsW8C2XiUVKTM9o8W2INzwbNI
         9ywlGUZukQU4tME2lDsrM9IwxRuRXqyaj/L/y08Dom3IA9VSqBYnFVfekVnEPpbR4srm
         wnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4TZKS6d2y1eHYS1jppzyvKAfOVpYJMMu/Ehs0CdOMQ=;
        b=jGiYzfQI+zDLECGa8LhQpzwJQNn4+wRc3x25o51DMPoJ+EdIrSY/fjB6d+tHvFnoRk
         0h4GWFwqW0e9OWFKOo1/o0mz56m2+AHnzC/+n2ryieyuVNUb1ydaV5O3bhDjQHfUi9lL
         kIICNMtumSU2CxNzZ1IiElVVgLx8e6X1WmCwCbj3UCRjrbap4W/5bLP7maM+EVIv0ecb
         yCib9EM9hji4ymWqqIubV5hoQUKMWGvZwsWDEtNbd7eqnC+IRc5yToLBRcQTrsQvy7a9
         sPT3EBkeV26wn20VYYjEwyD3mVQ35uhmVbmkWSXcO60LSXv6EcYdd+JYKr2didxXFaNf
         f9TQ==
X-Gm-Message-State: ANhLgQ2btynIPQe54JqLSAP92J9esr+uuPPso7fQYBAueVbcXK0YNZhf
        aY+zKkLR3zDxROb9Mt2Fq75WfQ==
X-Google-Smtp-Source: ADFU+vves3/aQr7oLsJhGchZWXzKMdM3mh+P/th94kW7rLjU1R6jxUU6OV6sQnzpH/J+h5YTyQdu4g==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr22672571pfl.252.1584933455399;
        Sun, 22 Mar 2020 20:17:35 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id i4sm2741719pjg.4.2020.03.22.20.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 20:17:34 -0700 (PDT)
Date:   Mon, 23 Mar 2020 08:47:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix return of
 cpufreq_set_cur_state
Message-ID: <20200323031724.xnbr6wmbzwpwutn4@vireshk-i7>
References: <20200321092740.7vvwfxsebcrznydh@macmini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321092740.7vvwfxsebcrznydh@macmini.local>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-03-20, 09:27, Willy Wolff wrote:
> The function freq_qos_update_request returns 0 or 1 describing update
> effectiveness, and a negative error code on failure. However,
> cpufreq_set_cur_state returns 0 on success or an error code otherwise.
> 
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index fe83d7a210d4..af55ac08e1bd 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -431,6 +431,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  				 unsigned long state)
>  {
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +	int ret;
>  
>  	/* Request state should be less than max_level */
>  	if (WARN_ON(state > cpufreq_cdev->max_level))
> @@ -442,8 +443,9 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  
>  	cpufreq_cdev->cpufreq_state = state;
>  
> -	return freq_qos_update_request(&cpufreq_cdev->qos_req,
> -				get_state_freq(cpufreq_cdev, state));
> +	ret = freq_qos_update_request(&cpufreq_cdev->qos_req,
> +				      get_state_freq(cpufreq_cdev, state));
> +	return ret < 0 ? ret : 0;
>  }
>  
>  /* Bind cpufreq callbacks to thermal cooling device ops */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
