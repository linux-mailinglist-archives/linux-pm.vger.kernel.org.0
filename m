Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9729690D47
	for <lists+linux-pm@lfdr.de>; Sat, 17 Aug 2019 08:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfHQGJT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 02:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfHQGJT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 02:09:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3439321019;
        Sat, 17 Aug 2019 06:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566022156;
        bh=hI/X7F4ARJ75tmtiKfFhRfWXS93yZ6eS2p1swcC4Kjw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mgdvFDJ9oroGMKW508ggTLjmU0ae/LmMPhRfAdFxu+eICCsWH3TuHWx4r/bXgptil
         R/mTzmOJnuUkZebOUcmkyt8JqkgktZeT5+MHEI1tcYcPSquJttOWv6ORKbbp5uhji7
         l5pdhD2+6ma41zxDzN7Bgsa5dvrUyc99+Fzsu/Hg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3105ffc275c6e1106a17b8b9ad83a8f1816445eb.1564091601.git.amit.kucheria@linaro.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <3105ffc275c6e1106a17b8b9ad83a8f1816445eb.1564091601.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH 15/15] drivers: thermal: tsens: Add interrupt support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 23:09:15 -0700
Message-Id: <20190817060916.3439321019@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-07-25 15:18:50)
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index 13a875b99094..f94ef79c37bc 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -13,6 +13,22 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
> =20
> +/* IRQ state, mask and clear */
> +struct tsens_irq_data {
> +       u32 up_viol;

Is viol a violation? Maybe some kernel doc would be useful here.

> +       int up_thresh;
> +       u32 up_irq_mask;
> +       u32 up_irq_clear;
> +       u32 low_viol;
> +       int low_thresh;
> +       u32 low_irq_mask;
> +       u32 low_irq_clear;
> +       u32 crit_viol;
> +       u32 crit_thresh;
> +       u32 crit_irq_mask;
> +       u32 crit_irq_clear;
> +};
> +
>  char *qfprom_read(struct device *dev, const char *cname)
>  {
>         struct nvmem_cell *cell;
> @@ -65,6 +81,18 @@ void compute_intercept_slope(struct tsens_priv *priv, =
u32 *p1,
>         }
>  }
> =20
> +static inline u32 degc_to_code(int degc, const struct tsens_sensor *sens=
or)
> +{
> +       u32 code =3D (degc * sensor->slope + sensor->offset) / SLOPE_FACT=
OR;

This can't overflow 32-bits with the multiply and add?

> +
> +       if (code > THRESHOLD_MAX_ADC_CODE)
> +               code =3D THRESHOLD_MAX_ADC_CODE;
> +       else if (code < THRESHOLD_MIN_ADC_CODE)
> +               code =3D THRESHOLD_MIN_ADC_CODE;

Looks like

	return clamp(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);

> +       pr_debug("%s: raw_code: 0x%x, degc:%d\n", __func__, code, degc);
> +       return code;
> +}
> +
>  static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *=
s)
>  {
>         int degc, num, den;
> @@ -106,6 +134,363 @@ static int tsens_hw_to_mC(char *str, struct tsens_s=
ensor *s, int field, int temp
>         }
>  }
> =20
> +/**
> + * tsens_mC_to_hw - Return correct value to be written to threshold
> + * registers, whether in ADC code or deciCelsius depending on IP version
> + */
> +static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
> +{
> +       struct tsens_priv *priv =3D s->priv;
> +
> +       if (priv->feat->adc) {
> +               /* milli to C to adc code */
> +               return degc_to_code(temp / 1000, s);
> +       } else {
> +               /* milli to deci C */
> +               return (temp / 100);
> +       }

Drop the else and just return without parenthesis.

> +}
> +
> +static inline unsigned int tsens_ver(struct tsens_priv *priv)
> +{
> +       return priv->feat->ver_major;
> +}
> +
> +static inline u32 irq_mask(u32 hw_id)

Is this used?

