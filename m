Return-Path: <linux-pm+bounces-2213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9405B82DDB7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195C91F2244E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148F17BC4;
	Mon, 15 Jan 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjUYZaEC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AE17BBE
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso7425795276.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705336757; x=1705941557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/fqnYPq+dkxltZBpseJmaWi5P52GcYKf8Hz52+kYdw=;
        b=IjUYZaECxzKfYLrIA6JZzfm/WyjSzCqj+ZaR3B/yqVXZfdIbfIalky8b+JGoH3NI3K
         oIQhhDgEQUm91cIXyGgYivNQxQiONX5/J6XVIGuoD9YqKc5uEfmnR2iVx2ibEQnklPcV
         7kHm7u0Az29VHRc5AyX57An1zAQB5RtH0Gyj0/ezzU+K0GoPhA1zPzlI7j0ML5MpbNyb
         aUjb7v5PdTekQKR/bARWs2x2Cp0CAZMDiXsBN3D4WKvh3FckB9/Vssb334V71DaNV4d2
         GjQIHsHTvOqIlAH8qeRtzLs5mB+s8z9sUNqD64FNeWIOhtvsAxshySe7SV9q1/sJzBm6
         h7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705336757; x=1705941557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/fqnYPq+dkxltZBpseJmaWi5P52GcYKf8Hz52+kYdw=;
        b=ji7Ijypz65vXbZ29NSZhFYIU2GD7YIaAlUXxG+KyofiVDJHU6k63QLAi1g618+KnWH
         khlvSDOFukfhX7zzZpLZpYKwfR70GNphpu6ulKmWWoEreRujXV+whr+/IKtnywGDX31z
         8ypQwgg0nDMwgANFmdwNjHbe+02JJAWkV+g+WqmQxpmCA9FAA2oCu6+hmtBe4E9fOcrx
         vuRh49l49fM6LbBHCxJCQ0PReaNPdmsIm8/0QmtIwDSYxbgrGq01tcfbTVTrydu1WyaE
         AF7N2wkNOKRVxAN8f5ELpu5P+QBxtDx7CRjkU4Th36hjLXqk4NX+VUMF4tKM1pqfbtLw
         A/xw==
X-Gm-Message-State: AOJu0Yx9Foxew+L0ofWoNUSZ4Fc4OlcDoufj43kyzsMqwKdRE21gC8By
	bxKjUOS5BGMC9+HfvFryTrSyezdWwBp9+RKX8VD0qxulLgWmuQ==
X-Google-Smtp-Source: AGHT+IHETO9D5PNXpCW0t0+ryr9d6gweyKG6zA7bPc8EVqB2nhkeswrpOk/2xV5U8DLwdyukn9i/vGUKpTbnfZA43ds=
X-Received: by 2002:a05:6902:1b13:b0:dbd:98db:f6ec with SMTP id
 eh19-20020a0569021b1300b00dbd98dbf6ecmr3260792ybb.33.1705336756978; Mon, 15
 Jan 2024 08:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704726960.git.geert+renesas@glider.be> <ee3e57bafef123194b9779dbf5b9c181dc3b37ed.1704726960.git.geert+renesas@glider.be>
In-Reply-To: <ee3e57bafef123194b9779dbf5b9c181dc3b37ed.1704726960.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Jan 2024 17:38:40 +0100
Message-ID: <CAPDyKFpc1ZsVhFM22zum=54LQ3Tiow7kG0nnt3WD3DBTGY6KFg@mail.gmail.com>
Subject: Re: [PATCH 09/15] pmdomain: renesas: r8a779h0-sysc: Add r8a779h0 support
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Mon, 8 Jan 2024 at 16:34, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
>
> Add support for R-Car V4M (R8A779H0) SoC power areas to the R-Car SYSC
> driver.
>
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

To make sure we agree on the merge strategy; should I pick up $subject
patch, patch3 and patch4 through my pmdomain tree? DT patches, like
patch3 and patch4, I should share as usual via my immutable "dt"
branch, so you can pull it into your renesas tree?

Kind regards
Uffe

