Return-Path: <linux-pm+bounces-39550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC2CBDA73
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBA63062917
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0389F335BAF;
	Mon, 15 Dec 2025 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggHVA/NO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A06331A4B
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799340; cv=none; b=WSrK2/s9+10JrAMsevogH1BLAZgOY2jq9LCfXBzaurGz37lU/WAN94xEYuHe8KRl3ao4je/5N1VwHW8Vl75q/KiR5dNNcziQ3XQeB/7H+CUsk85W6bGlyL0VOhNJsLEbePlphDYEQ/r2PnQHfXyErn1XajTgwFwhAVZ5indEzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799340; c=relaxed/simple;
	bh=AUGS/vVbcguCwXN5yc6vQmfH4RTztPxPeY+c1WLm1FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrDDa1Tk43GnSrlEGISaatgpulmYYDBmnJIEwP70n0inMJQ3q0hUQmcvqDPUlT7LNG8gF0/HSQK6Tm0KKNocyg+8rmTb1C/fWxxl0I/FxRYLhU5WsKT55U1uGEL7w4dwtogIacAdYv9MbbgJZ31dwUtToDXF85hsCblFapesFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggHVA/NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E233C19422
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799340;
	bh=AUGS/vVbcguCwXN5yc6vQmfH4RTztPxPeY+c1WLm1FI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ggHVA/NOUBmWUohkua2CpDtsOqbhHlmOAVq3DLR2lIriB8ocWN2tn8mjoluGtGbli
	 hH4oTtsn1yV5ZTNP+24p1VuxnEgkg9Fkwv7pd82bwySxLtWhhvhdgz6ZcTkJT1YjVG
	 cczdaK5lGbVGevmYoEyLnPBKR6zpCEJ/rXg9ZRbJgDKjjVbHXWKXlJMKBe86h6Nu62
	 CFrhJDdu5MFIhphT5sXdMdsGos+KCQ+QOktLfE5G/P3zczmJVXwYj8SpsGgHtKmsFU
	 /ifUhvfxO/ZLm5EvNyWA8/Y/mXw/gCnA0+jWbXZubGFtD8U5hfwOpxrspqhHk4KXzq
	 xISdAlZQa4kYA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65745a436f7so1969527eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:49:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxA5jVhDih0tbv/52ZYUvTibwf8v/0WDNj2TKkLuZB/i1yo5eo+xhVB1AcSY9bmU2Lm0e1H/vVsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99DRT6lDcqHar5J62cobxN9gWWe4x8xptAITkovWa2a0sDi7+
	QJzstWGbrNzX4nfLoHWRESXx41S0TknFoQ5xOLEAM6taEU3Ym0ZPLUJAuH0CHiLRRLrxoYR/BNx
	Kf+9IkMr92olsePgOvHmxHAzebef4vXI=
X-Google-Smtp-Source: AGHT+IF/Qj+JInQuPO6tj00ydDWPh6KJRpwYPRoeU77wpSqnTNSeng1Sd24HTAHf+Wm6DHnBIfefeHMklmABHLHPySM=
X-Received: by 2002:a05:6820:4b92:b0:659:9a49:8f7b with SMTP id
 006d021491bc7-65b45736584mr5142201eaf.64.1765799339861; Mon, 15 Dec 2025
 03:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251206174245.116391-2-thorsten.blum@linux.dev>
In-Reply-To: <20251206174245.116391-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 12:48:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h9m_wPrm57ZDPritAe9S45eKfi=RE9gfx5yR0PR9KXDw@mail.gmail.com>
X-Gm-Features: AQt7F2peFLEMzTm5dQEYZS9QsU0fQiUAzEz_jfQEEg-yFkJc8JpyNMczxUmd5yE
Message-ID: <CAJZ5v0h9m_wPrm57ZDPritAe9S45eKfi=RE9gfx5yR0PR9KXDw@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Fix typo and indentation in comments
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 6:44=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> s/tmperature/temperature/ and adjust the indentation of the @ops
> parameter description to improve readability.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/thermal_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 90e7edf16a52..dc9f7416f7ff 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -500,7 +500,7 @@ void thermal_zone_set_trip_hyst(struct thermal_zone_d=
evice *tz,
>         WRITE_ONCE(trip->hysteresis, hyst);
>         thermal_notify_tz_trip_change(tz, trip);
>         /*
> -        * If the zone temperature is above or at the trip tmperature, th=
e trip
> +        * If the zone temperature is above or at the trip temperature, t=
he trip
>          * is in the trips_reached list and its threshold is equal to its=
 low
>          * temperature.  It needs to stay in that list, but its threshold=
 needs
>          * to be updated and the list ordering may need to be restored.
> @@ -1043,7 +1043,7 @@ static void thermal_cooling_device_init_complete(st=
ruct thermal_cooling_device *
>   * @np:                a pointer to a device tree node.
>   * @type:      the thermal cooling device type.
>   * @devdata:   device private data.
> - * @ops:               standard thermal cooling devices callbacks.
> + * @ops:       standard thermal cooling devices callbacks.
>   *
>   * This interface function adds a new thermal cooling device (fan/proces=
sor/...)
>   * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bin=
d itself
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

Applied as 6.19-rc material, thanks!

