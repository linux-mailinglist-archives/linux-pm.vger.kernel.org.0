Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54A4C43ED
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 12:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiBYLuc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 06:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiBYLuc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 06:50:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF111CABDD
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 03:49:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b5so4121700wrr.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z0AQwDRmlX2jEKuEmLzMZmV3FmNg77Cty88ZTME6GuM=;
        b=SSGifpfGLVf+Zzv2eo6p02Vq/j8D3FLBVVD0jX6skrKL+9cZEmf6ZkDgJXpdAnUWug
         h6GpsgrfS3bSfnya5A8FKqXkPss13YXxB2BPqYJy40sc7ABFyGBF/9VAT360026RglMe
         w76Zyx3pcNf4LU32OILuxa3QnUTS3bNFlpExa9O7jd0BOPjGYEj0IQsJTjGVa7oSsShA
         Z+ARt6Oaaef8QqaKSs+oRjcuQBslLxhtwNTC7H0fh+HSdC8e8l9m3H4BE4zHjQIVd8VL
         oMQLixVrnJaep8UTszS0nEw4+bTdsnhn+mUf3dyOZ5CciCtsSWXKUcFrwabs7YCCyADS
         KjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z0AQwDRmlX2jEKuEmLzMZmV3FmNg77Cty88ZTME6GuM=;
        b=uHDQOea6tMqr28Zx+aOu+pXaP7VuSNoDihrbgnuCrAs9sXtz3jNf1z4Gv4fsAn1PU/
         ktjfWVql/KeSdBDkVdKWawvtZfyljMlqePNMZpTq2X0D8Jn9CjoaZ8POruioCQcoEk98
         wR2PkI2RiLLfnDjSZpvOn+yOkUIZbCvR+rLwKPqt+luXE2UA7L2Xgn/KVe1eiRvgrNgV
         8wghFwXXuAR242sNUBZsHiGauojoBiFBgVQhvJpgI4v+0Sne0T6b+ssIUEwRwU9+tK3c
         rT9WFh0V+rJ2lX++WviCGSkXNdPzXBRsTZUD+5mazABJIbMEqKuEWxZB3E3UXxLDhjOB
         9Ohg==
X-Gm-Message-State: AOAM533YCk7tZeQzlER5Wirt13BgwWrYiZlJ0yLEUdArlDK5170I4dpT
        Q2yvFCtBNWWWiSycCSdUnTlFNtgyhwFbdw==
X-Google-Smtp-Source: ABdhPJxAab05Ky6k1ckH2WY7c97myyYHsgpcFkM0j1pcgOp6jiqJeOsJO7FNDFtatunM68Whq+kf7g==
X-Received: by 2002:adf:eec1:0:b0:1e3:1e0a:72f0 with SMTP id a1-20020adfeec1000000b001e31e0a72f0mr5952581wrp.524.1645789798159;
        Fri, 25 Feb 2022 03:49:58 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id t9-20020a05600c198900b0037bd5fabd10sm2518713wmq.48.2022.02.25.03.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 03:49:57 -0800 (PST)
Message-ID: <aa780adc-78f2-98bc-16b2-e0a50d3f2bb6@linaro.org>
Date:   Fri, 25 Feb 2022 12:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] thermal: k3: Add hwmon support
Content-Language: en-US
To:     Massimiliano Minella <massimiliano.minella@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
References: <20220210164756.3489848-1-massimiliano.minella@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220210164756.3489848-1-massimiliano.minella@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/02/2022 17:47, Massimiliano Minella wrote:
> Expose the thermal sensors on K3 AM654 as hwmon devices, so that
> temperatures could be read using lm-sensors.
> Use devm_add_action_or_reset() to unregister the hwmon interface
> automatically.
> 
> Signed-off-by: Massimiliano Minella <massimiliano.minella@gmail.com>
> ---

[ ... ]

>   		}
> +
> +		data[id].tzd->tzp->no_hwmon = false;
> +		ret = thermal_add_hwmon_sysfs(data[id].tzd);
> +		if (ret) {
> +			dev_err(dev, "thermal failed to add hwmon sysfs\n");
> +			goto err_alloc;
> +		}
> +
> +		ret = devm_add_action_or_reset(dev,
> +					       k3_hwmon_action,
> +					       data[id].tzd);
> +		if (ret)
> +			goto err_alloc;

check out devm_thermal_add_hwmon_sysfs

>   	}
>   
>   	platform_set_drvdata(pdev, bgp);
> 
> base-commit: e5b54867f47f765fcb439e09ed763b5de617af3e


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
