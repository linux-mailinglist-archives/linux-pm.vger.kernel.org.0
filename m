Return-Path: <linux-pm+bounces-31186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA07B0C0D8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102B716EDF0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA428C87B;
	Mon, 21 Jul 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XAdhfoSZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8028C2B3
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092505; cv=none; b=UyK8JZPi7W7QznbEdbX4UYnrTB55l2UDWIM+LOyWE2ABPzRuZGP9VBl0gTkl1CfI3QjXxyRJGxRkdlNU0PVqLvfMbV96p4fiV6/gfZj1EBQ/K7PDWN32ZAke2m5xj6LNpGzgl5FeBkoO67Bixgdm1xF0iDFGMh2ZnSy9x+mmecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092505; c=relaxed/simple;
	bh=50Ubmg4LfSlEdX6k4IcF145XqGsrPBSvcnbfU9xKeLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSBPUVtDUj+z73h1qBC3NplXa6GbvrPf7xTigwcjY1rSrpg3zob/f4BcF91GJO0oOBaEzvN6pyMQzNuxB9LShAfQPjHw0G3xB1pWp2A54WP9c0OurgzLWsaDLAZS9S9rh398Po0cv4QOWtZWsxyU/Syz6IziGcw0+oOvcEs6We8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XAdhfoSZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55502821bd2so5183751e87.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753092500; x=1753697300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD8rxQd2ghX7oxkvwv9EZVZXOQiPMsFApAotllBQSeg=;
        b=XAdhfoSZONUfQGU3zAjMmLyhemuNhljyMd5NAsbQk58mafPj4HvRBYYF9MnlAMZ28C
         vqeFad8XNUQ5B5h9pGJpmRYYw28ZyG/evVPUfOdJuPrcay/J2a8HjGg3hTDgBoMDIL1A
         pcaF/BxAjhYZ2zadjJWIZ1dgaMD5SAS0R+0gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092500; x=1753697300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD8rxQd2ghX7oxkvwv9EZVZXOQiPMsFApAotllBQSeg=;
        b=ttQPnUS/9hL9SJ39ODe6sAqRAQl2MOPWAumc9S1MlUpzkO9uhBZdplCKIhwkrUq1g9
         yI7TDtlmoRoDAQ+8X8Jg8xhf3QyOvAlu4hrSSv/Rhm8DYa54fld9NaHFbBzbNPV3q65r
         Zl71bec/Lagj0cfLeRY1V+TvdXw++7wNRnhcNN5WhrqDbHinoOCpy2fpU9JYZyRz2s3z
         drZgHX+5T9pTRPGnaLiQTxz6EMnFNa3w03SZfxYq0r0aFis5+lx6jdFJBfO+BgdfKFFH
         F/sFDHOReAS7ypoW6kAB6mLxTp8hmrqSWglU60fsOFHrNqwV/szxo0JxZ+Z7D2SIjaG+
         Ekuw==
X-Forwarded-Encrypted: i=1; AJvYcCW4AMzZFoOcleEcmxJRXrvFdjECeswwh+Iv1F7E0mKGgFbdMjGdI/Wra5xHyxmoZfLdv/7ugnc6Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YysbIo4YcLWQhax1CCSOhEm8LhPkir3uXIBgVsxBRzvHUi8hMJb
	eACs2Da79lb7BJT8x3LZ0S9hBxUFB1G7ztwaWFCTpWeKA5G2rfCoy38EhjuksEGl6nzEWv6SOJ1
	qQd/TRnuMPdiGbZDbYFMwq9TC6LmT9yGOaKdEzMJd
X-Gm-Gg: ASbGnct75JrhchaxDicDwhyJXiEz1tgmwy98QwbboD5NBJVDxwEInQ08mZgksT7oUSE
	MBej/uoQDPy7GatsQ5itx4NEggUgKpkcVd3G+6o8d+aom/TT5/5qKR6r8ExBeeqBQHAzeu1ejME
	eAxNX8R1esE1jTpU4Iy47jQFn+89lxJBaEh7rLVW+xprFKp/h9PQmQ3LGpdQB7nJ62HXCUA9YyR
	+CRg0zOyOSS1DW8ZE5wV7fc14mtZGo9HKs=
X-Google-Smtp-Source: AGHT+IHi6PdCwFOePdyUiSBZQls+DPW7XtyOQBhq5kUoIJmQhohNKReJGJb1oSImXRjY6TmgwESv8Tvn2SOgxE98754=
X-Received: by 2002:a2e:a99a:0:b0:32a:8916:55af with SMTP id
 38308e7fff4ca-3308f4c5e9cmr53974251fa.2.1753092499826; Mon, 21 Jul 2025
 03:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721081459.16278-1-laura.nao@collabora.com> <20250721081459.16278-4-laura.nao@collabora.com>
In-Reply-To: <20250721081459.16278-4-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 21 Jul 2025 18:08:08 +0800
X-Gm-Features: Ac12FXzBhOOgbkI7YQgVr-Zp96LKQsUci_34ENr1pVVGZfl3HxcKeWbG5MiHa8I
Message-ID: <CAGXv+5F51DiCHi_QPeDKOGCwvgM6HpmRjEjSgS8-mh=Fg1Fr5g@mail.gmail.com>
Subject: Re: [PATCH 3/9] thermal/drivers/mediatek/lvts: Guard against zero
 temp_factor in lvts_raw_to_temp
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

On Mon, Jul 21, 2025 at 4:26=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
> division by zero and ensure safe conversion.
>
> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff c=
onfigurable")
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Code wise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

However I assume this would only happen with bad platform data? The
factor should _never_ be zero. Maybe also issue a warning in the probe
function?

ChenYu

> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/me=
diatek/lvts_thermal.c
> index 8d5259b9d03b..b80c2929ae74 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -280,11 +280,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_=
factor)
>
>  static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>  {
> -       u32 raw_temp =3D ((s64)(golden_temp_offset - temperature)) << 14;
> +       u32 raw_temp;
>
> -       raw_temp =3D div_s64(raw_temp, -temp_factor);
> +       if (temp_factor =3D=3D 0)
> +               return temperature;
>
> -       return raw_temp;
> +       raw_temp =3D ((s64)(golden_temp_offset - temperature)) << 14;
> +
> +       return div_s64(raw_temp, -temp_factor);
>  }
>
>  static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
> --
> 2.39.5
>
>

