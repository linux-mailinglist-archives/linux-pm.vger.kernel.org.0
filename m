Return-Path: <linux-pm+bounces-17190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D049C17CD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 09:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3326BB2453D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 08:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFC1E1034;
	Fri,  8 Nov 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqZ47e3J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59E1E0E11
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054082; cv=none; b=FaBQkW3VRPi9o0B4kqzTq+fjDOdiX1Lq1q/mfS0dpXjSok+86LN/mUcwbqMAbphr58aAlqlwF2d6de4VeI9ATN2trEH+iSz9woIOpQXsuLSUTGGK9bLbs6HEHytNBHsufmlw7t8s8RF/BmnEbjqWb7bXpb6WmHbbPdasTq+1Lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054082; c=relaxed/simple;
	bh=eWjhfFl0lxuSZTAzDN6LrwZdoPNmukVNi4I1AQ4yInM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw1UGdSiwttWPgRjNNsqvdVCo1Mtzp95hFtUDXKIYjc/r70EVmnYjfofbGu8g8ltrBCp0TTaYT61FbT/ZqLBoZ1zxFxX53WM5lu7ht0XCwv3zdTCVz1VP1yu0f/BBvnqHnw30/eeXcWFtLfQMJJ1/I3kBHsvrkQrP4ofhLoIA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WqZ47e3J; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e63c8678so2008847e87.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2024 00:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731054079; x=1731658879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4o7fhe2V5dd+UE3dA/uAT0KHoDiGtLUhf89NGPnqv0=;
        b=WqZ47e3JDJW0cVbUiikMLQJF947kEb9C96g9AMeL08ZaL5TXYfRJud4fKZWxYDu2Dx
         3HVpRvYhUgGw07OX30bSleJWjtWuj+MoaeaO4sxZ3PSfwEo6Ibb+C67wqN1WkNgt2ko8
         tCeKqFk0JkCxaCrpTihYNPkZwoJS4hUK06A7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054079; x=1731658879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4o7fhe2V5dd+UE3dA/uAT0KHoDiGtLUhf89NGPnqv0=;
        b=rnZEMy49ikoEs85Jn+5+MGhoDgZ3Tqcc6P6mXOgeyL+8olnjuM5607hGUpFs4AgNiT
         +HBowOK/xgn89X/Rux2m95+Uv63OWEBtgmgnUKbWXpBq1gz+T5vk7+20Vh4xPRQfnIOH
         /mKiTv6cho8Ct5bLakLL8T8fhP2h5jXdDqY1eMSTVIDkIX9PTk67XIaTRSMDsivQQtO4
         kmLy5C3zO1IWj2GzcvKppSkn4JkJ28bdmnpbFz6jkRmWXbUPgh01eGIQ0z1W+UmAFMHv
         246sz21zcu7GV8dBJBCQJcKmpPexvXQ+akoqrQiQpGMwqbaBwOBgApKsZgr2UxRuW1c/
         9+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsSJhGeqKjMcOqYEuEH9Ucz16yszHbbK6tpVtZjEati0TftywAVCmlsGHKEsQRPF4F0ztPxyOnDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4fOHI6WuOUO2JBwfLeuCbzgPVlOC4R2FbKURN7sOsJ3BJsEW
	KGaPqL4l8NGZxS94wTo2T+6gyAM84Pdp7RLMyt6Kh4+4bcZthvoZEcNuVLXPWvUNU/WzpT5y+X6
	cmDBr18La5g3dF1r+f4RMs/fcjyG4V4wP/kjL
X-Google-Smtp-Source: AGHT+IE2S4gjvQOpSK8kJaaKxLV5rdskh4etefXYjl17eLQ1scFoBJFDNNCqeEcFChM7or3BIVTeHmM7tSYZlf0ID34=
X-Received: by 2002:a05:6512:ac3:b0:539:e513:1f66 with SMTP id
 2adb3069b0e04-53d862fe1cfmr903159e87.37.1731054078864; Fri, 08 Nov 2024
 00:21:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
In-Reply-To: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 8 Nov 2024 16:21:07 +0800
Message-ID: <CAGXv+5EOcg0pQxj=iOn_ff8-t6pyGKwemA9mdn=VCpxg6Uzt+g@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Switch to IMMEDIATE_MODE
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:51=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> Currently, MT8192 cannot suspend with FILTERED_MODE. Switch to
> IMMEDIATE_MODE will fix this.
>

Probably should have a Fixes tag.

Also, Nicolas previously reported that the threshold interrupts don't
work with the immediate mode [1], which is why filtered mode was used
in the final version.


ChenYu

[1] https://lore.kernel.org/linux-mediatek/37680c5e-e61c-410b-b48d-82991420=
0e4a@notapiano/

> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 1997e91bb3be94a3059db619238aa5787edc7675..daad52f14fc03d0c4131f2ffd=
f3eb6b49a4a43d0 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1541,7 +1541,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 },
>                 VALID_SENSOR_MAP(1, 1, 0, 0),
>                 .offset =3D 0x0,
> -               .mode =3D LVTS_MSR_FILTERED_MODE,
>         },
>         {
>                 .lvts_sensor =3D {
> @@ -1552,7 +1551,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 },
>                 VALID_SENSOR_MAP(1, 1, 0, 0),
>                 .offset =3D 0x100,
> -               .mode =3D LVTS_MSR_FILTERED_MODE,
>         },
>         {
>                 .lvts_sensor =3D {
> @@ -1567,7 +1565,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_=
data_ctrl[] =3D {
>                 },
>                 VALID_SENSOR_MAP(1, 1, 1, 1),
>                 .offset =3D 0x200,
> -               .mode =3D LVTS_MSR_FILTERED_MODE,
>         }
>  };
>
>
> ---
> base-commit: 906bd684e4b1e517dd424a354744c5b0aebef8af
> change-id: 20241108-lvts-f7beb36efc59
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>
>

