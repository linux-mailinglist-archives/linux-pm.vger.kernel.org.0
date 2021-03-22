Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EECE3446C2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 15:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCVOJI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 10:09:08 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43943 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhCVOIv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 10:08:51 -0400
Received: by mail-lj1-f181.google.com with SMTP id y1so21178520ljm.10;
        Mon, 22 Mar 2021 07:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DjeXTzNazMiJiGna6zzafYIk3RTDoVxg5DdIRkouymA=;
        b=PbGMyDHWpAIolO0N4UTxDNgiWzGcbtPKpdRe7BhX5uUWBeiYVf5WGRdKJNJjIBPRh5
         5xS3PhDwV4mAWvE0zQq0TWhK2Nx7qPGISV/d6B6H1pEfMWafWgKfBOGYVmBlnNY59rxs
         eT8OlYU1QnxRuPokDc8Cbvp3LV64s60OScLavi46Hb2egWqGFcrjWoqYXokCcohCtE9X
         hIfT5vIOmCRT7zYz4rDcBty/Yht944R80VtYM+SAh63PDVGdi7L4sYNM5RXUyeO1lBvP
         B0nml0YOAuXtCPX4rSfyr3fxbGOVBymAzajIHeIuCN/EuuCedwNa6+8ZMdTqqYBcNwcN
         CiyQ==
X-Gm-Message-State: AOAM530Bwo9tgcd9JlBdjqVqXdDxVMQ/5izGgWF5DyEjIbt5obnXP66A
        g4FWbkeTq9GYCnJS7Vr5TJIVC/izv3XY7g==
X-Google-Smtp-Source: ABdhPJwv8R60LY6+kYLi+DbQVo78lRQg3ib80v+EZcsB/l7XMEqptMwlo2LIe4IBpZftqSA4tjXvDA==
X-Received: by 2002:a2e:9204:: with SMTP id k4mr9597080ljg.203.1616422129298;
        Mon, 22 Mar 2021 07:08:49 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id z10sm1583260lfe.114.2021.03.22.07.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 07:08:49 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id o126so12006781lfa.0;
        Mon, 22 Mar 2021 07:08:49 -0700 (PDT)
X-Received: by 2002:a19:e12:: with SMTP id 18mr9671138lfo.296.1616422128984;
 Mon, 22 Mar 2021 07:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com> <a4588ab46ab6ae621f24cd3b6983c72032f41360.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <a4588ab46ab6ae621f24cd3b6983c72032f41360.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 22 Mar 2021 22:08:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64cat4mr=5FJfYRG85mt7_sFwG-XjWbDjkekuEEAUQvnQ@mail.gmail.com>
Message-ID: <CAGb2v64cat4mr=5FJfYRG85mt7_sFwG-XjWbDjkekuEEAUQvnQ@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH v2 6/8] power: supply: Clean-up few drivers by
 using managed work init
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Mar 22, 2021 at 3:38 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Few drivers implement remove call-back only for ensuring a delayed
> work gets cancelled prior driver removal. Clean-up these by switching
> to use devm_delayed_work_autocancel() instead.
>
> This change is compile-tested only. All testing is appreciated.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/power/supply/axp20x_usb_power.c      | 15 +++++----------
>  drivers/power/supply/bq24735-charger.c       | 18 ++++++------------
>  drivers/power/supply/ltc2941-battery-gauge.c | 20 +++++++-------------
>  drivers/power/supply/sbs-battery.c           | 16 +++++-----------
>  4 files changed, 23 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index 8933ae26c3d6..4259709e3491 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -646,21 +647,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
> +                                          axp20x_usb_power_poll_vbus);
> +       if (ret)
> +               return ret;

This doesn't look right. The IRQ is requested before this, and the delayed_work
struct is initialized even earlier, so you'd be re-initializing the struct,
with the work item potentially running or queued up already.


ChenYu

>         if (axp20x_usb_vbus_needs_polling(power))
>                 queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
>
>         return 0;
>  }
>
> -static int axp20x_usb_power_remove(struct platform_device *pdev)
> -{
> -       struct axp20x_usb_power *power = platform_get_drvdata(pdev);
> -
> -       cancel_delayed_work_sync(&power->vbus_detect);
> -
> -       return 0;
> -}
> -
>  static const struct of_device_id axp20x_usb_power_match[] = {
>         {
>                 .compatible = "x-powers,axp202-usb-power-supply",
> @@ -680,7 +676,6 @@ MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
>
>  static struct platform_driver axp20x_usb_power_driver = {
>         .probe = axp20x_usb_power_probe,
> -       .remove = axp20x_usb_power_remove,
>         .driver = {
>                 .name           = DRVNAME,
>                 .of_match_table = axp20x_usb_power_match,
