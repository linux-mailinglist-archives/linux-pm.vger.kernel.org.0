Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F967E508D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 07:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKHGzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Nov 2023 01:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjKHGz3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2023 01:55:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46777D40
        for <linux-pm@vger.kernel.org>; Tue,  7 Nov 2023 22:55:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40806e40fccso40835755e9.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2023 22:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1699426526; x=1700031326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdaiSL4v903vHYwpT1bHNjan8atdW0O+05issBZGM4g=;
        b=ELwP3fj5QbngOuZqyJno8OHWTsqZ3KR3pXXC2xtaycJ1zOXNvF+Zogvg4QdjXyM1E4
         kRULKAB4XKWK6x6apqdWU7D5ho6MEPoUDCFardtTblmyEbwtbalT3SGof/lOvJGlW8yz
         tSJq4ogmatvpNhE5xjwc0D6WQBM8AGv1VkjIrPk4RfVGoc1FDBt1r6GFkxb0KVxmFfk/
         1lbP4zmaGca+E0OV0gMK99PjTp5k6P+v0cagEM6Scbkc1MkhG2kZvRYhI99UmnDsdjzs
         OPjXGI4R6Hk/wLbA8T0oxPvDQL1Mgty6NtqvnbILJbniAfLmxDgsua7xX2u8TPAPFxBT
         qeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426526; x=1700031326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdaiSL4v903vHYwpT1bHNjan8atdW0O+05issBZGM4g=;
        b=H0TE/0OIYw3QexcJ8ydg/0Xudan/3JDGIbp9gWRlO1sr8vj0FPz3b+TvXGe8fVTPK6
         sHT/EM3HouSJAJLg4z9+mTlM6N78v3fyqKb64dfroyEDnP09fwMxa/u9FLjD9alHvod9
         wlz7Td6AarFCPS8c1mXsS2+XA0QJ1AhP4U5SHB9Xn7TV5BV1thY6RCpGeZQqC0VA/+K7
         S1akWGl2Qq0xi6DrPgtsJHYYqzSvPPBaLhFu7iBD8DnvCQdKgG5fvOzyPSF8T1OmhQyF
         OMVqYcC0dGO4R5Lo5OT7ugMxjGCLDYw6mwU/ASi8RcFitkeh8/ne3H0PxTFySpa0kqzS
         MCrQ==
X-Gm-Message-State: AOJu0YyRO3GJz4Yhxmx3NTkEjpOo53IfQM6O2tH8WtcSMi906gG6d+PN
        hEFDsFT25vPs9jZaTha6PnsXAA==
X-Google-Smtp-Source: AGHT+IF8WwcY/0mNmL2/ZBzOsN8n6gW4d2kpF4fZpH6Wm88GXR5JfzbiJ7+F8E35Oi3pIJPjG+OY9w==
X-Received: by 2002:a05:600c:3b92:b0:405:4f78:e128 with SMTP id n18-20020a05600c3b9200b004054f78e128mr1047290wms.4.1699426525705;
        Tue, 07 Nov 2023 22:55:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id d5-20020adff2c5000000b0032d2f09d991sm4110012wrp.33.2023.11.07.22.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 22:55:25 -0800 (PST)
Message-ID: <350625dd-7d04-4bd8-8777-3aae20b326b3@tuxon.dev>
Date:   Wed, 8 Nov 2023 08:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] power: reset: at91-sama5d2_shdwc: Stop using
 module_platform_driver_probe()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kbuild@vger.kernel.org
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
 <20231104211501.3676352-19-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231104211501.3676352-19-u.kleine-koenig@pengutronix.de>
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

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index e76b102b57b1..ef8add623363 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -329,7 +329,7 @@ static const struct of_device_id at91_pmc_ids[] = {
>  	{ /* Sentinel. */ }
>  };
>  
> -static int __init at91_shdwc_probe(struct platform_device *pdev)
> +static int at91_shdwc_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
>  	struct device_node *np;
> @@ -421,7 +421,7 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int __exit at91_shdwc_remove(struct platform_device *pdev)
> +static int at91_shdwc_remove(struct platform_device *pdev)
>  {
>  	struct shdwc *shdw = platform_get_drvdata(pdev);
>  
> @@ -442,13 +442,14 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver at91_shdwc_driver = {
> -	.remove = __exit_p(at91_shdwc_remove),
> +	.probe = at91_shdwc_probe,
> +	.remove = at91_shdwc_remove,
>  	.driver = {
>  		.name = "at91-shdwc",
>  		.of_match_table = at91_shdwc_of_match,
>  	},
>  };
> -module_platform_driver_probe(at91_shdwc_driver, at91_shdwc_probe);
> +module_platform_driver(at91_shdwc_driver);
>  
>  MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
>  MODULE_DESCRIPTION("Atmel shutdown controller driver");
