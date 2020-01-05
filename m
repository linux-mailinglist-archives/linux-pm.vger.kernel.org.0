Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71D4130714
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 11:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAEKfC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 05:35:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40511 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgAEKfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 05:35:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so45144195edx.7;
        Sun, 05 Jan 2020 02:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYETpdZ2mRczL5SotBEID+XkiFWbeEdqRen+MEr3I8o=;
        b=Wy11CIAL6lGCs7h2cAj7LYi1miElEyG11gL5iUKU+fc2/oDgv597bTE0J367sYY8G6
         WURLFBXqC7pIwKi8jB093N1I2/14ZFnrmbq8+TrAMdqpkyeUHXmijkfb539r8cw5dnNt
         AaK8wjUvYfa4gRaU7FKecBYV9bJGzKK2P7FUc4xOnIAKRQaORHQYSHOzLHZF1kp0AaPt
         DiggrD+PkK0dRqey58/3J7CLrlwNZzbZuJ8DI+nFvlD0NVrd4n/DIeIVGOI3Ns70xb2x
         auo8Fj4fFp3VxdFQR1otMtEWAI6/4VTq6QryRqo5l2Ed8J60mXbGWmd36njFq5KKu6je
         gzVQ==
X-Gm-Message-State: APjAAAVJoiNWL/XBFfCEv7rRq/5EpX7bEE0S3yLPHq7QOwBCxhpw50UW
        cPTf88AU9cyY1dNZ4YC7NPigeJN7feE=
X-Google-Smtp-Source: APXvYqzLk1JO6nw7Te+p5R3ACWDzB9HG+VU7PjaY85FHFt8NTAj8zKEZ6NbJqC6zVkd8dGby2S8LaQ==
X-Received: by 2002:a17:906:a14:: with SMTP id w20mr103037573ejf.274.1578220499089;
        Sun, 05 Jan 2020 02:34:59 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id n14sm7990870ejx.11.2020.01.05.02.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 02:34:58 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id u2so12375427wmc.3;
        Sun, 05 Jan 2020 02:34:58 -0800 (PST)
X-Received: by 2002:a1c:a50e:: with SMTP id o14mr28143754wme.2.1578220498338;
 Sun, 05 Jan 2020 02:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-7-samuel@sholland.org>
In-Reply-To: <20200105012416.23296-7-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 5 Jan 2020 18:34:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v67rudw=3x9QBxeSqmMN-Qrt4+=3VD0u6H7JeS4KT8caqg@mail.gmail.com>
Message-ID: <CAGb2v67rudw=3x9QBxeSqmMN-Qrt4+=3VD0u6H7JeS4KT8caqg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 6/9] power: supply: axp20x_usb_power: Use
 a match structure
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Instead of ad-hoc variant ID checks throughout the code, let's start
> moving the variant-specific details to a match structure. This allows
> for future flexibility, and it better matches the other axp20x power
> supply drivers.

