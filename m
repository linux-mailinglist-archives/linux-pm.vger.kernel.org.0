Return-Path: <linux-pm+bounces-36055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E38BD8BDC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F93E4FA2E8
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C542F6571;
	Tue, 14 Oct 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsp+xi37"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6E2F5468
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437407; cv=none; b=chwYeeH325JzjeNguafdcb/zwkzW/kq5jopcKofo9H/PwpR+zPyXF4hjJJBsI4IEq46VT05QWBaPu2vIfglFRdHn02cAzUkC/LFTL4jd/MoD0Z1vdcfdqDWd+ONDdm1NwvxqzoHHx9bvZrHV4rbvq9CA6OiD88MshwbELkj+7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437407; c=relaxed/simple;
	bh=HBeoLSxpTUhB5k5FsVkrCIB6ViDWGKvUTXafr91NmxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwvXzh48P+d4uJtvi5A1m1yHGdj0PG7WyjypAVlhnpXPg0IML8hVEVGkj1RXL8Q4Gz5PyCrV+rScjmhElVV3DJsgdjfRgK9i6+5r1NFKws9l0YZtfrQEENLgs0XFh2eZ1uv/HlfAcOme4r1NUGEHlPBP5RXTyMDGPxY0hYVy2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsp+xi37; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6353ff1a78dso4835735d50.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760437404; x=1761042204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NSrWOSqSz9iedx0CTd4FBgAAcUOjskBzS2cIVqq5D4=;
        b=wsp+xi37UYTi8l5a1JzKzq22tfgPsi8wJ+rUabCdC1uw0rzTsorG1NElfng4FXqkVn
         kSVaRv1rs2ux5mEKCju/LvpWvuF4WiqjBC+tWNumSG10RxrT6mtRtykfDkUMXiFIfhhj
         Ren8BkTj5hYLnq1Q+ttCCI+QZ4wio/sLVAGKAF6NsE16EeRQ3NamYXmwrMvdneR1RCWD
         fGlmNXccxiyDbbogDHt88nIPtT4sNi5AFQ9xnDS0l+eyvRt1vnZVBPsAWVCvhZbVoYa2
         95MmZWiDNX8kish8JFxUdEGujB2DG/cxejRG+yoPWcHZaEl0vM5p0S78PPFaRT+tpw7I
         k+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437404; x=1761042204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NSrWOSqSz9iedx0CTd4FBgAAcUOjskBzS2cIVqq5D4=;
        b=HfEq9q+ElaF3gYHVqi5y5AqSqFoxn3QYnOZRM5aCZkqDlmrq+4eT4DtVvMYZyynXDs
         1ZI9WtsImuN6r553b7akhlpL3TOUdEWNxCsnXXc3auXvNLTXqWFMj65E6woJo9ZuI/WR
         gkhTBfq+/9DePcTQgpSWQ6B77Q+VFhfrRrCa/pQFthVZe289fKoCxV2Hyw0UOLunzVz9
         iJ3k8/2CjOb2JNxt0wt5lZTfS2uDH5uUetzFwRHgt+KJH/FB9yc5fbezUGwCn3eorQw4
         VgetaYKqUb4++wjroYE0rLLLAAd0fs46xr0DXxQtO6LaCW8av264maAPqw4hE9738TZC
         C6ag==
X-Forwarded-Encrypted: i=1; AJvYcCUw8DYRp4HfxapC2vBVxYqvxAevHg71D9nISbZe8kqXnnefmpTC5YZZ8pTtfCbDT9zu6eVQxVpaZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw9ZO1hnf4u7g0OBOioBUueajSab5hz0z5/nyZMoUGuwpZvONX
	ynDAbffyYJlfIiXjI/AIjdMRaggyl8GlhoNZHtiMDvFiuPOgfreZl9+qcc5VxUWUd3hWkwRWmvo
	U0eE2Wj2Vf5PshPRk0PDmM5h9Eo0CwqRZb+Tg1Pp8V0SIkzh3G+VrZyQ=
