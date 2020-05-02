Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080411C2893
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 00:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgEBWZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 18:25:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgEBWZm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 18:25:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5BC3D26127B
Received: by earth.universe (Postfix, from userid 1000)
        id 512973C08C7; Sun,  3 May 2020 00:25:38 +0200 (CEST)
Date:   Sun, 3 May 2020 00:25:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: power: Convert power_supply text to yaml
Message-ID: <20200502222538.4picedksvh5pvvnr@earth.universe>
References: <20200501172913.23537-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g67rzxqxnnbyq5ce"
Content-Disposition: inline
In-Reply-To: <20200501172913.23537-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--g67rzxqxnnbyq5ce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 12:29:13PM -0500, Dan Murphy wrote:
> Convert the power_supply.txt to power-supply.yaml.
> This conversion entailed fixing up the binding to being yaml and dt
> checker compliant.
>=20
> Added a note in the power_supply.txt to reference the power-supply.yaml
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  .../bindings/power/supply/power-supply.yaml   | 40 +++++++++++++++++++
>  .../bindings/power/supply/power_supply.txt    | 25 +-----------
>  2 files changed, 42 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/power-=
supply.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.=
yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> new file mode 100644
> index 000000000000..3bb02bb3a2d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/power-supply.yaml#"
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
> +      usb_charger:charger@e {
> +        compatible =3D "some,usb-charger";
> +        reg =3D <0xe>;
> +      };
> +
> +      ac_charger:charger@c {
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

--g67rzxqxnnbyq5ce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6t82IACgkQ2O7X88g7
+poYNg//bzYxRkCjCt7ev8FZ3vQSMwknF0RzNN1TzDYgzIGo0OVAVY5qrQs5ZoW0
OGn1QNdnGknhIVFio2RrqDhcVzC3icY4KiBjT8t8m6TE9uR0hLmUreFOjYMGs1/2
RJBpt//tcABEsKEKDJClR6MC0r/2mrhbWh7OTghkFBOO28udl0Nz9KIDRtIyUIVP
E435QPs1OKGEJGqPOeDiKHyhbBk/Hwo2xrpsJl81pl9nl4YmvrZqkJYAyvzgBjFk
1UoFZYRqwvIZDgc25cKJeQotIoit5Q3edPVlFgdqd9VScgCVFFHWCTDnGcvWuHJA
3aw9HaNLDnTGmP0/pKwoNIZ3PJsM4rRUnwKsI8p+8ERlw/HvYaqP7t7u3snC5Bmo
mzqlfEcjk9DL4eqmrdtIHqsImGO2yD41qAksZZG/gZ88IK3pVzjsMKhZfSEoTa0O
5pa38ohIkIMlo3LSWfjBI803JDbElMnq/dpVUFQ7JyHhFLawc1iQS2Y6WdhhV8im
sdzAxik8FOw204d6V7Ijy7EReIH+aAajba9BPHgXtYmxm44tjgq7eHBXb0xRCvQW
gLhc+fSMVsiifx92gM/xrvamAs+GEEW7nDAXsG4GLDWn8Fc+Bxd5CRHmnEoIeMqM
J9vNQUkXj9OHV/Xa1hGDT3mF7DjX4lNoG9tKOjC2lWPLhS2KrEE=
=RCwM
-----END PGP SIGNATURE-----

--g67rzxqxnnbyq5ce--
