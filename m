Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D82241B38
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgHKM5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgHKM5w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 08:57:52 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B4C06178A
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 05:57:51 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id x2so2601281vkd.8
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2020 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AL6Rc0fjEZsUIiqTKaF4QuZnNQMFT5drdpMHmwxBtLE=;
        b=dOLn0qQiuPhr7thP74vx2KSfABzfXum3+YLt83xU5hH8EgFgq8mlO4lRH+rQs7BeP/
         UT7/Agbj25A/CFn5jGgRTfO3EbgHSqajG/aiJyDwY3SkZcUkJr0ta4c+yr41x4kr87j8
         QqX/JR0QoARZOxK7a2ak1khlq7CctO0tIBoloN+YxjSZnIaRYjL3caSUn5kOs+823UTu
         s7Sug6qdrseeL9pWqMLjaP8d4m1yagaRvZnNkYQqTGwbl1b2Y6csg6CKVLUxt2j1S7YP
         x83IXmLLFXvwUe/OpYSZ5B6eENKejjpQUXBLjb2dPsSGiSlmO/kJs+Lkvt9snleE9Fpp
         KgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AL6Rc0fjEZsUIiqTKaF4QuZnNQMFT5drdpMHmwxBtLE=;
        b=ZSb+wLFhdUuzsML9Jx/4cF1sdsa1nNxZi5Wq6Z8RuqUfVM82/ngdBblxdpBnrZ03F0
         Usc8vM691Zl2rIr4T2rzYAzmkfncJmWQQ0gaN3TndWQ1dz2JqhmLmePJSVmqM6ElS1GF
         ejT5eIz7j6fnaOWvjqzb02y4SdUAwDqKs1XIoeCk2S3BWzJipAYjP3ZF9bo3PAm8OVN4
         Jm2esfwPUJIoH9EHh2PXaWbM0/58SnlfsPLdUCHbe96aLrog+SQVUm2onnJuCMnDL4xw
         rDXM21RQ20m7K6CU4GgdgsUi9tGMlQ2+vfyTWv3LSdHgkaEccwB6vEpcNyMxIdVZsNYj
         NtBg==
X-Gm-Message-State: AOAM530DtEwIr0YUyHR1lRCJqywBVgFZZnN5RuKXV7tMtxbvvyQITygp
        lcHDVMmSMHmPIQMsustDkS2i373xWAgsgZf+abxDYg==
X-Google-Smtp-Source: ABdhPJy7GhXD9WF+vFOxBmvqLYSQ9qGDvGcYcKLvAoiMERjbXwoEosLE/h7Z2U0e3Ob+MQEwh3ibR3YWWu/7+eIUqds=
X-Received: by 2002:a1f:6282:: with SMTP id w124mr24283068vkb.46.1597150670494;
 Tue, 11 Aug 2020 05:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200725181404.18951-1-ansuelsmth@gmail.com> <20200725181404.18951-2-ansuelsmth@gmail.com>