X-Gm-Gg: ASbGncvCl+lBKzAXsC3gKwEVwFIl3CyGJWee6+U7UnjboH8wcGqCr9sp6kF97QNscJR
	qVDSz7UzjodNepg7MtQVmqTZYJcoCdJO8V3h0Al0begwBah2O25zrERpqkmJK5P1warXEChEgoF
	+hc3+B1MRUKdzDns7oK8T1lyn/WkRfrcwqnFeuSIjBFpL/w/LmAtWUJ0m5NELCI7KkXExFNX/wn
	XlqcnrNAknFnm+WvX/GdG7ZtFCjMg==
X-Google-Smtp-Source: AGHT+IGX7pWJReynN7jgaMlmfnmPBVJaIc8aQG0hFCcA9poFMAny2m2Orf6s2pNDMLHxkaG9c0y1HL8Su4Eo2yMxogY=
X-Received: by 2002:a53:ac49:0:b0:63c:e72f:d354 with SMTP id
 956f58d0204a3-63ce72fd63cmr12181584d50.22.1760437404038; Tue, 14 Oct 2025
 03:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_DAD6E4E85F79FDC4DF2878B03940CA337108@qq.com>
In-Reply-To: <tencent_DAD6E4E85F79FDC4DF2878B03940CA337108@qq.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 12:23:07 +0200
X-Gm-Features: AS18NWCoMb5XDlmenFa0xGITZP61fGGQfLpt-glaoPxcSHEPwEjlMrE6klD2W9U
Message-ID: <CACRpkda833CiwA+ihMLm6zzTFsoCMFoesbAVrW7EMA0-vGFTFQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Add SC8541 charger drivers
To: 1647395606@qq.com
Cc: sre@kernel.org, brgl@bgdev.pl, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	wangwenqiang <wenqiang.wang@faiot.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wang,

thanks for your patch!

On Mon, Oct 13, 2025 at 10:54=E2=80=AFAM <1647395606@qq.com> wrote:

> From: wangwenqiang <wenqiang.wang@faiot.com>
>
> The SC8541 is a charger pump from South Chip.
> By adjusting the voltage difference between the input and output terminal=
s,
> it can achieve a maximum charging current of 8A.
> It has been verified that this driver can operate normally on the Qualcom=
m QCS615 platform.
>
> Signed-off-by: wangwenqiang <wenqiang.wang@faiot.com>

(...)
> +#include <linux/gpio.h>

Don't use this legacy API, include <linux/gpio/consumer.h> if you need
to use GPIO lines and use GPIO descriptors.

> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/kthread.h>

Are you using sched.h and thread.h really?
You are using threaded interrupt handlers but that is
not coming from this file but interrupt.h.

> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>

Don't use this legacy API either, use <linux/gpio/consumer.h>

> +#include <linux/err.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/regulator/machine.h>

I don't think you're defining regulator machines either.

> +#include <linux/debugfs.h>
> +#include <linux/bitops.h>
> +#include <linux/math64.h>
> +#include <linux/regmap.h>

Please go over the includes and make sure you only include the ones
you really need.

> +#define SC8541_DRV_VERSION              "1.0.0_G"

I would just drop this, we don't use these kind of strings much these days.

> +struct flag_bit {
> +    int notify;
> +    int mask;
> +    char *name;
> +};
> +
> +struct intr_flag {
> +    int reg;
> +    int len;
> +    struct flag_bit bit[8];
> +};

Are these things such as notify, mask, reg, len really int?
Aren't they better as u32?

> +struct reg_range {
> +    u32 min;
> +    u32 max;
> +    u32 step;
> +    u32 offset;
> +    const u32 *table;
> +    u16 num_table;
> +    bool round_up;
> +};

Here is some nice use of proper types!

> +static const struct regmap_config sc8541_regmap_config =3D {
> +    .reg_bits =3D 8,
> +    .val_bits =3D 8,
> +
> +    .max_register =3D SC8541_REGMAX,
> +};

Nice use of regmap.

