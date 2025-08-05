Return-Path: <linux-pm+bounces-31973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6648B1B9A0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E16718A2297
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA4293B5E;
	Tue,  5 Aug 2025 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0iIvbdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C3A55;
	Tue,  5 Aug 2025 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416435; cv=none; b=htui4myC0RKggFqOjJb6T/vq4qpDBkXZW2DfDmEpxgNRe+YSEG4mZ32X6sPuLSfourTK81Pl5TUeIWSF/i6vYOA55NaXtWsknga/ZzCXI3GvbzlXS95hEQ3emlIG4MonjCWwFK5L1M1wTo/t/90oZmC6NJDN0DLTI/e1DOWBDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416435; c=relaxed/simple;
	bh=MioYAhNotFZUh9CEi5VyuJwmmwIaFoi439ziNU1/xZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4COUQQ1qwOGHoiQZk78JE9jYSYJh0r6VhVD10G08M65DwV3qn+hQ3HbcJpX3zTBc1Aem1EHQJEwOGneiw1fKDDRVFiOUVXttshxG6pb4FO4dkxvPnnzdqEHHQ0kRYliKCuXOX3VAICTyYsEedmiQAKeJx6gTGbsqKToXISl3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0iIvbdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096A5C4CEF0;
	Tue,  5 Aug 2025 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754416435;
	bh=MioYAhNotFZUh9CEi5VyuJwmmwIaFoi439ziNU1/xZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0iIvbdpeFbfMCoUWOUNU6swI/EliSO8PLGjxXx+2FqXmmPipOCslpqGmJ+l8jyB2
	 A+aDpXNCe0HKve5SYckNe3zMxD3rBB/7wLlwSN7vaqQfth8M91o0slwsy/Bi5GtykL
	 LXBLRw071Lwk9PTvI6aAvbjIyCbFUIvlAWlk7UdUst6+i3nwnv76RM4fVdqPQH9BgK
	 fiYR07U4n20ZLUIh2s/hhrPMjCxfQEZfWfGh9zqa4TbXnbIwjtmLq925h+WOu833r7
	 0QZzLibgzVmlUQEyNJp8e8aNFejaB0WpEBVppck6Qsw/e71L90hcSAC/+efBA509aZ
	 /+o0a8OE8rhfw==
Date: Tue, 5 Aug 2025 12:53:54 -0500
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
Subject: Re: [PATCH v3 01/10] dt-bindings: memory: mtk-smi: Document
 #access-controller-cells
Message-ID: <20250805175354.GA2004232-robh@kernel.org>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
 <20250805074746.29457-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805074746.29457-2-angelogioacchino.delregno@collabora.com>

On Tue, Aug 05, 2025 at 09:47:37AM +0200, AngeloGioacchino Del Regno wrote:
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

I'm still wondering why this is 0? That seems odd that an access 
controller is 1:1 with a device.

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
> 2.50.1
> 

