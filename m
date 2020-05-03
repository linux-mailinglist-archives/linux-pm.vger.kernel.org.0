Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082DA1C293D
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgECAki (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 20:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726570AbgECAki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 20:40:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5A8C061A0C;
        Sat,  2 May 2020 17:40:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E7DA12A0BBA
Received: by earth.universe (Postfix, from userid 1000)
        id EE5E43C08C7; Sun,  3 May 2020 02:40:34 +0200 (CEST)
Date:   Sun, 3 May 2020 02:40:34 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/3] Add the bindings for the bq25150 and bq25155
 500mA charging ICs from Texas Instruments.
Message-ID: <20200503004034.eroc76g2yyeqmtip@earth.universe>
References: <20200501175118.26226-1-dmurphy@ti.com>
 <20200501175118.26226-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jwgmemsqra7osklz"
Content-Disposition: inline
In-Reply-To: <20200501175118.26226-3-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jwgmemsqra7osklz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 12:51:17PM -0500, Dan Murphy wrote:
> From: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>=20
> Description:
> The BQ2515X family of devices are highly integrated battery management
> ICs that integrate the most common functions for wearbale devices
> namely a charger, an output voltage rail, ADC for battery and system
> monitoring, and a push-button controller.
>=20
> Datasheets:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
>=20
> CC: Rob Herring <robh@kernel.org>
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  .../bindings/power/supply/bq2515x.yaml        | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515=
x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml =
b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> new file mode 100644
> index 000000000000..673caf67a993
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated
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
> +  ac_detect-gpios:
> +    description: |
> +       GPIO used for connecting the bq2515x device PG (AC Detect)
> +       pin.  This pin should be used if possible as this is the
> +       recommended way to obtain the charger's input PG state.
> +       If this pin is not specified a software-based approach for PG
> +       detection is used.

No _ in DT properties, please use ac-detect-gpios as I wrote in PATCHv4.

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
> +
> +  constant-charge-current-max-microamp:
> +    description: |
> +       Maximum charging current in micro Amps.
> +    minimum: 50000
> +    maximum: 600000
> +
> +  precharge-current-max-microamp:
> +    description: |
> +       Maximum precharging current in micro Amps.
> +    minimum: 1250
> +    maximum: 77500
> +
> +  input-current-limit-microamp:
> +    description: |
> +       Maximum input current in micro Amps.
> +    minimum: 50000
> +    maximum: 500000
> +
> +  constant-charge-voltage-max-microvolt:
> +    description: |
> +       Maximum charging voltage in micro volts.
> +    minimum: 3600000
> +    maximum: 4600000

The following properties describe battery properties
and should go into a simple-battery node, which is
referenced by the charger. Then you get the properties
in the driver via power_supply_get_battery_info():

constant-charge-current-max-microamp
constant-charge-voltage-max-microvolt
precharge-current-max-microamp

The binding for simple-battery can be found here:

Documentation/devicetree/bindings/power/supply/battery.txt

(still needs to be converted to YAML)

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
> +          ac_detect-gpios =3D <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +          reset-gpios =3D <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +          low-power-gpios =3D <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +          charge-enable-gpios =3D <&gpio0 13 GPIO_ACTIVE_LOW>;
> +          constant-charge-current-max-microamp =3D <300000>;
> +          constant-charge-voltage-max-microvolt =3D <4200000>;
> +	  precharge-current-max-microamp =3D <2500>;
> +	  input-current-limit-microamp =3D <100000>;

bogus indention

> +      };
> +    };

-- Sebastian

--jwgmemsqra7osklz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6uEwIACgkQ2O7X88g7
+poYthAApXLPRZ2KAIty+bU6dXkuWyH6CVmLJw54N5i1RMnagbSSU0b7W3SbuwOi
uW12N9aNh4mRt9W8/F2fbnGYp6iQjJJ3Hfl0xEcg+4PMy7UJkVsVlISXJkdR229r
UeyusIEjPQcVKe4ilf04bmLaeyKuVIwNA5mD1LXBQMSH5JgAjfsNUkFdTl7+2moa
fkP2L2zPukrQfqdP7AvOYkRZHENHwP+TR4h7pZtHnvT5l1epM75MxralnE2YBRht
7DXX5WP15Y1bSTiZ5+1ksBHP7JsOPYaQRw6E7UCJNHOlxDIXBedAqJ1KT0NIKHdS
ToU8HTLlSe4a6qXdxhWc0Aoxq+8/DeO/D8RAFzt60wXdqI181pE1U4rtX0CC4IjP
oUJf2w6ZxnUeV8lAdhsIE3K8+CaTLuUk+KLRg4JHmRRS8i58ze4hRvnLbE/JElVE
PwjHyij1HzR09gMTKTXWCS68awbh5TVLPsxS6OQf4nM69PWN8lKwZny7MFLWG1d1
clAsSIcMwiObqIaiY/Pwu6ozTetPxA1edz3pkLJYYvJ7kwWRGJs3YBmNk2J4gPo2
i+wg6z114fv2QL0P7gYQvOtSC7zglXHbS9j+QuRfgXwFBlTBypXzoMIt1x9/iQYQ
0NLicFRgJW6Rmwh5VnW1WJsj6a+Rt07CJ6BW7zQ9/HQ6Ai5DVmg=
=ZNJM
-----END PGP SIGNATURE-----

--jwgmemsqra7osklz--
