Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC764B08C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 08:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiLMHrB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 02:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiLMHqt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 02:46:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45E13F7F
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 23:46:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg10so7605900wmb.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 23:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGfAyTmobVlW+lq5bho+EJgBiAhBZsnOAyxUVzfm0zY=;
        b=RyqDT9zGiKqROcHYVwzCeNPeNka7NMUKMm5WoBPafP3DUoZmGfFY8/xgeltDuc5Q6e
         YT5P//8HrwfZLEZEG6r2AwTZ6JIm369vRT4Ne7Iv2887RSye9uvF/DZ06R0TIQFrpcS4
         liiVn7kndScQ5jSc+kogrYHhmfJiDX7y/NsbS/JZJFcFDBw6U2oJJqpwy5Km6jG6kD16
         ILQs62hbs/dKf9+yiHWSNtLExSey7Dvh0yjtYANFKBaZqIWvbC35T3hu9LEJCUt3eQpQ
         FVAf8KdZvHFovydH4+x3OLjlIa+OpVNJ3dpCwJsZoXZ1i6Zy87zv8ej8PGG8fxxp22Hn
         2KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGfAyTmobVlW+lq5bho+EJgBiAhBZsnOAyxUVzfm0zY=;
        b=7b2YV3/FySF2g8BdbqOZ0KjQC4b3WxIzeGmtwvUEcgL8fEiR2E5noqaHoCoOzRwqXX
         QPwDT39kfHhXq/mk98xqrYKk0ecbQ+tgJa9pBZxPe8Iylbq0jAm9vQXpgKwkiCszWTpg
         KlppHhuwJkafJ0oiAND42jmyFfCM3Kxzm5CJZKaEYyFe1FIwJN2qoz5bS5tsC/qu4D+T
         vp/RC+FwMY27KsrKE2rLe5Gp3v8NTE3pDNOmKVxel5lUwtSrxjsYOvIeXNqUxC8Wci26
         mO/KatFZos5aujQqzektgOpPl5GXy3hvnf5cIOBivFFk14Zg83gN7EkeQQShdDInxuNk
         NOzg==
X-Gm-Message-State: ANoB5pkdEdwdrAEkWyioyEnT87gK1ra1gXbb31E5zMXr5AyDQ/XhNXrC
        YGffn0n6nNmBKPsoWwEiIqEpBg==
X-Google-Smtp-Source: AA0mqf5EOYpZhDBK3hUwMolR6t2f+av6TO4srDAvU/lOt3KXCviGwzBnwVSw4CnOxFYNZeYxm12K+A==
X-Received: by 2002:a1c:f606:0:b0:3c6:e63d:adaf with SMTP id w6-20020a1cf606000000b003c6e63dadafmr14527481wmc.31.1670917606860;
        Mon, 12 Dec 2022 23:46:46 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bc5c3000000b003cfd4e6400csm11815142wmk.19.2022.12.12.23.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 23:46:46 -0800 (PST)
Message-ID: <0df3eb81-9795-a747-8cce-96e6ccd40716@linaro.org>
Date:   Tue, 13 Dec 2022 08:46:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: imx_sc_thermal: Drop empty platform remove
 function
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/12/2022 23:02, Uwe Kleine-König wrote:
> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.

AFAIU, without the remove callback the module can not be unloaded, no?

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/thermal/imx_sc_thermal.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index 5d92b70a5d53..4df925e3a80b 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -127,11 +127,6 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int imx_sc_thermal_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
>   static int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
>   
>   static const struct of_device_id imx_sc_thermal_table[] = {
> @@ -142,7 +137,6 @@ MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
>   
>   static struct platform_driver imx_sc_thermal_driver = {
>   		.probe = imx_sc_thermal_probe,
> -		.remove	= imx_sc_thermal_remove,
>   		.driver = {
>   			.name = "imx-sc-thermal",
>   			.of_match_table = imx_sc_thermal_table,
> 
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

