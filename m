Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10260130708
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 11:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgAEKY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 05:24:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39702 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgAEKY6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 05:24:58 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so45146430eds.6;
        Sun, 05 Jan 2020 02:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeHbUqwnj2QyxE3kM0HOfpFIEVel6iHcPE0SvL1GAQA=;
        b=sE+L4jduIW7HFs82x7rD21tuYxTDMfxKbhC+0JispGVSqUDD/wbgL+KnlOC3xtB8QQ
         Ks6YrfzDoz7r2B2XO0dlw1ZlEY1IBH3A8HFZkaVLMWfc4/qFL72lpaWZ3wbHANvDH8WN
         l6Ls7eB1xqTmpRvpFFtotTxlJkOcxtrCqv2x4ulQgyGxgsPNvKzGu2p1QUr5WBz2bMOg
         CSyN0C4fomTQpKqGD7TeeQKSsl6Bo1laxmrUC5f3pydz0u9bG6busMtRPPdLXytE9YDA
         6nuHcD5w1wFJZrrBc5wBKhhg9J/FotkVNIjN9+6PMu+6nKxr/P4iwnZeZCkPFdwE7CO/
         IVHw==
X-Gm-Message-State: APjAAAXPdral152/GyPQDIxh2sW6ICMOaSsk44lzU/RI+IPG8OGmxbpe
        hPs4ZyW/9kfS8rsxWL+xtF2KR0YzkDs=
X-Google-Smtp-Source: APXvYqy+RZbOcs7cEYLFGXvDe4D9r7We70orM0dxooMollrkwB/fJx64z+Q0ERamHbVQTIYv+WPMaA==
X-Received: by 2002:a50:e3c5:: with SMTP id c5mr101070120edm.7.1578219895441;
        Sun, 05 Jan 2020 02:24:55 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id n14sm7989949ejx.11.2020.01.05.02.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 02:24:55 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id c14so46462129wrn.7;
        Sun, 05 Jan 2020 02:24:55 -0800 (PST)
X-Received: by 2002:adf:cf12:: with SMTP id o18mr99244996wrj.361.1578219894697;
 Sun, 05 Jan 2020 02:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-5-samuel@sholland.org>
