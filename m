Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C400A1A12
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2019 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfH2MbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Aug 2019 08:31:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45364 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2MbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2019 08:31:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so2680951qki.12
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2019 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uu2G2QOPOreVQBYbh48JdKdig/amaHs7QHKHg4v2pm4=;
        b=SpqfwohGI13rfR/BUQnzwhTbeVo7a+JKcvxN5XkSTTZnqh/1Fkmtxx1IUyyY1PtNR/
         1oY3oRTVkVrvN65Xhnwu70t+yyiJTOGVyzZ3wfm+xrdBm/KquWeoDqH0DHYAKTZ8HcPo
         lOOwCa9xKjiu9dt09Ry5vvaiOM35ZWFo/RZ4Sl812CyxM/0e4LlNUxMv2jBi+xlaePte
         xichSdzQJ2xx4fo7GyWInkM36Vi8Ei0b7vjBTwpPecuFglDqm/mvM5jIvZTFnql0bxQ8
         5RT6Shg9Z2OLDp1u68GOOInByJurPRyaVqakVYd4jsOCbuqI3lds2y555cduZstaEtwC
         cPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu2G2QOPOreVQBYbh48JdKdig/amaHs7QHKHg4v2pm4=;
        b=PReBzco5JVnSPLa6PGyRKijdfi3aQ/ekSbol3bXiz7IjHeB+Q01/hFeI0p6PS/c1WK
         XiNhJGkTb+hqV1alP7I5qYhYc1pcBZDrfAq9lmzj9TPn+2wHZN90IXCtsy/lNirPlDWw
         IO4KszuaG3FZMx7AekKSOOBijIKwF5qA5q4qPBqf7/sPH9m2xw9pzlCXy8F+apg9uIPW
         QkSQfAAHNPnYClIQtsqjI800/xRgX52XdTZsCiij1kSxBcG0z2J3jDKTwrrFgZbLnkyQ
         exCqnh+AiJbNas1RIzwu+Tcr5jY0x6g5GbcyyGBDJN/STbNpcJBIh5HBczI7Ss37ROZk
         ugkw==
X-Gm-Message-State: APjAAAXnbcLUYfkoiY7OdcAlq2nEfBRXwK/v7TVmokDYKmnnNUIJsIie
        bsEMqMU7MBU5GsxCH2V8tplSWUC5yoi5JvSKaKl32Q==
X-Google-Smtp-Source: APXvYqx1MrJopLWuhuq/dfvSjJl9LiyymTH7Tkvya8UHv+xTQjdq5VO/4XiFPZUVU0UWIwS9Lx2O+eyV6f/ZSjUc6Vg=
X-Received: by 2002:a37:4f41:: with SMTP id d62mr8767176qkb.302.1567081870439;
 Thu, 29 Aug 2019 05:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <a4666f8afa39471658602e06758b04a991f80828.1566907161.git.amit.kucheria@linaro.org>
 <5d66f545.1c69fb81.3663f.129d@mx.google.com>
In-Reply-To: <5d66f545.1c69fb81.3663f.129d@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 29 Aug 2019 18:00:59 +0530
Message-ID: <CAP245DVV=7wfJqQdknoovqarXnHdzZzfhPQCkKxCy+heGrz9Ag@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] drivers: thermal: tsens: Add interrupt support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brian Masney <masneyb@onstation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 29, 2019 at 3:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-08-27 05:14:11)
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 06b44cfd5eab9..c549f8e1488ba 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -114,6 +146,314 @@ static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
> >         return sign_extend32(temp, priv->tempres) * 100;
> >  }
> >
> > +/**
> > + * tsens_mC_to_hw - Return correct value to be written to threshold
> > + * registers, whether in ADC code or deciCelsius depending on IP version
>
> Document arguments and return value? Maybe summary can be 'convert
> tsens temperature to hardware register value'?

Fixed.

> > + */
> > +static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
> > +{
> > +       struct tsens_priv *priv = s->priv;
> > +
> > +       if (priv->feat->adc) {
> > +               /* milliC to C to adc code */
> > +               return degc_to_code(temp / 1000, s);
> > +       }
> > +
> > +       /* milliC to deciC */
> > +       return temp / 100;
> > +}
> > +
> > +static inline unsigned int tsens_ver(struct tsens_priv *priv)
>
> Can this return the enum instead of unsigned int?

