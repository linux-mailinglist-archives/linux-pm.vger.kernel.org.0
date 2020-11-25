Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9F2C494E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgKYUp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 15:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbgKYUp4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 15:45:56 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE6EC0613D4;
        Wed, 25 Nov 2020 12:45:56 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lv15so4866544ejb.12;
        Wed, 25 Nov 2020 12:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0aYRiLyBFmRyxgu5Ay1i1UapzreHrDDoNdvvukWevAE=;
        b=hlWaZ2WYGa5wwewNydjlFNb4ry0GxCfzX2QIJQtjg0oDrF85R2OgosDVPWug3glqer
         zXF4EQYRdG4fb485hnEaNaPjlWQYQ6WPG/vSlSBgq2CdZ9nAXpW3E/194B+Akz0MFK/L
         gKFLacAIspmK6MGVroPGWf5639yulRYy9nYZ8aultfJqWMtkurYSYgOkyWGycNkuRteg
         SPuLa4z1OoVRPOB52WMdaBn0TLrh7sAGXXu6PIsExtv+4dXw7wnkX/pPbLgDicTsHuJa
         eP/Daj193NtCtPON7rBsS7vIFnEV1d3MEVMFJLK0GdeDuAP7Gg52Zw3ayoOeZporkHL0
         3wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aYRiLyBFmRyxgu5Ay1i1UapzreHrDDoNdvvukWevAE=;
        b=euWDk70TgR7WTrBC1cFqHQW0s1c6a1I4pBuOV68QneovxwHlnvlbw9+O+fW7jXe6fJ
         QmyWrmHlmX++NUmG7QlzJ5RcQu14vvRV98uSLS4Dy8yUBU2v6b0cnmFBd7ucjndUSddf
         5LxLP6aYM5P9Xaq/dll0t3GiapIaNXpCgfA2Hb+mr3uvvKtM0yVumJBBzbi1ilPFq+oe
         /bVDKCdNaljMCjh5xeJh+sJLjJPSgcqOII6fz34xwnLZ6AQpKTcgLaSugYjoEpBlVKhD
         fzYBZjr9N1ygdWEixyc5i2Bw+zvbeuf6t2bDb1SKncDyQFA4dm3r9Ypk8rxxiOVb04k8
         UyfA==
X-Gm-Message-State: AOAM533QUk+LVDa9G5NShI6ELtMDNiHp5kTBcAHp3PnnUgNQ6s9bxA30
        bFHe2uU+82LVSgF5uqf4kck=
X-Google-Smtp-Source: ABdhPJxcaSF9a/6e77h6NQjmmXwaVtHoeD5NyDSMyvuiFRJigPpMlrYmzpvTFepPauNnW3IgMSL2AA==
X-Received: by 2002:a17:906:7c95:: with SMTP id w21mr4569302ejo.304.1606337155067;
        Wed, 25 Nov 2020 12:45:55 -0800 (PST)
Received: from ansuel-xps20.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.gmail.com with ESMTPSA id u9sm1856945ejt.35.2020.11.25.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:45:53 -0800 (PST)
Date:   Wed, 25 Nov 2020 13:22:28 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v6 2/8] drivers: thermal: tsens: Add VER_0 tsens
 version
Message-ID: <20201125122228.GB23592@ansuel-xps20.localdomain>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
 <20200814134123.14566-3-ansuelsmth@gmail.com>
 <CAHLCerMArOceCFQ1XFbsZCAnUdKVX3TVnAb502w+kxmO97bdJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerMArOceCFQ1XFbsZCAnUdKVX3TVnAb502w+kxmO97bdJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 23, 2020 at 01:35:22AM +0530, Amit Kucheria wrote:
