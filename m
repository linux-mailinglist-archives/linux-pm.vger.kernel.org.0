Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD43EBB37
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhHMRSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 13:18:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58602 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhHMRSN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 13:18:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D06D01F44A1D
Received: by earth.universe (Postfix, from userid 1000)
        id 8DD2C3C0C99; Fri, 13 Aug 2021 19:17:39 +0200 (CEST)
Date:   Fri, 13 Aug 2021 19:17:39 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Daniel Gonzalez Cabanelas <dgcbueu@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: reset: linkstation-poweroff: prepare for new
 devices
Message-ID: <20210813171739.cafastjubtkvqkty@earth.universe>
References: <20210624091813.42334-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zlbul57bczkluur7"
Content-Disposition: inline
In-Reply-To: <20210624091813.42334-1-paweldembicki@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zlbul57bczkluur7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 24, 2021 at 11:18:11AM +0200, Pawel Dembicki wrote:
> This commit prepare driver for another device support.
>=20
> New power_off_cfg structure describes two most important things: name of
> mdio bus and pointer to register setting function. It allow to add new
> device with different mdio bus node and other phy register config.
>=20
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/linkstation-poweroff.c | 35 ++++++++++++++++++----
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/r=
eset/linkstation-poweroff.c
> index f1e843df0e16..cb5a32f852c1 100644
> --- a/drivers/power/reset/linkstation-poweroff.c
> +++ b/drivers/power/reset/linkstation-poweroff.c
> @@ -29,11 +29,21 @@
>  #define LED2_FORCE_ON					(0x8 << 8)
>  #define LEDMASK						GENMASK(11,8)
> =20
> +struct power_off_cfg {
> +	char *mdio_node_name;
> +	void (*phy_set_reg)(bool restart);
> +};
> +
>  static struct phy_device *phydev;
> +static const struct power_off_cfg *cfg;
> =20
> -static void mvphy_reg_intn(u16 data)
> +static void linkstation_mvphy_reg_intn(bool restart)
>  {
>  	int rc =3D 0, saved_page;
> +	u16 data =3D 0;
> +
> +	if (restart)
> +		data =3D MII_88E1318S_PHY_LED_TCR_FORCE_INT;
> =20
>  	saved_page =3D phy_select_page(phydev, MII_MARVELL_LED_PAGE);
>  	if (saved_page < 0)
> @@ -66,11 +76,16 @@ static void mvphy_reg_intn(u16 data)
>  		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
>  }
> =20
> +static const struct power_off_cfg linkstation_power_off_cfg =3D {
> +	.mdio_node_name =3D "mdio",
> +	.phy_set_reg =3D linkstation_mvphy_reg_intn,
> +};
> +
>  static int linkstation_reboot_notifier(struct notifier_block *nb,
>  				       unsigned long action, void *unused)
>  {
>  	if (action =3D=3D SYS_RESTART)
> -		mvphy_reg_intn(MII_88E1318S_PHY_LED_TCR_FORCE_INT);
> +		cfg->phy_set_reg(true);
> =20
>  	return NOTIFY_DONE;
>  }
> @@ -82,14 +97,18 @@ static struct notifier_block linkstation_reboot_nb =
=3D {
>  static void linkstation_poweroff(void)
>  {
>  	unregister_reboot_notifier(&linkstation_reboot_nb);
> -	mvphy_reg_intn(0);
> +	cfg->phy_set_reg(false);
> =20
>  	kernel_restart("Power off");
>  }
> =20
>  static const struct of_device_id ls_poweroff_of_match[] =3D {
> -	{ .compatible =3D "buffalo,ls421d" },
> -	{ .compatible =3D "buffalo,ls421de" },
> +	{ .compatible =3D "buffalo,ls421d",
> +	  .data =3D &linkstation_power_off_cfg,
> +	},
> +	{ .compatible =3D "buffalo,ls421de",
> +	  .data =3D &linkstation_power_off_cfg,
> +	},
>  	{ },
>  };
> =20
> @@ -97,13 +116,17 @@ static int __init linkstation_poweroff_init(void)
>  {
>  	struct mii_bus *bus;
>  	struct device_node *dn;
> +	const struct of_device_id *match;
> =20
>  	dn =3D of_find_matching_node(NULL, ls_poweroff_of_match);
>  	if (!dn)
>  		return -ENODEV;
>  	of_node_put(dn);
> =20
> -	dn =3D of_find_node_by_name(NULL, "mdio");
> +	match =3D of_match_node(ls_poweroff_of_match, dn);
> +	cfg =3D match->data;
> +
> +	dn =3D of_find_node_by_name(NULL, cfg->mdio_node_name);
>  	if (!dn)
>  		return -ENODEV;
> =20
> --=20
> 2.25.1
>=20

--zlbul57bczkluur7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWqTMACgkQ2O7X88g7
+prrDQ//SeP6zggVT8iyWjHr79wRUR4zvYmEOX2XDjq1E7DIfdEaq6VFMw2abWt3
1EVq6UaF/oQUJdWogaRI7Jly5iaJNAf/T9fvzeaj8QHVnEGkB/WAKuhY2X3bP8GH
IwSD3NMO6J4+nV61mP6dIMqDq3IN/13vfY46re6+lHPiJEHA4NqODEpGO2idCMMv
2FYIUrNe6duxc/yoxDYIBuoIcR8sVf0+E8gEsnpASrJYe0mJj3vQfbNE+o4etBVf
U0EREUd6wuWRx00W2Yh36YULlSoUsWWSrO/t0J6LfmT1+bWlPRj5IzZGC8Ep+43P
BBfxIdj3MooXntYWKrVd6cvHx2Zhp9gqBecApPLBvzfrK/WN2ogDKeHiNjEiP73v
UY1+sxarW8cSGxyBXMckyQsu2u+P5p5hyH/HPg6cppDpT5RUQutfu0hITVubYiA9
5t3LEjxNnT7HwQd0utbDZYq0a7OGm7DWAL5n9Tv3EyVZPT568MCUi3YHIJZjXsmO
UT5x54lN/6P5dRnIINRvzoFy0rgPC2laoue25TWA+ppnWWgdaXcmNFAeWLxmhLOc
FMK+gNHIbTyRGN58ODpkBKvZAXFpG33CnJibG+70mpwfRQm1920wFtSACN2HNeiu
Z9Ho/O+ddgW/K7I2/c8cJneredVxADFVkomIpiZ8p4M81D0bp3Y=
=NwJ4
-----END PGP SIGNATURE-----

--zlbul57bczkluur7--
