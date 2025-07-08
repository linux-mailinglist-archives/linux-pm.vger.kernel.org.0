Return-Path: <linux-pm+bounces-30394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6999AFD703
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 21:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC21C2475F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868FB2DC35C;
	Tue,  8 Jul 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZZbEkp5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B221CC44;
	Tue,  8 Jul 2025 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002299; cv=none; b=bN8HDVvUoX0zyrHNQrN76XPJ9tCfqjpL3a/RSDOo/WJizbQwoJpvz18ACTDwFs+gATFDKj9EQKH4oaY4kwN0LFxoNcqMPatdS7l3wFuIqbWAW3Pq/gb3iT3VpRDTHW7QuhwlnLrF05dw11s4azT8mt0Mm4YrPd4hNQ4zPhS0xwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002299; c=relaxed/simple;
	bh=CqxReAjk4p+ThDgdhazjTZmOHtB9hZJ/Bma1N9kU+Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvhmgDYwS7vfR+moNXByN2igaXAjz5g9i+yfF95gkjTyF1nkFfP7rLLwJ05xqxFFpobAzZn3WtC8oTd72l0K02w6J4c7VPSW8oxX7vnVHT4+/tJrwkxVZr8PxnbdxtXMvz10Usn+4x8aEad1jvTPKOOvCcVy9tqseGrCcEc5xVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZZbEkp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A0C4CEED;
	Tue,  8 Jul 2025 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752002297;
	bh=CqxReAjk4p+ThDgdhazjTZmOHtB9hZJ/Bma1N9kU+Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZZbEkp5Qh7CYJ/We3wQhmgXCmuLJuq9jo3slSJ1B8UvZ+bVszH1wC/78AbyAyuVU
	 P3b6zw1YqWv7n5VW5NDZjf0vnEOPuK/7x90h1eGdnMgxaTdOWaFTPWIcsAI/d6hgJq
	 q4JsimkJIJ3inT1x66GZI9zQgF9qvspCZ2ZetLSvDDxVLw+AL3WPJ/9NfMKD9wddrr
	 4xC1/PCtuQfQM85NHeOkbJ9saLQBUTCgpl81LIGrIxCaUvHVMeWGpVhaaLOECwqWg4
	 KtPuAlJpAQWktPtHVBYAPwBfge5/HtOiIvmnuDYx29fVXTsF6Rt8aZav8kX7V5kBzp
	 TPO0L181oPFng==
Date: Tue, 8 Jul 2025 14:18:16 -0500
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
Subject: Re: [PATCH v2 01/10] dt-bindings: memory: mtk-smi: Document
 #access-controller-cells
Message-ID: <20250708191816.GA770716-robh@kernel.org>
References: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
 <20250707105605.98248-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707105605.98248-2-angelogioacchino.delregno@collabora.com>

On Mon, Jul 07, 2025 at 12:55:56PM +0200, AngeloGioacchino Del Regno wrote:
> Some of the SMI Common HW provides access control to at least
> the power controller: document the #access-controller-cells
> property and allow specifying it only for MT8183 and MT8365
> as those are the only known SoCs with an SMI acting as access
> controller.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../memory-controllers/mediatek,smi-common.yaml  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 0762e0ff66ef..74b355a08493 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -74,6 +74,9 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  '#access-controller-cells':
> +    const: 0

Kind of odd for an access controller controlling only 1 device. You 
said 'at least', so maybe this should be 1?

> +
>    mediatek,smi:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: a phandle to the smi-common node above. Only for sub-common.
> @@ -168,6 +171,19 @@ allOf:
>              - const: apb
>              - const: smi
>  
> +  - if:  # for SMI providing access control
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8183-smi-common
> +            - mediatek,mt8365-smi-common
> +    then:
> +      properties:
> +        '#access-controller-cells': true
> +    else:
> +      properties:
> +        '#access-controller-cells': false
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.49.0
> 

