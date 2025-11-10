Return-Path: <linux-pm+bounces-37758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A9C48A03
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 19:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 896554E27DC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7023183B;
	Mon, 10 Nov 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqYCHOxH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F161C695;
	Mon, 10 Nov 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800327; cv=none; b=dRXeelVTuAuqDOVVWPgAbdT4w3zhjk/FwjU/hsEk66RHvKlI4qKEvuYzk/oIsByF7Y1RtcFQfih3e0EFurKYckghSu5mvh2zb/znoQyHtv4vYq90EKqtNB+67Or+vRn8yGW91PCA+jALGendFqIPcuvZL7U+3o+0naR6ECDyYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800327; c=relaxed/simple;
	bh=h+hvokvmCCTDbp1ZtZ5LLSZHkoGj3sCDkVi6fIPluaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQsX9PxtLKwA0wT0ZyMjYm5vahTNArln30Y3kV5Kmd+ydoq0Xac4hS07r5aeGploi/FBZykgwmZ8XjJ27Lhw+qjrd1Ivag3nY7M6pWBmzMjXVc83iQV3bFz+X9mVy/K8JyLbGctTCoWsomDSEF/ZMRX9BQfdzQgukl+cNLU9eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqYCHOxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A14C16AAE;
	Mon, 10 Nov 2025 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762800327;
	bh=h+hvokvmCCTDbp1ZtZ5LLSZHkoGj3sCDkVi6fIPluaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqYCHOxHrTmZdzB1WxpNF61c/7mzYYd64sAZLx7pm8fQ5FHdlPMVUWCNq5lZAwAYN
	 IARYZ2xi5eguyUrK1/n3ud3g+I0ZVTtbej0tMgp4HaqrpUGr6nKS3g7goyyNjC4IQF
	 oW+wjYzjH0dVZeWGbOrt19dSO1ye+/BrWqoYn0UXZD2AcwYRFjs9tyDTxmJZAYmCSl
	 VIF6FxfnPJMrGiIr6yoqN2avq8U+z7iHGwcmEmIetJTs7RvoT01JA/f/9cWQfhvhvD
	 5iqagu1+YKiqxcr94E3Lz5l2N1jsnWZOUXxx1cZgWqckCMiKMhK49cP2xHOuJDQVLd
	 Rd02bg09psC6g==
Date: Mon, 10 Nov 2025 18:45:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Hanchien Lin <hanchien.lin@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	raymond.sun@mediatek.com, Irving-CH.lin@mediatek.com
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8189: Add thermal controller
 node
Message-ID: <20251110-vagueness-waggle-50b8efe728a8@spud>
References: <20251110094113.3965182-1-hanchien.lin@mediatek.com>
 <20251110094113.3965182-2-hanchien.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C0KGNy2z0JyurDwg"
Content-Disposition: inline
In-Reply-To: <20251110094113.3965182-2-hanchien.lin@mediatek.com>


--C0KGNy2z0JyurDwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 05:40:38PM +0800, Hanchien Lin wrote:
> Add device tree node for the thermal controller on MediaTek MT8189 SoC.

$subject is incorrect for a binding change.
pw-bot: changes-requested

>=20
> Signed-off-by: Hanchien Lin <hanchien.lin@mediatek.com>
> ---
>  .../thermal/mediatek,lvts-thermal.yaml        | 27 +++++++++++++++++--
>  .../thermal/mediatek,lvts-thermal.h           | 20 ++++++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.=
yaml
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
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8189-lvts-ap
> +              - mediatek,mt8189-lvts-mcu
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
> =20
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
> =20
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
>    - nvmem-cells
>    - nvmem-cell-names
> =20
> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/includ=
e/dt-bindings/thermal/mediatek,lvts-thermal.h
> index ddc7302a510a..6c9103dfdc2d 100644
> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
> @@ -42,6 +42,26 @@
>  #define MT8188_AP_CAM1		6
>  #define MT8188_AP_CAM2		7
> =20
> +#define MT8189_MCU_BIG_CPU1     0
> +#define MT8189_MCU_BIG_CPU2     1
> +#define MT8189_MCU_BIG_CPU3     2
> +#define MT8189_MCU_BIG_CPU4     3
> +#define MT8189_MCU_LITTLE_CPU1  4
> +#define MT8189_MCU_LITTLE_CPU2  5
> +#define MT8189_MCU_LITTLE_CPU3  6
> +#define MT8189_MCU_LITTLE_CPU4  7
> +#define MT8189_MCU_LITTLE_CPU5  8
> +#define MT8189_MCU_LITTLE_CPU6  9
> +#define MT8189_MCU_LITTLE_CPU7  10
> +#define MT8189_MCU_LITTLE_CPU8  11
> +
> +#define MT8189_AP_SOC1          12
> +#define MT8189_AP_SOC2          13
> +#define MT8189_AP_SOC3          14
> +#define MT8189_AP_APU           15
> +#define MT8189_AP_GPU1          16
> +#define MT8189_AP_GPU2          17
> +
>  #define MT8195_MCU_BIG_CPU0     0
>  #define MT8195_MCU_BIG_CPU1     1
>  #define MT8195_MCU_BIG_CPU2     2
> --=20
> 2.45.2
>=20

--C0KGNy2z0JyurDwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRIywAAKCRB4tDGHoIJi
0rCTAP9newdSvzQ50dBkzqSM5wtiWoT8lSk9sQqFZvPJH+LPZQEA5SXT+Bxj/MFp
miT6FPn/6265Zc6AXcJjiSewgImm9wA=
=HeTN
-----END PGP SIGNATURE-----

--C0KGNy2z0JyurDwg--

