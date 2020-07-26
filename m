Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575C822E2B1
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jul 2020 23:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgGZVLH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jul 2020 17:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgGZVLH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Jul 2020 17:11:07 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03552065C;
        Sun, 26 Jul 2020 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595797866;
        bh=KiVubal74AV8jhtlRHoRy6J5S1SLY5rer2hyCC5ooKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bY1WRoM7Ehpn4XSH1kenSZhry5ttrRIASIBaok8KHF3Y18uGqmBe/+1pGqCmyzsuZ
         uX/GSUJ4erLAUwatOXUQ4KFGkvyP2NUJ0qjlKITII+9v8tf8178yF5PE0HcJVRFTRc
         X5DnbYV19qbOG46F6pAotAyfyQ2SWHUVQh/pI+Cc=
Received: by earth.universe (Postfix, from userid 1000)
        id A4FF23C0B87; Sun, 26 Jul 2020 23:11:03 +0200 (CEST)
Date:   Sun, 26 Jul 2020 23:11:03 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: Convert ingenic,battery.txt to YAML
Message-ID: <20200726211103.gt735j6365vqrqmt@earth.universe>
References: <20200726125605.7009-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fshinpkyzrtxwpbz"
Content-Disposition: inline
In-Reply-To: <20200726125605.7009-1-contact@artur-rojek.eu>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fshinpkyzrtxwpbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 26, 2020 at 02:56:05PM +0200, Artur Rojek wrote:
> Convert the textual documentation of Device Tree bindings for the
> Ingenic JZ47xx SoCs battery to YAML.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  .../bindings/power/supply/ingenic,battery.txt | 31 ---------
>  .../power/supply/ingenic,battery.yaml         | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 31 deletions(-)
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
> index 000000000000..8d36216f6c0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> @@ -0,0 +1,67 @@
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
> +    oneOf:
> +      - enum:
> +        - ingenic,jz4740-battery

Can be simplified to:

- const: ingenic,jz4740-battery

> +      - items:
> +        - enum:
> +          - ingenic,jz4725b-battery
> +          - ingenic,jz4770-battery
> +        - const: ingenic,jz4740-battery

The patch introduces new compatible values without any mention in
the patch description. Please move this into a second patch.

> +
> +  io-channels:
> +    items:
> +      - description: >
> +          phandle and IIO specifier pair to the IIO device.
> +          See Documentation/devicetree/bindings/iio/iio-bindings.txt for=
 more
> +          details.
> +
> +  io-channel-names:
> +    const: "battery"
> +
> +  monitored-battery:
> +    items:
> +      - description: >
> +          phandle to a "simple-battery" compatible node.
> +
> +          This property must be a phandle to a node using the format des=
cribed
> +          in battery.txt, with the following properties being required:
> +          - voltage-min-design-microvolt: drained battery voltage,
> +          - voltage-max-design-microvolt: fully charged battery voltage.
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

Otherwise LGTM.

-- Sebastian

--fshinpkyzrtxwpbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8d8WQACgkQ2O7X88g7
+pq5rw//f36kz5rMPK/yVuL0cNKdLXzMLH4x8HrunW2UoyJl3WlHGGN2YP2fPl+N
TL1Rwre1dmUDQkTPhaaEqj39bff8fkGHHuyWPW3qTFprwL8zuUrTU06VCzlKSc6p
SwZWZ5sagmiBKDtSec6SiiO7F19UW5Jers+iiwA1aOcQIG+15M7dWAcdu2G6pzaJ
2vHzxzCQlL08gL+IgVYYSF9HattEv9BnYljwWjVHF+48kP/G6/bT3tL7YHyY3DNZ
0OmXU0IKmkZ7Q+ETQkfxeOjZ8PpbEWK58G5Dfv5t0iwIFLbpUKFTjVFmfrfmzdAT
gZs9d2uWp1vCr6iQlOk5udxNWVEdRcAoPoMDtZg8g0zYR+ticKU6v028oOGnyPpr
pMivGSHfo+7DFqMH5UBbibg6I5eXFKzQ9B0L2cDsEIZUwLRiGmko3eVF0qJAsoK8
5x/4qU/Vz7XkZyma3KvrcDAmIB3HV1+HQv3GGEi76YG41mR82qbJ3EDejonXdKCM
qXjhOg8SWxSJFVC7hZvGvndwXQxKe8PjU5zfkhO3nfCY25fkdE6qqewBqdQwxo6D
6PPyHtjQ8gZ9k4gjTp1Rn1LH0x1LO8IFgLRq8oTkUDxQVJ3DUHausHlBpLjBycp1
hJYClVa/tUYs2ppUmFpp7Wue/jcYSLqPu6dzyuFCe546VpSTeGc=
=pmiS
-----END PGP SIGNATURE-----

--fshinpkyzrtxwpbz--
