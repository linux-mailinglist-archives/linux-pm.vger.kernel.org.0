Return-Path: <linux-pm+bounces-21449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F0A2A322
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EF43A47BE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199CF225760;
	Thu,  6 Feb 2025 08:27:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264622541C;
	Thu,  6 Feb 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830426; cv=none; b=YAN1nrxDQ0x5EhsF1jR2GU+aLi5lPa1Oxn+4S2uUGN+hLUi1P/8YnpYqxpiwQd/4T2CgmZYBHOtRVlbY/RSf7tq6sL7tKz3LzOV1TlpkAuVl6L+kTKLtfI6d1ebdTlseMzRLcrYRElpXKJvTwpdBQLW5vC3TIPfgF1MSpuDvoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830426; c=relaxed/simple;
	bh=CggEDzLVrJ/5LVza6ynbodRY6rSUx2uk81kQJmtuv2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsuArUEiu8N1JR5vkUmfJwpXOeS27lGNM2AUf0Mxkv9i3gfGh2PZdOwsnQ/hNWF0pR6aCrKbMJykf/pJlvftQ28babxQQ72Lb1LyxRRetWENHZFwvxAU7WRu1GeDJ0mYxqJW3oui8NiG+aSaKnm39pQoGNwebpLCxj+B8Dlir0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-866f2f6ffb8so158423241.2;
        Thu, 06 Feb 2025 00:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830422; x=1739435222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow/L2GzL/jAzXYN2eE61/QWPEdvBuOGmNTlDQL9aSwc=;
        b=rBwzTBX6i7FQalam3GDY/n9phs9vzjQdiNbPTAwUY15aft6olUGzz+jQNQgrBr9W9r
         qzidEXLqLi4lyMcj60Ju3r7x6VSWpud9868XiQvOHZVzenNWtO9AqJi0iyyCoEX7vLDL
         0nY4FzNGEb/OC0+NY++138U/ai/1wp63VhIgsxPCwyjddHXNZpK2LouZk1KtxowjKrmQ
         m750zo7zzYUJFx28DOIR8DWFx0Njf3hDbUpnWixNQrDyC/y0z0OGC0alQ7rS89/8qJhA
         PKPDqhVRs1XrS36lZrDs28CW6Htar342vCHi8A+yyWuepS295qwMRNjBE+gEp6iRwlE7
         6dZA==
X-Forwarded-Encrypted: i=1; AJvYcCUMZrcDumQkhaqM1JVNlsC8rbajHbtDToEtf2Rhp77z05rzItIcFIEdpGUXRS+93RMsAo+ncjxIbdo=@vger.kernel.org, AJvYcCUwLkJil/lw+ErNUz5K4Ht1IXF+dTHCY0+SQGPTy+CjXlKzrVV1aEvMBykl/PyYi1sBeJ9oFH53kCrL@vger.kernel.org, AJvYcCVEwJPK3YW3DOKtV1qzFsPHybAT3Dhva+e5Mdls7//zkh9B6YahuX+D0sk3/jq/Z1lx4xAIb4+WNK/XM6/Q@vger.kernel.org, AJvYcCW4Be5wzQBZLmWslYzolz8falUxVrLarTlTEMcLB5V8IqTWEsN8ozr+PhElqoW2jr7rbsXyadKH6v97twPx4rlrohE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1r+UHzbVJ2T7jDi/eyCGQwe+TDWMTHSBkrGvOuDzSDN79iLP0
	u870CDEzv6bJzhoFcOGdrEjiOEiglx8gYe6vb7Zf6hOxActPkEHWDB/6eDp0
X-Gm-Gg: ASbGncvhlTcPcqfFPGO/1XXlnPCG0iF900PJ42WEHuukKuBBSjfPCxU23NPM9eBviD/
	/Gkj7JUwYWh541iTrL5jcvhfuKRhvYhPjnD/FPtvMCRVaZxXNe4xT0oc/sC5uStBg45/ghkIluC
	XpJTybSd3TjcHF9aw18hrIw3AgJjHXjo2jBEftg/bMZUX5HWAzElTb/N5S3PyDBhr+xida0kXjX
	jCv7ngN7sCCTr4BySdr8tQHzvAxvcimJ1dKlQWbtO9H2DPMy0x562RTuw8TISGEvDhfsNpxkM/p
	u1ybuaiCi4NP9j8tsg9tv02doJQKeiMuA5Q4MW9YK79hbzlEF8jOsiB++g==
