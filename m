Return-Path: <linux-pm+bounces-29709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97645AEC0BB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E756C3B54C8
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96B1FC7E7;
	Fri, 27 Jun 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrHiXih+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092E3A8F7;
	Fri, 27 Jun 2025 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055346; cv=none; b=IR+NX1XrsOuk3BYDFfptUMY38SNYELOODh9s9Xvv5+3yhBTKRJ5jLe2kwEAjVzhoIIWr1lBlkj3H+VClhbjtnBWqdgXr9R89LtGsDVnjj9McQblFFftUogNeOuA5A1q3eHnxgRJqz6aGkaAqfONX2hS/EPvAFKiyQpExU8mU/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055346; c=relaxed/simple;
	bh=A1HZdHwLlVd1wktKvcUvDiv1sLcJQsvaROUniDdEirI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNx+KoX58a2ynHZ5f1Y5B+yLtd1PYE96f92JT9o3SDqmHSajOxTli8ZKs+xjKo0xgyN25V9n/Rg4L3MeH/1ZzLlXY6D8pltqSBnoP+ICBxJh1q4aNGaEK7C/EEe66ThKa1RiMMqFsOwlPajUNGmkodQmwDiT8/jkv68j7zNwwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrHiXih+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5257C4CEE3;
	Fri, 27 Jun 2025 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751055344;
	bh=A1HZdHwLlVd1wktKvcUvDiv1sLcJQsvaROUniDdEirI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrHiXih+BZdymtaHzgqTsVDdu1FEBGcLRQgLhv1aG2fsboVDOZbVMbynjwTaX3sNA
	 iWGag08iZ4mv30r/ci/yihUghINwgdiMVZhoZBh3bnyRsXN5OthTcrzdiFHQ41xlmk
	 2woK0MPlzohsTuK9e63xEhfpn+73hPWvc9IN1IsA3hHrKBOYPv/FvVYXSbyu6VGn8c
	 i19BkmMr0OojSpgJxRcDIwIPlwJ1tP+2svqvKBr7A8H3B8V5Gr3lGA8x91em23ot1z
	 K/BMTKv86TfG4EaUgc3t9yudO3Bo4hTMV48TuVsbF7MWaeEADllTHH67D/o+viXmad
	 hTLcRg4Fpphdw==
Date: Fri, 27 Jun 2025 15:15:43 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, ulf.hansson@linaro.org,
	y.oudjana@protonmail.com, fshao@chromium.org, wenst@chromium.org,
	lihongbo22@huawei.com, mandyjh.liu@mediatek.com, mbrugger@suse.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v1 01/13] dt-bindings: power: mediatek: Document
 mediatek,bus-protection
Message-ID: <20250627201543.GA4171766-robh@kernel.org>
References: <20250623120154.109429-1-angelogioacchino.delregno@collabora.com>
 <20250623120154.109429-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623120154.109429-2-angelogioacchino.delregno@collabora.com>

On Mon, Jun 23, 2025 at 02:01:42PM +0200, AngeloGioacchino Del Regno wrote:
> Add a new mediatek,bus-protection property in the main power
> controller node and deprecate the old mediatek,infracfg,
> mediatek,infracfg-nao and mediatek,smi properties located in
> the children.
> 
> This is done in order to both simplify the power controller
> nodes and in preparation for adding support for new generation
> SoCs like MT8196/MT6991 and other variants, which will need
> to set protection on new busses.

Protection like access controls? We have the access-controller binding 
for that.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 9c7cc632abee..2530c873bb3c 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -44,6 +44,18 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  mediatek,bus-protection:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A number of phandles to external blocks to set and clear the required
> +      bits to enable or disable bus protection, necessary to avoid any bus
> +      faults while enabling or disabling a power domain.
> +      For example, this may hold phandles to INFRACFG and SMI.
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      maxItems: 1
> +
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
>      $ref: "#/$defs/power-domain-node"
> @@ -123,14 +135,17 @@ $defs:
>        mediatek,infracfg:
>          $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the device containing the INFRACFG register range.
> +        deprecated: true
>  
>        mediatek,infracfg-nao:
>          $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the device containing the INFRACFG-NAO register range.
> +        deprecated: true
>  
>        mediatek,smi:
>          $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the device containing the SMI register range.
> +        deprecated: true
>  
>      required:
>        - reg
> @@ -138,6 +153,31 @@ $defs:
>  required:
>    - compatible
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8183-power-controller
> +    then:
> +      properties:
> +        mediatek,bus-protection:
> +          minItems: 2
> +          maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8365-power-controller
> +    then:
> +      properties:
> +        mediatek,bus-protection:
> +          minItems: 3
> +          maxItems: 3
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.49.0
> 