In-Reply-To: <20200105012416.23296-5-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 5 Jan 2020 18:24:42 +0800
X-Gmail-Original-Message-ID: <CAGb2v67sphtqQiaFKNjOhRbWXmWpVestuSb89Wdjmp1Lc7dWMg@mail.gmail.com>
Message-ID: <CAGb2v67sphtqQiaFKNjOhRbWXmWpVestuSb89Wdjmp1Lc7dWMg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 4/9] power: supply: axp20x_ac_power: Add
 wakeup control
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
> The AC power supply input can be used as a wakeup source. Hook up the
> ACIN_PLUGIN IRQ to trigger wakeup based on userspace configuration.
>
> To do this, we must remember the list of IRQs for the life of the
> device. To know how much space to allocate for the flexible array
> member, we switch from using a NULL sentinel to using an array length.
>
> Because we now depend on the specific order of the IRQs (we assume
> ACIN_PLUGIN is first and always present), failing to acquire an IRQ
> during probe must be a fatal error.
>
> To avoid spuriously waking up the system when the AC power supply is
> not configured as a wakeup source, we must explicitly disable all non-
> wake IRQs during system suspend. This is because the SoC's NMI input is
> shared among all IRQs on the AXP PMIC. Due to the use of regmap-irq, the
> individual IRQs within the PMIC are nested threaded interrupts, and are
> therefore not automatically disabled during system suspend.
>
> The upshot is that if any other device within the MFD (such as the power
> key) is an enabled wakeup source, all enabled IRQs within the PMIC will
> cause wakeup. We still need to call enable_irq_wake() when we *do* want
> wakeup, in case those other wakeup sources on the PMIC are all disabled.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 91 +++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
> index bc2663cd47fa..177b5c1eee8f 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -44,6 +45,8 @@ struct axp20x_ac_power {
>         struct iio_channel *acin_v;
>         struct iio_channel *acin_i;
>         bool has_acin_path_sel;
> +       unsigned int num_irqs;
> +       unsigned int irqs[];
>  };
>
>  static irqreturn_t axp20x_ac_power_irq(int irq, void *devid)
> @@ -242,38 +245,86 @@ static const struct power_supply_desc axp813_ac_power_desc = {
>         .set_property = axp813_ac_power_set_property,
>  };
>
> +static const char * const axp20x_irq_names[] = {
> +       "ACIN_PLUGIN",
> +       "ACIN_REMOVAL",
> +};
> +
>  struct axp_data {
>         const struct power_supply_desc  *power_desc;
> +       const char * const              *irq_names;
> +       unsigned int                    num_irq_names;
>         bool                            acin_adc;
>         bool                            acin_path_sel;
>  };
>
>  static const struct axp_data axp20x_data = {
>         .power_desc     = &axp20x_ac_power_desc,
> +       .irq_names      = axp20x_irq_names,
> +       .num_irq_names  = ARRAY_SIZE(axp20x_irq_names),
>         .acin_adc       = true,
>         .acin_path_sel  = false,
>  };
>
>  static const struct axp_data axp22x_data = {
>         .power_desc     = &axp22x_ac_power_desc,
> +       .irq_names      = axp20x_irq_names,
> +       .num_irq_names  = ARRAY_SIZE(axp20x_irq_names),
>         .acin_adc       = false,
>         .acin_path_sel  = false,
>  };
>
>  static const struct axp_data axp813_data = {
>         .power_desc     = &axp813_ac_power_desc,
> +       .irq_names      = axp20x_irq_names,
> +       .num_irq_names  = ARRAY_SIZE(axp20x_irq_names),
>         .acin_adc       = false,
>         .acin_path_sel  = true,
>  };
>
> +#ifdef CONFIG_PM_SLEEP
> +static int axp20x_ac_power_suspend(struct device *dev)
> +{
> +       struct axp20x_ac_power *power = dev_get_drvdata(dev);
> +       int i = 0;
> +
> +       /*
> +        * Allow wake via ACIN_PLUGIN only.
> +        *
> +        * As nested threaded IRQs are not automatically disabled during
> +        * suspend, we must explicitly disable the remainder of the IRQs.
> +        */
> +       if (device_may_wakeup(&power->supply->dev))
> +               enable_irq_wake(power->irqs[i++]);
> +       while (i < power->num_irqs)
> +               disable_irq(power->irqs[i++]);
> +
> +       return 0;
> +}
> +
> +static int axp20x_ac_power_resume(struct device *dev)
> +{
> +       struct axp20x_ac_power *power = dev_get_drvdata(dev);
> +       int i = 0;
> +
> +       if (device_may_wakeup(&power->supply->dev))
> +               disable_irq_wake(power->irqs[i++]);
> +       while (i < power->num_irqs)
> +               enable_irq(power->irqs[i++]);
> +
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(axp20x_ac_power_pm_ops, axp20x_ac_power_suspend,
> +                                                axp20x_ac_power_resume);
> +
>  static int axp20x_ac_power_probe(struct platform_device *pdev)
>  {
>         struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>         struct power_supply_config psy_cfg = {};
>         struct axp20x_ac_power *power;
>         const struct axp_data *axp_data;
> -       static const char * const irq_names[] = { "ACIN_PLUGIN", "ACIN_REMOVAL",
> -               NULL };
>         int i, irq, ret;
>
>         if (!of_device_is_available(pdev->dev.of_node))
> @@ -284,12 +335,14 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> +       axp_data = of_device_get_match_data(&pdev->dev);
> +
> +       power = devm_kzalloc(&pdev->dev,
> +                            struct_size(power, irqs, axp_data->num_irq_names),
> +                            GFP_KERNEL);
>         if (!power)
>                 return -ENOMEM;
>
> -       axp_data = of_device_get_match_data(&pdev->dev);
> -

This change doesn't seem related, nor is it needed.


>         if (axp_data->acin_adc) {
>                 power->acin_v = devm_iio_channel_get(&pdev->dev, "acin_v");
>                 if (IS_ERR(power->acin_v)) {
> @@ -308,6 +361,7 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
>
>         power->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>         power->has_acin_path_sel = axp_data->acin_path_sel;
> +       power->num_irqs = axp_data->num_irq_names;
>
>         platform_set_drvdata(pdev, power);
>
> @@ -321,20 +375,22 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
>                 return PTR_ERR(power->supply);
>
>         /* Request irqs after registering, as irqs may trigger immediately */
> -       for (i = 0; irq_names[i]; i++) {
> -               irq = platform_get_irq_byname(pdev, irq_names[i]);
> +       for (i = 0; i < axp_data->num_irq_names; i++) {
> +               irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
>                 if (irq < 0) {
> -                       dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> -                                irq_names[i], irq);
> -                       continue;
> +                       dev_err(&pdev->dev, "No IRQ for %s: %d\n",
> +                               axp_data->irq_names[i], irq);
> +                       return irq;
>                 }
> -               irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> -               ret = devm_request_any_context_irq(&pdev->dev, irq,
> +               power->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +               ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
>                                                    axp20x_ac_power_irq, 0,
>                                                    DRVNAME, power);
> -               if (ret < 0)
> -                       dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> -                                irq_names[i], ret);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +                               axp_data->irq_names[i], ret);
> +                       return ret;
> +               }
>         }
>
>         return 0;
> @@ -357,8 +413,9 @@ MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
>  static struct platform_driver axp20x_ac_power_driver = {
>         .probe = axp20x_ac_power_probe,
>         .driver = {
> -               .name = DRVNAME,
> -               .of_match_table = axp20x_ac_power_match,
> +               .name           = DRVNAME,
> +               .of_match_table = axp20x_ac_power_match,
> +               .pm             = &axp20x_ac_power_pm_ops,
>         },
>  };
>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
