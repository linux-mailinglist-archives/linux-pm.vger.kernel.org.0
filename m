Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7634742391A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhJFHpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 03:45:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36074
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhJFHpw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 03:45:52 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B98CE3FFDA
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633506239;
        bh=p3TdwP/PribmlQ1v0NHBlYo0hol6MEpHmLnfLowf3MQ=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=nLR4AQjbm3GB4Al+SXIxdPPH4ZghPvcnqXt5c7MlspmtJR1O6BDRxqKqUASOJJq+7
         MBDBrXgd8UdmjzoQab73sSoah1G1+LlB5cybNTKzXaC7wAy+SCg688X74+1mZ9s0yy
         eviOFzF9yxAbozNLTVlmC7xwov5uwFF2Ce3nC6UXDTkgcZJ8593wSS7VKaal0u2BpK
         niN2oKAjOm748RwVPyWNItYB8n795Vk6fMWG+OKedmp6rYo2AkW/u2zJHXH3j/aHFf
         B2f87ZX0zrT9V09bMxCE1w18RaM9KZCkKNbSlQ6HI9+LX1/OC/nFycpf09WD+UEatR
         u0b2uVNQ8O6eQ==
Received: by mail-lf1-f69.google.com with SMTP id i1-20020ac25221000000b003fd5769ca3bso150194lfl.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 00:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p3TdwP/PribmlQ1v0NHBlYo0hol6MEpHmLnfLowf3MQ=;
        b=J5z7P05mW53weVzZVvUD/RLrtyTYcN4ifJmUbbr9HBr6o9v1HIa9WNWbaa+GLgvn2l
         nfl/veIL7fwO6IN7TQ+/KCUkjhIHqDV//x1UWVyMV/ag8n5wKxQ9uYuKX9sJgJDSxcN5
         IVvLm8tXQe5KSthQDzx1aT4bIGAyG2AwZxFMTxsZ8n7lY00H4dp19ziKicyX+UjQepQ5
         JIUqNJ8oH4hsp+cYG5lE3g7AtZZkcMjenO0zmLfHV7NgvmFT7pU0ijQxfP3GdAvg1SIO
         5YotHIQePXX5Ihm+cwC0pqziWkmsZb3sh5UYt2LXEzzboYIhqRxR6GoZtZT2MZ8vYKWj
         xrFw==
X-Gm-Message-State: AOAM533go7fEaIVMh1wMTlockOUz2t+MZrIhU0FAspBGcBFbJRkJnqbm
        QmQSdqJaUKP80bA4wQToSH2AVOZM/yU4FwGIZ/0K/qnFod6we2y6W4MFvyPeQF0ce0hExYFmZmN
        mexqnyTSadKq+y81IAQmntV4ghm1mphv9jaYs
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr7537010ljj.207.1633506238938;
        Wed, 06 Oct 2021 00:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwShXMII/bxjqdcgdiJRadaRbz/YAHRW3hisKs3N8yKBLAl3qc5SWHESVOxB866fsSGC6z0AA==
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr7536987ljj.207.1633506238757;
        Wed, 06 Oct 2021 00:43:58 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g14sm2187143lfb.205.2021.10.06.00.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 00:43:58 -0700 (PDT)
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-7-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 6/7] tty: serial: samsung_tty: Support runtime PM
Message-ID: <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
Date:   Wed, 6 Oct 2021 09:43:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005155923.173399-7-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/10/2021 17:59, Hector Martin wrote:
> This allows idle UART devices to be suspended using the standard
> runtime-PM framework. The logic is modeled after stm32-usart.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 88 ++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index e2f49863e9c2..d68e3341adc6 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -40,6 +40,7 @@
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>  #include <asm/irq.h>
>  
>  /* UART name and device definitions */
> @@ -1381,31 +1382,49 @@ static void exynos_usi_init(struct uart_port *port)
>  
>  /* power power management control */
>  
> -static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> -			      unsigned int old)
> +static int __maybe_unused s3c24xx_serial_runtime_suspend(struct device *dev)
>  {
> +	struct uart_port *port = dev_get_drvdata(dev);
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
>  	int timeout = 10000;
>  
> -	ourport->pm_level = level;
> +	while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
> +		udelay(100);
>  
> -	switch (level) {
> -	case 3:
> -		while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
> -			udelay(100);
> +	if (!IS_ERR(ourport->baudclk))
> +		clk_disable_unprepare(ourport->baudclk);
>  
> -		if (!IS_ERR(ourport->baudclk))
> -			clk_disable_unprepare(ourport->baudclk);
> +	clk_disable_unprepare(ourport->clk);
> +	return 0;
> +};
>  
> -		clk_disable_unprepare(ourport->clk);
> -		break;
> +static int __maybe_unused s3c24xx_serial_runtime_resume(struct device *dev)
> +{
> +	struct uart_port *port = dev_get_drvdata(dev);
> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
>  
> -	case 0:
> -		clk_prepare_enable(ourport->clk);
> +	clk_prepare_enable(ourport->clk);
>  
> -		if (!IS_ERR(ourport->baudclk))
> -			clk_prepare_enable(ourport->baudclk);
> +	if (!IS_ERR(ourport->baudclk))
> +		clk_prepare_enable(ourport->baudclk);
> +	return 0;
> +};
> +
> +static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> +			      unsigned int old)
> +{
> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +
> +	ourport->pm_level = level;
>  
> +	switch (level) {
> +	case UART_PM_STATE_OFF:
> +		pm_runtime_mark_last_busy(port->dev);
> +		pm_runtime_put_sync(port->dev);
> +		break;
> +
> +	case UART_PM_STATE_ON:
> +		pm_runtime_get_sync(port->dev);
>  		exynos_usi_init(port);
>  		break;
>  	default:
> @@ -2282,18 +2301,15 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +

You need to cleanup in error paths (put/disable).

>  	dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
>  	uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
>  	platform_set_drvdata(pdev, &ourport->port);
>  
> -	/*
> -	 * Deactivate the clock enabled in s3c24xx_serial_init_port here,
> -	 * so that a potential re-enablement through the pm-callback overlaps
> -	 * and keeps the clock enabled in this case.
> -	 */
> -	clk_disable_unprepare(ourport->clk);
> -	if (!IS_ERR(ourport->baudclk))
> -		clk_disable_unprepare(ourport->baudclk);
> +	pm_runtime_put_sync(&pdev->dev);
>  
>  	ret = s3c24xx_serial_cpufreq_register(ourport);
>  	if (ret < 0)
> @@ -2309,8 +2325,14 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
>  	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
>  
>  	if (port) {
> +		pm_runtime_get_sync(&dev->dev);

1. You need to check return status.
2. Why do you need to resume the device here?

> +
>  		s3c24xx_serial_cpufreq_deregister(to_ourport(port));
>  		uart_remove_one_port(&s3c24xx_uart_drv, port);
> +
> +		pm_runtime_disable(&dev->dev);

Why disabling it only if port!=NULL? Can remove() be called if
platform_set_drvdata() was not?

> +		pm_runtime_set_suspended(&dev->dev);
> +		pm_runtime_put_noidle(&dev->dev);
>  	}
>  
>  	uart_unregister_driver(&s3c24xx_uart_drv);
> @@ -2319,8 +2341,8 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
>  }
>  

Best regards,
Krzysztof
