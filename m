Return-Path: <linux-pm+bounces-11316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8084939746
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 02:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4ED1F22477
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 00:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF3A31;
	Tue, 23 Jul 2024 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGRKYaW+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3367F
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692951; cv=none; b=G1mZjaB6BMosZwhz1ooLRDrl9hmuOZZS8rZXEEuS1NdRk1TU7pfOCHkwJre8heXwPIM8WKfoT8HoJzmx6kLYmRkyci4wWosw2Ffkxe6BPxhVmAsaxfGBbGvOZfe/x7fa1HNcJtgeShgDvXen0P7/PjC8FAOTtKm1GNIeLsiQLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692951; c=relaxed/simple;
	bh=vhjf08mbkj4INKoV7kY2CKVrz0EAYDmf1royEH39T4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QARogSopQ46JnGEzinxserV1hhgCL9+t/OoLdDWolb+qwfSd2Dlk1G7R0AblvcysjnAILRpnbR4PHQ/ige0XRHdWeelZ6eToMDBqUsCKSE2Ce4nTBAnY11ALzwjkSEQH5xEap90bP1s5L2qJryAdy9HXQ4mbiWdTV2aLKo0a39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGRKYaW+; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6678a45eaa3so46711977b3.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2024 17:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721692948; x=1722297748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHdT0nY+srvI4gjyCrkvE6Ta/xBloNN8P3uthZUAq7Q=;
        b=SGRKYaW+p/IHk9vn6vXqhH8ZfTy2jOXNiy6OThTi+T0uZ3OHq3hT68l+wGgF4v916A
         NRqlXR9D7Xm6wWKM99ODMpH2rTjDq0ghQ7bZraDbgLF3HlM0ZYoy3bjSKJFPVmzMEURv
         ZjM6tTAW1vHhVZQq2HJ/bN61tBZmryBeGO0HV9jp5uGVgeHhz+pVUWOXqpKAIgmwIu1o
         g2esP7x9l0URm/t7ox420SMDphtRZAzaYvbsU9BsjH44UTAh8x2MznIrnaPtLR+mN3Ry
         FfSkhceTbgtoNNDBPKVxTUBJh31kExt+i6nGVRfDQd8GBY8tWNhc3WcmcFx3xvn+T6yS
         rUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721692948; x=1722297748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHdT0nY+srvI4gjyCrkvE6Ta/xBloNN8P3uthZUAq7Q=;
        b=reQY9V4jOON8qlX5anSY/Rbv7q3mRaCM6tKUMJY1CcHGrHFH2JU9h6OH1GNvYWaiHO
         d/ICv7Diqi7qcv0BRjcDvc24kyvu/CqxdG/c83li0IZ0nMKznJl9TKfG6SuOF6bnL9BC
         B7m06HSuSYeRRTAZskZfHeMYCv1lh16yY0d6v2k3yR8t5oUkQeFr1W+bGtMcLwkFkbJw
         shvOzLau9J97CH39d8UuH0PrYPh5NpEo5HiVytdeVZ2CJ4xNlqzBuiBZjFuOX6DgXIJt
         btx3rb8XhUGXwu8DrDNxswCJdAQjmIEhbmn2jyVjpYsshuX5fI5uAgtF16KXuexUrhBO
         b2eg==
X-Gm-Message-State: AOJu0YwUYtLJ4FnWkMT6qwwgDsXSEVkITchAKE05jse7Iuo1hzVnOyXK
	qFO+iVV6kY/0qGd2GsjHjrtRKFspVdBJ7MtJXtnItqIkcKXKZNvi7Za9hXZ558S86cTgaUsSim6
	TKVu09E8/y+zNrYy0g2XAB+o9qqJjZ2qI6UFplg==
