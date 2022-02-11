Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F44B2EEE
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 21:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiBKUzh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Feb 2022 15:55:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBKUzh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Feb 2022 15:55:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC729E
        for <linux-pm@vger.kernel.org>; Fri, 11 Feb 2022 12:55:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 196021F47058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644612934;
        bh=1T88aKMftv+IcSARNW07epkwwwoboZk2xrCVKBO8+TA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqtWQF5YBGzr9gOJR0iOj1rdSqZ9mMYmCscS0vCmH6bhYSTTLphFyi6Vun6SqMMII
         uXg1/JP8YseH9f0XB4lBRkj+OaI8Fix9NJS8Gwsgu+nN3eHs8YQTgCMno7pFZ64qFL
         hDo1I96h6ThnGWxFmEQesqCF3gkct8l17p+55HIb5vBdyOiv9DqqN8KsIPw8GfItic
         gcIGiqlH5AxXRl52RjzrniHENvy6j0/S267Y09yhO1qW+NgcW9Dz5ZB92maPKqcroc
         LOLVxT2S3Rla+xsj825eyCZXeaecTme6/ejYF3xjp/MEhqbIgCIyVssHutr62eF1Y6
         7k06FrQBbEbUw==
Received: by mercury (Postfix, from userid 1000)
        id 29A6A1060908; Fri, 11 Feb 2022 21:55:32 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:55:32 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: axp288-charger: Set Vhold to 4.4V
Message-ID: <20220211205532.fcckg65l25vdc3qm@mercury.elektranox.org>
References: <20220208125147.512145-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wmwew4sslyhtuqti"
Content-Disposition: inline
In-Reply-To: <20220208125147.512145-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wmwew4sslyhtuqti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 08, 2022 at 01:51:47PM +0100, Hans de Goede wrote:
> The AXP288's recommended and factory default Vhold value (minimum
> input voltage below which the input current draw will be reduced)
> is 4.4V. This lines up with other charger IC's such as the TI
> bq2419x/bq2429x series which use 4.36V or 4.44V.
>=20
> For some reason some BIOS-es initialize Vhold to 4.6V or even 4.7V
> which combined with the typical voltage drop over typically low
> wire gauge micro-USB cables leads to the input-current getting
> capped below 1A (with a 2A capable dedicated charger) based on Vhold.
>=20
> This leads to slow charging, or even to the device slowly discharging
> if the device is in heavy use.
>=20
> As the Linux AXP288 drivers use the builtin BC1.2 charger detection
> and send the input-current-limit according to the detected charger
> there really is no reason not to use the recommended 4.4V Vhold.
>=20
> Set Vhold to 4.4V to fix the slow charging issue on various devices.
>=20
> There is one exception, the special-case of the HP X2 2-in-1s which
> combine this BC1.2 capable PMIC with a Type-C port and a 5V/3A factory
> provided charger with a Type-C plug which does not do BC1.2. These
> have their input-current-limit hardcoded to 3A (like under Windows)
> and use a higher Vhold on purpose to limit the current when used
> with other chargers. To avoid touching Vhold on these HP X2 laptops
> the code setting Vhold is added to an else branch of the if checking
> for these models.
>=20
> Note this also fixes the sofar unused VBUS_ISPOUT_VHOLD_SET_MASK
> define, which was wrong.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp288_charger.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index ec41f6cd3f93..c498e62ab4e2 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -42,11 +42,11 @@
>  #define VBUS_ISPOUT_CUR_LIM_1500MA	0x1	/* 1500mA */
>  #define VBUS_ISPOUT_CUR_LIM_2000MA	0x2	/* 2000mA */
>  #define VBUS_ISPOUT_CUR_NO_LIM		0x3	/* 2500mA */
> -#define VBUS_ISPOUT_VHOLD_SET_MASK	0x31
> +#define VBUS_ISPOUT_VHOLD_SET_MASK	0x38
>  #define VBUS_ISPOUT_VHOLD_SET_BIT_POS	0x3
>  #define VBUS_ISPOUT_VHOLD_SET_OFFSET	4000	/* 4000mV */
>  #define VBUS_ISPOUT_VHOLD_SET_LSB_RES	100	/* 100mV */
> -#define VBUS_ISPOUT_VHOLD_SET_4300MV	0x3	/* 4300mV */
> +#define VBUS_ISPOUT_VHOLD_SET_4400MV	0x4	/* 4400mV */
>  #define VBUS_ISPOUT_VBUS_PATH_DIS	BIT(7)
> =20
>  #define CHRG_CCCV_CC_MASK		0xf		/* 4 bits */
> @@ -769,6 +769,16 @@ static int charger_init_hw_regs(struct axp288_chrg_i=
nfo *info)
>  		ret =3D axp288_charger_vbus_path_select(info, true);
>  		if (ret < 0)
>  			return ret;
> +	} else {
> +		/* Set Vhold to the factory default / recommended 4.4V */
> +		val =3D VBUS_ISPOUT_VHOLD_SET_4400MV << VBUS_ISPOUT_VHOLD_SET_BIT_POS;
> +		ret =3D regmap_update_bits(info->regmap, AXP20X_VBUS_IPSOUT_MGMT,
> +					 VBUS_ISPOUT_VHOLD_SET_MASK, val);
> +		if (ret < 0) {
> +			dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
> +				AXP20X_VBUS_IPSOUT_MGMT, ret);
> +			return ret;
> +		}
>  	}
> =20
>  	/* Read current charge voltage and current limit */
> --=20
> 2.33.1
>=20

--wmwew4sslyhtuqti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGzUMACgkQ2O7X88g7
+pr6+Q//c2ITP9JVen6HRIIxvXotgqCglJSv6gZHwado/CXnFOj9SSmE2FRoL4t+
bUlOA+DLs69dMjPNwuFzHWWYKqiIip3CCqNY9zKGndwAkeohShs+XjdQiJfU+FXO
5NzgBTKcKQfuG6cSUj2tiPp+fEZqarkyJeTgCeawNIiwUI1LQve7FqL9BC33ZID9
MHNkUhvTVDKD3BVx4dGWTTXs/uWrLCaeraOSFyrhmIEzCT50OIdNqhWMENa2o8hP
2tXePwhMH9nugtVR/sWpDLczoG0ZhNRZpy+3MPfv72Bo098bDmyT2xdpgXKYq9g1
zPkGYzKAR9quIIboHJeRe1WAm2ZCZKdntLbUdtJvP1FgC2vh+cYOdZz0pqvN0WUN
xT5EXn6Y1j0pOj1Vxgl1DIlVL2SRH/mqjGI5WNS6YRuADBnFxf06k4FSpqQJ6ZRD
qF3nPFTkVUqvQTL93Xh9dbI3DQGoS5Hixnc2aR7W/g2bO0c1M0OOZuEKC282MsYv
7h9PsKWUK0WUu/IhPJrHOHND+6O45n9Gdrdx0tLFqHWwKF103sG7kAxF8JnBegYI
83qOYDfKvLJr1BNOjhNgdSFh2e0V89G4tKWaJUSZM4fyMaV0cJtSso/KRRTk/O/0
aXwoE2qU0zxmYLjLLEfLFjR53l6hPQiqgIvOwqxXgH4mgifJ1CQ=
=Efrt
-----END PGP SIGNATURE-----

--wmwew4sslyhtuqti--
