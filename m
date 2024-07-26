Return-Path: <linux-pm+bounces-11442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A993D879
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FA7285B72
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44454778C;
	Fri, 26 Jul 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ar6CSLzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7E3F9F9
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019503; cv=none; b=Jm8dAd16I8urWfoHLyF6R6W1yZlmZoyVubj5u1YtvFJKFtr6pZ+fGgPz8wbsrQDXBpTZQkop2OkifwGEd/VFEIrSSGJo3Rr3UxDbK2mSn91DGaZ+AyOUsqhiGaA6lAgoKd6kKaQO+BwgRkpGLnqYKQPAL5zbccwGYhI5I9GolZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019503; c=relaxed/simple;
	bh=UCARF7dfq4wjV7ZkKGKjCDksLhqHITlO63pedtrAkxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRoHh8et/uJ/4E5jS17UWY+BhOf8eCkuqb6MxiKaYmMQm5R9b0ybOeBHpYgxrbBGyElyc2b80R6nM7R6oVouS+Di3usFFB28H5nh8/VqegwUVgS2qdoRVbsGkG8OZSkXPepwgBlH6Obg2Pl6EYq34+cfTH6aTWBj+zrNprYxs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ar6CSLzL; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66599ca3470so24989817b3.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722019500; x=1722624300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsifxQ0usgY6YlEXog6cF0/Iw3GnVa1z3F0hrXXXxxA=;
        b=Ar6CSLzLDnKV7iNHOtb/QDIi8+gsCuU+lturC4qg+puXwbCn/UqzN259XlfuMVk7GB
         Al4or4bgw2eYXFPeTEhRFIj4iDg3tpmccVN+H5e3iRR9XamycB+2vVimxKe4BrRVvGNG
         nZpIYl0BMCN69CvYMrgZ+kdODXEni4xH1GIaQnMFMV/Bb8eQQl5cJkuXXRLc7cgXX3oX
         P2sEhjUA1jbR4uErEU48jtjx4qhv5Si1AKm3oPPlheRP67D5Fi1Y1plJAXqu2tR5w8JO
         Es37eWOldlIq23HoJHvdKVsCmU4ZRNxaIfAhuL1gFV7vuWPD8gCz0DBnwjM2EpIycxQH
         NdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019501; x=1722624301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsifxQ0usgY6YlEXog6cF0/Iw3GnVa1z3F0hrXXXxxA=;
        b=E28EjF+mYToZ4mXedw4DO5maj3mg+r/ppxhKXzl3OU+23XLsF1FaZAj+sIGhM0SDj6
         Jq9DROAMceDko7EDsp9XDcB/AjIA+/jqcM5xQ26PT790pQV+uKhBQqdA2TuMbiXWguU7
         Rw1YOurNV+Jysjxbn7LoeH4KUtI0tFiXZXyA4+AEQqUwrr6VNIQ7hefggs54+eFrRY/d
         8gkmTeyxJQXu9vhP/Xge3evVzdSVSIPPSQQlG4dds/XK8JtaMp9I3wZzv2aZ9k59ggGo
         THaAVdmh3yIyQYBXg5E5enUleEnxHrbdLZ8WY99gZsWVHFBTp5XWdzqIte396bAaBVwF
         TeUg==
X-Gm-Message-State: AOJu0YxIwhN1+Ndx9bEY9slR63BOHyXeyNnPIIYRWX2XToWLEg+qGnqR
	dOb4Uyk5Y28lLE3DLdpeFLkrIatA9EJKsmRx5GBe6H+AHof+HXpH0WSG/bnaSuufBmm30Dd3PBr
	1n+GW8sNLSaF5+AOfweaRBiJeaLc3cE582CU9xg==
X-Google-Smtp-Source: AGHT+IHq4ersvGmfoLfXX9SWcuVi5VBMy9AFILmzM0TSb1aYeNWYqFT1p+WrpKd1qQdGsqx7KUynlNWAFgt9TRtKk3s=
X-Received: by 2002:a05:690c:f0c:b0:64b:3e44:e4f4 with SMTP id
 00721157ae682-67a05c8b5ecmr8756297b3.7.1722019500486; Fri, 26 Jul 2024
 11:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240726110141eucas1p279c474e8737dcf4752808a20219e12d4@eucas1p2.samsung.com>
 <20240726110114.1509733-1-m.majewski2@samsung.com> <20240726110114.1509733-6-m.majewski2@samsung.com>