Fixed.

> > +{
> > +       return priv->feat->ver_major;
> > +}
> > +
> > +/**
> > + * tsens_set_interrupt_v1 - Disable an interrupt (enable = false)
> > + *                          Re-enable an interrupt (enable = true)
> > + */
> > +static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
> > +                                  enum tsens_irq_type irq_type, bool enable)
> > +{
> > +       u32 index;
> > +
> > +       if (enable) {
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       index = UP_INT_CLEAR_0 + hw_id;
> > +                       break;
> > +               case LOWER:
> > +                       index = LOW_INT_CLEAR_0 + hw_id;
> > +                       break;
> > +               }
> > +               regmap_field_write(priv->rf[index], 0);
> > +       } else {
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       index = UP_INT_CLEAR_0 + hw_id;
> > +                       break;
> > +               case LOWER:
> > +                       index = LOW_INT_CLEAR_0 + hw_id;
> > +                       break;
> > +               }
> > +               regmap_field_write(priv->rf[index], 1);
> > +       }
>
> De-dup the switch statement and have
>
>         regmap_field_write(priv->rf[index], enable ? 1 : 0);

Fixed.

> > +}
> > +
> > +/**
> > + * tsens_set_interrupt_v2 - Disable an interrupt (enable = false)
> > + *                          Re-enable an interrupt (enable = true)
> > + */
> > +static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
> > +                                  enum tsens_irq_type irq_type, bool enable)
> > +{
> > +       u32 index_mask, index_clear;
> > +
> > +       if (enable) {
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       index_mask = UP_INT_MASK_0 + hw_id;
> > +                       break;
> > +               case LOWER:
> > +                       index_mask = LOW_INT_MASK_0 + hw_id;
> > +                       break;
> > +               }
> > +               regmap_field_write(priv->rf[index_mask], 0);
> > +       } else {
> > +               /* To disable the interrupt flag for a sensor:
>
> Nitpick: Wrong comment style.
>

Fixed.

> > +                *  1. Mask further interrupts for this sensor
> > +                *  2. Write 1 followed by 0 to clear the interrupt
> > +                */
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       index_mask  = UP_INT_MASK_0 + hw_id;
> > +                       index_clear = UP_INT_CLEAR_0 + hw_id;
> > +                       break;
> > +               case LOWER:
> > +                       index_mask  = LOW_INT_MASK_0 + hw_id;
> > +                       index_clear = LOW_INT_CLEAR_0 + hw_id;
> > +                       break;
> > +               }
>
> Please extract index_mask and index_clear assignments to one switch
> statement and then change the sequence to an if/else
>
>         if (enable) {
>                regmap_field_write(priv->rf[index_mask], 1);
>                regmap_field_write(priv->rf[index_clear], 1);
>                regmap_field_write(priv->rf[index_clear], 0);
>        } else {
>                regmap_field_write(priv->rf[index_mask], 0);
>        }


Fixed.

