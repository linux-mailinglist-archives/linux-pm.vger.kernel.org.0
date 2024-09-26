Return-Path: <linux-pm+bounces-14832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0A98773A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E16B2ADCB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C4E15C137;
	Thu, 26 Sep 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7HvlSFA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C3153BF7;
	Thu, 26 Sep 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366706; cv=none; b=L3RQWHXfW9++mjMcjJ3H+czJiNzcNPMFyQ7cLN2WqNd/YhFMzdGP4ocAe6uStjJh5agOXP/GHRDFTLlmns1eTuIActeWX5FqSzGh33rAEyaYFTs3Y+K46CAY3QmWQlLkWTjQr9sC6dPXD37A3VRsnBZ7xrFG9jQvttA/znQcuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366706; c=relaxed/simple;
	bh=8oF862eULQ8YFoJtKU6F4+GDmwMiUNpW0n24amXJv4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdUV7R/R8VjhUZQNhdFxrC4cPzUpy7Az+yJSOhW/tQTK0RUAYydVi/Ihr9bPE1iXfPflR+lIXOXhXq5dYYubb7mohevwEv9OHLZY4pLTMtLVmtl7f4GKgVofq152W8CrcRIHGOwkxtqtM8HrkGb9Vlx9vAV5N4BzYZZXi4zYwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7HvlSFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F23C4CECE;
	Thu, 26 Sep 2024 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727366705;
	bh=8oF862eULQ8YFoJtKU6F4+GDmwMiUNpW0n24amXJv4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7HvlSFAY1HpayQkyF0ijnpGCTEfRC6oQ8lepirwQIRabQuVyr4k7Zzcja9HKmqns
	 qEXlzEiGWQNyb51qNuW1buk6zlOnjz6AjfNry3FfJXnvsucsFAX/ef5PPnhepd0yTF
	 AkQa0VVTifqwh1JO7LbhkCMLBmV+zkDrKfABvzFZYYmbWmI2TZ76y0DzHzZZBCb6NH
	 gCrn/Dnjwp8evthCeCve3uNResHbQiJ1nsE7zcBoRsyruP478/CvfdqeM0NDg7o+v6
	 uW9mjXvFiPkh3cpANJ2YUsIu+sqww1y4UJATUIBGnX6jR+F4+CHmY4850FpHo2/tFz
	 QeSU6xNxdFMOQ==
Date: Thu, 26 Sep 2024 17:04:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Eason Yen <eason.yen@mediatek.com>,
	Jiaxin Yu <jiaxin.yu@mediatek.com>,
	Shane Chien <shane.chien@mediatek.com>,
	Hui Liu <hui.liu@mediatek.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: mediatek: mt6397: add compatible
 for mt6359-codec
Message-ID: <20240926-smokeless-clobber-0fb8a1cdc7ab@spud>
References: <20240926092519.6556-1-macpaul.lin@mediatek.com>
 <20240926092519.6556-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gtFGL1RUPZo9Sk8n"
Content-Disposition: inline
In-Reply-To: <20240926092519.6556-2-macpaul.lin@mediatek.com>


--gtFGL1RUPZo9Sk8n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 05:25:18PM +0800, Macpaul Lin wrote:
> This patch updates the audio-codec properties includes:
>  - compatible:
>   - Re-order the supported device items.
>   - Add 'mt6359-codec' to compatible since MT6359 PMIC has been included
>     in this DT Schema.

>   - Set 'additionalProperties: true' for 'mt6359-codec'.

Why?

>=20
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b=
/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 40cabaf60d0d..ffb5848a96d5 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -104,7 +104,7 @@ properties:
> =20
>    audio-codec:
>      type: object
> -    additionalProperties: false
> +    additionalProperties: true
>      description:
>        Audio codec support with MT6397 and MT6358.
> =20
> @@ -112,8 +112,9 @@ properties:
>        compatible:
>          oneOf:
>            - enum:
> -              - mediatek,mt6397-codec
>                - mediatek,mt6358-sound
> +              - mediatek,mt6359-codec
> +              - mediatek,mt6397-codec
>            - items:
>                - enum:
>                    - mediatek,mt6366-sound
> --=20
> 2.45.2
>=20

--gtFGL1RUPZo9Sk8n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWGKgAKCRB4tDGHoIJi
0nLMAPwNICZFxiXu4ZhvDLmOlTakmKiEVOTVZu/0hCQuyldZZQD+LrT5WwoJnbMH
g+uamV5Vyo9o/jF8L1GRHbGmPCz4kg4=
=sQf+
-----END PGP SIGNATURE-----

--gtFGL1RUPZo9Sk8n--

