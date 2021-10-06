Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7E1423F31
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhJFNb1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 09:31:27 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38610
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhJFNb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 09:31:26 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9F2F93FE09
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633526973;
        bh=Ld6+ZKe0AociGcEEMM9rX6l+gjcfCFCnMNQZNPjE3U4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ZIRsLvjpyeo3FSwc74TFp+XwgygyWYshy22wr8XWRbNtgRt72OVO1qwVcu3c1L4gy
         Q23kddGwYqZOBZHB128xLlzRSO5lUvcgWCdHafEnEQAV3V8AlMbpPsXMrecqnbvhmQ
         pVdyQZe+nUVg/OhSj0y59C/p5xQ5FbumouDiueI9XEKGyWYYGku37sLyncjasJjZYO
         TU83Dxu4BzyofJ4OfNGPJaV0NVYlA1Bh73sU3jLPkFDlhlVE/xzeSd44QzTDRi3x7V
         oDzJr63HUsdMohFQ+mR8wjHJ1pkX+ep4uObNuqSsioBFHy5c6l18z+wejF847PkMHI
         WwvoFdxhsXfbg==
Received: by mail-lf1-f72.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so1973655lfv.18
        for <linux-pm@vger.kernel.org>; Wed, 06 Oct 2021 06:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ld6+ZKe0AociGcEEMM9rX6l+gjcfCFCnMNQZNPjE3U4=;
        b=quBu91yLK0YS82SUrY8bXo+omhdPvlvXgrkPRq3hpf9gWQw2fgBYaaOqVDJgz/gVaC
         4pT5odeofiYwf8b50kCLg2sjOmw3UdGT3hgU1pVWUSmlfi2h74ieoFGzqCi216IWuKq7
         eH81l9Z2LycotGtRqKzCZog8fa/gZ4hfOw0PGDBQwEjH9XP28NPupOEMxzZ0a7wrANIY
         rjZzl8+D5EPmXHMLEHKWaK4ZC+ZWWB/09t2xJfpYkbCRPqX3CC6EOB5tANY8gykO0nwx
         TYO8YQTXJzOz4BwT2HS70zuCrWMskyAJ1rckBf0qU92B5eG+YHJx1JH2e2zjn3TPx40q
         D+vg==
X-Gm-Message-State: AOAM533smLDX40yPWWpIaj9+fXK4ClSd2knmGdHSfAGyf2KtfZdQhTbY
        fV3aUiqRVLgQiwJhKt6rhk61aI2FA51VcZtW90JK0hCZgRRJfw+vxkN+hdnPj7u7+GiqAxcvO8/
        ZFCwuZTgv6awfG+YvlOPGsyqMoYU4WpOT7iyW
X-Received: by 2002:a19:9102:: with SMTP id t2mr4263975lfd.431.1633526973110;
        Wed, 06 Oct 2021 06:29:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXKn/6Bfm2mm70Ig+2BseuKQIkDzaugyqTqGjoigj0kYItm2g3eUz6fl7aOdDI4FnW9IgceA==
X-Received: by 2002:a19:9102:: with SMTP id t2mr4263947lfd.431.1633526972903;
        Wed, 06 Oct 2021 06:29:32 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a23sm1715544ljb.107.2021.10.06.06.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 06:29:32 -0700 (PDT)
Subject: Re: [PATCH 6/7] tty: serial: samsung_tty: Support runtime PM
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-7-marcan@marcan.st>
 <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
 <CAJZ5v0hWC0UxwVrCdJ64rR66UYwdMhCvkYKV00sTeZ2m4-AonQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d4004d9c-7ff9-2263-58b3-94c13eb3e47d@canonical.com>
