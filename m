Return-Path: <linux-pm+bounces-23225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5422EA4B117
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 12:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183EA7A1FE1
	for <lists+linux-pm@lfdr.de>; Sun,  2 Mar 2025 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C11DF26B;
	Sun,  2 Mar 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aooXR+7V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25E1DDA1E
	for <linux-pm@vger.kernel.org>; Sun,  2 Mar 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740913936; cv=none; b=DPBDKcI40UhwmcG6vdXV0SR/ic+iXRT7wYWGO7vpeFb1BMlkjQxb8YxmwiOK7kYQfmEMzJs5zq1wvN5npg0QU99R1rHOUenNskxMwHmV7rLqT9YgkPy0365R9ymGdT/V3Z7QoBgFg7YL8DAlh/avk5fA/5iAzGOfRbwX8LKhrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740913936; c=relaxed/simple;
	bh=r/E6LYdvBIOak/3//3gj1xJnve0xQ99P5eZuiofdHBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+oE8lWhdsVR/6Kx2yDb3JyKcyDn2oSdFSgIRk6XIjhwDizZNeZjCW+pFG6Uq4129P+GBz66+bu9Fsb6Jgwbn6U2ymGcbkqK4mLbFWZDEma7Zkybl003ACcpCcCo46BN0+Oy8YW/N4L/xFSXbwV+KpuqiWrHGdgLzdmCoDNaN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aooXR+7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135A2C4CEE5
	for <linux-pm@vger.kernel.org>; Sun,  2 Mar 2025 11:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740913936;
	bh=r/E6LYdvBIOak/3//3gj1xJnve0xQ99P5eZuiofdHBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aooXR+7VXvcH/6f6zYxI/NB0+JCxNoNsNcXKPniLlNfl9QzReuxQUe6U+TObi3bJw
	 8EKv7Lp2XjlglDw8aYX809DkRNHxb4CjV9mwjiANdoU515uFJdI0OSwmUcyOiq0pYk
	 i3dkWhuoKm+ifsYcwOhGiidlkzWd4A54Qv/6j2l8rpC9c6SxfPZes52+f4LDdDzbWH
	 fUkekrEFbjXMt7ou4u0DkmL1EeWCORefX55+pOtCSGZqIVLBH7m3Q1WN2m7AF6yOZg
	 wXwCh0q8heLNsgpZVPp9rdJXXaZTffYcIqYJqZ0iM8A1A3bHP2XykyGh2Tps4N781K
	 sSFPYDfJKzdEg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so697007566b.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Mar 2025 03:12:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3CBik/icKwaF11xpbS4Bh5vR4DJDijISOQiP83oqlwwhxm8NdqPN2kH2HlcE8tp6VoC0AeI/0kA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh246KrOi5jIZq9Qys7hPsJZQxQh3N5Tyssfpv+o5+7jvIV8qq
	b3Rla0E+0uQD1nBIYItkW3eKJnf9dA5RlQJTUQrSbyzP2G6HWAwFvpGqcLkOQEVWp81igZsh0oa
	nCyUwOm8ouvC4mnQ5vzW1bJMjBuKLJxmHygPnsw==
X-Google-Smtp-Source: AGHT+IFd32O0cccPkVHyQRUGAgtLUbYK+uQRte/DydLBmgbHW6tCrbh5UXeoEHiox6cW6eWJEnsnCGH2skEnueF6o6M=
X-Received: by 2002:a17:906:6a04:b0:ab2:b84b:2dab with SMTP id
 a640c23a62f3a-abf261cdfa0mr1142238466b.30.1740913934658; Sun, 02 Mar 2025
 03:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228051521.138214-1-george.moussalem@outlook.com> <DS7PR19MB8883434CAA053648E22AA8AC9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
In-Reply-To: <DS7PR19MB8883434CAA053648E22AA8AC9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
From: Amit Kucheria <amitk@kernel.org>
Date: Sun, 2 Mar 2025 16:42:03 +0530
X-Gmail-Original-Message-ID: <CAHLCerN=jDXtsGCGUMaerh=-oSZf4+ExdnvVHFcXTjjTRvW-ig@mail.gmail.com>
X-Gm-Features: AQ5f1Joo-9vQhdZihXI6_SZRgjhU3sAL0Uv-PUaO4J3qP3ecnI1uP64WCbn4VBE
Message-ID: <CAHLCerN=jDXtsGCGUMaerh=-oSZf4+ExdnvVHFcXTjjTRvW-ig@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] thermal: qcom: tsens: update conditions to
 strictly evaluate for IP v2+
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, 
	thara.gopinath@gmail.com, dmitry.baryshkov@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 10:46=E2=80=AFAM George Moussalem
<george.moussalem@outlook.com> wrote:
>
> TSENS v2.0+ leverage features not available to prior versions such as
> updated interrupts init routine, masked interrupts, and watchdog.
> Currently, the checks in place evaluate whether the IP version is greater
> than v1 which invalidates when updates to v1 or v1 minor versions are
> implemented. As such, update the conditional statements to strictly
> evaluate whether the version is greater than or equal to v2 (inclusive).
>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/thermal/qcom/tsens.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 1f5d4de017d9..43b388bcc7d6 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *pr=
iv, u32 hw_id,
>         dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
>                 irq_type ? ((irq_type =3D=3D 1) ? "UP" : "CRITICAL") : "L=
OW",
>                 enable ? "en" : "dis");
> -       if (tsens_version(priv) > VER_1_X)
> +       if (tsens_version(priv) >=3D VER_2_X)
>                 tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
>         else
>                 tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
> @@ -499,7 +499,7 @@ static int tsens_read_irq_state(struct tsens_priv *pr=
iv, u32 hw_id,
>         ret =3D regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->=
low_irq_clear);
>         if (ret)
>                 return ret;
> -       if (tsens_version(priv) > VER_1_X) {
> +       if (tsens_version(priv) >=3D VER_2_X) {
>                 ret =3D regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id]=
, &d->up_irq_mask);
>                 if (ret)
>                         return ret;
> @@ -543,7 +543,7 @@ static int tsens_read_irq_state(struct tsens_priv *pr=
iv, u32 hw_id,
>
>  static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
>  {
> -       if (ver > VER_1_X)
> +       if (ver >=3D VER_2_X)
>                 return mask & (1 << hw_id);
>
>         /* v1, v0.1 don't have a irq mask register */
> @@ -733,7 +733,7 @@ static int tsens_set_trips(struct thermal_zone_device=
 *tz, int low, int high)
>  static int tsens_enable_irq(struct tsens_priv *priv)
>  {
>         int ret;
> -       int val =3D tsens_version(priv) > VER_1_X ? 7 : 1;
> +       int val =3D tsens_version(priv) >=3D VER_2_X ? 7 : 1;
>
>         ret =3D regmap_field_write(priv->rf[INT_EN], val);
>         if (ret < 0)
> @@ -1040,7 +1040,7 @@ int __init init_common(struct tsens_priv *priv)
>                 }
>         }
>
> -       if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> +       if (tsens_version(priv) >=3D VER_2_X &&  ver_minor > 2) {
>                 /* Watchdog is present only on v2.3+ */
>                 priv->feat->has_watchdog =3D 1;
>                 for (i =3D WDOG_BARK_STATUS; i <=3D CC_MON_MASK; i++) {
> --
> 2.48.1
>

