Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC957E5087
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 07:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjKHGyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Nov 2023 01:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjKHGyw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2023 01:54:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70BF1BB
        for <linux-pm@vger.kernel.org>; Tue,  7 Nov 2023 22:54:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso3675913f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2023 22:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1699426489; x=1700031289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WADg7Gm6M1d4joBFiIBPtNImR2VpL9viJ4iA0bfHJbQ=;
        b=Zod5rmWVlv7iROxODKBc/gI6+Ik2PlFoRBQrsjh38bF7XztD5HpBkNZeUw1sV4Yavz
         Kl3fj+iZOQO0902fUMQqOf1V6TZZP3pXt5F/JX1slkukHyCUVO3Gz+sRVJ/nQGFwAJfV
         gabdPqi9Rp9YVIVNmkcPD26R9mT5cRTfDS34KodNzxuEYuTp+QJNAGfCBiqFXo9Xry4W
         UzVLxqPucpLasGOHCOth8nt6J6Jeq5bBZKZHYRF/kK1anNNNXi3rLkIaHlyhPIYrZIep
         fUD54TMu7uWDDvJLZjkpP1mf1YJEAsxS0B5goq5U01/v3NZQDmH3ktGhVkhNQoTqYetT
         rN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426489; x=1700031289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WADg7Gm6M1d4joBFiIBPtNImR2VpL9viJ4iA0bfHJbQ=;
        b=qjqWASSNnCvNGVS+ftkb9IuNFeLVhL/LTDeJkXSTAyfxH86QZIKr3Y5P1P5yaaQQZ0
         70PEL5Mg5J6WYiclM5diePjcl/m7Na7kE6cGZukTya0HkyCtVDToohujp3jsdfDFh3PC
         SOMAzPgf8izJfxaSdba8utH0CDQ7VMS8fVuLyMbvcVVwDndsYYbQUH17eqcMPhNN4Ndm
         e5fzKZchxrq5n+P95lHZFbZqnzJiHW+3GRmrl7vp4QxNIxaQZ5F6pONXUpEwEwjIRugJ
         HAp0GkZCgy+3EsbunUYLE0UdeVGfWEM5RHktjbQRnqG/O0IWC2HVgkwi9Wf9CPteYI0Q
         UIZg==
X-Gm-Message-State: AOJu0YzoMOWlzou8pphQ3vCPpLqPGqSASuN2jch7BMafaQ0wSYqfpxVj
        IEbCjMkdzydDG12wBDWu9rJwFA==
X-Google-Smtp-Source: AGHT+IH9sF8Iat/MJCRKetrR0QjQlXe0ah3cJGmtywkEt+nWdfSRUNj+tMAo8P/GO37d7ozNguEasQ==
X-Received: by 2002:a05:6000:b81:b0:323:36f1:c256 with SMTP id dl1-20020a0560000b8100b0032336f1c256mr673503wrb.11.1699426489081;
        Tue, 07 Nov 2023 22:54:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id d5-20020adff2c5000000b0032d2f09d991sm4110012wrp.33.2023.11.07.22.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 22:54:48 -0800 (PST)
Message-ID: <202b36b3-2f77-46c1-ad2f-5ec686ca05c8@tuxon.dev>
Date:   Wed, 8 Nov 2023 08:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] power: reset: at91-reset:: Stop using
 module_platform_driver_probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kbuild@vger.kernel.org
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
 <20231104211501.3676352-18-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231104211501.3676352-18-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 04.11.2023 23:15, Uwe Kleine-König wrote:
> On today's platforms the benefit of platform_driver_probe() isn't that
> relevant any more. It allows to drop some code after booting (or module
> loading) for .probe() and discard the .remove() function completely if
> the driver is built-in. This typically saves a few 100k.
> 
> The downside of platform_driver_probe() is that the driver cannot be
> bound and unbound at runtime which is ancient and so slightly
> complicates testing. There are also thoughts to deprecate
> platform_driver_probe() because it adds some complexity in the driver
> core for little gain. Also many drivers don't use it correctly. This
> driver for example misses to mark the driver struct with __ref which is
> needed to suppress a (W=1) modpost warning.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Other than "::" in title:

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/power/reset/at91-reset.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index aa9b012d3d00..af85f2f929ba 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -337,7 +337,7 @@ static int at91_rcdev_init(struct at91_reset *reset,
>  	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
>  }
>  
> -static int __init at91_reset_probe(struct platform_device *pdev)
> +static int at91_reset_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
>  	struct at91_reset *reset;
> @@ -417,7 +417,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __exit at91_reset_remove(struct platform_device *pdev)
> +static int at91_reset_remove(struct platform_device *pdev)
>  {
>  	struct at91_reset *reset = platform_get_drvdata(pdev);
>  
> @@ -428,13 +428,14 @@ static int __exit at91_reset_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver at91_reset_driver = {
> -	.remove = __exit_p(at91_reset_remove),
> +	.probe = at91_reset_probe,
> +	.remove = at91_reset_remove,
>  	.driver = {
>  		.name = "at91-reset",
>  		.of_match_table = at91_reset_of_match,
>  	},
>  };
> -module_platform_driver_probe(at91_reset_driver, at91_reset_probe);
> +module_platform_driver(at91_reset_driver);
>  
>  MODULE_AUTHOR("Atmel Corporation");
>  MODULE_DESCRIPTION("Reset driver for Atmel SoCs");
