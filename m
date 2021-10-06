Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68524423EE8
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhJFN1h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 09:27:37 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45968 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbhJFN12 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 09:27:28 -0400
Received: by mail-ot1-f44.google.com with SMTP id 66-20020a9d0548000000b0054e21cd00f4so2899679otw.12;
        Wed, 06 Oct 2021 06:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFj6PAsZPblCmvtV66vb9o9j+/xLW6cMAwOn+M0zyTA=;
        b=HcQ0/M2LuThTQ81rbaJ7swDzAKsVrp0zakDv3Aynko9Cf2ID5M8d6vsOT9eUIr6KMM
         FW5rqnkKDGhG0GOFxyYE3Zzht09/wxf4shYZfXuNeu/xExig2dEp2GV/RrJj/PlCWCeP
         iXCbMqF1qIrLGBff4Eu+2nxxaQe8rdgU5zCX2ujtMHwWNdbn22pb5c0dH0q5AFNJ5uPf
         QKiKjCpu4/JWLLEyCksgEmGXP6A679uKPp47pWIy7DyW/QwdT8SfgASPS9QVhwMo4ZTT
         S7scGNw1giUB22BKXjyTzFdAHKuk18VAYu+WYjZoPv2o97ZM3fBeuv6aEzaYiAvDcr1L
         2veA==
X-Gm-Message-State: AOAM532zDdzfiIFgI/TuhJZT4u5sgSYIVuSvWWElqZr/wmY8VmEOCVB8
        LNNHBdgsLgOA9kaQq8QCPjGy0MlrYHTEk7imuLY=
X-Google-Smtp-Source: ABdhPJzwgoaANVynzs0esxptCK1meFgk7RGupfEI/ZN5tZQ//T73X87Fhla//G47QM/6Ngq0L7s56xVk/gBAftfhftA=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr19259845ots.319.1633526735389;
 Wed, 06 Oct 2021 06:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211005155923.173399-1-marcan@marcan.st> <20211005155923.173399-7-marcan@marcan.st>
 <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
In-Reply-To: <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Oct 2021 15:25:23 +0200
Message-ID: <CAJZ5v0hWC0UxwVrCdJ64rR66UYwdMhCvkYKV00sTeZ2m4-AonQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] tty: serial: samsung_tty: Support runtime PM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 6, 2021 at 9:44 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 05/10/2021 17:59, Hector Martin wrote:
> > This allows idle UART devices to be suspended using the standard
> > runtime-PM framework. The logic is modeled after stm32-usart.
> >
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 88 ++++++++++++++++++++------------
> >  1 file changed, 54 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index e2f49863e9c2..d68e3341adc6 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/of.h>
> > +#include <linux/pm_runtime.h>
> >  #include <asm/irq.h>
> >
> >  /* UART name and device definitions */
> > @@ -1381,31 +1382,49 @@ static void exynos_usi_init(struct uart_port *port)
> >
> >  /* power power management control */
> >
> > -static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> > -                           unsigned int old)
> > +static int __maybe_unused s3c24xx_serial_runtime_suspend(struct device *dev)
> >  {
> > +     struct uart_port *port = dev_get_drvdata(dev);
> >       struct s3c24xx_uart_port *ourport = to_ourport(port);
> >       int timeout = 10000;
> >
> > -     ourport->pm_level = level;
> > +     while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
> > +             udelay(100);
> >
> > -     switch (level) {
> > -     case 3:
> > -             while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
> > -                     udelay(100);
> > +     if (!IS_ERR(ourport->baudclk))
> > +             clk_disable_unprepare(ourport->baudclk);
> >
> > -             if (!IS_ERR(ourport->baudclk))
> > -                     clk_disable_unprepare(ourport->baudclk);
> > +     clk_disable_unprepare(ourport->clk);
> > +     return 0;
> > +};
> >
> > -             clk_disable_unprepare(ourport->clk);
> > -             break;
> > +static int __maybe_unused s3c24xx_serial_runtime_resume(struct device *dev)
> > +{
> > +     struct uart_port *port = dev_get_drvdata(dev);
> > +     struct s3c24xx_uart_port *ourport = to_ourport(port);
> >
> > -     case 0:
> > -             clk_prepare_enable(ourport->clk);
> > +     clk_prepare_enable(ourport->clk);
> >
> > -             if (!IS_ERR(ourport->baudclk))
> > -                     clk_prepare_enable(ourport->baudclk);
> > +     if (!IS_ERR(ourport->baudclk))
> > +             clk_prepare_enable(ourport->baudclk);
> > +     return 0;
> > +};
> > +
> > +static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> > +                           unsigned int old)
> > +{
> > +     struct s3c24xx_uart_port *ourport = to_ourport(port);
> > +
> > +     ourport->pm_level = level;
> >
> > +     switch (level) {
> > +     case UART_PM_STATE_OFF:
> > +             pm_runtime_mark_last_busy(port->dev);
> > +             pm_runtime_put_sync(port->dev);
> > +             break;
> > +
> > +     case UART_PM_STATE_ON:
> > +             pm_runtime_get_sync(port->dev);
> >               exynos_usi_init(port);
> >               break;
> >       default:
> > @@ -2282,18 +2301,15 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     pm_runtime_get_noresume(&pdev->dev);
> > +     pm_runtime_set_active(&pdev->dev);
> > +     pm_runtime_enable(&pdev->dev);
> > +
>
> You need to cleanup in error paths (put/disable).
>
> >       dev_dbg(&pdev->dev, "%s: adding port\n", __func__);
> >       uart_add_one_port(&s3c24xx_uart_drv, &ourport->port);
> >       platform_set_drvdata(pdev, &ourport->port);
> >
> > -     /*
> > -      * Deactivate the clock enabled in s3c24xx_serial_init_port here,
> > -      * so that a potential re-enablement through the pm-callback overlaps
> > -      * and keeps the clock enabled in this case.
> > -      */
> > -     clk_disable_unprepare(ourport->clk);
> > -     if (!IS_ERR(ourport->baudclk))
> > -             clk_disable_unprepare(ourport->baudclk);
> > +     pm_runtime_put_sync(&pdev->dev);
> >
> >       ret = s3c24xx_serial_cpufreq_register(ourport);
> >       if (ret < 0)
> > @@ -2309,8 +2325,14 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
> >       struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
> >
> >       if (port) {
> > +             pm_runtime_get_sync(&dev->dev);
>
> 1. You need to check return status.

Why?  What can be done differently if the resume fails?

> 2. Why do you need to resume the device here?

This appears to be to prevent the device from suspending after the given point.

> > +
> >               s3c24xx_serial_cpufreq_deregister(to_ourport(port));
> >               uart_remove_one_port(&s3c24xx_uart_drv, port);
> > +
> > +             pm_runtime_disable(&dev->dev);
>
> Why disabling it only if port!=NULL? Can remove() be called if
> platform_set_drvdata() was not?
>
> > +             pm_runtime_set_suspended(&dev->dev);
> > +             pm_runtime_put_noidle(&dev->dev);
> >       }
> >
> >       uart_unregister_driver(&s3c24xx_uart_drv);
> > @@ -2319,8 +2341,8 @@ static int s3c24xx_serial_remove(struct platform_device *dev)
> >  }
> >
>
> Best regards,
> Krzysztof
