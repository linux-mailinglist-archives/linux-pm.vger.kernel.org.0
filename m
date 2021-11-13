Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C2844F4A6
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 19:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhKMS4R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 13:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKMS4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Nov 2021 13:56:15 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E3C061767
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 10:53:22 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id m6so25131758oim.2
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rh7c+/1/CSnZX6IxhT7ftQzx0ERImx/7h2nk61oVkOc=;
        b=RpJcKtqt13lKT8fkNE4/gFWeOMS2/QMN74DWjHqLqB0hkkiAfO64wW7H5Ls7L3l3bn
         Yv5oSsQkhxd0kyL0jNvXk8rePr5RmyOCqAEwFRdOdLB8svlE+FCFRw4+87G16ddj2ks9
         y7Y7K07h/nD+wfzLGbWm4PD2qpZWjnA2VP/8Ikgz+MQLcINr38wvZ5kTo97JLJqSvUu7
         WARO36STeTwdF0qAZHfoex2Dn67cg1+JNutBnThhm4AKmwrn7gVApB60WP9sID4xshXY
         lE9xhFzw1jkAb+29HeNMJOtGTQoPBD65aslpNryfwKB70UN7YzQyXRWjKdrAUDl7YWbA
         CMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rh7c+/1/CSnZX6IxhT7ftQzx0ERImx/7h2nk61oVkOc=;
        b=Ni4Q90OTiLFN89P7tnW7pnT8CievJyKApd0ZbpM4I98W7UhSx8vPJonjh93itYAm07
         McEPP4/+vFcGklt/rFmvoqn+TcepWiM2FZ/90Ek98cNHfbKo42Px+kXb3c2wleO5MAkj
         FRCEf1wbgUDaqd+0Ta6oN3313Ltgssy6uwRq3VD7pfBTg/YP0mvkepFdQbnAblx4c4m4
         61ISs1n0oBj83s1a0imVYd1sAogTcaFJddPA+FPNUUwxLC+OI6UfdsxdFH98qoYM2qgA
         qPCtdyQzccINXNboDblOl5yVutYEnZJLnvDLBbdadzPvCE+p92vK2kz2UT39Gtv5B52T
         pnYw==
X-Gm-Message-State: AOAM5326SZyX/B3ZnvPqwZoZu70TduQQtlNJ6ykay33RvpPlAKeEfRGB
        3FMB+BQdMDPICtYu/Qu6G6vBRw==
X-Google-Smtp-Source: ABdhPJyBTh06eH3ZFoz+dIWfV4UIt/kCZKNabsD27X+vUEBneDniR+o2MMFlnUs3ixohLNoKxO52Hw==
X-Received: by 2002:aca:ab84:: with SMTP id u126mr33839229oie.41.1636829602144;
        Sat, 13 Nov 2021 10:53:22 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o2sm1962387otk.39.2021.11.13.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 10:53:21 -0800 (PST)
Date:   Sat, 13 Nov 2021 12:53:17 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH 1/3][RESEND] cpufreq: qcom-cpufreq-hw: Avoid stack buffer
 for IRQ name
Message-ID: <YZAJnVCoY+jLv5u1@builder.lan>
References: <20211111154808.2024808-1-vladimir.zapolskiy@linaro.org>
 <20211111154808.2024808-2-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111154808.2024808-2-vladimir.zapolskiy@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 11 Nov 09:48 CST 2021, Vladimir Zapolskiy wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Registering an IRQ requires the string buffer containing the name to
> remain allocated, as the name is not copied into another buffer.
> 
> So let's add a irq_name field to the data struct instead, which is
> guaranteed to have the appropriate lifetime.
> 
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks for reposting this Vladimir.

Regards,
Bjorn

> ---
> vzapolskiy: rebased, added all collected tags and resend the change from Ard
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index a2be0df7e174..3b5835336658 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -46,6 +46,7 @@ struct qcom_cpufreq_data {
>  	 */
>  	struct mutex throttle_lock;
>  	int throttle_irq;
> +	char irq_name[15];
>  	bool cancel_throttle;
>  	struct delayed_work throttle_work;
>  	struct cpufreq_policy *policy;
> @@ -375,7 +376,6 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  {
>  	struct qcom_cpufreq_data *data = policy->driver_data;
>  	struct platform_device *pdev = cpufreq_get_driver_data();
> -	char irq_name[15];
>  	int ret;
>  
>  	/*
> @@ -392,11 +392,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
>  	mutex_init(&data->throttle_lock);
>  	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
>  
> -	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
> +	snprintf(data->irq_name, sizeof(data->irq_name), "dcvsh-irq-%u", policy->cpu);
>  	ret = request_threaded_irq(data->throttle_irq, NULL, qcom_lmh_dcvs_handle_irq,
> -				   IRQF_ONESHOT, irq_name, data);
> +				   IRQF_ONESHOT, data->irq_name, data);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Error registering %s: %d\n", irq_name, ret);
> +		dev_err(&pdev->dev, "Error registering %s: %d\n", data->irq_name, ret);
>  		return 0;
>  	}
>  
> -- 
> 2.32.0
> 
