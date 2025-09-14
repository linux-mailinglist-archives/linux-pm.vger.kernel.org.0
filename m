Return-Path: <linux-pm+bounces-34604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA687B56847
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38847189B5A9
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9486F24728F;
	Sun, 14 Sep 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuHy6qI4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5201DFCB;
	Sun, 14 Sep 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851557; cv=none; b=R+4ZMPIyfNpjEZayf3lPX7jslFVb6pAC9d1E8JKSIGPuJOSbgB5Aqq8IIHOodT3Fi2E7O/Lsn60PuEkZ5oR955FQsYgUrf3rfrNkzmnXiaJbjuDacrKKL0wDldRwnCWFvGBFmvnoEYIWRaNpMrAvw7dhslk/oKPhIXIQrWOnPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851557; c=relaxed/simple;
	bh=VPAHReVnPlaTN0aQS3I1hluH0vProSeTueDNuzjCjj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvYzGWyDDco9YP9owAmVsrqx8WbjN0Gq1nKSgvaHOKhKLJv2RUCUhrIKeW6C+tfaFPdJ7hymwU1P3dzMxjIpG0pWDk/Qq3UIK34b/3WAUDxKC06AG1ah3DkcPfzDnR1/dp8BIxfTE9ReEXaMB76pR/WfbBIyoUGTPieLNX+4XCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuHy6qI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9376C4CEF0;
	Sun, 14 Sep 2025 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757851556;
	bh=VPAHReVnPlaTN0aQS3I1hluH0vProSeTueDNuzjCjj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YuHy6qI4tiX9PBJO++rGoG8tESbjcg4wxE5VjBSXkhY0CpRqgsBROiAk5s/G9BAId
	 crWhjliGMXuwBaLvjKwHAiDTVUDTmVgdCcj5/wtGCE/SYEQUBFdCmOecfLeGod0Ivj
	 lT524/lJamQxdOHc5KglcCirgWd1bz57gReNX0WED74gOwmPKTDfHd+scRvXmgSWDd
	 wdWAbGLFuqua6NTXYvSR9IuPKzmDcfpQv3aPhVxkP/dtzZLNSBmxcjoGbt1Er2WYzW
	 zsKdlvLCq82f6/FgQmqp/ZL5nz+6ztf/1begdedtus+CaA8KhPgufG5sfh5E0vb8Ys
	 kHsSBfLAtFUWA==
Message-ID: <746e10a5-02fe-4f0d-ab86-d674a8fedab0@kernel.org>
Date: Sun, 14 Sep 2025 14:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: power: mediatek: Add MT8189 power
 domain definitions
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com,
 vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
References: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
 <20250912120508.3180067-3-irving-ch.lin@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250912120508.3180067-3-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2025 14:04, irving.ch.lin wrote:
> From: Irving-ch Lin <irving-ch.lin@mediatek.com>
> 
> Add device tree bindings for the power domains of MediaTek MT8189 SoC.
> These definitions will be used to describe the power domain topology in
> device tree sources.
> 
> Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
> ---
>  .../mediatek,mt8189-power-controller.yaml     | 88 +++++++++++++++++++
>  .../dt-bindings/power/mediatek,mt8189-power.h | 38 ++++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
>  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
> new file mode 100644
> index 000000000000..71156f7edafe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mediatek,mt8189-power-controller.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/mediatek,mt8189-power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Power Domains Controller for MT8189
> +
> +maintainers:
> +  - Qiqi Wang <qiqi.wang@mediatek.com>
> +
> +description: |
> +  MediaTek processors include support for multiple power domains which can be
> +  powered up/down by software based on different application scenes to save power.
> +
> +  IP cores belonging to a power domain should contain a 'power-domains'
> +  property that is a phandle for SCPSYS node representing the domain.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8189-scpsys
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  clocks:
> +    description: |
> +      A number of phandles to clocks that need to be enabled during domain
> +      power-up sequencing.

Nothing improved, there is no such code in the bindings.

> +
> +  clock-names:
> +    description: |
> +      List of names of clocks, in order to match the power-up sequencing
> +      for each power domain we need to group the clocks by name. BASIC

Nothing improved here either.

> +      clocks need to be enabled before enabling the corresponding power
> +      domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> +      SUSBYS clocks need to be enabled before releasing the bus protection,
> +      and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> +
> +      In order to follow properly the power-up sequencing, the clocks must
> +      be specified by order, adding first the BASIC clocks followed by the
> +      SUSBSYS clocks.
> +
> +patternProperties:
> +  "^mfg[01]-supply$":
> +    description: |
> +      Regulator supply for mfg domain. With this attribute, scpsys can manage
> +      mfg regulator in mtcmos control flow, to achieve low power scenario.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mediatek,mt8189-clk.h>
> +    #include <dt-bindings/power/mediatek,mt8189-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        scpsys: power-controller@1c001000 {
> +            compatible = "mediatek,mt8189-scpsys";
> +            reg = <0 0x1c001000 0 0x1000>;
> +            #power-domain-cells = <1>;
> +            clocks = /* MFG */
> +                <&topckgen_clk CLK_TOP_MFG_REF_SEL>,
> +                <&apmixedsys_clk CLK_APMIXED_MFGPLL>;
> +            clock-names = "mfg", "mfg_top";
> +            mfg0-supply = <&mt6359_vproc1_buck_reg>;
> +            mfg1-supply = <&mt6359_vsram_proc1_ldo_reg>;
> +        };
> +
> +        /* Example of module to register power domain */


What do the guidelines speak about this? Don't do this, don't add the
consumers. Drop.

The binding did not improve, so I am not doing full review. Please go
through writing bindings or tutorials/presentations explaining this, so
we won't need to repeat same comments.


Best regards,
Krzysztof

