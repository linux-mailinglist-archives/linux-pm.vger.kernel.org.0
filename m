Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266343EBA06
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhHMQ3s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhHMQ3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 12:29:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFEBC061756;
        Fri, 13 Aug 2021 09:29:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 60E1F1F44925
Received: by earth.universe (Postfix, from userid 1000)
        id 406E53C0C99; Fri, 13 Aug 2021 18:29:14 +0200 (CEST)
Date:   Fri, 13 Aug 2021 18:29:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bruno Meneguele <bruno.meneguele@smartgreen.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: bq24735: add watchdog timer delay
 support
Message-ID: <20210813162914.p3mzc47ixpmdk62f@earth.universe>
References: <20210709142731.23418-1-bruno.meneguele@smartgreen.net>
 <20210709142731.23418-3-bruno.meneguele@smartgreen.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qozfxa223fazoxhr"
Content-Disposition: inline
In-Reply-To: <20210709142731.23418-3-bruno.meneguele@smartgreen.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qozfxa223fazoxhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 09, 2021 at 11:27:31AM -0300, Bruno Meneguele wrote:
> The BQ24735 charger allows the user to set the watchdog timer delay betwe=
en
> two consecutives ChargeCurrent or ChargeVoltage command writes, if the IC
> doesn't receive any command before the timeout happens, the charge is tur=
ned
> off.
>=20
> This patch adds the support to the user to change the default/POR value w=
ith
> four discrete values:
>=20
>   0 - disabled
>   1 - enabled, 44 sec
>   2 - enabled, 88 sec
>   3 - enabled, 175 sec (default at POR)
>=20
> These are the options supported in the ChargeOptions register bits 13&14.
>=20
> Also, this patch make one additional check when poll-interval is set by t=
he
> user: if the interval set is greater than the WDT timeout it'll fail duri=
ng
> the probe stage, preventing the user to set non-compatible values between
> the two options.
>=20
> Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
> ---
>  .../bindings/power/supply/bq24735.yaml        | 13 +++++

Patches for the DT bindings needs to be CC'd to the DT binding
maintainers and should be in their own patch.

>  drivers/power/supply/bq24735-charger.c        | 48 +++++++++++++++++++
>  include/linux/power/bq24735-charger.h         |  1 +
>  3 files changed, 62 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yaml =
b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> index 131be6782c4b..62399efab467 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
> @@ -56,6 +56,19 @@ properties:
>        The POR value is 0x1000h. This number is in mA (e.g. 8064).
>        See the spec for more information about the InputCurrent (0x3fh) r=
egister.
> =20
> +  ti,wdt-timeout:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Used to control and set the charger watchdog delay between consecu=
tive
> +      charge voltage and charge current commands.
> +      This value must be:
> +        0 - disabled
> +        1 - 44 seconds
> +        2 - 88 seconds
> +        3 - 175 seconds
> +      The POR value is 0x11 (3).
> +      See the spec for more information about the ChargeOptions(0x12h) r=
egister.
> +

This is missing=20

minimum: 0
maximum: 3

