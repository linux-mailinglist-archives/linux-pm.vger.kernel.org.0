Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB763021
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 07:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGIFpF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 01:45:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39035 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfGIFpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 01:45:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so3240086otq.6
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2019 22:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P212O3pD6J1OHFbkKOo30mb6JIIMTTuJiFwciEcoMBI=;
        b=XAl2MDBM1SqnFzOMbq9qOjKyVUmi6eASeOwZqhW4/RSgqSMKiwgIoXCZzXefE/Tv6o
         xsyfIgJgsYWkEXNA/DcJMaXO9CvxreOkZqvDPD2cKcOQFOVrdZCf0yp8VC6ntO/kK2GE
         Ib6o+dYeMWoeAx7R2t9enaqt9XioShu3aUhWtB/1DbvL2dD8miEOSmHeS9BxU563H6+P
         r6HJ+ScsU0jvKZS0xaO1ie3zyJQ0yWVpgtSFaMdrWkFVNrdK20MUWRLW62kh7Sg85Fik
         Kf1TZ0kwjrYH2RwyScIVwvE1De5SEeTDqah423zA2jhXwAxxkU81dDCI2OV/cfGv82fG
         QGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P212O3pD6J1OHFbkKOo30mb6JIIMTTuJiFwciEcoMBI=;
        b=PNOzC1gVbd5V0WZgEFXmHM76TISEl+6E8oYuHWfyq0CDyVXPneILdROuMbqAXGzNEG
         86cD1DThuAHTCgrl8z912tceHqTH3qexZm6wpAqpxGJeMU9iVC4GgLOgpdSqmaV81HDK
         wdGos92HXQBIQeAQrZJ9X3r4AK5ZfgXheSijKowwfuY2DQtiN1tmHeamW00y/5RhU62r
         h/eOk8+qykbPUzmhR6LG4ga5KQz7qX3oqYNkgO9kxjGPI76b91JbgykJv5OKt3KpLH9m
         wrAJfg40qi4ahBb2GEbe6IepUqMyAwl29Jgh7YG1MOHOxx9ONKCaAtvzv6V9va+qC40i
         NjwQ==
X-Gm-Message-State: APjAAAXsfg6uO8bp6SPGluCPhJzxuVAybPY/IS5s9ChUKQ7W/RVYx6wc
        Im/4eeEViCyx9k40fzGL2+MtjYJCre+z8pGW5elm7Q==
X-Google-Smtp-Source: APXvYqw6oUZkKhaG1Q540oYRSkHVIx1Akfrd0ty6pGytUdVf3Ue+NeqdRc2ryNHhrFzl0/ATHqOmJUR42rC/yZojFUg=
X-Received: by 2002:a9d:529:: with SMTP id 38mr17765884otw.145.1562651104246;
 Mon, 08 Jul 2019 22:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190708123251.11759-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190708123251.11759-1-huangfq.daxian@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 9 Jul 2019 13:44:52 +0800
