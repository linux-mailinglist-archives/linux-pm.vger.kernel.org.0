Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D341CCC35
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgEJQR0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 12:17:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40310 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgEJQRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 12:17:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F2C1A2A04D1
Received: by earth.universe (Postfix, from userid 1000)
        id 63E943C08C7; Sun, 10 May 2020 18:17:21 +0200 (CEST)
Date:   Sun, 10 May 2020 18:17:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: Re: [PATCH v2] dt-bindings: power: Convert bq27xxx dt to yaml
Message-ID: <20200510161721.257vprq6rqp64wu5@earth.universe>
References: <20200507183013.27261-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eleyscz72hdifi3z"
Content-Disposition: inline
In-Reply-To: <20200507183013.27261-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--eleyscz72hdifi3z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, May 07, 2020 at 01:30:13PM -0500, Dan Murphy wrote:
> Convert the bq27xxx.txt to yaml format
>=20
> CC: Pali Roh=E1r <pali@kernel.org>
> CC: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

This needs is missing the power-supplies property. The N900 DT
contains a bq27200 referencing the charger, so it should fail the DT
check without the property being listed here.

>  .../bindings/power/supply/bq27xxx.txt         | 56 ------------
>  .../bindings/power/supply/bq27xxx.yaml        | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/bq27xx=
x.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xx=
x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b=
/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> deleted file mode 100644
> index 4fa8e08df2b6..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -TI BQ27XXX fuel gauge family
> -
> -Required properties:
> -- compatible: contains one of the following:
> - * "ti,bq27200" - BQ27200
> - * "ti,bq27210" - BQ27210
> - * "ti,bq27500" - deprecated, use revision specific property below
> - * "ti,bq27510" - deprecated, use revision specific property below
> - * "ti,bq27520" - deprecated, use revision specific property below
> - * "ti,bq27500-1" - BQ27500/1
> - * "ti,bq27510g1" - BQ27510-g1
> - * "ti,bq27510g2" - BQ27510-g2
> - * "ti,bq27510g3" - BQ27510-g3
> - * "ti,bq27520g1" - BQ27520-g1
> - * "ti,bq27520g2" - BQ27520-g2
> - * "ti,bq27520g3" - BQ27520-g3
> - * "ti,bq27520g4" - BQ27520-g4
> - * "ti,bq27521" - BQ27521
> - * "ti,bq27530" - BQ27530
> - * "ti,bq27531" - BQ27531
> - * "ti,bq27541" - BQ27541
> - * "ti,bq27542" - BQ27542
> - * "ti,bq27546" - BQ27546
> - * "ti,bq27742" - BQ27742
> - * "ti,bq27545" - BQ27545
> - * "ti,bq27411" - BQ27411
> - * "ti,bq27421" - BQ27421
> - * "ti,bq27425" - BQ27425
> - * "ti,bq27426" - BQ27426
> - * "ti,bq27441" - BQ27441
> - * "ti,bq27621" - BQ27621
> -- reg: integer, I2C address of the fuel gauge.
> -
> -Optional properties:
> -- monitored-battery: phandle of battery characteristics node
> -    The fuel gauge uses the following battery properties:
> -    + energy-full-design-microwatt-hours
> -    + charge-full-design-microamp-hours
> -    + voltage-min-design-microvolt
> -  Both or neither of the *-full-design-*-hours properties must be set.
> -  See Documentation/devicetree/bindings/power/supply/battery.txt
> -
> -Example:
> -
> -	bat: battery {
> -		compatible =3D "simple-battery";
> -		voltage-min-design-microvolt =3D <3200000>;
> -		energy-full-design-microwatt-hours =3D <5290000>;
> -		charge-full-design-microamp-hours =3D <1430000>;
> -	};
> -
> -	bq27510g3: fuel-gauge@55 {
> -		compatible =3D "ti,bq27510g3";
> -		reg =3D <0x55>;
> -		monitored-battery =3D <&bat>;
> -	};
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml =
b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> new file mode 100644
> index 000000000000..54f497c291f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq27xxx.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI BQ27XXX fuel gauge family
> +
> +maintainers:
> +  - Pali Roh=E1r <pali@kernel.org>
> +  - Andrew F. Davis <afd@ti.com>
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |
> +  Support various Texas Instruments fuel gauge devices that share similar
> +  register maps and power supply properties

allOf:
  - $ref: power-supply.yaml#

> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq27200 - BQ27200
> +      - ti,bq27210 - BQ27210
> +      - ti,bq27500 - deprecated, use revision specific property below
> +      - ti,bq27510 - deprecated, use revision specific property below
> +      - ti,bq27520 - deprecated, use revision specific property below

