Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E754142C62A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhJMQUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 12:20:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38838 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhJMQUu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 12:20:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 84F681F4207C
Received: by earth.universe (Postfix, from userid 1000)
        id 7D6AA3C0CA8; Wed, 13 Oct 2021 18:18:28 +0200 (CEST)
Date:   Wed, 13 Oct 2021 18:18:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: ux500: Switch battery nodes to standard
Message-ID: <20211013161828.ddsjxlnnc6u7uq6p@earth.universe>
References: <20211006224008.394191-1-linus.walleij@linaro.org>
 <20211006224008.394191-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mbrvmyuaheehdzal"
Content-Disposition: inline
In-Reply-To: <20211006224008.394191-3-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mbrvmyuaheehdzal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Oct 07, 2021 at 12:40:08AM +0200, Linus Walleij wrote:
> This force-converts the per-device battery node into the standard
> properties using "simple-battery" for the HREF machines and the
> corresponding Samsung battery for the mobile phones.
>=20
> This is fine to do since the battery data in the DTS files has never
> been deployed or used. In commit a1149ae97554
> "ARM: ux500: Disable Power Supply and Battery Management by default"
> it was turned off and has not been switched back on since. In
> the meantime standardized bindings for batteries have appeared
> making the old AB8500 battery bindings obsolete.
>=20
> The battery node which is now in the middle of an included file
> is obviously a per-device piece of information so push this down
> to each board. The HREF machines all have the same battery and can
> share a single node in the HREF dtsi file.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Sebastian: I will merge this patch to the Ux500 tree when/if you
> merge the two other patches, so all is fixed up in linux-next and
> in the merge window.

Thanks, I just merged patch 1 & 2.

-- Sebastian

