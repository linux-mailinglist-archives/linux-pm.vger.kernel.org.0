Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47D46C7C46
	for <lists+linux-pm@lfdr.de>; Fri, 24 Mar 2023 11:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCXKLx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Mar 2023 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCXKLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2023 06:11:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10A0274B2
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 03:11:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso622068wmo.4
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679652703;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=begInB01sukj5RGggFoHNUNKWw4p2fTlflH92RQjtys=;
        b=HhT1nB29ydzX5PF0bXW52RYVNTs9v6IuqXvD72m0nvfScE2FIMQR8UlgwgNOuDzXAE
         zIU4NptYFbipst4gm3n2Brq4NesPRdckCLpMQaJfm4bj6o8eNQf1ppjkudLpJhwYmVlI
         j1MZ5zHTg+uFaTEZJWq5F6UmQhxkQh0QCR4+Qei8X6V1ar0BRu3Y15FkHMM9UU6/BOGE
         t4WMQ0Dsz8Fj9E3T3gBMkTvzaJ7vV7UBqPtUzfck8lOpxzz9+dCSmeEUL78WkPTtIT47
         mbsrSgnBRz1yADJw34LQtf4jTvZhwVHkwqoyQWz7YZmRQ0ySlDycLQbDU69s5BqB71W+
         qMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652703;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=begInB01sukj5RGggFoHNUNKWw4p2fTlflH92RQjtys=;
        b=6oGXjeIPSyxtThHk/1L/Y8WoEwkCEgFyq+WqlrgBE0i2o/WJ8Izq0WAuMY9uKgscUx
         8u9bKB9jzeJJpvfvTI6h46qgu9C0ssrtu5XAKyxAeaaRHuTtV0CeRFNsA6C7Ge0iRRdx
         NnOwxT0abgtAJ8lZIH/qgOfrkU+PksdjAJTz/t1Qj5XLbdl8Q2ZOSIYwNtRuR5UG8QEj
         99dum3jUcRfEBxskiEaGo9nfOBoA6iP5VNnaHMNyRdTLMMwfH1+aA/5A3nMVl3oQIXjo
         UevzOci6JFW4wH8I/zLTQSfko4xj8agOeAg2cVGYpZxvYEYeYRNUq/bfAfBq0VRRl50T
         4Ylg==
X-Gm-Message-State: AO0yUKUqmlgEK6ytpPxKYqtnrv/p6PaHVEYDwfbS/+7QAQ9atSszJTCO
        skvKJQnIJOm/JqWZjKW9aE2L+A==
X-Google-Smtp-Source: AK7set/9fgXTuSp8Lq5Om/uWBWc1ygPFrBf1H4iOs0sxSyWuq5jLXqCdoTLtU1j867CZLG4lhpeziQ==
X-Received: by 2002:a1c:ed14:0:b0:3e1:374:8b66 with SMTP id l20-20020a1ced14000000b003e103748b66mr1808811wmh.40.1679652703013;
        Fri, 24 Mar 2023 03:11:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:213f:a579:70af:e4a0? ([2a01:e0a:982:cbb0:213f:a579:70af:e4a0])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b003ee65e7acbcsm4700489wmb.20.2023.03.24.03.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:11:42 -0700 (PDT)
Message-ID: <19b78f85-141e-eab7-2f4f-a30db3f8fb7e@linaro.org>
Date:   Fri, 24 Mar 2023 11:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] thermal: amlogic: Use dev_err_probe()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, glaroque@baylibre.com
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202303241020110014476@zte.com.cn>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <202303241020110014476@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/03/2023 03:20, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/thermal/amlogic_thermal.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 4bf36386462f..3abc2dcef408 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -262,11 +262,8 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
>   		return PTR_ERR(pdata->regmap);
> 
>   	pdata->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(pdata->clk)) {
> -		if (PTR_ERR(pdata->clk) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get clock\n");
> -		return PTR_ERR(pdata->clk);
> -	}
> +	if (IS_ERR(pdata->clk))
> +		return dev_err_probe(dev, PTR_ERR(pdata->clk), "failed to get clock\n");
> 
>   	pdata->sec_ao_map = syscon_regmap_lookup_by_phandle
>   		(pdev->dev.of_node, "amlogic,ao-secure");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
