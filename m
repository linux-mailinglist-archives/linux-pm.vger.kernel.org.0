Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141D39954F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbfHVNkj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 09:40:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45293 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbfHVNkj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 09:40:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so5101225qki.12
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7OCvWWarIaOda8gSWoZ9wMY3YZ9zx8R1m3Ht/i//yQ=;
        b=MwGbGS3zXGHAwRCugMcUR5Nx5IkOuv07tZQmsbbWA2CHQKJ3kVEIfSq6cTtZ3CU0jp
         tnKsLeN0Tvc9169Q93NMrc/RZXhs8jMERG23vUEeql9ErzP/HLnREUTi6XzjyGEmJsgq
         zVDZybCP3XHIMIXy7KYWvq94pzu73gJBw12TPfelXXc6e9VtqH3tiYQuqLvPSbWN0TQ4
         vv/FI2BjHVvX1Q61i5Oy60SnlEa3fly0fhLZcF50eltoB9UMiAwkT6lk4SGtc3k8ibt4
         sqsIXgZGuWrjCE2EeN8a6APf6TxHZnnONkfPFBJaEbSOuAJlC99TBjd6PE2f0qx0yL1K
         Vkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7OCvWWarIaOda8gSWoZ9wMY3YZ9zx8R1m3Ht/i//yQ=;
        b=LskamRweipoeiyvBeK8PsYkMom+EtBARUK2oq6V+PDqyMtvSK/XV5ag8dxCdrqQcqA
         DanUS7Y3Dp64xSvY0UFhVjQPLyiyBHnPrmhOZT+af7ZJm0rCBpu2TH47DiuXL+cjyHXq
         vWhl8cEFJlCuxO5UxTxXDttupZUCohcn1ocEtPvkDWWZ6n//vSnxeHWq58IcbyDaSGIH
         6nZCJ0DuxWe8d6sW+gU1VRp0lfUfweVuCvkj7Ci8+XKwSCix0CUKKtJKgWgu89Lnm6Pf
         X8rUEgedRv+HjCn1NjKdDkcreAqj3RUYlSIKyCVbRgOUKxY4VpJpOCKnbClasmVYlruA
         BUVw==
X-Gm-Message-State: APjAAAWGvWzw/8gxSWKf699P4t7JospiQGC7H64YsLl46jl0LhE9CSZh
        orUuReRhCZXpzOhtQvLKlJjg0f1lpk0HE6vpdiF6Og==
X-Google-Smtp-Source: APXvYqwYKgf5Jf/0/syBaWyMlljkIRp5mZxSsc5nsXqwFpsKEc09zkvSO6/2ZLAH1cD7KrLKfVtW2Ahe4uzi0cfycs4=
X-Received: by 2002:a05:620a:5f7:: with SMTP id z23mr35962471qkg.106.1566481237497;
 Thu, 22 Aug 2019 06:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
 <3105ffc275c6e1106a17b8b9ad83a8f1816445eb.1564091601.git.amit.kucheria@linaro.org>
 <20190817060916.3439321019@mail.kernel.org>
In-Reply-To: <20190817060916.3439321019@mail.kernel.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 22 Aug 2019 19:10:26 +0530
Message-ID: <CAP245DWNaKYz9L8aXb6ktToQ6v7ffeSi9YRWT+B2-z==eFnAPQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] drivers: thermal: tsens: Add interrupt support
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

Thanks for the thorough review.