In-Reply-To: <20240726110114.1509733-6-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jul 2024 13:44:49 -0500
Message-ID: <CAPLW+4nXXaVxawa57JjKj7tpMrwLjCh4dWCM_4KRWV4q9fTbaA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drivers/thermal/exynos: add initial Exynos850 support
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 6:01=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> This is loosely adapted from an implementation available at
> https://gitlab.com/Linaro/96boards/e850-96/kernel/-/blob/android-exynos-4=
.14-linaro/drivers/thermal/samsung/exynos_tmu.c
> Some differences from that implementation:
> - unlike that implementation, we do not use the ACPM mechanism, instead
>   we just access the registers, like we do for other SoCs,
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

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v1 -> v2: rename and reorder some registers, use the correct register
>   offset for EXYNOS850_TMU_REG_AVG_CON, make the clock required,
>   additionally do some minor style changes.
>
>  drivers/thermal/samsung/exynos_tmu.c | 191 +++++++++++++++++++++++++--
>  1 file changed, 182 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 087a09628e23..2618a81fca53 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -117,6 +117,41 @@
>  #define EXYNOS7_EMUL_DATA_SHIFT                        7
>  #define EXYNOS7_EMUL_DATA_MASK                 0x1ff
>
> +/* Exynos850 specific registers */
> +#define EXYNOS850_TMU_REG_CURRENT_TEMP0_1      0x40
> +#define EXYNOS850_TMU_REG_THD_TEMP0_RISE       0x50
> +#define EXYNOS850_TMU_REG_THD_TEMP0_FALL       0x60
> +
> +#define EXYNOS850_TMU_TRIMINFO_SHIFT           4
> +#define EXYNOS850_TMU_TRIMINFO_OFFSET(n) \
> +       (EXYNOS_TMU_REG_TRIMINFO + (n) * EXYNOS850_TMU_TRIMINFO_SHIFT)
> +#define EXYNOS850_TMU_T_TRIM0_SHIFT            18
> +
> +#define EXYNOS850_TMU_REG_CONTROL1             0x24
> +#define EXYNOS850_TMU_LPI_MODE_MASK            1
> +#define EXYNOS850_TMU_LPI_MODE_SHIFT           10
> +
> +#define EXYNOS850_TMU_REG_COUNTER_VALUE0       0x30
> +#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK     0xffff
> +#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT    0
> +
> +#define EXYNOS850_TMU_REG_COUNTER_VALUE1       0x34
> +#define EXYNOS850_TMU_CLK_SENSE_ON_MASK                0xffff
> +#define EXYNOS850_TMU_CLK_SENSE_ON_SHIFT       16
> +
> +#define EXYNOS850_TMU_REG_AVG_CON              0x38
> +#define EXYNOS850_TMU_AVG_MODE_MASK            0x7
> +#define EXYNOS850_TMU_DEM_ENABLE               BIT(4)
> +
> +#define EXYNOS850_TMU_REG_TRIM0                        0x3c
> +#define EXYNOS850_TMU_TRIM0_MASK               0xf
> +#define EXYNOS850_TMU_VBEI_TRIM_SHIFT          8
> +#define EXYNOS850_TMU_VREF_TRIM_SHIFT          12
> +#define EXYNOS850_TMU_BGRI_TRIM_SHIFT          20
> +
> +#define EXYNOS850_TMU_TEM1051X_SENSE_VALUE     0x028a
> +#define EXYNOS850_TMU_TEM1456X_SENSE_VALUE     0x0a28
> +
>  #define EXYNOS_FIRST_POINT_TRIM                        25
>  #define EXYNOS_SECOND_POINT_TRIM               85
>
> @@ -134,6 +169,7 @@ enum soc_type {
>         SOC_ARCH_EXYNOS5420_TRIMINFO,
>         SOC_ARCH_EXYNOS5433,
>         SOC_ARCH_EXYNOS7,
> +       SOC_ARCH_EXYNOS850,
>  };
>
>  /**
> @@ -232,12 +268,14 @@ static int code_to_temp(struct exynos_tmu_data *dat=
a, u16 temp_code)
>
>  static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_i=
nfo)
>  {
> -       u16 tmu_temp_mask =3D
> -               (data->soc =3D=3D SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MA=
SK
> -                                               : EXYNOS_TMU_TEMP_MASK;
> -       int tmu_85_shift =3D
> -               (data->soc =3D=3D SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_SH=
IFT
> -                                               : EXYNOS_TRIMINFO_85_SHIF=
T;
> +       u16 tmu_temp_mask =3D (data->soc =3D=3D SOC_ARCH_EXYNOS7 ||
> +                            data->soc =3D=3D SOC_ARCH_EXYNOS850) ?
> +                                   EXYNOS7_TMU_TEMP_MASK :
> +                                   EXYNOS_TMU_TEMP_MASK;
> +       int tmu_85_shift =3D (data->soc =3D=3D SOC_ARCH_EXYNOS7 ||
> +                           data->soc =3D=3D SOC_ARCH_EXYNOS850) ?
> +                                  EXYNOS7_TMU_TEMP_SHIFT :
> +                                  EXYNOS_TRIMINFO_85_SHIFT;
>
>         data->temp_error1 =3D trim_info & tmu_temp_mask;
>         if (!data->temp_error1 ||
> @@ -587,6 +625,114 @@ static void exynos7_tmu_initialize(struct platform_=
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
> +       u32 cal_type, avg_mode, reg, bgri, vref, vbei;
> +
> +       reg =3D readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(0));
> +       cal_type =3D (reg & EXYNOS5433_TRIMINFO_CALIB_SEL_MASK) >>
> +                  EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT;
> +       data->reference_voltage =3D (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) =
&
> +                                 EXYNOS_TMU_REF_VOLTAGE_MASK;
> +       reg =3D readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(1));
> +       data->gain =3D (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
> +                    EXYNOS_TMU_BUF_SLOPE_SEL_MASK;
> +       reg =3D readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(2));
> +       avg_mode =3D (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
> +                  EXYNOS850_TMU_AVG_MODE_MASK;
> +       reg =3D readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(3));
> +       bgri =3D (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRI=
M0_MASK;
> +       reg =3D readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(4));
> +       vref =3D (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRI=
M0_MASK;
> +       reg =3D readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(5));
> +       vbei =3D (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRI=
M0_MASK;
> +
> +       data->cal_type =3D cal_type =3D=3D EXYNOS5433_TRIMINFO_TWO_POINT_=
TRIMMING ?
> +                                TYPE_TWO_POINT_TRIMMING :
> +                                TYPE_ONE_POINT_TRIMMING;
> +
> +       reg =3D readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(0));
> +       sanitize_temp_error(data, reg);
> +
> +       dev_info(&pdev->dev, "Calibration type is %d-point calibration\n"=
,
> +                cal_type ? 2 : 1);
> +
> +       reg =3D readl(data->base + EXYNOS850_TMU_REG_AVG_CON);
> +       reg &=3D ~EXYNOS850_TMU_AVG_MODE_MASK;
> +       reg &=3D ~EXYNOS850_TMU_DEM_ENABLE;
> +       if (avg_mode) {
> +               reg |=3D avg_mode;
> +               reg |=3D EXYNOS850_TMU_DEM_ENABLE;
> +       }
> +       writel(reg, data->base + EXYNOS850_TMU_REG_AVG_CON);
> +
> +       reg =3D readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
> +       reg &=3D ~(EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK
> +                << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT);
> +       reg |=3D EXYNOS850_TMU_TEM1051X_SENSE_VALUE
> +              << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT;
> +       writel(reg, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
> +
> +       reg =3D readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
> +       reg &=3D ~(EXYNOS850_TMU_CLK_SENSE_ON_MASK
> +                << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT);
> +       reg |=3D EXYNOS850_TMU_TEM1051X_SENSE_VALUE
> +              << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT;
> +       writel(reg, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
> +
> +       reg =3D readl(data->base + EXYNOS850_TMU_REG_TRIM0);
> +       reg &=3D ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_BGRI_TRIM_SH=
IFT);
> +       reg &=3D ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_VREF_TRIM_SH=
IFT);
> +       reg &=3D ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_VBEI_TRIM_SH=
IFT);
> +       reg |=3D bgri << EXYNOS850_TMU_BGRI_TRIM_SHIFT;
> +       reg |=3D vref << EXYNOS850_TMU_VREF_TRIM_SHIFT;
> +       reg |=3D vbei << EXYNOS850_TMU_VBEI_TRIM_SHIFT;
> +       writel(reg, data->base + EXYNOS850_TMU_REG_TRIM0);
> +
> +       reg =3D readl(data->base + EXYNOS850_TMU_REG_CONTROL1);
> +       reg &=3D ~(EXYNOS850_TMU_LPI_MODE_MASK << EXYNOS850_TMU_LPI_MODE_=
SHIFT);
> +       writel(reg, data->base + EXYNOS850_TMU_REG_CONTROL1);
> +}
> +
>  static void exynos4210_tmu_control(struct platform_device *pdev, bool on=
)
>  {
>         struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
> @@ -676,7 +822,8 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *d=
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
> @@ -706,7 +853,8 @@ static void exynos4412_tmu_set_emulation(struct exyno=
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
> @@ -761,6 +909,12 @@ static int exynos7_tmu_read(struct exynos_tmu_data *=
data)
>                 EXYNOS7_TMU_TEMP_MASK;
>  }
>
> +static int exynos850_tmu_read(struct exynos_tmu_data *data)
> +{
> +       return readw(data->base + EXYNOS850_TMU_REG_CURRENT_TEMP0_1) &
> +              EXYNOS7_TMU_TEMP_MASK;
> +}
> +
>  static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
>  {
>         struct exynos_tmu_data *data =3D id;
> @@ -787,7 +941,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_t=
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
> @@ -838,6 +993,9 @@ static const struct of_device_id exynos_tmu_match[] =
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
> @@ -950,6 +1108,21 @@ static int exynos_map_dt_data(struct platform_devic=
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
> --
> 2.45.1
>

