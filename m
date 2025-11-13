Return-Path: <linux-pm+bounces-37994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A206AC59E0F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3935A3530DA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7831B80E;
	Thu, 13 Nov 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYEzuM9N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28776026;
	Thu, 13 Nov 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063852; cv=none; b=leHNWrodjFF8kGR0AMNBCG27KEN0XVq6tecFQxmPEwMyBD+uxOGxP7ZfU+cWWJMljbxcoTyyWNoTDBWzyi95FcBzFaTZMIiCBRaAtF6yHgjTdqT7IFyzPGMI9MIkTbiBw1qn21w8puJ8U19GcuEqONKjH8KCtqnp3vzRKYj6suI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063852; c=relaxed/simple;
	bh=puo0UoB37ZnIPSLQ+4sdZrPawcM3Ismb6YVyUz2aLwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V463ttrkSu2zxVDt9DQbVKbBuDcc/8GTfDkukCpY7Zpj10Dlryva75kx9o5tY4+I8EwwCCLyM6doLDab0BZXiEKdyrqw9xYXmzW9/Q4C6xSzxL8qIyDPDb3lTAN0D2A5sr0dawc29CUXfEWM0GVGXaZfk2sVhUIL4H8D0TDhbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYEzuM9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BADC4CEF5;
	Thu, 13 Nov 2025 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063851;
	bh=puo0UoB37ZnIPSLQ+4sdZrPawcM3Ismb6YVyUz2aLwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYEzuM9NfSh3sWGMHViESvr3w7FufROCVw1qN0xO7aPwIQqauF+9tEO45BOKCoD0L
	 IfUY4to5+TjoonkFYBv5XMiLmV4sHa6ml0Adr4TEFbcMFjdlmzf5Cl0UhiybpOz55Z
	 RmIS4K6cU3HbYZ44+FPGaZSstZdKGowNlCkyd8Jjt+xzORKuGG9vbYMV6lgLeGAlzj
	 ZhiltSJL4r0ZLOSU4wglstb1hwUUkTDK8c16AhEBdmOR8YY/J0EmncaZyBXOJhcl4d
	 gBQaDYPmNsw4At4rNVk+0BF9L70CZG3ErgOC00gpsFwMvusAllveTJtuVuQUXsvic4
	 GTz0RD3wCqyaw==
Date: Thu, 13 Nov 2025 19:57:25 +0000
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
Subject: Re: [PATCH 04/13] dt-bindings: power: supply: document Samsung S2M
 series PMIC charger device
Message-ID: <20251113-evaluate-unrented-0f87915a5297@spud>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
 <20251114-s2mu005-pmic-v1-4-9e3184d3a0c9@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u7n4qZJf1FleTFjE"
Content-Disposition: inline
In-Reply-To: <20251114-s2mu005-pmic-v1-4-9e3184d3a0c9@disroot.org>


--u7n4qZJf1FleTFjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:35:05AM +0530, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a battery charger device which,
> among other things, manages power interfacing of the USB port. It may
> supply power, as done in USB OTG operation mode, or it may accept power
> and redirect it to the battery fuelgauge for charging.
>=20
> This driver depends on the MUIC device present in the same PMIC block.
>=20
> The initial driver introduced has support for S2MU005, add its
> compatible as well.

Similar comments in all these binding commit messages, they should only
really contain mentions of "drivers" if you are talking about electrical
circuitry.

>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../power/supply/samsung,s2mu005-charger.yaml      | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu0=
05-charger.yaml b/Documentation/devicetree/bindings/power/supply/samsung,s2=
mu005-charger.yaml
> new file mode 100644
> index 000000000000..80292d6e2562
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-char=
ger.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/samsung,s2mu005-charger.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery Charger Driver for Samsung S2M series PMICs
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +description: |
> +  The Samsung S2M series PMIC battery charger manages power interfacing
> +  of the USB port. It may supply power, as done in USB OTG operation
> +  mode, or it may accept power and redirect it to the battery fuelgauge
> +  for charging.
> +
> +  This is a part of device tree bindings for S2M and S5M family of Power
> +  Management IC (PMIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
> +  additional information and example.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-charger

Why do you need a dedicated child node for this? It's got one property,
other than the compatible, that you're using. It could easily just go
in the parent without a dedicated node etc.

> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
>=20
> --=20
> 2.51.2
>=20

--u7n4qZJf1FleTFjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRY4JQAKCRB4tDGHoIJi
0lucAQDyRCAA4SjDFvfubCoPl93IXeeEYtZ1Fr/ARmnLeDMbBwEArFFq5IqPWdLd
1boZpaq0faA9nEz/5hWtAica4B7b8wY=
=GYZh
-----END PGP SIGNATURE-----

--u7n4qZJf1FleTFjE--