> > +}
> > +
> > +/**
> > + * tsens_set_interrupt - Disable an interrupt (enable = false)
> > + *                       Re-enable an interrupt (enable = true)
> > + */
> > +static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
> > +                               enum tsens_irq_type irq_type, bool enable)
> > +{
> > +       dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
> > +               irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
> > +               enable ? "en" : "dis");
> > +       if (tsens_ver(priv) > VER_1_X)
> > +               tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
> > +       else
> > +               tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
> > +}
> > +
> > +/**
> > + * tsens_threshold_violated - Check if a sensor temperature violated a preset threshold
> > + *
>
> Document arguments?

Fixed.

> > + * Return: 0 if threshold was not violated, 1 if it was violated and negative
> > + * errno in case of errors
> > + */
> > +static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
> > +                                   struct tsens_irq_data *d)
> > +{
> > +       int ret;
> > +
> > +       ret = regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->up_viol);
> > +       if (ret)
> > +               return ret;
> > +       ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->low_viol);
> > +       if (ret)
> > +               return ret;
> > +       if (d->up_viol || d->low_viol)
> > +               return 1;
> > +
> > +       return 0;
> > +}
> > +
> > +static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
> > +                               struct tsens_sensor *s, struct tsens_irq_data *d)
> > +{
> > +       int ret;
> > +
> > +       ret = regmap_field_read(priv->rf[UP_INT_CLEAR_0 + hw_id], &d->up_irq_clear);
> > +       if (ret)
> > +               return ret;
> > +       ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
> > +       if (ret)
> > +               return ret;
> > +       if (tsens_ver(priv) > VER_1_X) {
> > +               ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
> > +               if (ret)
> > +                       return ret;
> > +               ret = regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id], &d->low_irq_mask);
> > +               if (ret)
> > +                       return ret;
> > +       } else {
> > +               /* No mask register on older TSENS */
> > +               d->up_irq_mask = 0;
> > +               d->low_irq_mask = 0;
> > +       }
> > +
> > +       d->up_thresh = tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
> > +       d->low_thresh = tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
> > +
> > +       dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u) | clr(%u|%u) | mask(%u|%u)\n",
> > +               hw_id, __func__, (d->up_viol || d->low_viol) ? "(V)" : "",
> > +               d->low_viol, d->up_viol, d->low_irq_clear, d->up_irq_clear,
> > +               d->low_irq_mask, d->up_irq_mask);
> > +       dev_dbg(priv->dev, "[%u] %s%s: thresh: (%d:%d)\n", hw_id, __func__,
> > +               (d->up_viol || d->low_viol) ? "(violation)" : "",
> > +               d->low_thresh, d->up_thresh);
> > +
> > +       return 0;
> > +}
> > +
> > +static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
> > +{
> > +       if (ver > VER_1_X)
> > +               return mask & (1 << hw_id);
> > +
> > +       /* v1, v0.1 don't have a irq mask register */
> > +       return 0;
> > +}
> > +
> > +irqreturn_t tsens_irq_thread(int irq, void *data)
> > +{
> > +       struct tsens_priv *priv = data;
> > +       struct tsens_irq_data d;
> > +       bool enable = true, disable = false;
> > +       unsigned long flags;
> > +       int temp, ret, i;
> > +
> > +       /*
> > +        * Check if any sensor raised an IRQ - for each sensor connected to the
> > +        * TSENS block if it set the threshold violation bit.
> > +        */
> > +       for (i = 0; i < priv->num_sensors; i++) {
> > +               bool trigger = 0;
>
> How about trigger = false? It's a bool.

Fixed.

> > +               struct tsens_sensor *s = &priv->sensor[i];
> > +               u32 hw_id = s->hw_id;
> > +
> > +               if (IS_ERR(priv->sensor[i].tzd))
> > +                       continue;
> > +               if (!tsens_threshold_violated(priv, hw_id, &d))
> > +                       continue;
> > +               ret = get_temp_tsens_valid(s, &temp);
> > +               if (ret) {
> > +                       dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
>
> I hope there isn't an interrupt storm where we're trying to print out
> messages from the irq handler.
>
> > +                       continue;
> > +               }
> > +
> > +               spin_lock_irqsave(&priv->ul_lock, flags);
> > +
> > +               tsens_read_irq_state(priv, hw_id, s, &d);
> > +
> > +               if (d.up_viol &&
> > +                   !masked_irq(hw_id, d.up_irq_mask, tsens_ver(priv))) {
> > +                       tsens_set_interrupt(priv, hw_id, UPPER, disable);
> > +                       if (d.up_thresh > temp) {
> > +                               dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> > +                                       priv->sensor[i].hw_id, __func__);
> > +                               /* unmask the interrupt for this sensor */
> > +                               tsens_set_interrupt(priv, hw_id, UPPER, enable);
> > +                       } else {
> > +                               trigger = 1;
> > +                               /* Keep irq masked */
> > +                       }
> > +               } else if (d.low_viol &&
> > +                          !masked_irq(hw_id, d.low_irq_mask, tsens_ver(priv))) {
> > +                       tsens_set_interrupt(priv, hw_id, LOWER, disable);
> > +                       if (d.low_thresh < temp) {
> > +                               dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
> > +                                       priv->sensor[i].hw_id, __func__);
> > +                               /* unmask the interrupt for this sensor */
> > +                               tsens_set_interrupt(priv, hw_id, LOWER, enable);
> > +                       } else {
> > +                               trigger = 1;
> > +                               /* Keep irq masked */
> > +                       }
> > +               }
> > +
> > +               spin_unlock_irqrestore(&priv->ul_lock, flags);
> > +
> > +               if (trigger) {
> > +                       dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> > +                               hw_id, __func__, temp);
> > +                       thermal_zone_device_update(priv->sensor[i].tzd,
> > +                                                  THERMAL_EVENT_UNSPECIFIED);
> > +               } else {
> > +                       dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> > +                               hw_id, __func__, temp);
> > +               }
> > +       }
> > +
> > +       return IRQ_HANDLED;
>
> Should we return IRQ_NONE in the case that the above for loop didn't
> find anything in those if/else-ifs?

