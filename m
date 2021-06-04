Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0563D39B72F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFDKgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 06:36:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33610 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhFDKgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:36:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1A6D51F43871
Received: by earth.universe (Postfix, from userid 1000)
        id 6CE733C0C95; Fri,  4 Jun 2021 12:34:58 +0200 (CEST)
Date:   Fri, 4 Jun 2021 12:34:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/3] Fix RT5033 battery device tree probing
Message-ID: <20210604103458.bb6niqmuflgh6vkq@earth.universe>
References: <20210517105113.240379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qpaey6c4rosasac"
Content-Disposition: inline
In-Reply-To: <20210517105113.240379-1-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7qpaey6c4rosasac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 17, 2021 at 12:51:10PM +0200, Stephan Gerhold wrote:
> At the moment, the RT5033 MFD and battery driver suggest that the
> battery driver should probe as a sub-device of the MFD driver. However,
> this does not make any sense since the fuel gauge part of RT5033 has its
> own I2C device and interrupt line.
>=20
> It was also documented as separate I2C device in the original device
> tree bindings [1] (that were never finished up and merged) but for some
> reason the code does not match the documentation (and reality). :/
>=20
> Given other fairly critical mistakes like setting the wrong bits
> in the regulator driver (see [2]), unfortunately I get the feeling
> that none of the RT5033 drivers were ever tested properly. :(
>=20
> This patch sets adds a proper of_match_table to rt5033-battery
> and removes the rt5033-battery sub-device from the MFD driver.
> There is no compile/runtime dependency of the power supply / MFD patch
> so they can just be applied separately through the power supply / MFD tre=
e.

Thanks, I queued patches 1&2 to power-supply's for-next branch
and ignored patch 3.

-- Sebastian

> With these changes, rt5033-battery seems to work fine on the
> Samsung Galaxy A5 (2015) at least (it reports a reasonable
> battery percentage).
>=20
> [1]: https://lore.kernel.org/linux-pm/1425864191-4121-3-git-send-email-be=
omho.seo@samsung.com/
> [2]: https://lore.kernel.org/lkml/20201110130047.8097-1-michael.srba@sezn=
am.cz/
>=20
> Changes in v2: Fix stupid typo in second patch :(
> v1: Honestly, not worth looking at :)
>=20
> Stephan Gerhold (3):
>   dt-bindings: power: supply: Add DT schema for richtek,rt5033-battery
>   power: supply: rt5033_battery: Fix device tree enumeration
>   mfd: rt5033: Drop rt5033-battery sub-device
>=20
>  .../power/supply/richtek,rt5033-battery.yaml  | 54 +++++++++++++++++++
>  drivers/mfd/rt5033.c                          |  3 --
>  drivers/power/supply/Kconfig                  |  3 +-
>  drivers/power/supply/rt5033_battery.c         |  7 +++
>  4 files changed, 63 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/richte=
k,rt5033-battery.yaml
>=20
> --=20
> 2.31.1
>=20

--7qpaey6c4rosasac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6AckACgkQ2O7X88g7
+prOSg//QRnXNFYXcAz50rTV4DV/Q6evnwV92ekn8gUnkCO4WkgM8oyW4ijP2CUo
9J3Lpu9jrabPyP6wT1xDV0GurQoAsuB5WEYwuGbByLkur3yZyB+gXMCsaN9OpTwm
eIQ5+LheWY4gQEIzO4ry3eCqe6VU2hQN+vdrz3KEp2wnZ34D+KYBENIY3lejDkkx
Vr7hhSj/N6+bgjn/KJFmEASUoIuFWphYfG4dBPAlRyslhFsLxTiIiKKAdvvfIlpN
RVH5SU19oPtcagQWpKvkLKg16u/U5lIBpbh9r7RML0armDsYxeGiOAs59njEnx5+
G7NRg916LJIV/MyVrJvnx9PAzxtO7sW2iIEtLdxdxHrqHuzSyGnwuBcaWyqLraxd
3L6wVS94HnKNl4zphLiTkF8cvdGphEL1BMKaCBnBEEcqESC7sLNZD+EUnYmsSBob
/muKm5fWU16yixrS3wDHgR8VxkVqa9istOEIf5gioKxaV5H+rWik98pjpHAXG9Lv
zIpmWB09ufkHNq3Y7law4qPrqfnf/Oo4dOrQFJmAno+PgCxMChUZ0tytwfWvx3Pr
JU2+nl7ff1Br17eLkjyMVZx9zhUMo1RI3SrsVQK/KZ91sZqCSfx3IGjMKHfBgPpd
evona00fQ4Hnq5wxajKMoeAjWenQ/17CdwLCo+XJunzW6PILS1Q=
=Bv8O
-----END PGP SIGNATURE-----

--7qpaey6c4rosasac--
