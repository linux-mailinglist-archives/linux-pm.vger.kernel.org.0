Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E73354113
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbhDEKHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhDEKHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 06:07:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319CC061756;
        Mon,  5 Apr 2021 03:07:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BDAB11F4449C
Received: by earth.universe (Postfix, from userid 1000)
        id 3B5A43C0C96; Mon,  5 Apr 2021 12:06:56 +0200 (CEST)
Date:   Mon, 5 Apr 2021 12:06:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Czerski <ma.czerski@gmail.com>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] power: reset: ltc2952: make trigger delay configurable
Message-ID: <20210405100656.xphmgza4jurxcs2q@earth.universe>
References: <20210203214900.71677-1-ma.czerski@gmail.com>
 <20210210220413.GA2878331@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uymfseyv447fvjcc"
Content-Disposition: inline
In-Reply-To: <20210210220413.GA2878331@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uymfseyv447fvjcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 10, 2021 at 04:04:13PM -0600, Rob Herring wrote:
> On Wed, 03 Feb 2021 22:49:00 +0100, Marek Czerski wrote:
> > Make trigger delay configurable through device tree with
> > trigger-delay-ms property.
> >=20
> > Trigger delay is the time to wait before starting shutdown
> > sequence after trigger line assertion.
> > Trigger delay must take into account the OFFT time configured
> > with the capacitor connected to OFFT pin of the LTC2952 chip.
> > Basically, the higher the capacitance connected to OFFT pin,
> > the larger trigger delay must be.
> >=20
> > Signed-off-by: Marek Czerski <ma.czerski@gmail.com>
> > ---
> >  .../devicetree/bindings/power/reset/ltc2952-poweroff.txt  | 4 ++++
> >  drivers/power/reset/ltc2952-poweroff.c                    | 8 ++++++++
> >  2 files changed, 12 insertions(+)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--uymfseyv447fvjcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBq4UAACgkQ2O7X88g7
+popgw/9GcGIK8qgWXxvNtHh3YVOonZvs+Rf9UlBY1+pWUXsQQUIPTtDymT5Uzzj
9gGenw+vaNeM9JwKTHbhDa/0j8MGcjEDg4LOABNeOazM+2HZuWbQhDAsjtaWL6Ni
27NyF3nMIWZBeO/D948RPSFUVBgC+y3DXhgqNAozUsUN0RlZ0df/2O/ikKNt6MUu
eo/n3AfFuqh6feTDudzoyW6ngeoCOTLW7z+xqCQWLHg5eaARIwg2yL1qyzqP1Vcn
qivo1pE422zwU2/NTBaqN5r8lurvDrW5fDQGss77s1treoAY6IOGg7dhnf5yVFUF
+qw5SgrYIP3GddCHLTS35m3IfSJ4+tbKhdMvG+QUzHYK4gToS/J5CdezfVXqXNO/
LmlJtuO5301V91qddd6uISOeUWQerpvxh6Va0LWAJcssEYsXb/esX/o4uqmhRsQR
BIxrfPaIdQDBLoe0p0+Fs/7hCgggnrT3N9FzAB1X1lOpXSQz2QSt25pA3cCNQk3c
WbMn3j61MiEa7J3ko/UDV1rXutxbGpycci+YWc003sUpV5lYBBIccs/Fj7h3xfxE
QY6ynlGJLFuvL1gIpBqXiZE0rLlxk9zN9WoApBHrIx7Lp+iCiAfUYydWa4Mpwtn0
xU+eUuebHx6a7FvWAaSAaKQRbAhyaZA+SGMeP6A1G/eUKJQ4lbs=
=UvUo
-----END PGP SIGNATURE-----

--uymfseyv447fvjcc--
