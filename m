Return-Path: <linux-pm+bounces-39697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA1CCECAF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 08:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE15C30111BC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Dec 2025 07:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BDC2BE03D;
	Fri, 19 Dec 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGSzWIMd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A224468C;
	Fri, 19 Dec 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129710; cv=none; b=OdzogLVJy2ODFX9Oj2G+Nw1GrsJezFofCPAty65hA0qvX9U3eeTFY2xkGo3pYLvXPd5QiMn0Pqy1oZEFY/XWoKcTvBfeJ2i1z6YlTgQRJ4UIOSNtnX7oXNwnupiQ2NMzJvzJueQftcpts5+7l/m1SroxpMRRji2MqIRLka/dseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129710; c=relaxed/simple;
	bh=UFYiLPoUdNxWhfMRrjS7vxL4zRDLpmZgX5Xj7zFgNLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+BQiyR0+Yq3/Xa3nuXRDDYWATojkINxTnjsDv2Xwm3xLiLMiia/2KfSPtvzGUFfYy/UheBs+omnLv6dsIMdGXlOu985qX9s+6+FoirY2Y+GbvlRrpSqm1Q6m6tR0UbJ/7MM6Qsrq6jS1yYXm7DpMwoN1H5ATI79RLDlvFJr3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGSzWIMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5800CC4CEF1;
	Fri, 19 Dec 2025 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766129708;
	bh=UFYiLPoUdNxWhfMRrjS7vxL4zRDLpmZgX5Xj7zFgNLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGSzWIMd8xMiGfVw7DbXCqdns9/DzqDprIJx3lPoRaPgJqhu4HEoT2aucmpYhs7+b
	 iqTj/tPAF+otAIvi6IYCynmAtqmU5VErvdG4XsHn8igDq+hNBnoqsPY7CB1yicq7fp
	 /VEjfJIRZqTkmcycmss/3BHRCHVomYi1UCi8xgp2ZRPwTyJ89tHFJVHM256nLF/aGl
	 Zv+n0QmpF+SUFMr0wnqZu5cqZ///KZwqYx6OV+jzxcDYZT6xYbrF+emteN5VV5ezN8
	 wW4vQwYwZm00PzuKwM9zN76kC9r+9o/RdWgGcYKNHA4hD9YvweTojXFkoLivFxTcEI
	 KEyVvlZiTY7gA==
Date: Fri, 19 Dec 2025 08:35:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	netdev@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
Subject: Re: [PATCH v4 01/21] dt-bindings: clock: mediatek: Add MT8189 clock
 definitions
Message-ID: <20251219-venomous-ninja-uakari-bf8d1a@quoll>
References: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
 <20251215034944.2973003-2-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215034944.2973003-2-irving-ch.lin@mediatek.com>

On Mon, Dec 15, 2025 at 11:49:10AM +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add device tree bindings for the clock of MediaTek MT8189 SoC.

You in different patchset already received that comment:

A nit, subject: drop second/last, redundant "bindings" or "definitions"
or whatever you keep adding here redundantly. The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Can you finally read the docs?

> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>  .../bindings/clock/mediatek,mt8189-clock.yaml |  90 +++
>  .../clock/mediatek,mt8189-sys-clock.yaml      |  58 ++
>  .../dt-bindings/clock/mediatek,mt8189-clk.h   | 580 ++++++++++++++++++
>  3 files changed, 728 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
>  create mode 100644 include/dt-bindings/clock/mediatek,mt8189-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
> new file mode 100644
> index 000000000000..d21e02df36a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8189-clock.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mt8189-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Functional Clock Controller for MT8189
> +
> +maintainers:
> +  - Qiqi Wang <qiqi.wang@mediatek.com>

Why there is n ack for this? Is above person going to provide any
reviews? Why didn't this person review this binding, already at v4.

> +
> +description: |
> +  The clock architecture in MediaTek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes -->
> +                               clock gate
> +
> +  The devices provide clock gate control in different IP blocks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8189-camsys-main
> +          - mediatek,mt8189-camsys-rawa
> +          - mediatek,mt8189-camsys-rawb
> +          - mediatek,mt8189-dbg-ao
> +          - mediatek,mt8189-dem
> +          - mediatek,mt8189-dispsys
> +          - mediatek,mt8189-dvfsrc-top
> +          - mediatek,mt8189-gce-d
> +          - mediatek,mt8189-gce-m
> +          - mediatek,mt8189-iic-wrap-e
> +          - mediatek,mt8189-iic-wrap-en
> +          - mediatek,mt8189-iic-wrap-s
> +          - mediatek,mt8189-iic-wrap-ws
> +          - mediatek,mt8189-imgsys1
> +          - mediatek,mt8189-imgsys2
> +          - mediatek,mt8189-infra-ao
> +          - mediatek,mt8189-ipesys
> +          - mediatek,mt8189-mdpsys
> +          - mediatek,mt8189-mfgcfg
> +          - mediatek,mt8189-mm-infra
> +          - mediatek,mt8189-peri-ao
> +          - mediatek,mt8189-scp-clk
> +          - mediatek,mt8189-scp-i2c-clk
> +          - mediatek,mt8189-ufscfg-ao
> +          - mediatek,mt8189-ufscfg-pdn
> +          - mediatek,mt8189-vdec-core
> +          - mediatek,mt8189-venc
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8189-peri-ao
> +              - mediatek,mt8189-ufscfg-ao
> +              - mediatek,mt8189-ufscfg-pdn
> +
> +    then:
> +      required:
> +        - '#reset-cells'

else:
  properties:
    reset-cells: false

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@11b21000 {
> +        compatible = "mediatek,mt8189-iic-wrap-ws", "syscon";
> +        reg = <0x11b21000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
> new file mode 100644
> index 000000000000..c94de207e289
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8189-sys-clock.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mt8189-sys-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek System Clock Controller for MT8189
> +
> +maintainers:
> +  - Qiqi Wang <qiqi.wang@mediatek.com>

Same problem. We are at v4 and maintainer did not bother to review it in
public. What sort of maintenance is this?

> +
> +description: |
> +  The clock architecture in MediaTek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes -->
> +                               clock gate

Pretty obvious, no? Is there a clock topology which is different?

> +
> +  The apmixedsys provides most of PLLs which generated from SoC 26m.
> +  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
> +  The infracfg_ao provides clock gate in peripheral and infrastructure IP blocks.
> +  The mcusys provides mux control to select the clock source in AP MCU.
> +  The device nodes also provide the system control capacity for configuration.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8189-apmixedsys
> +          - mediatek,mt8189-topckgen
> +          - mediatek,mt8189-vlpckgen
> +          - mediatek,mt8189-vlp-ao
> +          - mediatek,mt8189-vlpcfg-ao
> +      - const: syscon

I do not understand why this is separate from the previous binding. It's
exactly the same, even description is the same.

Best regards,
Krzysztof


