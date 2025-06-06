Return-Path: <linux-pm+bounces-28199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D02AD0148
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15282175EBF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA62882C9;
	Fri,  6 Jun 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yr0VC8AM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402620330
	for <linux-pm@vger.kernel.org>; Fri,  6 Jun 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210039; cv=none; b=K/MkRNaFDWiWqU79hmJPDF1zZfTIPggc5sVVEjFNtZX4z6IzTl9yoZRPyfPwEy+7jhGuijCsJSRvgHZolSUV02VObiYfP26jxhaOO2OYHuni7H/HMEwbS0EbWNtkwfGnxOHQCulZFLURnerix1B1KtfiSuz8RmtUtHdxHWM0QJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210039; c=relaxed/simple;
	bh=9JAv+lsJK+UUVnLtRy4m0/3CjekfbABM/4Za5oCwU68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktyDnjL5LZ892qFNsYbW//c6Z0xiTn0wRLDQK3tt5OXYqGsWA6rMqwReF0P5mpiP05/i9AXeGNkO6wqHNR9UY5ML7f46f++/JE1Zj6SJgmP27QSUwtsEeLpF8dindgh1TOqshDQGAeJ4UBemXRf1y5bmCYzKjVCE46gIs/uymmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yr0VC8AM; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60bef8e7bb3so1036761eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Jun 2025 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749210035; x=1749814835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqaoojFiVes+ZO0jsy6RpLFdw7INbC2+V4FCCgGkvIo=;
        b=yr0VC8AMvDwf8IRxleciWqBpy1Ral0XCYQg58dJXQ0ug/2+YZQI+X8DusDEaAJfCcW
         aVdX5zhOVs2BBb5iuvoDJkAh7sSXX2O6mBwTFYo4BG2hmcGmoBR96eOS0BOwj2hvu/79
         mcYGz0ZLPsA9dZJz0v+lYsXTb4bE/S7yTvoALA6OI1ar1CS2xSKusIJuCCmsWQTZozkm
         wDOw23dVL0DkV3FugZkVBMwLMbtO9+C5cnmqWh9RgODog6tw0BtI+cGXKj/3MIk8qxyi
         xolLvI691stmJweFvhGxsv40HRmz9hCB4hRHeeN0KBGsHWbpCSOHK1UBg4f7yhtgwpvt
         OvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749210035; x=1749814835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqaoojFiVes+ZO0jsy6RpLFdw7INbC2+V4FCCgGkvIo=;
        b=rlkVy7541thouX/hYvIqmEa+EYKt0J6bbUqSb2mv9NyOfrucsg4q4LMc8dQ86LWKbT
         n3TLUCskW5jQaK6/15+jDSpiPk6LBtePwVD/b5xV4ntNEiVKIb8HTkzXK5ljdNhfLaXo
         eoFJo0KiarzU2ORnF5/V09HZzmWqPv/FLOGwxoVrePt/R4tE8y3YlROu6G6dSV98xSBT
         7++I2CGZYHGAe7gShWqyRhDhGuYkR3fFLC+1MF9Xbq0ulkjUCkMKLtw/HN0UaN+yY+Xf
         fSa791QqlM/DdlmViajwyCd0OXPZ1QE9nYyaIolOx9MJuEcON1FAueqye5/r5tUDE1Em
         iz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4AI02IiKeTWZsB76bgti1ZDufqoUYCTVvUrBwMyhctE5YQCxcaYrNQTlcmdjX3xyzbEa3yy/Mag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYIlXl/c6YoJCPkKvrbpsI6x6Y3Fs8Puwvvc6SFQESkJWAusO
	vV1eRcmGP6AV9HuXYjzYQxkCQyPntdRVQaL4E9VjHCGzWRbbKuWiaHTqxsARIf0dXi9NUpMnYTU
	PbEJq3yT3PzqgvkcxE1X/7Yvv97SY0GhqNSunzGVM1g==
X-Gm-Gg: ASbGncu1UJoka91fb8ysUNuKRU28hPc9At2cHHQbFURtoD3qdvXLV+Jk0LA37Y05Vfl
	v+22AkhKWq541LiiUgbSUdvq84c4LkIuzVOJpfEDlvp/cnSP73e/f8l5jJFpRWPao4ruRzH4NUl
	sfJjiF3LP2BuyyrupNqYDDAb2x+WR3YQkIvQ==
