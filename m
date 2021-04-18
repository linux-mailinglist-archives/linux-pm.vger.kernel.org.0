Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55FA363466
	for <lists+linux-pm@lfdr.de>; Sun, 18 Apr 2021 11:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhDRJS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 05:18:57 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34860 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDRJS5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Apr 2021 05:18:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7A67F1C0B77; Sun, 18 Apr 2021 11:18:26 +0200 (CEST)
Date:   Sun, 18 Apr 2021 11:18:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Fricke <sebastian.fricke@posteo.net>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] base: power: runtime.c: Remove a unnecessary space
Message-ID: <20210418091825.GA17916@amd>
References: <20210418060800.8833-1-sebastian.fricke@posteo.net>
 <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
 <20210418091143.6h466qqd52uf766z@basti-TUXEDO-Book-XA1510>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20210418091143.6h466qqd52uf766z@basti-TUXEDO-Book-XA1510>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2021-04-18 09:11:43, Sebastian Fricke wrote:
> Hey Joe,
>=20
> On 18.04.2021 00:09, Joe Perches wrote:
> >On Sun, 2021-04-18 at 06:08 +0000, Sebastian Fricke wrote:
> >>Remove a redundant space to improve the quality of the comment.
> >
> >I think this patch is not useful.
> >
> >It's not redundant.
>=20
> Thank you, I actually found this pattern a few more times but I wanted
> to check first if this is a mistake or chosen consciously.

It is okay as it is. No need to remove extra space. No need to add it,
either.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmB7+WEACgkQMOfwapXb+vI7OwCdGn+7wHfkeIhYQVDKlMJtnKQn
X7QAn25n1NbnYA4mLreOlYmlD3RsJbRt
=Ymvk
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