Date:   Wed, 6 Oct 2021 15:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hWC0UxwVrCdJ64rR66UYwdMhCvkYKV00sTeZ2m4-AonQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 15:25, Rafael J. Wysocki wrote:
> On Wed, Oct 6, 2021 at 9:44 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 05/10/2021 17:59, Hector Martin wrote:
>>> This allows idle UART devices to be suspended using the standard
>>> runtime-PM framework. The logic is modeled after stm32-usart.
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> ---
>>>  drivers/tty/serial/samsung_tty.c | 88 ++++++++++++++++++++------------
>>>  1 file changed, 54 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
>>> index e2f49863e9c2..d68e3341adc6 100644
>>> --- a/drivers/tty/serial/samsung_tty.c
>>> +++ b/drivers/tty/serial/samsung_tty.c
>>> @@ -40,6 +40,7 @@
>>>  #include <linux/clk.h>
>>>  #include <linux/cpufreq.h>
>>>  #include <linux/of.h>
>>> +#include <linux/pm_runtime.h>
>>>  #include <asm/irq.h>
>>>
>>>  /* UART name and device definitions */
>>> @@ -1381,31 +1382,49 @@ static void exynos_usi_init(struct uart_port *port)
>>>
>>>  /* power power management control */
>>>
>>> -static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
>>> -                           unsigned int old)
>>> +static int __maybe_unused s3c24xx_serial_runtime_suspend(struct device *dev)
>>>  {
>>> +     struct uart_port *port = dev_get_drvdata(dev);
>>>       struct s3c24xx_uart_port *ourport = to_ourport(port);
>>>       int timeout = 10000;
>>>
>>> -     ourport->pm_level = level;
>>> +     while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
>>> +             udelay(100);
>>>
>>> -     switch (level) {
>>> -     case 3:
>>> -             while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
>>> -                     udelay(100);
>>> +     if (!IS_ERR(ourport->baudclk))
>>> +             clk_disable_unprepare(ourport->baudclk);
>>>
>>> -             if (!IS_ERR(ourport->baudclk))
>>> -                     clk_disable_unprepare(ourport->baudclk);
>>> +     clk_disable_unprepare(ourport->clk);
>>> +     return 0;
>>> +};
>>>
>>> -             clk_disable_unprepare(ourport->clk);
>>> -             break;
>>> +static int __maybe_unused s3c24xx_serial_runtime_resume(struct device *dev)
>>> +{
>>> +     struct uart_port *port = dev_get_drvdata(dev);
>>> +     struct s3c24xx_uart_port *ourport = to_ourport(port);
>>>
>>> -     case 0:
>>> -             clk_prepare_enable(ourport->clk);
>>> +     clk_prepare_enable(ourport->clk);
>>>
>>> -             if (!IS_ERR(ourport->baudclk))
>>> -                     clk_prepare_enable(ourport->baudclk);
>>> +     if (!IS_ERR(ourport->baudclk))
>>> +             clk_prepare_enable(ourport->baudclk);
>>> +     return 0;
>>> +};
>>> +
>>> +static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
>>> +                           unsigned int old)
>>> +{
>>> +     struct s3c24xx_uart_port *ourport = to_ourport(port);
>>> +
>>> +     ourport->pm_level = level;
>>>
>>> +     switch (level) {
>>> +     case UART_PM_STATE_OFF:
>>> +             pm_runtime_mark_last_busy(port->dev);
>>> +             pm_runtime_put_sync(port->dev);
>>> +             break;
>>> +
>>> +     case UART_PM_STATE_ON:
>>> +             pm_runtime_get_sync(port->dev);
>>>               exynos_usi_init(port);
>>>               break;
>>>       default:
>>> @@ -2282,18 +2301,15 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>>>               }
>>>       }
>>>
>>> +     pm_runtime_get_noresume(&pdev->dev);
>>> +     pm_runtime_set_active(&pdev->dev);
>>> +     pm_runtime_enable(&pdev->dev);
>>> +
>>
>> You need to cleanup in error paths (put/disable).
>>
>>>       dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
>>>       uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
>>>       platform_set_drvdata(pdev, &ourport->port);
>>>
>>> -     /*
>>> -      * Deactivate the clock enabled in s3c24xx_serial_init_port here,
>>> -      * so that a potential re-enablement through the pm-callback overlaps
>>> -      * and keeps the clock enabled in this case.
>>> -      */
>>> -     clk_disable_unprepare(ourport->clk);
>>> -     if (!IS_ERR(ourport->baudclk))
>>> -             clk_disable_unprepare(ourport->baudclk);
>>> +     pm_runtime_put_sync(&pdev->dev);
>>>
>>>       ret = s3c24xx_serial_cpufreq_register(ourport);
>>>       if (ret < 0)
>>> @@ -2309,8 +2325,14 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
>>>       struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
>>>
>>>       if (port) {
>>> +             pm_runtime_get_sync(&dev->dev);
>>
>> 1. You need to check return status.
> 
> Why?  What can be done differently if the resume fails?

The answer is connected with the point (2) below. If there were for
example register access here, maybe it should be simply skipped to avoid
imprecise abort...

> 
>> 2. Why do you need to resume the device here?
> 
> This appears to be to prevent the device from suspending after the given point.

Makes sense.

> 
>>> +
>>>               s3c24xx_serial_cpufreq_deregister(to_ourport(port));
>>>               uart_remove_one_port(&s3c24xx_uart_drv, port);
>>> +
>>> +             pm_runtime_disable(&dev->dev);
>>
>> Why disabling it only if port!=NULL? Can remove() be called if
>> platform_set_drvdata() was not?
>>
>>> +             pm_runtime_set_suspended(&dev->dev);
>>> +             pm_runtime_put_noidle(&dev->dev);
>>>       }
>>>
>>>       uart_unregister_driver(&s3c24xx_uart_drv);
>>> @@ -2319,8 +2341,8 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
>>>  }
>>>
>>
>> Best regards,
>> Krzysztof


Best regards,
Krzysztof
