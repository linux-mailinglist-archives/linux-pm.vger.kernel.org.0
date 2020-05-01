Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C71C1B00
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgEAQ6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729161AbgEAQ6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 12:58:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4353C061A0E;
        Fri,  1 May 2020 09:58:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4D3052A2F73
Received: by earth.universe (Postfix, from userid 1000)
        id 78B953C08C7; Fri,  1 May 2020 18:58:29 +0200 (CEST)
Date:   Fri, 1 May 2020 18:58:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: Convert power_supply text to yaml
Message-ID: <20200501165829.2y2soxprt6naemki@earth.universe>
References: <20200430151841.17453-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="55spgyagwzo6onjh"
Content-Disposition: inline
In-Reply-To: <20200430151841.17453-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--55spgyagwzo6onjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 30, 2020 at 10:18:41AM -0500, Dan Murphy wrote:
> Convert the power_supply.txt to power-supply.yaml.
> This conversion entailed fixing up the binding to being yaml and dt
> checker compliant.

Looks mostly good to me, thanks for taking care of it.

> Added a note in the power_supply.txt to reference the power-supply.yaml

Yes, we should keep the file until all bindings referencing the file
have been converted to YAML.

> CC: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/power-supply.yaml   | 40 +++++++++++++++++++
>  .../bindings/power/supply/power_supply.txt    | 25 +-----------
>  2 files changed, 42 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/power-=
supply.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.=
yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> new file mode 100644
> index 000000000000..cfbc79833ed8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/power_supply.yaml#"

This should be power-supply instead of power_supply, which is also
reported by dtb_binding_check on my system :)

> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Power Supply Core Support
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +properties:
> +  power-supplies:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      This property is added to a supply in order to list the devices wh=
ich
> +      supply it power, referenced by their phandles.
> +
> +examples:
> +  - |
> +    power {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      usb_charger:power@e {
> +        compatible =3D "some,usb-charger";
> +        reg =3D <0xe>;
> +      };
> +
> +      ac_charger:power@c {

^^^ while at it, let's also fix this up and use
charger instead of power (for both entries).

> +        compatible =3D "some,ac-charger";
> +        reg =3D <0xc>;
> +      };
> +
> +      battery:battery@b {
> +        compatible =3D "some,battery";
> +        reg =3D <0xb>;
> +        power-supplies =3D <&usb_charger>, <&ac_charger>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/power/supply/power_supply.=
txt b/Documentation/devicetree/bindings/power/supply/power_supply.txt
> index 8391bfa0edac..d9693e054509 100644
> --- a/Documentation/devicetree/bindings/power/supply/power_supply.txt
> +++ b/Documentation/devicetree/bindings/power/supply/power_supply.txt
> @@ -1,23 +1,2 @@
> -Power Supply Core Support
> -
> -Optional Properties:
> - - power-supplies : This property is added to a supply in order to list =
the
> -   devices which supply it power, referenced by their phandles.
> -
> -Example:
> -
> -	usb-charger: power@e {
> -		compatible =3D "some,usb-charger";
> -		...
> -	};
> -
> -	ac-charger: power@c {
> -		compatible =3D "some,ac-charger";
> -		...
> -	};
> -
> -	battery@b {
> -		compatible =3D "some,battery";
> -		...
> -		power-supplies =3D <&usb-charger>, <&ac-charger>;
> -	};
> +This binding has been converted to yaml please see power-supply.yaml in =
this
> +directory.
> --=20
> 2.25.1
>=20

--55spgyagwzo6onjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sVTAACgkQ2O7X88g7
+pqlKg/+Il5cAdRXQRVHI1WT7/ey6SRvhvTcnmqzGwxY8hWP0hlPjJetHXytDRiD
tYeDQHpwxhHaJ4rQz9k9bc0QcZZaMWTC5Y1awpJ+PNMMWKkI1EYrQ2fjeW7D24oh
74gfWACAJNAVIQUsEVlZXyiLNQ5pvx/7xMVVPfkZivfgXpxJ4Tpj/wnoYy5sDefL
o2KO0fuBLM+DWkaa5+SiJyc5DpRh8T0lLJOb4/ZgG8O11lNI3jgUJK9YRllxd2PT
cHeoqzE5ZmCPxV4bBMzyXBnJYnSGGRnB9HoyPpMNU1sBTr6XSCJtAHr5JxXjW6ff
X6kSLB171uFW5oEMOQr5eVMzvs9nm+TyoxShlWVz8DAUlDfX8l7FQOl840b4O34q
e3xUobqoJZ9zcTBAWe5NXd9ZVTIRHWkICW/CnLtzYf8TG3OIxklLty1e9v1f5upl
ekpdBW48LTHCGoWGr2+zaA3TS3U+Z+OzoOj/0dIDcqmmKxCJhsF9eWgZVi4tTJqU
94IdY3MeusxfSHzim7p8UkYCEYZUYvo8IvIPbjBN4beu3/faAAWoYnVCkX7a2h7W
ZsvGCRmCfC5pKUZ7ucBuhqbwfkY0abySsI7Dti1+RzLSx4wJwOuy3nd/GmMBQjzh
y7I4nzq2TL++ljd/TaIqseiyzUq/JpDNyhLAl/f1mn/Xk9MU2Dc=
=oymK
-----END PGP SIGNATURE-----

--55spgyagwzo6onjh--
