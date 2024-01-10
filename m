Return-Path: <linux-pm+bounces-2055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93533829A14
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 13:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BC51C23868
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5D47F5D;
	Wed, 10 Jan 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Jg8bb2EW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79F47F47
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso4346032e87.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 04:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1704888151; x=1705492951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cqpNf17BaPPXOco6WFiFYt1HPjCXyc4g8DVMu5tK88c=;
        b=Jg8bb2EWav+HdfGA7FjTVQH2jvC6BG4L2YFM9Q5h4L4OnKJ/+LeriQ+1eWIK/8h0Rd
         0F5UAI6ww+TJRSiZpinQJi+PLeKn4i5gsZAgjtFSthwdc4X5Ii8CojgPih6PbwS8uuUw
         oO1Q0wM+j4Yba7MjfIDrJxs+cCExfg8ZE5qLahQXrJfVw1KdQVSeobi0rRNkpFH3QFp1
         UqYyu/s+epn345j7eGkWreSPR0fpz6+VAJ25PRcHptEMVkwtW5M+nTuwXnyg8RkCLSgA
         yo9DEWKqmIYLP+1yUEaIrNVarhj95a1W75el4UarcgVA6joSmU1Fs56eu6kf9UbK24F3
         xfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704888151; x=1705492951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqpNf17BaPPXOco6WFiFYt1HPjCXyc4g8DVMu5tK88c=;
        b=de0RWKFC/3yEAAUGznvW0GwRiy8Q69BA3G6OC/Ro/WQKLWm1XA/FDHPOrERshUw6UE
         CPUvS1334R8ymjTkk9Mv5A7oBRM1l4+9dJYma1Mgp5PiTAPCNwAABi+iAOiAPG3AWuxA
         j7I9BiM1tGJM7+ClcGjO/PW1Cnjh2QT8BxwvopeEliGDdNhzXCs5TLbA56KYFv0Fb34N
         oadNNzTsbZshxnFGUWnxM0yDp9VYhz+aAq0TFnDDeT+cX5dK+2wk2y5f9vYGFxI6W5AL
         +t+8y03YOGCZm8nHAK6b8ik5398DZDfwikWKY8sAgjABmTMk649GIToAtkYG4p4m0PqQ
         OOLw==
X-Gm-Message-State: AOJu0YwoQjeyVE0MeAH6U7A7nDPH6EMAMX90NDj03y+wSzde5JTgIxxb
	IZKsBwPF/GBtbjrGsacVxFmR0r3R8S6huQ==
X-Google-Smtp-Source: AGHT+IESm3a8APKI9Q3v0h/TazI/VSsn3H4oKclF5WuzIMy/SwiuCaXXo7bqG3iSsWi/M1/lX1ayPA==
X-Received: by 2002:a05:6512:2307:b0:50e:d63a:96f1 with SMTP id o7-20020a056512230700b0050ed63a96f1mr239033lfu.146.1704888150679;
        Wed, 10 Jan 2024 04:02:30 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id q5-20020ac24a65000000b0050e9eca5f82sm645090lfp.1.2024.01.10.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 04:02:30 -0800 (PST)
Date: Wed, 10 Jan 2024 13:02:29 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: clock: Add R8A779H0 V4M CPG Core
 Clock Definitions
Message-ID: <20240110120229.GB1625657@ragnatech.se>
References: <cover.1704726960.git.geert+renesas@glider.be>
 <2e083461752c9d52fdb251ad9071f6111f13c3c5.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e083461752c9d52fdb251ad9071f6111f13c3c5.1704726960.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your patch.