On Sat, Aug 17, 2019 at 11:39 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Amit Kucheria (2019-07-25 15:18:50)
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 13a875b99094..f94ef79c37bc 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -13,6 +13,22 @@
> >  #include <linux/regmap.h>
> >  #include "tsens.h"
> >
> > +/* IRQ state, mask and clear */
> > +struct tsens_irq_data {
> > +       u32 up_viol;
>
> Is viol a violation? Maybe some kernel doc would be useful here.

Will fix.

> > +       int up_thresh;
> > +       u32 up_irq_mask;
> > +       u32 up_irq_clear;
> > +       u32 low_viol;
> > +       int low_thresh;
> > +       u32 low_irq_mask;
> > +       u32 low_irq_clear;
> > +       u32 crit_viol;
> > +       u32 crit_thresh;
> > +       u32 crit_irq_mask;
> > +       u32 crit_irq_clear;
> > +};
> > +
> >  char *qfprom_read(struct device *dev, const char *cname)
> >  {
> >         struct nvmem_cell *cell;
> > @@ -65,6 +81,18 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
> >         }
> >  }
> >
> > +static inline u32 degc_to_code(int degc, const struct tsens_sensor *sensor)
> > +{
> > +       u32 code = (degc * sensor->slope + sensor->offset) / SLOPE_FACTOR;
>
> This can't overflow 32-bits with the multiply and add?

Most of the public HW doesn't have any calibration data and the
defaults values seem to avoid the problem. I'll check again.

Perhaps best to just declare this as u64 and then clamp below?

> > +
> > +       if (code > THRESHOLD_MAX_ADC_CODE)
> > +               code = THRESHOLD_MAX_ADC_CODE;
> > +       else if (code < THRESHOLD_MIN_ADC_CODE)
> > +               code = THRESHOLD_MIN_ADC_CODE;
>
> Looks like
>
>         return clamp(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);

clamp_val works better with the #defines, but yes. Will fix.

> > +       pr_debug("%s: raw_code: 0x%x, degc:%d\n", __func__, code, degc);
> > +       return code;
> > +}
> > +
> >  static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
> >  {
> >         int degc, num, den;
> > @@ -106,6 +134,363 @@ static int tsens_hw_to_mC(char *str, struct tsens_sensor *s, int field, int temp
> >         }
> >  }
> >
> > +/**
> > + * tsens_mC_to_hw - Return correct value to be written to threshold
> > + * registers, whether in ADC code or deciCelsius depending on IP version
> > + */
> > +static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
> > +{
> > +       struct tsens_priv *priv = s->priv;
> > +
> > +       if (priv->feat->adc) {
> > +               /* milli to C to adc code */
> > +               return degc_to_code(temp / 1000, s);
> > +       } else {
> > +               /* milli to deci C */
> > +               return (temp / 100);
> > +       }
>
> Drop the else and just return without parenthesis.

Will fix.

> > +}
> > +
> > +static inline unsigned int tsens_ver(struct tsens_priv *priv)
> > +{
> > +       return priv->feat->ver_major;
> > +}
> > +
> > +static inline u32 irq_mask(u32 hw_id)
>
> Is this used?

Removed.

> > +{
> > +       return 1 << hw_id;
> > +}
> > +
> > +/**
> > + * tsens_set_interrupt_v1 - Disable an interrupt (enable = false)
> > + *                          Re-enable an interrupt (enable = true)
> > + */
> > +static void tsens_set_interrupt_v1(struct tsens_priv *priv, const struct tsens_irq_data d,
> > +                                  u32 hw_id, enum tsens_irq_type irq_type, bool enable)
> > +{
> > +       if (enable) {
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 0);
> > +                       break;
> > +               case LOWER:
> > +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 0);
> > +                       break;
> > +               default:
> > +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
> > +                       break;
> > +               }
> > +       } else {
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 1);
> > +                       break;
> > +               case LOWER:
> > +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 1);
> > +                       break;
> > +               default:
> > +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
> > +                       break;
> > +               }
> > +       }
> > +}
> > +
> > +/**
> > + * tsens_set_interrupt_v2 - Disable an interrupt (enable = false)
> > + *                          Re-enable an interrupt (enable = true)
> > + */
> > +static void tsens_set_interrupt_v2(struct tsens_priv *priv, const struct tsens_irq_data d,
> > +                                  u32 hw_id, enum tsens_irq_type irq_type, bool enable)
> > +{
> > +       if (enable) {
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       regmap_field_write(priv->rf[UP_INT_MASK_0 + hw_id], 0);
>
> Maybe just have a variable like mask_reg that is equal to UP_INT_MASK,
> etc? And then one regmap_field_write() call outside the switch that does
> the write to 0?

Agreed. Makes the code nicer.

> > +                       break;
> > +               case LOWER:
> > +                       regmap_field_write(priv->rf[LOW_INT_MASK_0 + hw_id], 0);
> > +                       break;
> > +               case CRITICAL:
> > +                       regmap_field_write(priv->rf[CRIT_INT_MASK_0 + hw_id], 0);
> > +                       break;
> > +               default:
> > +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
> > +                       break;
> > +               }
> > +       } else {
> > +               /* To disable the interrupt flag for a sensor:
> > +                *  1. Mask further interrupts for this sensor
> > +                *  2. Write 1 followed by 0 to clear the interrupt
> > +                */
> > +               switch (irq_type) {
> > +               case UPPER:
> > +                       regmap_field_write(priv->rf[UP_INT_MASK_0 + hw_id], 1);
> > +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 1);
> > +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_id], 0);
>
> Same comment here. Use a local variable for mask and clear and then
> write the register with three regmap_field_write() calls?

Will fix.

