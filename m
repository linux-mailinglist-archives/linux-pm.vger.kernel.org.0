Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8D81267EB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfLSRWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 12:22:30 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49590 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLSRWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 12:22:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 33E7228E9F9
Received: by earth.universe (Postfix, from userid 1000)
        id EEF183C0C7B; Thu, 19 Dec 2019 18:22:25 +0100 (CET)
Date:   Thu, 19 Dec 2019 18:22:25 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add the bq2515x family dt
 bindings
Message-ID: <20191219172225.7euto3vschdisyzo@earth.universe>
References: <20191029200201.24483-1-dmurphy@ti.com>
 <20191029200201.24483-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qlxjxuzmhifdjwwc"
Content-Disposition: inline
In-Reply-To: <20191029200201.24483-2-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qlxjxuzmhifdjwwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 29, 2019 at 03:02:00PM -0500, Dan Murphy wrote:
> Add the bindings for the bq25150 and bq25155 500mA
> charging ICs from Texas Instruments.
>=20
> Datasheet:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Rob Herring <robh@kernel.org>
> ---
>=20
> v2 - Converted to yaml format and removed ti,* properties for already def=
ined
> properties
>=20
>  .../bindings/power/supply/bq2515x.yaml        | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515=
x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml =
b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> new file mode 100644
> index 000000000000..4e6225056f45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2019 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq2515x.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI bq2515x 500-mA Linear charger family
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  The BQ2515x family is a highly integrated battery charge management IC=
 that
> +  integrates the most common functions for wearable devices, namely a ch=
arger,
> +  an output voltage rail, ADC for battery and system monitoring, and
> +  push-button controller.
> +
> +  Specifications about the charger can be found at:
> +    http://www.ti.com/lit/ds/symlink/bq25150.pdf
> +    http://www.ti.com/lit/ds/symlink/bq25155.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq25150
> +      - ti,bq25155
> +
> +  reg:
> +    maxItems: 1
> +
> +  pg-gpios:
> +    description: |
> +       GPIO used for connecting the bq2515x device PG (Power Good)
> +       pin.  This pin should be used if possible as this is the
> +       recommended way to obtain the charger's input PG state.
> +       If this pin is not specified a software-based approach for PG
> +       detection is used.
> +
> +  reset-gpios:
> +    description: |
> +       GPIO used for hardware reset.
> +
> +  low-power-gpios:
> +    description: |
> +       GPIO used for low power mode of IC.
> +
> +  charge-enable-gpios:
> +    description: |
> +       GPIO used to turn on and off charging.

Above looks ok to me.

> +  constant-charge-current-max-microamp:
> +    description: |
> +       Maximum charging current in micro Amps.
> +    minimum: 50000
> +    maximum: 600000
> +
> +  voltage-max-design-microvolt:
> +    description: |
> +       Maximum charging voltage in micro volts.
> +    minimum: 3600000
> +    maximum: 4600000

These two should use the simple-battery binding, as seen in
Documentation/devicetree/bindings/power/supply/battery.txt

-- Sebastian

> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c0 {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      charger@6b {
> +          compatible =3D "ti,bq25150";
> +          reg =3D <0x6b>;
> +
> +          pg-gpios =3D <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +          reset-gpios =3D <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +          low-power-gpios =3D <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +          charge-enable-gpios =3D <&gpio0 13 GPIO_ACTIVE_LOW>;
> +          constant-charge-current-max-microamp =3D <300000>;
> +          voltage-max-design-microvolt =3D <4200000>;
> +      };
> +    };
> --=20
> 2.22.0.214.g8dca754b1e
>=20

--qlxjxuzmhifdjwwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl37sdEACgkQ2O7X88g7
+pphvw//R58CcnL63L2y7BnPANjwO1EqYpxXouuxE78m1FqZs+NUvlptobyl0DBy
BuZPO3WRCHsstFTDyePyeLbaXl739olOJh+HE5aD6lDdK3TqhFbAslFAS8+w6ubZ
n5B5B6NT2PAPayEQ75O8Gj8MZr8ERoaaEfIjFkVWzfPVEiYS4ZDBq7YPeeZIJX3u
2+kF6kV+ly51KZR2e6pl2UMg9NPnBgo6nBqgIaUTWwP+diVVSaWFFp8I1iuzmPqD
tw3jHrt4yqoB9NgGOwYQU5fT2GmB1Tnqr1Z7q/zf2tWkPPbbNIZeLyNsHUgaqwU3
HKULLv1Aa4IUC69wSfNFUBe23MgRpV4y8upCFDs0WHtIENgDzyh7jIuVacnVgLZS
PfLqEC4fNDB//qgK+I4HgdudVOlJ4KCKmeg20GFH7TGD5XGchPYwFc59DfSO1enq
R8s1SdgJT9ZiHSqZp0HD2A5ooMUHBFQ5hcO1muZnYjcx+aKqEcgs5GUq6vrLEihf
9n6O3uruZnMXQYk9IVPHbjz5deCFXevQq8Exr7nMu6737kR7GQcpXE+vHy98v1Xj
BMgSRwPQ4QCi3M11AW5AtfOWOqDvJ8CqTk5YQ9o0phQ3Hebal+tpeX5EN29jVJ5c
aYFv1pQLrNPr9iMPQpFmLhXpFQphWzNhK+u9qUVdbz4H1J2cfcI=
=iONg
-----END PGP SIGNATURE-----

--qlxjxuzmhifdjwwc--
