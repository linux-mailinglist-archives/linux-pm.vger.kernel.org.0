Return-Path: <linux-pm+bounces-39634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F7CC3201
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 14:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13057304229E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810D3446DB;
	Tue, 16 Dec 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JORHmz3Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E643446D3
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887544; cv=none; b=UMD3wdKgQQBZRbB3Q/8n4Jo6E3CtQSOfSvIUiYW+OHv5k/yaQUX2BjpcZApOpvWzGsqEzgYOR1qYZnCvoOdQz7CT1PdMh+o3N2RZoug6knwi05/aCYXlUaoDHGMKNhUVgYiyU/zGEsIjnGQObci28ChonwCp83BLJHoKvBTQzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887544; c=relaxed/simple;
	bh=cbfTLWarFJGwc9xWrcnkLcdWupdCDcKErBjldS2Ykdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZdQV40hCwm29SIh0TACh9lYsnkfLIKptGrHbLwOss/PVRi9oGYDcHVDzU6rC2r2OyCR8xcC5Q0kMGlITxejyE2zQts55+MCexe4yZ1yPc2ybJnUEXLeYjXnaVPmRd4PTpHOQciHqmENnjH4Ykca5xdJA1y7syuyqlKitzQzdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JORHmz3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B20CC19423
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887544;
	bh=cbfTLWarFJGwc9xWrcnkLcdWupdCDcKErBjldS2Ykdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JORHmz3YbCVdG0gaq1kFwkhZDvV0UeLK6O19ZWJswMHR5FKmzNSnG/cRea9qtpzKB
	 r78Kw3eMVDH1XVUIrsixpDmFmqsjVSr63/67//mz/4JgQGFsLSv/ORdMjYqm8rGOL7
	 1Z9wjtvymErFoVFg5lw7FGH74UPXRA/aPEVzPoMPZ0XwwvQGaxoh2q3xHu/drcC62V
	 RtLewxJKH7vUwkToEaBq1P9gqAZzXJuSn6efssU+qLpqcR3pPOmr1DGl5N1dSNpTFR
	 JZ9bZgpYfahs/NLRGD+HrJWvgNk2mzB6z+dxkQD3tYDS1b99qIbZcL0szYGRs77IyT
	 33padsTYowz2Q==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f584ab62c6so1798522fac.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 04:19:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXs0ikPAsiSFF/4OPAYcXNuDw4V8Ny/K/1uW1J8Eqh7sdAch6euzJ6IGUoxJM0FR9AgS2HkT833tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHpKYec99ZaG4yFJ3dlp1vneuaLXU1fhnIFckhtg/Fm+hNXp2
	kluae/RBsNpsDwwHedZwfgXVU/mw/wwwE8RrAH7hNymqW75/j386Ni7NwQNJOHoVVLgY/H4TZ1r
	2d7x9ZilrZluxAkyWeIIcCF6tcnm5OA0=
X-Google-Smtp-Source: AGHT+IE3RVLCrld8HqJMEUwOtY5GnXiOrNzUs+b68FRGRTzbi0ToySIstKUf3kP4nyrzbW2bagnEYGPJN0P44x3i/To=
X-Received: by 2002:a05:6820:198f:b0:659:7f3a:7d55 with SMTP id
 006d021491bc7-65b451518b0mr6675143eaf.6.1765887543565; Tue, 16 Dec 2025
 04:19:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215121633.375193-1-thorsten.blum@linux.dev>
In-Reply-To: <20251215121633.375193-1-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Dec 2025 13:18:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gKsG43isrXPezvAtkZ6juRnTkaorXE_7QO_RSvDq-www@mail.gmail.com>
X-Gm-Features: AQt7F2pZEccnnHsJ1OosNBc72QhrkKUQ4OX0rYr39_AlWBYf8JdfnIDnH-Aib4c
Message-ID: <CAJZ5v0gKsG43isrXPezvAtkZ6juRnTkaorXE_7QO_RSvDq-www@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Use strnlen in thermal_zone_device_register_with_trips
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:16=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace strlen() with the safer strnlen() and calculate the length of
> the thermal zone name 'type' only once.  No functional changes.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/thermal_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 17ca5c082643..63eb35b449c6 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1505,15 +1505,17 @@ thermal_zone_device_register_with_trips(const cha=
r *type,
>         const struct thermal_trip *trip =3D trips;
>         struct thermal_zone_device *tz;
>         struct thermal_trip_desc *td;
> +       size_t type_len;

size_t type_len =3D 0;

>         int id;
>         int result;
>
> -       if (!type || strlen(type) =3D=3D 0) {
> +       type_len =3D type ? strnlen(type, THERMAL_NAME_LENGTH) : 0;

if (type)
        type_len =3D strnlen(type, THERMAL_NAME_LENGTH);

Pretty please.

> +       if (type_len =3D=3D 0) {
>                 pr_err("No thermal zone type defined\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (strlen(type) >=3D THERMAL_NAME_LENGTH) {
> +       if (type_len =3D=3D THERMAL_NAME_LENGTH) {
>                 pr_err("Thermal zone name (%s) too long, should be under =
%d chars\n",
>                        type, THERMAL_NAME_LENGTH);
>                 return ERR_PTR(-EINVAL);
> --