X-Google-Smtp-Source: AGHT+IHLIof1OMOBy91GVdpBWeeU3HO/VbU+jVbUE6NfXw24Kem4yq/cGajhacazi/09DgHnOPQrieibdqoiGU/z58Q=
X-Received: by 2002:a05:690c:4287:b0:65f:8afe:9ba6 with SMTP id
 00721157ae682-66ad88da3b3mr87089567b3.14.1721692947508; Mon, 22 Jul 2024
 17:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120948eucas1p13f3dc8f3aba56027da720d36c6057040@eucas1p1.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com> <20240719120853.1924771-6-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-6-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 19:02:16 -0500
Message-ID: <CAPLW+4n6XB3fm8KQA=6_2z8ay9pDPtu-VFgAaW5imZkRH2ywkg@mail.gmail.com>
Subject: Re: [PATCH 5/6] drivers/thermal/exynos: add initial Exynos 850 support
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:10=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> This is loosely adapted from an implementation available at
> https://gitlab.com/Linaro/96boards/e850-96/kernel/-/blob/android-exynos-4=
.14-linaro/drivers/thermal/samsung/exynos_tmu.c

Not sure if it's going to be helpful to you, but we also uploaded the
downstream k5.10 a while back, and it features a bit different TMU
driver implementation [1].

[1] https://gitlab.com/Linaro/96boards/e850-96/kernel/-/tree/android-exynos=
-5.10-linaro/drivers/thermal/samsung?ref_type=3Dheads

> Some differences from that implementation:
> - unlike that implementation, we do not use the ACPM mechanism, instead
>   we just access the registers, like we do for other SoCs,

Do you know what are the possible implications of not using ACPM? As I
understand, ACPM is a Samsung's downstream framework which uses APM
(Active Power Management) IP block internally to act as an IPC
mechanism, which makes it possible to offload any PM related
operations (which might get quite heavy, if we are to belive the TRM
description of APM) from CPU to APM. I'm not against the direct
registers access based implementation (in fact, I'm not sure how that
APM/ACPM thing can be implemented in upstreamable way and if it's
worth it at all). Just curious if we understand what we are
potentially missing out, and if at some point we'll be forced to
implement that ACPM thing anyway (for something else)?

> - the SoC is supposed to support multiple sensors inside one unit. The
>   vendor implementation uses one kernel device per sensor, we would
>   probably prefer to have one device for all sensors, have
>   #thermal-sensor-cells =3D <1> and so on. We implemented this, but we
>   could not get the extra sensors to work on our hardware so far. This
>   might be due to a misconfiguration and we will probably come back to
>   this, however our implementation only supports a single sensor for
>   now,
> - the vendor implementation supports disabling CPU cores as a cooling
>   device. We did not attempt to port this, and this would not really fit
>   this driver anyway.
>
> Additionally, some differences from the other SoCs supported by this
> driver:
> - this SoC does not require a clock to work correctly, so we need an
>   exception for data->clk,

Not sure if that's true, as already discussed in my comments for the
previous patches. Looks like one clock is still needed, which is the
PCLK bus clock (to interface registers) which might simultaneously act
as an operating (functional) clock.

> - we do not really constrain the e-fuse information like the other SoCs
>   do (data->{min,max}_efuse_value). In our tests, those values (as well
>   as the raw sensor values) were much higher than in the other SoCs, to
>   the degree that reusing the data->{min,max}_efuse_value from the other
>   SoCs would cause instant critical temperature reset on boot,
> - this SoC provides more information in the e-fuse data than other SoCs,
>   so we read some values inside exynos850_tmu_initialize instead of
>   hardcoding them in exynos_map_dt_data.
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 214 +++++++++++++++++++++++++--
>  1 file changed, 202 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index f0de72a62fd7..bd52663f1a5a 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -116,6 +116,43 @@
>  #define EXYNOS7_EMUL_DATA_SHIFT                        7
>  #define EXYNOS7_EMUL_DATA_MASK                 0x1ff
>
> +/* Exynos850 specific registers */
> +#define EXYNOS850_TMU_REG_AVG_CON              0x58

