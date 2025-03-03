Return-Path: <linux-pm+bounces-23323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B006BA4C46D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 16:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC5E1887647
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100121422D;
	Mon,  3 Mar 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVD5y0vS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B9212B04;
	Mon,  3 Mar 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014823; cv=none; b=mUlc2cCPCGwPzzlLXPOY8Ps1k4jwoXGtuZAyDGSbbbM/lIbcnqr+hM262YarwXgEgCLh4fqkkAn8WVQMxvUVfuO1ngho7QDhfpq7cqIXIV+w6YI+9thNOSu68VF+kxsXWMykb0vX0NEEgtJauEquixkbG6KtCZnwbrBXcu8FTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014823; c=relaxed/simple;
	bh=SBZUhpymT0Ng8SaIzcFPvGl+P4B6oU/H9HGvmO04ZRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceyjdw2Qi83gFiWmMb6wwn0mNnxKVMw6393GT+8un5PnF6QF4EibqcHFpKuRNvu64y4cSmo3tyxIQP3J6vxdJKAgBZ4mcn24ll0N5h8mGdz1Jy0dt5lM2SZRgmv4LXYbGFWAKIn58tmYKEWYSMEHOtZ+el2bmmLePYCC3zFaEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVD5y0vS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C37C4CED6;
	Mon,  3 Mar 2025 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014823;
	bh=SBZUhpymT0Ng8SaIzcFPvGl+P4B6oU/H9HGvmO04ZRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVD5y0vSsPRzl4ffSylCValEHdYfZACbN3DXT7ToG+Yo4xmYpiWkPgMq9EsURnvMO
	 qow6QiO6v+Mi+w7MSpc9GxRMEG9R6nIj1MJkBLRhLMDDrLwAv7pbA6kHJrvVJ7hhur
	 Pndcx8h01cmrjSiuOb2KlcH7AdedTY/NGaCn6g3ZvVw/A3s55Gn88NTWN7NhUaqWA9
	 Z6YPNAYxRiTGGBmxhM5uuLVomxTwvOUlSDaC5uiNuuUC2Wa5Yx+KQVo/dg3YlncFsG
	 OpSWdhfFDs+QYpHXzvxWaJy+i/zvLwLfOxbuWCvpyy1VbQ5bIkNby1ERABE2HNWM2M
	 JGdo1lx90dhaQ==
Date: Mon, 3 Mar 2025 09:13:41 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel@collabora.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/20] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
Message-ID: <20250303151341.GA1865196-robh@kernel.org>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-2-5bd633ee0d47@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302-mt6359-accdet-dts-v2-2-5bd633ee0d47@collabora.com>

On Sun, Mar 02, 2025 at 01:30:41PM -0300, Nícolas F. R. A. Prado wrote:
> Describe the accdet as a possible subnode of the MT6359 PMIC.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..1a8c5748a28da6ad8aa091f8c0a74bc1dc709644 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -224,6 +224,13 @@ properties:
>      description:
>        Pin controller
>  
> +  accdet:
> +    type: object
> +    $ref: /schemas/sound/mediatek,mt6359-accdet.yaml
> +    unevaluatedProperties: false

Don't need unevaluatedProperties here. The referenced schema already has 
the constraint.

> +    description:
> +      Accessory Detection
> +
>  required:
>    - compatible
>    - regulators
> 
> -- 
> 2.48.1
> 

