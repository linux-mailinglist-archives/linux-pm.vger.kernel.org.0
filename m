Return-Path: <linux-pm+bounces-39239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82106CA7194
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 11:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DD9836CD8D5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3C73081D2;
	Fri,  5 Dec 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ7ngaXI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1483219301;
	Fri,  5 Dec 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923948; cv=none; b=LiMvdMzEfqi3NkSeJR/gBfCR1YB7vCj7G+AV6Tp2pqSYTfJnnitxg7xbyEyBA1Vn5CPbAdwdOOsslxuNX37GrzQnKq7+Xu+e8QkJSDXTrjJOcJ7vHXLx1uoc1zG9kQeKyTJyd14tLa34Y/Mg8fvNiVmapECOU10J2yy2bD20h4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923948; c=relaxed/simple;
	bh=9HJ5sgZEsPfwomqdOTPvYrHHBOud2TBPVuz56dCYrqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JthjrHFimCHtgTA59QnMwjvO1xgAnqgw+/M/bmBoGqtibI7SUNrVMc9kSZcQrcyv3xKrJYs8qJPDeCnM10/mSNZysPLTbjYdjShjW2IEUp3NA8qvvuEd8V+R9zdDKYk7OuoGPvlb0hnU3qJ8GGZ2QL44Wh0PoDWWvgreldE5fAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ7ngaXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973CCC4CEF1;
	Fri,  5 Dec 2025 08:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764923946;
	bh=9HJ5sgZEsPfwomqdOTPvYrHHBOud2TBPVuz56dCYrqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJ7ngaXI/A9Yxr7OMM/TK12mMBKIkr/0kbXk0ZpSmsVburcI6VuNnbvF8h2Qp8VNt
	 QQFZ3Hbg6V2lAGnGhkf049YGjmQmReQXvRma3ret49QAbl+YQ+HJNZYhE5DnZM5xHh
	 4aesaFfigu/DaUnFrDIK58QUWYacqIxjP2zBd0LfojkmXmXtk620DpBX0GPuW8CBap
	 wd8szEs5t5M8LjomU+vrzCDzijDESm8FAsbOQmgejpJ3CQHO8Omxx0mOlAVi3Lttdy
	 mL8AHgbFva9isRibOgH1vt4lPcMz6kWGq/aGY7pqdhkNpigMRWhIZIPbHYeKJ+9p8H
	 SkesHflqNsANA==
Date: Fri, 5 Dec 2025 09:39:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hanchien Lin <hanchien.lin@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Balsam CHIHI <bchihi@baylibre.com>, Irving-CH.lin@mediatek.com, 
	Jh Hsu <Jh.Hsu@mediatek.com>, WH Wu <vincent.wu@mediatek.com>, 
	Raymond Sun <Raymond.Sun@mediatek.com>, Sirius Wang <Sirius.Wang@mediatek.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: mediatek: Add MT8189 LVTS
 thermal controller bindings
Message-ID: <20251205-nostalgic-just-mussel-5cbf89@quoll>
References: <20251202091056.1761229-1-hanchien.lin@mediatek.com>
 <20251202091056.1761229-2-hanchien.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251202091056.1761229-2-hanchien.lin@mediatek.com>

On Tue, Dec 02, 2025 at 05:10:55PM +0800, Hanchien Lin wrote:
> Add support for the MediaTek MT8189 LVTS thermal controller to the device tree bindings.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> This includes new compatible strings and required properties for MT8189.

Drop, redundant. Don't explain the obvious. Can you document new device
wihout "new compatible strings"?

Your commit msg should explain non obvious things, e.g. why this is not
compatible with existing devices.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18


> 
> Signed-off-by: Hanchien Lin <hanchien.lin@mediatek.com>
> ---
>  .../thermal/mediatek,lvts-thermal.yaml        | 27 +++++++++++++++++--
>  .../thermal/mediatek,lvts-thermal.h           | 20 ++++++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> index 0259cd3ce9c5..0f7fd69f5fdf 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -22,6 +22,8 @@ properties:
>        - mediatek,mt8186-lvts
>        - mediatek,mt8188-lvts-ap
>        - mediatek,mt8188-lvts-mcu
> +      - mediatek,mt8189-lvts-ap
> +      - mediatek,mt8189-lvts-mcu
>        - mediatek,mt8192-lvts-ap
>        - mediatek,mt8192-lvts-mcu
>        - mediatek,mt8195-lvts-ap
> @@ -58,6 +60,21 @@ properties:
>  allOf:
>    - $ref: thermal-sensor.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8189-lvts-ap
> +              - mediatek,mt8189-lvts-mcu

Why new if:then? Why cannot it be part of existing block? I don't see
differences.

> +    then:
> +      properties:
> +        nvmem-cells:
> +          minItems: 2
> +
> +        nvmem-cell-names:
> +          minItems: 2
> +
>    - if:
>        properties:
>          compatible:
> @@ -75,6 +92,10 @@ allOf:
>          nvmem-cell-names:
>            maxItems: 1
>  
> +      required:
> +        - clocks
> +        - resets
> +
>    - if:
>        properties:
>          compatible:
> @@ -91,12 +112,14 @@ allOf:
>          nvmem-cell-names:
>            minItems: 2
>  
> +      required:
> +        - clocks
> +        - resets
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> -  - clocks
> -  - resets


Maybe that's the difference, but commit msg explained nothing. Your
commit is just redundant - tells zero, but all the unexpected things are
totally not explained.

Device cannot work without resets and clocks. If you think otherwise,
prove your point in commit msg (in terms of datasheet, hardware, not
drivers!).

>    - nvmem-cells
>    - nvmem-cell-names

Best regards,
Krzysztof


