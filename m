Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB0F69521C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBMUnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 15:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBMUnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 15:43:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BFC1DB8E
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 12:43:45 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 519826602158;
        Mon, 13 Feb 2023 20:43:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676321022;
        bh=vTNbl0Ib+pbs1GsWOsUQowsyN4AB6ATgUEMoTLiUBlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lG5MsCqbUgFBENvY9guO1kPKWISoRZGnWNkwl1ktmwkl3RCwB5hPgjUd/HqNncdPu
         0AnklTAj/tSRz/FIkLfhXzFMQuCQ0M/cHHYG+6ILpEK11uolFJqNnlhjplrzVySh88
         FlnA/jVRi9P1SzKbEi3OfAXmFvIQAdu5SLPjr6O3Urs7r2WzwDRrYswYPryLu2SuR3
         dEIe5V71CUnacwvE48YnzS/DHLFZtDH2p6DZbaPqXYCPsb3YLSf6juIEDwU0RoxioR
         0gN2HbIe0Bs+FfKbsSI73S/CKnLl/ZzwE1AF6LBBd/GF9+XXmyKoMfIf5PEcqpUIXn
         5mhvlV5GiXSXg==
Received: by mercury (Postfix, from userid 1000)
        id 335E71060961; Mon, 13 Feb 2023 21:43:40 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:43:40 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, alina_yu@richtek.com,
        cy_huang@richtek.com, u0084500@gmail.com
Subject: Re: [PATCH -next v2] power: supply: rt9471: fix using wrong ce_gpio
 in rt9471_probe()
Message-ID: <20230213204340.3m6kctgmoxqwdbw5@mercury.elektranox.org>
References: <20230206122018.3601419-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnqv5cprm2sofsjd"
Content-Disposition: inline
In-Reply-To: <20230206122018.3601419-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lnqv5cprm2sofsjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 06, 2023 at 08:20:18PM +0800, Yang Yingliang wrote:
> Pass the correct 'ce_gpio' to IS_ERR(), and remove the ce_gpio in
> chip data, make it all by SW control only, not to control by HW pin.
>=20
> Fixes: 4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charger d=
river")
> Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Thanks, queued.

-- Sebastian

> v1 -> v2:
>   Remove the ce_gpio in chip data.
> ---
>  drivers/power/supply/rt9471.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
> index 5d3cf375ad5c..1ea40876494b 100644
> --- a/drivers/power/supply/rt9471.c
> +++ b/drivers/power/supply/rt9471.c
> @@ -141,7 +141,6 @@ enum {
> =20
>  struct rt9471_chip {
>  	struct device *dev;
> -	struct gpio_desc *ce_gpio;
>  	struct regmap *regmap;
>  	struct regmap_field *rm_fields[F_MAX_FIELDS];
>  	struct regmap_irq_chip_data *irq_chip_data;
> @@ -851,7 +850,7 @@ static int rt9471_probe(struct i2c_client *i2c)
> =20
>  	/* Default pull charge enable gpio to make 'CHG_EN' by SW control only =
*/
>  	ce_gpio =3D devm_gpiod_get_optional(dev, "charge-enable", GPIOD_OUT_HIG=
H);
> -	if (IS_ERR(chip->ce_gpio))
> +	if (IS_ERR(ce_gpio))
>  		return dev_err_probe(dev, PTR_ERR(ce_gpio),
>  				     "Failed to config charge enable gpio\n");
> =20
> --=20
> 2.25.1
>=20

--lnqv5cprm2sofsjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqoPsACgkQ2O7X88g7
+pq8nA//QnjAFAovFM3xPQ5LmwU+1OvK4WnMpy8XSezTMMCTMl0VAw/ISxSuk1KI
+b3xtWQZ7OB4xyZ1jn6F8O4yG9VkpROum4JKtkZn5qckjq516IhfkIO7O9fpR0m/
mtS31f0m+clNdOfy7BUzCd/MXhfQwl+pAfXSVbrJeg30Jif/QdXTZZAJGI0mTDnN
9SJ0uOOrcNXOP3iJFy6IE0A9QxHQcbb/9MkdHvKYBB+s58y4/g+Qb0rUeesWb3gD
fUqAUoQ85nGsXi7c+HeaKd2Jw8EKwMlHatGTwd1oM5epYD5GqC7qu6E3IqObOdJp
0rEFvqMB20+tZj0SvP1hsABStWi9+ffsbcKDfES13X4Q9veCbcaEWulZrqHjg4uZ
MYct8mbS6e4W3iHCgLypJ3RNpmVgLHpnQ5usDIdpYXtHM+248/5FDiuKCW5wGN8Q
5sLEJ/B90+OHwQoryPFjy8ulE8LHqjDD5F2WZDHbGa/JyMM2sHcM18np4b60IfXD
WeHEBrvUdUk+jJBJy7IqNr/SeEG45ai8WeZZ+XzScPsBcOgEoN6W8bjWfXCOKCcd
38zxWADJTXOFFzFS+5pikOsjRbDmHhbVEvyam3uUdOaay1SWcm0OsInhoQDXNIzW
r83jmpBMmfhusBPqS2SjvNgWnrvZxIA7WUSLgHhx6HBef9rOpS8=
=0Nop
-----END PGP SIGNATURE-----

--lnqv5cprm2sofsjd--
