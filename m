Return-Path: <linux-pm+bounces-31192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC77B0C247
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 13:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8693B43D9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A0D296168;
	Mon, 21 Jul 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kkm38Y2L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C22295520
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096201; cv=none; b=GDbAIbWcbLHntbXFOs4jG0wfYlwyVmOUiKjWAF+zgPa92/1B6O0gXK9T1h6HVaOGQWys2TSfjx7tN2712p/Nshl64TXUhsSFObAJ1VLbZBdshQHlTyscviHsqWEkX3HHCzA9oZ/TkwGGnZ13ajVlGO68Jcj85v1W+Ewt5WbvR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096201; c=relaxed/simple;
	bh=sB5Y3BU3Xtwi3wF9nhNOXV9hrQqBf3LqIEohBOIRQTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwqgPvU2zxoku/P0HYX7ShBo9bmfda38oOFeFv9L06qBzgxOf1p42x4drLzbiq0qSl94xOpOmmGFNWOqnY4TorW/DR1wYpbT8f0YqfA4cDCXQKRstNYcmXWamcrledVmnlg2Z5zwbFTWTMXDdgWzqo0YcUvgif65AZxcw0wbas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kkm38Y2L; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-33097e1133fso37842081fa.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753096197; x=1753700997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WW2uf9Dse9OAFXSGg4nVLrSNNR6IaqC06E35FrZCQw=;
        b=Kkm38Y2L5XxZCQ3d+HKL5hzrLow83EiPjgb3sOqPMKf0XbrTLL7vZZ5SkDF8UEpcRv
         NfVEu7R3Bp6E63AvTagKs5gFzKYQCy+7p7kMPvQ4ld4mqjma87XiF29eLHidhKNu0rWa
         OjQPX/Gy/SuNsIDcEoZD5ey4P8IUHBqck7ZNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096197; x=1753700997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WW2uf9Dse9OAFXSGg4nVLrSNNR6IaqC06E35FrZCQw=;
        b=DfeZvRfUCmzMoobW+wvHVF5muvGMcGQJHE+AOmDpqFzuzR5oJpJlOe7hb2AscclwXQ
         Z5gmSrai7FYeoENK3/i7gyp1/cmDFCGYXk8eA4CcvCZ5Zi9VP2cytb4GvngtRWlvZTGP
         Y+1ioaoOa7r7gjtgxKd9VCfB8agXMe4XlWjyOZfFQwxmDH/Ab9nmyb0niJe+WFuojUfA
         fvmpVW8MrTBq3xyQiwZzbQxkefhzZymJN8oMyFYGH99UWP1MKG0KIdsBkJxHyIQhUHFq
         GGBt8zdmxvJ+iJXKegic0sM72qQbVCuFeQ0Vnn+NI1Euhu6CtVC4FClxhBP75j88Zh5f
         wQJA==
X-Forwarded-Encrypted: i=1; AJvYcCUp8b3eReG03LXW411bHO9ahQdPIs5NJTgsjcS0h1Fh6BJfM6kjvGxXPNDhKSsqJMKVCku+qXFVfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVacNavmpdwWr9uNVlOZVlqgE6/kShszI/o0D2rgsEXPWu8a2+
	RIYJJf3Ots625NOH7gGoyblzWOa/Neb/XAqWREnGxCBDgtFecPYB0JRCDAlE9qUKcdd49XfE+q+
	7V9cRAWWx7dsfDEC2JpbmjCkJXcX7wAlMcaowTqPq
X-Gm-Gg: ASbGncsvCCb6mA7UK3jM+A+IhLGb+w3TTh1zAwdYz0aEQCPBq2x0ACaX6uFUX0gfe3m
	9v2PiVnoShxoWuF1HrMSXCDF9wKo2+JszTXEBPVK+JIL1KFlscXIgkcFag8No147EzKIV1XoKdw
	S7f3pWD2rEmxgfBFWvJkqu0h2KvZ2OiuwRt6l8vLzvMjbjIyXQu7GQ7NinsAZC4lH892u4d1GTr
	pu2sZdnZVwPojv4HuaX9tqr+xUEaPNYd6fM/IZIIEYCfw==
X-Google-Smtp-Source: AGHT+IF4nBN7l8BVpT48NL044EtxxNCfvAewP1ZUdA31VvrzYipiWFMocffu+xLGFjFA/wIBhY4ZsuRqkeecG+8Cpu0=
X-Received: by 2002:a05:651c:3241:b0:32f:522e:f040 with SMTP id
 38308e7fff4ca-330a7b352d4mr27431031fa.12.1753096197351; Mon, 21 Jul 2025
 04:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721081459.16278-1-laura.nao@collabora.com> <20250721081459.16278-7-laura.nao@collabora.com>
