Return-Path: <linux-pm+bounces-37992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A2C59DBE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1CEB3488A0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173FC3161A7;
	Thu, 13 Nov 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkNaukk3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB32FC881;
	Thu, 13 Nov 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063637; cv=none; b=AaiUSptmfC64cJnL1HvnmSBj/2DFW1KO7gSbvInSDgGk/wmbvM5OTTapTT2PuB6SqnOB75nDSYhvS2awMOTguIYJh+8pLfJj5xqHLKODZ1lOz0jsUJmDjazd2RFf8UxTk1wCI/Osv1qXzXYQsPHT5KE4Ht3MTzwCCJULO0KpkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063637; c=relaxed/simple;
	bh=ZKJbLBa0fy5L++3eLehWmmy0nrt64NDQIpOco3SAK+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvJhaQugpCTG9BKEjmMd8DCLq9T/w79ZKnN+QQVRqQRHYzDT+uGOWGwgHrT3ek6BZtdqcXMr2RAKVET2H2g90PCspaGWH30JVRl4vqFsYOYHzQniOiefBtlVq0u+T7H341mjyI1dHK00dgxPTCf5PuDKyNoMj705jpmN8+kZ+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkNaukk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E4BC4CEF7;
	Thu, 13 Nov 2025 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063636;
	bh=ZKJbLBa0fy5L++3eLehWmmy0nrt64NDQIpOco3SAK+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkNaukk39QBebiHy439y0q5dIw1iaKCIUkF1979D1Owm+yO4/tZnGa5JV6gZZA4kH
	 z0qiDz5Ff2yVR6+mJqLLKxZyvIFk9a9Tza8/L0HntUrKlSN8XPD4WlgkAGBmfJVeq2
	 8gwrS8eFPwb44s+Rk7DN0w5hktJ/ow1omLymcvKf9A2H/uVWQZp+uniBUBHWjtXBf7
	 RB+18WWuBFybBRPBUci6BKy5A4RUdJ2HpYXtjsFV1CiGEZk0MaMkl+1uMJe6kOA+Gj
	 W8oStvSL0GFIV/mj5C/7w9rolBUcvwN3Zcm1asF7WZg+iw03QgYdjqpeozEJacD1qL
	 zYg41/z96SmSA==
Date: Thu, 13 Nov 2025 19:53:51 +0000
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
Subject: Re: [PATCH 02/13] dt-bindings: leds: document Samsung S2M series
 PMIC RGB LED device
Message-ID: <20251113-predefine-reprogram-6ac518ae3c01@spud>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
 <20251114-s2mu005-pmic-v1-2-9e3184d3a0c9@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLQIDdi531A5rD9h"
Content-Disposition: inline
In-Reply-To: <20251114-s2mu005-pmic-v1-2-9e3184d3a0c9@disroot.org>


--SLQIDdi531A5rD9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:35:03AM +0530, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a three-channel LED device with
> independent brightness control for each channel, typically used as
> status indicators in mobile phones. Document the devicetree schema from
> this driver.
>=20
> The initial driver introduced has support for S2MU005, add its
> compatible as well.

Same here.
Additionally "Document the ... from this driver" should lose the driver
part, unless you mean it as "led driver" rather than "linux driver".
pw-bot: changes-requested


>=20
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../bindings/leds/samsung,s2mu005-rgb.yaml         | 34 ++++++++++++++++=
++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.y=
aml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
> new file mode 100644
> index 000000000000..bad7080ff8f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/samsung,s2mu005-rgb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RGB LED Driver for Samsung S2M series PMICs
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +description: |
> +  The Samsung S2M series PMIC RGB LED is a three-channel LED device with
> +  8-bit brightness control for each channel, typically used as status
> +  indicators in mobile phones.
> +
> +  This is a part of device tree bindings for S2M and S5M family of Power
> +  Management IC (PMIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
> +  additional information and example.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-rgb
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
>=20
> --=20
> 2.51.2
>=20

--SLQIDdi531A5rD9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRY3TgAKCRB4tDGHoIJi
0ttSAQCrTnorYl4zjYckb6wIib40vGfB8jpqrPfkPj0b9WYNOAD/Wm0MR2BOYqu8
tUWoOQo3rw843YlaMf3HXmiNSnyo1AA=
=Lphx
-----END PGP SIGNATURE-----

--SLQIDdi531A5rD9h--

