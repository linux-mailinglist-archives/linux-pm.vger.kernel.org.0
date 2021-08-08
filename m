Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6183E3D38
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 01:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhHHXtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Aug 2021 19:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhHHXtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Aug 2021 19:49:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1694FC061760
        for <linux-pm@vger.kernel.org>; Sun,  8 Aug 2021 16:49:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A50451F422A7
Received: by earth.universe (Postfix, from userid 1000)
        id 7D3F93C0C99; Mon,  9 Aug 2021 01:49:25 +0200 (CEST)
Date:   Mon, 9 Aug 2021 01:49:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, maccraft123mc@gmail.com,
        heiko@sntech.de, robh+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC v2 1/4] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <20210808234925.rgd77x4nheom2bx3@earth.universe>
References: <20210726190130.1973-1-macroalpha82@gmail.com>
 <20210726190130.1973-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pntqqh5scteorx5d"
Content-Disposition: inline
In-Reply-To: <20210726190130.1973-2-macroalpha82@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pntqqh5scteorx5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 26, 2021 at 02:01:27PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
>=20
> - rockchip,resistor-sense: The value in microohms of the sample
>                            resistor.
> - rockchip,sleep-enter-current: The value in microamps of the sleep
>                                 enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.

please use common property units:

https://github.com/devicetree-org/dt-schema/blob/master/schemas/property-un=
its.yaml

-- Sebastian

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../devicetree/bindings/mfd/rk808.txt         | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentat=
ion/devicetree/bindings/mfd/rk808.txt
> index 23a17a6663ec..fa42b6253d26 100644
> --- a/Documentation/devicetree/bindings/mfd/rk808.txt
> +++ b/Documentation/devicetree/bindings/mfd/rk808.txt
> @@ -70,13 +70,37 @@ Optional RK817 properties:
> =20
>  - vcc8-supply:  The input supply for BOOST
>  - vcc9-supply:  The input supply for OTG_SWITCH
> +
>  - codec:	The child node for the codec to hold additional properties.
>  		If no additional properties are required for the codec, this
>  		node can be omitted.
> -
> -- rockchip,mic-in-differential: Telling if the microphone uses different=
ial
> +- rockchip,mic-in-differential:	Telling if the microphone uses different=
ial
>  				mode. Should be under the codec child node.
> =20
> +- battery:	The child node for the charger to hold additional properties.
> +		If a battery is not in use, this node can be omitted. If a
> +		battery node is used, the following values are required:
> +		rockchip,resistor-sense, rockchip,sleep-enter-current,
> +		rockchip,sleep-filter-current, and a phandle to a
> +		monitored-battery node that contains a valid value for
> +		charge-full-design-microamp-hours,
> +		charge-term-current-microamp,
> +		constant-charge-current-max-microamp,
> +		constant-charge-voltage-max-microvolt,
> +		voltage-max-design-microvolt, voltage-min-design-microvolt,
> +		and a valid ocv-capacity table.
> +- rockchip,resistor-sense: Value in microohms of the battery sense resis=
tor.
> +			   The PMIC only supports values of either 10000 or
> +			   20000. This value is used by the driver to set
> +			   the correct divisor value to translate ADC readings
> +			   into the proper units of measure.
> +- rockchip,sleep-enter-current: Value in microamps of the sleep enter cu=
rrent
> +				for the charger. Value is used by the driver
> +				to calibrate the relax threshold.
> +- rockchip,sleep-filter-current: Value in microamps of the sleep filter =
current
> +				 for the charger. Value is used by the driver
> +				 to derive the sleep sample current.
> +
>  Optional RK818 properties:
>  - vcc1-supply:  The input supply for DCDC_REG1
>  - vcc2-supply:  The input supply for DCDC_REG2
> @@ -459,6 +483,13 @@ Example:
>  			};
>  		};
> =20
> +		rk817_battery: battery {
> +			monitored-battery =3D <&battery_cell>;
> +			rockchip,resistor-sense =3D <10000>;
> +			rockchip,sleep-enter-current =3D <300000>;
> +			rockchip,sleep-filter-current =3D <100000>;
> +		};
> +
>  		rk817_codec: codec {
>  			rockchip,mic-in-differential;
>  		};
> --=20
> 2.25.1
>=20

--pntqqh5scteorx5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEQbYUACgkQ2O7X88g7
+pp23A/+LfEKSuvv0Gu++WqrdOYO5aozobC75hO29l/vAooU8hXId98PEDnNiDIi
kv9WyULSLJxqbDaY6GGyQ8XpVeQbUoE4leuM0kqLpDsa2SK6zLOxQBkIUMXTZd6g
KGaYYcjmSaBkEDUPLZdjtbP4I+CCOhbbHw7swUrfeqddJu5xiTxn6dgWAdNDAUR0
XU7PmnUzOaYfHOHPKlhj495dvfX3JPTryLB/jdhCybyTzS2opehTFw+DfQMrHcVH
Gnt4Cr6cWp0t2w7OcuNUnAvirg1Ct8OnCSt6SgNif0c+/VFQH7/+eGq2dVWuzv0w
VrGcywG15Y45cbwHGq8XJRcfK0SVUjr3uPZhNVzXQ73hwbf6aGy3w2ELmFLxl6oA
T7Ja3gIsY90yY0ugundwMF5SudJ7I/QXWPIBxTzYPCQAP9+OqevSeMVNlC6Wd5sK
p4FrsR5jxHMcPArqIEBjC2ZvSJWqQ+wmfZYxsN94RE18OdAvLEquPG5X8E6YOopA
nYlNQ1qHXktlCFeDH3nZVly6OLwhrAF1fs9O8LdSZQ+m+tomlcZsnMXRD9QOQ4qq
MhPm4zCt0j0dKe6G3+3pHBcbeWdPumP6s5c90vjNoUwpgairkdM/wGRgwUpTN85+
ue0hWagMf9KX7semQ7Pb921i5a49Xwsj3Cdmoy4m+CczBdVIfpk=
=XGiK
-----END PGP SIGNATURE-----

--pntqqh5scteorx5d--
