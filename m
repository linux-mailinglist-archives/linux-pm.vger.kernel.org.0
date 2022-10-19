Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E11360542E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 01:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJSXpN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 19:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJSXpM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 19:45:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9440BF01A6
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 16:45:08 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D3996602373;
        Thu, 20 Oct 2022 00:45:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666223107;
        bh=32/nM8tOizuEVobUKFcvhd6TOzppgakon2L/Dy3MsY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uzf0p9Uf14IOdv5/SjOF8ORUv8Cn/KcD353vNEtWtVVhecbDlKJ79V+tRTp3r+B8z
         21pB8QCqXQPYITJmCP5r8RjyXLZ0X8Ybq20aYlXYvBtqLsKILDr1ntFN359xtdJ51K
         SmHG/lCWwOFrTcLtZQFsF//JpMsxibHQ4cuEwrtUty9rMnFS/apyKD5VulVNPEc6l8
         v1c0zFpqmGhzhDMEhQBfb6rVLqwK7WMTfYIJRd1zSOOrkWe9NpM54hUNwpc7bN8xV8
         P7VcS7k9GAE5LOp12oVq1ScynDAFe29v2AR+eHiUc7Wd9msxcp82ISEkZiEYgVdz5A
         IfJOu72EeMfwg==
Received: by mercury (Postfix, from userid 1000)
        id 1AC7810607E3; Thu, 20 Oct 2022 01:45:05 +0200 (CEST)
Date:   Thu, 20 Oct 2022 01:45:05 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, maccraft123mc@gmail.com, lee@kernel.org,
        dan.carpenter@oracle.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH] power: supply: Change rk817_chg_cur_to_reg to int
Message-ID: <20221019234505.5viojwmk6ksqr4gb@mercury.elektranox.org>
References: <20221010141329.10006-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ojhjhth2aqihinrd"
Content-Disposition: inline
In-Reply-To: <20221010141329.10006-1-macroalpha82@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ojhjhth2aqihinrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 10, 2022 at 09:13:29AM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Change return value of rk817_chg_cur_to_reg from u8 to int. If the
> function fails to find a suitable value it returns a -EINVAL, but
> defined as a u8 it would not return correctly. Additionally, change
> defined variable that stores return value from u8 to int.
>=20
> Fixes: 11cb8da0189b (power: supply: Add charger driver for Rockchip
> RK817)

Wrong format, must be one line and title should be in quotes in
addition to the brackets. (I fixed this while applying)

> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks, queued to fixes branch.

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 635f051b0821..305354d99177 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -121,7 +121,7 @@ struct rk817_charger {
>  #define ADC_TO_CHARGE_UAH(adc_value, res_div)	\
>  	(adc_value / 3600 * 172 / res_div)
> =20
> -static u8 rk817_chg_cur_to_reg(u32 chg_cur_ma)
> +static int rk817_chg_cur_to_reg(u32 chg_cur_ma)
>  {
>  	if (chg_cur_ma >=3D 3500)
>  		return CHG_3_5A;
> @@ -864,8 +864,8 @@ static int rk817_battery_init(struct rk817_charger *c=
harger,
>  {
>  	struct rk808 *rk808 =3D charger->rk808;
>  	u32 tmp, max_chg_vol_mv, max_chg_cur_ma;
> -	u8 max_chg_vol_reg, chg_term_i_reg, max_chg_cur_reg;
> -	int ret, chg_term_ma;
> +	u8 max_chg_vol_reg, chg_term_i_reg;
> +	int ret, chg_term_ma, max_chg_cur_reg;
>  	u8 bulk_reg[2];
> =20
>  	/* Get initial plug state */
> --=20
> 2.25.1
>=20

--ojhjhth2aqihinrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNQjAAACgkQ2O7X88g7
+pqBfA//f+km5kVUQeP9SwC0jnkEhNZh6/EKepvExUu7IYkbUx40uPrcAPG5K6gJ
C8XNvEY5mHlZJYH+BfR/MWgZ9tVBMx+bYNMN9zVSACFhP9cY3LT8ku+Yg7QmpcXR
YZoidOxlkafnUGzrSj6h1g4EbgjgxLswLCZAz8IKyNfjNWg8D5U59aBwdcLKeZeC
mVfaDMYBL5xsEWrNSJNzO8CkqKv/TWvOVxuKZ119Moaj6Mn83zn8Uxxfq0YE2Oy+
GFIn0kV+iqOseDxR1Zk2Pt7lUurbTP6vKPoNjdfB0qApiL8FY62/M67/p6cPQWyL
KnayNj406rPoATZTCv9Aj9IeiyFnjQh9QKXrbJrW0ZPiOzZBvKteqU80btIjJ+wn
yiwkbUUk7S/h+a9uW5zK7KryKPK/gYcTUUS8Ny+kiNEpdLV+oMSV/hXshKrHGdbc
gK2mHn1J6POH+7HCn9z6gEOA7SNPE0QvC0Clhe4QHN3QzhZZ2cycKQ809U06BfBJ
geVbA/ZcOesUMRLKqZ3fKvt4GzI/YsAvbQ6Uh2qspSZNw5XlL2BeDzNZ6uPFHWs3
sgiO9fbRDsjY0Wbs6Zofj2RXH9Q9JYYNYGJvmk1LxGEYobiQkLUjxt4aFUSlJU7p
a9l85aCnlgpZl18hswwSuJ9cSPETQ2T8AF5aXSpRqs2M6wlOMIs=
=5sQl
-----END PGP SIGNATURE-----

--ojhjhth2aqihinrd--