In-Reply-To: <20250721081459.16278-7-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 21 Jul 2025 19:09:45 +0800
X-Gm-Features: Ac12FXzx8td7SOjqLltSsFYEC21ZPF3VEQHs0mR_h7cbh7ksB6i9GixQOdHUn5w
Message-ID: <CAGXv+5Fgha-3xAa8gOEsub0u=Qr5RjQVzkyPoZ=iDkJL_KCXEg@mail.gmail.com>
Subject: Re: [PATCH 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	lala.lin@mediatek.com, arnd@arndb.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nfraprado@collabora.com, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com, colin.i.king@gmail.com, bchihi@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 4:33=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detect
> abnormal temperature conditions, which involves reading temperature data
> from a dedicated set of registers separate from the ones used for
> immediate and filtered modes.
>
> Add support for ATP mode and its relative registers to ensure accurate
> temperature readings and proper thermal management on MT8196/MT6991
> devices.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 34 ++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 3c34956e37c1..8f9da0d5b886 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -44,6 +44,10 @@
>  #define LVTS_EDATA01(__base)   (__base + 0x0058)
>  #define LVTS_EDATA02(__base)   (__base + 0x005C)
>  #define LVTS_EDATA03(__base)   (__base + 0x0060)
> +#define LVTS_ATP0(__base)              (__base + 0x0070)
> +#define LVTS_ATP1(__base)              (__base + 0x0074)
> +#define LVTS_ATP2(__base)              (__base + 0x0078)
> +#define LVTS_ATP3(__base)              (__base + 0x007C)
>  #define LVTS_MSR0(__base)              (__base + 0x0090)
>  #define LVTS_MSR1(__base)              (__base + 0x0094)
>  #define LVTS_MSR2(__base)              (__base + 0x0098)
> @@ -90,6 +94,7 @@
>
>  #define LVTS_MSR_IMMEDIATE_MODE                0
>  #define LVTS_MSR_FILTERED_MODE         1
> +#define LVTS_MSR_ATP_MODE              2

Nit: I suggest changing this to an enum since they are related, and
also because these are artificial (unrelated to hardware values).

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

>  #define LVTS_MSR_READ_TIMEOUT_US       400
>  #define LVTS_MSR_READ_WAIT_US          (LVTS_MSR_READ_TIMEOUT_US / 2)
> @@ -207,6 +212,10 @@ static const struct debugfs_reg32 lvts_regs[] =3D {
>         LVTS_DEBUG_FS_REGS(LVTS_EDATA01),
>         LVTS_DEBUG_FS_REGS(LVTS_EDATA02),
>         LVTS_DEBUG_FS_REGS(LVTS_EDATA03),
> +       LVTS_DEBUG_FS_REGS(LVTS_ATP0),
> +       LVTS_DEBUG_FS_REGS(LVTS_ATP1),
> +       LVTS_DEBUG_FS_REGS(LVTS_ATP2),
> +       LVTS_DEBUG_FS_REGS(LVTS_ATP3),
>         LVTS_DEBUG_FS_REGS(LVTS_MSR0),
>         LVTS_DEBUG_FS_REGS(LVTS_MSR1),
>         LVTS_DEBUG_FS_REGS(LVTS_MSR2),
> @@ -621,6 +630,13 @@ static int lvts_sensor_init(struct device *dev, stru=
ct lvts_ctrl *lvts_ctrl,
>                 LVTS_IMMD3(lvts_ctrl->base)
>         };
>
> +       void __iomem *atp_regs[] =3D {
> +               LVTS_ATP0(lvts_ctrl->base),
> +               LVTS_ATP1(lvts_ctrl->base),
> +               LVTS_ATP2(lvts_ctrl->base),
> +               LVTS_ATP3(lvts_ctrl->base)
> +       };
> +
>         int i;
>
>         lvts_for_each_valid_sensor(i, lvts_ctrl_data) {
> @@ -656,8 +672,20 @@ static int lvts_sensor_init(struct device *dev, stru=
ct lvts_ctrl *lvts_ctrl,
>                 /*
>                  * Each sensor has its own register address to read from.
>                  */
> -               lvts_sensor[i].msr =3D lvts_ctrl_data->mode =3D=3D LVTS_M=
SR_IMMEDIATE_MODE ?
> -                       imm_regs[i] : msr_regs[i];
> +               switch (lvts_ctrl_data->mode) {
> +               case LVTS_MSR_IMMEDIATE_MODE:
> +                       lvts_sensor[i].msr =3D imm_regs[i];
> +                       break;
> +               case LVTS_MSR_FILTERED_MODE:
> +                       lvts_sensor[i].msr =3D msr_regs[i];
> +                       break;
> +               case LVTS_MSR_ATP_MODE:
> +                       lvts_sensor[i].msr =3D atp_regs[i];
> +                       break;
> +               default:
> +                       lvts_sensor[i].msr =3D imm_regs[i];
> +                       break;
> +               }
>
>                 lvts_sensor[i].low_thresh =3D INT_MIN;
>                 lvts_sensor[i].high_thresh =3D INT_MIN;
> @@ -907,7 +935,7 @@ static void lvts_ctrl_monitor_enable(struct device *d=
ev, struct lvts_ctrl *lvts_
>         u32 sensor_map =3D 0;
>         int i;
>
> -       if (lvts_ctrl->mode !=3D LVTS_MSR_FILTERED_MODE)
> +       if (lvts_ctrl->mode =3D=3D LVTS_MSR_IMMEDIATE_MODE)
>                 return;
>
>         if (enable) {
> --
> 2.39.5
>
>

