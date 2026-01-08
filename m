Return-Path: <linux-pm+bounces-40494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00260D0529B
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 18:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3A843027E5C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E093A3033D0;
	Thu,  8 Jan 2026 17:43:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A42E7BDC
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894187; cv=none; b=uW3rZpOb9HoK0d5t0KYNI9w5qoIiRtt3+GYZLivhfAwKqiFMfwK5glvxClwZj2PZIVxq6Pm9f3OsBgWtfyw7VwGlz5jWahGTjcY2MEC0jNVgVWctXDnCjpjiI3nGWE6Ve0kilpLtT5iATZq2UsiI+k1LD8vPlSYBMH/kYxhlCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894187; c=relaxed/simple;
	bh=GAMmRH8WG4SuwJpSk40B1/V0uVXYQJKFg56MoYwmk70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcHaX+gICMaoZ7+ic911lJVJ8xEyBwjeyXcGD9rhg1Voi9tTLuM0koVBBHHmZ21eyus3H51BzZ8d0VIGNSn2YuBkaUSX+wAmIgFS0ZcFW9X0sVe4kHyLfHwg6V4P7tY0RDI/HaPyB15wFpg7iPENWyCXRonMfyGNyhuzYMZPwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-559966a86caso1069849e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 09:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767894179; x=1768498979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfe9XNi/Cjru8cNLH+ivGd+Nm2hyK8hmMgtx6v7K+ro=;
        b=bYg7O88gdDe7dlUvlPbUojxX2X9S+qRK3Y469IbN8k7rnLEcRXKdbTqnwG2FmqwRTY
         FivCoOsVmGxu+5mOZ3EWNxhUYotmIYXFC+1YpPmbxkO6ftf5oZWQFZvVxHd2JdGJn3R5
         km81GtTmRz71eLBzHship3qHTfhg/+5Ud5RdBdz5t6m1Bwf6IkgiycwAq1bd/+p0iKyq
         UgXIafrVV958RcolKaH99enwCwz9Nbylg0TW5xc11Fy/TJJUaAbqHCqnx2KB1gTlQx77
         MF0wRBm8PnBcun+vuxZ9RAzLRFqklpn4OcWmIgC0Ks+iUZsYALbDEsLMOmtfH/xcsJyl
         QAig==
X-Forwarded-Encrypted: i=1; AJvYcCUQO2/DOsc2nnnWM9Vvp1F3zow/TF6w24bVvXaOO7xJFjl1+64ecIB+4L+af+cIf18hPuc148DPEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+3T/mqHbgP/tqdQyxqR17hsat53ZdVOCN0S55CqhLl4ovB3o
	U/ZR3Ikoj17yapRvgZw/cGnxoLrPApZXVBctCW1Lr0R+mv5Chxocp6PgcSEbBqU+
X-Gm-Gg: AY/fxX5Grj3Sp+NISvuYymL2e30j67/psEeTYDilzEShEOmJcrtwhC67GQVhSBW29bi
	i0uzaRdpAuzmWggn6tUxK5J3J/vQdJ5S2Y/TIIMYrAFT3RpEt/s3l8Ghh0hdvxTUZuFiFyg5UgB
	W0A+aX+o82pzLvKByex/Mg5rxTalSkiFqzPcuzTvRJKbFFA55Xg0XLnXIXChMDR5TCw/fl2zi0/
	iv5PLftqs/OoN8KcIhYBdxjogIIO6LMFNXCzJfEkj6u7n9HB6Pdefkeo/ryq3SNdd/FckQSB6Ri
	vUjbZujr0aECAJ94elcrAOwU1Ljlvvqr4XRefgjB6D1+36s9nODWCJr69kDSta1zLpXD/cjGXYr
	NkYy/h2tSv8o9JgKvU0QAnIL7RZTO4N4QeKPRFE9O1L4+8jr8cTPV48QzpHFEvF8G9AK2AArzp6
	GT3ayyl8hukS7Jb90d8fCQyM5kJWn2ysLen5bo6Nrbc/uN/MjKofPbAD11iXw=
X-Google-Smtp-Source: AGHT+IEYiX2gt0xasuBPKT2rGsmQ1S4pclQDx0D5EiVIG2MHZWQsR9NlcSMYLR12cDHGYjyhPO8fRg==
X-Received: by 2002:a05:6122:8292:b0:559:ed61:46d8 with SMTP id 71dfb90a1353d-56347fb4492mr2100955e0c.10.1767894178983;
        Thu, 08 Jan 2026 09:42:58 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a074d30sm6860559e0c.0.2026.01.08.09.42.58
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 09:42:58 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93a9f700a8cso1170391241.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 09:42:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLNLkvQkB4YfBRxisrfkbgsUtOLZCapzP+5KULiw0riyA6Isw8xxvY8LkKohf7SxG4y8m7rXhzHw==@vger.kernel.org
X-Received: by 2002:a05:6102:5cc7:b0:5dd:89ad:1100 with SMTP id
 ada2fe7eead31-5ecb5cbb74bmr2376260137.6.1767894178396; Thu, 08 Jan 2026
 09:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com> <20260108165324.11376-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260108165324.11376-6-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 18:42:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0G92JmwneZp1h+AOF-Cit2scVGGWXCBZGwBVmJjUAVg@mail.gmail.com>
X-Gm-Features: AQt7F2oaRcSSM-TJ2lzWvwve1kr4JhP9eX1Et_7XoG_piUmKankXGgTr0tEIJaU
Message-ID: <CAMuHMdX0G92JmwneZp1h+AOF-Cit2scVGGWXCBZGwBVmJjUAVg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Thu, 8 Jan 2026 at 17:55, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> temperature calibration via SMC SIP and do not have a reset for the
> TSU peripheral, and use different minimum and maximum temperature values
> compared to the already supported RZ/G3E.
>
> Although the calibration data is stored in an OTP memory, the OTP itself
> is not memory-mapped, access to it is done through an OTP controller.
>
> The OTP controller is only accessible from the secure world,
> but the temperature calibration data stored in the OTP is exposed via
> SMC.
>
> Add support for retrieving the calibration data using arm_smcc_smc().
>
> Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
>
> Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>
> V4:
>  * pick up John's Reviewed-by and Tested-by
>  * replace new macro TSU_TEMP_MASK usage with existing macro
>    TSU_CODE_MAX

Thanks for the update!

Looks like Gmail blocked my review comments on v4 :-(

> index c1b586128fa6..ba13ca8cbb8c 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c

> @@ -362,6 +366,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
>         return 0;
>  }
>
> +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
> +{
> +       struct arm_smccc_res local_res;

Missing #include <linux/arm-smccc.h> (on e.g. arm and riscv).

> +
> +       arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> +                     0, 0, 0, 0, 0, 0, &local_res);

Can this crash? E.g. if this SMC call is not supported by the firmware?

> +       priv->trmval0 = local_res.a0 & TSU_CODE_MAX;
> +
> +       arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
> +                     0, 0, 0, 0, 0, 0, &local_res);
> +       priv->trmval1 = local_res.a0 & TSU_CODE_MAX;
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

