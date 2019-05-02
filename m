Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AEF121D3
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfEBSWw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 14:22:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57862 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfEBSWw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 14:22:52 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A790E802ED; Thu,  2 May 2019 20:22:40 +0200 (CEST)
Date:   Thu, 2 May 2019 20:22:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Nikitas Angelinas <nikitas.angelinas@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Message-ID: <20190502182250.GA4845@amd>
References: <20190502074305.GA6039@vostro>
 <20190502101500.GA23980@amd>
 <20190502175958.GA14955@vostro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20190502175958.GA14955@vostro>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-02 10:59:58, Nikitas Angelinas wrote:
> On Thu, May 02, 2019 at 12:15:00PM +0200, Pavel Machek wrote:
> > On Thu 2019-05-02 00:43:05, Nikitas Angelinas wrote:
> > > There is no need to keep sysrq_poweroff_op after initialization, so m=
ark
> > > it with __initdata.
> >=20
> > Are you sure?
> >=20
> > pavel@duo:/data/l/k$ grep -ri sysrq_key_op . | grep initdata
> > pavel@duo:/data/l/k$
> >=20
> >=20
> > 									Pavel
> >=20
> I am sorry about this. I completely missed the point of registering this
> structure. Please ignore this patch.
>=20

Yup. You can have Acked-by: for the other parts.

									Pavel

> > > =20
> > > -static struct sysrq_key_op	sysrq_poweroff_op =3D {
> > > +static struct sysrq_key_op sysrq_poweroff_op __initdata =3D {
> > >  	.handler        =3D handle_poweroff,
> > >  	.help_msg       =3D "poweroff(o)",
> > >  	.action_msg     =3D "Power Off",
> >=20
> > --=20
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzLNXoACgkQMOfwapXb+vKmjgCgnFC4NkPKTlbkBpxuDlHQPYfp
TToAoKbW6WSTatCwlvhlp9pUbt/Obi4P
=kXiy
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
