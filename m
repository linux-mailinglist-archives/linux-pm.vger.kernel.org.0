Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549F42823AF
	for <lists+linux-pm@lfdr.de>; Sat,  3 Oct 2020 12:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgJCKs0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Oct 2020 06:48:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJCKsZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Oct 2020 06:48:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 61CE829D0C7
Received: by earth.universe (Postfix, from userid 1000)
        id 433743C0C84; Sat,  3 Oct 2020 12:48:21 +0200 (CEST)
Date:   Sat, 3 Oct 2020 12:48:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1] power: supply: document current direction
Message-ID: <20201003104821.oduzfpxbw23b4fcz@earth.universe>
References: <20200827140248.37749-1-sebastian.reichel@collabora.com>
 <20201002182303.51db1289@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tut7zgjl6z4grit4"
Content-Disposition: inline
In-Reply-To: <20201002182303.51db1289@aktux>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tut7zgjl6z4grit4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 02, 2020 at 06:23:03PM +0200, Andreas Kemnade wrote:
> On Thu, 27 Aug 2020 16:02:48 +0200
> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
>=20
> > Currently the sign for CURRENT_NOW and CURRENT_AVG is a bit
> > of a mess. There are basically 3 different ways battery fuel
> > gauges report the current:
> >=20
> > 1. uses negative values for discharging and positive values
> >    for charging
> > 2. uses positive values for discharging and negative values
> >    for discharging (opposit of 1)
> > 3. only uses positive values
> >=20
> > As a result userspace currently cannot use the sign at all in
> > a generic way. Let's solve the issue by documenting a canonical
> > way for reporting the data and ensure new drivers follow this
> > way. Then existing drivers can be fixed on a case-by-case basis.
> >=20
> > The 'negative value =3D battery discharging' has been choosen,
> > since there are only very few drivers doing it the other way
> > around.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
>=20
> would be nice if this comes in, so that is it clearly specified.

Ack, I'm a bit late picking up patches this merge window due to a
vacation. This has been queued now.

-- Sebastian

--tut7zgjl6z4grit4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl94Vu8ACgkQ2O7X88g7
+ppLfw//axQg30mpwaFeoG1ILvanxIQOc96J9leo41XLs8N2xNNYak4Nry9OS0ET
G7P1wmo22Y9HdwbvzKV3t5sMKc3d2gswhd+CnjM8FbrbTd4iI6JQv4G38gRPcqPK
HUA/NWmLRHakRb70AgsuJBMR6JIhSBNWt54CfjXk/GsrJ3hpwApgKGPRK2oQ2oHd
VTXMOKzqhV3J47NY4d2Xn0jWPDY6Kjm5xuevOhAH6XNKyYZMScifQIItVBTOXnX/
sh960fhph6Mh50KhztJQaqWEusCi99m7WPxyvdNwte2UEPLnMUG7d31b0hIo/k7k
qYoy4soOD8FR3wIRRcbwS+SFhztaM//4jqN0YcIL9HQAyxWQsbEngVP67SVVwOEA
UvS2vPunFwHrvWDR1eWMLNf/pX0s7ov5BZ7H7p+5JGqV9r81DHM86NxLUF5bz+p+
ggzM6ZyAxGh0XnVki10J7VUIIFxMirwEZYO/7IMPI2DZmOuduQ/IyHErAlxjpBCQ
K+AecAV4qTdXqSZ0qaV26bSN67+GDWk7MkQIlyStDI5x6l727MSk0TzRjH9dpYJ4
uDdqmlFCyriNolOvdESnsf5B8Wa321RCLwXLA5OJ2NIXqWsoe4PAZasAqneicnvQ
WUSiWhVxzGlOnahDfI8/a5lsT/vzbx8xStTLPGmV4jcMGnXuOW4=
=vsSI
-----END PGP SIGNATURE-----

--tut7zgjl6z4grit4--
