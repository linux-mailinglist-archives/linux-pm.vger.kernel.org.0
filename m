Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37E32B329
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352457AbhCCDsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350745AbhCBMrB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 07:47:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B5CC061356
        for <linux-pm@vger.kernel.org>; Tue,  2 Mar 2021 04:36:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u187so2069629wmg.4
        for <linux-pm@vger.kernel.org>; Tue, 02 Mar 2021 04:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=21H6X5rvFt0C32Ctuv5aBj/q0Nf5F/lL8iKvx7fYKHk=;
        b=apLWEffqFWJnX7KTXo6D4CJSsEWb4++cob/WFqj+ZSeECfK3egaM5UKhOQuDfwySQV
         feVV2+nEd9tXMLbQQXnJ937Un4uAy9pNfpIHg/m8WUVAiFzTxpVjjj7pBjd0MpZWRPax
         QSqLoiHTSJyh3QR50ttVv6c6g//ROFYOoEHsJwH8lcfE7MN/ShB3kWbOXJK56FvuKGQz
         XOXsELPeg+qLYSnwMHyLARMhPDP4d+jsn6Xj138vOCnacwtgaV2bAX2lWBGCCr4Wydgr
         sNomdwMMbVxn9hLxD4YBvEIGX0X5OqPXuNI+4z4dRGX8f6/oXuwA441zfhGJZmzvTr59
         B5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=21H6X5rvFt0C32Ctuv5aBj/q0Nf5F/lL8iKvx7fYKHk=;
        b=l2K+4teYjcDy6xOrm7V9T9hhlqpO2tbz73wjnDEGYod57STYcdzeTXMDa3urgx91Ud
         uH/8c5OJeiO7ngG7FX6awAMpreRsnPwHu+8OzNW4aRpYVM/Xc5+fBKeuY1hjVwMCd5ff
         Zls5zKi0HUhTYPQCD5ql7Atjddlx+OLxNvPjYJCeMW9QJTQu6bJzvkZtyj9yoZSQqwP7
         M6RPfzAofJ4gpbplV2evMx2egZ1aFKSQX4rDFNyfyP26FjbFZSzOzuLCT4h3vuz131pN
         cyTFwI4CIC4GaOep1q1QMTiBwCwvPvHLDeprU2jdvS/RN8xswhqAmo7AGdA4SCgbOR7c
         Sbzg==
X-Gm-Message-State: AOAM533I8BydwMtLtHoyb+LN6ckJlvVTUJZNQshf2bxUhrO8wGslNZcg
        1AatzwSFv89gd0BAEFekg7MlOA==
X-Google-Smtp-Source: ABdhPJztIqxQQoKHKbCEJHOj5ZGVqCfgPg/mXSu5EYZczdOo18Qvlhplp3k1rR5y3c6D5xGl30CqBw==
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr3990395wma.45.1614688567906;
        Tue, 02 Mar 2021 04:36:07 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.googlemail.com with ESMTPSA id o2sm2417699wme.16.2021.03.02.04.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 04:36:07 -0800 (PST)
Subject: Re: [PATCH RESEND v2 1/2] cpuidle: tegra: Fix C7 idling state on
 Tegra114
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210302095405.28453-1-digetx@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <36f5d767-d021-d1cb-dfc1-7b9dd63d7d9f@linaro.org>
Date:   Tue, 2 Mar 2021 13:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302095405.28453-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/03/2021 10:54, Dmitry Osipenko wrote:
> Trusted Foundation firmware doesn't implement the do_idle call and in
> this case suspending should fall back to the common suspend path. In order
> to fix this issue we will unconditionally set the NOFLUSH_L2 mode via
> firmware call, which is a NO-OP on Tegra30/124, and then proceed to the
> C7 idling, like it was done by the older Tegra114 cpuidle driver.
> 
> Fixes: 14e086baca50 ("cpuidle: tegra: Squash Tegra114 driver into the common driver")
> Cc: stable@vger.kernel.org # 5.7+
> Reported-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changelog:
> 
> v2: - No changes. V1 got no attention, hence re-sending.
> 
>  drivers/cpuidle/cpuidle-tegra.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index 191966dc8d02..29c5e83500d3 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -135,13 +135,13 @@ static int tegra_cpuidle_c7_enter(void)
>  {
>  	int err;
>  
> -	if (tegra_cpuidle_using_firmware()) {
> -		err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
> -		if (err)
> -			return err;
> +	err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
> +	if (err && err != -ENOSYS)
> +		return err;
>  
> -		return call_firmware_op(do_idle, 0);
> -	}
> +	err = call_firmware_op(do_idle, 0);
> +	if (err != -ENOSYS)
> +		return err;
>  
>  	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
>  }
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