> +struct sc8541_chip {
> +    struct device *dev;
> +    struct i2c_client *client;
> +    struct regmap *regmap;
> +    struct regmap_field *rmap_fields[F_MAX_FIELDS];
> +
> +    struct sc8541_cfg_e cfg;
> +    int irq_gpio;
> +    int irq;
> +
> +    int mode;
> +
> +    bool charge_enabled;
> +    int usb_present;
> +    int vbus_volt;
> +    int ibus_curr;
> +    int vbat_volt;
> +    int ibat_curr;
> +    int die_temp;

Can all of these really be negative? Otherwise use unsigned int.
I guess the die_temp should be int because it could be negative.

> +/********************COMMON API***********************/

Drop these headers, we can see it is a common API anyway.

> +__maybe_unused static u8 val2reg(enum sc8541_reg_range id, u32 val)
> +{
> +    int i;
> +    u8 reg;
> +    const struct reg_range *range =3D &sc8541_reg_range[id];
> +
> +    if (!range)
> +       return val;
> +
> +    if (range->table) {
> +       if (val <=3D range->table[0])
> +           return 0;
> +       for (i =3D 1; i < range->num_table - 1; i++) {
> +           if (val =3D=3D range->table[i])
> +               return i;
> +           if (val > range->table[i] &&
> +               val < range->table[i + 1])
> +               return range->round_up ? i + 1 : i;
> +       }
> +       return range->num_table - 1;
> +    }
> +    if (val <=3D range->min)
> +       reg =3D 0;
> +    else if (val >=3D range->max)
> +       reg =3D (range->max - range->offset) / range->step;
> +    else if (range->round_up)
> +       reg =3D (val - range->offset) / range->step + 1;
> +    else
> +       reg =3D (val - range->offset) / range->step;
> +    return reg;
> +}

Add some description of what the function is doing, it's hard
to understand, kerneldoc please.

> +__maybe_unused static u32 reg2val(enum sc8541_reg_range id, u8 reg)
> +{
> +    const struct reg_range *range =3D &sc8541_reg_range[id];
> +
> +    if (!range)
> +       return reg;
> +    return range->table ? range->table[reg] :
> +                 range->offset + range->step * reg;
> +}

Same here.

> +static int sc8541_field_read(struct sc8541_chip *sc,
> +               enum sc8541_fields field_id, int *val)
> +{
> +    int ret;
> +
> +    ret =3D regmap_field_read(sc->rmap_fields[field_id], val);
> +    if (ret < 0) {
> +       dev_err(sc->dev, "sc8541 read field %d fail: %d\n", field_id, ret=
);
> +    }
> +
> +    return ret;
> +}
> +
> +static int sc8541_field_write(struct sc8541_chip *sc,
> +               enum sc8541_fields field_id, int val)
> +{
> +    int ret;
> +
> +    ret =3D regmap_field_write(sc->rmap_fields[field_id], val);
> +    if (ret < 0) {
> +       dev_err(sc->dev, "sc8541 read field %d fail: %d\n", field_id, ret=
);
> +    }
> +
> +    return ret;
> +}
> +
> +static int sc8541_read_block(struct sc8541_chip *sc,
> +               int reg, uint8_t *val, int len)
> +{
> +    int ret;
> +
> +    ret =3D regmap_bulk_read(sc->regmap, reg, val, len);
> +    if (ret < 0) {
> +       dev_err(sc->dev, "sc8541 read %02x block failed %d\n", reg, ret);
> +    }
> +
> +    return ret;
> +}

Does these three indirections really but you something? You just need to
handle the returned ret once more in the code. Isn't it better to just use
regmap_* field etc directly and report errors in the code.

> +__maybe_unused static int sc8541_reg_reset(struct sc8541_chip *sc)
> +{
> +    return sc8541_field_write(sc, REG_RST, 1);
> +}
> +
> +__maybe_unused static int sc8541_dump_reg(struct sc8541_chip *sc)
> +{
> +    int ret;
> +    int i;
> +    int val;
> +
> +    for (i =3D 0; i <=3D SC8541_REGMAX; i++) {
> +       ret =3D regmap_read(sc->regmap, i, &val);
> +       dev_err(sc->dev, "%s reg[0x%02x] =3D 0x%02x\n",
> +               __func__, i, val);
> +    }
> +
> +    return ret;
> +}
> +
> +__maybe_unused static int sc8541_enable_charge(struct sc8541_chip *sc, b=
ool en)
> +{
> +    int ret;
> +
> +    dev_info(sc->dev, "%s:%d", __func__, en);
> +
> +    ret =3D sc8541_field_write(sc, CHG_EN, !!en);
> +
> +    return ret;
> +}
> +
> +
> +__maybe_unused static int sc8541_check_charge_enabled(struct sc8541_chip=
 *sc, bool *enabled)
> +{
> +    int ret, val;
> +
> +    ret =3D sc8541_field_read(sc, CP_SWITCHING_STAT, &val);
> +
> +    *enabled =3D (bool)val;
> +
> +    dev_info(sc->dev, "%s:%d", __func__, val);
> +
> +    return ret;
> +}
> +
> +__maybe_unused static int sc8541_get_status(struct sc8541_chip *sc, uint=
32_t *status)
> +{
> +    int ret, val;
> +    *status =3D 0;
> +
> +    ret =3D sc8541_field_read(sc, VBUS_ERRORHI_STAT, &val);
> +    if (ret < 0) {
> +       dev_err(sc->dev, "%s fail to read VBUS_ERRORHI_STAT(%d)\n", __fun=
c__, ret);
> +       return ret;
> +    }
> +    if (val !=3D 0)
> +       *status |=3D BIT(ERROR_VBUS_HIGH);
> +
> +    ret =3D sc8541_field_read(sc, VBUS_ERRORLO_STAT, &val);
> +    if (ret < 0) {
> +       dev_err(sc->dev, "%s fail to read VBUS_ERRORLO_STAT(%d)\n", __fun=
c__, ret);
> +       return ret;
> +    }
> +    if (val !=3D 0)
> +       *status |=3D BIT(ERROR_VBUS_LOW);
> +
> +
> +    return ret;
> +
> +}
> +
> +__maybe_unused static int sc8541_enable_adc(struct sc8541_chip *sc, bool=
 en)
> +{
> +    dev_info(sc->dev, "%s:%d", __func__, en);
> +    return sc8541_field_write(sc, ADC_EN, !!en);
> +}
> +
> +__maybe_unused static int sc8541_set_adc_scanrate(struct sc8541_chip *sc=
, bool oneshot)
> +{
> +    dev_info(sc->dev, "%s:%d", __func__, oneshot);
> +    return sc8541_field_write(sc, ADC_RATE, !!oneshot);
> +}

This overuse of __maybe_unused means you are potentially
compiling in a lot of crap that will not be used.

Consider using static inline in a .h file instead, then they will
just not be compiled if not used.

> +__maybe_unused static int sc8541_disable_vbusovp_alarm(struct sc8541_chi=
p *sc, bool en)
> +{
> +    int ret;
> +
> +    dev_info(sc->dev, "%s:%d", __func__, en);

Convert all these to dev_debug() to not litter the log.

> +
> +    ret =3D sc8541_field_write(sc, VBUS_OVP_ALM_DIS, !!en);
> +
> +    return ret;
> +}

This kind of functions also look like unnecessary indirection to me
but at least rewrite them like this:

return sc8541_field_write(sc, VBUS_OVP_ALM_DIS, !!en);

and it saves you 4-5 lines of code in each functions ince you don't
need to declare ret and return it on a separate line.

> +static int mtk_sc8541_set_vbusovp(struct charger_device *chg_dev, u32 uV=
)
> +{
> +    struct sc8541_chip *sc =3D charger_get_data(chg_dev);
> +    int mv;
> +
> +    mv =3D uV / 1000;

If this is coming from an IIO ADC you can use the existing prescaler
in IIO instead.

ret =3D iio_read_channel_processed_scale(adc_main_charger_v,
                                                       &vch, 1000);

Otherwise, maybe your ADC  *should* be an IIO device, hm?

> +static int mtk_sc8541_get_adc(struct charger_device *chg_dev, enum adc_c=
hannel chan,
> +                         int *min, int *max)
> +{
> +    struct sc8541_chip *sc =3D charger_get_data(chg_dev);
> +
> +    sc8541_get_adc_data(sc, to_sc8541_adc(chan), max);
> +
> +    if (chan !=3D ADC_CHANNEL_TEMP_JC)
> +       *max =3D *max * 1000;
> +
> +    if (min !=3D max)
> +               *min =3D *max;
> +
> +    return 0;
> +}
> +
> +static int mtk_sc8541_get_adc_accuracy(struct charger_device *chg_dev,
> +                                  enum adc_channel chan, int *min, int *=
max)
> +{
> +    *min =3D *max =3D sc8541_adc_accuracy_tbl[to_sc8541_adc(chan)];
> +    return 0;
> +}

Yeah this looks like this part of the driver should be in
drivers/iio/adc/*

> +static int sc8541_register_interrupt(struct sc8541_chip *sc)
> +{
> +    int ret;
> +
> +    if (gpio_is_valid(sc->irq_gpio)) {
> +       ret =3D gpio_request_one(sc->irq_gpio, GPIOF_IN, "sc8541_irq");
> +       if (ret) {
> +            dev_err(sc->dev, "failed to request sc8541_irq\n");
> +           return -EINVAL;
> +       }
> +       sc->irq =3D gpio_to_irq(sc->irq_gpio);
> +       if (sc->irq < 0) {
> +            dev_err(sc->dev, "failed to gpio_to_irq\n");
> +           return -EINVAL;
> +       }

NACK do not use these old GPIO APIs.

Use devm_gpiod_get() instead.

Just grep in the kernel for many good examples of how to
do this:

struct gpio_desc *gd =3D devm_gpiod_get(dev, "irq", GPIOD_IN);
int irq =3D gpiod_to_irq(gd);
(etc)

> +    if (sc->irq) {
> +       ret =3D devm_request_threaded_irq(&sc->client->dev, sc->irq,
> +               NULL, sc8541_irq_handler,
> +               IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +               sc8541_irq_name[sc->mode], sc);
> +
> +       if (ret < 0) {
> +            dev_err(sc->dev, "request irq for irq=3D%d failed, ret =3D%d=
\n",
> +                           sc->irq, ret);
> +           return ret;
> +       }
> +       enable_irq_wake(sc->irq);

It's nice that you use threaded IRQs with oneshot!

> +static int sc8541_set_work_mode(struct sc8541_chip *sc, int mode)
> +{
> +    sc->mode =3D mode;
> +
> +    dev_err(sc->dev, "work mode is %s\n", sc->mode =3D=3D SC8541_STANDAL=
ONE
> +       ? "standalone" : (sc->mode =3D=3D SC8541_MASTER ? "master" : "sla=
ve"));

Why is this dev_err()?

It's not an error.

> +#ifdef CONFIG_PM_SLEEP
> +static int sc8541_suspend(struct device *dev)
> +{
> +    struct sc8541_chip *sc =3D dev_get_drvdata(dev);
> +
> +    dev_info(sc->dev, "Suspend successfully!");
> +    if (device_may_wakeup(dev))
> +       enable_irq_wake(sc->irq);
> +    disable_irq(sc->irq);
> +
> +    return 0;
> +}
> +static int sc8541_resume(struct device *dev)
> +{
> +    struct sc8541_chip *sc =3D dev_get_drvdata(dev);
> +
> +    dev_info(sc->dev, "Resume successfully!");
> +    if (device_may_wakeup(dev))
> +       disable_irq_wake(sc->irq);
> +    enable_irq(sc->irq);
> +
> +    return 0;
> +}
> +
> +static const struct dev_pm_ops sc8541_pm =3D {
> +    SET_SYSTEM_SLEEP_PM_OPS(sc8541_suspend, sc8541_resume)
> +};
> +#endif

IIRC there is a new API for this, look through recent changes to the
kernel concerning PM ops. I don't think you need the #ifdefs anymore.

> +MODULE_DESCRIPTION("SC SC8541 Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("South Chip <Aiden-yu@southchip.com>");

I think this is supposed to be a real person, not a function, can you
put in your own name and mail instead?

Yours,
Linus Walleij

