Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07762017BE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395525AbgFSQmq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 12:42:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbgFSQmp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 12:42:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C0CE72A163A
Received: by earth.universe (Postfix, from userid 1000)
        id 86D403C08CD; Fri, 19 Jun 2020 18:42:41 +0200 (CEST)
Date:   Fri, 19 Jun 2020 18:42:41 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 0/2] SBS battery PEC support
Message-ID: <20200619164241.yuwiflgopyqocux6@earth.universe>
References: <CGME20200605230641eucas1p199386d808ad8ce83006092da23e48bb5@eucas1p1.samsung.com>
 <20200605230625.192427-1-sebastian.reichel@collabora.com>
 <be2a9fd5-9646-5e13-209a-6072a00d1b08@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mq7fdbym2zztfgad"
Content-Disposition: inline
In-Reply-To: <be2a9fd5-9646-5e13-209a-6072a00d1b08@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mq7fdbym2zztfgad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 08, 2020 at 08:23:05AM +0200, Marek Szyprowski wrote:
> Hi Sebastian,
>=20
> On 06.06.2020 01:06, Sebastian Reichel wrote:
> > Second try to enable PEC for SBS battery. Mainline currently
> > has 3 different platforms using sbs-battery with an I2C driver
> > not implementing I2C_M_RECV_LEN:
> >
> >   * i2c-exynos5
> >   * i2c-rk3x
> >   * i2c-tegra
> >
> > On those platforms PEC will be temporarly disabled for SBS
> > functions requesting strings. I considered moving the emulation
> > to I2C core, but it's specific to the SBS battery. The hack
> > only works because the strings are constant.
>=20
> Thanks for the update. Works fine on Samsung Exynos-based Chromebooks:=20
> Snow, Peach-Pit and Peach-Pi.
>=20
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, queued.

-- Sebastian

> > Changes since PATCHv1:
> >   * dropped all applied changes
> >   * rebased on top of power-supply's for-next branch
> >   * keep existing string reading method as fallback
> >
> > -- Sebastian
> >
> > Sebastian Reichel (2):
> >    power: supply: sbs-battery: use i2c_smbus_read_block_data()
> >    power: supply: sbs-battery: add PEC support"
> >
> >   drivers/power/supply/sbs-battery.c | 89 +++++++++++++++++++++++++++++-
> >   1 file changed, 87 insertions(+), 2 deletions(-)

--mq7fdbym2zztfgad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s6vQACgkQ2O7X88g7
+pps2BAAjWxgPSAyRL5qwOniGJbTCLlaIKJBJMivyNAxhw8TNK6tl8qDXa9KFDlW
TJ+U62PfqoPid1zXwnqao3HXm6ppaE3G0aiy1SqtTsHDcLFvlQiwRB7XgHAXYyol
5iYLbCrSv097WgeoqOMPAWiV0yXVDG7euZvxfONVpP6MfxoUy4Ddih70oxwYqt8m
J1IKIVWTm6MgPMYjvqknEMgN317232Er+X27xSlzDwDgZFiiQVv8YzZCok3X97Wf
ZfmgLZIgIVDc0CK+jMqnonw8bfuJO3K9vPA3FWnvIEEjoqIvt+9okTD5N1Uh4cVC
PG1orCBUHqbytdkWa+eFI6YOZXvDGutu9L7yC1LYJ/nZlGzMZHLPZVh5bNwR7/Oz
78sqpIdrFgOM5SExbMSmg1qUq2vdgDs+k5m5ED1NyQAQLx5ci0Mqhbx4CHTCB/C9
AMdveLwaEFiA9Q16jpJ/SD9Hz5XxGOMtB8fE0FVS9cSPGr3cFSDyx/siavGAg2+b
P6vph31EjXAGd9sgQVYkopCcgayAB82onY7+LljZN9+6vwP7mdeFiYF0UaXgrQXy
S0uHPXToc0Dd2q5UWM1rUbuNJmwEByWwLE8Ae5hdufg3UU/y61WEHYTPL4q7TL85
boemBk+UZuGk3dJVull1n80ADdPdzl0nC4aDzlROvj5YVO2Rp4k=
=AGyu
-----END PGP SIGNATURE-----

--mq7fdbym2zztfgad--
