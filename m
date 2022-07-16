Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE957721C
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGPXHp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 19:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiGPXHo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 19:07:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5EF186D4
        for <linux-pm@vger.kernel.org>; Sat, 16 Jul 2022 16:07:43 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0212D66015C4;
        Sun, 17 Jul 2022 00:07:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658012862;
        bh=6tmUuXU5FOkUnkbO/ntgxJ+Ac8p4cYlNZjt5d7YI7m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZOY9bx2GDw92H0Zzjpz8C5dOIYVmyKNYla0zyLR6csbWHsOgyVX0+oq3t8fmwy2i
         2d4yQDBJvMrFyZ2haUhBiBssNZ1P5gKzrbmxAf1JtLnpi2ptnRZxvMZcxunZ+h1PkV
         PIG07KXmjTEiZAwvC3wXD+QDJWv2b5nZNvfMKBzcK3UyBlJiRo49HMalzhDBwOrnsZ
         z31Y7b281ZOzk3A/J6NcDopHSYaxyK8xvRq+aP/bEssBTP9+ruEbSXi8hIMGjhwcJw
         okQnp0R6OGgO8TNCXJ+2UQ7mZ/FaRrNCgvCUjphh9ZB3bdI2TC5wgcKlA51FW+8kCT
         82TwijAugrY1Q==
Received: by mercury (Postfix, from userid 1000)
        id 278261060428; Sun, 17 Jul 2022 01:07:39 +0200 (CEST)
Date:   Sun, 17 Jul 2022 01:07:39 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Liang He <windhl@126.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] power/supply/olpc_battery: Hold the reference
 returned by of_find_compatible_node
Message-ID: <20220716230739.dwqv5ynts5j74433@mercury.elektranox.org>
References: <20220621151720.4083639-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjqw3pjjsnl73wzh"
Content-Disposition: inline
In-Reply-To: <20220621151720.4083639-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xjqw3pjjsnl73wzh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 21, 2022 at 11:17:20PM +0800, Liang He wrote:
> In olpc_battery_probe(), we should hold the reference returned by
> of_find_compatible_node() and use it to call of_node_put() for
> refcount balance.
>=20
> Signed-off-by: Liang He <windhl@126.com>
> ---

Thanks, queued.

-- Sebastian

>  changelog:
>=20
>  v2: fix bug intro-ed by v1, reported by lkp.
>  v1: add hold-ref code.
>=20
>  drivers/power/supply/olpc_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index e0476ec06601..a5da20ffd685 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -635,6 +635,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
>  	struct power_supply_config bat_psy_cfg =3D {};
>  	struct power_supply_config ac_psy_cfg =3D {};
>  	struct olpc_battery_data *data;
> +	struct device_node *np;
>  	uint8_t status;
>  	uint8_t ecver;
>  	int ret;
> @@ -649,7 +650,9 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
> +	np =3D of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec");
> +	if (np) {
> +		of_node_put(np);
>  		/* XO 1.75 */
>  		data->new_proto =3D true;
>  		data->little_endian =3D true;
> --=20
> 2.25.1
>=20

--xjqw3pjjsnl73wzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTRLoACgkQ2O7X88g7
+povOxAAk7ZkYpoNxkHlLrrWOUkdAFvvvMJZDL1133ulFZ+kgDXyP3IgjrOaHmy0
QiYc8rJ757+dA3SRnpEYxTbbS3dEe8ZFwKoo+UONoJayGqduQ2UilGeyqBtwvVXs
kXhzEgNEvlObqFfrhKKntY5sQzTr8hfPxdV6YbmSOe82lJ6pTpJPHuEIZB3XonFM
UjAq2B+ulTpEBZKDjYmjPdm61mDNAmorYvCdgEhbAp9Dm7BSx0xoQRe62haAXPaG
aeVlQmnlYLkSj2xwy/WIx5wVkpbd+9v7LW7cC/9SwVs65Dpi7fgKFEmP5YGiXhg2
wWwW1Ho3FviUkjLZ0VE3fQAsV+cKbkpw1CMcjALtdP/K+1mW3rG/eRIjtSwpnNrO
e5PxEZ0wPGb00B57lU9ePyFke/ivDJYuoUTrZ6l/YivzPO00Mk3BSku4C6q2BRh2
HqK344vHWYbgrbKrtlH9MSpw/eWTPunDI/CBFlDFLn5bdTqggI7GUpkI/WDSLmhY
zjREJyYGYDrrm9+J4LQC1wezNrPDAolS9GbGU3J2zeUkq9gQXwTEcrUmmaSequ/8
2ph2bVsb7eVKI9hQpEEgfzRsrJkrV1BL9ZD1kiuXrZoyVzzzeSvwIN3MEtgRZEbF
QevPG9FIMRJmIV3XYiuzQoTFAGR8K2P9/hegiB4CzhvK2n3Z8Uw=
=CnBh
-----END PGP SIGNATURE-----

--xjqw3pjjsnl73wzh--
