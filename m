Return-Path: <linux-pm+bounces-3926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2043785540A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 21:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB28A2847E5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B6013EFED;
	Wed, 14 Feb 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHK5MzdJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E2433D1;
	Wed, 14 Feb 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942708; cv=none; b=YUZRWU4qOs8XDPzs8piHygAAJV0cCHxx4Y/88VEgEsLK+djLyRN/SeN2/G/b87DyYb6p6WbNl/RXlmlZV2xLZ1nvINcFIlcexph0mxpTHJwYpcKp9rOJRyFU1ov2nblWkVXg4QQ/HDHjYZugKNgtYUKjEn9yMr7tAedtazrEurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942708; c=relaxed/simple;
	bh=Lgk3C099a2KCc+S9pK08eZpliFuZsqBXvxzz2zm7K/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGyqUdLeD3UaCGHy69KPTP603fN/IdBYy+EePL3q4iOLzfjb2bH5YeW62e8nZWTzrZDX/t46ZEIF65yNF5yu5wGSCUTzJVtfsQNJXhX5UcT92c5yQ5AuHNle4hYOfdIY233/oAVtfrrTOB6EqibgX9M9EeHa7uKu0pjGnxUj/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHK5MzdJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso1038335e9.1;
        Wed, 14 Feb 2024 12:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707942704; x=1708547504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poFBgT5whWeYH5dyu5dJ6KrDGN+Ca5xEvs0UEciRlZE=;
        b=VHK5MzdJtr81JsdTypdtkUZkxspbvPJXJuUpKBbZBdh7BA+PXk1H9+uzuVrl0AwJfO
         V28z1m9vpkiuhcBCvcopcb0j0/HbEgBWPidu+eKgz3h75ZrmgC2M4hVDC+MI2MoRoEBo
         fAZQVblt0z4WekfCJs7uCBhj4wt+yhWC+3qcEwpGDDLamRzCexhV0Kb/FwCiv7NZ62k+
         EJsk0FL2NHDv1C+Fq62eQuirK9Lc571NWb2Ozn77BJKwjChNXEI8ipQmdNexX//5qX2H
         OwGm4bSpzdGhiWsuYUgR/I5l2qOeuJTf2Z5qZD4ySaVkwvr06zcuNPqVoHlltGBTVMG3
         dLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707942704; x=1708547504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poFBgT5whWeYH5dyu5dJ6KrDGN+Ca5xEvs0UEciRlZE=;
        b=dO8IZ2eTbPS9AtydNSJTUTnOV2cuyrOAbEMctyy1RxBS3CeRZ8sThdglAJpI/tOo4x
         4h3P5GIhX1kPaEyytNE03u45MXdiy84bBsg0hQfizNBwmo0CvbZuhYexqwmUDk0bMQVr
         +ompK3XP5Oyl7dAK4gAcsaIMt6+aVAPEJ+6TP3zCvKKk+eRTUidVCnk4/tgfWUVaKeD7
         GyEIGLtLZ11ry1IAdSonCFFRHpldbvkNJV0Yup7xABJeNti/GgC5Nf5ihUGZuZ8Qr9YH
         fRyoT8oaMt2TDWPdqxL87My/ZtED7ZtMM6KmGRYMYHYjRsgrnkPgm0/XA3SVsC3lNT1g
         3S9g==
X-Forwarded-Encrypted: i=1; AJvYcCU6rrQggKEueV1+HlnHX59eqt8qc+W8tanfEo785dDqPnqK203OGR1nWiDznblTY8Gzm7nyMYoEfbOr5Jy8/pH2roaPdhFxHe72v+oMCBhax9+6XuhDhjr568EeA63zp4OY0mgT
X-Gm-Message-State: AOJu0YxBR9vHmZI43uv/HgYAmYPHEV4MWO6a8A8PKTiSZZMbXV5m1pfG
	C+nYk+ByIYhrZVvYtI9pmxmrGE3mehldl5irUauTH8N2tFREzrfe
