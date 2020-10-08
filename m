Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8F287EF1
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgJHXAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 19:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgJHXAg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 19:00:36 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C100422248;
        Thu,  8 Oct 2020 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602198035;
        bh=RhmG9ir2Fk6IUNm/SmhzpPjolcBLKYD4AciOj2QmkgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9zWyfLSdYCLWQjsv2CkXnG/tX9oGZTBYXF2AbUsSWpudKvTtA/TiaziC6dYtwsFB
         qeFW/p7aUhKWV9rMtE5Pk+RtYG683BWX4sC++qMRWelaUIqKguqlVQxxExPqSR2VHV
         qnsnRVfLjqSs4PJXv1X0L/UG9/nlIA5YjdYsT+6s=
Received: by earth.universe (Postfix, from userid 1000)
        id 68CF93C0C87; Fri,  9 Oct 2020 01:00:32 +0200 (CEST)
Date:   Fri, 9 Oct 2020 01:00:32 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
Message-ID: <20201008230032.a2mgd3yymxbbreqo@earth.universe>
References: <20200906195103.1347-1-digetx@gmail.com>
 <20200906195103.1347-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jddqv7i2wiys2vkp"
Content-Disposition: inline
In-Reply-To: <20200906195103.1347-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--jddqv7i2wiys2vkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 06, 2020 at 10:50:59PM +0300, Dmitry Osipenko wrote:
> Add binding document for the ENE KB930 Embedded Controller.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ene-kb930.yaml b/Docum=
entation/devicetree/bindings/mfd/ene-kb930.yaml
> new file mode 100644
> index 000000000000..635c8966ca22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ene-kb930.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ENE KB930 Embedded Controller bindings
> +
> +description: |
> +  This binding describes the ENE KB930 Embedded Controller attached to an
> +  I2C bus.
> +
> +maintainers:
> +  - Dmitry Osipenko <digetx@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - acer,a500-iconia-ec # Acer A500 Iconia tablet device
> +      - enum:
> +        - ene,kb930
> +  reg:
> +    maxItems: 1
> +
> +  monitored-battery: true

^^^ this is not being used by your battery driver. Do you plan
to use it in the future or is it a copy&paste mistake? :)

-- Sebastian

> +  power-supplies: true
> +  system-power-controller: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    battery: battery-cell {
> +      compatible =3D "simple-battery";
> +      charge-full-design-microamp-hours =3D <3260000>;
> +      energy-full-design-microwatt-hours =3D <24000000>;
> +      operating-range-celsius =3D <0 40>;
> +    };
> +
> +    mains: ac-adapter {
> +      compatible =3D "gpio-charger";
> +      charger-type =3D "mains";
> +      gpios =3D <&gpio 125 0>;
> +    };
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      embedded-controller@58 {
> +        compatible =3D "acer,a500-iconia-ec", "ene,kb930";
> +        reg =3D <0x58>;
> +
> +        system-power-controller;
> +
> +        monitored-battery =3D <&battery>;
> +        power-supplies =3D <&mains>;
> +      };
> +    };
> +
> +...
> --=20
> 2.27.0
>=20

--jddqv7i2wiys2vkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/mhAACgkQ2O7X88g7
+pp63A//ZZhQ8x9f3hQfOOIo4d7D0X+Ybay9oCzCADuEMxtx+s9y57OBHSkMNiZ5
uaBXwueE/HMe0VVsc/HOmBh2T9iOxVmab1+YP36zeNB6tsma/jmfjToqEjwjyXMn
uqEfC8aKFSar9Hm2JtYRjkwAcNxCktmXHyKpiBsA66UWq8W6PMePeDeZNBLJBd+R
XZg/Z/RgXRmgD5Hdm2tuQqPHM8+9yvS08I69E4uFW9b/ci9LyNkDZ2Nv8Fztyaw8
CNpFSNB9+GI3RsXDFg9oKz5ofyGvICElD2M9QumvoBdTriJPBA2Btsggn4z0ERpP
hl+ixC/hu1+wK0NLL4wyoJdIlfzPRWp1oL0C9q0C8coSgaC5dEBLscadtMrjVr9l
2WbXodXV+igOW5egV5z1G6LzJygbUAq+xs4XtO+f+OzV74p+LS1QS0AF7D8zdSqS
Ne+4Dj30VWqbYgI1fVWaT4BmgzSPcHLLLAA0dytpmDzoHezNqGyHcO8OuZ0PgPnB
t9Rlptvg/QQEnxdzhzZiT5gT49eHcyzvfYhZngzUjpkN7o53Grjm4HXqVLuUo/cj
HVR6i9+GKDLPKrzKYIiINyfY6TV+WVlCbDUDUPn0S5aTpkpSf1zfRV0ShWamZ6C4
77hVvD10pIUr9UfbF3pdvk2xOLYg82J6b4WrArkl/U7tvEztR8Q=
=spjz
-----END PGP SIGNATURE-----

--jddqv7i2wiys2vkp--
