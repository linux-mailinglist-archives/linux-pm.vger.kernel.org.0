Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DFD800A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfJOTUf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 15:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389382AbfJOTSl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:41 -0400
Received: from earth.universe (eth-west-pareq2-46-193-2-41.wb.wifirst.net [46.193.2.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2499920854;
        Tue, 15 Oct 2019 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571167120;
        bh=3VW3nI+C8AV/pn0tLd1hom0tfVBcQeY8vKH6rm2SlyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnX5nhBNBOkPiickEeDv73BH7AJSwxU5DzeCYKhyqo7HLp58cTBbHcyuedxGTRfFF
         zjCBGym+BMmC5jH49x3l6nmZBIFC/CrGynmKu2dwMe3Y9i7a5z74TeTWFqjlCEtje9
         f/NIODiCutdaXX7nobHbAj9HeMAsy3cllhSk7WYY=
Received: by earth.universe (Postfix, from userid 1000)
        id 9C91E3C0CA1; Tue, 15 Oct 2019 21:18:37 +0200 (CEST)
Date:   Tue, 15 Oct 2019 21:18:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: power: max77650: convert the binding
 document to yaml
Message-ID: <20191015191837.jd6lbk3qbsmzuwfu@earth.universe>
References: <20191015162300.22024-1-brgl@bgdev.pl>
 <20191015162300.22024-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qh5r3wj6smdvdc4t"
Content-Disposition: inline
In-Reply-To: <20191015162300.22024-5-brgl@bgdev.pl>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qh5r3wj6smdvdc4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2019 at 06:22:58PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Convert the binding document for MAX77650 charger module to YAML.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Looks sensible to me. Assuming this goes through Rob:

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  .../power/supply/max77650-charger.txt         | 29 +------------
>  .../power/supply/max77650-charger.yaml        | 42 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max776=
50-charger.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> index e6d0fb6ff94e..fbab7d3ac8e3 100644
> --- a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> @@ -1,28 +1 @@
> -Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> -
> -This module is part of the MAX77650 MFD device. For more details
> -see Documentation/devicetree/bindings/mfd/max77650.txt.
> -
> -The charger is represented as a sub-node of the PMIC node on the device =
tree.
> -
> -Required properties:
> ---------------------
> -- compatible:		Must be "maxim,max77650-charger"
> -
> -Optional properties:
> ---------------------
> -- input-voltage-min-microvolt:	Minimum CHGIN regulation voltage. Must be=
 one
> -				of: 4000000, 4100000, 4200000, 4300000,
> -				4400000, 4500000, 4600000, 4700000.
> -- input-current-limit-microamp:	CHGIN input current limit (in microamps)=
=2E Must
> -				be one of: 95000, 190000, 285000, 380000,
> -				475000.
> -
> -Example:
> ---------
> -
> -	charger {
> -		compatible =3D "maxim,max77650-charger";
> -		input-voltage-min-microvolt =3D <4200000>;
> -		input-current-limit-microamp =3D <285000>;
> -	};
> +This file was moved to max77650-charger.yaml.
> diff --git a/Documentation/devicetree/bindings/power/supply/max77650-char=
ger.yaml b/Documentation/devicetree/bindings/power/supply/max77650-charger.=
yaml
> new file mode 100644
> index 000000000000..9dd0dad0f948
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/max77650-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> +
> +maintainers:
> +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +
> +description: |
> +  This module is part of the MAX77650 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +  The charger is represented as a sub-node of the PMIC node on the devic=
e tree.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77650-charger
> +
> +  input-voltage-min-microvolt:
> +    description:
> +      Minimum CHGIN regulation voltage.
> +    enum: [ 4000000, 4100000, 4200000, 4300000,
> +            4400000, 4500000, 4600000, 4700000 ]
> +
> +  input-current-limit-microamp:
> +    description:
> +      CHGIN input current limit (in microamps).
> +    enum: [ 95000, 190000, 285000, 380000, 475000 ]
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    charger {
> +        compatible =3D "maxim,max77650-charger";
> +        input-voltage-min-microvolt =3D <4200000>;
> +        input-current-limit-microamp =3D <285000>;
> +    };
> --=20
> 2.23.0
>=20

--qh5r3wj6smdvdc4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2mG4QACgkQ2O7X88g7
+pr7Tg/+IMEVM9QSOBaEnCwYZYyzGFLriJJdzib9Cy6UMd80ujaTVa/BRf95ctlx
SWLlkmQd8I6BsF9CxMulgyhatN0GA+/C0Q2Dr8eSvvWtDtQu5DY6W0LjKQzXr/W5
UVM1OzqO9FDQsF7x0jaLfgTt+0AOdtiDBz+kKO2SnAytJkqjtlxj4vLAI9Gl9u6z
dlaTeMxs7eO0qir3L47jLBbtsnoXuKq5QmWn2SI+j/D//tmlVPqodLbNPKqKpcV0
hNgmRdBCMSYTXFGEV9d6jgkZ17QaXU8dGumr2w8DIeLDKj3blCU7gEIw1wiIdnkG
c1SX+Kzw+Q8ejaD4tn0vxYrHl0G+H6x/vR948BZvlgH6eO/5iMaf8dRyp7BsqItV
xE8Ii9ZepDr5Ny0a7UjKXXelujrAHdnaEWnV4AXGiPcatePsdYElz0PI4e99JLLa
TWrtDsvmlFRDlMmcmGd+JJ5waj/RSaHg8fA+A4BDUBGkzQQFIrg6pFouvj81N/4v
8mcFQ+S1X0kqQSXQnsvWlIl5XGO+0oThjlBOKoy2Sla+q5G37DvIqUE3FOJAOiUk
Vk1RRM6PkM1dObjiYHaAzVK+qZBkWsIYLSa5FcS93efcTKHumN0HueGYTb/8zG0J
2PiUCu20PdEbRYgrsRMaa/b2YusDP+ZPssYgqKJR7aN5fH0lpnU=
=m1Mo
-----END PGP SIGNATURE-----

--qh5r3wj6smdvdc4t--