> ---
> Changes compared to the BSP:
>   - Move from drivers/soc/renesas/ to drivers/pmdomain/renesas/,
>   - Include rcar-gen4-sysc glue from "soc: renesas: rcar-gen4-sysc:
>     Introduce R-Car Gen4 SYSC driver",
>   - Remove unneeded includes,
>   - Align second column,
>   - Fix names of "a33dga" and "a23dgb" domains,
>   - Add missing "a3cr[012]" domains.
> ---
>  drivers/pmdomain/renesas/Kconfig          |  4 ++
>  drivers/pmdomain/renesas/Makefile         |  1 +
>  drivers/pmdomain/renesas/r8a779h0-sysc.c  | 55 +++++++++++++++++++++++
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c |  3 ++
>  drivers/pmdomain/renesas/rcar-gen4-sysc.h |  1 +
>  5 files changed, 64 insertions(+)
>  create mode 100644 drivers/pmdomain/renesas/r8a779h0-sysc.c
>
> diff --git a/drivers/pmdomain/renesas/Kconfig b/drivers/pmdomain/renesas/Kconfig
> index 80bf2cf8b60e6f63..54acb4b1ec7c4892 100644
> --- a/drivers/pmdomain/renesas/Kconfig
> +++ b/drivers/pmdomain/renesas/Kconfig
> @@ -71,6 +71,10 @@ config SYSC_R8A779G0
>         bool "System Controller support for R-Car V4H" if COMPILE_TEST
>         select SYSC_RCAR_GEN4
>
> +config SYSC_R8A779H0
> +       bool "System Controller support for R-Car V4M" if COMPILE_TEST
> +       select SYSC_RCAR_GEN4
> +
>  config SYSC_RMOBILE
>         bool "System Controller support for R-Mobile" if COMPILE_TEST
>
> diff --git a/drivers/pmdomain/renesas/Makefile b/drivers/pmdomain/renesas/Makefile
> index e306e396fc8c10e3..89180f19c23be732 100644
> --- a/drivers/pmdomain/renesas/Makefile
> +++ b/drivers/pmdomain/renesas/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_SYSC_R8A77995)   += r8a77995-sysc.o
>  obj-$(CONFIG_SYSC_R8A779A0)    += r8a779a0-sysc.o
>  obj-$(CONFIG_SYSC_R8A779F0)    += r8a779f0-sysc.o
>  obj-$(CONFIG_SYSC_R8A779G0)    += r8a779g0-sysc.o
> +obj-$(CONFIG_SYSC_R8A779H0)     += r8a779h0-sysc.o
>  # Family
>  obj-$(CONFIG_SYSC_RCAR)                += rcar-sysc.o
>  obj-$(CONFIG_SYSC_RCAR_GEN4)   += rcar-gen4-sysc.o
> diff --git a/drivers/pmdomain/renesas/r8a779h0-sysc.c b/drivers/pmdomain/renesas/r8a779h0-sysc.c
> new file mode 100644
> index 0000000000000000..bf3fd50dc8dccaf0
> --- /dev/null
> +++ b/drivers/pmdomain/renesas/r8a779h0-sysc.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas R-Car V4M System Controller
> + *
> + * Copyright (C) 2016-2017 Glider bvba
> + * Copyright (C) 2023 Renesas Electronics Corp
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include <dt-bindings/power/r8a779h0-sysc.h>
> +
> +#include "rcar-gen4-sysc.h"
> +
> +static struct rcar_gen4_sysc_area r8a779h0_areas[] __initdata = {
> +       { "always-on",  R8A779H0_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
> +       { "c4",         R8A779H0_PD_C4, R8A779H0_PD_ALWAYS_ON },
> +       { "a2e0d0",     R8A779H0_PD_A2E0D0, R8A779H0_PD_C4, PD_SCU },
> +       { "a1e0d0c0",   R8A779H0_PD_A1E0D0C0, R8A779H0_PD_A2E0D0, PD_CPU_NOCR },
> +       { "a1e0d0c1",   R8A779H0_PD_A1E0D0C1, R8A779H0_PD_A2E0D0, PD_CPU_NOCR },
> +       { "a1e0d0c2",   R8A779H0_PD_A1E0D0C2, R8A779H0_PD_A2E0D0, PD_CPU_NOCR },
> +       { "a1e0d0c3",   R8A779H0_PD_A1E0D0C3, R8A779H0_PD_A2E0D0, PD_CPU_NOCR },
> +       { "a3cr0",      R8A779H0_PD_A3CR0, R8A779H0_PD_ALWAYS_ON, PD_CPU_NOCR },
> +       { "a3cr1",      R8A779H0_PD_A3CR1, R8A779H0_PD_ALWAYS_ON, PD_CPU_NOCR },
> +       { "a3cr2",      R8A779H0_PD_A3CR2, R8A779H0_PD_ALWAYS_ON, PD_CPU_NOCR },
> +       { "a33dga",     R8A779H0_PD_A33DGA, R8A779H0_PD_C4 },
> +       { "a23dgb",     R8A779H0_PD_A23DGB, R8A779H0_PD_A33DGA },
> +       { "a3vip0",     R8A779H0_PD_A3VIP0, R8A779H0_PD_C4 },
> +       { "a3vip2",     R8A779H0_PD_A3VIP2, R8A779H0_PD_C4 },
> +       { "a3dul",      R8A779H0_PD_A3DUL, R8A779H0_PD_C4 },
> +       { "a3isp0",     R8A779H0_PD_A3ISP0, R8A779H0_PD_C4 },
> +       { "a2cn0",      R8A779H0_PD_A2CN0, R8A779H0_PD_C4 },
> +       { "a1cn0",      R8A779H0_PD_A1CN0, R8A779H0_PD_A2CN0 },
> +       { "a1dsp0",     R8A779H0_PD_A1DSP0, R8A779H0_PD_A2CN0 },
> +       { "a1dsp1",     R8A779H0_PD_A1DSP1, R8A779H0_PD_A2CN0 },
> +       { "a2imp01",    R8A779H0_PD_A2IMP01, R8A779H0_PD_C4 },
> +       { "a2psc",      R8A779H0_PD_A2PSC, R8A779H0_PD_C4 },
> +       { "a2dma",      R8A779H0_PD_A2DMA, R8A779H0_PD_C4 },
> +       { "a2cv0",      R8A779H0_PD_A2CV0, R8A779H0_PD_C4 },
> +       { "a2cv1",      R8A779H0_PD_A2CV1, R8A779H0_PD_C4 },
> +       { "a2cv2",      R8A779H0_PD_A2CV2, R8A779H0_PD_C4 },
> +       { "a2cv3",      R8A779H0_PD_A2CV3, R8A779H0_PD_C4 },
> +       { "a3imr0",     R8A779H0_PD_A3IMR0, R8A779H0_PD_C4 },
> +       { "a3imr1",     R8A779H0_PD_A3IMR1, R8A779H0_PD_C4 },
> +       { "a3imr2",     R8A779H0_PD_A3IMR2, R8A779H0_PD_C4 },
> +       { "a3imr3",     R8A779H0_PD_A3IMR3, R8A779H0_PD_C4 },
> +       { "a3vc",       R8A779H0_PD_A3VC, R8A779H0_PD_C4 },
> +       { "a3pci",      R8A779H0_PD_A3PCI, R8A779H0_PD_C4 },
> +       { "a2pciphy",   R8A779H0_PD_A2PCIPHY, R8A779H0_PD_A3PCI },
> +};
> +
> +const struct rcar_gen4_sysc_info r8a779h0_sysc_info __initconst = {
> +       .areas = r8a779h0_areas,
> +       .num_areas = ARRAY_SIZE(r8a779h0_areas),
> +};
> diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> index 9e5e6e077abc081c..728248659a97e8cc 100644
> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
> @@ -284,6 +284,9 @@ static const struct of_device_id rcar_gen4_sysc_matches[] __initconst = {
>  #endif
>  #ifdef CONFIG_SYSC_R8A779G0
>         { .compatible = "renesas,r8a779g0-sysc", .data = &r8a779g0_sysc_info },
> +#endif
> +#ifdef CONFIG_SYSC_R8A779H0
> +       { .compatible = "renesas,r8a779h0-sysc", .data = &r8a779h0_sysc_info },
>  #endif
>         { /* sentinel */ }
>  };
> diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.h b/drivers/pmdomain/renesas/rcar-gen4-sysc.h
> index 388cfa8f8f9fd656..fdf843aa51134f87 100644
> --- a/drivers/pmdomain/renesas/rcar-gen4-sysc.h
> +++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.h
> @@ -40,5 +40,6 @@ struct rcar_gen4_sysc_info {
>  extern const struct rcar_gen4_sysc_info r8a779a0_sysc_info;
>  extern const struct rcar_gen4_sysc_info r8a779f0_sysc_info;
>  extern const struct rcar_gen4_sysc_info r8a779g0_sysc_info;
> +extern const struct rcar_gen4_sysc_info r8a779h0_sysc_info;
>
>  #endif /* __SOC_RENESAS_RCAR_GEN4_SYSC_H__ */
> --
> 2.34.1
>