> > +                       break;
> > +               case LOWER:
> > +                       regmap_field_write(priv->rf[LOW_INT_MASK_0 + hw_id], 1);
> > +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 1);
> > +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_id], 0);
> > +                       break;
> > +               case CRITICAL:
> > +                       regmap_field_write(priv->rf[CRIT_INT_MASK_0 + hw_id], 1);
> > +                       regmap_field_write(priv->rf[CRIT_INT_CLEAR_0 + hw_id], 1);
> > +                       regmap_field_write(priv->rf[CRIT_INT_CLEAR_0 + hw_id], 0);
> > +                       break;
> > +               default:
>
> I'm not sure we actually need this. Modern compilers check for not
> catching an enum value in a switch case so this shouldn't even really
> matter.

I didn't know that about enums. Will fix.

> > +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __func__);
> > +                       break;
> > +               }
> > +       }
> > +}
> > +
> > +/**
> > + * tsens_set_interrupt - Disable an interrupt (enable = false)
> > + *                       Re-enable an interrupt (enable = true)
> > + */
> > +static void tsens_set_interrupt(struct tsens_priv *priv, const struct tsens_irq_data d,
>
> Why not pass a pointer to tsens_irq_data?

I actually wanted to remove tsens_irq_data completely - see comment
below. I needed it in a previous iteration but now I noticed the data
isn't used. So we can remove the parameter completely.

> > +                               u32 hw_id, enum tsens_irq_type irq_type, bool enable)
> > +{
> > +       /* FIXME: remove tsens_irq_data */
> > +       dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
> > +               irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
> > +               enable ? "en" : "dis");
> > +       if (tsens_ver(priv) > VER_1_X)
> > +               tsens_set_interrupt_v2(priv, d, hw_id, irq_type, enable);
> > +       else
> > +               tsens_set_interrupt_v1(priv, d, hw_id, irq_type, enable);
> > +}
> > +
> > +static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
> > +                               struct tsens_sensor *s, struct tsens_irq_data *d)
> > +{
> > +       int ret, up_temp, low_temp;
> > +
> > +       if (hw_id > priv->num_sensors) {
> > +               dev_err(priv->dev, "%s Invalid hw_id\n", __func__);
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret = regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->up_viol);
> > +       if (ret)
> > +               return ret;
> > +       ret = regmap_field_read(priv->rf[UP_THRESH_0 + hw_id], &up_temp);
> > +       if (ret)
> > +               return ret;
> > +       ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->low_viol);
> > +       if (ret)
> > +               return ret;
> > +       ret = regmap_field_read(priv->rf[LOW_THRESH_0 + hw_id], &low_temp);
> > +       if (ret)
> > +               return ret;
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
> > +       d->up_thresh = tsens_hw_to_mC("upthresh", s, UP_THRESH_0, up_temp);
> > +       d->low_thresh = tsens_hw_to_mC("lowthresh", s, LOW_THRESH_0, low_temp);
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
> > +       if (ver > VER_1_X) {
> > +               return mask & (1 << hw_id);
> > +       } else {
> > +               /* v1, v0.1 don't have a irq mask register */
> > +               return 0;
> > +       }
>
> Same return comment.

Will fix.

