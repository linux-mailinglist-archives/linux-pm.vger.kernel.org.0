Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D97120E6A6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404143AbgF2VtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:49:20 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51886 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404340AbgF2VtF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 17:49:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D9FFE1C0C22; Mon, 29 Jun 2020 23:49:00 +0200 (CEST)
Date:   Mon, 29 Jun 2020 23:49:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, martin_rysavy@centrum.cz,
        linux-pm@vger.kernel.org
Subject: Re: [RFC] Limiting charge current on Droid 4 (and N900)
Message-ID: <20200629214900.GB26513@amd>
References: <20200615140557.GA22781@duo.ucw.cz>
 <23f924be-a0ee-8efa-d92c-da83700261da@wizzup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <23f924be-a0ee-8efa-d92c-da83700261da@wizzup.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Droid 4 has same problem as N900: it is often neccessary to manually
> > tweak current draw from USB, for example when using thin charging cable.
> >=20
> > N900 creates unique attribute by hand, but I believe
> > POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT looks suitable. (Should N900 be
> > converted?)
> >=20
> > Comments? Would the patch be acceptable after fixing whitespace?
>=20
> I'm not very knowledgeable on batteries - but the patch looks good to me.
>=20
> Could you perhaps explain what exactly this fixes? I've seen some
> interesting behaviour when plugging a Droid 4 into a PC (or wall
> charger, really): the led blinks for a few seconds until it
> stabilises.

With this patch, we'll limit charging to 0.5A by default, unless
overrident by user. So you should not see green LED blinking, unless
you manually select bigger current than charger can handle.

> And then there's the issue where, once the battery is full, it will
> switch between charging and discharging every few seconds/minutes.

This will definitely not help with this one.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl76YcwACgkQMOfwapXb+vLX6wCeJphl0Oi4AFWn9kxgBhOq9X31
wtwAoL3nHC9lc2nGxO6RSI3cXE/ZOYdJ
=KZon
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
