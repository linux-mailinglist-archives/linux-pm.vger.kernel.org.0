Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA6140149
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 02:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgAQBF1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 20:05:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34340 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAQBF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 20:05:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5350129330B
Received: by earth.universe (Postfix, from userid 1000)
        id E8D7A3C0C7E; Fri, 17 Jan 2020 02:05:22 +0100 (CET)
Date:   Fri, 17 Jan 2020 02:05:22 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: power: Add the bq2515x family dt
 bindings
Message-ID: <20200117010522.giiz42csswgyc472@earth.universe>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cetc77rkog4fj2n6"
Content-Disposition: inline
In-Reply-To: <20200116175039.1317-4-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cetc77rkog4fj2n6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 16, 2020 at 11:50:38AM -0600, Dan Murphy wrote:
> Add the bindings for the bq25150 and bq25155 500mA
> charging ICs from Texas Instruments.
>=20
> Datasheet:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/bq2515x.yaml        | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515=
x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml =
b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> new file mode 100644
> index 000000000000..670952021e8d
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

Let's name this "ac-detect-gpios", which is easy to understand
an generic enough for all chargers.

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
> +  constant-charge-voltage-max-microvolt:
> +    description: |
> +       Maximum charging voltage in micro volts.
> +    minimum: 3600000
> +    maximum: 4600000

The above two are properties, that are coming from the battery.
Please use the simple-battery binding as described in this
file: Documentation/devicetree/bindings/power/supply/battery.txt

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
> 2.25.0
>=20

--cetc77rkog4fj2n6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4hCFIACgkQ2O7X88g7
+pp05RAAjpWounywSeXfEg3EJg9d3eafJJ5Z59FAPerwuy5mdRRUJrhpptTa7Sd2
HTspJ6Ap5Ol3mGC14bxhN/bR7UTqeD0rDtmfDLJOY4naKt2X5i+PZLysSXlUP4YM
lWmRqjFMPc3QvKDnf6MrlveROmGLG315bMTW1HCMRIG4LKlA/FFGD4m3gOLHv8UC
ORhV3sl0kR7V7Jr4/YTeiEhNhU9VKKprjfCAur/D/XmhxL/3sr+uT133S+9b9thF
vzizMxvITyvNORid3NmKGy7JZtaeuPVc6JPDLQV4zdNFLN//+esQAdfrKdiBS7S/
5OBS0djyRb9Iv019VSc8MQW9IDqNJWEyTX//iornIcQ3QAaabQwNtETFITi/UIB6
bODom4aOsCqbk6R3xFFHlQzTEsMnrwzmFke/HM2cPDNJrNaL7VK4jrER3dhti2Ne
RO0VmNyLA8o52Ub1UlGI+MaecL5sxW+X6rMHVCqElf8FDIaui6v58pPUasst4ccE
28svNkBthzInmJzGmXeH4QJ5eqfU8IeitFvZr+5/0zyzAygZfK34La2KpkO5WWX9
Y5hOrbD0XS/7dbjhIseYF/KHmL5fgPy5i79HixCSADvFjVKk0j6T9Rlx5PHANo/X
ZUWQzf6DVB4vW/t5XNbRT1ICmOK4fuMHXI394NgWfainJhuLk0c=
=hgBF
-----END PGP SIGNATURE-----

--cetc77rkog4fj2n6--