Exynos850 TRM says AVG_CONTROL offset is 0x38, and 0x58 is actually
for THRESHOLD0_TEMP_RISE3_2 register.

> +#define EXYNOS850_TMU_REG_CONTROL1             0x24
> +#define EXYNOS850_TMU_REG_COUNTER_VALUE0       0x30
> +#define EXYNOS850_TMU_REG_COUNTER_VALUE1       0x34
> +#define EXYNOS850_TMU_REG_CURRENT_TEMP1_0      0x40

In TRM, this register is called CURRENT_TEMP0_1. Maybe change 1_0 -> 0_1?

> +#define EXYNOS850_TMU_REG_THD_TEMP0_RISE       0x50
> +#define EXYNOS850_TMU_REG_THD_TEMP0_FALL       0x60
> +#define EXYNOS850_TMU_REG_TRIM0                        0x3C
> +
> +#define EXYNOS850_TMU_AVG_CON_SHIFT            18

Maybe rename it to something like EXYNOS850_TMU_T_AVG_MODE_SHIFT, to
avoid confusion with AVG_CONTROL register? That belongs to TRIMINFO2
register, if I understand it correctly, not to AVG_CONTROL.

> +#define EXYNOS850_TMU_AVG_MODE_MASK            0x7

I'd suggest to group all the definitions here as such:

#define REG1_OFFSET
#define REG1_FIELD1_OFFSET
#define REG1_FIELD2_OFFSET
...empty line...
#define REG2_OFFSET
#define REG2_FIELD1_OFFSET
#define REG2_FIELD2_OFFSET
...etc...

Or otherwise each shift/mask constant should contain its register name
as a prefix, to avoid confusion. But right now it's kinda hard to
understand what belongs to what :) But that's just a nitpick.

> +#define EXYNOS850_TMU_BGRI_TRIM_MASK           0xF

Suggest using GENMASK() macro whenever possible.

> +#define EXYNOS850_TMU_BGRI_TRIM_SHIFT          20
> +#define EXYNOS850_TMU_CLK_SENSE_ON_MASK                0xffff
> +#define EXYNOS850_TMU_CLK_SENSE_ON_SHIFT       16
> +#define EXYNOS850_TMU_DEM_ENABLE               1
> +#define EXYNOS850_TMU_DEM_SHIFT                        4

Instead of above two values, it could be just BIT(4) for
EXYNOS850_TMU_DEM_ENABLE?

> +#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK     0xffff
> +#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT    0
> +#define EXYNOS850_TMU_LPI_MODE_MASK            1
> +#define EXYNOS850_TMU_LPI_MODE_SHIFT           10
> +#define EXYNOS850_TMU_T_BUF_SLOPE_SEL_MASK     0xF
> +#define EXYNOS850_TMU_T_BUF_SLOPE_SEL_SHIFT    18
> +#define EXYNOS850_TMU_T_BUF_VREF_SEL_MASK      0x1F
> +#define EXYNOS850_TMU_T_BUF_VREF_SEL_SHIFT     18
> +#define EXYNOS850_TMU_TEM1051X_SENSE_VALUE     0x028A
> +#define EXYNOS850_TMU_TEM1456X_SENSE_VALUE     0x0A28

I'd pull those two values under shift/mask definitions. Also, please
use lowercase characters for hex values, here and in all other places.

