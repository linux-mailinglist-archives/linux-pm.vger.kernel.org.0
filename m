Return-Path: <linux-pm+bounces-40478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3D3D04936
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2433368E782
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CDD2882BB;
	Thu,  8 Jan 2026 15:43:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8142D9EF9
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887038; cv=none; b=QbE7ySDIv5p9y36+UTVC0fj5F99F29t1U4NOm2/gqMZtqZ7oCxZKmbSYMcBgSj44Ho6g8EnWmtIKfD2KVd4Bb/WrvTFIUiH2kH8/QtZUpCySTYR894w+WwmZ35oeZF1mLHypspRUL+IjBTdIVV9JpB6DWVyGmOoV+s5Kh0uIHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887038; c=relaxed/simple;
	bh=szg4XoxN3u9g+Ff2h/pAFUtLTJUETFvDphXYepeSKBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4mCneLkcTLhFTGr6D2Jo8931N2H6FBV7S75OKSIEDkMHfFopPaumaPSWr2riaJEWM4R2HwG6QDNx6oEdNzXqcuAzBxOH97fsjGJTjuI2wJpD1vDMkLozWS3tGuIayYCi952kkz1UJ8vFcXsML+nYahWtY+fXoi+8SInbB/OgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93f63d46f34so992560241.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767887035; x=1768491835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAzoJbmxW9Hq33LekfntKKNhXdUxUdN8KMqCFiNMSXI=;
        b=qx7lbcANWTGR9yr1Hj300UhquL0gghFLnKcEysREbeWGckAXa1fC19z5Y8niRNXGXL
         mcnwTJFtxsbf7n+Z2ICgzcdZ/1JmYNHn8sQyySgIClBSHn5Vkojzsi3ovlDt1R71KB9i
         JjYC89BRhRxp+en3uzKY00TOrNJQBCGPX1exIryYpqr3b7iSZpCdRnIdtgoJlTGjmULJ
         bPsxxFk5DdKur4Anwo1COsE+Dlwb34PH8kU6ULVbh1nI6yfAq9XBakYWvK/FB72D6SbG
         rfFD/nqHi4FkUHsS8P8DswYDXjKkzZYVOcMlyb4WwCzC356KZ5bIs03w6N5Rbqg3xJdp
         pS5w==
X-Forwarded-Encrypted: i=1; AJvYcCWa2+rSsZK4+vbQXrhCHfXcZJOh4Q4+if4OUGV648IK4aUB0HjgDtMowxVrzhKBFtihZ4ja2ukeYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxylNWajm7wvVD8ZlYIQKbrl4Id5Rs6ctEkZF3Wg8+l0Sj90UX
	33kxy+rLFwSguYFmvyj/5JQNH7vsKES/sneBB/BBfTsNHpT1SdSH/ewD9dISs2Dv
X-Gm-Gg: AY/fxX5K2SSfq5vM7FaAZC+METR8j+e/9+qfUtjF/ouTdM7vJ/vlfYIP4U6L500gYpi
	WxYWx+XpNho1Z2GnSQL8DSLSNfEiDgLCX51WnUfdu4XdvvJ9ML9IyT/V8h2EUzFDTi6KE5ONbDW
	fLPYLdSWR+ui/4MZlt2FMwyCmB6zjqJcp7Cv9TcN0Sbs7m+wYihOQ4E/JFb7Q16eGsTXALkKc7F
	bHPc3CMhXIg6jhXisESEO4Ed3kK18iFJfTNlPTxJZVIWbaSxarHfl6vVYWUXDTKX8mOgc6vyaAq
	EcAL5qYdtQ5VXYI3y0bPfY7mqf3yhvYcUINWaQPGSCGYYhdRBg900u7VnK6HMxWVsRHpWux803i
	4TF5lTNCP7vadmctjd2JJoG+2AimpNu/i2cku7U7D09kWQWuG0rKScQx4fd8Fxg8mZ8CLYvCn0X
	owKOwVWl8MHwjDJ4hlxYSdD0o2L9zDTmZfNkRj1cFqUVezuuu6
X-Google-Smtp-Source: AGHT+IF8Pu7hWsZfsfnFdor+3HKYugCrQ4A0VUw8sCDQ0jvIHQWto7ERaIJxjm8PnmBKganruihZ6Q==
X-Received: by 2002:a05:6102:3f91:b0:5dd:840f:a449 with SMTP id ada2fe7eead31-5ecb1e95d1emr2443655137.14.1767887035284;
        Thu, 08 Jan 2026 07:43:55 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ee9fe7f478sm1674971137.3.2026.01.08.07.43.54
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:43:54 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dd6fbe50c0so1327917137.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:43:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoiZW1s1SwxwwmHxUJssUAQhXGm1oQp1icwTDHSu6ZsB2j68qe7IvCPUXsnQeJ2y0xxYqnH86Bvg==@vger.kernel.org
X-Received: by 2002:a05:6102:554b:b0:5ea:67f4:c1ad with SMTP id
 ada2fe7eead31-5ecb68aff05mr2439515137.21.1767887034584; Thu, 08 Jan 2026
 07:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-9-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-9-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:43:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9zNBNtUNwLN4SgDbMpvyMOBYVhVwufgB4zC+F+OCgVw@mail.gmail.com>
X-Gm-Features: AQt7F2phv5yFw7C9wXRwfNBduSHOcvNWuCOsJEw2DhFFHSG9sOONm1vVQhQj4OQ
Message-ID: <CAMuHMdX9zNBNtUNwLN4SgDbMpvyMOBYVhVwufgB4zC+F+OCgVw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] arm64: dts: renesas: r9a09g077: add TSU and
 thermal zones support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 14:05, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) SoC includes a Temperature Sensor Unit
> (TSU). The device provides real-time temperature measurements for
> thermal management, utilizing a single dedicated channel for temperature
> sensing.
>
> The TSU loads calibration data via SMC SIP.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi

> @@ -952,6 +967,37 @@ sdhi1_vqmmc: vqmmc-regulator {
>                 };
>         };
>
> +       thermal-zones {

I will move this after stmmac-axi-config while applying, to preserve
sort order (alphabetical).

> +               cpu-thermal {

[...]

> +       };
> +
>         stmmac_axi_setup: stmmac-axi-config {
>                 snps,lpi_en;
>                 snps,wr_osr_lmt = <0xf>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