X-Google-Smtp-Source: AGHT+IGPaAGn9iQyMBJtFjG6VFBrTrEjl1SqdtOd+jkmmGGT5jvCC0aGOFstBgHykg8Ve8H76UnHvFuNqDfGC3ioIYM=
X-Received: by 2002:a05:6820:2112:b0:60b:b134:a1 with SMTP id
 006d021491bc7-60f3cf2e2c5mr1700381eaf.6.1749210034900; Fri, 06 Jun 2025
 04:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be> <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-2-b49904e35a34@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 6 Jun 2025 12:40:23 +0100
X-Gm-Features: AX0GCFuEetRBi0jDLFg0Uft93KobL6YT9ud-De2FOwUUfLokKDe78RZcyXziMWE
Message-ID: <CADrjBPqOMOyHP=aQ1+fg2X58NWRp-=MJBRZfpbEhQsTzaZ9LHw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] power: supply: add support for max77759 fuel gauge
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Thanks for your patch and working to get fuel gauge functional on
Pixel 6! I've tried to do quite an in-depth review comparing with the
downstream driver.

On Fri, 23 May 2025 at 13:52, Thomas Antoine via B4 Relay
<devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>
> From: Thomas Antoine <t.antoine@uclouvain.be>
>
> The interface of the Maxim MAX77759 fuel gauge has a lot of common with t=
he
> Maxim MAX1720x. A major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.
>
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c3=
6bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>
> Other differences include the lack of V_BATT register to read the battery
> level. The voltage must instead be read from V_CELL, the lowest voltage o=
f
> all cells. The mask to identify the chip is different. The computation of
> the charge must also be changed to take into account TASKPERIOD, which
> can add a factor 2 to the result.
>
> Add support for the MAX77759 by taking into account all of those
> differences based on chip type.
>
> Do not advertise temp probes using the non-volatile memory as those are
> not available.
>
> The regmap was proposed by Andr=C3=A9 Draszik in
>
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a11=
6.camel@linaro.org/

I think it would be worth noting in the commit message this is basic
initial support for the M5 gauge in MAX77759, and things like loading
& saving the m5 model aren't implemented yet.

That's important as some values such as the REPSOC register value used
for POWER_SUPPLY_PROP_CAPACITY show the result after all processing
including ModelGauge mixing etc, so these values won't be as accurate
as downstream.

