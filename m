Return-Path: <linux-pm+bounces-23608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B780A561F1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 08:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B17B3B2C4A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD48F1A7AF7;
	Fri,  7 Mar 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9uZgIlX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF618B476;
	Fri,  7 Mar 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333293; cv=none; b=u3DHbrObsGT1paONNmsmr59QzWlQ744glHrwfGtYoQ5pzr1bdkn98v2WWZKvNc7DDOgF9aIgRY+2uJMuAc0g4fuvFMZTgLROs6+xGsuHQyM7Yt+JQWU19uMAXbUu9bB2d+lZv/mUTTsTiEnFbEqS8WcgPZqgYGjWuTRQPhlgpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333293; c=relaxed/simple;
	bh=bF4mHFm8U4if18/YMhPJOe0mEyH61C7WCg62Scl77Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjpmJKk+mMFfaSDwGyrmK8UhY8HSh7EDvgY6oHftpuPgc5YHpeCw9jMnJmx2VQ0+7XPBXHc7B2y5fvZqNEBgG9itf0Ddvhmdee8m4kE+MfwsfO0TlwO5h4pP3jNHEsXsSHVWQuR5U5ymB/s0sXKel930U3RnT14SS6nWiAH7ZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9uZgIlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA816C4CEE3;
	Fri,  7 Mar 2025 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741333293;
	bh=bF4mHFm8U4if18/YMhPJOe0mEyH61C7WCg62Scl77Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9uZgIlXLqnJo2uw3DIO3ns8wZj+4j/ii84D6nl2S4GBYtIj4MjIDSFEwm5O7CU/r
	 GEGSe/s3pDrwVduFkj/QQ3lFydgrpCtm8GSqsjp6PNy53ePPAU7y9ry5fPdsJ0lR/v
	 CuEVEUS4OinFeaEbljbYWAEUy98q3CkdeBrRAJQjk2FIVcHUoJ5tZOVo0BvV00il0e
	 CH1RC/W7l9I2/MJJp0dxSy/roJKTfUdkyhCh3RxA90u7dEZiIUvVYZv5OQ+ewwAXgl
	 kgIjafzCTI4Q6D95Y6qVSryy3dHrcYCj7JzljY73jYIKPKfIlWGe5bgSQtN4mjwmM4
	 hrY4G743ZdEiw==
Date: Fri, 7 Mar 2025 08:41:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guangjie Song <guangjie.song@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 12/13] dt-bindings: power: mediatek: Add new MT8196 power
 domain
Message-ID: <20250307-groovy-opalescent-spoonbill-cb569e@krzk-bin>
References: <20250307034454.12243-1-guangjie.song@mediatek.com>
 <20250307034454.12243-13-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307034454.12243-13-guangjie.song@mediatek.com>

On Fri, Mar 07, 2025 at 11:44:36AM +0800, Guangjie Song wrote:
> Add the binding documentation for power domain on MediaTek MT8196.
> 
> Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
> ---
>  .../mediatek,mt8196-power-controller.yaml     | 74 +++++++++++++++++++
>  include/dt-bindings/power/mt8196-power.h      | 57 ++++++++++++++


You keep sending multiple patchsets and none of them are tested.


>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
>  create mode 100644 include/dt-bindings/power/mt8196-power.h

Comments from other patches apply.

> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
> new file mode 100644
> index 000000000000..6c2867b25967
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/mediatek,mt8196-power-controller.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/mediatek,mt8196-power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT8196 Power Domains Controller
> +
> +maintainers:
> +  - Guangjie Song <guangjie.song@mediatek.com>
> +
> +description: |
> +  Mediatek processors include support for multiple power domains which can be
> +  powered up/down by software based on different application scenes to save power.
> +
> +properties:
> +  $nodename:
> +    pattern: '^power-controller(@[0-9a-f]+)?$'


How unit address can be optional?

> +
> +  compatible:
> +    enum:
> +      - mediatek,mt8196-scpsys
> +      - mediatek,mt8196-hfrpsys
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    description: Address range of the power controller.

No, look how other bindings do it.

> +
> +  clocks:
> +    description: |

Look at other bindings.

> +      A number of phandles to clocks that need to be enabled during domain
> +      power-up sequencing.

Look at other bindings.

> +
> +  clock-names:
> +    description: |
> +      List of names of clock.
> +
> +  domain-supply:
> +    description: domain regulator supply.
> +
> +  spm:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the device containing the spm register range.
> +
> +  mmpc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the device containing the mmpc register range.
> +
> +  vote-regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the device containing the vote register range.
> +
> +  mm-vote-regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the device containing the mm-vote register range.

None of these are correct.

> +
> +required:
> +  - compatible

That's just incomplete.

This binding is really incomplete and with multiple issues. Considering
this was never tested, please first consult some internal folks to do
proper internal review.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/power/mt8196-power.h>
> +
> +    scpsys: power-controller@1c004000 {
> +      compatible = "mediatek,mt8196-scpsys", "syscon";
> +      reg = <0 0x1c004000 0 0x1000>;
> +      #power-domain-cells = <1>;
> +      spm = <&scpsys_bus>;
> +      vote-regmap = <&vote>;
> +    };
> diff --git a/include/dt-bindings/power/mt8196-power.h b/include/dt-bindings/power/mt8196-power.h
> new file mode 100644
> index 000000000000..b0db89cc435d
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8196-power.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.

We have 2025.

Best regards,
Krzysztof


