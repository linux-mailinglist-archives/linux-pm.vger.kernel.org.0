Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D47F40F484
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhIQJJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 05:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhIQJJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 05:09:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42AC061574
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 02:08:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u15so13992594wru.6
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 02:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6H3PgEvJtKdfjyBEYlYykpBnafjbdNton0u/XHPtQkY=;
        b=e92OBaLRYooNOD8adcQCqfoNoPrMKrhSenSe/RAIl/Q3MEONRS++meOfqRiquzCPTO
         oFzdPQwEfuP0VJEjRUEEaGWZbd9sV/eORFgkfV2WjjuSyuOQde9tuRB/3a+q56dFq0J/
         Utg2hQVV5ctHvAP7kerfL32V+CIzQY7p5UvEnHQkEycyxNDa37+Z7tCIAjlG6hQZj3Ha
         NvRAlYvZqQTS3onGoVZR509VwzDwX500IPRBu9+2WWjaeZ211Up8sIdgULQ52/mP45D3
         rJ0SMArM3xr79qR1o64ScXD2qWI68PUyv9Z3ecWh6v4Acfd6f+7krIAaXDHi7j7EVIFz
         VY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6H3PgEvJtKdfjyBEYlYykpBnafjbdNton0u/XHPtQkY=;
        b=u9Gj3Gj+r6Qrp1Rv85eU2jEED0tmGiZenrHBxHpdZGEuL4Fw119ysqE0uEbPhfb3qY
         yPp4bS2dOLLiM7hHCmUzAizwv5hNh2Onn0lkrJOhQEl1VGrXZNTPsmGdYbFdqAzqeUT8
         lCQUDoaU0uO8mAyc2IVrkFUj1LGudh0RCJ/als/Ta35pDtnoI6B54bykc3U3hllYFqDv
         SS4yCBIYmEY1K+J8NXArbCX9+eizugGJcClsbuMskSE+8qlqnGUrnWgVdKsvJUFbL92P
         ZNl4glYCiPd7MOQp6i2C/OW5W6A6/hHk77xgoFqHVi0OxjkG81eozelNSvecgZjXo2PF
         CxKg==
X-Gm-Message-State: AOAM531Nw4myPwnzAPOohW4WmMLRxHMCFMqPaRFfqVAfot7q1AlOOjvW
        BVs/h1Dmw7zTHQ74ggvx+KB0Sw==
X-Google-Smtp-Source: ABdhPJzhFXRN7B5ouSQwSKgqj5+f/A/03bCmzpqAegKiAAOn3OFsIbt0Eet7OTCBonqbpgTw3y4NIA==
X-Received: by 2002:a5d:5229:: with SMTP id i9mr10794836wra.373.1631869697332;
        Fri, 17 Sep 2021 02:08:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cf95:6508:8470:7171? ([2a01:e34:ed2f:f020:cf95:6508:8470:7171])
        by smtp.googlemail.com with ESMTPSA id m2sm9888055wmm.3.2021.09.17.02.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 02:08:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] drivers: thermal: tsens: add timeout to
 get_tem_tsens_valid
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210907212543.20220-1-ansuelsmth@gmail.com>
 <20210907212543.20220-2-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f06f6d13-e659-16e9-5900-2d82596f139c@linaro.org>
Date:   Fri, 17 Sep 2021 11:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907212543.20220-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/09/2021 23:25, Ansuel Smith wrote:
> The function can loop and lock the system if for whatever reason the bit
> for the target sensor is NEVER valid. This is the case if a sensor is
> disabled by the factory and the valid bit is never reported as actually
> valid. Add a timeout check and exit if a timeout occurs. As this is
> a very rare condition, handle the timeout only if the first read fails.
> While at it also rework the function to improve readability.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens.c | 40 +++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b1162e566a70..1ff244176beb 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -599,26 +599,38 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  	int hw_id = s->hw_id;
>  	u32 temp_idx = LAST_TEMP_0 + hw_id;
>  	u32 valid_idx = VALID_0 + hw_id;
> +	unsigned long timeout;
>  	u32 valid;
>  	int ret;
>  
>  	/* VER_0 doesn't have VALID bit */
> -	if (tsens_version(priv) >= VER_0_1) {
> +	if (tsens_version(priv) == VER_0)
> +		goto get_temp;
> +
> +	ret = regmap_field_read(priv->rf[valid_idx], &valid);
> +	if (ret || valid)
> +		goto check_valid;
> +
> +	timeout = jiffies + msecs_to_jiffies(20);

Why not use regmap_field_read_poll_timeout() ?

> +	do {
> +		/* Valid bit is 0 for 6 AHB clock cycles.
> +		 * At 19.2MHz, 1 AHB clock is ~60ns.
> +		 * We should enter this loop very, very rarely.
> +		 */
> +		ndelay(400);
>  		ret = regmap_field_read(priv->rf[valid_idx], &valid);
> -		if (ret)
> -			return ret;
> -		while (!valid) {
> -			/* Valid bit is 0 for 6 AHB clock cycles.
> -			 * At 19.2MHz, 1 AHB clock is ~60ns.
> -			 * We should enter this loop very, very rarely.
> -			 */
> -			ndelay(400);
> -			ret = regmap_field_read(priv->rf[valid_idx], &valid);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> +		if (ret || valid)
> +			goto check_valid;
> +	} while (time_before(jiffies, timeout));
> +
> +	return -ETIMEDOUT;
> +
> +check_valid:
> +	/* Check ret of valid bit read */
> +	if (ret)
> +		return ret;
>  
> +get_temp:
>  	/* Valid bit is set, OK to read the temperature */
>  	*temp = tsens_hw_to_mC(s, temp_idx);
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
