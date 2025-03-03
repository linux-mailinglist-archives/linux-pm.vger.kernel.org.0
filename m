Return-Path: <linux-pm+bounces-23322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9D1A4C465
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 16:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3951A171A76
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98497214223;
	Mon,  3 Mar 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY06sI30"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D2212D63;
	Mon,  3 Mar 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014699; cv=none; b=a1zCdlXHid/Fm71aJj4c/AlWI4d7qAM49vMmorLgwH7UGAvLObXpabVSLXLgAFqLt/xYoLgmBJ7Dns9JneT7PdcjXHexiSBBRQ3pa7C8cNiycUmM/xDr/MbaJ9wKwWRgtUBcMHwdHtH2iQLVjy5TqW1Q2e01/GXpLGa+XuqI4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014699; c=relaxed/simple;
	bh=G/dwvTYbi29J7qZDLqsdsunHt5wGMVf9N068m47ts/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsby5aZHcvnRHaMuQ91fAgMnDkYiM+SO1YtkzYEdC7Ql+ExOJBQJCrQGtJGyKlj89XvZzMIwxT0D0cjpp8f1RXQBYjyLZNA+b4UpUN44JIHvqqznYzx5L3NfIs7bfKXrqcHSaduWi6XeodrbFlW9BI/i9aDahUaSYFl5FPiSlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY06sI30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBC3C4CED6;
	Mon,  3 Mar 2025 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014698;
	bh=G/dwvTYbi29J7qZDLqsdsunHt5wGMVf9N068m47ts/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MY06sI307vcBUkl0yjLJUOLKbfIs9ElMYH5Nfmz2zop1X2cO2qijkn00N3ZSVDZSu
	 94V89LwyvSzcRizck5nfgyHiTDh4H0JvWhTOGo/3txQJsTKOqszFNVw/z46/Jc/SK7
	 AxvWjYo6rY24lPQAi/mTPc8tmPVTJX9jDFceZ36wtO+uzdSDRSG85o1ReH7hOoX8Ig
	 +CltfvNKVL2iRLj1H6Nj89OK9vaj9k6ixUVjflUmemK52iNza3fJiIwBNsGYYJsYbC
	 K3/C58ov5uThD31PFIW3ZfNxC8bmCrDis4MMz1uzLh3Xfv1sI7XqXpfWE0uLocmmY3
	 F+yZHzV9WmYGQ==
Date: Mon, 3 Mar 2025 09:11:37 -0600
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
Subject: Re: [PATCH v2 01/20] ASoC: dt-bindings: Add document for
 mt6359-accdet
Message-ID: <20250303151137.GA1862020-robh@kernel.org>
References: <20250302-mt6359-accdet-dts-v2-0-5bd633ee0d47@collabora.com>
 <20250302-mt6359-accdet-dts-v2-1-5bd633ee0d47@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302-mt6359-accdet-dts-v2-1-5bd633ee0d47@collabora.com>

On Sun, Mar 02, 2025 at 01:30:40PM -0300, Nícolas F. R. A. Prado wrote:
> Add dt-binding for the MT6359 ACCDET hardware block.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  .../bindings/sound/mediatek,mt6359-accdet.yaml     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d08a79301409374714c76135b061e20e8e8acfaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt6359-accdet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6359 Accessory Detection
> +
> +maintainers:
> +  - Nícolas F. R. A. Prado <nfraprado@collabora.com>
> +
> +description: |

Don't need '|'.

> +  The MT6359 Accessory Detection block is part of the MT6359 PMIC and allows
> +  detecting audio jack insertion and removal, as well as identifying the type of
> +  events connected to the jack.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6359-accdet
> +
> +  mediatek,hp-eint-high:
> +    type: boolean
> +    description:
> +      By default, the HP_EINT pin is assumed to be pulled high and connected to
> +      a normally open 3.5mm jack. Plug insertion is detected when the pin is
> +      brought low in that case. Add this property if the behavior should be
> +      inverted, for example if a normally closed 3.5mm jack is used, or if the
> +      line is pulled low on open.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    accdet: accdet {
> +        compatible = "mediatek,mt6359-accdet";
> +        mediatek,hp-eint-high;
> +    };
> 
> -- 
> 2.48.1
> 