> +{
> +       return 1 << hw_id;
> +}
> +
> +/**
> + * tsens_set_interrupt_v1 - Disable an interrupt (enable =3D false)
> + *                          Re-enable an interrupt (enable =3D true)
> + */
> +static void tsens_set_interrupt_v1(struct tsens_priv *priv, const struct=
 tsens_irq_data d,
> +                                  u32 hw_id, enum tsens_irq_type irq_typ=
e, bool enable)
> +{
> +       if (enable) {
> +               switch (irq_type) {
> +               case UPPER:
> +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_i=
d], 0);
> +                       break;
> +               case LOWER:
> +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_=
id], 0);
> +                       break;
> +               default:
> +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __fu=
nc__);
> +                       break;
> +               }
> +       } else {
> +               switch (irq_type) {
> +               case UPPER:
> +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_i=
d], 1);
> +                       break;
> +               case LOWER:
> +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_=
id], 1);
> +                       break;
> +               default:
> +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __fu=
nc__);
> +                       break;
> +               }
> +       }
> +}
> +
> +/**
> + * tsens_set_interrupt_v2 - Disable an interrupt (enable =3D false)
> + *                          Re-enable an interrupt (enable =3D true)
> + */
> +static void tsens_set_interrupt_v2(struct tsens_priv *priv, const struct=
 tsens_irq_data d,
> +                                  u32 hw_id, enum tsens_irq_type irq_typ=
e, bool enable)
> +{
> +       if (enable) {
> +               switch (irq_type) {
> +               case UPPER:
> +                       regmap_field_write(priv->rf[UP_INT_MASK_0 + hw_id=
], 0);

Maybe just have a variable like mask_reg that is equal to UP_INT_MASK,
etc? And then one regmap_field_write() call outside the switch that does
the write to 0?

> +                       break;
> +               case LOWER:
> +                       regmap_field_write(priv->rf[LOW_INT_MASK_0 + hw_i=
d], 0);
> +                       break;
> +               case CRITICAL:
> +                       regmap_field_write(priv->rf[CRIT_INT_MASK_0 + hw_=
id], 0);
> +                       break;
> +               default:
> +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __fu=
nc__);
> +                       break;
> +               }
> +       } else {
> +               /* To disable the interrupt flag for a sensor:
> +                *  1. Mask further interrupts for this sensor
> +                *  2. Write 1 followed by 0 to clear the interrupt
> +                */
> +               switch (irq_type) {
> +               case UPPER:
> +                       regmap_field_write(priv->rf[UP_INT_MASK_0 + hw_id=
], 1);
> +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_i=
d], 1);
> +                       regmap_field_write(priv->rf[UP_INT_CLEAR_0 + hw_i=
d], 0);

Same comment here. Use a local variable for mask and clear and then
write the register with three regmap_field_write() calls?

> +                       break;
> +               case LOWER:
> +                       regmap_field_write(priv->rf[LOW_INT_MASK_0 + hw_i=
d], 1);
> +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_=
id], 1);
> +                       regmap_field_write(priv->rf[LOW_INT_CLEAR_0 + hw_=
id], 0);
> +                       break;
> +               case CRITICAL:
> +                       regmap_field_write(priv->rf[CRIT_INT_MASK_0 + hw_=
id], 1);
> +                       regmap_field_write(priv->rf[CRIT_INT_CLEAR_0 + hw=
_id], 1);
> +                       regmap_field_write(priv->rf[CRIT_INT_CLEAR_0 + hw=
_id], 0);
> +                       break;
> +               default:

I'm not sure we actually need this. Modern compilers check for not
catching an enum value in a switch case so this shouldn't even really
matter.

