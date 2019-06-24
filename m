Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D89501DE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 08:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfFXGFF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 02:05:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46973 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFXGFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 02:05:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so6845977pfy.13
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2019 23:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vjjia/1M9aSR2+WeUbso9u0aGhrSxlgo/tvak8yLfjI=;
        b=eiOkHAgkVZbZyjrZb9Ggr3KMs4EhF9lpTDftApoDttnZT3xSDAPRXzoRXrdmh4tOF1
         DqFfIL8aSostGecScVbWUOz9CMHQwgGoAP8dlwUIfykX5joEJFXSE7ClKp73gubr8Oh0
         4o2Wxdyy/wOVGKSKVa28GRqYCuzKNXDAqsPhEesmXrgD3c7omdrEpgluixVqki+52ONZ
         6IBL9mwhWMz9huL9RLW9FWodCNLOte1Rx6i1ZLY+ZDO81QwPzoFfT6nUwlAkaayOEq5S
         izi2h0UWiXK9llUo1pdcIeYYJgXIokr+BMRf4h5dGlU+BUEILwBDNsIAeMqNbNQpPqLM
         v3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vjjia/1M9aSR2+WeUbso9u0aGhrSxlgo/tvak8yLfjI=;
        b=Yx9SVd+2h4iow8lxku3Kq1zG6Q/lk0Ao994+6I6tnk3k2wyhjhf/t1XQd/dFCxXEX/
         ZrTkIxpPH7W/eOPU20oKYZe7c9N8194R3N62jMXDoWD4Su+kYfX/hVU2zfNxgrWOUEFc
         yvmb2AH0/gS1JYD2J08hDy6yFZ6HzZSpM47IEgRlE4L+sYn8cgzOs2j5HQEN5VoZ14TZ
         dmVJQbUq1b3d/ArqRpjylk00xHWMWJcMQRly13JEFv4D4rA6orkup06Vcgm0XrmdF8kn
         /34OO/asHkN7BHQNzwnFSJ+4N6Guw8TF47OxNNbKrD9enNYlZFjIjg20rHH3Z1BuWJJz
         uIlg==
X-Gm-Message-State: APjAAAUXEBpki0a8eVBSk0I4ML+LseFP/mhEf+oxcznsskeMertDgynw
        dKDkje5p4K/Vlv10Zb4HYeLP4g==
X-Google-Smtp-Source: APXvYqxAzfeN6vXtOHb3JICGsbAYvEcPE6ev51G3Y76BFX2HzI5UO3uZEZ4tX5qbRpClsBdUa3LEdQ==
X-Received: by 2002:a17:90a:2706:: with SMTP id o6mr23302400pje.62.1561356304358;
        Sun, 23 Jun 2019 23:05:04 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id b11sm6413643pfd.18.2019.06.23.23.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 23:05:03 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:35:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/6] cpufreq:  Remove cooling device usage
Message-ID: <20190624060502.yrjcd3subxtabpug@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621132302.30414-4-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-06-19, 15:23, Daniel Lezcano wrote:
> The cpufreq_cooling_unregister() function uses now the policy to
> unregister itself. The only purpose of the cooling device pointer is
> to unregister the cpu cooling device.
> 
> As there is no more need of this pointer, remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++----
>  include/linux/cpufreq.h   | 3 ---
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index dfbc9bea606c..1d8f85faeaca 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1379,7 +1379,7 @@ static int cpufreq_online(unsigned int cpu)
>  		cpufreq_driver->ready(policy);
>  
>  	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> -		policy->cdev = of_cpufreq_cooling_register(policy);
> +		of_cpufreq_cooling_register(policy);
>  
>  	pr_debug("initialization complete\n");
>  
> @@ -1468,10 +1468,8 @@ static int cpufreq_offline(unsigned int cpu)
>  		goto unlock;
>  	}
>  
> -	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
> +	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
>  		cpufreq_cooling_unregister(policy);
> -		policy->cdev = NULL;
> -	}
>  
>  	if (cpufreq_driver->stop_cpu)
>  		cpufreq_driver->stop_cpu(policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d01a74fbc4db..9a42711f338b 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -144,9 +144,6 @@ struct cpufreq_policy {
>  
>  	/* For cpufreq driver's internal use */
>  	void			*driver_data;
> -
> -	/* Pointer to the cooling device if used for thermal mitigation */
> -	struct thermal_cooling_device *cdev;
>  };
>  
>  struct cpufreq_freqs {

This too. In my view this should be merged with 2/6.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
