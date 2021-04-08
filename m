Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F187E358363
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 14:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDHMih (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDHMih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 08:38:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8DC061760;
        Thu,  8 Apr 2021 05:38:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 284E81F45CCB
Received: by earth.universe (Postfix, from userid 1000)
        id 278893C0C96; Thu,  8 Apr 2021 14:38:23 +0200 (CEST)
Date:   Thu, 8 Apr 2021 14:38:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] power: supply: Add battery and AC drivers for
 Surface devices
Message-ID: <20210408123823.7nalqvovdpcstus6@earth.universe>
References: <20210405234126.667532-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7pabjv4il66igsp"
Content-Disposition: inline
In-Reply-To: <20210405234126.667532-1-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p7pabjv4il66igsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 06, 2021 at 01:41:24AM +0200, Maximilian Luz wrote:
> This series provides battery and AC drivers for Microsoft Surface
> devices, where this information is provided via an embedded controller
> (the Surface System Aggregator Module, SSAM) instead of the usual ACPI
> interface.
>=20
> Specifically, 7th generation Surface devices, i.e. Surface Pro 7,
> Surface Book 3, Surface Laptop 3, as well as the Surface Laptop Go use
> this new interface.
>=20
> Note: This series depends on the
>=20
>     platform/surface: Add Surface Aggregator device registry
>=20
> series. More specifically patch
>=20
>     platform/surface: Set up Surface Aggregator device registry
>=20
> The full series has been merged into the for-next branch of the
> platform-drivers-x86 tree and is available as immutable tag at
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git tags/platform-drivers-x86-surface-aggregator-v5.13-1
>=20
> Maximilian Luz (2):
>   power: supply: Add battery driver for Surface Aggregator Module
>   power: supply: Add AC driver for Surface Aggregator Module
>=20
>  .../ABI/testing/sysfs-class-power-surface     |  15 +
>  MAINTAINERS                                   |   8 +
>  drivers/power/supply/Kconfig                  |  32 +
>  drivers/power/supply/Makefile                 |   2 +
>  drivers/power/supply/surface_battery.c        | 865 ++++++++++++++++++
>  drivers/power/supply/surface_charger.c        | 282 ++++++
>  6 files changed, 1204 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-surface
>  create mode 100644 drivers/power/supply/surface_battery.c
>  create mode 100644 drivers/power/supply/surface_charger.c

Thanks, queued to power-supply's for-next branch using referenced
immutable tag.

-- Sebastian

--p7pabjv4il66igsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBu+TUACgkQ2O7X88g7
+pqygg/9GaP62jyA8PNx13tInbbD7/OV/LnuKAMfTmFEnYrF24qKY7v5VFG+SD0b
3yCjMXsQ4Q5KwAJXICIPy7Rv+dts0ehNdkSWsBTRbyZ7Mb8iABI2o+ivxaNv3ldl
ixKkpbw8xsru6gnaNpxD4OAxd1sFZYs1wDAPnt4l0YOGog5olASEyfg5H4aGtE08
Hcjl/klU75zi7gnA3iJov2S6EWW4WF9T0uuB6mf4vf8mpp79eAL8gS2Kc3i3HVj7
j0I5VfCXbsg2zhPEN6jYPqR+fuwfX9dTCGg5Sy41s8ow3zY+Hi/ggU1/v4OBDaCb
K7bJTVS48NMCsZmT0P3XG3WpsBJTp3fqJQCmNKhzV/b0B/QKjN9766754Y5p1saS
x3iY9nX/aFh98bv6BZO7nEIEkC1vKHtkAmd26aD95mMClokwlbkwOFarrdNeihaV
lxkI5SeEQItRtepQwqeToG1611XieHAIPVnFRUXN/J8f2dQ5QmFI6fHqGVCqIMiN
cX1Nu6YV7bUCLFr/QXcFd0URx7pJle7ks+kIusgxYDJ5hP20TNz+antcOiUh0wb+
nhWklUn6Z7zRNd1cwB29k+EwSCHpyNEOEk4cW1FyNlqvmdtQBbqOpH+tqJiRUjdR
BmucCxR/gG2G9NQSaPUaNXW0EWj+fo/LaiHqVJzjMaKV3rQV/0I=
=q9+w
-----END PGP SIGNATURE-----

--p7pabjv4il66igsp--