X-Google-Smtp-Source: AGHT+IE+Tq46mXhzIQwHlKaelaP9p/cVp+b8AfbRwFaSDwnS7qL5oU0Auy4oJ9aMZxendPXz1CFsBg==
X-Received: by 2002:a05:6102:3c92:b0:4af:fca2:1b7 with SMTP id ada2fe7eead31-4ba4791e09fmr3794560137.14.1738830422435;
        Thu, 06 Feb 2025 00:27:02 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866f9636a9asm133155241.4.2025.02.06.00.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 00:27:02 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso176131e0c.1;
        Thu, 06 Feb 2025 00:27:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVabSl0glEhPP8LYbZmoyZz7e26uju2d0u2DasM1BxKpLronMLv4VJg7R7uSzD0FWXaVD+ou4lsy4pRdW6FTain8nM=@vger.kernel.org, AJvYcCXDFflgPeIUn8nHks4Ar2WiMgpoiTJSpmeIy2EmPiZnchh5tIP4DEvd9Ox0u2HnWY4KIqLEZtFAvG8=@vger.kernel.org, AJvYcCXJNp18bE7OlILp/Y2Q8yQ69486ewezThaBCZdfp5z7R/b76S2x3rMZG4rTElABFre4V+YYL4OUjPT5Lew2@vger.kernel.org, AJvYcCXXmx0yPUESsDk5G6vFvjkq/AZrqNF2tJYTx2ngmBGUjsHSTHnGatjwJQZmQKukdZ16+0Kvhf6CRYjc@vger.kernel.org
X-Received: by 2002:a05:6122:438d:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-51f0c51cba6mr3179751e0c.8.1738830421760; Thu, 06 Feb 2025
 00:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145616.2691841-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250128145616.2691841-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Feb 2025 09:26:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQm0Mk3C7YC+kquXP6qR3-uEYbvhzfJJfL2EZeDosz7g@mail.gmail.com>
X-Gm-Features: AWEUYZlVQ4f3o3IWlTN_KbdaT7BiYfwBQECNt_v-P5YDGTwkJCgpWNDjcVHsolE
Message-ID: <CAMuHMdUQm0Mk3C7YC+kquXP6qR3-uEYbvhzfJJfL2EZeDosz7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a08g045: Add OPP table
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

CC Energy Model

On Tue, 28 Jan 2025 at 15:56, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add OPP table for the Renesas RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -28,6 +28,33 @@ audio_clk2: audio2-clk {
>                 clock-frequency = <0>;
>         };
>
> +       cluster0_opp: opp-table-0 {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp-137500000 {
> +                       opp-hz = /bits/ 64 <137500000>;
> +                       opp-microvolt = <940000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               opp-275000000 {
> +                       opp-hz = /bits/ 64 <275000000>;
> +                       opp-microvolt = <940000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               opp-550000000 {
> +                       opp-hz = /bits/ 64 <550000000>;
> +                       opp-microvolt = <940000>;
> +                       clock-latency-ns = <300000>;
> +               };
> +               opp-1100000000 {
> +                       opp-hz = /bits/ 64 <1100000000>;
> +                       opp-microvolt = <940000>;
> +                       clock-latency-ns = <300000>;
> +                       opp-suspend;
> +               };

So all voltages are the same.  This means the Energy Model (if enabled)
will always pick the operating point with the highest clock rate, just
like on R-Car E3 and RZ/G2E.  Apparently that can be fixed by using
"opp-microwatt" instead, but I am still waiting for feedback about
some practical points[1] (yes, the Ebisu-4D is still on my desk for
this reason, and thus unavailable for remote access).

Thanks!

> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> @@ -40,6 +67,7 @@ cpu0: cpu@0 {
>                         next-level-cache = <&L3_CA55>;
>                         enable-method = "psci";
>                         clocks = <&cpg CPG_CORE R9A08G045_CLK_I>;
> +                       operating-points-v2 = <&cluster0_opp>;
>                 };
>
>                 L3_CA55: cache-controller-0 {

[1] https://lore.kernel.org/linux-renesas-soc/cover.1728377971.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

