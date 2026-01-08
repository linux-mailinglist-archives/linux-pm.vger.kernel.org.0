Return-Path: <linux-pm+bounces-40479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4ED04276
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 878E23027587
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AB2D1907;
	Thu,  8 Jan 2026 15:45:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B0266B72
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887110; cv=none; b=qv/I/ycneu1fwJd468wjs3dwYP8S5XV4csUxqYsj3mjWNAlmZlqe08ho7mbw3LnDrfi9LX+vX5QqFgagjVs0pV3kilNppWqJHH8D7UCkysT1IlQ/j65HtYgqCMnvi5SowRgomwyeXUvjPsu2wJkpFTRgLycVq2n11R8hjjuvm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887110; c=relaxed/simple;
	bh=BBsNKmsId5cR8LindZ/7FZKftktXvKprwoHo7JbEZwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9n/plMmRkpKVUIfqqIdnEikipGA+29CNMTRZLLBTjv6qy78zy7sddQwHqLUz860MGxxlttacHbHEnZsL/eM7LVhrNzmdH6roHhafsJBUmbWM67eIyd0OaR8uTICkuGU+IaBEL8BINrhVoCZqMa5hhedyCqnHPBJPcFzP87wFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5eb3c50c688so2297998137.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767887108; x=1768491908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx9OXbti98lXjfXlLYihiIxjP9eLHg+VOozfKRmOdZY=;
        b=HF4mLdab33JnE3tP+UetAfr0R2B25DrNXIGwb2dFfPOm78roXrerGKq48yUj7XcOvv
         aRvtI+2XN8GoOLSX/+xnEjVdM7FEcBIwrx5iacNmZ9wQ0nnsqlP44FWtc3cfeC/PyK1i
         nqjTRjxuZFN9+b6hLTvH5iQyDDrs+7buzIIXAekidqD5TtesZMmWkJ8lVJDV3gAoGN4D
         hVObHJ1ScO42ARpZRoa/5w8BK8SYmfAevKQPB8o33pjYYn2gs9V1K0sbwBoIso2nM53r
         DrawPCNzJbT3ZeVCS5VcmFldn4jcOd9+KJekeItesGvvfPxXf8pn5+TLkTfHByutnbmw
         xpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCULYfmdmWifudDiVj8ZPHbb7I/fc2OJ9YpgwtLMoXjed6QOKrFT4uXV+tsrA5wkAaD/VSFyCJelQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4RQYlTkYIDyehUVHJttTzCnkbNUHWvUCerWwp3mKyXlug0oH
	43gnGeCRRW7VI2EsW7EuLhF8m0jECsFi4ojlR6UpLih/ZyWCDDdCufFVh71kIrJd
X-Gm-Gg: AY/fxX6YswZNolmp+e76BZNPsux4lSiCWGonooaoEZUUYLY95xIw99Db25/UZfXqiHw
	9TLwWjFACsSuLB2+Qn5QjJNcx6cPbzOyWyS9XRYfASppyyxsMFSLBZoYdv+IZpQmv4aTmw7BEv1
	yDU1q8dQiw2pZ0ZhkkX6BKvtdrfOLUdZp3L0kDAr2gjkBYOmcySWJit2XCP/7avIx8+66miR0uR
	eA/7+CRaMImIzA+zqfRYQ3MuCVoEab07dEebu7TENnOi7PIyszOcUtMgdRX0qppchxbvwXPvVQe
	XZVSSb9j+U+1wiEYYM00byNbUXSo+J5P0oWEEpQE1EF6iqkczjanyaXv2HQzfXrOnkGcM+7Iewi
	2AK9VDUfLNH+hmNKHsrSYH7mOQw6wBRPPQ/F9Eh0Ow8kTZRkyPN18PXBAjPYqwM9+CdYzl/oXVN
	BGLkJtiPx+7ORfQ7t66QHsdM5GHmanbVjLF4/kVH/yLIxAMu6j
X-Google-Smtp-Source: AGHT+IF2CSe7ns38BkUIpf7cdp17SzADFDEdxN9MskAvZE5NOl6ucUTWj+h2uws+p/M18dSV1h9EaQ==
X-Received: by 2002:a67:e105:0:b0:5ee:9fef:68d5 with SMTP id ada2fe7eead31-5ee9fef70bemr859457137.41.1767887106635;
        Thu, 08 Jan 2026 07:45:06 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944122d6132sm6504411241.5.2026.01.08.07.45.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:45:06 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5eb3c50c688so2297969137.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:45:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6813/PqQJO/+oW+TYpzzWyV22NSI0Tg9QVXOySAzI/Imyudlbv0vazkyZ/m0Ot/eNnwf8xOSE3g==@vger.kernel.org
X-Received: by 2002:a05:6102:6050:b0:5ed:d33:a65d with SMTP id
 ada2fe7eead31-5ed0d33ae20mr2185253137.34.1767887106092; Thu, 08 Jan 2026
 07:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-10-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-10-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:44:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWajzk_NxzmgvazqO-SHiifqtq42rf84JeAQPD8jzEAGQ@mail.gmail.com>
X-Gm-Features: AQt7F2qatq2GmDh9d4ZT43bcryI7HhqWDkEF1PCTTBINYtLEjKdyngOLyqdhCe4
Message-ID: <CAMuHMdWajzk_NxzmgvazqO-SHiifqtq42rf84JeAQPD8jzEAGQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] arm64: dts: renesas: r9a09g087: add TSU and
 thermal zones support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 14:05, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/N2H (R9A09G087) SoC includes a Temperature Sensor Unit
> (TSU). The device provides real-time temperature measurements for
> thermal management, utilizing a single dedicated channel for temperature
> sensing.
>
> The TSU loads calibration data via SMC SIP.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

> --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi

> @@ -955,6 +970,37 @@ sdhi1_vqmmc: vqmmc-regulator {
>                 };
>         };
>
> +       thermal-zones {

I will move this after stmmac-axi-config while applying, to preserve
sort order (alphabetical).

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

