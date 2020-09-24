Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86CA277080
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgIXMAo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:00:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35190 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgIXMAo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 08:00:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F2AD51C0BCB; Thu, 24 Sep 2020 14:00:41 +0200 (CEST)
Date:   Thu, 24 Sep 2020 14:00:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] leds: Add driver for Acer Iconia Tab A500
Message-ID: <20200924120041.GB3933@duo.ucw.cz>
References: <20200906195103.1347-1-digetx@gmail.com>
 <20200906195103.1347-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20200906195103.1347-5-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-09-06 22:51:02, Dmitry Osipenko wrote:
> Acer Iconia Tab A500 is an Android tablet device which has two LEDs
> embedded into the Power Button. Orange LED indicates "battery charging"
> status and white LED indicates "wake-up/charge-done" status. The new LED
> driver provides control over both LEDs to userspace.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Thanks, applied.

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2yKaQAKCRAw5/Bqldv6
8h7KAJ9RHZ0L+HYBj60LPGu9PNZjMYFyOwCffFDh8TOvkbAqDobirABHaaRTQ9w=
=6kM8
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
