Return-Path: <linux-pm+bounces-31238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280FB0CB3A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342BE16C7B0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2323770D;
	Mon, 21 Jul 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AViKdRQU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F227230BE0;
	Mon, 21 Jul 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127902; cv=none; b=oDFLVST1zvvvgoiyPB4Jv6xIPDTCgMMo/rY/3sXl8wHlVq0QOgXGlfyy1TfrubxMYxIhmo3uiSd95ivIBxqJkntHaw1eNGY7ZKzzuURktlQvF70Hd1wQvKaCAPmLIR93rbdEadRea3sJ3HP29/PAK1BVWNQkvNK31Mggt/4sD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127902; c=relaxed/simple;
	bh=KuJmPdgYM52TyEfb5GOaYYy/Wz8zkqWtBSMWMCCCUXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXuTxOVAwA2zQt5/08czuP0tiBVliatbnZBDswxHX1yiUO8Luuez2ugmiM9DISTe7PvvbNnO+I8yPQmTeBC7pbk5HKhZ5a9XXuVYiK/mPUGbH4YypTgRKOy0PdReuv0QGqEjEutCl4CvtCgdo0tPsNNmGCHcHLlXXl8Zll5R8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AViKdRQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1E7C4CEED;
	Mon, 21 Jul 2025 19:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753127902;
	bh=KuJmPdgYM52TyEfb5GOaYYy/Wz8zkqWtBSMWMCCCUXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AViKdRQUgjZkH+Mbtvssorka8bkheIkitMNfiDbxUfb+690Dt1VuzCqU+7ttwe5Ad
	 kMPF6GD1v1DRk3vz0S1w8yKh2jsTm5YgQeqEbAGIhhM9HefDaeosAA4fK27RVMkKfy
	 qVsIHS6OB9L6yMwapvunD/anMfISkff2B8R0uhxqJkO8u/CFZlLgJdJcwAtJ+O8pr1
	 l493eO1Ku7LwqQMqMStazmD7gJXCwEMZ/VQL+lvqHIMD+CeqOiNbr5zO4epfHrA7sS
	 InnBoE+iqnd4Zpmy6wFJQOL3gt+1C1e8oyT6R8g3Rl78Kc8gaEU7F+Zhmlwo9piLu4
	 35tiwJnZhQuGg==
Date: Mon, 21 Jul 2025 14:58:21 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, ulf.hansson@linaro.org,
	y.oudjana@protonmail.com, fshao@chromium.org, wenst@chromium.org,
	lihongbo22@huawei.com, mandyjh.liu@mediatek.com, mbrugger@suse.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v2 03/10] dt-bindings: power: mediatek: Document
 access-controllers property
Message-ID: <20250721195821.GA1163453-robh@kernel.org>
References: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
 <20250707105605.98248-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707105605.98248-4-angelogioacchino.delregno@collabora.com>

On Mon, Jul 07, 2025 at 12:55:58PM +0200, AngeloGioacchino Del Regno wrote:
> Allow specifying access-controllers in the main power controller
> node and deprecate the old mediatek,infracfg, mediatek,infracfg-nao
> and mediatek,smi properties located in the children.
> 
> This is done in order to both simplify the power controller
> nodes and in preparation for adding support for new generation
> SoCs like MT8196/MT6991 and other variants, which will need
> to set protection on new busses.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 9c7cc632abee..82bfd3899b22 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -44,6 +44,17 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +  access-controllers:
> +    description:
> +      A number of phandles to external blocks to set and clear the required
> +      bits to enable or disable bus protection, necessary to avoid any bus
> +      faults while enabling or disabling a power domain.
> +      For example, this may hold phandles to INFRACFG and SMI.
> +    minItems: 1
> +    maxItems: 3

> +    items:
> +      maxItems: 1

Drop 'items' as how many cells is up to the provider.

> +
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
>      $ref: "#/$defs/power-domain-node"
> @@ -123,14 +134,17 @@ $defs:
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
> @@ -138,6 +152,31 @@ $defs:
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
> +        access-controllers:
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
> +        access-controllers:
> +          minItems: 3
> +          maxItems: 3
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.49.0
> 

