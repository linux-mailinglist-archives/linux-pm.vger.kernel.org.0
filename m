Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A77E508F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 07:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjKHGzm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Nov 2023 01:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjKHGzl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2023 01:55:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0E170C
        for <linux-pm@vger.kernel.org>; Tue,  7 Nov 2023 22:55:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32fe1a29010so772489f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2023 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1699426537; x=1700031337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNfr0rONuYQjXPxySVY96uvpxmFa5CFj5rntlz/tfjo=;
        b=MjA7ds74fruAbj3/kQiTc1gD1ZDOQdD3xCSejW+fPTJN+jUCN+1fmpGrMVxia3aodi
         wkeRAcZL/HcxMqsbWGgoWnwhTn8ahIgLU36jglweqiK5kst7yhCO8U/Z+hp/CjwSb/FW
         RdaRhEf5sC94qW2IIL0n0iP0MDtfUA78xt9UJRCkQqv53YDOAi+EBPBPTYsd6R9upaHC
         VdvE509InoZ2r+GOniH9ROM0+yhac0hawu+BZvYmqi9QqYJiMCqNZUWce506AMvYW6yj
         BEOJku41oEWxkaFwc1lqDhmDWOSLSoQfNA8bV6+rUZwMYFSZd5OvXtTvCd1GlUfhA8AD
         xHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426537; x=1700031337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNfr0rONuYQjXPxySVY96uvpxmFa5CFj5rntlz/tfjo=;
        b=TSc93tl4tEbeSDr5ijmn8pwa4UZE9GrENh0JYLlfEs3OSKb667QklIck5w+JyKaoLx
         1sZD6y5B0vTbepvD4fCwQs3Urb974KIvF4OXgNPPCGs4Baw3PPJlt8Lh9NR5KIVHwNVf
         xao91YasY0GWB0ah8gOXF4UKZ582uaQfOVBDmp3VM+nILfaY50/46ARTr1sxdwc5lNAq
         gB0p32Ck8lNy7xCuzPjMQbfMOyM0ofLz8NMSYYFdL8hZwU5nB+HIGZ/JHafXgan6ryMW
         vf0PkfvIzL3T/U4kiS/EJ9LDTMEVsum90ZekgbeQu1d3zVkzk6QgQlJPx25n5EF5NMXm
         Oplw==
X-Gm-Message-State: AOJu0YyskriZ0K7pQKT0VGRDa29sLKsIWwL8i44jQkEFZ1xocgtY+oGz
        LMf6jn+aEolsX3nEQySNaYvXhA==
X-Google-Smtp-Source: AGHT+IHZ3W+K0Lf3BX/ym+NzB1rFf2UTWKhq/F67SpqFbmDKBrJ73zpDKwYrLrtsao/Thldu2sbiRg==
X-Received: by 2002:a5d:5683:0:b0:32f:7a1d:ef4e with SMTP id f3-20020a5d5683000000b0032f7a1def4emr548597wrv.41.1699426537125;
        Tue, 07 Nov 2023 22:55:37 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id d5-20020adff2c5000000b0032d2f09d991sm4110012wrp.33.2023.11.07.22.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 22:55:36 -0800 (PST)
Message-ID: <3a184c02-695a-4190-b581-6f81cf03dc16@tuxon.dev>
Date:   Wed, 8 Nov 2023 08:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] power: reset: at91-poweroff: Convert to platform
 remove callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
 <20231104211501.3676352-21-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231104211501.3676352-21-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 04.11.2023 23:15, Uwe Kleine-König wrote:
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
>  drivers/power/reset/at91-poweroff.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
> index 83567428ab43..126e774e210c 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -202,7 +202,7 @@ static int at91_poweroff_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int at91_poweroff_remove(struct platform_device *pdev)
> +static void at91_poweroff_remove(struct platform_device *pdev)
>  {
>  	if (pm_power_off == at91_poweroff)
>  		pm_power_off = NULL;
> @@ -211,8 +211,6 @@ static int at91_poweroff_remove(struct platform_device *pdev)
>  		iounmap(at91_shdwc.mpddrc_base);
>  
>  	clk_disable_unprepare(at91_shdwc.sclk);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id at91_poweroff_of_match[] = {
> @@ -225,7 +223,7 @@ MODULE_DEVICE_TABLE(of, at91_poweroff_of_match);
>  
>  static struct platform_driver at91_poweroff_driver = {
>  	.probe = at91_poweroff_probe,
> -	.remove = at91_poweroff_remove,
> +	.remove_new = at91_poweroff_remove,
>  	.driver = {
>  		.name = "at91-poweroff",
>  		.of_match_table = at91_poweroff_of_match,
