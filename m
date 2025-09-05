Return-Path: <linux-pm+bounces-34037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A74B46739
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691C6189CC7E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C59721D3C9;
	Fri,  5 Sep 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt7bN0Dr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698214F5E0;
	Fri,  5 Sep 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757115064; cv=none; b=Vo3Iwt3HqGBKnyqsvyOu0apvmWsRzxbZB2AItcpMK2RSKO9JwNp1n78Q28aU4xtAIigq5wbafXtomHaZj/grJvh8xgSz8KJTFFbvu55Dt6HsL1XVOSpwqJkeuXPyWp/r8t3ybvvmnCNqLLX0fgb+4F6ldQFIOh7YxDz2hAziRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757115064; c=relaxed/simple;
	bh=BhvkplneeHvq8+/St2DrA4zwRkq9v6hH9fZ+08hzphw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHJP3jLPyyH92Njv6ON4UEfrQ8Yx9gk2yIW6RxfJiRAor/zFCQxVaqJzAfeogm12zLI5nx28jaazX9UWe/ytQQuMg3QXEhlRTUooo9xjhCNMUoqjq1UOJsQruS+hIv/iPtXbN+edzyU+afUjyy3Edg3gPP2k43pHvOjkMXBHxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pt7bN0Dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B5C4CEF1;
	Fri,  5 Sep 2025 23:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757115064;
	bh=BhvkplneeHvq8+/St2DrA4zwRkq9v6hH9fZ+08hzphw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt7bN0Dr2EYWLSdBhCvlwbVMIYN3Ig8y/jgrzdnjRjxPAEUR46bNQtiTCEvVSHeuz
	 sCZxBz/5gODblGYi6JpgvycV+FGAuMVxvqTx6daLEhapSXeUj3RBEmsv2V8vdzWz7f
	 r3qvSbqGlue6IoiNwrZ8O+3bcqhxIAS1N3hSwhbClKHNHtcamaW0zeq6NvR1fysEZc
	 UnDKZbtbdbj9/gHoF3stVdM0pNNB51k/cFyuOd6c6NbGT0awSMZ6PhIMUu2cr47nVK
	 vEoUOVaes6PpH/SxAphgsq5A3Ru1GENiXcWKSNUgD/I2GXH8EEg+jLGqyJQGel1jxx
	 u4Em+O4BGCRmQ==
Date: Fri, 5 Sep 2025 18:31:03 -0500
From: Rob Herring <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] dt-bindings: mailbox: Add MT8196 GPUEB Mailbox
Message-ID: <20250905233103.GA1508406-robh@kernel.org>
References: <20250905-mt8196-gpufreq-v1-0-7b6c2d6be221@collabora.com>
 <20250905-mt8196-gpufreq-v1-4-7b6c2d6be221@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-mt8196-gpufreq-v1-4-7b6c2d6be221@collabora.com>

On Fri, Sep 05, 2025 at 12:23:00PM +0200, Nicolas Frattaroli wrote:
> The MediaTek MT8196 SoC includes an embedded MCU referred to as "GPUEB",
> acting as glue logic to control power and frequency of the Mali GPU.
> This MCU runs proprietary firmware for this purpose, and the main
> application processor communicates with it through a mailbox.
> 
> Add a binding that describes this mailbox.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../mailbox/mediatek,mt8196-gpueb-mbox.yaml        | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbox.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..506723d54ae0a429b462914f3666184c24c4fc5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbox.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mediatek,mt8196-gpueb-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MFlexGraphics GPUEB Mailbox Controller
> +
> +maintainers:
> +  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8196-gpueb-mbox
> +
> +  reg:
> +    items:
> +      - description: mailbox data registers
> +      - description: mailbox control registers
> +
> +  reg-names:
> +    items:
> +      - const: mbox
> +      - const: mbox_ctl

'mbox' is redundant. So 'data' and 'ctl'?

> +
> +  clocks:
> +    items:
> +      - description: main clock of the GPUEB MCU
> +
> +  interrupts:
> +    items:
> +      - description: fires when a new message is received
> +
> +  "#mbox-cells":
> +    const: 1
> +    description:
> +      The number of the mailbox channel.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gpueb_mbox: mailbox@4b09fd80 {

Drop unused labels.

> +        compatible = "mediatek,mt8196-gpueb-mbox";
> +        reg = <0x4b09fd80 0x280>,
> +              <0x4b170000 0x7c>;
> +        reg-names = "mbox", "mbox_ctl";
> +        clocks = <&topckgen CLK_TOP_MFG_EB>;
> +        interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH 0>;
> +        #mbox-cells = <1>;
> +    };
> 
> -- 
> 2.51.0
> 

