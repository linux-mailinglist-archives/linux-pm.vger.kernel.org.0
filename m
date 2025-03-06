Return-Path: <linux-pm+bounces-23542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54819A54418
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 08:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503EB1886BEA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FB1E2838;
	Thu,  6 Mar 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWi8fvt7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D251DF964;
	Thu,  6 Mar 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247851; cv=none; b=lHZhrwiE6kkwUyDMisYS1R7DWy1PQOWTZz9d2wv9LkQxlKsTjTKIOyj88U3r/mfqU9u4hrZELIQEKqSaP/d1CwKXL77kKH5iE4X+devUzoX1k/ZoubIekcvnGrmLtLclfyHSHakNE/lyL0axeaiCZpbURml6fUHLClSI2mnakyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247851; c=relaxed/simple;
	bh=pH/NwpaMg9Ocf6/GG426eX1DXAWQDLNc+lU1WIH8/QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITbMGarVWct32V+iyLAoO3lVc8hbeZlOnN2vLrxnCH6aduWt02LdB8aVT4A9JvBpaFkXEMQUgLMHvNDojLGWcaf+V6JBkiehd0dNH3tXcEahSKK9x/QLxLZjxIX1wjCxvBuZ+u9ioQnFfFHjC/Q2JE8l5yi1lo1S8yuIpdXWIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWi8fvt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25FEC4CEE8;
	Thu,  6 Mar 2025 07:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741247850;
	bh=pH/NwpaMg9Ocf6/GG426eX1DXAWQDLNc+lU1WIH8/QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWi8fvt71RfuEChdxeFW1z5xzOV52XkMxEFre9acnh9RpzpbHDygtR55Xq9OnDKTw
	 yBakukkMrljf/7vLgd7Fd8FY7J9EkTMeDxHCw4CPnqlo62IqBwNZdGRL+jTP00WfHH
	 hfOHqjHu95VgIIVZtXkaPyiTI5+Z4wNDsQnvTKBrCoc2c646KbXq/ZjXnuF3Loqgkk
	 waPgyV0wIZ7PpHAqpd7iPcKVHVo+TeEfvYKLt6cQbcbOf0iebhvfb7fDGquXQ4JarN
	 G/JkFFk1ICN0jZ2eYvkCVNK4jviTojvPs8rAjIdaZRkhzBIeK5ufO67oLokGe6x5V3
	 sjWY1vIj0RzZg==
Date: Thu, 6 Mar 2025 08:57:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, kernel@collabora.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 01/19] dt-bindings: mfd: mediatek: mt6397: Add accdet
 subnode
Message-ID: <20250306-certain-jasmine-mastiff-fd67ba@krzk-bin>
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
 <20250305-mt6359-accdet-dts-v4-1-e5ffa5ee9991@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250305-mt6359-accdet-dts-v4-1-e5ffa5ee9991@collabora.com>

On Wed, Mar 05, 2025 at 03:58:16PM -0300, N=C3=ADcolas F. R. A. Prado wrote:
> Describe the accessory detection (accdet) module as a possible subnode
> of the MT6359 PMIC.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 51 ++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b=
/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 6a89b479d10fad3c8b61cab5a3af1453baca4d1a..51012b8bbfaef3df7bdb619a4=
f8d828d6f9cc15a 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -24,6 +24,7 @@ description: |
>    - LED
>    - Keys
>    - Power controller
> +  - Accessory Detection
> =20
>    It is interfaced to host controller using SPI interface by a proprieta=
ry hardware
>    called PMIC wrapper or pwrap. MT6397/MT6323 PMIC is a child device of =
pwrap.
> @@ -224,6 +225,30 @@ properties:
>      description:
>        Pin controller
> =20
> +  accdet:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      The Accessory Detection module found on the PMIC allows detecting =
audio
> +      jack insertion and removal, as well as identifying the type of eve=
nts
> +      connected to the jack.
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mt6359-accdet

You just removed the other file, no folding happened here. Drop the
accdet node and fold this into parent.

Best regards,
Krzysztof


