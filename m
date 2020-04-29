Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9931BEC12
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 00:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2WbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WbL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 18:31:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE040C03C1AE;
        Wed, 29 Apr 2020 15:31:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A15882A1735
Received: by earth.universe (Postfix, from userid 1000)
        id D74F03C08C6; Thu, 30 Apr 2020 00:31:05 +0200 (CEST)
Date:   Thu, 30 Apr 2020 00:31:05 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add the BQ27561 fuel gauge
 bindings
Message-ID: <20200429223105.2echdvu745d6xbx2@earth.universe>
References: <20200417172227.28075-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xemb2zi3kkbabaoe"
Content-Disposition: inline
In-Reply-To: <20200417172227.28075-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xemb2zi3kkbabaoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 17, 2020 at 12:22:26PM -0500, Dan Murphy wrote:
> Introduce the Texas Instrument BQ27561 and BQ27750 fuel gauge device
> tree bindings.
>=20
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

I think its best to just add them to bq27xxx.txt. Conversion to YAML
would still be nice of course :)

In any case the binding is incomplete, since batteries should contain
a power-supplies node referencing their charger via a phandle, see
power_suppliy.txt (which still needs to be converted to YAML).

-- Sebastian

>  .../bindings/power/supply/bq27561.yaml        | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2756=
1.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27561.yaml =
b/Documentation/devicetree/bindings/power/supply/bq27561.yaml
> new file mode 100644
> index 000000000000..abc9acdbc704
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq27561.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq27561.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI BQ27561 and BQ27750 Fuel Gauges
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  The bq27z561 device provides a feature-rich gas gauging solution for
> +  single-cell battery pack applications.
> +
> +  Specifications about the charger can be found at:
> +    https://www.ti.com/lit/gpn/bq27z561
> +    https://www.ti.com/lit/gpn/bq27750
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq27561
> +      - ti,bq27750
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      I2C address of the device which is 0x55
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
> +      fuel_gauge@55 {
> +        compatible =3D "ti,bq27561";
> +        reg =3D <0x55>;
> +      };
> +    };
> --=20
> 2.25.1
>=20

--xemb2zi3kkbabaoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6qACEACgkQ2O7X88g7
+pr1HRAAlca+wGXkJM5z+VHrMYTiryyjVYigImg4CKkGNmjbo3oCAOPvYoD8RLGq
M27Njfb+pbRzzYf9hXTXO91Y7yiWAWbwFs1xJpazgMeYMTMwrY/HMDUJ5WfRiz2o
/zGb4csNyELJAodiw4t+U28oMrh4PhmbqLJmOxG0qLVecRJI7Bso9la8E/4ih9qY
zS4YLAyokfHyrsFzgpg64mhfXN8qeCL3oPzbk+7cMpQoEV6NbfvDaEFwESGyBgGN
0cdzQJ8s0oOpfPiAecl/dHBUpP3nafBiiiSxxNKR1J8+yDDG1eCa2qCCHXgYNg3e
/jta5p/BR53WnlE0GtunF6XAFp93mx54sbMNnKPr9pjVmgtb60z+1rtihRV8rIHr
txDV6l8SoYTDWAFg9n1wtyZUgd4uD0J3TEkJ47usEdr+tWrVLxtIsDwE2qWXLS84
/Ewa0X+wxUkqh/uMxSXierrwhScu7ksvlpfvIjUsNsFN5FfhUXZw8Q/i2imC6j6V
3P4FVmFTRltfHaTIehVETuJXrNTnw3arZ4jhEC39u9xQO5kUOvFzNxMeEQPT4LST
uvretfXswKEE4iRyDDWuRANJ3Vtg5uyhBGcwBZzhToNrQEVQis8Y9JUMGjJjD4Le
hBORhcSzkrI/nq42yuo4nNyfAJZ7mMft3B012+myNvDm+Sol6LQ=
=6M1m
-----END PGP SIGNATURE-----

--xemb2zi3kkbabaoe--
