Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42B27DC92
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 01:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgI2XSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 19:18:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39316 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgI2XSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 19:18:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CE30B29B618
Received: by earth.universe (Postfix, from userid 1000)
        id 542CF3C0C84; Wed, 30 Sep 2020 01:18:10 +0200 (CEST)
Date:   Wed, 30 Sep 2020 01:18:10 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Convert ingenic,battery.txt
 to YAML
Message-ID: <20200929231810.45xelfcbmpiki43m@earth.universe>
References: <20200926173529.25238-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qucfqa5lmpftt55s"
Content-Disposition: inline
In-Reply-To: <20200926173529.25238-1-contact@artur-rojek.eu>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qucfqa5lmpftt55s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 26, 2020 at 07:35:28PM +0200, Artur Rojek wrote:
> Convert the textual documentation of Device Tree bindings for the
> Ingenic JZ47xx SoCs battery to YAML.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---

Thanks, queued (both patches).

-- Sebastian

>=20
> Changes:
>     v2: move introduction of new compatibles into a separate patch
>    =20
>     v3: - drop description of `io-channels` property and set its maxItems,
>         - remove redundant quotes in `io-channel-names` property,
>         - drop `items` for `monitored-battery` property
>=20
>  .../bindings/power/supply/ingenic,battery.txt | 31 -----------
>  .../power/supply/ingenic,battery.yaml         | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/ingeni=
c,battery.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ingeni=
c,battery.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,batte=
ry.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> deleted file mode 100644
> index 66430bf73815..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* Ingenic JZ47xx battery bindings
> -
> -Required properties:
> -
> -- compatible: Must be "ingenic,jz4740-battery".
> -- io-channels: phandle and IIO specifier pair to the IIO device.
> -  Format described in iio-bindings.txt.
> -- monitored-battery: phandle to a "simple-battery" compatible node.
> -
> -The "monitored-battery" property must be a phandle to a node using the f=
ormat
> -described in battery.txt, with the following properties being required:
> -
> -- voltage-min-design-microvolt: Drained battery voltage.
> -- voltage-max-design-microvolt: Fully charged battery voltage.
> -
> -Example:
> -
> -#include <dt-bindings/iio/adc/ingenic,adc.h>
> -
> -simple_battery: battery {
> -	compatible =3D "simple-battery";
> -	voltage-min-design-microvolt =3D <3600000>;
> -	voltage-max-design-microvolt =3D <4200000>;
> -};
> -
> -ingenic_battery {
> -	compatible =3D "ingenic,jz4740-battery";
> -	io-channels =3D <&adc INGENIC_ADC_BATTERY>;
> -	io-channel-names =3D "battery";
> -	monitored-battery =3D <&simple_battery>;
> -};
> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,batte=
ry.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.ya=
ml
> new file mode 100644
> index 000000000000..658ef92a5b82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019-2020 Artur Rojek
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/ingenic,battery.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Ingenic JZ47xx battery bindings
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +
> +properties:
> +  compatible:
> +    const: ingenic,jz4740-battery
> +
> +  io-channels:
> +    maxItems: 1
> +
> +  io-channel-names:
> +    const: battery
> +
> +  monitored-battery:
> +    description: >
> +      phandle to a "simple-battery" compatible node.
> +
> +      This property must be a phandle to a node using the format describ=
ed
> +      in battery.txt, with the following properties being required:
> +      - voltage-min-design-microvolt: drained battery voltage,
> +      - voltage-max-design-microvolt: fully charged battery voltage.
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - io-channel-names
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/ingenic,adc.h>
> +
> +    simple_battery: battery {
> +            compatible =3D "simple-battery";
> +            voltage-min-design-microvolt =3D <3600000>;
> +            voltage-max-design-microvolt =3D <4200000>;
> +    };
> +
> +    ingenic-battery {
> +            compatible =3D "ingenic,jz4740-battery";
> +            io-channels =3D <&adc INGENIC_ADC_BATTERY>;
> +            io-channel-names =3D "battery";
> +            monitored-battery =3D <&simple_battery>;
> +    };
> --=20
> 2.28.0
>=20

--qucfqa5lmpftt55s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9zwLIACgkQ2O7X88g7
+pqk/Q/+KCh6SFEdbkKjQgoKF8aPgz/GGCv0WkklZ+mhjjGiCh7Nj2JSRGmk8f2V
lKBXcRWYARB+A8GRiDjLol1GNhbmUqAqV6v4D9lgynol1db3IgdtX9FUykwClFnA
5yVuAbSUQ/VuXZ8IgrFydJmJuNY2kHhEPk42v+i99w0Beoy9h0KBbnj3OTwpL+DV
sOYZdauKVTreWX+nhGWxC4yFbP/ObeztvLdLpd0UBbS6aRK5RN84PwKC6PALT+mf
y2fc7+6mezTo8WSjYXQpqlBlY3oiwjZgLy460B7p7hPdGA7F0vX84awl1ylup+Mk
lIA4ORHhaES9vsh2+6of3g1lLAALjIry+8vdec+cn9hmhHMHbXZI/MUhwlqbeJxR
y17zV2BdNjxUkXWAEgpeWlIJ/gnuvfniJBdu0s0XcOaPJf5svtbD2UfU6QdKAKt9
FCoVzJeFKz5MFePzgupGv5nmH7zwl6ocWU7BQOpRJ/Z3FJasRJPkU9uB8Z/PUG3t
mlzibx5tI0jhtNxD7pJJ3QwcChOCbZgJQwrhq8cUxrP9vZKqlyI7JNQY9ONqIQ6D
9JZpc8VxbvwnFEi9TGyqRKaMm778P9iFxE/QZL24gB7nN2P3AIWPJ0Xqyuh6aQZJ
K3V5n6Bhm39D1jzXQC6DoFwK0pExsKaoCCRwUhCec9OERAEt1b0=
=ZNlL
-----END PGP SIGNATURE-----

--qucfqa5lmpftt55s--
