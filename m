Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6088210796E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 21:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVUZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 15:25:40 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44806 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUZk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 15:25:40 -0500
Received: by mail-il1-f193.google.com with SMTP id i6so8114097ilr.11
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 12:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWQ8wjbjNIRDx+10lXE+eAGZSt9rjWCVGqjE4846t+c=;
        b=fBntcHy+ds1KkmaNZ3d0AfbizApH8XNgbLldTI/zj02skNBQOB5xHNdFvMf8WtZrrb
         AifreqURxyFuWKI/WevhdX4HCuRay37IatPs1nvoqoj6LL7W4CFoZs+uWF4zq2VwXt8o
         wu4VfFHPZLPhvZiRbShMYcoYmrmz33oRp6WFzQvPrq2EoHIWk3XNh4PiNAaoqJPRHdd8
         sRrZsdGmYqTaBe8YZuSOlxpU76hqyavUf4X6RCDJWDzu0UcR3lQZlNO1aGpnuwxsNvsT
         e6xaH1hOm4FFscgKCCvxhwVndJSTFKCbvWHBfNGZs+URnM79R/zhkwq336kyP3SMsHls
         vpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWQ8wjbjNIRDx+10lXE+eAGZSt9rjWCVGqjE4846t+c=;
        b=knKgf3wFBLk6+IuLBLorvW/QDICyMXbEsTUILsEskKTzEHylNeUyWmGdJ6Bg538BKL
         g5OBFECxMXdwisZmlRt1fYlfvEoYaS/+3qidcFdDxkMPAqeQ5iQ5d92Bu80ri+pLEGii
         oJPb6rm6GqY7v5SEJaJDnlL8bHQzBI8Kywmo9Z6WHEZV820Ggpik9Bbb/T716I5jc7/f
         W9brTjbmQHpIt5Ev+LxlyDntwOI4cWFWxSJm5N48Vox55vZSXYAV1mu9IaxK+7Yonnps
         4dRC2k0d+8TXMsLRpekiP2cXnDyJTC3n9T8dUtKsSNdD9sB1qSVr/QDEJ5PRspMytfo5
         OlCg==
X-Gm-Message-State: APjAAAV1kn3b6/+jo0sxDpbCfb/L4J6KVK91BsZnkOLydXIcrqxBmAYt
        9DnIY0f2pc7wt3DehHIwZd1tzLGLiDenU46vgCI=
X-Google-Smtp-Source: APXvYqxJKd+jqsYHv5dSSsJ7kJuWTnMAeYWYZbWSBlm2zNOzue05tV74NR/FvgZR0PO09IUA8ACxAfe6mAdi+yurKn0=
X-Received: by 2002:a92:afd5:: with SMTP id v82mr19670219ill.294.1574454339009;
 Fri, 22 Nov 2019 12:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20191119170004.24533-1-l.stach@pengutronix.de>
In-Reply-To: <20191119170004.24533-1-l.stach@pengutronix.de>
From:   Chris Healy <cphealy@gmail.com>
Date:   Fri, 22 Nov 2019 12:25:28 -0800
Message-ID: <CAFXsbZp3WvMYiF71bsmsN50V=4DHQOYeiXmbJbxYfS+MWhDT5Q@mail.gmail.com>
Subject: Re: [PATCH] power: suppy: ucs1002: disable power when max current is 0
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tested-by: Chris Healy <cphealy@gmail.com>

On Tue, Nov 19, 2019 at 9:00 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> For some devices userspace needs the ability to completely cut the power
> to the USB devices connected to the charge controller. An easy way to
> achieve this is by allowing 0 as a valid max current and forcibly disable
> the output in that case, as well as enable it again if the regulator is
> in use and a non-0 max current is set.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/power/supply/ucs1002_power.c | 42 +++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
> index 1b80ae479e7d..0ca80d00b80a 100644
> --- a/drivers/power/supply/ucs1002_power.c
> +++ b/drivers/power/supply/ucs1002_power.c
> @@ -100,7 +100,9 @@ struct ucs1002_info {
>         struct i2c_client *client;
>         struct regmap *regmap;
>         struct regulator_desc *regulator_descriptor;
> +       struct regulator_dev *rdev;
>         bool present;
> +       bool output_disable;
>  };
>
>  static enum power_supply_property ucs1002_props[] = {
> @@ -233,6 +235,11 @@ static int ucs1002_get_max_current(struct ucs1002_info *info,
>         unsigned int reg;
>         int ret;
>
> +       if (info->output_disable) {
> +               val->intval = 0;
> +               return 0;
> +       }
> +
>         ret = regmap_read(info->regmap, UCS1002_REG_ILIMIT, &reg);
>         if (ret)
>                 return ret;
> @@ -247,6 +254,12 @@ static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
>         unsigned int reg;
>         int ret, idx;
>
> +       if (val == 0) {
> +               info->output_disable = true;
> +               regulator_disable_regmap(info->rdev);
> +               return 0;
> +       }
> +
>         for (idx = 0; idx < ARRAY_SIZE(ucs1002_current_limit_uA); idx++) {
>                 if (val == ucs1002_current_limit_uA[idx])
>                         break;
> @@ -270,6 +283,12 @@ static int ucs1002_set_max_current(struct ucs1002_info *info, u32 val)
>         if (reg != idx)
>                 return -EINVAL;
>
> +       info->output_disable = false;
> +
> +       if (info->rdev && info->rdev->use_count &&
> +           !regulator_is_enabled_regmap(info->rdev))
> +               regulator_enable_regmap(info->rdev);
> +
>         return 0;
>  }
>
> @@ -470,9 +489,24 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *data)
>         return IRQ_HANDLED;
>  }
>
> +int ucs1002_regulator_enable(struct regulator_dev *rdev)
> +{
> +       struct ucs1002_info *info = rdev_get_drvdata(rdev);
> +
> +       /*
> +        * If the output is disabled due to 0 maximum current, just pretend the
> +        * enable did work. The regulator will be enabled as soon as we get a
> +        * a non-zero maximum current budget.
> +        */
> +       if (info->output_disable)
> +               return 0;
> +
> +       return regulator_enable_regmap(rdev);
> +}
> +
>  static const struct regulator_ops ucs1002_regulator_ops = {
>         .is_enabled     = regulator_is_enabled_regmap,
> -       .enable         = regulator_enable_regmap,
> +       .enable         = ucs1002_regulator_enable,
>         .disable        = regulator_disable_regmap,
>  };
>
> @@ -499,7 +533,6 @@ static int ucs1002_probe(struct i2c_client *client,
>         };
>         struct regulator_config regulator_config = {};
>         int irq_a_det, irq_alert, ret;
> -       struct regulator_dev *rdev;
>         struct ucs1002_info *info;
>         unsigned int regval;
>
> @@ -589,10 +622,11 @@ static int ucs1002_probe(struct i2c_client *client,
>         regulator_config.dev = dev;
>         regulator_config.of_node = dev->of_node;
>         regulator_config.regmap = info->regmap;
> +       regulator_config.driver_data = info;
>
> -       rdev = devm_regulator_register(dev, info->regulator_descriptor,
> +       info->rdev = devm_regulator_register(dev, info->regulator_descriptor,
>                                        &regulator_config);
> -       ret = PTR_ERR_OR_ZERO(rdev);
> +       ret = PTR_ERR_OR_ZERO(info->rdev);
>         if (ret) {
>                 dev_err(dev, "Failed to register VBUS regulator: %d\n", ret);
>                 return ret;
> --
> 2.20.1
>