> +                       dev_err(priv->dev, "%s: Invalid irq_type\n", __fu=
nc__);
> +                       break;
> +               }
> +       }
> +}
> +
> +/**
> + * tsens_set_interrupt - Disable an interrupt (enable =3D false)
> + *                       Re-enable an interrupt (enable =3D true)
> + */
> +static void tsens_set_interrupt(struct tsens_priv *priv, const struct ts=
ens_irq_data d,

Why not pass a pointer to tsens_irq_data?

> +                               u32 hw_id, enum tsens_irq_type irq_type, =
bool enable)
> +{
> +       /* FIXME: remove tsens_irq_data */
> +       dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
> +               irq_type ? ((irq_type =3D=3D 1) ? "UP" : "CRITICAL") : "L=
OW",
> +               enable ? "en" : "dis");
> +       if (tsens_ver(priv) > VER_1_X)
> +               tsens_set_interrupt_v2(priv, d, hw_id, irq_type, enable);
> +       else
> +               tsens_set_interrupt_v1(priv, d, hw_id, irq_type, enable);
> +}
> +
> +static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
> +                               struct tsens_sensor *s, struct tsens_irq_=
data *d)
> +{
> +       int ret, up_temp, low_temp;
> +
> +       if (hw_id > priv->num_sensors) {
> +               dev_err(priv->dev, "%s Invalid hw_id\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->u=
p_viol);
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_field_read(priv->rf[UP_THRESH_0 + hw_id], &up_temp=
);
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->l=
ow_viol);
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_field_read(priv->rf[LOW_THRESH_0 + hw_id], &low_te=
mp);
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_field_read(priv->rf[UP_INT_CLEAR_0 + hw_id], &d->u=
p_irq_clear);
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->=
low_irq_clear);
> +       if (ret)
> +               return ret;
> +       if (tsens_ver(priv) > VER_1_X) {
> +               ret =3D regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id]=
, &d->up_irq_mask);
> +               if (ret)
> +                       return ret;
> +               ret =3D regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id=
], &d->low_irq_mask);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               /* No mask register on older TSENS */
> +               d->up_irq_mask =3D 0;
> +               d->low_irq_mask =3D 0;
> +       }
> +
> +       d->up_thresh =3D tsens_hw_to_mC("upthresh", s, UP_THRESH_0, up_te=
mp);
> +       d->low_thresh =3D tsens_hw_to_mC("lowthresh", s, LOW_THRESH_0, lo=
w_temp);
> +
> +       dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u) | clr(%u|%u) | mask(=
%u|%u)\n",
> +               hw_id, __func__, (d->up_viol || d->low_viol) ? "(V)" : "",
> +               d->low_viol, d->up_viol, d->low_irq_clear, d->up_irq_clea=
r,
> +               d->low_irq_mask, d->up_irq_mask);
> +       dev_dbg(priv->dev, "[%u] %s%s: thresh: (%d:%d)\n", hw_id, __func_=
_,
> +               (d->up_viol || d->low_viol) ? "(violation)" : "",
> +               d->low_thresh, d->up_thresh);
> +
> +       return 0;
> +}
> +
> +static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
> +{
> +       if (ver > VER_1_X) {
> +               return mask & (1 << hw_id);
> +       } else {
> +               /* v1, v0.1 don't have a irq mask register */
> +               return 0;
> +       }

Same return comment.

> +}
> +
> +static unsigned long tsens_filter_active_sensors(struct tsens_priv *priv)
> +{
> +       int i, ret, up, low;
> +       unsigned long mask =3D 0;
> +
> +       for (i =3D 0; i < priv->num_sensors; i++) {
> +               struct tsens_sensor *s =3D &priv->sensor[i];
> +               u32 hw_id =3D s->hw_id;
> +
> +               if (IS_ERR(priv->sensor[i].tzd))
> +                       continue;
> +               ret =3D regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id=
], &up);
> +               if (ret)
> +                       return ret;

Probably don't want to return ret here given that this returns a mask.
Maybe push this into the callsite loop and then break out or return an
error from there instead. Making a mask via a loop and then using that
again the second time to test the bit is more complicated.