In-Reply-To: <20200725181404.18951-2-ansuelsmth@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 11 Aug 2020 18:27:39 +0530
Message-ID: <CAHLCerMc8yUjh9qwUCa=jMZHs18GC4qeS3rqT1_6K90QJd=nVA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] drivers: thermal: tsens: Add VER_0 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 25, 2020 at 11:44 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> VER_0 is used to describe device based on tsens version before v0.1.
> These device are devices based on msm8960 for example apq8064 or
> ipq806x.
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens.c | 160 +++++++++++++++++++++++++++--------
>  drivers/thermal/qcom/tsens.h |   7 +-
>  2 files changed, 132 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 9fe9a2b26705..78840c1bc5d2 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -516,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>                         dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
>                                 hw_id, __func__, temp);
>                 }
> +
> +               if (tsens_version(priv) < VER_0_1) {
> +                       /* Constraint: There is only 1 interrupt control register for all
> +                        * 11 temperature sensor. So monitoring more than 1 sensor based
> +                        * on interrupts will yield inconsistent result. To overcome this
> +                        * issue we will monitor only sensor 0 which is the master sensor.
> +                        */
> +                       break;
> +               }
>         }
>
>         return IRQ_HANDLED;
> @@ -531,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
>         int high_val, low_val, cl_high, cl_low;
>         u32 hw_id = s->hw_id;
>
> +       if (tsens_version(priv) < VER_0_1) {
> +               /* Pre v0.1 IP had a single register for each type of interrupt
> +                * and thresholds
> +                */
> +               hw_id = 0;
> +       }
> +
>         dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
>                 hw_id, __func__, low, high);
>
> @@ -550,6 +566,12 @@ static int tsens_set_trips(void *_sensor, int low, int high)
>         tsens_set_interrupt(priv, hw_id, LOWER, true);
>         tsens_set_interrupt(priv, hw_id, UPPER, true);
>
> +       /* VER_0 require to set MIN and MAX THRESH */
> +       if (tsens_version(priv) < VER_0_1) {
> +               regmap_field_write(priv->rf[MIN_THRESH_0], 0);
> +               regmap_field_write(priv->rf[MAX_THRESH_0], 120000);

Since MIN_THRESH_0 and MAX_THRESH_0 are the only two threshold on pre
0.1 IP, just (mis)use the already predefined LOW_THRESH_0 and
UP_THRESH_0 in regfield_ids in init_common() below? Then we won't need
this special casing here. All the special casing ugliness can then
stay in init_common() with comments.

> +       }
> +
>         spin_unlock_irqrestore(&priv->ul_lock, flags);
>
>         dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
> @@ -584,18 +606,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>         u32 valid;
>         int ret;
>
> -       ret = regmap_field_read(priv->rf[valid_idx], &valid);
> -       if (ret)
> -               return ret;
> -       while (!valid) {
> -               /* Valid bit is 0 for 6 AHB clock cycles.
> -                * At 19.2MHz, 1 AHB clock is ~60ns.
> -                * We should enter this loop very, very rarely.
> -                */
> -               ndelay(400);
> +       /* VER_0 doesn't have VALID bit */
> +       if (tsens_version(priv) >= VER_0_1) {

Since 8960 needs a custom get_temp function, is this change really needed?

>                 ret = regmap_field_read(priv->rf[valid_idx], &valid);
>                 if (ret)
>                         return ret;
> +               while (!valid) {
> +                       /* Valid bit is 0 for 6 AHB clock cycles.
> +                        * At 19.2MHz, 1 AHB clock is ~60ns.
> +                        * We should enter this loop very, very rarely.
> +                        */
> +                       ndelay(400);
> +                       ret = regmap_field_read(priv->rf[valid_idx], &valid);
> +                       if (ret)
> +                               return ret;
> +               }
>         }
>
>         /* Valid bit is set, OK to read the temperature */
> @@ -765,8 +790,8 @@ int __init init_common(struct tsens_priv *priv)
>
>         if (tsens_version(priv) > VER_0_1) {
>                 for (i = VER_MAJOR; i <= VER_STEP; i++) {
> -                       priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
> -                                                             priv->fields[i]);
> +                       priv->rf[i] = devm_regmap_field_alloc(
> +                               dev, priv->srot_map, priv->fields[i]);

This doesn't change any code, simply reformats the code to 80 columns.
Avoid adding such lines to other features, makes it harder to review
changes.

Please ignore the 80 column warning here and elsewhere below when it
is only going over by a few characters. Run checkpatch on your patches
which has now increased the number of columns to 100 now.


>                         if (IS_ERR(priv->rf[i]))
>                                 return PTR_ERR(priv->rf[i]);
>                 }
> @@ -775,12 +800,80 @@ int __init init_common(struct tsens_priv *priv)
>                         goto err_put_device;
>         }
>
> -       priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
> -                                                    priv->fields[TSENS_EN]);
> -       if (IS_ERR(priv->rf[TSENS_EN])) {
> -               ret = PTR_ERR(priv->rf[TSENS_EN]);
> -               goto err_put_device;
> +       if (tsens_version(priv) >= VER_0_1) {
> +               priv->rf[TSENS_EN] = devm_regmap_field_alloc(
> +                       dev, priv->srot_map, priv->fields[TSENS_EN]);
> +               if (IS_ERR(priv->rf[TSENS_EN])) {
> +                       ret = PTR_ERR(priv->rf[TSENS_EN]);
> +                       goto err_put_device;
> +               }
> +
> +               priv->rf[SENSOR_EN] = devm_regmap_field_alloc(
> +                       dev, priv->srot_map, priv->fields[SENSOR_EN]);
> +               if (IS_ERR(priv->rf[SENSOR_EN])) {
> +                       ret = PTR_ERR(priv->rf[SENSOR_EN]);
> +                       goto err_put_device;
> +               }
> +               priv->rf[INT_EN] = devm_regmap_field_alloc(
> +                       dev, priv->tm_map, priv->fields[INT_EN]);
> +               if (IS_ERR(priv->rf[INT_EN])) {
> +                       ret = PTR_ERR(priv->rf[INT_EN]);
> +                       goto err_put_device;
> +               }
> +       } else {

Let's not create two big sections with if-else for 8960 and everything
else. For example, what is wrong with using common code for TSENS_EN?

If the concern is memory wasted trying to allocate fields not present
on this older platform, perhaps consider adding a check in the loop to
break early in case of 8960?

> +               priv->rf[TSENS_EN] = devm_regmap_field_alloc(
> +                       dev, priv->tm_map, priv->fields[TSENS_EN]);
> +               if (IS_ERR(priv->rf[TSENS_EN])) {
> +                       ret = PTR_ERR(priv->rf[TSENS_EN]);
> +                       goto err_put_device;
> +               }
> +
> +               priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
> +                       dev, priv->tm_map, priv->fields[TSENS_EN]);
> +               if (IS_ERR(priv->rf[TSENS_EN])) {
> +                       ret = PTR_ERR(priv->rf[TSENS_EN]);
> +                       goto err_put_device;
> +               }
> +
> +               /* enable TSENS */
> +               regmap_field_write(priv->rf[TSENS_EN], 1);
> +
> +               priv->rf[LOW_INT_CLEAR_0] = devm_regmap_field_alloc(
> +                       dev, priv->tm_map, priv->fields[LOW_INT_CLEAR_0]);
> +               if (IS_ERR(priv->rf[LOW_INT_CLEAR_0])) {
> +                       ret = PTR_ERR(priv->rf[LOW_INT_CLEAR_0]);
> +                       goto err_put_device;
> +               }
> +
> +               priv->rf[UP_INT_CLEAR_0] = devm_regmap_field_alloc(
> +                       dev, priv->tm_map, priv->fields[UP_INT_CLEAR_0]);
> +               if (IS_ERR(priv->rf[UP_INT_CLEAR_0])) {
> +                       ret = PTR_ERR(priv->rf[UP_INT_CLEAR_0]);
> +                       goto err_put_device;
> +               }
> +
> +               priv->rf[MIN_THRESH_0] = devm_regmap_field_alloc(
> +                       dev, priv->tm_map, priv->fields[MIN_THRESH_0]);
> +               if (IS_ERR(priv->rf[MIN_THRESH_0])) {
> +                       ret = PTR_ERR(priv->rf[MIN_THRESH_0]);
> +                       goto err_put_device;
> +               }
> +
> +               priv->rf[MAX_THRESH_0] = devm_regmap_field_alloc(
> +                       dev, priv->tm_map, priv->fields[MAX_THRESH_0]);
> +               if (IS_ERR(priv->rf[MAX_THRESH_0])) {
> +                       ret = PTR_ERR(priv->rf[MAX_THRESH_0]);
> +                       goto err_put_device;
> +               }
> +
> +               priv->rf[TRDY] = devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                        priv->fields[TRDY]);
> +               if (IS_ERR(priv->rf[TRDY])) {
> +                       ret = PTR_ERR(priv->rf[TRDY]);
> +                       goto err_put_device;
> +               }
>         }
> +
>         ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>         if (ret)
>                 goto err_put_device;
> @@ -790,19 +883,6 @@ int __init init_common(struct tsens_priv *priv)
>                 goto err_put_device;
>         }
>
> -       priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
> -                                                     priv->fields[SENSOR_EN]);
> -       if (IS_ERR(priv->rf[SENSOR_EN])) {
> -               ret = PTR_ERR(priv->rf[SENSOR_EN]);
> -               goto err_put_device;
> -       }
> -       priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
> -                                                  priv->fields[INT_EN]);
> -       if (IS_ERR(priv->rf[INT_EN])) {
> -               ret = PTR_ERR(priv->rf[INT_EN]);
> -               goto err_put_device;
> -       }
> -
>         /* This loop might need changes if enum regfield_ids is reordered */
>         for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
>                 for (i = 0; i < priv->feat->max_sensors; i++) {
> @@ -856,7 +936,11 @@ int __init init_common(struct tsens_priv *priv)
>         }
>
>         spin_lock_init(&priv->ul_lock);
> -       tsens_enable_irq(priv);
> +
> +       /* VER_0 interrupt doesn't need to be enabled */
> +       if (tsens_version(priv) >= VER_0_1)
> +               tsens_enable_irq(priv);
> +
>         tsens_debug_init(op);
>
>  err_put_device:
> @@ -952,10 +1036,18 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>                 if (irq == -ENXIO)
>                         ret = 0;
>         } else {
> -               ret = devm_request_threaded_irq(&pdev->dev, irq,
> -                                               NULL, thread_fn,
> -                                               IRQF_ONESHOT,
> -                                               dev_name(&pdev->dev), priv);
> +               /* VER_0 have a different interrupt type */

Say how it is different.


> +               if (tsens_version(priv) > VER_0)
> +                       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +                                                       thread_fn, IRQF_ONESHOT,
> +                                                       dev_name(&pdev->dev),
> +                                                       priv);
> +               else
> +                       ret = devm_request_threaded_irq(&pdev->dev, irq,
> +                                                       thread_fn, NULL,
> +                                                       IRQF_TRIGGER_RISING,
> +                                                       dev_name(&pdev->dev),
> +                                                       priv);
>                 if (ret)
>                         dev_err(&pdev->dev, "%s: failed to get irq\n",
>                                 __func__);
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 59d01162c66a..f1120791737c 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -25,7 +25,8 @@ struct tsens_priv;
>
>  /* IP version numbers in ascending order */
>  enum tsens_ver {
> -       VER_0_1 = 0,
> +       VER_0 = 0,
> +       VER_0_1,
>         VER_1_X,
>         VER_2_X,
>  };
> @@ -441,6 +442,10 @@ enum regfield_ids {
>         CRIT_THRESH_14,
>         CRIT_THRESH_15,
>
> +       /* VER_0 MIN MAX THRESH */
> +       MIN_THRESH_0,
> +       MAX_THRESH_0,
> +
>         /* WATCHDOG */
>         WDOG_BARK_STATUS,
>         WDOG_BARK_CLEAR,
> --
> 2.27.0
>
