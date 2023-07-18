Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA09758013
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jul 2023 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjGROtB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jul 2023 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGROso (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2023 10:48:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2691997
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 07:48:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so53977505e9.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1689691711; x=1692283711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3PeHDGShv0/Y1SaTBcwWlp0DgIC2lqoORc+f/lyUag=;
        b=a8ZhbREt0uH7gJ9cBW17TnUuIeY9lua9HO/AozN0hssszX/Phmw738FVOnzPEoqKPM
         9g4ej6yAf/cuK4nEWyxjfBYtwq2t48q5q+nSJ+5OQlOzhsONtMZQnc+j6RCyZcUN1oz/
         WJHBxQoDbrIWi0QyPl72CzT34+UDqSNvbRnQbvEHLyPBKdnn5nr3RT3iXFXMDi5NLpyh
         FK1WZibGA4JoIsa4IL/UxG9P0jvEctbL10XGpyZRaKz+cEvrufbngxfwDfXOD15lMLC7
         etDDOD4GaZZtjqltQf05sbbfL2Pe45hszeZCcAgOKSgMQQVmIrrOfYsXhwu4Vt/0vXQy
         ekaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691711; x=1692283711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3PeHDGShv0/Y1SaTBcwWlp0DgIC2lqoORc+f/lyUag=;
        b=EzN6j4qbDakhvuVwAu0qxBe6zxgHAWULFBMCOEGrKTfhgjED57fytfgEmCK0Me/ojh
         /lDr3ShKEhDKoPygPl/HLZ0JNPnWorGdk2E8f194OKuuW8aGWCAtHR2GQrwLB+9rHPpr
         AYZ3SE2UII7MyeDm92QoWjlafslmJSVClJ8pBbdmPa+RlPIp8odl9RWszHWiXy2Jh2DI
         KAsAlc7mcBtFZCbzoq1on4bDv/k66eI2vEiMTnGZ9lp71eEw6PwVTTb2+hZ52eVbn3K5
         +TQ5rB1Ue247oGX7HtIkZ3JSKt7eogw0cU22V7tpPpYUbo6CN1vQpDlVL/SVNBnwo3gm
         sPeg==
X-Gm-Message-State: ABy/qLYBcjB7lHxFtCyTRK8bSatUbLWlF0T/APBXFfHLTkh9iG3Obe1N
        4F753fSPe3C5yKvZ6TJ6Y0Iosw==
X-Google-Smtp-Source: APBJJlH8FgksFnhHrYa/bYaQB7Lf3bViTB+cyeDz8GdO0wx0X43DqCQgnSsDAnuYgKuzpQVErJxIqg==
X-Received: by 2002:a05:600c:d5:b0:3fc:5606:c246 with SMTP id u21-20020a05600c00d500b003fc5606c246mr2052029wmm.22.1689691711290;
        Tue, 18 Jul 2023 07:48:31 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm10659329wml.18.2023.07.18.07.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:48:30 -0700 (PDT)
Message-ID: <b0bdccb7-e10e-8d8a-fb64-0d41248adf8a@tuxon.dev>
Date:   Tue, 18 Jul 2023 17:48:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/10] pinctrl: at91: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-7-andriy.shevchenko@linux.intel.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230717172821.62827-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17.07.2023 20:28, Andy Shevchenko wrote:
> Since pm.h provides a helper for system no-IRQ PM callbacks,
> switch the driver to use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pinctrl/pinctrl-at91.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 39956d821ad7..608f55c5ba5f 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1657,7 +1657,7 @@ static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
>   	return 0;
>   }
>   
> -static int __maybe_unused at91_gpio_suspend(struct device *dev)
> +static int at91_gpio_suspend(struct device *dev)
>   {
>   	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
>   	void __iomem *pio = at91_chip->regbase;
> @@ -1675,7 +1675,7 @@ static int __maybe_unused at91_gpio_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int __maybe_unused at91_gpio_resume(struct device *dev)
> +static int at91_gpio_resume(struct device *dev)
>   {
>   	struct at91_gpio_chip *at91_chip = dev_get_drvdata(dev);
>   	void __iomem *pio = at91_chip->regbase;
> @@ -1903,15 +1903,13 @@ static int at91_gpio_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static const struct dev_pm_ops at91_gpio_pm_ops = {
> -	NOIRQ_SYSTEM_SLEEP_PM_OPS(at91_gpio_suspend, at91_gpio_resume)
> -};
> +static DEFINE_NOIRQ_DEV_PM_OPS(at91_gpio_pm_ops, at91_gpio_suspend, at91_gpio_resume);
>   
>   static struct platform_driver at91_gpio_driver = {
>   	.driver = {
>   		.name = "gpio-at91",
>   		.of_match_table = at91_gpio_of_match,
> -		.pm = pm_ptr(&at91_gpio_pm_ops),
> +		.pm = pm_sleep_ptr(&at91_gpio_pm_ops),
>   	},
>   	.probe = at91_gpio_probe,
>   };
