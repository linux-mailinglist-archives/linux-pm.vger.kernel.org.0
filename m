Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3DD201652
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbgFSQ3M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 12:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388632AbgFSQ3I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 12:29:08 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C12A21707;
        Fri, 19 Jun 2020 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592584147;
        bh=ZtQhASeQp5iIgLtY6Y187VZOIqUND/RMMdRa8MqBJZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1Nmqq2Q1PSlS/XgDVPaBzBHdE8AauJhEW6lmqQA4eVEMFvbNqCURptugUHju4lI7
         ndPEtNUUjdw8o5K6o8Ml7ccr4UBCc534yFeBVNcVsiWXaNki2YF/roULzwJvYayvv7
         RTn81dP33oKFk2D+TSKHR87YPJSUW9BE6M8KrvZI=
Received: by earth.universe (Postfix, from userid 1000)
        id 9FE0C3C08CD; Fri, 19 Jun 2020 18:29:05 +0200 (CEST)
Date:   Fri, 19 Jun 2020 18:29:05 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 1/6] dt-bindings: power: supply: gpio-charger: convert
 to yaml
Message-ID: <20200619162905.7yoxccylfz55daie@earth.universe>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
 <20200605224403.181015-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lln7em7yay23qb4r"
Content-Disposition: inline
In-Reply-To: <20200605224403.181015-2-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lln7em7yay23qb4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 06, 2020 at 12:43:58AM +0200, Sebastian Reichel wrote:
> Convert the gpio-charger bindings from text format to
> new YAML based representation.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Thanks, queued.

-- Sebastian

>  .../bindings/power/supply/gpio-charger.txt    | 31 ----------
>  .../bindings/power/supply/gpio-charger.yaml   | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/gpio-c=
harger.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/gpio-c=
harger.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> deleted file mode 100644
> index 0fb33b2c62a6..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -gpio-charger
> -
> -Required properties :
> - - compatible : "gpio-charger"
> - - gpios : GPIO indicating the charger presence.
> -   See GPIO binding in bindings/gpio/gpio.txt .
> - - charger-type : power supply type, one of
> -     unknown
> -     battery
> -     ups
> -     mains
> -     usb-sdp (USB standard downstream port)
> -     usb-dcp (USB dedicated charging port)
> -     usb-cdp (USB charging downstream port)
> -     usb-aca (USB accessory charger adapter)
> -
> -Optional properties:
> - - charge-status-gpios: GPIO indicating whether a battery is charging.
> -
> -Example:
> -
> -	usb_charger: charger {
> -		compatible =3D "gpio-charger";
> -		charger-type =3D "usb-sdp";
> -		gpios =3D <&gpd 28 GPIO_ACTIVE_LOW>;
> -		charge-status-gpios =3D <&gpc 27 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	battery {
> -		power-supplies =3D <&usb_charger>;
> -	};
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> new file mode 100644
> index 000000000000..78b167c62ab1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/gpio-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: simple battery chargers only communicating through GPIOs
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description:
> +  This binding is for all chargers, which are working more or less
> +  autonomously, only providing some status GPIOs and possibly some
> +  GPIOs for limited control over the charging process.
> +
> +properties:
> +  compatible:
> +    const: gpio-charger
> +
> +  charger-type:
> +    enum:
> +      - unknown
> +      - battery
> +      - ups
> +      - mains
> +      - usb-sdp                   # USB standard downstream port
> +      - usb-dcp                   # USB dedicated charging port
> +      - usb-cdp                   # USB charging downstream port
> +      - usb-aca                   # USB accessory charger adapter
> +    description:
> +      Type of the charger, e.g. "mains" for a wall charger.
> +
> +  gpios:
> +    maxItems: 1
> +    description: GPIO indicating the charger presence
> +
> +  charge-status-gpios:
> +    maxItems: 1
> +    description: GPIO indicating the charging status
> +
> +required:
> +  - compatible
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    charger {
> +      compatible =3D "gpio-charger";
> +      charger-type =3D "usb-sdp";
> +
> +      gpios =3D <&gpd 28 GPIO_ACTIVE_LOW>;
> +      charge-status-gpios =3D <&gpc 27 GPIO_ACTIVE_LOW>;
> +    };
> --=20
> 2.26.2
>=20

--lln7em7yay23qb4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s59EACgkQ2O7X88g7
+poTgg/+Jy47Umtm1TDYfreX2IK/zJzPDWvLpmdpAtPJjctCCrMjTdPVMJUfSRSB
v8y6bhzGd05Uwy4/xNA/s6mfiCkEpvAxy9j4hNW60+9mKG4WXRBVzWCaAHJ2d22r
Yroxoq+7pitZ20P/6t5pTYIS5/UqE2695lH/XuuNzzV2E2LYe3LIHTC+xXQQiuL+
MBVwp8sheham904HsnVPslT1nBY0Oy36BszGrXHAGA+RJVHgqrqWBAHalaOZk1qH
Ab6Z3Zi3QP3kjp2jMaYiXkuuEgRm2UvnHzqSvYGg5XmnnRjEmKhFHJVz5aApXmqs
QWFjVVm6iAoCnqnChBenWEBQl0QGq5p3+aCvVUTp++4VTXnMaP1ZdHyHS0T7SbIK
pVXFPpXQ4q8mNhRF7yc8KS/pmOPPhoeoc7RPlEVrw/7qphhCPu3zpQ0UYg22Qk9P
kuhvNHN2w1ekCHpY4FEMElT920IXy/O4nzBwnXJMRkhCOtrJEIMDXwNUq34y3cGd
tQnqfu41F7SGZ+eaN/62BOmAt1tFUuBHItULPxKUTKl1Hyz+OwbmtTaPwQzcxjl9
3hJdQT+xh09EmsdcZ6CzViB1DJHANr+KHF9DEgy5UsYQZR6aAvWBTKL2SgJNFJPz
AM1V7tst08DvxLa1jRg8hSvVwELeOD4c1431wri5tNP6G9tsQXw=
=gdx0
-----END PGP SIGNATURE-----

--lln7em7yay23qb4r--
