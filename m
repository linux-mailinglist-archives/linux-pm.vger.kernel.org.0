Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD97E5090
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 07:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjKHG4Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Nov 2023 01:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjKHG4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2023 01:56:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C3C10C0
        for <linux-pm@vger.kernel.org>; Tue,  7 Nov 2023 22:56:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32f7bd27c2aso4501242f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2023 22:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1699426572; x=1700031372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lystALgvqiUi957WIQTpVWotbDzphKuWXe3g9VIwj4g=;
        b=V6K+S2bAIY3YY32eivzwKijRl4ZfiTVW5Q8EQTFmdH1Sx+z2BIOOdpb67pGXCUjd+l
         qzy38y1gsO5OO2MueRtV25pHKe8XpXCVIZzrFofNo5BHiqWtT2h4Oj7IYI5eK9KMCuSN
         zQtg2AodyvoBPVB5LBzMEs3Ve9RuqJI3PQSgj5tgjfrwyykKzfGlJdKUlmZ0xyYdbsdp
         V6fva7GN+BD9sPuY0sIqihYMcLr3JERiI5KiUB1H5S8b6hHAw22z9Zv9t915Gz4zZxUY
         yy7/GEDdTlrgR/ezFL0m2MY+aPL2zFYl0RaEyphESdW6daJ0rgwIf9cZCWt15CT8KQmX
         5mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426572; x=1700031372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lystALgvqiUi957WIQTpVWotbDzphKuWXe3g9VIwj4g=;
        b=SJFuoWYY8jJhEnlq7WSFcZu4vICeF6lOEIGnA+MqCp5w252ypHjzqVa0r392PRWhAr
         q4EWZwwmMvyVRlXx2V1kes8fMHFxzVvpShhsAf1y60zbtDWii91/UPY+Sg1Skk6Wpo/2
         gGFcy0RZn2KG1IQWPD1C7orsh0R7ehAm+0k0VXP2+TZJ2RD5Dxcx2zjNEihxTuwyVS+U
         7tf6q4YX3rCKEokloNfW1h8Rz9CZ8b82IJK7TKDh4GbL3xTvjX4sqLNh+xXsjL6F/Kzg
         OO22RD6RmD+wcgzt5oLBcLP1JDRCmvr1tUH6nTZeQK4Tfc/OP5tDcXO10Kaj7Y07OWrY
         rjdg==
X-Gm-Message-State: AOJu0YwBZJeycqOLQuaXGMgK+CD0NmZ9/xPYXB8EeOCet9wdMdTKFCgP
        rMWlKsJAHt3Ftm0xsWqCR+mcbw==
X-Google-Smtp-Source: AGHT+IF3FuibMYbPYQN6CS33H+5t0aWAIUkH8SsmfMYOPsbBj7A8EKZ0wUIq7smZkN1/KvURGHkZ3w==
X-Received: by 2002:a5d:64e6:0:b0:31c:8880:5d0f with SMTP id g6-20020a5d64e6000000b0031c88805d0fmr719693wri.11.1699426571969;
        Tue, 07 Nov 2023 22:56:11 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id d5-20020adff2c5000000b0032d2f09d991sm4110012wrp.33.2023.11.07.22.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 22:56:11 -0800 (PST)
Message-ID: <b606cf9c-6456-4270-ac4e-57fdc07707ff@tuxon.dev>
Date:   Wed, 8 Nov 2023 08:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/14] power: reset: at91-reset: Convert to platform
 remove callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
 <20231105094712.3706799-3-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231105094712.3706799-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 05.11.2023 11:47, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/power/reset/at91-reset.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index af85f2f929ba..16512654295f 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -417,19 +417,17 @@ static int at91_reset_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int at91_reset_remove(struct platform_device *pdev)
> +static void at91_reset_remove(struct platform_device *pdev)
>  {
>  	struct at91_reset *reset = platform_get_drvdata(pdev);
>  
>  	unregister_restart_handler(&reset->nb);
>  	clk_disable_unprepare(reset->sclk);
> -
> -	return 0;
>  }
>  
>  static struct platform_driver at91_reset_driver = {
>  	.probe = at91_reset_probe,
> -	.remove = at91_reset_remove,
> +	.remove_new = at91_reset_remove,
>  	.driver = {
>  		.name = "at91-reset",
>  		.of_match_table = at91_reset_of_match,