> +#define EXYNOS850_TMU_TEMP_SHIFT               9
> +#define EXYNOS850_TMU_TRIMINFO_SHIFT           4
> +#define EXYNOS850_TMU_T_TRIM0_MASK             0xF
> +#define EXYNOS850_TMU_T_TRIM0_SHIFT            18
> +#define EXYNOS850_TMU_VBEI_TRIM_MASK           0xF
> +#define EXYNOS850_TMU_VBEI_TRIM_SHIFT          8
> +#define EXYNOS850_TMU_VREF_TRIM_MASK           0xF
> +#define EXYNOS850_TMU_VREF_TRIM_SHIFT          12
> +
>  #define EXYNOS_FIRST_POINT_TRIM                        25
>  #define EXYNOS_SECOND_POINT_TRIM               85
>
> @@ -133,6 +170,7 @@ enum soc_type {
>         SOC_ARCH_EXYNOS5420_TRIMINFO,
>         SOC_ARCH_EXYNOS5433,
>         SOC_ARCH_EXYNOS7,
> +       SOC_ARCH_EXYNOS850,
>  };
>
>  /**
> @@ -231,13 +269,16 @@ static int code_to_temp(struct exynos_tmu_data *dat=
a, u16 temp_code)
>
>  static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_i=
nfo)
>  {
> -       u16 tmu_temp_mask =3D
> -               (data->soc =3D=3D SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MA=
SK
> -                                               : EXYNOS_TMU_TEMP_MASK;
> +       u16 tmu_temp_mask =3D (data->soc =3D=3D SOC_ARCH_EXYNOS7 ||
> +                            data->soc =3D=3D SOC_ARCH_EXYNOS850) ?
> +                                   EXYNOS7_TMU_TEMP_MASK :
> +                                   EXYNOS_TMU_TEMP_MASK;
> +       int tmu_85_shift =3D (data->soc =3D=3D SOC_ARCH_EXYNOS850) ?
> +                                  EXYNOS850_TMU_TEMP_SHIFT :
> +                                  EXYNOS_TRIMINFO_85_SHIFT;

Something seems off to me here. How come the shift value for EXYNOS7
case is 8, but the mask is actually 9 bits long? Does it mean the
first error field is 8 bits long, and the second error field is 9 bits
long for EXYNOS7? I don't have the Exynos7 manual, so it's just a
hunch. But if it's true, maybe this shift value has to be added in
your [PATCH 2/6] to fix Exynos7 case?

Also, just an idea: those values (and other similar values) could be
pre-calculated somewhere during the probe, stored in some struct (e.g.
_variant or _chip) and then just used here. Stylistically, instead of
the ternary operator, maybe switch one would easier to read? Again,
those are very minor nitpicks.

>
>         data->temp_error1 =3D trim_info & tmu_temp_mask;
> -       data->temp_error2 =3D ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
> -                               tmu_temp_mask);
> +       data->temp_error2 =3D ((trim_info >> tmu_85_shift) & tmu_temp_mas=
k);
>

No need for the left-most and right-most brackets.

>         if (!data->temp_error1 ||
>             (data->min_efuse_value > data->temp_error1) ||
> @@ -245,9 +286,8 @@ static void sanitize_temp_error(struct exynos_tmu_dat=
a *data, u32 trim_info)
>                 data->temp_error1 =3D data->efuse_value & tmu_temp_mask;
>
>         if (!data->temp_error2)
> -               data->temp_error2 =3D
> -                       (data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
> -                       tmu_temp_mask;
> +               data->temp_error2 =3D (data->efuse_value >> tmu_85_shift)=
 &
> +                                   tmu_temp_mask;
>  }
>
>  static int exynos_tmu_initialize(struct platform_device *pdev)
> @@ -588,6 +628,129 @@ static void exynos7_tmu_initialize(struct platform_=
device *pdev)
>         sanitize_temp_error(data, trim_info);
>  }
>
> +static void exynos850_tmu_set_low_temp(struct exynos_tmu_data *data, u8 =
temp)
> +{
> +       exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_FALL + 1=
2, 0,
> +                              temp);
> +       exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
> +                             EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, true);
> +}
> +
> +static void exynos850_tmu_set_high_temp(struct exynos_tmu_data *data, u8=
 temp)
> +{
> +       exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_RISE + 1=
2, 16,
> +                              temp);
> +       exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
> +                             EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, true);
> +}
> +
> +static void exynos850_tmu_disable_low(struct exynos_tmu_data *data)
> +{
> +       exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
> +                             EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, false);
> +}
> +
> +static void exynos850_tmu_disable_high(struct exynos_tmu_data *data)
> +{
> +       exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
> +                             EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, false);
> +}
> +
> +static void exynos850_tmu_set_crit_temp(struct exynos_tmu_data *data, u8=
 temp)
> +{
> +       exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_RISE + 0=
, 16,
> +                              temp);
> +       exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
> +                             EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
> +       exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
> +                             EXYNOS7_TMU_INTEN_RISE0_SHIFT + 7, true);
> +}
> +
> +static void exynos850_tmu_initialize(struct platform_device *pdev)
> +{
> +       struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> +       int cal_type;

Please make it u32.

> +       unsigned int avg_mode, buf, bgri, vref, vbei;

Suggest renaming buf -> reg, and maybe make it u32.

> +
> +       buf =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> +       cal_type =3D (buf & EXYNOS5433_TRIMINFO_CALIB_SEL_MASK) >>
> +                  EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT;
> +       data->reference_voltage =3D (buf >> EXYNOS850_TMU_T_BUF_VREF_SEL_=
SHIFT) &
> +                                 EXYNOS850_TMU_T_BUF_VREF_SEL_MASK;
> +       buf =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
> +                   EXYNOS850_TMU_TRIMINFO_SHIFT);
> +       data->gain =3D (buf >> EXYNOS850_TMU_T_BUF_SLOPE_SEL_SHIFT) &
> +                    EXYNOS850_TMU_T_BUF_SLOPE_SEL_MASK;
> +       buf =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
> +                   2 * EXYNOS850_TMU_TRIMINFO_SHIFT);
> +       avg_mode =3D (buf >> EXYNOS850_TMU_AVG_CON_SHIFT) &
> +                  EXYNOS850_TMU_AVG_MODE_MASK;
> +       buf =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
> +                   3 * EXYNOS850_TMU_TRIMINFO_SHIFT);
> +       bgri =3D (buf >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
> +              EXYNOS850_TMU_T_TRIM0_MASK;
> +       buf =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
> +                   4 * EXYNOS850_TMU_TRIMINFO_SHIFT);
> +       vref =3D (buf >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
> +              EXYNOS850_TMU_T_TRIM0_MASK;
> +       buf =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
> +                   5 * EXYNOS850_TMU_TRIMINFO_SHIFT);

For cases like that, maybe introduce some macro like:

    #define EXYNOS850_TRIMINFO_OFFSET(n)    (EXYNOS_TMU_REG_TRIMINFO +
(n) * EXYNOS850_TMU_TRIMINFO_SHIFT)

and use it everywhere?

> +       vbei =3D (buf >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
> +              EXYNOS850_TMU_T_TRIM0_MASK;
> +
> +       buf =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> +       sanitize_temp_error(data, buf);
> +
> +       switch (cal_type) {
> +       case EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING:
> +               data->cal_type =3D TYPE_TWO_POINT_TRIMMING;
> +               break;
> +       case EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING:

Add "fallthrough;" here? Or maybe just remove above line at all?

> +       default:
> +               data->cal_type =3D TYPE_ONE_POINT_TRIMMING;
> +               break;
> +       }
> +
> +       dev_info(&pdev->dev, "Calibration type is %d-point calibration\n"=
,
> +                cal_type ? 2 : 1);
> +
> +       buf =3D readl(data->base + EXYNOS850_TMU_REG_AVG_CON);
> +       buf &=3D ~(EXYNOS850_TMU_AVG_MODE_MASK);

No need for brackets.

> +       buf &=3D ~(EXYNOS850_TMU_DEM_ENABLE << EXYNOS850_TMU_DEM_SHIFT);
> +       if (avg_mode) {
> +               buf |=3D avg_mode;
> +               buf |=3D (EXYNOS850_TMU_DEM_ENABLE << EXYNOS850_TMU_DEM_S=
HIFT);
> +       }
> +       writel(buf, data->base + EXYNOS850_TMU_REG_AVG_CON);
> +
> +       buf =3D readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
> +       buf &=3D ~(EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK
> +                << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT);
> +       buf |=3D EXYNOS850_TMU_TEM1051X_SENSE_VALUE
> +              << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT;
> +       writel(buf, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
> +
> +       buf =3D readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
> +       buf &=3D ~(EXYNOS850_TMU_CLK_SENSE_ON_MASK
> +                << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT);
> +       buf |=3D EXYNOS850_TMU_TEM1051X_SENSE_VALUE
> +              << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT;
> +       writel(buf, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
> +
> +       buf =3D readl(data->base + EXYNOS850_TMU_REG_TRIM0);
> +       buf &=3D ~(EXYNOS850_TMU_BGRI_TRIM_MASK << EXYNOS850_TMU_BGRI_TRI=
M_SHIFT);
> +       buf &=3D ~(EXYNOS850_TMU_VREF_TRIM_MASK << EXYNOS850_TMU_VREF_TRI=
M_SHIFT);
> +       buf &=3D ~(EXYNOS850_TMU_VBEI_TRIM_MASK << EXYNOS850_TMU_VBEI_TRI=
M_SHIFT);

Why not define this mask value like this instead:

    #define EXYNOS850_TMU_VBEI_TRIM_MASK        GENMASK(11,8)

And then you'll be able to do just:

    buf &=3D ~EXYNOS850_TMU_VBEI_TRIM_MASK;

The same goes for all similar cases.

> +       buf |=3D (bgri << EXYNOS850_TMU_BGRI_TRIM_SHIFT);
> +       buf |=3D (vref << EXYNOS850_TMU_VREF_TRIM_SHIFT);
> +       buf |=3D (vbei << EXYNOS850_TMU_VBEI_TRIM_SHIFT);

Brackets are not needed.

> +       writel(buf, data->base + EXYNOS850_TMU_REG_TRIM0);
> +
> +       buf =3D readl(data->base + EXYNOS850_TMU_REG_CONTROL1);
> +       buf &=3D ~(EXYNOS850_TMU_LPI_MODE_MASK << EXYNOS850_TMU_LPI_MODE_=
SHIFT);
> +       writel(buf, data->base + EXYNOS850_TMU_REG_CONTROL1);
> +}
> +
>  static void exynos4210_tmu_control(struct platform_device *pdev, bool on=
)
>  {
>         struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> @@ -679,7 +842,8 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *d=
ata, unsigned int val,
>
>                 val &=3D ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIF=
T);
>                 val |=3D (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
> -               if (data->soc =3D=3D SOC_ARCH_EXYNOS7) {
> +               if (data->soc =3D=3D SOC_ARCH_EXYNOS7 ||
> +                   data->soc =3D=3D SOC_ARCH_EXYNOS850) {
>                         val &=3D ~(EXYNOS7_EMUL_DATA_MASK <<
>                                 EXYNOS7_EMUL_DATA_SHIFT);
>                         val |=3D (temp_to_code(data, temp) <<
> @@ -709,7 +873,8 @@ static void exynos4412_tmu_set_emulation(struct exyno=
s_tmu_data *data,
>                 emul_con =3D EXYNOS5260_EMUL_CON;
>         else if (data->soc =3D=3D SOC_ARCH_EXYNOS5433)
>                 emul_con =3D EXYNOS5433_TMU_EMUL_CON;
> -       else if (data->soc =3D=3D SOC_ARCH_EXYNOS7)
> +       else if (data->soc =3D=3D SOC_ARCH_EXYNOS7 ||
> +                data->soc =3D=3D SOC_ARCH_EXYNOS850)
>                 emul_con =3D EXYNOS7_TMU_REG_EMUL_CON;
>         else
>                 emul_con =3D EXYNOS_EMUL_CON;
> @@ -766,6 +931,12 @@ static int exynos7_tmu_read(struct exynos_tmu_data *=
data)
>                 EXYNOS7_TMU_TEMP_MASK;
>  }
>
> +static int exynos850_tmu_read(struct exynos_tmu_data *data)
> +{
> +       return readw(data->base + EXYNOS850_TMU_REG_CURRENT_TEMP1_0) &
> +              EXYNOS7_TMU_TEMP_MASK;
> +}
> +
>  static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
>  {
>         struct exynos_tmu_data *data =3D id;
> @@ -794,7 +965,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_t=
mu_data *data)
>         if (data->soc =3D=3D SOC_ARCH_EXYNOS5260) {
>                 tmu_intstat =3D EXYNOS5260_TMU_REG_INTSTAT;
>                 tmu_intclear =3D EXYNOS5260_TMU_REG_INTCLEAR;
> -       } else if (data->soc =3D=3D SOC_ARCH_EXYNOS7) {
> +       } else if (data->soc =3D=3D SOC_ARCH_EXYNOS7 ||
> +                  data->soc =3D=3D SOC_ARCH_EXYNOS850) {
>                 tmu_intstat =3D EXYNOS7_TMU_REG_INTPEND;
>                 tmu_intclear =3D EXYNOS7_TMU_REG_INTPEND;
>         } else if (data->soc =3D=3D SOC_ARCH_EXYNOS5433) {
> @@ -845,6 +1017,9 @@ static const struct of_device_id exynos_tmu_match[] =
=3D {
>         }, {
>                 .compatible =3D "samsung,exynos7-tmu",
>                 .data =3D (const void *)SOC_ARCH_EXYNOS7,
> +       }, {
> +               .compatible =3D "samsung,exynos850-tmu",
> +               .data =3D (const void *)SOC_ARCH_EXYNOS850,
>         },
>         { },
>  };
> @@ -957,6 +1132,21 @@ static int exynos_map_dt_data(struct platform_devic=
e *pdev)
>                 data->min_efuse_value =3D 15;
>                 data->max_efuse_value =3D 100;
>                 break;
> +       case SOC_ARCH_EXYNOS850:
> +               data->tmu_set_low_temp =3D exynos850_tmu_set_low_temp;
> +               data->tmu_set_high_temp =3D exynos850_tmu_set_high_temp;
> +               data->tmu_disable_low =3D exynos850_tmu_disable_low;
> +               data->tmu_disable_high =3D exynos850_tmu_disable_high;
> +               data->tmu_set_crit_temp =3D exynos850_tmu_set_crit_temp;
> +               data->tmu_initialize =3D exynos850_tmu_initialize;
> +               data->tmu_control =3D exynos4210_tmu_control;
> +               data->tmu_read =3D exynos850_tmu_read;
> +               data->tmu_set_emulation =3D exynos4412_tmu_set_emulation;
> +               data->tmu_clear_irqs =3D exynos4210_tmu_clear_irqs;
> +               data->efuse_value =3D 55;
> +               data->min_efuse_value =3D 0;
> +               data->max_efuse_value =3D 511;
> +               break;
>         default:
>                 dev_err(&pdev->dev, "Platform not supported\n");
>                 return -EINVAL;
> @@ -1051,7 +1241,7 @@ static int exynos_tmu_probe(struct platform_device =
*pdev)
>                 return ret;
>
>         data->clk =3D devm_clk_get(dev, "tmu_apbif");
> -       if (IS_ERR(data->clk))
> +       if (IS_ERR(data->clk) && data->soc !=3D SOC_ARCH_EXYNOS850)
>                 return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to =
get clock\n");
>
>         data->clk_sec =3D devm_clk_get(dev, "tmu_triminfo_apbif");
> --
> 2.45.1
>
>

