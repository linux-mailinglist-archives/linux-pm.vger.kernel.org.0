Return-Path: <linux-pm+bounces-11438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE393D84E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57ED1C228E4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2373BBCB;
	Fri, 26 Jul 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxRE+7Tt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C403BB21
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018459; cv=none; b=JzIsBQsrhT64uh5Rbz5kZow/vbfa4MoDnPEV2fROsWwbF7sej17jEXAkvirLcWb2o8NF+zGXU/BqaVlAXy4UTRk62Q2yClfxUD+RIq9HztYtax4fAaMNxr/gHEw4mfbCUDU8UJHOy5EM6/5WMUnsBditoaoAKEBB/EevjxwIMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018459; c=relaxed/simple;
	bh=6EykVPTZYFydFQcBWpX4LI9GsdVlmbMDoZiRWXXhD6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAvMwcOYXk/7NpPwSvMtS1ZAxYFZpwAFUZQxpMZ4eIHL4TJGQN2kqNwKMYqbs0tCE95zvd2RrYqESQCsAMqIzimwWR9GXI+i+sjvahmroCCtA/JXwU7WkQ7Ju3mVdv/0I+1SWZduldmGY5x+vD2nPTS65FScV8vEq2trh0RHK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxRE+7Tt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66ca536621cso25961267b3.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722018457; x=1722623257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyXLE5+5Swdlu0x6Wri+janyRxYEWn8w2PU12UcKNGU=;
        b=gxRE+7TtIbf52twj4oUrMgE6qa2JlCqZr2VXameRwKPxuPNHeDeRcu4arZZW8qQ31i
         VaOY23j7AliWALkRQYpcTvqPAe+GP7mXnXXeIym6ZSGwk9FwL0fspalDWEOtbvmnbdeL
         KwgUohUjCamVo6Eed/gxUFw2sKUso7S58z2zJuFBXhGSPXkCcDyhM2zQJlsDZlIejSoX
         Zf0Bgg3zkn/QuhxEbi0X6gzfE68qIo68jw8Cbv8M9qzmCcEV3V/4+BUmbUKRGqm9ngLO
         d1njV13IO9PGd6FhxvP89ziCLxOAc/QYXJw8W3YGQKBlS2uT6IX28BUx0bWVXOW+sV2f
         CDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018457; x=1722623257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyXLE5+5Swdlu0x6Wri+janyRxYEWn8w2PU12UcKNGU=;
        b=uHVA0b5ZI1mLZdY/upAlaM8obkFrnzOnoAY4MJk5YmC8J3XEg6iyCYxSzgEd6KzPgT
         29tSB9ZpkWCLUK9UYHlB79uxop1VNKsqRwM1MJvX8IVWmBMdebMUykiWdLqaprCE+3xF
         r/KcnNQZ1vFMVPwCgJ7/YeTJxBzCpksJhINuiO6hGQ2dU3lwUitLOVc84CM6d/SoS3LN
         TsL90V0Wtl8c5y8hGe5xVF97Wa2iZUrcPc98Jy++UXVxbuGvuaS51l/tR+PtupEY2VYG
         Q6a15G+DMp2/hPj4j9OmW5uamKVv0iWps796M975pBAzaHvLvW7yzNQqru++YRW/3dFl
         r+lA==
X-Gm-Message-State: AOJu0Yxyi0hFpbd5zNTDUKoP6un4DZQm35s9rUvb9SfF0Bue2aIWMWoA
	DAwcFhSKw4E1VJtbr7czACGLvJ1Rs7b6t1Ni9HvSy8gmNkr1R9I9BDVoNzz66Buv6t4dSaVG6v7
	4j0QlPvdKC0jNQoNDQc8TR52b3vRJrbvILxQAWQ==
X-Google-Smtp-Source: AGHT+IGu+fZfm0OlFYIELI6yk25RKnnuCGjlhcQl4HnDPQGENb9SW/oXMTgqpBNFbF9MFabxhl8bPpc+MSo694zdG/0=
X-Received: by 2002:a0d:ee43:0:b0:651:6cf1:76b with SMTP id
 00721157ae682-67a06ede805mr6762737b3.22.1722018456817; Fri, 26 Jul 2024
 11:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240726110138eucas1p27f33fb42af84ba7938703796c3f80727@eucas1p2.samsung.com>
 <20240726110114.1509733-1-m.majewski2@samsung.com> <20240726110114.1509733-4-m.majewski2@samsung.com>