There is a deprecated property ("deprecated: true"), but IDK how to
apply it to specific compatible values. Maybe Rob can help out here.
Otherwise it's not a blocker, since the conversion is still an
improvement without having explicit deprecation marks :)

> +      - ti,bq27500-1 - BQ27500/1
> +      - ti,bq27510g1 - BQ27510-g1
> +      - ti,bq27510g2 - BQ27510-g2
> +      - ti,bq27510g3 - BQ27510-g3
> +      - ti,bq27520g1 - BQ27520-g1
> +      - ti,bq27520g2 - BQ27520-g2
> +      - ti,bq27520g3 - BQ27520-g3
> +      - ti,bq27520g4 - BQ27520-g4
> +      - ti,bq27521 - BQ27521
> +      - ti,bq27530 - BQ27530
> +      - ti,bq27531 - BQ27531
> +      - ti,bq27541 - BQ27541
> +      - ti,bq27542 - BQ27542
> +      - ti,bq27546 - BQ27546
> +      - ti,bq27742 - BQ27742
> +      - ti,bq27545 - BQ27545
> +      - ti,bq27411 - BQ27411
> +      - ti,bq27421 - BQ27421
> +      - ti,bq27425 - BQ27425
> +      - ti,bq27426 - BQ27426
> +      - ti,bq27441 - BQ27441
> +      - ti,bq27621 - BQ27621
> +
> +  reg:
> +    maxItems: 1
> +    description: integer, I2C address of the fuel gauge.
> +
> +  monitored-battery:
> +    description: |
> +       phandle of battery characteristics node.
> +       The fuel gauge uses the following battery properties:
> +       - energy-full-design-microwatt-hours
> +       - charge-full-design-microamp-hours
> +       - voltage-min-design-microvolt
> +       Both or neither of the *-full-design-*-hours properties must be s=
et.
> +       See Documentation/devicetree/bindings/power/supply/battery.txt

power-supplies: true

> +
> +required:
> +  - compatible
> +  - reg
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      bat: battery {
> +        compatible =3D "simple-battery";
> +        voltage-min-design-microvolt =3D <3200000>;
> +        energy-full-design-microwatt-hours =3D <5290000>;
> +        charge-full-design-microamp-hours =3D <1430000>;
> +      };
> +
> +      bq27510g3: fuel-gauge@55 {
> +        compatible =3D "ti,bq27510g3";
> +        reg =3D <0x55>;
> +        monitored-battery =3D <&bat>;
> +      };
> +    };

Otherwise looks good to me.

-- Sebastian

--eleyscz72hdifi3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64KQsACgkQ2O7X88g7
+pqdzA/5AQ8k1elDdtykmTF+LhZ1lSdxfrzg0iZ97kdNdO8zHnXU+3bUXrUAPKUl
NFL1XFjNQVUvekFOXMb1ZI4wn0gtQN8IHaPG1aexFXHhvmh0pn8fqlQ64nMX1jp0
vo/UkC5RpyqP9sszO5+VUXTS3TUiTKN/A3JeDAqr0jGIFGUZRI/cE3BPkHO9/r3/
nUfFmpPFOH7phlj9TOYzOAqdZlqg93Bu8CLBNJnBpykqhAyirSBX2ELaN3ytAUYd
bYamQmRMzC3MCN554MaeX6et1FGH+3X8XjamV81jlax3sllE/+jVhG9JMZb4IGrw
BB7fCJCYmF5rYzEK0CG1ttmZSu0JboYYVYKpxem6xBS2MwSNX3n8heXYhfA/sw/T
mt3VaJyB7rzyu52yhq8fKcaUx83B6hs4sFzzaO4BIIdydqSobMQ2/Iyc+qE1sjj+
flj4hbXaksv+P7ncBv9Jny5mKQPfIxgoyyVbRcWZvX5NPIuQVpldkC0LxmDiDKWr
aTZBLIAT34LAtSRMrtI+o+tyErypYngRR4uER2QDGKcPRtuNYyDH/ANRSNg6Efsy
LSBkAMI8x9KVUaAGXvJ6KMoeIV5VVUg4UuqN36Rd65cnbnoYBBuZF9SBRMHFh20u
XmmtbTo3rTToAU3JGhxZUMC/npcMgjS5QW+IALr1jH8+c8icTDc=
=VmQV
-----END PGP SIGNATURE-----

--eleyscz72hdifi3z--
