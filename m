Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82884CDFB6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 22:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiCDVXW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 16:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCDVXV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 16:23:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B656760
        for <linux-pm@vger.kernel.org>; Fri,  4 Mar 2022 13:22:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9E31D1F46D77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646428951;
        bh=tJlbYV4WEI4gDQbXGCsUW7A6tPK3DvGdqRBssg8tAPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJTGe9zDBt6CIZ2oJnUt8KOJg38gKZPK55Er3gR3CKCj7n46aZvX6sDh8K8YeSatI
         jb9gKu7rEbEBUbXuKKz/oZLENOUTzWtw0jNzPz5qe/hPr9Z4otTgr2osuFgglHfCBJ
         Slf1sI0QjkdSMI0PQ5ihZ5e+CCU7I2BM5MK0airytJwZYS4/oDzhOVoWPXplU9kUoo
         TocK0iAAngxnN2xXiDL3Vxwi2rgYpICTT06Q8NANqIy54DSur6RFJcfUFG62G1PLLc
         Wyr6iuHZx3edJBqE/5/onuBwrd4q6c1VfNjQThbw/I5DNlIPfc3XITB4rvPJmgfxK7
         NJgyzZOnYqWxg==
Received: by mercury (Postfix, from userid 1000)
        id 91D591060602; Fri,  4 Mar 2022 22:22:29 +0100 (CET)
Date:   Fri, 4 Mar 2022 22:22:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH] power: supply: Fix static batteries
Message-ID: <20220304212229.fqac676xf5okfdrc@mercury.elektranox.org>
References: <20220301003020.2308835-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="faaxlpnhj357gbhd"
Content-Disposition: inline
In-Reply-To: <20220301003020.2308835-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--faaxlpnhj357gbhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 01, 2022 at 01:30:20AM +0100, Linus Walleij wrote:
> The code for looking up static battery data was erroneously
> rebased and assumed we were only using device tree, but we have
> added fwnode support.
>=20
> Augment the code properly to just pass in a compatible as a
> string when looking up a static Samsung battery, also move
> the fwnode parsing code up so we can still check this before
> we move on to simple-battery and start allocating stuff.
>=20
> Fixes: ffb983d31519 ("power: supply: Static data for Samsung batteries")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, I squashed this into the previous commit.

-- Sebastian