In-Reply-To: <20240726110114.1509733-4-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jul 2024 13:27:26 -0500
Message-ID: <CAPLW+4mN5sntZj5UcXXazZq6a_Ra7Ssuz-qLJk9N0egp1W9r=A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drivers/thermal/exynos: improve sanitize_temp_error
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
> There are two minor issues regarding this function.
>
> One is that it attempts to calculate the second calibration value even
> if 1-point trimming is being used; in this case, the calculated value is
> probably not useful and is never used anyway. Changing this also
> requires a minor reordering in Exynos5433 initialization function, so
> that we know which type of trimming is used before we call
> sanitize_temp_error.
>
> The second issue is that the function is not very consistent when it
> comes to the use of Exynos7-specific parameters. This seems to not be an
> issue in practice, in part because some of these issues are related to
> the mentioned calculation of the second calibration value. However,
> fixing this makes the code a bit less confusing, and will be required
> for Exynos850 which has 9-bit temperature values and uses 2-point
> trimming.
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v1 -> v2: reworked to change shift instead of only mask and to also fix
>   the 2-point trimming issue.
>
>  drivers/thermal/samsung/exynos_tmu.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index b68e9755c933..087a09628e23 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -111,6 +111,7 @@
>  #define EXYNOS7_TMU_REG_EMUL_CON               0x160
>
>  #define EXYNOS7_TMU_TEMP_MASK                  0x1ff
> +#define EXYNOS7_TMU_TEMP_SHIFT                 9
>  #define EXYNOS7_PD_DET_EN_SHIFT                        23
>  #define EXYNOS7_TMU_INTEN_RISE0_SHIFT          0
>  #define EXYNOS7_EMUL_DATA_SHIFT                        7
> @@ -234,20 +235,23 @@ static void sanitize_temp_error(struct exynos_tmu_d=
ata *data, u32 trim_info)
>         u16 tmu_temp_mask =3D
>                 (data->soc =3D=3D SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MA=
SK
>                                                 : EXYNOS_TMU_TEMP_MASK;
> +       int tmu_85_shift =3D
> +               (data->soc =3D=3D SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_SH=
IFT
> +                                               : EXYNOS_TRIMINFO_85_SHIF=
T;
>
>         data->temp_error1 =3D trim_info & tmu_temp_mask;
> -       data->temp_error2 =3D ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
> -                               EXYNOS_TMU_TEMP_MASK);
> -
>         if (!data->temp_error1 ||
>             (data->min_efuse_value > data->temp_error1) ||
>             (data->temp_error1 > data->max_efuse_value))
> -               data->temp_error1 =3D data->efuse_value & EXYNOS_TMU_TEMP=
_MASK;
> +               data->temp_error1 =3D data->efuse_value & tmu_temp_mask;
>
> -       if (!data->temp_error2)
> -               data->temp_error2 =3D
> -                       (data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
> -                       EXYNOS_TMU_TEMP_MASK;
> +       if (data->cal_type =3D=3D TYPE_TWO_POINT_TRIMMING) {
> +               data->temp_error2 =3D (trim_info >> tmu_85_shift) & tmu_t=
emp_mask;
> +               if (!data->temp_error2)
> +                       data->temp_error2 =3D
> +                               (data->efuse_value >> tmu_85_shift) &
> +                               tmu_temp_mask;
> +       }
>  }
>
>  static int exynos_tmu_initialize(struct platform_device *pdev)
> @@ -510,7 +514,6 @@ static void exynos5433_tmu_initialize(struct platform=
_device *pdev)
>         int sensor_id, cal_type;
>
>         trim_info =3D readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> -       sanitize_temp_error(data, trim_info);
>
>         /* Read the temperature sensor id */
>         sensor_id =3D (trim_info & EXYNOS5433_TRIMINFO_SENSOR_ID_MASK)
> @@ -532,6 +535,8 @@ static void exynos5433_tmu_initialize(struct platform=
_device *pdev)
>                 break;
>         }
>
> +       sanitize_temp_error(data, trim_info);
> +
>         dev_info(&pdev->dev, "Calibration type is %d-point calibration\n"=
,
>                         cal_type ?  2 : 1);
>  }
> --
> 2.45.1
>

