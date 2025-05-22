Return-Path: <linux-pm+bounces-27489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF5AC0694
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9C03A63E4
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9B26156A;
	Thu, 22 May 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npu2yHi7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFF261388;
	Thu, 22 May 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901283; cv=none; b=qtADKTjAcKJGdwxhkIwn1jkoT3wOqFYtmuwNy4ym8Ous3h08u/+5RHqyuxgAJLcP6le1LaERKNh4CfCh7aPK2MkLot/VLNuMVr+D09i0EHsZ2NKif/McRgXGWcK0xo9wuGkWgMciTpeFAL/+4aSm15umXl7LqNdRMcSbWVIIVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901283; c=relaxed/simple;
	bh=AsgpU/OXH0n6Yb0Oy9gxgm5VK9clyMyMr5CAUWaU9So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/kYQ3daosd9zwsU14L8aixl2UVN7HdD2pYontulp99/N9Ap5ES4C76Ks2cE6sO5vJo9+f7bGAZ2Vg9lbjlLlO0BBIJSGL4VOQCyODdGpJ75ry2TpZ4Mosxmp1qBX7Q8xNE6L/nSalhSrfGwtxLzu5JjMiVXY3VG54ZqrVNrfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npu2yHi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59EC4CEE4;
	Thu, 22 May 2025 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747901283;
	bh=AsgpU/OXH0n6Yb0Oy9gxgm5VK9clyMyMr5CAUWaU9So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npu2yHi7RF+x3QqPt86UJMSYYCX4TVIOqXQZrJCPm0uuRfr/u3IgWtctAkR7CYm5I
	 NvZmkWkMM0QX5lZchXerYvMg7LIh6xCfi8jr43v0dq4uBdDJkLIOtsxon0Zjz5ARJo
	 OGIhhRWlqEF2bkpOCwN6ZpN3DJJQyh33NbrZCRmrF7qsoQ6c39dHeqMc5sBT98t4B0
	 DDfd7DqR7cuVtRaCWrDNC7I17dkVBf0zUsiI6xE0zesRjD8qjHPoCzvUDVg3jd6ewR
	 /Z4kH6avZrHUWv27bQ2dlz1itw0POwicnltY+WaQzJpa+Zs1Ybskh3dMOyJkL0uabM
	 37XjpVdbKQfvA==
Date: Thu, 22 May 2025 10:08:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: kernel@collabora.com, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>, Hui Liu <hui.liu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Tinghan Shen <tinghan.shen@mediatek.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 2/3] dt-bindings: iommu: mediatek: Support 5 IRQs on
 MT8195 infra IOMMU
Message-ID: <20250522-foamy-cricket-of-defiance-edc2cd@kuoka>
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
 <20250514-mt8395-dtb-errors-v2-2-d67b9077c59a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514-mt8395-dtb-errors-v2-2-d67b9077c59a@collabora.com>

On Wed, May 14, 2025 at 10:19:57AM GMT, Julien Massot wrote:
> @@ -97,7 +97,8 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
>  
>    clocks:
>      items:
> @@ -201,6 +202,21 @@ allOf:
>        required:
>          - mediatek,infracfg
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-iommu-infra
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 5

Instead list the items here and in else:, or in top-level if first
interrupt is the same.

> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1

Best regards,
Krzysztof


