Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD9424262
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhJFQRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhJFQRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 12:17:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6016C061746;
        Wed,  6 Oct 2021 09:15:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4FCE31F41572
Received: by earth.universe (Postfix, from userid 1000)
        id F1C4A3C0CA8; Wed,  6 Oct 2021 18:15:48 +0200 (CEST)
Date:   Wed, 6 Oct 2021 18:15:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: add Maxim MAX77976
 battery charger
Message-ID: <20211006161548.ary3mijxlcz6mdob@earth.universe>
References: <20211004130732.950512-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4iiygwy4zl7ebylp"
Content-Disposition: inline
In-Reply-To: <20211004130732.950512-1-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4iiygwy4zl7ebylp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 04, 2021 at 03:07:31PM +0200, Luca Ceresoli wrote:
> Add bindings for the Maxim MAX77976 I2C-controlled battery charger.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../bindings/power/supply/maxim,max77976.yaml | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,=
max77976.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max7797=
6.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
> new file mode 100644
> index 000000000000..b508d9cc04a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max77976.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX77976 Battery charger
> +
> +maintainers:
> +  - Luca Ceresoli <luca@lucaceresoli.net>
> +
> +description: |
> +  The Maxim MAX77976 is a 19Vin / 5.5A, 1-Cell Li+ battery charger
> +  configured via I2C.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77976
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Add

allOf:
  - $ref: power-supply.yaml#

and replace additionalProperties with unevaluatedProperties, so that
the power-supplies property is also valid.

-- Sebastian

> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      charger@6b {
> +        compatible =3D "maxim,max77976";
> +        reg =3D <0x6b>;
> +      };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeb4c70b3d5b..b3a3667cef46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11388,6 +11388,11 @@ F:	Documentation/devicetree/bindings/*/*max77802=
=2Etxt
>  F:	drivers/regulator/max77802-regulator.c
>  F:	include/dt-bindings/*/*max77802.h
> =20
> +MAXIM MAX77976 BATTERY CHARGER
> +M:	Luca Ceresoli <luca@lucaceresoli.net>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
> +
>  MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>  M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> --=20
> 2.25.1
>=20

--4iiygwy4zl7ebylp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFdy68ACgkQ2O7X88g7
+pouRw/+IjIUpy+TiY80hx4winh/LGG8JvLd2epxDCqGClCNw7evULVpiqB8MYMt
+bLLjesjNjVrTSbLgZZrK332F2OtTS+z4hEAQQs3a9qbEoYh/f3vkeT4nvxG7Om0
0A8lYTQgtD85vV/g/2xyKvwE4BtzLLW7HMf9lPcQjnteaOsKeBf3ppLujV7Xu+nd
ytSAc8AGDlI4g3Rw4CQ5GEYDZLOeYuxMRaYzF6uSQFeeXFBnzOlAwiASqwzSXY5+
ngoATAvZcXQHCNrRk7515MZ7TGOHgpROVdo5dSVVtCKYst5JkQGeyTXpUk8y/Yjz
EkDwVZK/XJkb430XS4kmuqo2WpOwD961fmtyJCwlFmmfZFLG4SRF6lI1UbhIn26T
oiGYAINVezGzIO+nMrrGCnCkn5H3xmDRyCmieGD83KSeaeHw8ZEIYexDjg0SgNmq
OZm/V1L2lsAWNuzLl+RSaozfPoSfYlpFYQTPxdbI2ACdtSsIvIf2lyHGnukmTH56
FR9dqwP2TxlB4WZFkmLSygb/Ta8l8GLvJDI1KbeKYZ98pPI9M7ZjH6ZCByFrkYA6
dsjbK1ra304twX5eIUYOpaD8tu4Xpzb/wE7pm6Kbaaqx4oAQljo+Vdsb7UwoTwt6
HhZ3rN7AQc5zHHHf26CI+vpc+XxRWwJi9uAsv5x3YLmo6kI+WLg=
=4+L8
-----END PGP SIGNATURE-----

--4iiygwy4zl7ebylp--
