Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8031C1B9C
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgEARYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728933AbgEARYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 13:24:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555DEC061A0C;
        Fri,  1 May 2020 10:24:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 19C612A2CCE
Received: by earth.universe (Postfix, from userid 1000)
        id C144B3C08C7; Fri,  1 May 2020 19:24:45 +0200 (CEST)
Date:   Fri, 1 May 2020 19:24:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [RESEND PATCH v5 0/3] BQ25150/155 Charger
Message-ID: <20200501172445.diiccfzbh7kzkxdl@earth.universe>
References: <20200304174025.31655-1-r-rivera-matos@ti.com>
 <eb5f0818-21c7-1b84-b0c9-904bce9721be@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3qxaeywejrfpsd4j"
Content-Disposition: inline
In-Reply-To: <eb5f0818-21c7-1b84-b0c9-904bce9721be@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3qxaeywejrfpsd4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I don't see any PATCHv5 (with or without RESEND) for bq25150 and
lore does not see anything either:

https://lore.kernel.org/linux-pm/?q=3DPATCH+v5+0%2F3%5D+BQ25150%2F155+Charg=
er

-- Sebastian

On Tue, Mar 24, 2020 at 10:14:20AM -0500, Ricardo Rivera-Matos wrote:
> bump
>=20
> On 3/4/20 11:40 AM, Ricardo Rivera-Matos wrote:
> > Hello,
> >=20
> > This v5 series picks up on the development that Dan Murphy
> > <dmurphy@ti.com> began with the power_supply framework and
> > bq2515x_charger driver. This series incorporates the changes
> > suggested by Sebastien Reichel <sre@kernel.org> in v4.
> >=20
> > Datasheets for these devices can be found at:
> > http://www.ti.com/lit/ds/symlink/bq25150.pdf
> > http://www.ti.com/lit/ds/symlink/bq25155.pdf
> >=20
> > Thanks, Ricardo
> >=20
> > Dan Murphy (1):
> >    power_supply: Add additional health properties to the header
> >=20
> > Ricardo Rivera-Matos (2):
> >    Add the bindings for the bq25150 and bq25155 500mA charging ICs from
> >      Texas Instruments.
> >    power: supply: bq25150 introduce the bq25150
> >=20
> >   Documentation/ABI/testing/sysfs-class-power   |    2 +-
> >   .../bindings/power/supply/bq2515x.yaml        |   99 ++
> >   drivers/power/supply/Kconfig                  |    8 +
> >   drivers/power/supply/Makefile                 |    1 +
> >   drivers/power/supply/bq2515x_charger.c        | 1170 +++++++++++++++++
> >   drivers/power/supply/power_supply_sysfs.c     |    2 +-
> >   include/linux/power_supply.h                  |    3 +
> >   7 files changed, 1283 insertions(+), 2 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/power/supply/bq2=
515x.yaml
> >   create mode 100644 drivers/power/supply/bq2515x_charger.c
> >=20

--3qxaeywejrfpsd4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sW1gACgkQ2O7X88g7
+po/SBAAnRpzJmKAuQqz96DkkraOu519lvxZyNn0zx9J6ETapkjL32Yf+/ibJrI9
4wG4ksu6ONcNFTrk82z4wZAL8hyzu2H+7NaXEKvtE2SaJpENgA5WSr8W8Df2n7TB
iuMjPeXeX1eSyIjquvt8pXI1NKXuBgfpp+wHBcYfn6gQ9DCkRLwrCvb8gCQYumCG
N4SS2Z8HZikrLXH3BCSCbZn7l0OY7ZWOunzP5xiyxzBzaWqxHIsT8HZUDqavAJF+
j7tG4t1KxBfkRNP2W3E7gV27/Sb/mtTaudjbCATOwuKWxX478pXLARv1ZOB3c2qq
kzy+W+HM4/apvzp0HraeNlGMm6Tk9q8iigP3clskrXT+bg01EEoRaKoi8YkR1SMp
KSsXcPHQeNSKMvrdBF7aI8OhI2ieFQf6kxnxx98IsIMjYk2DN3OvRBF8ZcjTPmMQ
QXQzSUjKQXIjA8x/cTLJ5eD0ueTnum5uSezjSvsveHc4/OLqItaHaYHvt5po76SX
D5g09hOVDUI6AoYobKplXhEWtN1irCFo1i9Np/zIpyNPIpCBT3neBjfskqn1aMX7
rndaSx+zVM6HIp28o00xGGAbGbFGu5jNTqMs5ZriREMe+259xYU1r4WWPtMKmbRZ
Gkqwc0IYM6sq6eiQzZOUWzEWhk9VLmMAmXedM0aD74DcZXfoIlM=
=NGH8
-----END PGP SIGNATURE-----

--3qxaeywejrfpsd4j--
