Return-Path: <linux-pm+bounces-40402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930FD00035
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20E2A30133F1
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151233385AE;
	Wed,  7 Jan 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHQDRTu4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01C3385A5
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817799; cv=none; b=kdHOEwkEY5G2sDXPsd41xEdQ+RSqw9dE1EiTqfO/Sj1I3jxCtedsOSWRm/R2OKWV3SpDQgCtHQ6z9e4HtY5MHDTQsQl9rNJ+X2Be1Is+YYhY9qrdXDLAX4Wu+aaiVYbyd9UFD8QmuX5iw9Yy6m4Odusu6JKL8cOgaHVC8JUJqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817799; c=relaxed/simple;
	bh=opfaAiSj+TWRnyQswcaANR2Atg1XQUFlZQUyPX7ANPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=minpYqBnK3qrRLaa6OOT/7l7yuhNZdxrbKFh1QTYDjuUDPR5vMBiLYFfMk2846DqsjazJQyOFWdoRJLAWtNlAGcSyLsQQihh0D50rL5IaiaPxcWe7nTnEYHlAJTanYzL476heNKBMFY6WDa7L4z/Z6Vls9IC2Hlwtr92msVABYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHQDRTu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7CCC19424
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767817799;
	bh=opfaAiSj+TWRnyQswcaANR2Atg1XQUFlZQUyPX7ANPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IHQDRTu4giiHwsCtC7RTWGueP/Yq80AtTNdAzR7l4AZfIVIL88a8Dm+A4t/l8Z+ba
	 rBf68Z6QXPuirk+Bp2pZSrx1RnniN7J6ezXx8sdL+WWBFCi62HEnjppWxtzZkdQZqf
	 ivNusVlRxCFi9INbGvDAzESstc/YhNmIJga6O+3IMtegIlTpJVkmZUks3PRyorxfK3
	 BNHi3qpkPlxolmU97qf2ifzA+Zjx2AtP4vb3KQK8ZzHiAzy2QU+nbjTy0zlIN5jdpQ
	 RbW1EkWk3VJK9ZpnMloI/sZkYxhcFboAAW0J8kzCCaanoEiZDVPDyEsw95GF5qBND8
	 rMz1Kn357SxiA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65749fe614bso915559eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:29:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/Yw1Ueh49f/BVG70yiwJttiV6voVcvZa58Z6fEWZq7R+2yga0txSiCV6ExLBuKganv0Du855cng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZszNS5uTYJ+s4MErbM/01bEBcxumnmH8wXhC6KQO6/NiAWcL5
	L6EOO9YZx9sW9cAa9GJ417XEKFcxqG5Tl3MnrVqy57sAY9xMtQQlIkaRIS4LT3kMBE8Q49bNWeH
	yDmCtadwhUDRQrE5VMO6lxfW9xjjmIW0=
X-Google-Smtp-Source: AGHT+IEcALl0YuMQh+RAFTvVHjniKG5GNUIpHS5sV8evAUbGtc8yFM8IU02JvZOwj3cRc3mRry/jBJJj3Tq3usO1feY=
X-Received: by 2002:a05:6820:168c:b0:659:9a49:8e46 with SMTP id
 006d021491bc7-65f54ee943amr1664986eaf.22.1767817798275; Wed, 07 Jan 2026
 12:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216130943.40180-2-thorsten.blum@linux.dev>
In-Reply-To: <20251216130943.40180-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:29:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0inW7X5q7m+5Kqm0gzVAiWRrcjFFe5ZyDYKgQrgwJsuNA@mail.gmail.com>
X-Gm-Features: AQt7F2q9QXSZvgJ_goP-wJUZbX-DGv3cp5O0mSg5RsrPknj6mM7_vx1tYAvv8oc
Message-ID: <CAJZ5v0inW7X5q7m+5Kqm0gzVAiWRrcjFFe5ZyDYKgQrgwJsuNA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Use strnlen in thermal_zone_device_register_with_trips
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 2:10=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace strlen() with the safer strnlen() and calculate the length of
> the thermal zone name 'type' only once.  No functional changes.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Format the code differently (Rafael)
> - Link to v1: https://lore.kernel.org/lkml/20251215121633.375193-1-thorst=
en.blum@linux.dev/
> ---
>  drivers/thermal/thermal_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 17ca5c082643..90e7edf16a52 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1505,15 +1505,19 @@ thermal_zone_device_register_with_trips(const cha=
r *type,
>         const struct thermal_trip *trip =3D trips;
>         struct thermal_zone_device *tz;
>         struct thermal_trip_desc *td;
> +       size_t type_len =3D 0;
>         int id;
>         int result;
>
> -       if (!type || strlen(type) =3D=3D 0) {
> +       if (type)
> +               type_len =3D strnlen(type, THERMAL_NAME_LENGTH);
> +
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

Applied as 6.20 material, thanks!