The upper/lower interrupts are non-sticky, level-triggered. So if the
temp returns to within the thresholds in the time that a IRQ was
triggered and the handler scheduled, we might not see any threshold
violations/interrupt bits set.

It feels to me that this is a case of the IRQ being handled
(automagically) instead of IRQ_NONE. The definition of IRQ_NONE[1]
also seems to suggest that it should be used when the IRQ wasn't
handled. But it was handled in this case (although, automatically),
wasn't it?

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/irqreturn.h#L7

> > +}
> > +
> > +int tsens_set_trips(void *_sensor, int low, int high)
> > +{
> > +       struct tsens_sensor *s = _sensor;
> > +       struct tsens_priv *priv = s->priv;
> > +       struct device *dev = priv->dev;
> > +       struct tsens_irq_data d;
> > +       unsigned long flags;
> > +       int high_val, low_val, cl_high, cl_low;
> > +       bool enable = true;
> > +       u32 hw_id = s->hw_id;
> > +
> > +       dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
> > +               hw_id, __func__, low, high);
> > +
> > +       cl_high = clamp_val(high, -40000, 120000);
> > +       cl_low  = clamp_val(low, -40000, 120000);
> > +
> > +       high_val = tsens_mC_to_hw(s, cl_high);
> > +       low_val  = tsens_mC_to_hw(s, cl_low);
> > +
> > +       spin_lock_irqsave(&priv->ul_lock, flags);
> > +
> > +       tsens_read_irq_state(priv, hw_id, s, &d);
> > +
> > +       /* Write the new thresholds and clear the status */
> > +       regmap_field_write(priv->rf[LOW_THRESH_0 + hw_id], low_val);
> > +       regmap_field_write(priv->rf[UP_THRESH_0 + hw_id], high_val);
> > +       tsens_set_interrupt(priv, hw_id, LOWER, enable);
> > +       tsens_set_interrupt(priv, hw_id, UPPER, enable);
>
> Just pass true? Why is there an enable local variable?

Good catch. Left over from a refactor with more convoluted logic.