You should probably mention that there are still parts of the code
where ID matching is done.

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 91 ++++++++++++++++---------
>  1 file changed, 60 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index dd3f3f12e41d..2d7272e19a87 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -405,6 +405,50 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
>         .set_property = axp20x_usb_power_set_property,
>  };
>
> +static const char * const axp20x_irq_names[] = {
> +       "VBUS_PLUGIN",
> +       "VBUS_REMOVAL",
> +       "VBUS_VALID",
> +       "VBUS_NOT_VALID",
> +       NULL
> +};
> +
> +static const char * const axp22x_irq_names[] = {
> +       "VBUS_PLUGIN",
> +       "VBUS_REMOVAL",
> +       NULL
> +};
> +
> +struct axp_data {
> +       const struct power_supply_desc  *power_desc;
> +       const char * const              *irq_names;
> +       enum axp20x_variants            axp20x_id;
> +};
> +
> +static const struct axp_data axp202_data = {
> +       .power_desc     = &axp20x_usb_power_desc,
> +       .irq_names      = axp20x_irq_names,
> +       .axp20x_id      = AXP202_ID,
> +};
> +
> +static const struct axp_data axp221_data = {
> +       .power_desc     = &axp22x_usb_power_desc,
> +       .irq_names      = axp22x_irq_names,
> +       .axp20x_id      = AXP221_ID,
> +};
> +
> +static const struct axp_data axp223_data = {
> +       .power_desc     = &axp22x_usb_power_desc,
> +       .irq_names      = axp22x_irq_names,
> +       .axp20x_id      = AXP223_ID,
> +};
> +
> +static const struct axp_data axp813_data = {
> +       .power_desc     = &axp22x_usb_power_desc,
> +       .irq_names      = axp22x_irq_names,
> +       .axp20x_id      = AXP813_ID,
> +};
> +
>  static int configure_iio_channels(struct platform_device *pdev,
>                                   struct axp20x_usb_power *power)
>  {
> @@ -440,12 +484,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>         struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>         struct power_supply_config psy_cfg = {};
>         struct axp20x_usb_power *power;
> -       static const char * const axp20x_irq_names[] = { "VBUS_PLUGIN",
> -               "VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID", NULL };
> -       static const char * const axp22x_irq_names[] = {
> -               "VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
> -       const char * const *irq_names;
> -       const struct power_supply_desc *usb_power_desc;
> +       const struct axp_data *axp_data;
>         int i, irq, ret;
>
>         if (!of_device_is_available(pdev->dev.of_node))
> @@ -456,15 +495,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +       axp_data = of_device_get_match_data(&pdev->dev);
> +
>         power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
>         if (!power)
>                 return -ENOMEM;
>
> -       platform_set_drvdata(pdev, power);
> -       power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
> -                                                               &pdev->dev);
> -
>         power->regmap = axp20x->regmap;
> +       power->axp20x_id = axp_data->axp20x_id;
> +
> +       platform_set_drvdata(pdev, power);

Not sure why this needs to be reordered.

>         if (power->axp20x_id == AXP202_ID) {
>                 /* Enable vbus valid checking */
> @@ -481,18 +521,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>
>                 if (ret)
>                         return ret;
> -
> -               usb_power_desc = &axp20x_usb_power_desc;
> -               irq_names = axp20x_irq_names;
> -       } else if (power->axp20x_id == AXP221_ID ||
> -                  power->axp20x_id == AXP223_ID ||
> -                  power->axp20x_id == AXP813_ID) {
> -               usb_power_desc = &axp22x_usb_power_desc;
> -               irq_names = axp22x_irq_names;
> -       } else {
> -               dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
> -                       axp20x->variant);
> -               return -EINVAL;
>         }
>
>         if (power->axp20x_id == AXP813_ID) {
> @@ -504,17 +532,18 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>         psy_cfg.of_node = pdev->dev.of_node;
>         psy_cfg.drv_data = power;
>
> -       power->supply = devm_power_supply_register(&pdev->dev, usb_power_desc,
> +       power->supply = devm_power_supply_register(&pdev->dev,
> +                                                  axp_data->power_desc,
>                                                    &psy_cfg);
>         if (IS_ERR(power->supply))
>                 return PTR_ERR(power->supply);
>
>         /* Request irqs after registering, as irqs may trigger immediately */
> -       for (i = 0; irq_names[i]; i++) {
> -               irq = platform_get_irq_byname(pdev, irq_names[i]);
> +       for (i = 0; axp_data->irq_names[i]; i++) {
> +               irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
>                 if (irq < 0) {
>                         dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> -                                irq_names[i], irq);
> +                                axp_data->irq_names[i], irq);
>                         continue;
>                 }
>                 irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> @@ -522,7 +551,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>                                 axp20x_usb_power_irq, 0, DRVNAME, power);
>                 if (ret < 0)
>                         dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> -                                irq_names[i], ret);
> +                                axp_data->irq_names[i], ret);
>         }
>
>         INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
> @@ -544,16 +573,16 @@ static int axp20x_usb_power_remove(struct platform_device *pdev)
>  static const struct of_device_id axp20x_usb_power_match[] = {
>         {
>                 .compatible = "x-powers,axp202-usb-power-supply",
> -               .data = (void *)AXP202_ID,
> +               .data = &axp202_data,
>         }, {
>                 .compatible = "x-powers,axp221-usb-power-supply",
> -               .data = (void *)AXP221_ID,
> +               .data = &axp221_data,
>         }, {
>                 .compatible = "x-powers,axp223-usb-power-supply",
> -               .data = (void *)AXP223_ID,
> +               .data = &axp223_data,
>         }, {
>                 .compatible = "x-powers,axp813-usb-power-supply",
> -               .data = (void *)AXP813_ID,
> +               .data = &axp813_data,
>         }, { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
> --
> 2.23.0

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