> +               ret =3D regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id=
], &low);
> +               if (ret)
> +                       return ret;
> +               if (up || low)
> +                       set_bit(hw_id, &mask);
> +       }
> +       dev_dbg(priv->dev, "%s: hw_id mask: 0x%lx\n",  __func__, mask);
> +
> +       return mask;
> +}
> +
> +irqreturn_t tsens_irq_thread(int irq, void *data)
> +{
> +       struct tsens_priv *priv =3D data;
> +       int temp, ret, i;
> +       unsigned long flags;
> +       bool enable =3D true, disable =3D false;
> +       unsigned long mask =3D tsens_filter_active_sensors(priv);
> +
> +       if (!mask) {
> +               dev_err(priv->dev, "%s: Spurious interrupt?\n", __func__);

Do we need the spurious irq print? Doesn't genirq already tell us about
spurious interrupts and shuts them down?

> +               return IRQ_NONE;
> +       }
> +
> +       /* Check if any sensor raised an IRQ - for each sensor connected =
to the

/*
 * Please make multiline comments
 * like this
 */

> +        * TSENS block if it set the threshold violation bit.
> +        */
> +       for (i =3D 0; i < priv->num_sensors; i++) {
> +               struct tsens_sensor *s =3D &priv->sensor[i];
> +               struct tsens_irq_data d;
> +               u32 hw_id =3D s->hw_id;
> +               bool trigger =3D 0;
> +
> +               if (!test_bit(hw_id, &mask))
> +                       continue;
> +               if (IS_ERR(priv->sensor[i].tzd))
> +                       continue;
> +               ret =3D get_temp_tsens_valid(s, &temp);
> +               if (ret) {
> +                       dev_err(priv->dev, "[%u] %s: error reading sensor=
\n", hw_id, __func__);
> +                       continue;
> +               }
> +
> +               spin_lock_irqsave(&priv->ul_lock, flags);
> +
> +               tsens_read_irq_state(priv, hw_id, s, &d);
> +
> +               if (d.up_viol &&
> +                   !masked_irq(hw_id, d.up_irq_mask, tsens_ver(priv))) {
> +                       tsens_set_interrupt(priv, d, hw_id, UPPER, disabl=
e);
> +                       if (d.up_thresh > temp) {
> +                               dev_dbg(priv->dev, "[%u] %s: re-arm upper=
\n",
> +                                       priv->sensor[i].hw_id, __func__);
> +                               /* unmask the interrupt for this sensor */
> +                               tsens_set_interrupt(priv, d, hw_id, UPPER=
, enable);
> +                       } else {
> +                               trigger =3D 1;
> +                               /* Keep irq masked */
> +                       }
> +               } else if (d.low_viol &&
> +                          !masked_irq(hw_id, d.low_irq_mask, tsens_ver(p=
riv))) {
> +                       tsens_set_interrupt(priv, d, hw_id, LOWER, disabl=
e);
> +                       if (d.low_thresh < temp) {
> +                               dev_dbg(priv->dev, "[%u] %s: re-arm low\n=
",
> +                                       priv->sensor[i].hw_id, __func__);
> +                               /* unmask the interrupt for this sensor */
> +                               tsens_set_interrupt(priv, d, hw_id, LOWER=
, enable);
> +                       } else {
> +                               trigger =3D 1;
> +                               /* Keep irq masked */
> +                       }
> +               }
> +
> +               /* TODO: (amit) REALLY??? */

Remove it, and the mb?

> +               mb();
> +
> +               spin_unlock_irqrestore(&priv->ul_lock, flags);
> +
> +               if (trigger) {
> +                       dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%=
d mC)\n",
> +                               hw_id, __func__, temp);
> +                       thermal_zone_device_update(priv->sensor[i].tzd,
> +                                                  THERMAL_EVENT_UNSPECIF=
IED);
> +               } else {
> +                       dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> +                               hw_id, __func__, temp);
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +int tsens_set_trips(void *_sensor, int low, int high)
> +{
> +       struct tsens_sensor *s =3D _sensor;
> +       struct tsens_priv *priv =3D s->priv;
> +       struct device *dev =3D priv->dev;
> +       struct tsens_irq_data d;
> +       unsigned long flags;
> +       int high_val, low_val, cl_high, cl_low;
> +       bool enable =3D true;
> +       u32 hw_id =3D s->hw_id;
> +
> +       dev_dbg(dev, "[%u] %s: proposed thresholds: (%d:%d)\n",
> +               hw_id, __func__, low, high);
> +
> +       cl_high =3D clamp_val(high, -40000, 120000);
> +       cl_low  =3D clamp_val(low, -40000, 120000);
> +
> +       high_val =3D tsens_mC_to_hw(s, cl_high);
> +       low_val  =3D tsens_mC_to_hw(s, cl_low);
> +
> +       spin_lock_irqsave(&priv->ul_lock, flags);
> +
> +       tsens_read_irq_state(priv, hw_id, s, &d);
> +
> +       /* Write the new thresholds and clear the status */
> +       regmap_field_write(priv->rf[LOW_THRESH_0 + hw_id], low_val);
> +       regmap_field_write(priv->rf[UP_THRESH_0 + hw_id], high_val);
> +       tsens_set_interrupt(priv, d, hw_id, LOWER, enable);
> +       tsens_set_interrupt(priv, d, hw_id, UPPER, enable);
> +
> +       /* TODO: (amit) REALLY??? */
> +       mb();

Again!

> +
> +       spin_unlock_irqrestore(&priv->ul_lock, flags);
> +
> +       dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
> +               s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl=
_high);
> +
> +       return 0;
> +}
> +
> +int tsens_enable_irq(struct tsens_priv *priv)
> +{
> +       int ret;
> +       int val =3D (tsens_ver(priv) > VER_1_X) ? 7 : 1;

Drop useless parenthesis.

> +
> +       ret =3D regmap_field_write(priv->rf[INT_EN], val);
> +       if (ret < 0)
> +               dev_err(priv->dev, "%s: failed to enable interrupts\n", _=
_func__);
> +
> +       return ret;
> +}
> +
> +void tsens_disable_irq(struct tsens_priv *priv)
> +{
> +       regmap_field_write(priv->rf[INT_EN], 0);
> +}
> +
>  int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
>  {
>         struct tsens_priv *priv =3D s->priv;
> @@ -334,6 +719,88 @@ int __init init_common(struct tsens_priv *priv)
>                         goto err_put_device;
>                 }
>         }
> +       for (i =3D 0, j =3D UPPER_STATUS_0; i < priv->feat->max_sensors; =
i++, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +       for (i =3D 0, j =3D LOWER_STATUS_0; i < priv->feat->max_sensors; =
i++, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +       for (i =3D 0, j =3D CRITICAL_STATUS_0; i < priv->feat->max_sensor=
s; i++, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }

Can you make a function for this? Takes priv, and a 'j' and then does
the allocation and returns failure if something went bad? Then it's a
simple

	devm_tsens_regmap_field_alloc(dev, priv, CRITICAL_STATUS_0);

pile of calls. Maybe it could even be iterated through for j too in
another loop, not sure how the registers are setup though.

> +       for (i =3D 0, j =3D UP_THRESH_0; i < priv->feat->max_sensors; i++=
, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +       for (i =3D 0, j =3D LOW_THRESH_0; i < priv->feat->max_sensors; i+=
+, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +       for (i =3D 0, j =3D UP_INT_CLEAR_0; i < priv->feat->max_sensors; =
i++, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +       for (i =3D 0, j =3D LOW_INT_CLEAR_0; i < priv->feat->max_sensors;=
 i++, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +       for (i =3D 0, j =3D UP_INT_MASK_0; i < priv->feat->max_sensors; i=
++, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +       for (i =3D 0, j =3D LOW_INT_MASK_0; i < priv->feat->max_sensors; =
i++, j++) {
> +               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                     priv->fields[j]);
> +               if (IS_ERR(priv->rf[j])) {
> +                       ret =3D PTR_ERR(priv->rf[j]);
> +                       goto err_put_device;
> +               }
> +       }
> +
> +       priv->rf[INT_EN] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                  priv->fields[INT_EN]);
> +       if (IS_ERR(priv->rf[INT_EN])) {
> +               ret =3D PTR_ERR(priv->rf[INT_EN]);
> +               goto err_put_device;
> +       }
> +
> +       tsens_enable_irq(priv);
> +       spin_lock_init(&priv->ul_lock);

Maybe you should initialize the spinlock before requesting the irq.

> =20
>         tsens_debug_init(op);
> =20
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 772aa76b50e1..bc83e40ac0cf 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -7,6 +7,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> @@ -78,12 +79,15 @@ MODULE_DEVICE_TABLE(of, tsens_table);
>  static const struct thermal_zone_of_device_ops tsens_of_ops =3D {
>         .get_temp =3D tsens_get_temp,
>         .get_trend =3D tsens_get_trend,
> +       .set_trips =3D tsens_set_trips,
>  };
> =20
>  static int tsens_register(struct tsens_priv *priv)
>  {
> -       int i;
> +       int i, ret, irq;
>         struct thermal_zone_device *tzd;
> +       struct resource *res;
> +       struct platform_device *op =3D of_find_device_by_node(priv->dev->=
of_node);

What if this fails?

> =20
>         for (i =3D 0;  i < priv->num_sensors; i++) {
>                 priv->sensor[i].priv =3D priv;
> @@ -96,7 +100,25 @@ static int tsens_register(struct tsens_priv *priv)
>                 if (priv->ops->enable)
>                         priv->ops->enable(priv, i);
>         }
> +
> +       res =3D platform_get_resource(op, IORESOURCE_IRQ, 0);
> +       if (res) {
> +               irq =3D res->start;
> +               ret =3D devm_request_threaded_irq(&op->dev, irq,
> +                                               NULL, tsens_irq_thread,
> +                                               IRQF_TRIGGER_HIGH | IRQF_=
ONESHOT,
> +                                               res->name, priv);
> +               if (ret) {
> +                       dev_err(&op->dev, "%s: failed to get irq\n", __fu=
nc__);
> +                       goto err_put_device;
> +               }
> +               enable_irq_wake(irq);
> +       }
>         return 0;
> +
> +err_put_device:
> +       put_device(&op->dev);
> +       return ret;
>  }
> =20
>  static int tsens_probe(struct platform_device *pdev)
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index e1d6af71b2b9..aab47337b797 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -13,8 +13,10 @@
>  #define CAL_DEGC_PT2           120
>  #define SLOPE_FACTOR           1000
>  #define SLOPE_DEFAULT          3200
> +#define THRESHOLD_MAX_ADC_CODE 0x3ff
> +#define THRESHOLD_MIN_ADC_CODE 0x0
> =20
> -
> +#include <linux/interrupt.h>

Include this in the C driver?

>  #include <linux/thermal.h>
>  #include <linux/regmap.h>
> =20
> @@ -26,6 +28,12 @@ enum tsens_ver {
>         VER_2_X,
>  };
> =20
> +enum tsens_irq_type {
> +       LOWER,
> +       UPPER,