Message-ID: <CAMz4kuJvnops5ecjP9PFwLW=WBPo4do9eawCX3cFTOL45qLgVQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] power: supply: sc27xx: Introduce local variable
 'struct device *dev'
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 8 Jul 2019 at 20:33, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatly.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Looks good to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/power/supply/sc27xx_fuel_gauge.c | 47 ++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
> index 24895cc3b41e..9c184d80088b 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -957,81 +957,82 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
>
>  static int sc27xx_fgu_probe(struct platform_device *pdev)
>  {
> -       struct device_node *np = pdev->dev.of_node;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
>         struct power_supply_config fgu_cfg = { };
>         struct sc27xx_fgu_data *data;
>         int ret, irq;
>
> -       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>         if (!data)
>                 return -ENOMEM;
>
> -       data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       data->regmap = dev_get_regmap(dev->parent, NULL);
>         if (!data->regmap) {
> -               dev_err(&pdev->dev, "failed to get regmap\n");
> +               dev_err(dev, "failed to get regmap\n");
>                 return -ENODEV;
>         }
>
> -       ret = device_property_read_u32(&pdev->dev, "reg", &data->base);
> +       ret = device_property_read_u32(dev, "reg", &data->base);
>         if (ret) {
> -               dev_err(&pdev->dev, "failed to get fgu address\n");
> +               dev_err(dev, "failed to get fgu address\n");
>                 return ret;
>         }
>
> -       data->channel = devm_iio_channel_get(&pdev->dev, "bat-temp");
> +       data->channel = devm_iio_channel_get(dev, "bat-temp");
>         if (IS_ERR(data->channel)) {
> -               dev_err(&pdev->dev, "failed to get IIO channel\n");
> +               dev_err(dev, "failed to get IIO channel\n");
>                 return PTR_ERR(data->channel);
>         }
>
> -       data->charge_chan = devm_iio_channel_get(&pdev->dev, "charge-vol");
> +       data->charge_chan = devm_iio_channel_get(dev, "charge-vol");
>         if (IS_ERR(data->charge_chan)) {
> -               dev_err(&pdev->dev, "failed to get charge IIO channel\n");
> +               dev_err(dev, "failed to get charge IIO channel\n");
>                 return PTR_ERR(data->charge_chan);
>         }
>
> -       data->gpiod = devm_gpiod_get(&pdev->dev, "bat-detect", GPIOD_IN);
> +       data->gpiod = devm_gpiod_get(dev, "bat-detect", GPIOD_IN);
>         if (IS_ERR(data->gpiod)) {
> -               dev_err(&pdev->dev, "failed to get battery detection GPIO\n");
> +               dev_err(dev, "failed to get battery detection GPIO\n");
>                 return PTR_ERR(data->gpiod);
>         }
>
>         ret = gpiod_get_value_cansleep(data->gpiod);
>         if (ret < 0) {
> -               dev_err(&pdev->dev, "failed to get gpio state\n");
> +               dev_err(dev, "failed to get gpio state\n");
>                 return ret;
>         }
>
>         data->bat_present = !!ret;
>         mutex_init(&data->lock);
> -       data->dev = &pdev->dev;
> +       data->dev = dev;
>         platform_set_drvdata(pdev, data);
>
>         fgu_cfg.drv_data = data;
>         fgu_cfg.of_node = np;
> -       data->battery = devm_power_supply_register(&pdev->dev, &sc27xx_fgu_desc,
> +       data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
>                                                    &fgu_cfg);
>         if (IS_ERR(data->battery)) {
> -               dev_err(&pdev->dev, "failed to register power supply\n");
> +               dev_err(dev, "failed to register power supply\n");
>                 return PTR_ERR(data->battery);
>         }
>
>         ret = sc27xx_fgu_hw_init(data);
>         if (ret) {
> -               dev_err(&pdev->dev, "failed to initialize fgu hardware\n");
> +               dev_err(dev, "failed to initialize fgu hardware\n");
>                 return ret;
>         }
>
> -       ret = devm_add_action(&pdev->dev, sc27xx_fgu_disable, data);
> +       ret = devm_add_action(dev, sc27xx_fgu_disable, data);
>         if (ret) {
>                 sc27xx_fgu_disable(data);
> -               dev_err(&pdev->dev, "failed to add fgu disable action\n");
> +               dev_err(dev, "failed to add fgu disable action\n");
>                 return ret;
>         }
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
> -               dev_err(&pdev->dev, "no irq resource specified\n");
> +               dev_err(dev, "no irq resource specified\n");
>                 return irq;
>         }
>
> @@ -1046,17 +1047,17 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
>
>         irq = gpiod_to_irq(data->gpiod);
>         if (irq < 0) {
> -               dev_err(&pdev->dev, "failed to translate GPIO to IRQ\n");
> +               dev_err(dev, "failed to translate GPIO to IRQ\n");
>                 return irq;
>         }
>
> -       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +       ret = devm_request_threaded_irq(dev, irq, NULL,
>                                         sc27xx_fgu_bat_detection,
>                                         IRQF_ONESHOT | IRQF_TRIGGER_RISING |
>                                         IRQF_TRIGGER_FALLING,
>                                         pdev->name, data);
>         if (ret) {
> -               dev_err(&pdev->dev, "failed to request IRQ\n");
> +               dev_err(dev, "failed to request IRQ\n");
>                 return ret;
>         }
>
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards
