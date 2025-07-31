Return-Path: <linux-pm+bounces-31647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A1B16AAF
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 05:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A72762230B
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 03:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8E23B63A;
	Thu, 31 Jul 2025 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i/60mbN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0B23B61E
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931457; cv=none; b=RtdAkFQbu17Rd8J0s1XOYxsOdM8v9R++E276BT//qKx3syDvi4OCElILcrzWkN/Q+7cpLWrB32AJL73WgCKyQH7Dy+uvvJrpZ8nsqVEENztOlOZ5i4DyHgVyJzHEQYBzB+JRw0ty3aGPP+/PhFscDlLGPWywYl7hnP0z5eCiB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931457; c=relaxed/simple;
	bh=DIM3U/viUk7et9FK4/5wZRJ741E/C+ZgyDud3Xa0d+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IngHrDJoBlCB02DtSTQMG8NVDuSb+qKr8dv3QgBNu+efCsim0gx9yRzBBQetseYaXU2Ccl3dU3sfSbs3Z0eD0/FR++Ib9ZwdJtCwh8Gu3yl7MbCEww6/0tConGPV9p8YFBv4F4pKqi1PgwAD/u5bwBAL+j7NUgzZjh98Wb6QGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i/60mbN9; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-537904b0c74so179378e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753931453; x=1754536253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQz3EwDsCOo1XFmvxHoa4HIcyhVHPzzMG2oMGGNImxA=;
        b=i/60mbN9KAiBXMeC3ZJHbvLzcalVVSH/StByGr52gIESE/NRy3pbHSyPsGnsc7n4y8
         62R/589S8n/vwPa6vTz5lz0O2fIwDJtRmIAfCTjuZ1PwsLML5tdFJW+9eRSkOyqW8dsz
         0KOAQGf3pHY/iqtJG2KH0UBC8QW2auyUxKA/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753931453; x=1754536253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQz3EwDsCOo1XFmvxHoa4HIcyhVHPzzMG2oMGGNImxA=;
        b=ibfDPtGmlrnJVV+psQ+SAYcZQ5QnRpmonld8ETcd0SsoUWPjix9cyOXR9THsSohC74
         yCa2ouZGG9P/t/aWoYt5N1P0zWyXBfZ4WnBC5NP8ll/Kg8dtmqdWEneWPYWtsHdeGlpU
         SKa8X6QvXaTNhjt2KsxkRDJxMf4K6DAu46yBRf8gnrWlOcFKLp598XRDnRn0H7VlaDSs
         unzkF9vaYPlpcH7e9SKKeczioNPdRbQgUxHcIUZi3naFvQijzRa8LS8kotUCjHLG1uMS
         yxRk7Ji6Yt0ZOlI43OfeKBm4nAsSHuovuAYXRRlkJ8an/TLgZ4MNIR2oYeN5sIXMOIGA
         vqUg==
X-Forwarded-Encrypted: i=1; AJvYcCW3tP3XgY1k0LaIjRoepP/ZbpWbyPhcpbghaDNumfejUTWi1ginw5Ag9Ui1OUV7QdXtPtnx926pSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DYv4XSg5H16ELpeW1lWiSD82GSfoz+DzjwEEkm0En4xAhm11
	59jKs6tsYwo4si8B8QTjv4OD7HYK6jAccrZnDHBJGBJUrzKmO5ttJZPriLG+JVkL4ME+zNBFmls
	ASKA=
X-Gm-Gg: ASbGnctPRumkQiiez0Nmeb3vyfu/VOWL5ukRGg8MeLyBWTT/Oo4TcB1q7p+fCduZFDd
	IGlnBHzJ4sYQdRHPCD0JUYznCDsjP+bI8HjdPjY+We3jsP70h6nwrndjuY67h5Wnool+fJTtb7A
	kn9xU/+w8pJZhT6X2vlmB9RPiS8o1S32HI7HTLkbCpYa9JsyexN2V7gLJb8ng+XbNZe5jWxWo3B
	2ccHRwHUfvqH/GOK9UxOtqxGBrGdq6/EiLiBN3M8UPQESGcsWZaYJDSZ9RCAhX3l69U+1SF+Jes
	uVwQHRnvW15kTErnVeMMT2cjPVPfngFP37wly0uP2hupscj/yHaDb75ia07g0NqAwZAikETamp7
	C0v2+kDfsFtfetH+HwazK3Y+M9No1L3y+iqM/uncnR+cSyMEuxjq3hiIFEg==
X-Google-Smtp-Source: AGHT+IHGiL1MLfiycru3J92/eTlCaY66WvaKpZ2B+sQiTeiGi8tXQAFGzQ6sO1QvEyR4VyUbjuq4qA==
X-Received: by 2002:a05:6122:8ce:b0:531:2f9f:8026 with SMTP id 71dfb90a1353d-5391ce9632dmr3555170e0c.1.1753931453433;
        Wed, 30 Jul 2025 20:10:53 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936d10f3asm165836e0c.26.2025.07.30.20.10.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:10:52 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4fbed2d9e61so190988137.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 20:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwricvLx5JnNRb0Ey/IpkmTkaop1sPS+YkJJNKWCaf+Fpb79OIdLhmyo0RPyBXa8yrxewt7E70Rw==@vger.kernel.org
X-Received: by 2002:a05:6102:3e86:b0:4f9:d929:8558 with SMTP id
 ada2fe7eead31-4fbe7f5a8ecmr3674144137.10.1753931451474; Wed, 30 Jul 2025
 20:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-3-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-3-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 11:10:15 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhEiWmFkVMVGqg97TqXQqLhP0KZkQvq+F=k_hS_Jg297Q@mail.gmail.com>
X-Gm-Features: Ac12FXxQNf_MHWgJFTLhQCBFRAD1HLcfHVxkjg6vNoUDqC6XlmkmVeEw5sZ-QQw
Message-ID: <CAC=S1nhEiWmFkVMVGqg97TqXQqLhP0KZkQvq+F=k_hS_Jg297Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] thermal/drivers/mediatek/lvts: Make number of
 calibration offsets configurable
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:30=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 use 2-byte eFuse calibration data, whereas other SoCs
> supported by the driver rely on 3 bytes. Make the number of calibration
> bytes per sensor configurable, enabling support for SoCs with varying
> calibration formats.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 32 +++++++++++++++++--------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index f4d1e66d7db9..05aa8895ccce 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -96,12 +96,14 @@
>
>  #define LVTS_MINIMUM_THRESHOLD         20000
>
> +#define LVTS_MAX_CAL_OFFSETS           3
> +
>  static int golden_temp =3D LVTS_GOLDEN_TEMP_DEFAULT;
>  static int golden_temp_offset;
>
>  struct lvts_sensor_data {
>         int dt_id;
> -       u8 cal_offsets[3];
> +       u8 cal_offsets[LVTS_MAX_CAL_OFFSETS];
>  };
>
>  struct lvts_ctrl_data {
> @@ -127,6 +129,7 @@ struct lvts_data {
>         const struct lvts_ctrl_data *lvts_ctrl;
>         const u32 *conn_cmd;
>         const u32 *init_cmd;
> +       int num_cal_offsets;
>         int num_lvts_ctrl;
>         int num_conn_cmd;
>         int num_init_cmd;
> @@ -711,7 +714,7 @@ static int lvts_calibration_init(struct device *dev, =
struct lvts_ctrl *lvts_ctrl
>                                         u8 *efuse_calibration,
>                                         size_t calib_len)
>  {
> -       int i;
> +       int i, j;
>         u32 gt;
>
>         /* A zero value for gt means that device has invalid efuse data *=
/
> @@ -720,17 +723,18 @@ static int lvts_calibration_init(struct device *dev=
, struct lvts_ctrl *lvts_ctrl
>         lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
>                 const struct lvts_sensor_data *sensor =3D
>                                         &lvts_ctrl_data->lvts_sensor[i];
> +               u32 calib =3D 0;
>
> -               if (sensor->cal_offsets[0] >=3D calib_len ||
> -                   sensor->cal_offsets[1] >=3D calib_len ||
> -                   sensor->cal_offsets[2] >=3D calib_len)
> -                       return -EINVAL;
> +               for (j =3D 0; j < lvts_ctrl->lvts_data->num_cal_offsets; =
j++) {
> +                       u8 offset =3D sensor->cal_offsets[j];
> +
> +                       if (offset >=3D calib_len)
> +                               return -EINVAL;
> +                       calib |=3D efuse_calibration[offset] << (8 * j);
> +               }
>
>                 if (gt) {
> -                       lvts_ctrl->calibration[i] =3D
> -                               (efuse_calibration[sensor->cal_offsets[0]=
] << 0) +
> -                               (efuse_calibration[sensor->cal_offsets[1]=
] << 8) +
> -                               (efuse_calibration[sensor->cal_offsets[2]=
] << 16);
> +                       lvts_ctrl->calibration[i] =3D calib;
>                 } else if (lvts_ctrl->lvts_data->def_calibration) {
>                         lvts_ctrl->calibration[i] =3D lvts_ctrl->lvts_dat=
a->def_calibration;
>                 } else {
> @@ -1763,6 +1767,7 @@ static const struct lvts_data mt7988_lvts_ap_data =
=3D {
>         .temp_factor    =3D LVTS_COEFF_A_MT7988,
>         .temp_offset    =3D LVTS_COEFF_B_MT7988,
>         .gt_calib_bit_offset =3D 24,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8186_lvts_data =3D {
> @@ -1776,6 +1781,7 @@ static const struct lvts_data mt8186_lvts_data =3D =
{
>         .temp_offset    =3D LVTS_COEFF_B_MT7988,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 19000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8188_lvts_mcu_data =3D {
> @@ -1789,6 +1795,7 @@ static const struct lvts_data mt8188_lvts_mcu_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 20,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8188_lvts_ap_data =3D {
> @@ -1802,6 +1809,7 @@ static const struct lvts_data mt8188_lvts_ap_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 20,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8192_lvts_mcu_data =3D {
> @@ -1815,6 +1823,7 @@ static const struct lvts_data mt8192_lvts_mcu_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8192_lvts_ap_data =3D {
> @@ -1828,6 +1837,7 @@ static const struct lvts_data mt8192_lvts_ap_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8195_lvts_mcu_data =3D {
> @@ -1841,6 +1851,7 @@ static const struct lvts_data mt8195_lvts_mcu_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct lvts_data mt8195_lvts_ap_data =3D {
> @@ -1854,6 +1865,7 @@ static const struct lvts_data mt8195_lvts_ap_data =
=3D {
>         .temp_offset    =3D LVTS_COEFF_B_MT8195,
>         .gt_calib_bit_offset =3D 24,
>         .def_calibration =3D 35000,
> +       .num_cal_offsets =3D 3,
>  };
>
>  static const struct of_device_id lvts_of_match[] =3D {
> --
> 2.39.5
>
>

