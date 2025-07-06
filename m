Return-Path: <linux-pm+bounces-30232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B463AFA86C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 01:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4C6189ADE7
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 23:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4E202F87;
	Sun,  6 Jul 2025 23:38:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4776219D8A3;
	Sun,  6 Jul 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751845097; cv=none; b=Flxcc583VrnuICVjz6hSqp0xEfM36HIb2j3YO0Y7YHjY5udi6qaex46VeirVQhDpc3XzBP2EM2HyCfCWrqjx8y00EVYuVXo475+iljBYEVg61lzPm69Dv/b4VxK/NBPX1FJS0WnEnmWbx87B6mpLtaBTVaZj+037S31QQ+ZSHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751845097; c=relaxed/simple;
	bh=GIW4M+B02meitepEZRICFQHNNiA29C676M+kLF16Q4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hgxxuyn4ZDASWlws6gJKrYcMfBtyO2gfAs6Fq26CsZSWIs0uDb66TwF8OZlUArKyA3Oqqa5gdBZkKOAn+IsnPH/Wqdu8kug2dJBpvsPNdmjGIsCX7ItHpcKRpvBLMs08dldzmnyfHFxGGoCIMB7qQ9c1RMa36gtQRmmGyB4sbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98CB1E8D;
	Sun,  6 Jul 2025 16:38:00 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5DB3F694;
	Sun,  6 Jul 2025 16:38:11 -0700 (PDT)
Date: Mon, 7 Jul 2025 00:36:40 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: Add A523 PPU and PCK600 power
 controllers
Message-ID: <20250707003640.73e08911@minigeek.lan>
In-Reply-To: <20250627152918.2606728-2-wens@kernel.org>
References: <20250627152918.2606728-1-wens@kernel.org>
	<20250627152918.2606728-2-wens@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 23:29:15 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The A523 PPU is likely the same kind of hardware seen on previous SoCs.
> 
> The A523 PCK600, as the name suggests, is likely a customized version
> of ARM's PCK-600 power controller. Comparing the BSP driver against
> ARM's PPU datasheet shows that the basic registers line up, but
> Allwinner's hardware has some additional delay controls in the reserved
> register range. As such it is likely not fully compatible with the
> standard ARM version.
> 
> Document A523 PPU and PCK600 compatibles.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Both PPUs are merely mentioned in the user manual, but do not have a
register description. But the BSP source code confirms the mapping of
the power domains used below, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../bindings/power/allwinner,sun20i-d1-ppu.yaml   |  2 ++
>  .../power/allwinner,sun55i-a523-pck600.h          | 15 +++++++++++++++
>  .../dt-bindings/power/allwinner,sun55i-a523-ppu.h | 12 ++++++++++++
>  3 files changed, 29 insertions(+)
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
> 
> diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> index f578be6a3bc8..b9f550994512 100644
> --- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> +++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
> @@ -18,6 +18,8 @@ properties:
>      enum:
>        - allwinner,sun20i-d1-ppu
>        - allwinner,sun8i-v853-ppu
> +      - allwinner,sun55i-a523-ppu
> +      - allwinner,sun55i-a523-pck-600
>  
>    reg:
>      maxItems: 1
> diff --git a/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h b/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
> new file mode 100644
> index 000000000000..6b3d8ea7bb69
> --- /dev/null
> +++ b/include/dt-bindings/power/allwinner,sun55i-a523-pck600.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_POWER_SUN55I_A523_PCK600_H_
> +#define _DT_BINDINGS_POWER_SUN55I_A523_PCK600_H_
> +
> +#define PD_VE			0
> +#define PD_GPU			1
> +#define PD_VI			2
> +#define PD_VO0			3
> +#define PD_VO1			4
> +#define PD_DE			5
> +#define PD_NAND			6
> +#define PD_PCIE			7
> +
> +#endif /* _DT_BINDINGS_POWER_SUN55I_A523_PCK600_H_ */
> diff --git a/include/dt-bindings/power/allwinner,sun55i-a523-ppu.h b/include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
> new file mode 100644
> index 000000000000..bc9aba73c19a
> --- /dev/null
> +++ b/include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_POWER_SUN55I_A523_PPU_H_
> +#define _DT_BINDINGS_POWER_SUN55I_A523_PPU_H_
> +
> +#define PD_DSP			0
> +#define PD_NPU			1
> +#define PD_AUDIO		2
> +#define PD_SRAM			3
> +#define PD_RISCV		4
> +
> +#endif /* _DT_BINDINGS_POWER_SUN55I_A523_PPU_H_ */


