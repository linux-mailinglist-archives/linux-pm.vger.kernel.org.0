Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B747E509B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 07:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjKHG4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Nov 2023 01:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjKHG4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2023 01:56:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FAC170C
        for <linux-pm@vger.kernel.org>; Tue,  7 Nov 2023 22:56:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32deb2809daso3833684f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2023 22:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1699426595; x=1700031395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82eEQr+8/A7PiJMPT5spBMg6k8pyownoQwNjAZnUjqs=;
        b=OxklnfM3zc69mdUI35DTD0Z/mSJxjsGBjEkttPTQTjQhIbTV3nPmGELNamT/HuPSTj
         Ele6Lm05gKUFUhBmAM4v9kNOIQw6LqOtgikufd/YcHq6j96Xd4072ZDMKO+SlX8jAya9
         05xE5+NfhJP2ntrtR69RD6uP8mUpemhDFi45I/E4F6HyOcb3w0melTujZw5iqp1z4j45
         s3LRjkLSBrFB3LqLyKX0s6StiV3w+QXECySBgYGQscA0JMjVEpQbVyCZByoTz8QZ4U7m
         aJFMmXco/zXtTvRKUqO3nK81TjbdcFuZ90qisbuqCibgPbrFOTnlMQLnNZfth3nC+OsJ
         822g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699426595; x=1700031395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82eEQr+8/A7PiJMPT5spBMg6k8pyownoQwNjAZnUjqs=;
        b=kwPasUgSB2qeLGZCUqROHM6U6QnF1oZEMCzfelPrT1ssckSk8rHGLAAfYgVkCptu++
         lAT88ab1Bclm7Nl+4bxfg9KiUHRGpvxU58AEWcq+ChV6ZoRki6nI0FFf8rUU5mAr6Xsx
         1AtNzxV0T5s2ui9zbPdDc9elmoqIXK2TbTPAgZfbTP8WyCcb2pJppZsJWfpKtwKrEep2
         I2ld3MrN31L2bGf9iIXRvmIzPnnXyVVxsXVLy/9slcInZ9rhNaBeXp0KRi8CzvpbcW34
         sB7byUnjoxnIwGBG9UwX3SkWDdzCcZpScJjY1BePdgK2zAXST/ITnPBO6akDz4ULw+3Y
         X7jg==
X-Gm-Message-State: AOJu0YxMiXKgQGSv2ZIYnUo97cXmtixsg9EZQ46cbzrG9nAfBVnajxCT
        GyBBHDEI3xRL6IKfQ+zvUL7IMA==
X-Google-Smtp-Source: AGHT+IH9ZHe7+IrjXaTMhMnAsmmE+CaXi4lJs3UvQhp/poAK0D91rEuJgwccc1yV0MwqUePPeaJE3w==
X-Received: by 2002:adf:fd89:0:b0:32f:932b:e02f with SMTP id d9-20020adffd89000000b0032f932be02fmr737685wrr.55.1699426595397;
        Tue, 07 Nov 2023 22:56:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id d5-20020adff2c5000000b0032d2f09d991sm4110012wrp.33.2023.11.07.22.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 22:56:35 -0800 (PST)
Message-ID: <b05f51c3-f2bf-4049-92e4-13666ae6dd52@tuxon.dev>
Date:   Wed, 8 Nov 2023 08:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/14] power: reset: at91-sama5d2_shdwc: Convert to
 platform remove callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
 <20231105094712.3706799-4-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231105094712.3706799-4-u.kleine-koenig@pengutronix.de>
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
>  drivers/power/reset/at91-sama5d2_shdwc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index ef8add623363..af95c7b39cb3 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -421,7 +421,7 @@ static int at91_shdwc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int at91_shdwc_remove(struct platform_device *pdev)
> +static void at91_shdwc_remove(struct platform_device *pdev)
>  {
>  	struct shdwc *shdw = platform_get_drvdata(pdev);
>  
> @@ -437,13 +437,11 @@ static int at91_shdwc_remove(struct platform_device *pdev)
>  	iounmap(shdw->pmc_base);
>  
>  	clk_disable_unprepare(shdw->sclk);
> -
> -	return 0;
>  }
>  
>  static struct platform_driver at91_shdwc_driver = {
>  	.probe = at91_shdwc_probe,
> -	.remove = at91_shdwc_remove,
> +	.remove_new = at91_shdwc_remove,
>  	.driver = {
>  		.name = "at91-shdwc",
>  		.of_match_table = at91_shdwc_of_match,
