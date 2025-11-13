Return-Path: <linux-pm+bounces-37993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B1C59DD3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C6644E5719
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392731B10B;
	Thu, 13 Nov 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwlb74ks"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E482FC881;
	Thu, 13 Nov 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063683; cv=none; b=f7y9v9dmEtYaMKLDCANFHezNMg2vqQ6mKDkjiX5XEcFTSxTgKK4ftrvpa6JiVsvgQxt7Z8F9Hzx/oe4HO/vyFxesuZyORQWSWP61dAKDwstC8RUilbILaZBv1+EzBJEd36b4kntLjJi7iem8vTnLVUm0CSr2LUE+Se7OeqCI7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063683; c=relaxed/simple;
	bh=rd3gd8jpljtLVI/ul/oa4QUW2omKUk/tIvW4U3c4pUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaS6D0EONRoODTQeYphXdLM02wvFHkoTlv4d8bSAo3SJbcunky4ttsSJfFXNluI1EkERmHoUL7dXdvcnUtRgpI0Ncie90G5DdZNQUWw13c302vNgxogyl8IoLLiXdz1fm4u7cL1GTmEEenV9WHc71VAtDuTqxuoVmt5+0wKbY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwlb74ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8295EC4CEF5;
	Thu, 13 Nov 2025 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063683;
	bh=rd3gd8jpljtLVI/ul/oa4QUW2omKUk/tIvW4U3c4pUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vwlb74ksOhWYBHwKEmGH9f8msK/5U+iPbKtGhb1aPbLy0FRmBYZh8PrIJ0XVnY7PQ
	 H6m3h+mkdBQGsmsJfzXr3aF1wiSELK79ww6M1UezyDvL15I9yhRKGgSZoVtmAGyh2q
	 G+TOaPBkC7S2oeV26nIyks1yRe8p+y7ujd5AsJWGa5CnlpsRetMuHJq9HU4EZL8SFY
	 xTFoA9rznDQozeNA/vFvigi2fUE3C758EXAPisuBr/gO5N4Ki7e95mf3r1bT8K0H05
	 J3AhpmH2jTbejJpJSf369rsFUPzygXPRmqCFlO65BUeO2+liWE0R1TU3KwRe3ercrB
	 SvEFT74ztInQA==
Date: Thu, 13 Nov 2025 19:54:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 03/13] dt-bindings: extcon: document Samsung S2M series
 PMIC extcon device
Message-ID: <20251113-game-willpower-5ca93ea62cd0@spud>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
 <20251114-s2mu005-pmic-v1-3-9e3184d3a0c9@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z2jFyzIGjzo/0PsT"
Content-Disposition: inline
In-Reply-To: <20251114-s2mu005-pmic-v1-3-9e3184d3a0c9@disroot.org>


--z2jFyzIGjzo/0PsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:35:04AM +0530, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a MUIC device which reports
> various cable states by measuring the ID-GND resistance with an internal
> ADC. Document the devicetree schema for this device.
>=20
> The initial driver introduced has support for S2MU005, add its
> compatible as well.
>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../bindings/extcon/samsung,s2mu005-muic.yaml      | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/extcon/samsung,s2mu005-mui=
c.yaml b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
> new file mode 100644
> index 000000000000..8511bb96b47a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/samsung,s2mu005-muic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Extcon Driver for Samsung S2M series PMICs
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +description: |
> +  The Samsung S2M series PMIC extcon device is a USB port accessory
> +  detector. It reports multiple states depending on the ID-GND
> +  resistance measured by an internal ADC.
> +
> +  This is a part of device tree bindings for S2M and S5M family of Power
> +  Management IC (PMIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-muic

Why does this need a dedicated child node for just a port property?

> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - port
> +
> +additionalProperties: false
>=20
> --=20
> 2.51.2
>=20

--z2jFyzIGjzo/0PsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRY3fQAKCRB4tDGHoIJi
0kh4AP0XKLv/7QaeBB/tOO5jDegjLltpByS6Yu72YKSMZ2wxSgD+MyBrIbJZ7Auj
qjPG4CZpkpsPkWJyje/gPu4/l6XC7Ac=
=v6gL
-----END PGP SIGNATURE-----

--z2jFyzIGjzo/0PsT--