>    ti,external-control:
>      type: boolean
>      description: |
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/suppl=
y/bq24735-charger.c
> index 3ce36d09c017..88f1cb1e9fee 100644
> --- a/drivers/power/supply/bq24735-charger.c
> +++ b/drivers/power/supply/bq24735-charger.c
> @@ -45,6 +45,8 @@
>  /* ChargeOptions bits of interest */
>  #define BQ24735_CHARGE_OPT_CHG_DISABLE	(1 << 0)
>  #define BQ24735_CHARGE_OPT_AC_PRESENT	(1 << 4)
> +#define BQ24735_CHARGE_OPT_WDT_OFFSET	13
> +#define BQ24735_CHARGE_OPT_WDT		(3 << BQ24735_CHARGE_OPT_WDT_OFFSET)
> =20
>  struct bq24735 {
>  	struct power_supply		*charger;
> @@ -156,6 +158,20 @@ static int bq24735_config_charger(struct bq24735 *ch=
arger)
>  		}
>  	}
> =20
> +	if (pdata->wdt_timeout) {
> +		value =3D pdata->wdt_timeout;
> +
> +		ret =3D bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
> +					  BQ24735_CHARGE_OPT_WDT,
> +					  (value << BQ24735_CHARGE_OPT_WDT_OFFSET));
> +		if (ret < 0) {
> +			dev_err(&charger->client->dev,
> +				"Failed to write watchdog timer: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}

binding says '0' =3D disabled, but code implements '0' =3D do not
change.

-- Sebastian

> +
>  	return 0;
>  }
> =20
> @@ -347,6 +363,17 @@ static struct bq24735_platform *bq24735_parse_dt_dat=
a(struct i2c_client *client)
>  	if (!ret)
>  		pdata->input_current =3D val;
> =20
> +	ret =3D of_property_read_u32(np, "ti,wdt-timeout", &val);
> +	if (!ret) {
> +		if (val <=3D 3) {
> +			pdata->wdt_timeout =3D val;
> +		} else {
> +			dev_warn(&client->dev,
> +				 "Invalid value for ti,wdt-timeout: %d",
> +				 val);
> +		}
> +	}
> +
>  	pdata->ext_control =3D of_property_read_bool(np, "ti,external-control");
> =20
>  	return pdata;
> @@ -476,6 +503,27 @@ static int bq24735_charger_probe(struct i2c_client *=
client,
>  			return 0;
>  		if (!charger->poll_interval)
>  			return 0;
> +		if (charger->pdata->wdt_timeout) {
> +			int wdt_ms;
> +
> +			switch (charger->pdata->wdt_timeout) {
> +			case 1:
> +				wdt_ms =3D 44000;
> +				break;
> +			case 2:
> +				wdt_ms =3D 88000;
> +				break;
> +			case 3:
> +				wdt_ms =3D 175000;
> +				break;
> +			}
> +
> +			if (charger->poll_interval > wdt_ms) {
> +				dev_err(&client->dev,
> +					"Poll interval greater than WDT timeout\n");
> +				return -EINVAL;
> +			}
> +		}
> =20
>  		ret =3D devm_delayed_work_autocancel(&client->dev, &charger->poll,
>  						   bq24735_poll);
> diff --git a/include/linux/power/bq24735-charger.h b/include/linux/power/=
bq24735-charger.h
> index 321dd009ce66..ce5a030ca111 100644
> --- a/include/linux/power/bq24735-charger.h
> +++ b/include/linux/power/bq24735-charger.h
> @@ -12,6 +12,7 @@ struct bq24735_platform {
>  	uint32_t charge_current;
>  	uint32_t charge_voltage;
>  	uint32_t input_current;
> +	uint32_t wdt_timeout;
> =20
>  	const char *name;
> =20
> --=20
> 2.31.1
>=20

--qozfxa223fazoxhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWndoACgkQ2O7X88g7
+pphhg/7BS4jcSO/H83ZVDfrtbLGQnug9SCxp6S3QXkBxMzyeUfpDVwtmgCyhfPO
U10iR78V1mD25gLJAaUWExZpukZKGl3gOg+yg6tfEVzP06FuEgSmDdg4cGQUzc2i
Z1DS5sB4q125ewfdPJjGaPBBh9PzV3DEl+76jRyyK3VS01FaC0zYUhkumbEHbzLG
C4XAaB6QdMQRnDChtGdCS49qH19AePqHJsPZ8xyxg9M/C9h7j+ekFMpzJjSuOaY0
rdV1iCDe7ehEpVXzdQXXb/qU5PrqpbEv2fsqdpeHyyq/IiOHb6/P/mQXQMsdWndk
nbaw4L2IgDCNE4fQDDDfsjg8qB33FDMCeMs3AUca9OMKd4tuH6UF9whNEKZ558Qy
iVpf066iwfSVhMZVyJQIbZ5elSXaTa3h7hc6BVPY1mM4HAdsQdh6FjC4hYriywcK
lR640lLWkCUPrIwZyGbRoMyBEQjARjTzjNlHXdHreY/ahvcyXkcTlMGdscnj3ZlW
Km9/P3eFWF5LmenSfjyS70KVlY6YnMccQqZswbY7khDcqgaF/c492sxsqI7yI5KE
ZBaGEHw6IxMj+Zm1lIcH0yEwAWCJO/h5UlSKfhcKlWsmOdjPmuk+LWt++n1RIcvF
YUnx+3fzSc7CVzBWRmVjbzdJivZe4ac3Ws+GRI/lXdwAkrk4pOM=
=pjxb
-----END PGP SIGNATURE-----

--qozfxa223fazoxhr--
