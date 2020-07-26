Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3C22E320
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 00:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGZWaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jul 2020 18:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgGZWaL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Jul 2020 18:30:11 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665A9206E3;
        Sun, 26 Jul 2020 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595802610;
        bh=MJP0Jf9hKksltsWYsFTa3DOF0LkQ5HhAhLZwYMhd2Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUKhHbAQ1l1sYpoRtEdqCmcjDjOLcwObwRPkskL4+SalwjYP2/NDkPgNtlsMkLxGL
         ImabpjOa1IvxrOIzB7cfMYybTJ8o8vpGEwpERgbGJSRj4HPZHG2P32AuASKM8vbLX3
         0ylM4f4HUGLh8TWcSWrMo+4GeUCqOt4cvLaarUUs=
Received: by earth.universe (Postfix, from userid 1000)
        id 767B63C0B87; Mon, 27 Jul 2020 00:30:08 +0200 (CEST)
Date:   Mon, 27 Jul 2020 00:30:08 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: fix duplicated words in bq2415x_charger.h
Message-ID: <20200726223008.jlhcjrzwdjvmwavn@earth.universe>
References: <74a380ee-d0a7-a58b-5740-6f1049d05d76@infradead.org>
 <20200716083116.oqio4clyotjqy5vw@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tns4w7sqgcvdmy6"
Content-Disposition: inline
In-Reply-To: <20200716083116.oqio4clyotjqy5vw@pali>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7tns4w7sqgcvdmy6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 16, 2020 at 10:31:16AM +0200, Pali Roh=E1r wrote:
> On Wednesday 15 July 2020 18:30:01 Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >=20
> > Drop the doubled word "for".
> > Change "It it" to "If it".
> >=20
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Pali Roh=E1r <pali@kernel.org>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-pm@vger.kernel.org
>=20
> Thanks!
>=20
> Acked-by: Pali Roh=E1r <pali@kernel.org>

Thanks, queued.

-- Sebastian

>=20
> > ---
> >  include/linux/power/bq2415x_charger.h |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > --- linux-next-20200714.orig/include/linux/power/bq2415x_charger.h
> > +++ linux-next-20200714/include/linux/power/bq2415x_charger.h
> > @@ -14,8 +14,8 @@
> >   * value is -1 then default chip value (specified in datasheet) will be
> >   * used.
> >   *
> > - * Value resistor_sense is needed for for configuring charge and
> > - * termination current. It it is less or equal to zero, configuring ch=
arge
> > + * Value resistor_sense is needed for configuring charge and
> > + * termination current. If it is less or equal to zero, configuring ch=
arge
> >   * and termination current will not be possible.
> >   *
> >   * For automode support is needed to provide name of power supply devi=
ce
> >=20

--7tns4w7sqgcvdmy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8eA+0ACgkQ2O7X88g7
+po1RhAAqMX5YDJYQMKcmCeYaCmwru0utzJjSfR1H6rSekotf+pkWpw84FB3VwqR
mfLYbZZAQM7pazJAOAEKinHFkoO21dWBpiPJCC0Mje+SYHMSn/Dgjc9X9o+Z6E4S
FjLxRCTz6JfRhPpu9o2xB3UfGWiDdEHgHY/oEIftmni7P7b9JH4+mrvg6//9OTXk
ALY3lywv59kkgbzg7trkX2VM5maAQ4p/0GiUo/jKaWq5WCZDPB96Qu7MEHpWgzS0
J6F8knhs5WRF57l42W5LJNTukv0JFj8ZIghAFjgT0Q/5+PhB/GudBmDC68xoT0CC
nCLEUH/ordyXdTM2HZ2gHXkLwEvytuFjCrh5WToiW5Mu4AXzi1CshQNNfQzMUdos
jUVsaBmGvWVd8xxjH7otDW5VR9u/K5UIkrRIroGBYS/ItsK3rPeBc7NPzsJboizd
bwQ1YaQv3dS7SWloJGKyUF28ojpl5MQ4BKROTpaiSlsvhYFmah/kXp5yWWC0dpP2
XnZp6Jd1bGy+qMpdiuL3Q9MOZgi1P0DpkTHcPLtJuGszcoqozNUmx1BaZ+KHjhJN
AIT8cPEwrvOFl+dVHOVErEd8OsbYopWuA7Yqud7jK6+TWZejzSwkTmCBuDyEVHcR
ZHo4Upnq4e0ZtLdCeLWHHb4l/kcAeTpazex2vWL6lMCM5eK7NMA=
=e06k
-----END PGP SIGNATURE-----

--7tns4w7sqgcvdmy6--