> > +}
> > +
> > +static unsigned long tsens_filter_active_sensors(struct tsens_priv *priv)
> > +{
> > +       int i, ret, up, low;
> > +       unsigned long mask = 0;
> > +
> > +       for (i = 0; i < priv->num_sensors; i++) {
> > +               struct tsens_sensor *s = &priv->sensor[i];
> > +               u32 hw_id = s->hw_id;
> > +
> > +               if (IS_ERR(priv->sensor[i].tzd))
> > +                       continue;
> > +               ret = regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &up);
> > +               if (ret)
> > +                       return ret;
>
> Probably don't want to return ret here given that this returns a mask.
> Maybe push this into the callsite loop and then break out or return an
> error from there instead. Making a mask via a loop and then using that
> again the second time to test the bit is more complicated.

Right. I only wanted to iterate over sensors that had crossed their
thresholds in the irq thread. Will move it back to the irq_thread
function and split tsens_read_irq_state into two parts - one to just
check if the sensor crossed a threshold, the other reading all other
irq information.

> > +               ret = regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &low);
> > +               if (ret)
> > +                       return ret;
> > +               if (up || low)
> > +                       set_bit(hw_id, &mask);
> > +       }
> > +       dev_dbg(priv->dev, "%s: hw_id mask: 0x%lx\n",  __func__, mask);
> > +
> > +       return mask;
> > +}
> > +
> > +irqreturn_t tsens_irq_thread(int irq, void *data)
> > +{
> > +       struct tsens_priv *priv = data;
> > +       int temp, ret, i;
> > +       unsigned long flags;
> > +       bool enable = true, disable = false;
> > +       unsigned long mask = tsens_filter_active_sensors(priv);
> > +
> > +       if (!mask) {
> > +               dev_err(priv->dev, "%s: Spurious interrupt?\n", __func__);
>
> Do we need the spurious irq print? Doesn't genirq already tell us about
> spurious interrupts and shuts them down?

Already got rid of this. I realised it isn't a spurious interrupt but
the irq being level triggered and sometimes the temperature gets back
to below the thresholds in the time where the irq thread is schduled.

> > +               return IRQ_NONE;

we return IRQ_HANDLED here, in that case.

> > +       }
> > +
> > +       /* Check if any sensor raised an IRQ - for each sensor connected to the
>
> /*
>  * Please make multiline comments
>  * like this
>  */

Done.

> > +        * TSENS block if it set the threshold violation bit.
> > +        */
> > +       for (i = 0; i < priv->num_sensors; i++) {
> > +               struct tsens_sensor *s = &priv->sensor[i];
> > +               struct tsens_irq_data d;
> > +               u32 hw_id = s->hw_id;
> > +               bool trigger = 0;
> > +
> > +               if (!test_bit(hw_id, &mask))
> > +                       continue;
> > +               if (IS_ERR(priv->sensor[i].tzd))
> > +                       continue;
> > +               ret = get_temp_tsens_valid(s, &temp);
> > +               if (ret) {
> > +                       dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
> > +                       continue;
> > +               }
> > +
> > +               spin_lock_irqsave(&priv->ul_lock, flags);
> > +
> > +               tsens_read_irq_state(priv, hw_id, s, &d);
> > +
> > +               if (d.up_viol &&
> > +                   !masked_irq(hw_id, d.up_irq_mask, tsens_ver(priv))) {
> > +                       tsens_set_interrupt(priv, d, hw_id, UPPER, disable);
> > +                       if (d.up_thresh > temp) {
> > +                               dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> > +                                       priv->sensor[i].hw_id, __func__);
> > +                               /* unmask the interrupt for this sensor */
> > +                               tsens_set_interrupt(priv, d, hw_id, UPPER, enable);
> > +                       } else {
> > +                               trigger = 1;
> > +                               /* Keep irq masked */
> > +                       }
> > +               } else if (d.low_viol &&
> > +                          !masked_irq(hw_id, d.low_irq_mask, tsens_ver(priv))) {
> > +                       tsens_set_interrupt(priv, d, hw_id, LOWER, disable);
> > +                       if (d.low_thresh < temp) {
> > +                               dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
> > +                                       priv->sensor[i].hw_id, __func__);
> > +                               /* unmask the interrupt for this sensor */
> > +                               tsens_set_interrupt(priv, d, hw_id, LOWER, enable);
> > +                       } else {
> > +                               trigger = 1;
> > +                               /* Keep irq masked */
> > +                       }
> > +               }
> > +
> > +               /* TODO: (amit) REALLY??? */
>
> Remove it, and the mb?

Already removed, this shouldn't have snuck through in v1.

> > +               mb();
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
> > +       tsens_set_interrupt(priv, d, hw_id, LOWER, enable);
> > +       tsens_set_interrupt(priv, d, hw_id, UPPER, enable);
> > +
> > +       /* TODO: (amit) REALLY??? */
> > +       mb();
>
> Again!

Done