> > +
> > +       spin_unlock_irqrestore(&priv->ul_lock, flags);
> > +
> > +       dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
> > +               s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
> > +
> > +       return 0;
> > +}
> > +
> [...]
> > @@ -319,28 +659,31 @@ int __init init_common(struct tsens_priv *priv)
> >                 ret = PTR_ERR(priv->rf[SENSOR_EN]);
> >                 goto err_put_device;
> >         }
> > -       /* now alloc regmap_fields in tm_map */
> > -       for (i = 0, j = LAST_TEMP_0; i < priv->feat->max_sensors; i++, j++) {
> > -               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > -                                                     priv->fields[j]);
> > -               if (IS_ERR(priv->rf[j])) {
> > -                       ret = PTR_ERR(priv->rf[j]);
> > -                       goto err_put_device;
> > -               }
> > +       priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                  priv->fields[INT_EN]);
> > +       if (IS_ERR(priv->rf[INT_EN])) {
> > +               ret = PTR_ERR(priv->rf[INT_EN]);
> > +               goto err_put_device;
> >         }
> >
> > -       /* Save away resolution of signed temperature value for this IP */
> > -       priv->tempres = priv->fields[LAST_TEMP_0].msb - priv->fields[LAST_TEMP_0].lsb;
> > -
> > -       for (i = 0, j = VALID_0; i < priv->feat->max_sensors; i++, j++) {
> > -               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > -                                                     priv->fields[j]);
> > -               if (IS_ERR(priv->rf[j])) {
> > -                       ret = PTR_ERR(priv->rf[j]);
> > -                       goto err_put_device;
> > +       /* This loop might need changes if enum regfield_ids is reordered */
> > +       for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
> > +               for (i = 0; i < priv->feat->max_sensors; i++) {
> > +                       int idx = j + i;
> > +
> > +                       priv->rf[idx] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                               priv->fields[idx]);
> > +                       if (IS_ERR(priv->rf[idx])) {
> > +                               ret = PTR_ERR(priv->rf[idx]);
> > +                               goto err_put_device;
> > +                       }
> >                 }
> >         }
> > +       /* Save away resolution of signed temperature value for this IP */
> > +       priv->tempres = priv->fields[LAST_TEMP_0].msb - priv->fields[LAST_TEMP_0].lsb;
>
> Leave this where it was, i.e. before the for loop? Or is that a bug and
> it doesn't actually work unless it's after the for loop? In which case,
> this should go to the previous patch.

I've gotten rid of this completely now.

> >
> > +       spin_lock_init(&priv->ul_lock);
> > +       tsens_enable_irq(priv);
> >         tsens_debug_init(op);
> >
> >         return 0;
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 772aa76b50e12..a4335717aeede 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -96,7 +99,33 @@ static int tsens_register(struct tsens_priv *priv)
> >                 if (priv->ops->enable)
> >                         priv->ops->enable(priv, i);
> >         }
> > +
> > +       pdev = of_find_device_by_node(priv->dev->of_node);
> > +       if (!pdev) {
> > +               dev_err(&pdev->dev, "%s: device node not found in DT\n", __func__);
>
> Do we really need this? Maybe just bail out in silence because this
> should never happen?

Fixed.

> > +               return -ENODEV;
> > +       }
> > +
> > +       irq = platform_get_irq_byname(pdev, "uplow");
> > +       if (irq < 0) {
> > +               dev_err(&pdev->dev, "%s: missing irq in dt: uplow\n", __func__);
>
> You can drop the error print. I upstreamed a change to print the error
> generically in the core.

Fixed.

> > +               return irq;
>
> Did we need to put_device() here?

Refactored to goto err_put_device


> > +       }
> > +
> > +       ret = devm_request_threaded_irq(&pdev->dev, irq,
> > +                                       NULL, tsens_irq_thread,
> > +                                       IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +                                       dev_name(&pdev->dev), priv);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
> > +               goto err_put_device;
> > +       }
> > +       enable_irq_wake(irq);
> >         return 0;
> > +
> > +err_put_device:
> > +       put_device(&pdev->dev);
> > +       return ret;