>  drivers/power/supply/power_supply_core.c   | 63 +++++++++++-----------
>  drivers/power/supply/samsung-sdi-battery.c |  5 +-
>  drivers/power/supply/samsung-sdi-battery.h |  4 +-
>  3 files changed, 36 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 44816d41b4ec..ea02c8dcd748 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -579,16 +579,42 @@ int power_supply_get_battery_info(struct power_supp=
ly *psy,
>  	const __be32 *list;
>  	u32 min_max[2];
> =20
> +	if (psy->of_node) {
> +		battery_np =3D of_parse_phandle(psy->of_node, "monitored-battery", 0);
> +		if (!battery_np)
> +			return -ENODEV;
> +
> +		fwnode =3D fwnode_handle_get(of_fwnode_handle(battery_np));
> +	} else {
> +		err =3D fwnode_property_get_reference_args(
> +					dev_fwnode(psy->dev.parent),
> +					"monitored-battery", NULL, 0, 0, &args);
> +		if (err)
> +			return err;
> +
> +		fwnode =3D args.fwnode;
> +	}
> +
> +	err =3D fwnode_property_read_string(fwnode, "compatible", &value);
> +	if (err)
> +		goto out_put_node;
> +
> +
>  	/* Try static batteries first */
> -	err =3D samsung_sdi_battery_get_info(&psy->dev, battery_np, &info);
> -	if (!err) {
> -		*info_out =3D info;
> -		return err;
> +	err =3D samsung_sdi_battery_get_info(&psy->dev, value, &info);
> +	if (!err)
> +		goto out_ret_pointer;
> +
> +	if (strcmp("simple-battery", value)) {
> +		err =3D -ENODEV;
> +		goto out_put_node;
>  	}
> =20
>  	info =3D devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> -	if (!info)
> -		return -ENOMEM;
> +	if (!info) {
> +		err =3D -ENOMEM;
> +		goto out_put_node;
> +	}
> =20
>  	info->technology                     =3D POWER_SUPPLY_TECHNOLOGY_UNKNOW=
N;
>  	info->energy_full_design_uwh         =3D -EINVAL;
> @@ -625,31 +651,6 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
>  		info->ocv_table_size[index]  =3D -EINVAL;
>  	}
> =20
> -	if (psy->of_node) {
> -		battery_np =3D of_parse_phandle(psy->of_node, "monitored-battery", 0);
> -		if (!battery_np)
> -			return -ENODEV;
> -
> -		fwnode =3D fwnode_handle_get(of_fwnode_handle(battery_np));
> -	} else {
> -		err =3D fwnode_property_get_reference_args(
> -					dev_fwnode(psy->dev.parent),
> -					"monitored-battery", NULL, 0, 0, &args);
> -		if (err)
> -			return err;
> -
> -		fwnode =3D args.fwnode;
> -	}
> -
> -	err =3D fwnode_property_read_string(fwnode, "compatible", &value);
> -	if (err)
> -		goto out_put_node;
> -
> -	if (strcmp("simple-battery", value)) {
> -		err =3D -ENODEV;
> -		goto out_put_node;
> -	}
> -
>  	/* The property and field names below must correspond to elements
>  	 * in enum power_supply_property. For reasoning, see
>  	 * Documentation/power/power_supply_class.rst.
> diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/s=
upply/samsung-sdi-battery.c
> index 64ec34a41c5b..9d59f277f519 100644
> --- a/drivers/power/supply/samsung-sdi-battery.c
> +++ b/drivers/power/supply/samsung-sdi-battery.c
> @@ -10,7 +10,6 @@
>   * the BTI resistance with a multimeter on the battery.
>   */
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/power_supply.h>
>  #include "samsung-sdi-battery.h"
> =20
> @@ -895,7 +894,7 @@ static struct samsung_sdi_battery samsung_sdi_batteri=
es[] =3D {
>  };
> =20
>  int samsung_sdi_battery_get_info(struct device *dev,
> -				 struct device_node *np,
> +				 const char *compatible,
>  				 struct power_supply_battery_info **info)
>  {
>  	struct samsung_sdi_battery *batt;
> @@ -903,7 +902,7 @@ int samsung_sdi_battery_get_info(struct device *dev,
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(samsung_sdi_batteries); i++) {
>  		batt =3D &samsung_sdi_batteries[i];
> -		if (of_device_is_compatible(np, batt->compatible))
> +		if (!strcmp(compatible, batt->compatible))
>  			break;
>  	}
> =20
> diff --git a/drivers/power/supply/samsung-sdi-battery.h b/drivers/power/s=
upply/samsung-sdi-battery.h
> index 08783847dfcb..365ab6e85b26 100644
> --- a/drivers/power/supply/samsung-sdi-battery.h
> +++ b/drivers/power/supply/samsung-sdi-battery.h
> @@ -1,11 +1,11 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #if IS_ENABLED(CONFIG_BATTERY_SAMSUNG_SDI)
>  extern int samsung_sdi_battery_get_info(struct device *dev,
> -				struct device_node *np,
> +				const char *compatible,
>  				struct power_supply_battery_info **info);
>  #else
>  static inline int samsung_sdi_battery_get_info(struct device *dev,
> -				struct device_node *np,
> +				const char *compatible,
>  				struct power_supply_battery_info **info)
>  {
>  	return -ENODEV;
> --=20
> 2.34.1
>=20

--faaxlpnhj357gbhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIigxUACgkQ2O7X88g7
+poh1Q/+PZBV+nzD1qkx1OMiY8V+DFNx6Jw5n8+ifhsEB1p6mG+DeXqcTGzVMxX4
YSSsa2+AV4A4dtba9eKBKgf3OHcGCcBQaGe0nJ+3f0Z7tud/vSHD81zcwO0QATgT
MffyPzVJsfAAiFei0eT5whDkw49ZXoDvtKIGjIaUBBOo9F8Lx0V/pkHLyMRU+Yq7
F+6jqMUywSnFxFMUajbduTWvoT1YxNyPXt1mK7Oe5nd0KBruIV8I6KvnOEXDRIhF
N6rem+UHaaP0wPc4Ehq4CtIRbqdtuKMDNGTOOOxzfK3ahEOb7+j/pydGeNtJboKc
bpblHkujcNDTIqk3Sd/qGOIhzqr54BdBRJVvHpKy3O1O6j7H9YYpgYAkLmVrWS0z
/qp4/mEvIpPa/L9sgpnwnwX+EsL9YEo9Nbl3qgqfo+mV5OdhmsN+aItL4EaWfe4f
9RXpzVU8ITUnV8aKF09U8xexCJjcPPhFXxDYXskLkQCas7Ewb9lJ/UbnPv/6km2f
LPVT95WU5LnX/Dqle11MOLnUUF5rQjn8GkwB644Ee+wkSMEBEsVfVk7YnuIt7Yov
OR1G5MvKFhDUyvlFkCzuraCKKsBTwV6gbjT4LKu0JiEvjvSZi/QtI5nisKevqY9+
V82Ueb6SQ0wNudT7ernXyXGXpoZ+k5dx1LIXJ/Ffq1/+MWNizv8=
=cbX4
-----END PGP SIGNATURE-----

--faaxlpnhj357gbhd--
