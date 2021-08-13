Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE83EBB39
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHMRSh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 13:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhHMRSb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 13:18:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336DAC0612E7;
        Fri, 13 Aug 2021 10:18:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1F3011F44A1D
Received: by earth.universe (Postfix, from userid 1000)
        id CEBBC3C0C99; Fri, 13 Aug 2021 19:18:00 +0200 (CEST)
Date:   Fri, 13 Aug 2021 19:18:00 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Daniel Gonzalez Cabanelas <dgcbueu@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: reset: linkstation-poweroff: add new device
Message-ID: <20210813171800.7p4jdfh2khf5pb2q@earth.universe>
References: <20210624091813.42334-1-paweldembicki@gmail.com>
 <20210624091813.42334-2-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="js5kloxk3sqjf6s4"
Content-Disposition: inline
In-Reply-To: <20210624091813.42334-2-paweldembicki@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--js5kloxk3sqjf6s4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 24, 2021 at 11:18:12AM +0200, Pawel Dembicki wrote:
> This commit introduces support for NETGEAR ReadyNAS Duo v2.
> This device use bit 4 of LED[2:0] Polarity Control Register to indicate
> AC Power loss.
>=20
> For more details about AC loss detection in NETGEAR ReadyNAS Duo v2,
> please look at the file:
> RND_5.3.13_WW.src/u-boot/board/mv_feroceon/mv_hal/usibootup/usibootup.c
> from Netgear GPL sources.
>=20
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/linkstation-poweroff.c | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/r=
eset/linkstation-poweroff.c
> index cb5a32f852c1..5afe3ef23395 100644
> --- a/drivers/power/reset/linkstation-poweroff.c
> +++ b/drivers/power/reset/linkstation-poweroff.c
> @@ -19,6 +19,7 @@
>  #define MII_MARVELL_PHY_PAGE		22
> =20
>  #define MII_PHY_LED_CTRL		16
> +#define MII_PHY_LED_POL_CTRL		17
>  #define MII_88E1318S_PHY_LED_TCR	18
>  #define MII_88E1318S_PHY_WOL_CTRL	16
>  #define MII_M1011_IEVENT		19
> @@ -29,6 +30,8 @@
>  #define LED2_FORCE_ON					(0x8 << 8)
>  #define LEDMASK						GENMASK(11,8)
> =20
> +#define MII_88E1318S_PHY_LED_POL_LED2		BIT(4)
> +
>  struct power_off_cfg {
>  	char *mdio_node_name;
>  	void (*phy_set_reg)(bool restart);
> @@ -76,11 +79,48 @@ static void linkstation_mvphy_reg_intn(bool restart)
>  		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
>  }
> =20
> +static void readynas_mvphy_set_reg(bool restart)
> +{
> +	int rc =3D 0, saved_page;
> +	u16 data =3D 0;
> +
> +	if (restart)
> +		data =3D MII_88E1318S_PHY_LED_POL_LED2;
> +
> +	saved_page =3D phy_select_page(phydev, MII_MARVELL_LED_PAGE);
> +	if (saved_page < 0)
> +		goto err;
> +
> +	/* Set the LED[2].0 Polarity bit to the required state */
> +	__phy_modify(phydev, MII_PHY_LED_POL_CTRL,
> +		     MII_88E1318S_PHY_LED_POL_LED2, data);
> +
> +	if (!data) {
> +
> +		/* If WOL was enabled and a magic packet was received before powering
> +		 * off, we won't be able to wake up by sending another magic packet.
> +		 * Clear WOL status.
> +		 */
> +		__phy_write(phydev, MII_MARVELL_PHY_PAGE, MII_MARVELL_WOL_PAGE);
> +		__phy_set_bits(phydev, MII_88E1318S_PHY_WOL_CTRL,
> +			       MII_88E1318S_PHY_WOL_CTRL_CLEAR_WOL_STATUS);
> +	}
> +err:
> +	rc =3D phy_restore_page(phydev, saved_page, rc);
> +	if (rc < 0)
> +		dev_err(&phydev->mdio.dev, "Write register failed, %d\n", rc);
> +}
> +
>  static const struct power_off_cfg linkstation_power_off_cfg =3D {
>  	.mdio_node_name =3D "mdio",
>  	.phy_set_reg =3D linkstation_mvphy_reg_intn,
>  };
> =20
> +static const struct power_off_cfg readynas_power_off_cfg =3D {
> +	.mdio_node_name =3D "mdio-bus",
> +	.phy_set_reg =3D readynas_mvphy_set_reg,
> +};
> +
>  static int linkstation_reboot_notifier(struct notifier_block *nb,
>  				       unsigned long action, void *unused)
>  {
> @@ -109,6 +149,9 @@ static const struct of_device_id ls_poweroff_of_match=
[] =3D {
>  	{ .compatible =3D "buffalo,ls421de",
>  	  .data =3D &linkstation_power_off_cfg,
>  	},
> +	{ .compatible =3D "netgear,readynas-duo-v2",
> +	  .data =3D &readynas_power_off_cfg,
> +	},
>  	{ },
>  };
> =20
> --=20
> 2.25.1
>=20

--js5kloxk3sqjf6s4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWqUgACgkQ2O7X88g7
+ppy7g//StdJI1d0XP/jUo9eAUY5fs0qg1w1DFRvYTVMEkDxAMZQH20i9w6aiLJH
IJIywxUS3gRFsrR/NvgQbrFDBx1TucwaQXZoQiEWHUsf4Kcn14FtRQJO+5Px/Kc5
DDZJEjQxsIzHAn3I6epjgEau4juuhigPW1z868xYYhC0PqQNcGYvMcToMkSQbgPr
t1IVwdndNcWWFgJ7iMZuAQRtozwkLQicqgZr5naVu44Lb5fYe4BqrR32zo84tcy7
lRf3F8R9tEVf2EWWDa9yBv/8q0nuv/VcbcRgQcokRHEGhvKDNEnceB9Iu0+DLEDh
HFNcsokvVJuBCBlXXPKkwvsAnMEy2hHdOT3BcF7b9eSxHkI5m6lypp2DfKVUgMgX
ONlp7SOAMDJgwjiJRA6lb3KM0suHFddOusECQJdnFuPyqI0x+Dllbu8MGXOGY7Fa
JLLvRWjNbyMcCLtC5cuE/FK/rYBZ1DIp0XnooZ/lRe4tvLBI28Oq6TYPNHrDbqcz
UEbS3nywx9nS9SEPfL/y7WUlWGGNjSjAZ5EzwVr0b246CBjUvF65rUYXE+vFAiTb
qR4Ck6bK9hVA15fCtWCuuNwBCAy1odQJRzYnzH7wHYAvNQRyZu1CGN6mBGLaJKJ0
/hKu2EQoiJhpk1Tm/A7m99gImw2xPfTu57f2tYtwZXVTQ9mimto=
=n6ZF
-----END PGP SIGNATURE-----

--js5kloxk3sqjf6s4--
