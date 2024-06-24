Return-Path: <linux-pm+bounces-9908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71714915507
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7F7281F6D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD1919EEA2;
	Mon, 24 Jun 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYM5g7GW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE991EA87;
	Mon, 24 Jun 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248851; cv=none; b=j1yjlI/T2sOE/lpM0gNWgGop4CEnoKpQdrMgGMTLOwPJF1ooJ/A+25MJdPl/V1YRMMnUQkAVeuw8b6Fb3GzaiS4S0GQPo71XKv+xwzvWUagl21mtMYJ7Ll2fMdTyMRSBZoVZFB+KhjHGN7QZg43p+E3R3vMs+JgDuv1KspupiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248851; c=relaxed/simple;
	bh=xVjgbxgIL6BdkCx5ma5KcWzBtgfiKZ7zaKg5Ec62yS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvYzEhAWpTUQOcNa8JXgefsBLTF9DKtpN88wfCXgUlsP2+5i+KO/H1LB6AZAjH0SX0tyZlaUEWvasn+NsdKoUeP23x1fFBc3SJmvDfHAo3y7DiVSFfGxieZaYN1QL2WxicUx2c6PR9UUxIqh/hXdIixMuy+hXIs9KSGXXD6151w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYM5g7GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF49AC2BBFC;
	Mon, 24 Jun 2024 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719248850;
	bh=xVjgbxgIL6BdkCx5ma5KcWzBtgfiKZ7zaKg5Ec62yS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYM5g7GWxzB6c3iSoA/1v+VC4k5KN3q6bmB/o7J0uIcfPxuXTLLEaesMKs9/KZAX1
	 kE770aoUUViwYqw34Ibhh4KMup0tKxx9pfGAa4oZ/HEDaYPF/l8rSznmLKjzvTUHmF
	 p7sssG/whKSVdSA89NeEKmoFLWg3xJd8SbOy4dmSFUDlClOnGzSgJ7Hbrsl3LqWM0J
	 LuBUCv/B4XMOKU/xf9XQbE0gfSWcxmhdzihvh8qz9mdQTbDnx/G/4BVNBUFC4jKC/l
	 DmEoJE5bgoMYuEVfYN2vYLXcFu4fYMXDxxuzYCIk3ePLwouS4M5PdPGOBYj65kOTie
	 Z5k+qna58BsSA==
Date: Mon, 24 Jun 2024 18:07:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH v5 1/2] dt-bindings: power: supply: add support for
 MAX17201/MAX17205 fuel gauge
Message-ID: <20240624-risk-sixtyfold-3b5f82833615@spud>
References: <20240621125744.363564-1-dima.fedrau@gmail.com>
 <20240621125744.363564-2-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c4ZUpTGjldgbfpX4"
Content-Disposition: inline
In-Reply-To: <20240621125744.363564-2-dima.fedrau@gmail.com>


--c4ZUpTGjldgbfpX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 02:57:43PM +0200, Dimitri Fedrau wrote:
> Adding documentation for MAXIMs MAX17201/MAX17205 fuel gauge.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max1720x.yaml | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,=
max1720x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1720=
x.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
> new file mode 100644
> index 000000000000..dc3e0e7cb2ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max1720x.yaml#

s/1720x/17201/ both here, the title and in the filename please.
With that changed,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX1720x fuel gauge
> +
> +maintainers:
> +  - Dimitri Fedrau <dima.fedrau@gmail.com>
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: maxim,max17201
> +      - items:
> +          - enum:
> +              - maxim,max17205
> +          - const: maxim,max17201
> +
> +  reg:
> +    items:
> +      - description: ModelGauge m5 registers
> +      - description: Nonvolatile registers
> +
> +  reg-names:
> +    items:
> +      - const: m5
> +      - const: nvmem
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      fuel-gauge@36 {
> +        compatible =3D "maxim,max17201";
> +        reg =3D <0x36>, <0xb>;
> +        reg-names =3D "m5", "nvmem";
> +        interrupt-parent =3D <&gpio0>;
> +        interrupts =3D <31 IRQ_TYPE_LEVEL_LOW>;
> +      };
> +    };
> --=20
> 2.39.2
>=20

--c4ZUpTGjldgbfpX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmnzgAKCRB4tDGHoIJi
0sJuAP4oa/nY+pl3xEPLYrrj7PVV/pGENjWvjklF0u403a1vWgD/d5QZLRwuI4KV
VJW28K/aQ3STiD4yBgZusbMsdusRlwU=
=twk9
-----END PGP SIGNATURE-----

--c4ZUpTGjldgbfpX4--

