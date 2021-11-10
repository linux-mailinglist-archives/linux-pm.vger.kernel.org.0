Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137C044C48C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhKJPlV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 10:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhKJPlV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Nov 2021 10:41:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9D2C061766
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 07:38:33 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q124so5956774oig.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Nov 2021 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t6RRdlmjOEiTF/w10pBfkczH8P4zCO5ZF9paU22nvC8=;
        b=uaAhaej0J1C95EORDZ8Yrb5CkxLFbKyN4TUmNv/tXuW7eY3fFFfy+Xfmj+GX/Yhj+y
         TS2gYZhG6TewME9IzK99nxrKjae6RxyQtxUc/FK5H8wqtZZlX1b/m8X6MVdZOIH1kV41
         ssKqB9BkPs94zclfCVNTXxKcwpPV9X7n77hbmLHNK5kW2mG8O7NwU3ZJyPjm3Tmh+HSX
         yOnCMXfOKwQ+S3IT4F2q1rHhDTwYHKZRG+YDMo+jIhjzOlFsP0/wWydAmjA7HyQU7z9O
         mMh5XLxEMfgaQT+e/QDnw2zOSkA4NFdYLpsTbpcnWdnSACc9QKAzwB0NjNoHTM0KK+HS
         3Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t6RRdlmjOEiTF/w10pBfkczH8P4zCO5ZF9paU22nvC8=;
        b=v4ui+ngSG6j/2FTrzxmIyhLlo64fgm/gsdXzmzjn5iffRy52F7QLhzKsxMLN886R2I
         pMmdfYIxD4/cGrrBaPZaZN7mvtY+Np0qjpACUXaDpuM5E3kxActi+n4H7qOm0X/pJn2i
         5hUhwbcaTYV622rKxw+yS6gY14oI5KQ6ZiXGlhq6AMc092WTMeYyv8Zev5qrek+OOmtC
         swgWBGC255zny6HruAhfJH9NAojbd8wxG9vxaWhWuWW3ifvck/4pD7xiv4Fp9TsfLYLS
         bxgM162h0y8AYBwphrksacE9rytlrfitlkan5c4g+kjlMn2Qy978gShw/8MoBO0QrCVd
         I5dw==
X-Gm-Message-State: AOAM532q0HUO71u0ml9JDTuUREc2LOv8o9CT1Dg6N3qptQAYDmELSof9
        E/vR6kIuCiPgvbRiJJmHB0+FpA==
X-Google-Smtp-Source: ABdhPJyxeD7ANvsRTUeQPG2bU3+QsN0Xxef2U1AoJIqO1MLRjrKyxWz85YQB2yJpSifwsq5ZCPQFbg==
X-Received: by 2002:a05:6808:15a:: with SMTP id h26mr13814573oie.123.1636558712532;
        Wed, 10 Nov 2021 07:38:32 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e14sm28317oie.7.2021.11.10.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 07:38:32 -0800 (PST)
Date:   Wed, 10 Nov 2021 07:40:04 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Fix exposed stack contents
Message-ID: <YYvn1CJBrWprEKCD@ripper>
References: <20211110152745.1868099-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110152745.1868099-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 10 Nov 07:27 PST 2021, Vladimir Zapolskiy wrote:

> On irq request it is improper to pass its designated name, which is
> allocated on stack, because the irq name string is not copied, thus
> there is a risk of leaking partial stack contents to userspace.
> 
> Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

This was already proposed and reviewed at:

https://lore.kernel.org/all/20210901084732.943248-1-ardb@kernel.org/

Could Ard's patch please be picked up by the maintainers, preferably
with above Fixes added, so we get this backported onto v5.15 stable...

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a2be0df7e174..b772d8ed9a77 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -375,7 +375,7 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  {
>  	struct qcom_cpufreq_data *data = policy->driver_data;
>  	struct platform_device *pdev = cpufreq_get_driver_data();
> -	char irq_name[15];
> +	char *irq_name;
>  	int ret;
>  
>  	/*
> @@ -392,9 +392,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  	mutex_init(&data->throttle_lock);
>  	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
>  
> -	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
> -	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
> -				   IRQF_ONESHOT, irq_name, data);
> +	irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dcvsh-irq-%u",

qcom_cpufreq_hw_lmh_init() might be called multiple times through the
life cycle of the associated struct device, so I find Ard's solution
preferable.

Regards,
Bjorn

> +				  policy->cpu);
> +	ret = devm_request_threaded_irq(&pdev->dev, data->throttle_irq, NULL,
> +					qcom_lmh_dcvs_handle_irq, IRQF_ONESHOT,
> +					irq_name, data);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Error registering %s: %d\n", irq_name, ret);
>  		return 0;
> -- 
> 2.32.0
> 
