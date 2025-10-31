Return-Path: <linux-pm+bounces-37224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE3C25C7E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AC764F47D4
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F81DC198;
	Fri, 31 Oct 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsTz/Cp+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1485626;
	Fri, 31 Oct 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923090; cv=none; b=Q+ebCM8hoizp4Kuen2gKXbDddJEM9EZkjKajvEGXo7LTCkvzIsgutgHVEQ7fT0VJEC52SCXUfy+2epyEzIVzs3ZrXiv2T7BU0XpdL0kOBVwfKwRlCqkWiurCxhCylTOSJOAsBa2lelBnKB9Nxhkcm8UhROMbef7vQk0vwt47M7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923090; c=relaxed/simple;
	bh=abvCv24Xykh2zMnbow02BKPEdSW0lshmPG5OcfXFUUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0gIVhB9hw/dvpbrp+acM91PMe8FSg8Crlve/rpruR37Q2dFHoMYfYHUkaqVv2V76p9yR6eGJaqMfHQ8rryXs+UzKQoqvlc3NYIplXrVAJ/Z7o/sWofAy2hoBHePQCryLIqEO74pNR7I9LUCf7n+hoVc0z5anWJG9gz0AFgmIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsTz/Cp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2A1C4CEFB;
	Fri, 31 Oct 2025 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761923089;
	bh=abvCv24Xykh2zMnbow02BKPEdSW0lshmPG5OcfXFUUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsTz/Cp++0swcNCc25qYTvDYYyFsuMx1yzIbuqupV+UMJxOdNxkGL/I1ZNGNwacJ7
	 rAIisu/ZFnoyzsfS1jNl2MhHYU4JawMAWniVGUFUvBjao73krdR705gmzFsQaiZjGn
	 vDKXps+a/U1wjkEoYnVwIPOyHZ5c8GtQZ3RXC8hyM/z3/tpuwwh0pbW+70UD+Bz2pL
	 jqiW/Kqu3tcfSUR/hh54eBLTlpm4nteul4pfH6PCY8gojN/2oneyWCWElbD6Ww4ZNH
	 9M6Ig+x5gKbkWyyG4gUop6ep19GG64vXkP4A/ywcwjtwKP2Pz4Xp4t18Zm4BkOA3F+
	 6wsi4YElvDgkw==
Date: Fri, 31 Oct 2025 15:04:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Willow Cunningham <willow.e.cunningham@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: bcm: Add bcm2712 compatible
Message-ID: <20251031-icon-woozy-58061dd3d4b4@spud>
References: <20251031102423.1150093-1-svarbanov@suse.de>
 <20251031102423.1150093-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eLR4aUssiEfZ2HhD"
Content-Disposition: inline
In-Reply-To: <20251031102423.1150093-3-svarbanov@suse.de>


--eLR4aUssiEfZ2HhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:24:21PM +0200, Stanimir Varbanov wrote:
> Add bcm2712-pm compatible and update the bindings to satisfy it's
> requirements. The PM hardware block inside bcm2712 lacks the "asb"
> and "rpivid_asb" register ranges and also does not have clocks, update
> the bindings accordingly.
>=20
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 38 ++++++++++++++++---
>  1 file changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.ya=
ml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> index e28ef198a801..ce910802ee9d 100644
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> @@ -13,23 +13,21 @@ description: |
>  maintainers:
>    - Nicolas Saenz Julienne <nsaenz@kernel.org>
> =20
> -allOf:
> -  - $ref: /schemas/watchdog/watchdog.yaml#
> -
>  properties:
>    compatible:
>      items:
>        - enum:
>            - brcm,bcm2835-pm
>            - brcm,bcm2711-pm
> +          - brcm,bcm2712-pm
>        - const: brcm,bcm2835-pm-wdt
> =20
>    reg:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 3
> =20
>    reg-names:
> -    minItems: 2
> +    minItems: 1
>      items:
>        - const: pm
>        - const: asb
> @@ -62,7 +60,35 @@ required:
>    - reg
>    - "#power-domain-cells"
>    - "#reset-cells"
> -  - clocks
> +
> +allOf:
> +  - $ref: /schemas/watchdog/watchdog.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - brcm,bcm2835-pm
> +              - brcm,bcm2711-pm
> +    then:
> +      required:
> +        - clocks
> +
> +      properties:
> +        reg:
> +          minItems: 2
> +
> +        reg-names:
> +          minItems: 2

> +
> +    else:
> +      properties:
> +        reg:
> +          minItems: 1
> +
> +        reg-names:
> +          minItems: 1

This else has no impact, was it meant to be maxItems?
pw-bot: changes-requested

> =20
>  additionalProperties: false
> =20
> --=20
> 2.47.0
>=20

--eLR4aUssiEfZ2HhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQTQCwAKCRB4tDGHoIJi
0u7TAQCmY6ZrffsQeMrCOnwJwR+6+0PBxTS+VmwCXHJmSg55VAEA4E7lbHlwkUcC
Yp1juErjw5xEnoaFEYM/iaJJlh3erwY=
=eDwv
-----END PGP SIGNATURE-----

--eLR4aUssiEfZ2HhD--