X-Google-Smtp-Source: AGHT+IHdHTJdArjAeA9q7r6aKMEmpLgsuX56jLcA4O41GZ4yoXGsnDo4teq/QnLJlTqSAuXSDaOkNw==
X-Received: by 2002:a05:600c:5107:b0:411:c8a7:7b6e with SMTP id o7-20020a05600c510700b00411c8a77b6emr3006463wms.10.1707942704547;
        Wed, 14 Feb 2024 12:31:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUl+MJ6r0kdZ0I0u2FKzvWnTzN1C98F8FB1kXY0mHVsijNsLwnLQDFkSUGlQkaQ0GAf6l3aXN/nTCEQ182oH1u6mixlFKc20elJGyfWwZiMdg9zxVeoM0HDDeWl4cHdueaiU4GJE9wGgjalvq7YUceCmyJlCW7OPXNbAye1CFOUfq8lG7OaSCUF0GXK8Yz5T9gq4Qs/dhb1bE9UUU/wcp+UB2MIqLUDHF9jqiIW8HbqTHvqp8nBr3AbkaPxlxsVcCeZx25luYeJCqi4985jLtm7yIWwYXvrWmgQ2E1Iopktxoi0PO5YPihoX14Bpv5CUIPk3NMfKTfp7icHgsFNqj69RDAK/M2Ps4P7FO9lhuRh/texyxxaIdLtS60aZXMHvAqGQ6KFlCh3PgjRhGbnrt2fNXJgyouZW6Uh6a1Yvk4jKwLuB+qbXyQmJ6tmxsrFCOP1QTWPNuzJs/STY8d1paxa6VNPJ7WAjSdoHZ12gFWg0EMfeyOP+D4AuPmxfpI0EeDX30og2hfGQekJoIVboNnpxBX2NyA4+rwnUy0/ENBbr+T+OGgtwy1ls7ymS/nA8I3t9UB0KJCf9qkFAALkx++Cbih4lz6pgYFr57FVgiisbG50bpcShg==
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id bt9-20020a056000080900b0033b75d0993esm12320613wrb.74.2024.02.14.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:31:44 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 3/7] thermal: sun8i: explain unknown H6 register value
Date: Wed, 14 Feb 2024 21:31:42 +0100
Message-ID: <3274538.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20240209144221.3602382-4-andre.przywara@arm.com>
References:
 <20240209144221.3602382-1-andre.przywara@arm.com>
 <20240209144221.3602382-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne petek, 09. februar 2024 ob 15:42:17 CET je Andre Przywara napisal(a):
> So far we were ORing in some "unknown" value into the THS control
> register on the Allwinner H6. This part of the register is not explained
> in the H6 manual, but the H616 manual details those bits, and on closer
> inspection the THS IP blocks in both SoCs seem very close:
> - The BSP code for both SoCs writes the same values into THS_CTRL.
> - The reset values of at least the first three registers are the same.
> 
> Replace the "unknown" value with its proper meaning: "acquire time",
> most probably the sample part of the sample & hold circuit of the ADC,
> according to its explanation in the H616 manual.
> 
> No functional change, just a macro rename and adjustment.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Nice!

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/thermal/sun8i_thermal.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 6a8e386dbc8dc..42bee03c4e507 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -50,7 +50,8 @@
>  #define SUN8I_THS_CTRL2_T_ACQ1(x)		((GENMASK(15, 0) & (x)) << 16)
>  #define SUN8I_THS_DATA_IRQ_STS(x)		BIT(x + 8)
>  
> -#define SUN50I_THS_CTRL0_T_ACQ(x)		((GENMASK(15, 0) & (x)) << 16)
> +#define SUN50I_THS_CTRL0_T_ACQ(x)		(GENMASK(15, 0) & ((x) - 1))
> +#define SUN50I_THS_CTRL0_T_SAMPLE_PER(x)	((GENMASK(15, 0) & ((x) - 1)) << 16)
>  #define SUN50I_THS_FILTER_EN			BIT(2)
>  #define SUN50I_THS_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
>  #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
> @@ -410,25 +411,27 @@ static int sun8i_h3_thermal_init(struct ths_device *tmdev)
>  	return 0;
>  }
>  
> -/*
> - * Without this undocumented value, the returned temperatures would
> - * be higher than real ones by about 20C.
> - */
> -#define SUN50I_H6_CTRL0_UNK 0x0000002f
> -
>  static int sun50i_h6_thermal_init(struct ths_device *tmdev)
>  {
>  	int val;
>  
>  	/*
> -	 * T_acq = 20us
> -	 * clkin = 24MHz
> -	 *
> -	 * x = T_acq * clkin - 1
> -	 *   = 479
> +	 * The manual recommends an overall sample frequency of 50 KHz (20us,
> +	 * 480 cycles at 24 MHz), which provides plenty of time for both the
> +	 * acquisition time (>24 cycles) and the actual conversion time
> +	 * (>14 cycles).
> +	 * The lower half of the CTRL register holds the "acquire time", in
> +	 * clock cycles, which the manual recommends to be 2us:
> +	 * 24MHz * 2us = 48 cycles.
> +	 * The high half of THS_CTRL encodes the sample frequency, in clock
> +	 * cycles: 24MHz * 20us = 480 cycles.
> +	 * This is explained in the H616 manual, but apparently wrongly
> +	 * described in the H6 manual, although the BSP code does the same
> +	 * for both SoCs.
>  	 */
>  	regmap_write(tmdev->regmap, SUN50I_THS_CTRL0,
> -		     SUN50I_H6_CTRL0_UNK | SUN50I_THS_CTRL0_T_ACQ(479));
> +		     SUN50I_THS_CTRL0_T_ACQ(48) |
> +		     SUN50I_THS_CTRL0_T_SAMPLE_PER(480));
>  	/* average over 4 samples */
>  	regmap_write(tmdev->regmap, SUN50I_H6_THS_MFC,
>  		     SUN50I_THS_FILTER_EN |
> 





