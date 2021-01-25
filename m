Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADA3020DD
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 04:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbhAYDmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Jan 2021 22:42:14 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41595 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAYDmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jan 2021 22:42:14 -0500
Received: by mail-lj1-f174.google.com with SMTP id f11so13559706ljm.8;
        Sun, 24 Jan 2021 19:41:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsWOPVVebh8NoYzkQbBqzXbOw2W6S43eUM3sdOKqu1k=;
        b=hlgPcufewTWyoMRMnyRPZh2YICFrz9pIKMAgipDG+odRSa0XULe429prONjKOmuXpL
         eDyiUevfuEdDGdy02+f84JZf+duLIBKMN6shuADsdZUykEFzN/tLLyLFrsQbQuJHfA08
         TSxzNdOzAMZ/eJk6Cl7URK3jS97xVc0/wTNSuytNqSjmawQrYLSVYbVCSuG4IkwKpTuA
         I0jAIVfEb2BKmlWgNuyJDiht0Xod5JEfbK0/tVcnjebFM0fb1vqxpVu2GJw3bZfkIxGp
         V0XsC3PjZmtdKFsgJTGEpzHuMzGlpRUS1FdNeo8EUqOBGcwLEo9lwXv5+kKVjyx2VbEV
         rTVQ==
X-Gm-Message-State: AOAM532TOytrp7KU3EB83b2km4E/O+cQckko2qOzasW2E+lfF7j5XOVb
        teKSbL8N1RggMQzPV+L4y27q5IWS0nEI5Q==
X-Google-Smtp-Source: ABdhPJzOmPlojCD8p4IIh07lMBwTGHAruJl9Ezil9g+Ojxys6cRkos1qoZMoL1UsvVfqdm369eWbyA==
X-Received: by 2002:a05:651c:31c:: with SMTP id a28mr936046ljp.119.1611546091376;
        Sun, 24 Jan 2021 19:41:31 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a6sm1446992ljd.62.2021.01.24.19.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 19:41:31 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id s18so450734ljg.7;
        Sun, 24 Jan 2021 19:41:31 -0800 (PST)
X-Received: by 2002:a2e:9ccc:: with SMTP id g12mr175261ljj.282.1611546090897;
 Sun, 24 Jan 2021 19:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20210124152421.39693-1-samuel@sholland.org>
In-Reply-To: <20210124152421.39693-1-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 25 Jan 2021 11:41:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v66wS-tCsnnE44MUMYF13hhbsVN1tRRG6p=10yDf870mfw@mail.gmail.com>
Message-ID: <CAGb2v66wS-tCsnnE44MUMYF13hhbsVN1tRRG6p=10yDf870mfw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: Init work before
 enabling IRQs
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 24, 2021 at 11:24 PM Samuel Holland <samuel@sholland.org> wrote:
>
> The IRQ handler calls mod_delayed_work() on power->vbus_detect. However,
> that work item is not initialized until after the IRQs are enabled. If
> an IRQ is already pending when the driver is probed, the driver calls
> mod_delayed_work() on an uninitialized work item, which causes an oops.
>
> Fixes: bcfb7ae3f50b ("power: supply: axp20x_usb_power: Only poll while offline")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index 20817a49110b..02aba3da271a 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -711,20 +711,21 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>                              struct_size(power, irqs, axp_data->num_irq_names),
>                              GFP_KERNEL);
>         if (!power)
>                 return -ENOMEM;
>
>         platform_set_drvdata(pdev, power);
>
>         power->axp20x_id = axp_data->axp20x_id;
>         power->regmap = axp20x->regmap;
>         power->num_irqs = axp_data->num_irq_names;
> +       INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);

Nit:
Since axp20x_usb_power_poll_vbus() calls power_supply_changed() on
power->supply, it would make more sense to have INIT_DELAYED_WORK()
after devm_power_supply_register(), just so things are ordered correctly.
In practice this has no effect on the end result, since by the time the
interrupts are enabled the power supply would have been registered.

ChenYu

>         if (power->axp20x_id == AXP202_ID) {
>                 /* Enable vbus valid checking */
>                 ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
>                                          AXP20X_VBUS_MON_VBUS_VALID,
>                                          AXP20X_VBUS_MON_VBUS_VALID);
>                 if (ret)
>                         return ret;
>
>                 if (IS_ENABLED(CONFIG_AXP20X_ADC))
> @@ -763,21 +764,20 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>                 ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
>                                                    axp20x_usb_power_irq, 0,
>                                                    DRVNAME, power);
>                 if (ret < 0) {
>                         dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
>                                 axp_data->irq_names[i], ret);
>                         return ret;
>                 }
>         }
>
> -       INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
>         if (axp20x_usb_vbus_needs_polling(power))
>                 queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
>
>         return 0;
>  }
>
>  static int axp20x_usb_power_remove(struct platform_device *pdev)
>  {
>         struct axp20x_usb_power *power = platform_get_drvdata(pdev);
>
> --
> 2.26.2
>
