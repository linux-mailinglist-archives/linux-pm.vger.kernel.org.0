Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9410CECE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK1TTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 14:19:13 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43020 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfK1TTL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 14:19:11 -0500
Received: by mail-vk1-f193.google.com with SMTP id k19so6643083vke.10
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 11:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cohhF1NGkG9wv8KaQQ+xdNEYPWRsIUKdm2ue5iTbmiM=;
        b=oK8tIb+uLUO2qX0hYciICXuvv6wMjGagZAoTFfYbRaXRP9zlHg+O2RF6KdDI8I9pxt
         HIn1aREPGUBckjK9jjUZ4fgV/sMMLaYBpqjRayTjPEthUiRGBATLB1qG2DP8bYDlJcFO
         4KBd3eeIx8RyU+a8r4wS3+IV+IWv3XueP3tFRqhpp+wh9eYbq/AW5aa6nDC8BUdfU9LQ
         fh8Ude7KCXeGOysmhP0htm+8EBl0Fhk9s28jgkTmRzL/whm2GCZdtkivWBl1bbBSt6BW
         Nb34aL0GYPHub+Kr677NLhWIMd3tD9g2zQd6iv1jmkloCUFLz/inU9KAXS3YjjOCEJo3
         gRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cohhF1NGkG9wv8KaQQ+xdNEYPWRsIUKdm2ue5iTbmiM=;
        b=ByNOya/hJNzfhuxz4QQbcHUidTaBfxHpgzcR+sHieJmnfo2NyXpkEWo0jmKLsSsN8r
         JgydR/x8rEtGTPhPpK52wIUMyRcztNxZx+EliOrwR9AIDfiCQuOoLvKB/r4K2yEHiflw
         M/OVHVqTswqMYFxYR+KB6KKgIQywC982G/mIYU8U6irh0eOLma6DGlxeVjvXlOiHlMaQ
         BLUtjZ7BuEC4kdeBU+4DO+WKlTo4Cp++MELxnU9loCkVEBpMelHVitLyqdv0jRKIAJHr
         ibWuBM/GaYOWZPU4funPQ3eimeYspOoz45YHOTV7qJuc/lYaXhpUfStbrvjy0zWxOi4W
         A3Xw==
X-Gm-Message-State: APjAAAXIFH09FPzLjF0K+M7n7tIrCnO8X5DEuAWg59mqQWLG6/bEnIot
        5D8enqMpomfjkbHFM9eM3+Sbzc6Z3I84v66vTN5bng==
X-Google-Smtp-Source: APXvYqztvoQz7r5LCaOjyU7Z4nZCZOfzB76ES9oL6R3zQ1poLJ083TCQY3ueU5VXnq1YC+p+cQPvg+PhY3a0VcwKUyg=
X-Received: by 2002:a1f:bdd0:: with SMTP id n199mr1849831vkf.86.1574968748546;
 Thu, 28 Nov 2019 11:19:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <c08cf285b8696c4fd00706b85cd3c88d12f97df3.1573499020.git.amit.kucheria@linaro.org>
 <20191112192244.GB3140946@builder>
In-Reply-To: <20191112192244.GB3140946@builder>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 29 Nov 2019 00:48:57 +0530
Message-ID: <CAHLCerPojTpUV0TiJfis7skghuRzbkC+RB7kwDhi35c5-f=VgA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers: thermal: tsens: Add watchdog support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 13, 2019 at 12:52 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 11 Nov 11:21 PST 2019, Amit Kucheria wrote:
>
> > TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
> > HW FSM is frozen. Add support to detect and restart the FSM in the
> > driver. The watchdog is configured by the bootloader, we just enable the
> > feature in the kernel.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 41 +++++++++++++++++++++++++++++
> >  drivers/thermal/qcom/tsens-v2.c     | 10 +++++++
> >  drivers/thermal/qcom/tsens.h        | 12 +++++++++
> >  3 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 2989cb952cdb..9432518502a7 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -378,6 +378,28 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> >       bool enable = true, disable = false;
> >       unsigned long flags;
> >       int temp, ret, i;
> > +     u32 wdog_status, wdog_count, ver_minor;
> > +
> > +     ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
>
> The version is unlikely to change from one interrupt to the next, so I
> suggest that you add a boolean "has_watchdog" to your context that you
> populate in init_common.

Fair enough, will de-const tsense_features pointer and add a flag
there. It has been overdue, now that we're starting to look at
features that were introduced midway through an IP version cycle. That
is where this should reside instead of tsens_priv.

> > +     if (ret)
> > +             return ret;
> > +
> > +     if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> > +             /* Watchdog is present only on v2.3+ */
> > +             ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS], &wdog_status);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* Clear WDOG interrupt */
> > +             regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
> > +             regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
> > +
> > +             ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT], &wdog_count);
> > +             if (ret)
> > +                     return ret;
> > +             if (wdog_count)
> > +                     dev_err(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);
>
> What's the benefit of reading wdog_count and who's the audience for this
> print? What do I do when this goes to 11?