On 2024-01-08 16:33:41 +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> 
> Add all Clock Pulse Generator Core Clock Outputs for the Renesas R-Car
> V4M (R8A779H0) SoC.
> 
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I have no opinion on Krzysztof comment about renaming the file, for the 
file content,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Changes compared to the BSP:
>   - Drop POST* clocks, as they are internal clocks.
> ---
>  include/dt-bindings/clock/r8a779h0-cpg-mssr.h | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 include/dt-bindings/clock/r8a779h0-cpg-mssr.h
> 
> diff --git a/include/dt-bindings/clock/r8a779h0-cpg-mssr.h b/include/dt-bindings/clock/r8a779h0-cpg-mssr.h
> new file mode 100644
> index 0000000000000000..baf41231c215acb3
> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a779h0-cpg-mssr.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +#ifndef __DT_BINDINGS_CLOCK_R8A779H0_CPG_MSSR_H__
> +#define __DT_BINDINGS_CLOCK_R8A779H0_CPG_MSSR_H__
> +
> +#include <dt-bindings/clock/renesas-cpg-mssr.h>
> +
> +/* r8a779h0 CPG Core Clocks */
> +
> +#define R8A779H0_CLK_ZX			0
> +#define R8A779H0_CLK_ZD			1
> +#define R8A779H0_CLK_ZS			2
> +#define R8A779H0_CLK_ZT			3
> +#define R8A779H0_CLK_ZTR		4
> +#define R8A779H0_CLK_S0D2		5
> +#define R8A779H0_CLK_S0D3		6
> +#define R8A779H0_CLK_S0D4		7
> +#define R8A779H0_CLK_S0D1_VIO		8
> +#define R8A779H0_CLK_S0D2_VIO		9
> +#define R8A779H0_CLK_S0D4_VIO		10
> +#define R8A779H0_CLK_S0D8_VIO		11
> +#define R8A779H0_CLK_VIOBUSD1		12
> +#define R8A779H0_CLK_VIOBUSD2		13
> +#define R8A779H0_CLK_S0D1_VC		14
> +#define R8A779H0_CLK_S0D2_VC		15
> +#define R8A779H0_CLK_S0D4_VC		16
> +#define R8A779H0_CLK_VCBUSD1		17
> +#define R8A779H0_CLK_VCBUSD2		18
> +#define R8A779H0_CLK_S0D2_MM		19
> +#define R8A779H0_CLK_S0D4_MM		20
> +#define R8A779H0_CLK_S0D2_U3DG		21
> +#define R8A779H0_CLK_S0D4_U3DG		22
> +#define R8A779H0_CLK_S0D2_RT		23
> +#define R8A779H0_CLK_S0D3_RT		24
> +#define R8A779H0_CLK_S0D4_RT		25
> +#define R8A779H0_CLK_S0D6_RT		26
> +#define R8A779H0_CLK_S0D2_PER		27
> +#define R8A779H0_CLK_S0D3_PER		28
> +#define R8A779H0_CLK_S0D4_PER		29
> +#define R8A779H0_CLK_S0D6_PER		30
> +#define R8A779H0_CLK_S0D12_PER		31
> +#define R8A779H0_CLK_S0D24_PER		32
> +#define R8A779H0_CLK_S0D1_HSC		33
> +#define R8A779H0_CLK_S0D2_HSC		34
> +#define R8A779H0_CLK_S0D4_HSC		35
> +#define R8A779H0_CLK_S0D8_HSC		36
> +#define R8A779H0_CLK_SVD1_IR		37
> +#define R8A779H0_CLK_SVD2_IR		38
> +#define R8A779H0_CLK_IMPAD1		39
> +#define R8A779H0_CLK_IMPAD4		40
> +#define R8A779H0_CLK_IMPB		41
> +#define R8A779H0_CLK_SVD1_VIP		42
> +#define R8A779H0_CLK_SVD2_VIP		43
> +#define R8A779H0_CLK_CL			44
> +#define R8A779H0_CLK_CL16M		45
> +#define R8A779H0_CLK_CL16M_MM		46
> +#define R8A779H0_CLK_CL16M_RT		47
> +#define R8A779H0_CLK_CL16M_PER		48
> +#define R8A779H0_CLK_CL16M_HSC		49
> +#define R8A779H0_CLK_ZC0		50
> +#define R8A779H0_CLK_ZC1		51
> +#define R8A779H0_CLK_ZC2		52
> +#define R8A779H0_CLK_ZC3		53
> +#define R8A779H0_CLK_ZB3		54
> +#define R8A779H0_CLK_ZB3D2		55
> +#define R8A779H0_CLK_ZB3D4		56
> +#define R8A779H0_CLK_ZG			57
> +#define R8A779H0_CLK_SD0H		58
> +#define R8A779H0_CLK_SD0		59
> +#define R8A779H0_CLK_RPC		60
> +#define R8A779H0_CLK_RPCD2		61
> +#define R8A779H0_CLK_MSO		62
> +#define R8A779H0_CLK_CANFD		63
> +#define R8A779H0_CLK_CSI		64
> +#define R8A779H0_CLK_FRAY		65
> +#define R8A779H0_CLK_IPC		66
> +#define R8A779H0_CLK_SASYNCRT		67
> +#define R8A779H0_CLK_SASYNCPERD1	68
> +#define R8A779H0_CLK_SASYNCPERD2	69
> +#define R8A779H0_CLK_SASYNCPERD4	70
> +#define R8A779H0_CLK_DSIEXT		71
> +#define R8A779H0_CLK_DSIREF		72
> +#define R8A779H0_CLK_ADGH		73
> +#define R8A779H0_CLK_OSC		74
> +#define R8A779H0_CLK_ZR0		75
> +#define R8A779H0_CLK_ZR1		76
> +#define R8A779H0_CLK_ZR2		77
> +#define R8A779H0_CLK_RGMII		78
> +#define R8A779H0_CLK_CPEX		79
> +#define R8A779H0_CLK_CP			80
> +#define R8A779H0_CLK_CBFUSA		81
> +#define R8A779H0_CLK_R			82
> +
> +#endif /* __DT_BINDINGS_CLOCK_R8A779H0_CPG_MSSR_H__ */
> -- 
> 2.34.1
> 
> 

-- 
Kind Regards,
Niklas Söderlund

