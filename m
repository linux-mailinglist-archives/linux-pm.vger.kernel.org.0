Return-Path: <linux-pm+bounces-26141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FDA9B4CD
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC021BA55E0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3049428BABB;
	Thu, 24 Apr 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCoozjFz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2728A1CE
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513881; cv=none; b=uHi7J03jZUsHP5gnNpBDs+ixAohwHbkkDaMhlRUZcSUbBFrUoVIRdLz3Z1MOaUnpfVqAnUXK1nZ+LgrVWeHOAmit6ovrC+atSvD0aZmg7uE1JSTV5BZ5d2oe76pCo82WLULNlHMtQ++kXsMv60D3mfXqHhCn6L00IXNk7n2u0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513881; c=relaxed/simple;
	bh=j1MfpPRWqhfX/2KQfilannHBewLFWL4iLNkee7p1jNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii/jVnen5+7xlAN+UeBnYKKsL3sJA2l+G4t3NS16HZQvBtfBU8vM0LCHuNXzbjebrqyrNIgxfVmM2/YB59aKhzCpgrPS/AlvRrzy5f1NjIb7bVuu23vTAW07Ll1LN2M3iVf5wNgBaqtxOG0CbktJWz4GYb8qs3s3H/KTPKYBm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCoozjFz; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e73120cc26fso137709276.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745513878; x=1746118678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CC8QXc9LsvxTqtPlPIyO29AB2sQN6RDFy5sekBxfX70=;
        b=vCoozjFzjX4y6XuM2SS/8HavrP3FsNenwG5acDd3jARYmKb3IUBTf63dtOLxttD4NA
         ypVPOYAyUmSp7ppo6ZfKahhIOCe0RgFP05ydiNb5vjQLETDbjdPAbrCBl4QJhhO9Wizz
         kyQBY/Q9bociSxDv9UHHNcIIeoWm1we4NBBA8CedOe+MUfhSnDGDlAKfNhiO/33c0prr
         HUjPCMUDYzLm7/9NrBMi1MU42IdJF2N6KZVlmLgpAbc2ZPnE+jVk04FXlu3cAKkG1gs7
         tFZTBJnJOUnw56zwnsrWkQIA+9dsI3meToTZbAxcwWyoRPwyDwdcytZBeE//6VGKZM4p
         hG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513878; x=1746118678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CC8QXc9LsvxTqtPlPIyO29AB2sQN6RDFy5sekBxfX70=;
        b=JjH5peDIzOHgKN73mFHG9yBeipwxrjJnWkhkDPpqEn1J6Gvo38dedaWCF1MZg5tIq2
         d3yn9tE2TIqdFUnYPCnFHAhl11JjfaAfCZ8VQdOZkk0+PRsB/Zcuhp6de0YkuLl1M8qp
         nvr4t5UZOiLn3J2Sio+e9lj106GmsBQyWQhafTAhfEec0Hu7L2oDH6vXqIot9PRZNzU2
         3ATe6yZmSAP90sh1dVzk7xBSIR/IdZ31aE6Mdgo1atkcGlTiRsSnotc+QdEzizPZdSHp
         Q734Y3+61BVYuxhTsSWwpArN0vV9pomy/wwTX3kT8TjBDzs3I/ZjPqWePBbQviidSD21
         lUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+2UiVzPb9ly1sase2Lhd8O8bfYnUcPzOj7Kh5Xe/wuCaW2Me77g3fy+i3O3IYgAgjU49U81O+fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3a59wlwuqSJjyda14VpJ5qsnjoEYw3pwn1KdaZZajRpgC1Qi9
	wJJAQpQXazyZdzMj8P1c7MFy7x3v+BVutrxlWQGT0udWMHfz26Z58yNtGlby+4ODNfg/L1jrc7V
	E1OM5UrwMfCTjRUSkkuHSZxdh4whKJVqmmg2FIg==
X-Gm-Gg: ASbGncsgMprSZ9caJB7RIt6xIF8GUS13wvvDnF6hnJmDLtPM7wGi48WAVutygduytj+
	a2kCOLp9GiwDCXHo+CFb4vkYVc4igtA62uAxsqmVZ4sI/xrYv3dFG8qzjERTQrlDyyroyo/1tpy
	d47Xs3g5/jyuGmOxoAwfAJ+Kk=
X-Google-Smtp-Source: AGHT+IGUSO5FK4cTNY1s8aCOE0QjJA5+ZdVnwWYHpoNAMpE1vPT98E65H3GN3XHKq0FMUPOvfV/2uwmg/47o7Q3uAQg=
X-Received: by 2002:a05:6902:1b12:b0:e72:d449:72ed with SMTP id
 3f1490d57ef6-e7312d6905emr175202276.24.1745513878058; Thu, 24 Apr 2025
 09:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416224839.9840-1-andre.przywara@arm.com> <20250416224839.9840-2-andre.przywara@arm.com>
In-Reply-To: <20250416224839.9840-2-andre.przywara@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Apr 2025 18:57:22 +0200
X-Gm-Features: ATxdqUFsZ4jKzTVE_MqQW5hWNU9yilyI4trLvJSpUG2toFoex3HtMd6XPhqZ5bI
Message-ID: <CAPDyKFop9gAUq3kG4-hs358y=N48rLQSvJaRveXo_ebVTf8gEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add Allwinner H6/H616 PRCM PPU
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Philippe Simons <simons.philippe@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 00:49, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The Allwinner H6 and some later SoCs contain some bits in the PRCM (Power
> Reset Clock Management) block that control some power domains.
> Those power domains include the one for the GPU, the PLLs and some
> analogue circuits.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next by amending the example according to ChenYu's comment, thanks!

Note this patch is also available on the immutable dt branch, for SoC
maintainers to pull.

Kind regards
Uffe



> ---
>  .../power/allwinner,sun50i-h6-prcm-ppu.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
> new file mode 100644
> index 0000000000000..7eaff9baf7268
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/allwinner,sun50i-h6-prcm-ppu.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/allwinner,sun50i-h6-prcm-ppu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner SoCs PRCM power domain controller
> +
> +maintainers:
> +  - Andre Przywara <andre.przywara@arm.com>
> +
> +description:
> +  The Allwinner Power Reset Clock Management (PRCM) unit contains bits to
> +  control a few power domains.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun50i-h6-prcm-ppu
> +      - allwinner,sun50i-h616-prcm-ppu
> +      - allwinner,sun55i-a523-prcm-ppu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#power-domain-cells':
> +    const: 1
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
> +    prcm_ppu: power-controller@7010210 {
> +        compatible = "allwinner,sun50i-h616-prcm-ppu";
> +        reg = <0x07010250 0x10>;
> +        #power-domain-cells = <1>;
> +    };
> --
> 2.46.3
>

