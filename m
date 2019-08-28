Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA4A0C8F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 23:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfH1Vmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 17:42:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46616 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfH1Vmb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 17:42:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id o3so542577plb.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=LDrJN78swrMMxTHINo5awtlZAwquYmUFK4yMD7VkcMU=;
        b=la7r9TLXU+NDtIhY6O2OLWmlqu7Ah++Y6piSXx6+5+y7QwV+VBB7SEbswo04eZOKkY
         wQcxcJPYaQTA989uD0BEaak/osFdHOvZVWOCBYmRgAYeghsrk/5i046m3KTDsHGhhP3T
         ZUrRfJPb2z4d8YWLscAlaafnVLRvldlH+/OZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=LDrJN78swrMMxTHINo5awtlZAwquYmUFK4yMD7VkcMU=;
        b=AYU8y4UAmhaQdLs3LFhTFR17EyU3GFce/KYUshP2Mqnn6w6gATbjylKFPyvMJ8xeUd
         hmLu3yo4QKEraY06JwJgUATD7ulgvrqGHyzb5cL5RO+dGuK1lFiyTrXEXQJb75Dwq0yP
         4JSeFOAG5P+1P9QEKuVupE408BpIJz5Hjn6qmH04fjTXsGK7jwwAWk/IiEeISW9CJV9x
         /pp6QH8ZsMcX9r//Mn1mn6n//Cm1tkJasGkwUrFAaD1OBodB1zl2kXL/NwMVbKZsi/6c
         ftBffEVYXrFP/RidPPTkUgkYWVojQxEm02pxRVxRUD1S3sAe97O3z++DpaHVQnLG2+ev
         GfZA==
X-Gm-Message-State: APjAAAXPWtLSJs4dUh3DUNOqERKsEhoBuWBbB6QwQfnx8G4Mh7ZGYydC
        IQ+Ko3lmZILn0cnvDh2ikhMR8zH7xg+V/g==
X-Google-Smtp-Source: APXvYqwYTeDAowzlzAkDxZz7oOto4rbnQgH/GzVolQqHURmi9UIsX3deKmGnPugpIKq7tg206io/5Q==
X-Received: by 2002:a17:902:fe0f:: with SMTP id g15mr6146828plj.2.1567028550008;
        Wed, 28 Aug 2019 14:42:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j187sm313829pfg.178.2019.08.28.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:42:29 -0700 (PDT)
Message-ID: <5d66f545.1c69fb81.3663f.129d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a4666f8afa39471658602e06758b04a991f80828.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <a4666f8afa39471658602e06758b04a991f80828.1566907161.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 15/15] drivers: thermal: tsens: Add interrupt support
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 28 Aug 2019 14:42:28 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:11)
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index 06b44cfd5eab9..c549f8e1488ba 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -114,6 +146,314 @@ static int tsens_hw_to_mC(struct tsens_sensor *s, i=
nt field)
>         return sign_extend32(temp, priv->tempres) * 100;
>  }
> =20
> +/**
> + * tsens_mC_to_hw - Return correct value to be written to threshold
> + * registers, whether in ADC code or deciCelsius depending on IP version

Document arguments and return value? Maybe summary can be 'convert
tsens temperature to hardware register value'?

> + */
> +static int tsens_mC_to_hw(struct tsens_sensor *s, int temp)
> +{
> +       struct tsens_priv *priv =3D s->priv;
> +
> +       if (priv->feat->adc) {
> +               /* milliC to C to adc code */
> +               return degc_to_code(temp / 1000, s);
> +       }
> +
> +       /* milliC to deciC */
> +       return temp / 100;
> +}
> +
> +static inline unsigned int tsens_ver(struct tsens_priv *priv)

Can this return the enum instead of unsigned int?