Should be a debug statement. Will convert to dev_dbg.


> Regards,
> Bjorn
>
> > +     }
> >
> >       for (i = 0; i < priv->num_sensors; i++) {
> >               struct tsens_sensor *s = &priv->sensor[i];
> > @@ -685,6 +707,7 @@ int __init init_common(struct tsens_priv *priv)
> >  {
> >       void __iomem *tm_base, *srot_base;
> >       struct device *dev = priv->dev;
> > +     u32 ver_minor;
> >       struct resource *res;
> >       u32 enabled;
> >       int ret, i, j;
> > @@ -734,6 +757,9 @@ int __init init_common(struct tsens_priv *priv)
> >                       if (IS_ERR(priv->rf[i]))
> >                               return PTR_ERR(priv->rf[i]);
> >               }
> > +             ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
> > +             if (ret)
> > +                     goto err_put_device;
> >       }
> >
> >       priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
> > @@ -794,6 +820,21 @@ int __init init_common(struct tsens_priv *priv)
> >               }
> >       }
> >
> > +     if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> > +             /* Watchdog is present only on v2.3+ */
> > +             for (i = 0, j = WDOG_BARK_STATUS; j <= CC_MON_MASK; i++, j++) {
> > +                     priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                           priv->fields[j]);
> > +                     if (IS_ERR(priv->rf[j])) {
> > +                             ret = PTR_ERR(priv->rf[j]);
> > +                             goto err_put_device;
> > +                     }
> > +             }
> > +             /* Enable WDOG and disable cycle completion monitoring */
> > +             regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> > +             regmap_field_write(priv->rf[CC_MON_MASK], 1);
> > +     }
> > +
> >       spin_lock_init(&priv->ul_lock);
> >       tsens_enable_irq(priv);
> >       tsens_debug_init(op);
> > diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> > index 47d831df0803..4184850d1e42 100644
> > --- a/drivers/thermal/qcom/tsens-v2.c
> > +++ b/drivers/thermal/qcom/tsens-v2.c
> > @@ -24,6 +24,7 @@
> >  #define TM_Sn_CRITICAL_THRESHOLD_OFF 0x0060
> >  #define TM_Sn_STATUS_OFF             0x00a0
> >  #define TM_TRDY_OFF                  0x00e4
> > +#define TM_WDOG_LOG_OFF              0x013c
> >
> >  /* v2.x: 8996, 8998, sdm845 */
> >
> > @@ -66,6 +67,15 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
> >       REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_CLEAR,  TM_CRITICAL_INT_CLEAR_OFF),
> >       REG_FIELD_SPLIT_BITS_0_15(CRIT_INT_MASK,   TM_CRITICAL_INT_MASK_OFF),
> >
> > +     /* WATCHDOG on v2.3 or later */
> > +     [WDOG_BARK_STATUS] = REG_FIELD(TM_CRITICAL_INT_STATUS_OFF, 31, 31),
> > +     [WDOG_BARK_CLEAR]  = REG_FIELD(TM_CRITICAL_INT_CLEAR_OFF,  31, 31),
> > +     [WDOG_BARK_MASK]   = REG_FIELD(TM_CRITICAL_INT_MASK_OFF,   31, 31),
> > +     [CC_MON_STATUS]    = REG_FIELD(TM_CRITICAL_INT_STATUS_OFF, 30, 30),
> > +     [CC_MON_CLEAR]     = REG_FIELD(TM_CRITICAL_INT_CLEAR_OFF,  30, 30),
> > +     [CC_MON_MASK]      = REG_FIELD(TM_CRITICAL_INT_MASK_OFF,   30, 30),
> > +     [WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  7),
> > +
> >       /* Sn_STATUS */
> >       REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
> >       REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> > index 9b5a30533c52..7608e7877a7b 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -440,6 +440,18 @@ enum regfield_ids {
> >       CRIT_THRESH_13,
> >       CRIT_THRESH_14,
> >       CRIT_THRESH_15,
> > +
> > +     /* WATCHDOG */
> > +     WDOG_BARK_STATUS,
> > +     WDOG_BARK_CLEAR,
> > +     WDOG_BARK_MASK,
> > +     WDOG_BARK_COUNT,
> > +
> > +     /* CYCLE COMPLETION MONITOR */
> > +     CC_MON_STATUS,
> > +     CC_MON_CLEAR,
> > +     CC_MON_MASK,
> > +
> >       MIN_STATUS_0,           /* MIN threshold violated */
> >       MIN_STATUS_1,
> >       MIN_STATUS_2,
> > --
> > 2.17.1
> >
