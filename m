Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DF346196
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhCWOgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:36:36 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:33485 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhCWOgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 10:36:19 -0400
Received: by mail-vs1-f45.google.com with SMTP id a15so9482938vsi.0;
        Tue, 23 Mar 2021 07:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=p0MfGa/L8ELLoIQbdgOitYXykyrEfb/PHZvBkwW0O0I=;
        b=ZE/e8C/7rWQIDZgB5/sfWlVxMk3XitHX+JWRX4VQjB/wojvQt+1NSUMD5ytE7Yc7jp
         aFap7Nbvznqelhu7D0+6yonejK01C4yb7K/GYSFQrLBUGE3lutXtze5q1AfUg2zRZNCS
         6DruaJSV24O/lnNLKBCsR5gwZ5oEa+UcowJz2QMtdzSOdvUatW9Znzuca+ggYuzLqkX6
         r4WD9OyM2sg0jJUktfwmApMzroR0ZYGwBT2GpKxWfWnHW5FLUk3mwfl9hRV/ztrks2XD
         a4tQNHhu1LOX5pZODoEPEjEHTKVkyEQFiZlxhLdHRzG/LxfcZOWbwL8IZ3n9kmh9ZUJZ
         7h+Q==
X-Gm-Message-State: AOAM530httNMGhdxxZUS0poL0b3oSpexcDVumYrqV25GuQjl44Afdxcs
        lkcQ8WzWbXR9gCRRPawl/Fu22r7qJCHtuA==
X-Google-Smtp-Source: ABdhPJwhnUByn5LLoIQPKqTJ/exoifsFX9MxoLdiqZ8ED4tG4wsPAV1NNJscnBkxWhD5c5YNDE6ceA==
X-Received: by 2002:a05:6102:902:: with SMTP id x2mr3665257vsh.31.1616510178033;
        Tue, 23 Mar 2021 07:36:18 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id e142sm2272649vsc.16.2021.03.23.07.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 07:36:17 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id q18so6758454uas.11;
        Tue, 23 Mar 2021 07:36:17 -0700 (PDT)
X-Received: by 2002:a9f:3fcf:: with SMTP id m15mr3393309uaj.55.1616510176948;
 Tue, 23 Mar 2021 07:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com> <e5b1b0380cdd1aa066c9ac6d7a8b1a86ba1ddbbe.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <e5b1b0380cdd1aa066c9ac6d7a8b1a86ba1ddbbe.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 23 Mar 2021 22:36:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Jd6qFS-zmD+Hm4BJHA+-kx0nAxvDovUwW=WwZTEGYeg@mail.gmail.com>
Message-ID: <CAGb2v67Jd6qFS-zmD+Hm4BJHA+-kx0nAxvDovUwW=WwZTEGYeg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] power: supply: Clean-up few drivers by using
 managed work init
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

On Tue, Mar 23, 2021 at 9:58 PM Matti Vaittinen
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
> Changelog from RFCv2:
>  - RFC dropped. No functional changes.
>
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