>
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---
>  drivers/power/supply/max1720x_battery.c | 265 ++++++++++++++++++++++++++=
++----
>  1 file changed, 238 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supp=
ly/max1720x_battery.c
> index 68b5314ecf3a234f906ec8fe400e586855b69cd9..c9ad452ada9d0a2a51f37d04f=
d8c3260be522405 100644
> --- a/drivers/power/supply/max1720x_battery.c
> +++ b/drivers/power/supply/max1720x_battery.c
> @@ -37,6 +37,7 @@
>  #define MAX172XX_REPCAP                        0x05    /* Average capaci=
ty */
>  #define MAX172XX_REPSOC                        0x06    /* Percentage of =
charge */
>  #define MAX172XX_TEMP                  0x08    /* Temperature */
> +#define MAX172XX_VCELL                 0x09    /* Lowest cell voltage */
>  #define MAX172XX_CURRENT               0x0A    /* Actual current */
>  #define MAX172XX_AVG_CURRENT           0x0B    /* Average current */
>  #define MAX172XX_FULL_CAP              0x10    /* Calculated full capaci=
ty */
> @@ -54,15 +55,28 @@
>  #define MAX172XX_BATT                  0xDA    /* Battery voltage */
>  #define MAX172XX_ATAVCAP               0xDF
>
> +#define MAX77759_DEV_NAME_TYPE_MASK    GENMASK(15, 9)
> +#define MAX77759_DEV_NAME_TYPE_MAX77759        0x31
> +#define MAX77759_TASKPERIOD            0x3C
> +#define MAX77759_TASKPERIOD_175MS      0x1680
> +#define MAX77759_TASKPERIOD_351MS      0x2D00
> +
>  static const char *const max1720x_manufacturer =3D "Maxim Integrated";
>  static const char *const max17201_model =3D "MAX17201";
>  static const char *const max17205_model =3D "MAX17205";
> +static const char *const max77759_model =3D "MAX77759";
> +
> +enum chip_id {
> +       MAX1720X_ID,
> +       MAX77759_ID,
> +};
>
>  struct max1720x_device_info {
>         struct regmap *regmap;
>         struct regmap *regmap_nv;
>         struct i2c_client *ancillary;
>         int rsense;
> +       enum chip_id id;
>  };
>
>  /*
> @@ -271,6 +285,80 @@ static const enum power_supply_property max1720x_bat=
tery_props[] =3D {
>         POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>
> +/*
> + * Registers 0x80 up to 0xaf which contain the model for the fuel gauge
> + * algorithm (stored in nvmem for the max1720x) are locked. They can
> + * be unlocked by writing 0x59 to 0x62 and 0xc4 to 0x63. They should be
> + * enabled in the regmap if the driver is extended to manage the model.
> + */
> +static const struct regmap_range max77759_registers[] =3D {
> +       regmap_reg_range(0x00, 0x4f),
> +       regmap_reg_range(0xb0, 0xbf),
> +       regmap_reg_range(0xd0, 0xd0),
> +       regmap_reg_range(0xdc, 0xdf),
> +       regmap_reg_range(0xfb, 0xfb),
> +       regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_range max77759_ro_registers[] =3D {
> +       regmap_reg_range(0x3d, 0x3d),
> +       regmap_reg_range(0xfb, 0xfb),
> +       regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_access_table max77759_write_table =3D {
> +       .no_ranges =3D max77759_ro_registers,
> +       .n_no_ranges =3D ARRAY_SIZE(max77759_ro_registers),
> +};
> +
> +static const struct regmap_access_table max77759_rd_table =3D {
> +       .yes_ranges =3D max77759_registers,
> +       .n_yes_ranges =3D ARRAY_SIZE(max77759_registers),
> +};
> +
> +static const struct regmap_config max77759_regmap_cfg =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 16,
> +       .max_register =3D 0xff,
> +       .wr_table =3D &max77759_write_table,
> +       .rd_table =3D &max77759_rd_table,
> +       .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +       .cache_type =3D REGCACHE_NONE,
> +};
> +
> +static const enum power_supply_property max77759_battery_props[] =3D {
> +       POWER_SUPPLY_PROP_PRESENT,

I checked the register values match downstream - this looks correct

> +       POWER_SUPPLY_PROP_CAPACITY,

I checked the register offset matchs downstream. The value reported
varies a bit versus downstream. As mentioned above that is likely due
to the REPSOC register reporting after mixing with the m5 model which
is not loaded currently. Also the application specific values and cell
characterization information used by the model isn't configured
currently (see link below in _TEMP property below for the initial fuel
gauge params used by downstream.

> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,

I checked the register offset matchs downstream. Values reported look sensi=
ble.

> +       POWER_SUPPLY_PROP_CHARGE_FULL,

Downstream has a slightly different implementation than upstream for
this property. See here
https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef4745=
73cc8629cc1d121eb6a81ab68c/max1720x_battery.c#2244

> +       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,

I checked the register offset value is correct. However this is
reporting 3000000 and downstream reports 4524000. I checked and it's
just converting the register reset value of DESIGNCAP which is 0xbb8.

This is listed as a "application specific" value, so it maybe we just
need to write the correct initial value to DESIGNCAP (see TEMP section
below)


> +       POWER_SUPPLY_PROP_CHARGE_AVG,

This property isn't reported downstream. The value is changing and not
just the reset value. I noticed REPSOC is an output of the ModelGauge
algorithm so it is likely not to be completely accurate.

> +       POWER_SUPPLY_PROP_TEMP,

I checked the register offset value is correct. However the
temperature is always being reported as the register reset value of
220. This is for obvious reasons quite an important one to report
correctly.

I started debugging this a bit, and it is caused by an incorrectly
configured CONFIG (0x1D) register. In particular the TEX[8] bit is 1
on reset in this register which means temperature measurements are
written from the host AP. When this bit is set to 0, measurements on
the AIN pin are converted to a temperature value and stored in the
Temperature register (I then saw values of 360 and the value
changing).

See here for the bits in that CONFIG register
https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef4745=
73cc8629cc1d121eb6a81ab68c/max_m5_reg.h#403

In downstream all these initial register settings are taken from DT
here  https://android.googlesource.com/kernel/google-modules/raviole-device=
/+/refs/heads/android14-gs-pixel-6.1/arch/arm64/boot/dts/google/gs101-fake-=
battery-data.dtsi#27

For temperature when TEX=3D0, TGAIN, TOFF and TCURVE registers should
also be configured to adjust the temperature measurement.

I think it would likely be worth initialising all the fuel gauge
registers referenced in maxim,fg-params as that includes some of the
application specific values for DESIGNCAP, also some of the cell
characterization information, and hopefully we will get more accurate
values from the fuel gauge generally.

> +       POWER_SUPPLY_PROP_CURRENT_NOW,

I checked the register offset matches downstream. Values reported look
reasonable.

> +       POWER_SUPPLY_PROP_CURRENT_AVG,

I checked the register offset matches downstream. Values reported look
reasonable.

> +       POWER_SUPPLY_PROP_MODEL_NAME,

This property isn't reported downstream.

> +       POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +
> +struct chip_data {
> +       bool has_nvmem;
> +       const struct regmap_config *regmap_cfg;
> +       enum chip_id id;
> +};
> +
> +static const struct chip_data max1720x_data  =3D {
> +       .has_nvmem =3D true,
> +       .regmap_cfg =3D &max1720x_regmap_cfg,
> +       .id =3D MAX1720X_ID,
> +};
> +
> +static const struct chip_data max77759_data =3D {
> +       .has_nvmem =3D false,
> +       .regmap_cfg =3D &max77759_regmap_cfg,
> +       .id =3D MAX77759_ID,
> +};
> +
>  /* Convert regs value to power_supply units */
>
>  static int max172xx_time_to_ps(unsigned int reg)
> @@ -288,12 +376,41 @@ static int max172xx_voltage_to_ps(unsigned int reg)
>         return reg * 1250;      /* in uV */
>  }
>
> +static int max172xx_cell_voltage_to_ps(unsigned int reg)
> +{
> +       return reg * 625 / 8;   /* in uV */
> +}
> +
>  static int max172xx_capacity_to_ps(unsigned int reg,
>                                    struct max1720x_device_info *info)
>  {
>         return reg * (500000 / info->rsense);   /* in uAh */
>  }
>
> +static int max77759_capacity_lsb(struct max1720x_device_info *info,
> +                                unsigned int *lsb)
> +{
> +       unsigned int reg_task_period;
> +       int ret;
> +
> +       ret =3D regmap_read(info->regmap, MAX77759_TASKPERIOD, &reg_task_=
period);
> +       if (ret < 0)
> +               return ret;
> +
> +       switch (reg_task_period) {
> +       case MAX77759_TASKPERIOD_175MS:
> +               *lsb =3D 1;
> +               break;
> +       case MAX77759_TASKPERIOD_351MS:
> +               *lsb =3D 2;
> +               break;
> +       default:
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Current and temperature is signed values, so unsigned regs
>   * value must be converted to signed type
> @@ -390,16 +507,36 @@ static int max1720x_battery_get_property(struct pow=
er_supply *psy,
>                 val->intval =3D max172xx_percent_to_ps(reg_val);
>                 break;
>         case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -               ret =3D regmap_read(info->regmap, MAX172XX_BATT, &reg_val=
);
> -               val->intval =3D max172xx_voltage_to_ps(reg_val);
> +               if (info->id =3D=3D MAX1720X_ID) {
> +                       ret =3D regmap_read(info->regmap, MAX172XX_BATT, =
&reg_val);
> +                       val->intval =3D max172xx_voltage_to_ps(reg_val);

I think MAX1720X using MAX172XX_BATT register is likely a bug as the
downstream driver uses MAX172XX_VCELL for that variant  see here
https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef4745=
73cc8629cc1d121eb6a81ab68c/max1720x.h#304

Having said that, if we do need to cope with differing register
offsets for the different fuel gauge variants it would be nicer to
abstract them in a way similar to the downstream driver. See here
https://android.googlesource.com/kernel/google-modules/bms/+/1a68c36bef4745=
73cc8629cc1d121eb6a81ab68c/max_m5.c#1235.
I think that would be more scalable in supporting multiple variants in
one driver. Otherwise we will have an explosion of if(id=3D=3Dblah) else
if (id=3D=3Dblah) in the driver.

kind regards,

Peter