> > +
> > +       spin_unlock_irqrestore(&priv->ul_lock, flags);
> > +
> > +       dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
> > +               s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
> > +
> > +       return 0;
> > +}
> > +
> > +int tsens_enable_irq(struct tsens_priv *priv)
> > +{
> > +       int ret;
> > +       int val = (tsens_ver(priv) > VER_1_X) ? 7 : 1;
>
> Drop useless parenthesis.

Will fix.

> > +
> > +       ret = regmap_field_write(priv->rf[INT_EN], val);
> > +       if (ret < 0)
> > +               dev_err(priv->dev, "%s: failed to enable interrupts\n", __func__);
> > +
> > +       return ret;
> > +}
> > +
> > +void tsens_disable_irq(struct tsens_priv *priv)
> > +{
> > +       regmap_field_write(priv->rf[INT_EN], 0);
> > +}
> > +
> >  int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
> >  {
> >         struct tsens_priv *priv = s->priv;
> > @@ -334,6 +719,88 @@ int __init init_common(struct tsens_priv *priv)
> >                         goto err_put_device;
> >                 }
> >         }
> > +       for (i = 0, j = UPPER_STATUS_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +       for (i = 0, j = LOWER_STATUS_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +       for (i = 0, j = CRITICAL_STATUS_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
>
> Can you make a function for this? Takes priv, and a 'j' and then does
> the allocation and returns failure if something went bad? Then it's a
> simple
>
>         devm_tsens_regmap_field_alloc(dev, priv, CRITICAL_STATUS_0);
>
> pile of calls. Maybe it could even be iterated through for j too in
> another loop, not sure how the registers are setup though.

Yes, I will fix this. Some history for why I have this silly
implementation: I was trying to figure out what bit fields were
present in different versions of the IP while trying to save some
bytes by only alloc'ing things are present on the version of the IP. I
have reached the conclusion that we should just alloc in a loop is a
lot simpler at the cost of some extra bytes.

I will revisit this again.

Thanks again for the review.

Regards,
Amit

> > +       for (i = 0, j = UP_THRESH_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +       for (i = 0, j = LOW_THRESH_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +       for (i = 0, j = UP_INT_CLEAR_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +       for (i = 0, j = LOW_INT_CLEAR_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +       for (i = 0, j = UP_INT_MASK_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +       for (i = 0, j = LOW_INT_MASK_0; i < priv->feat->max_sensors; i++, j++) {
> > +               priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                     priv->fields[j]);
> > +               if (IS_ERR(priv->rf[j])) {
> > +                       ret = PTR_ERR(priv->rf[j]);
> > +                       goto err_put_device;
> > +               }
> > +       }
> > +
> > +       priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                  priv->fields[INT_EN]);
> > +       if (IS_ERR(priv->rf[INT_EN])) {
> > +               ret = PTR_ERR(priv->rf[INT_EN]);
> > +               goto err_put_device;
> > +       }
> > +
> > +       tsens_enable_irq(priv);
> > +       spin_lock_init(&priv->ul_lock);
>
> Maybe you should initialize the spinlock before requesting the irq.
>
> >
> >         tsens_debug_init(op);
> >
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 772aa76b50e1..bc83e40ac0cf 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm.h>
> >  #include <linux/slab.h>
> > @@ -78,12 +79,15 @@ MODULE_DEVICE_TABLE(of, tsens_table);
> >  static const struct thermal_zone_of_device_ops tsens_of_ops = {
> >         .get_temp = tsens_get_temp,
> >         .get_trend = tsens_get_trend,
> > +       .set_trips = tsens_set_trips,
> >  };
> >
> >  static int tsens_register(struct tsens_priv *priv)
> >  {
> > -       int i;
> > +       int i, ret, irq;
> >         struct thermal_zone_device *tzd;
> > +       struct resource *res;
> > +       struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
>
> What if this fails?
>
> >
> >         for (i = 0;  i < priv->num_sensors; i++) {
> >                 priv->sensor[i].priv = priv;
> > @@ -96,7 +100,25 @@ static int tsens_register(struct tsens_priv *priv)
> >                 if (priv->ops->enable)
> >                         priv->ops->enable(priv, i);
> >         }
> > +
> > +       res = platform_get_resource(op, IORESOURCE_IRQ, 0);
> > +       if (res) {
> > +               irq = res->start;
> > +               ret = devm_request_threaded_irq(&op->dev, irq,
> > +                                               NULL, tsens_irq_thread,
> > +                                               IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +                                               res->name, priv);
> > +               if (ret) {
> > +                       dev_err(&op->dev, "%s: failed to get irq\n", __func__);
> > +                       goto err_put_device;
> > +               }
> > +               enable_irq_wake(irq);
> > +       }
> >         return 0;
> > +
> > +err_put_device:
> > +       put_device(&op->dev);
> > +       return ret;
> >  }
> >
> >  static int tsens_probe(struct platform_device *pdev)
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> > index e1d6af71b2b9..aab47337b797 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -13,8 +13,10 @@
> >  #define CAL_DEGC_PT2           120
> >  #define SLOPE_FACTOR           1000
> >  #define SLOPE_DEFAULT          3200
> > +#define THRESHOLD_MAX_ADC_CODE 0x3ff
> > +#define THRESHOLD_MIN_ADC_CODE 0x0
> >
> > -
> > +#include <linux/interrupt.h>
>
> Include this in the C driver?
>
> >  #include <linux/thermal.h>
> >  #include <linux/regmap.h>
> >
> > @@ -26,6 +28,12 @@ enum tsens_ver {
> >         VER_2_X,
> >  };
> >
> > +enum tsens_irq_type {
> > +       LOWER,
> > +       UPPER,