> Hi Ansuel,
> 
> See comments inline.
> 
> On Fri, Aug 14, 2020 at 7:12 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >
> > VER_0 is used to describe device based on tsens version before v0.1.
> > These device are devices based on msm8960 for example apq8064 or
> > ipq806x.
> >
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/thermal/qcom/tsens.c | 122 +++++++++++++++++++++++++++++++----
> >  drivers/thermal/qcom/tsens.h |   7 +-
> >  2 files changed, 114 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 9fe9a2b26705..965c4799918a 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -516,6 +516,15 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
> >                         dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> >                                 hw_id, __func__, temp);
> >                 }
> > +
> > +               if (tsens_version(priv) < VER_0_1) {
> > +                       /* Constraint: There is only 1 interrupt control register for all
> > +                        * 11 temperature sensor. So monitoring more than 1 sensor based
> > +                        * on interrupts will yield inconsistent result. To overcome this
> > +                        * issue we will monitor only sensor 0 which is the master sensor.
> > +                        */
> > +                       break;
> > +               }
> >         }
> >
> >         return IRQ_HANDLED;
> > @@ -531,6 +540,13 @@ static int tsens_set_trips(void *_sensor, int low, int high)
> >         int high_val, low_val, cl_high, cl_low;
> >         u32 hw_id = s->hw_id;
> >
> > +       if (tsens_version(priv) < VER_0_1) {
> > +               /* Pre v0.1 IP had a single register for each type of interrupt
> > +                * and thresholds
> > +                */
> > +               hw_id = 0;
> > +       }
> > +
> >         dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
> >                 hw_id, __func__, low, high);
> >
> > @@ -584,18 +600,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
> >         u32 valid;
> >         int ret;
> >
> > -       ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > -       if (ret)
> > -               return ret;
> > -       while (!valid) {
> > -               /* Valid bit is 0 for 6 AHB clock cycles.
> > -                * At 19.2MHz, 1 AHB clock is ~60ns.
> > -                * We should enter this loop very, very rarely.
> > -                */
> > -               ndelay(400);
> > +       /* VER_0 doesn't have VALID bit */
> > +       if (tsens_version(priv) >= VER_0_1) {
> >                 ret = regmap_field_read(priv->rf[valid_idx], &valid);
> >                 if (ret)
> >                         return ret;
> > +               while (!valid) {
> > +                       /* Valid bit is 0 for 6 AHB clock cycles.
> > +                        * At 19.2MHz, 1 AHB clock is ~60ns.
> > +                        * We should enter this loop very, very rarely.
> > +                        */
> > +                       ndelay(400);
> > +                       ret = regmap_field_read(priv->rf[valid_idx], &valid);
> > +                       if (ret)
> > +                               return ret;
> > +               }
> 
> Let's revisit this after fixing patch 1.
> 
> 
> >         }
> >
> >         /* Valid bit is set, OK to read the temperature */
> > @@ -763,6 +782,10 @@ int __init init_common(struct tsens_priv *priv)
> >                 goto err_put_device;
> >         }
> >
> > +       /* VER_0 have only tm_map */
> > +       if (!priv->srot_map)
> > +               priv->srot_map = priv->tm_map;
> > +
> >         if (tsens_version(priv) > VER_0_1) {
> >                 for (i = VER_MAJOR; i <= VER_STEP; i++) {
> >                         priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
> > @@ -781,6 +804,10 @@ int __init init_common(struct tsens_priv *priv)
> >                 ret = PTR_ERR(priv->rf[TSENS_EN]);
> >                 goto err_put_device;
> >         }
> > +       /* in VER_0 TSENS need to be explicitly enabled */
> > +       if (tsens_version(priv) == VER_0)
> > +               regmap_field_write(priv->rf[TSENS_EN], 1);
> > +
> >         ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
> >         if (ret)
> >                 goto err_put_device;
> > @@ -803,6 +830,61 @@ int __init init_common(struct tsens_priv *priv)
> >                 goto err_put_device;
> >         }
> >
> > +       priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                    priv->fields[TSENS_EN]);
> > +       if (IS_ERR(priv->rf[TSENS_EN])) {
> > +               ret = PTR_ERR(priv->rf[TSENS_EN]);
> > +               goto err_put_device;
> > +       }
> > +
> > +       priv->rf[TSENS_SW_RST] = devm_regmap_field_alloc(
> > +               dev, priv->tm_map, priv->fields[TSENS_EN]);
> > +       if (IS_ERR(priv->rf[TSENS_EN])) {
> > +               ret = PTR_ERR(priv->rf[TSENS_EN]);
> > +               goto err_put_device;
> > +       }
> > +
> > +       priv->rf[LOW_INT_CLEAR_0] = devm_regmap_field_alloc(
> > +               dev, priv->tm_map, priv->fields[LOW_INT_CLEAR_0]);
> > +       if (IS_ERR(priv->rf[LOW_INT_CLEAR_0])) {
> > +               ret = PTR_ERR(priv->rf[LOW_INT_CLEAR_0]);
> > +               goto err_put_device;
> > +       }
> > +
> > +       priv->rf[UP_INT_CLEAR_0] = devm_regmap_field_alloc(
> > +               dev, priv->tm_map, priv->fields[UP_INT_CLEAR_0]);
> > +       if (IS_ERR(priv->rf[UP_INT_CLEAR_0])) {
> > +               ret = PTR_ERR(priv->rf[UP_INT_CLEAR_0]);
> > +               goto err_put_device;
> > +       }
> > +
> > +       /* VER_0 require to set MIN and MAX THRESH */
> > +       if (tsens_version(priv) < VER_0_1) {
> > +               priv->rf[MIN_THRESH_0] = devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, priv->fields[MIN_THRESH_0]);
> > +               if (IS_ERR(priv->rf[MIN_THRESH_0])) {
> > +                       ret = PTR_ERR(priv->rf[MIN_THRESH_0]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               priv->rf[MAX_THRESH_0] = devm_regmap_field_alloc(
> > +                       dev, priv->tm_map, priv->fields[MAX_THRESH_0]);
> > +               if (IS_ERR(priv->rf[MAX_THRESH_0])) {
> > +                       ret = PTR_ERR(priv->rf[MAX_THRESH_0]);
> > +                       goto err_put_device;
> > +               }
> > +
> > +               regmap_field_write(priv->rf[MIN_THRESH_0], 0);
> > +               regmap_field_write(priv->rf[MAX_THRESH_0], 120000);
> > +       }
> > +
> > +       priv->rf[TRDY] =
> > +               devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
> > +       if (IS_ERR(priv->rf[TRDY])) {
> > +               ret = PTR_ERR(priv->rf[TRDY]);
> > +               goto err_put_device;
> > +       }
> > +
> >         /* This loop might need changes if enum regfield_ids is reordered */
> >         for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
> >                 for (i = 0; i < priv->feat->max_sensors; i++) {
> > @@ -856,7 +938,11 @@ int __init init_common(struct tsens_priv *priv)
> >         }
> >
> >         spin_lock_init(&priv->ul_lock);
> > -       tsens_enable_irq(priv);
> > +
> > +       /* VER_0 interrupt doesn't need to be enabled */
> > +       if (tsens_version(priv) >= VER_0_1)
> > +               tsens_enable_irq(priv);
> > +
> >         tsens_debug_init(op);
> >
> >  err_put_device:
> > @@ -952,10 +1038,18 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
> >                 if (irq == -ENXIO)
> >                         ret = 0;
> >         } else {
> > -               ret = devm_request_threaded_irq(&pdev->dev, irq,
> > -                                               NULL, thread_fn,
> > -                                               IRQF_ONESHOT,
> > -                                               dev_name(&pdev->dev), priv);
> > +               /* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
> > +               if (tsens_version(priv) > VER_0)
> > +                       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +                                                       thread_fn, IRQF_ONESHOT,
> > +                                                       dev_name(&pdev->dev),
> > +                                                       priv);
> > +               else
> > +                       ret = devm_request_threaded_irq(&pdev->dev, irq,
> > +                                                       thread_fn, NULL,
> > +                                                       IRQF_TRIGGER_RISING,
> > +                                                       dev_name(&pdev->dev),
> > +                                                       priv);
> 
> 
> Just set a flag variable to ONESHOT OR TRIGGER_RISING and use that in the call.
> 
> >                 if (ret)
> >                         dev_err(&pdev->dev, "%s: failed to get irq\n",
> >                                 __func__);
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> > index 59d01162c66a..f1120791737c 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -25,7 +25,8 @@ struct tsens_priv;
> >
> >  /* IP version numbers in ascending order */
> >  enum tsens_ver {
> > -       VER_0_1 = 0,
> > +       VER_0 = 0,
> > +       VER_0_1,
> >         VER_1_X,
> >         VER_2_X,
> >  };
> > @@ -441,6 +442,10 @@ enum regfield_ids {
> >         CRIT_THRESH_14,
> >         CRIT_THRESH_15,
> >
> > +       /* VER_0 MIN MAX THRESH */
> > +       MIN_THRESH_0,
> > +       MAX_THRESH_0,
> > +
> 
> Consider reusing LOW_THRESH_0 and UP_THRESH_0 for these?
>

As we already have defined LOW_THRESH and UP how can we reuse that
regfield to define MIN and MAX? 

> >         /* WATCHDOG */
> >         WDOG_BARK_STATUS,
> >         WDOG_BARK_CLEAR,
> > --
> > 2.27.0
> >
