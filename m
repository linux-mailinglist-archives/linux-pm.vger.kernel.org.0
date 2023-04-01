Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929986D33D6
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDAUeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 16:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDAUeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 16:34:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA512658B
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 13:34:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l37so14864088wms.2
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680381256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ht/IPTnIvVbwoF0SflWngC/A+ZVYLrrTz6rPwMBBJMs=;
        b=wmuBvcYn7vbZM9UbNc3qo1Qj4OkPm6/eywww4WJ9vOFXKffHsQ3HBtsKRqNU1q1tXe
         WuIvnc0S5z2rKCmKKmv10TgP3Usn8i9AilRE6E5Bf2kI4d2H1Gke9Zn4hB3p072c9w1Q
         lLafKtPAWmIhl5r4XQZqDO5scZINGLNrxexgcftO3vBW12ve2lzykCmaJFIC4Lu6jws3
         RV8w39LGfJsbQxVZ4a94qAu0VNEhEpm5MezvbtQ/yhcrDMIYRpjG+XkDEScyrfEn/b+A
         PvAOufQPFQeCUTf0DKd3BQzE+8iud4YNfViuE5No9yaoFX+gouyXRHIf+sPbj05uB245
         QKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680381256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ht/IPTnIvVbwoF0SflWngC/A+ZVYLrrTz6rPwMBBJMs=;
        b=E19TZthICm9Cb++4uzS2hkhrelPzoI3uRNxhUubsXsnQkWYn2xwv5clePuyq9ZnUIu
         vaFoASJv00lLI2qGBqd7Oxh7oLn6AZGtFS9/ReAcYb1rx40iKnrlnGCdCjJTX8qkWBdF
         B9KUMioismhQJF/H6MYlWGrK1HwCojzDyJ/Zxgu1LIQFkjuou6Zbfm/TokvQSoGW2U+y
         cafSuTb9XkObP9uEwslORgE9v5AXTHnbZ0UqCa+/w7kj0eBgEwhuwXkZeBNLDVV+3BW9
         dvCMmlT+gewViIpavMRJlAp2sUa8E7Pem1U8u4gWSruyujr128d7/4jVu8kU2ngwR4ml
         8JiA==
X-Gm-Message-State: AO0yUKUkXP7eF1IRebGAUG1vTxDZ4Ur00Q2G52MRqTeKeDqUrU0vX31p
        Nxhc9+iO2H8LmJYWB6Z6nrRvAw==
X-Google-Smtp-Source: AK7set/RtjxgZsEYybfAD8nZw/slu6ebXp3/0fOgugjdML7qyRvyO5towi0Ex1h4GLS0FuLyWG0wzQ==
X-Received: by 2002:a7b:c8d0:0:b0:3eb:39e7:35fe with SMTP id f16-20020a7bc8d0000000b003eb39e735femr22975275wml.30.1680381256232;
        Sat, 01 Apr 2023 13:34:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id 5-20020a05600c228500b003e91b9a92c9sm7032337wmf.24.2023.04.01.13.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:34:15 -0700 (PDT)
Message-ID: <9ab8d176-378c-9720-3794-c710e2bd6272@linaro.org>
Date:   Sat, 1 Apr 2023 22:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: only update
 registered thermal zones
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230328031037.1361048-1-wenst@chromium.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230328031037.1361048-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/03/2023 05:10, Chen-Yu Tsai wrote:
> It's possible for some sensors or thermal zones to not be registered,
> either because they are unused or not fully declared in the device tree.
> Nevertheless the driver enables interrupts for all sensors. If an
> interrupt happens for an not-registered sensor, the driver would end up
> updating a non-existent thermal zone, which leads to a NULL pointer
> dereference.
> 
> Change it so that only registered thermal zones get updated.

Why not change the interrupt initialization ?

> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index d87d3847c7d0..bf59174e18d3 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -415,9 +415,14 @@ static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
>   		if (!(value & masks[i]))
>   			continue;
>   
> +		iret = IRQ_HANDLED;
> +
> +		/* sensor might not exist (bogus interrupt) or not be registered */
> +		if (!lvts_ctrl->sensors[i].tz)
> +			continue;
> +
>   		thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
>   					   THERMAL_TRIP_VIOLATED);
> -		iret = IRQ_HANDLED;
>   	}
>   
>   	/*

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