> ---
>  arch/arm/boot/dts/ste-ab8500.dtsi              | 13 ++++---------
>  arch/arm/boot/dts/ste-ab8505.dtsi              | 13 ++++---------
>  arch/arm/boot/dts/ste-href.dtsi                |  6 ++++++
>  arch/arm/boot/dts/ste-snowball.dts             |  6 ++++++
>  arch/arm/boot/dts/ste-ux500-samsung-codina.dts |  4 ++++
>  arch/arm/boot/dts/ste-ux500-samsung-gavini.dts |  4 ++++
>  arch/arm/boot/dts/ste-ux500-samsung-golden.dts |  4 ++++
>  arch/arm/boot/dts/ste-ux500-samsung-janice.dts |  4 ++++
>  arch/arm/boot/dts/ste-ux500-samsung-kyle.dts   |  4 ++++
>  arch/arm/boot/dts/ste-ux500-samsung-skomer.dts |  4 ++++
>  10 files changed, 44 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/ste-ab=
8500.dtsi
> index 9baf927f9b95..2cf19386a525 100644
> --- a/arch/arm/boot/dts/ste-ab8500.dtsi
> +++ b/arch/arm/boot/dts/ste-ab8500.dtsi
> @@ -129,11 +129,6 @@ ab8500_temp {
>  					io-channel-names =3D "aux1", "aux2";
>  				};
> =20
> -				ab8500_battery: ab8500_battery {
> -					stericsson,battery-type =3D "LIPO";
> -					thermistor-on-batctrl;
> -				};
> -
>  				ab8500_fg {
>  					compatible =3D "stericsson,ab8500-fg";
>  					interrupts =3D <24 IRQ_TYPE_LEVEL_HIGH>,
> @@ -146,7 +141,7 @@ ab8500_fg {
>  							  "LOW_BAT_F",
>  							  "CC_INT_CALIB",
>  							  "CCEOC";
> -					battery =3D <&ab8500_battery>;
> +					monitored-battery =3D <&battery>;
>  					io-channels =3D <&gpadc 0x08>;
>  					io-channel-names =3D "main_bat_v";
>  				};
> @@ -163,7 +158,7 @@ ab8500_btemp {
>  							  "BTEMP_HIGH",
>  							  "BTEMP_LOW_MEDIUM",
>  							  "BTEMP_MEDIUM_HIGH";
> -					battery =3D <&ab8500_battery>;
> +					monitored-battery =3D <&battery>;
>  					io-channels =3D <&gpadc 0x02>,
>  						      <&gpadc 0x01>;
>  					io-channel-names =3D "btemp_ball",
> @@ -200,7 +195,7 @@ ab8500_charger {
>  							  "VBUS_OVV",
>  							  "CH_WD_EXP",
>  							  "VBUS_CH_DROP_END";
> -					battery		=3D <&ab8500_battery>;
> +					monitored-battery =3D <&battery>;
>  					vddadc-supply	=3D <&ab8500_ldo_tvout_reg>;
>  					io-channels =3D <&gpadc 0x03>,
>  						      <&gpadc 0x0a>,
> @@ -214,7 +209,7 @@ ab8500_charger {
> =20
>  				ab8500_chargalg {
>  					compatible	=3D "stericsson,ab8500-chargalg";
> -					battery		=3D <&ab8500_battery>;
> +					monitored-battery	=3D <&battery>;
>  				};
> =20
>  				ab8500_usb: ab8500_usb {
> diff --git a/arch/arm/boot/dts/ste-ab8505.dtsi b/arch/arm/boot/dts/ste-ab=
8505.dtsi
> index 8d018701a680..e98335e9d1cb 100644
> --- a/arch/arm/boot/dts/ste-ab8505.dtsi
> +++ b/arch/arm/boot/dts/ste-ab8505.dtsi
> @@ -92,11 +92,6 @@ usb_id: channel@e {
>  					};
>  				};
> =20
> -				ab8500_battery: ab8500_battery {
> -					stericsson,battery-type =3D "LIPO";
> -					thermistor-on-batctrl;
> -				};
> -
>  				ab8500_fg {
>  					status =3D "disabled";
>  					compatible =3D "stericsson,ab8500-fg";
> @@ -110,7 +105,7 @@ ab8500_fg {
>  							  "LOW_BAT_F",
>  							  "CC_INT_CALIB",
>  							  "CCEOC";
> -					battery =3D <&ab8500_battery>;
> +					monitored-battery =3D <&battery>;
>  					io-channels =3D <&gpadc 0x08>;
>  					io-channel-names =3D "main_bat_v";
>  				};
> @@ -128,7 +123,7 @@ ab8500_btemp {
>  							  "BTEMP_HIGH",
>  							  "BTEMP_LOW_MEDIUM",
>  							  "BTEMP_MEDIUM_HIGH";
> -					battery =3D <&ab8500_battery>;
> +					monitored-battery =3D <&battery>;
>  					io-channels =3D <&gpadc 0x02>,
>  						      <&gpadc 0x01>;
>  					io-channel-names =3D "btemp_ball",
> @@ -166,7 +161,7 @@ ab8500_charger {
>  							  "VBUS_OVV",
>  							  "CH_WD_EXP",
>  							  "VBUS_CH_DROP_END";
> -					battery =3D <&ab8500_battery>;
> +					monitored-battery =3D <&battery>;
>  					vddadc-supply =3D <&ab8500_ldo_adc_reg>;
>  					io-channels =3D <&gpadc 0x09>,
>  						      <&gpadc 0x0b>;
> @@ -177,7 +172,7 @@ ab8500_charger {
>  				ab8500_chargalg {
>  					status =3D "disabled";
>  					compatible =3D "stericsson,ab8500-chargalg";
> -					battery =3D <&ab8500_battery>;
> +					monitored-battery =3D <&battery>;
>  				};
> =20
>  				ab8500_usb: ab8500_usb {
> diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href=
=2Edtsi
> index 961f2c7274ce..718752a0248e 100644
> --- a/arch/arm/boot/dts/ste-href.dtsi
> +++ b/arch/arm/boot/dts/ste-href.dtsi
> @@ -13,6 +13,12 @@ memory {
>  		reg =3D <0x00000000 0x20000000>;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "simple-battery";
> +		battery-type =3D "lithium-ion-polymer";
> +		thermistor-on-batctrl;
> +	};
> +
>  	soc {
>  		uart@80120000 {
>  			pinctrl-names =3D "default", "sleep";
> diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-s=
nowball.dts
> index 934fc788fe1d..fb719c8a8eb2 100644
> --- a/arch/arm/boot/dts/ste-snowball.dts
> +++ b/arch/arm/boot/dts/ste-snowball.dts
> @@ -17,6 +17,12 @@ memory {
>  		reg =3D <0x00000000 0x20000000>;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "simple-battery";
> +		battery-type =3D "lithium-ion-polymer";
> +		thermistor-on-batctrl;
> +	};
> +
>  	en_3v3_reg: en_3v3 {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "en-3v3-fixed-supply";
> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts b/arch/arm/bo=
ot/dts/ste-ux500-samsung-codina.dts
> index 952606e607ed..fbd60065542d 100644
> --- a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
> +++ b/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
> @@ -43,6 +43,10 @@ chosen {
>  		stdout-path =3D &serial2;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "samsung,eb425161lu";
> +	};
> +
>  	/* TI TXS0206 level translator for 2.9 V */
>  	sd_level_translator: regulator-gpio {
>  		compatible =3D "regulator-fixed";
> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts b/arch/arm/bo=
ot/dts/ste-ux500-samsung-gavini.dts
> index fabc390ccb0c..47bbf5ab267f 100644
> --- a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
> +++ b/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
> @@ -20,6 +20,10 @@ chosen {
>  		stdout-path =3D &serial2;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "samsung,eb585157lu";
> +	};
> +
>  	/* TI TXS0206 level translator for 2.9 V */
>  	sd_level_translator: regulator-gpio {
>  		compatible =3D "regulator-fixed";
> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/bo=
ot/dts/ste-ux500-samsung-golden.dts
> index ee6379ab688c..fc4c5166d85b 100644
> --- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> +++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> @@ -25,6 +25,10 @@ chosen {
>  		stdout-path =3D &serial2;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "samsung,eb-l1m7flu";
> +	};
> +
>  	i2c-gpio-0 {
>  		compatible =3D "i2c-gpio";
>  		sda-gpios =3D <&gpio2 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts b/arch/arm/bo=
ot/dts/ste-ux500-samsung-janice.dts
> index f14cf316a70a..2c914c58f8ba 100644
> --- a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
> +++ b/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
> @@ -20,6 +20,10 @@ chosen {
>  		stdout-path =3D &serial2;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "samsung,eb535151vu";
> +	};
> +
>  	/* External LDO for eMMC LDO VMEM_3V3 controlled by GPIO6 */
>  	ldo_3v3_reg: regulator-gpio-ldo-3v3 {
>  		compatible =3D "regulator-fixed";
> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts b/arch/arm/boot=
/dts/ste-ux500-samsung-kyle.dts
> index 3b825666d302..9ec3f85b1a18 100644
> --- a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
> +++ b/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
> @@ -24,6 +24,10 @@ chosen {
>  		stdout-path =3D &serial2;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "samsung,eb425161la";
> +	};
> +
>  	/* TI TXS0206 level translator for 2.9 V */
>  	sd_level_translator: regulator-gpio {
>  		compatible =3D "regulator-fixed";
> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts b/arch/arm/bo=
ot/dts/ste-ux500-samsung-skomer.dts
> index 264f3e9b5fce..37020127f6e7 100644
> --- a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
> +++ b/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
> @@ -20,6 +20,10 @@ chosen {
>  		stdout-path =3D &serial2;
>  	};
> =20
> +	battery: battery {
> +		compatible =3D "samsung,eb485159lu";
> +	};
> +
>  	/* TI TXS0206 level translator for 2.9 V */
>  	sd_level_translator: regulator-gpio {
>  		compatible =3D "regulator-fixed";
> --=20
> 2.31.1
>=20

--mbrvmyuaheehdzal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFnBtAACgkQ2O7X88g7
+poduA//Teo2FRc0LNTv51u7XGMjrWaS9vyTRRX5PzvqwfBb/IHYqfKFlYma08oz
PHA85yRvsoJ3EzIrGpS9ZyHJCll7mr4C+P845EqdWXa0m6liMaY2lZ7t0rwIvKeI
hrzF223ItcqXlPRL9DLqlcmWCU+cbPLHsLO6UGnOKEsJDFkDy9aIvacppBg5teDb
OFdxtEnceJTQqQ2ecySJKUxnXKlFKt6QHeqdF+Gj0QNYMp49QjA9b4olMd4YGzNZ
fhD6IHdLdn05vPFm/f4s+sSg0mDXaBXqkUFfZI2TvAaZLdK+cxkMn6tBJitXODUj
DqvWBy1/tbo7/9cWW3Ttu50ONwf+OzVUDZWEREdPmH5QQBpQbSX9WqVsFYoJoRyf
IlE6LUybH6ySLTLjEZNpPT9KQDLrXEQ+KQNsecjrNpo0IRjsLju9efpob5jtYV6H
Wspszn69JJIb0gBPPIW05vsfIMEl99AWCJbSvH4jybzJXXkQSfBd4ghiRPKwjbeZ
O2MlIXiMmrGS9j3M2Lo04lEDwKMC+HofVcOiD1bf4KdTAxUsCckhFdmy99+PNp9W
WgrhjpHSSfnKuBD4ByBzWfHKPRxkYORcB1d6rc2hf9OjZZfbuuTG+LBEOzgY2RN8
hn9UudU3daf00RTqnsLiqlsJ2a6LV0tHDEBomnYh4+xt1IDwemY=
=e90o
-----END PGP SIGNATURE-----

--mbrvmyuaheehdzal--