> +{
> +       return priv->feat->ver_major;
> +}
> +
> +/**
> + * tsens_set_interrupt_v1 - Disable an interrupt (enable =3D false)
> + *                          Re-enable an interrupt (enable =3D true)
> + */
> +static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
> +                                  enum tsens_irq_type irq_type, bool ena=
ble)
> +{
> +       u32 index;
> +
> +       if (enable) {
> +               switch (irq_type) {
> +               case UPPER:
> +                       index =3D UP_INT_CLEAR_0 + hw_id;
> +                       break;
> +               case LOWER:
> +                       index =3D LOW_INT_CLEAR_0 + hw_id;
> +                       break;
> +               }
> +               regmap_field_write(priv->rf[index], 0);
> +       } else {
> +               switch (irq_type) {
> +               case UPPER:
> +                       index =3D UP_INT_CLEAR_0 + hw_id;
> +                       break;
> +               case LOWER:
> +                       index =3D LOW_INT_CLEAR_0 + hw_id;
> +                       break;
> +               }
> +               regmap_field_write(priv->rf[index], 1);
> +       }

De-dup the switch statement and have

	regmap_field_write(priv->rf[index], enable ? 1 : 0);

> +}
> +
> +/**
> + * tsens_set_interrupt_v2 - Disable an interrupt (enable =3D false)
> + *                          Re-enable an interrupt (enable =3D true)
> + */
> +static void tsens_set_interrupt_v2(struct tsens_priv *priv, u32 hw_id,
> +                                  enum tsens_irq_type irq_type, bool ena=
ble)
> +{
> +       u32 index_mask, index_clear;
> +
> +       if (enable) {
> +               switch (irq_type) {
> +               case UPPER:
> +                       index_mask =3D UP_INT_MASK_0 + hw_id;
> +                       break;
> +               case LOWER:
> +                       index_mask =3D LOW_INT_MASK_0 + hw_id;
> +                       break;
> +               }
> +               regmap_field_write(priv->rf[index_mask], 0);
> +       } else {
> +               /* To disable the interrupt flag for a sensor:

Nitpick: Wrong comment style.

> +                *  1. Mask further interrupts for this sensor
> +                *  2. Write 1 followed by 0 to clear the interrupt
> +                */
> +               switch (irq_type) {
> +               case UPPER:
> +                       index_mask  =3D UP_INT_MASK_0 + hw_id;
> +                       index_clear =3D UP_INT_CLEAR_0 + hw_id;
> +                       break;
> +               case LOWER:
> +                       index_mask  =3D LOW_INT_MASK_0 + hw_id;
> +                       index_clear =3D LOW_INT_CLEAR_0 + hw_id;
> +                       break;
> +               }

Please extract index_mask and index_clear assignments to one switch
statement and then change the sequence to an if/else

	if (enable) {
               regmap_field_write(priv->rf[index_mask], 1);
               regmap_field_write(priv->rf[index_clear], 1);
               regmap_field_write(priv->rf[index_clear], 0);
       } else {
               regmap_field_write(priv->rf[index_mask], 0);
       }

> +}
> +
> +/**
> + * tsens_set_interrupt - Disable an interrupt (enable =3D false)
> + *                       Re-enable an interrupt (enable =3D true)
> + */
> +static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
> +                               enum tsens_irq_type irq_type, bool enable)
> +{
> +       dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
> +               irq_type ? ((irq_type =3D=3D 1) ? "UP" : "CRITICAL") : "L=
OW",
> +               enable ? "en" : "dis");
> +       if (tsens_ver(priv) > VER_1_X)
> +               tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
> +       else
> +               tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
> +}
> +
> +/**
> + * tsens_threshold_violated - Check if a sensor temperature violated a p=
reset threshold
> + *

Document arguments?

> + * Return: 0 if threshold was not violated, 1 if it was violated and neg=
ative
> + * errno in case of errors
> + */
> +static int tsens_threshold_violated(struct tsens_priv *priv, u32 hw_id,
> +                                   struct tsens_irq_data *d)
> +{
> +       int ret;
> +
> +       ret =3D regmap_field_read(priv->rf[UPPER_STATUS_0 + hw_id], &d->u=
p_viol);
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_field_read(priv->rf[LOWER_STATUS_0 + hw_id], &d->l=
ow_viol);
> +       if (ret)
> +               return ret;
> +       if (d->up_viol || d->low_viol)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
> +                               struct tsens_sensor *s, struct tsens_irq_=
data *d)
> +{
> +       int ret;
> +
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
> +       d->up_thresh =3D tsens_hw_to_mC(s, UP_THRESH_0 + hw_id);
> +       d->low_thresh =3D tsens_hw_to_mC(s, LOW_THRESH_0 + hw_id);
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
> +       if (ver > VER_1_X)
> +               return mask & (1 << hw_id);
> +
> +       /* v1, v0.1 don't have a irq mask register */
> +       return 0;
> +}
> +
> +irqreturn_t tsens_irq_thread(int irq, void *data)
> +{
> +       struct tsens_priv *priv =3D data;
> +       struct tsens_irq_data d;
> +       bool enable =3D true, disable =3D false;
> +       unsigned long flags;
> +       int temp, ret, i;
> +
> +       /*
> +        * Check if any sensor raised an IRQ - for each sensor connected =
to the
> +        * TSENS block if it set the threshold violation bit.
> +        */
> +       for (i =3D 0; i < priv->num_sensors; i++) {
> +               bool trigger =3D 0;

How about trigger =3D false? It's a bool.

> +               struct tsens_sensor *s =3D &priv->sensor[i];
> +               u32 hw_id =3D s->hw_id;
> +
> +               if (IS_ERR(priv->sensor[i].tzd))
> +                       continue;
> +               if (!tsens_threshold_violated(priv, hw_id, &d))
> +                       continue;
> +               ret =3D get_temp_tsens_valid(s, &temp);
> +               if (ret) {
> +                       dev_err(priv->dev, "[%u] %s: error reading sensor=
\n", hw_id, __func__);

I hope there isn't an interrupt storm where we're trying to print out
messages from the irq handler.

> +                       continue;
> +               }
> +
> +               spin_lock_irqsave(&priv->ul_lock, flags);
> +
> +               tsens_read_irq_state(priv, hw_id, s, &d);
> +
> +               if (d.up_viol &&
> +                   !masked_irq(hw_id, d.up_irq_mask, tsens_ver(priv))) {
> +                       tsens_set_interrupt(priv, hw_id, UPPER, disable);
> +                       if (d.up_thresh > temp) {
> +                               dev_dbg(priv->dev, "[%u] %s: re-arm upper=
\n",
> +                                       priv->sensor[i].hw_id, __func__);
> +                               /* unmask the interrupt for this sensor */
> +                               tsens_set_interrupt(priv, hw_id, UPPER, e=
nable);
> +                       } else {
> +                               trigger =3D 1;
> +                               /* Keep irq masked */
> +                       }
> +               } else if (d.low_viol &&
> +                          !masked_irq(hw_id, d.low_irq_mask, tsens_ver(p=
riv))) {
> +                       tsens_set_interrupt(priv, hw_id, LOWER, disable);
> +                       if (d.low_thresh < temp) {
> +                               dev_dbg(priv->dev, "[%u] %s: re-arm low\n=
",
> +                                       priv->sensor[i].hw_id, __func__);
> +                               /* unmask the interrupt for this sensor */
> +                               tsens_set_interrupt(priv, hw_id, LOWER, e=
nable);
> +                       } else {
> +                               trigger =3D 1;
> +                               /* Keep irq masked */
> +                       }
> +               }
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

Should we return IRQ_NONE in the case that the above for loop didn't
find anything in those if/else-ifs?

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
> +       tsens_set_interrupt(priv, hw_id, LOWER, enable);
> +       tsens_set_interrupt(priv, hw_id, UPPER, enable);

Just pass true? Why is there an enable local variable?

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
[...]
> @@ -319,28 +659,31 @@ int __init init_common(struct tsens_priv *priv)
>                 ret =3D PTR_ERR(priv->rf[SENSOR_EN]);
>                 goto err_put_device;
>         }
> -       /* now alloc regmap_fields in tm_map */
> -       for (i =3D 0, j =3D LAST_TEMP_0; i < priv->feat->max_sensors; i++=
, j++) {
> -               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> -                                                     priv->fields[j]);
> -               if (IS_ERR(priv->rf[j])) {
> -                       ret =3D PTR_ERR(priv->rf[j]);
> -                       goto err_put_device;
> -               }
> +       priv->rf[INT_EN] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> +                                                  priv->fields[INT_EN]);
> +       if (IS_ERR(priv->rf[INT_EN])) {
> +               ret =3D PTR_ERR(priv->rf[INT_EN]);
> +               goto err_put_device;
>         }
> =20
> -       /* Save away resolution of signed temperature value for this IP */
> -       priv->tempres =3D priv->fields[LAST_TEMP_0].msb - priv->fields[LA=
ST_TEMP_0].lsb;
> -
> -       for (i =3D 0, j =3D VALID_0; i < priv->feat->max_sensors; i++, j+=
+) {
> -               priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
> -                                                     priv->fields[j]);
> -               if (IS_ERR(priv->rf[j])) {
> -                       ret =3D PTR_ERR(priv->rf[j]);
> -                       goto err_put_device;
> +       /* This loop might need changes if enum regfield_ids is reordered=
 */
> +       for (j =3D LAST_TEMP_0; j <=3D UP_THRESH_15; j +=3D 16) {
> +               for (i =3D 0; i < priv->feat->max_sensors; i++) {
> +                       int idx =3D j + i;
> +
> +                       priv->rf[idx] =3D devm_regmap_field_alloc(dev, pr=
iv->tm_map,
> +                                                               priv->fie=
lds[idx]);
> +                       if (IS_ERR(priv->rf[idx])) {
> +                               ret =3D PTR_ERR(priv->rf[idx]);
> +                               goto err_put_device;
> +                       }
>                 }
>         }
> +       /* Save away resolution of signed temperature value for this IP */
> +       priv->tempres =3D priv->fields[LAST_TEMP_0].msb - priv->fields[LA=
ST_TEMP_0].lsb;

Leave this where it was, i.e. before the for loop? Or is that a bug and
it doesn't actually work unless it's after the for loop? In which case,
this should go to the previous patch.

> =20
> +       spin_lock_init(&priv->ul_lock);
> +       tsens_enable_irq(priv);
>         tsens_debug_init(op);
> =20
>         return 0;
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 772aa76b50e12..a4335717aeede 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -96,7 +99,33 @@ static int tsens_register(struct tsens_priv *priv)
>                 if (priv->ops->enable)
>                         priv->ops->enable(priv, i);
>         }
> +
> +       pdev =3D of_find_device_by_node(priv->dev->of_node);
> +       if (!pdev) {
> +               dev_err(&pdev->dev, "%s: device node not found in DT\n", =
__func__);

Do we really need this? Maybe just bail out in silence because this
should never happen?

> +               return -ENODEV;
> +       }
> +
> +       irq =3D platform_get_irq_byname(pdev, "uplow");
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "%s: missing irq in dt: uplow\n", __f=
unc__);

You can drop the error print. I upstreamed a change to print the error
generically in the core.

> +               return irq;

Did we need to put_device() here?

> +       }
> +
> +       ret =3D devm_request_threaded_irq(&pdev->dev, irq,
> +                                       NULL, tsens_irq_thread,
> +                                       IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +                                       dev_name(&pdev->dev), priv);
> +       if (ret) {
> +               dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
> +               goto err_put_device;
> +       }
> +       enable_irq_wake(irq);
>         return 0;
> +
> +err_put_device:
> +       put_device(&pdev->dev);
> +       return ret;
