Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E585858B3A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 21:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF0T4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 15:56:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51954 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF0T4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 15:56:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9E0AD80630; Thu, 27 Jun 2019 21:55:57 +0200 (CEST)
Date:   Thu, 27 Jun 2019 21:56:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 43/87] kernel: power: replace kmalloc and memset with
 kzalloc
Message-ID: <20190627195607.GA17039@amd>
References: <20190627174048.4234-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20190627174048.4234-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-06-28 01:40:48, Fuqian Huang wrote:
> kmalloc + memset(0) -> kzalloc
>=20
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -974,12 +974,11 @@ static int get_swap_reader(struct swap_map_handle *=
handle,
>  	last =3D handle->maps =3D NULL;
>  	offset =3D swsusp_header->image;
>  	while (offset) {
> -		tmp =3D kmalloc(sizeof(*handle->maps), GFP_KERNEL);
> +		tmp =3D kzalloc(sizeof(*handle->maps), GFP_KERNEL);
>  		if (!tmp) {
>  			release_swap_reader(handle);
>  			return -ENOMEM;
>  		}
> -		memset(tmp, 0, sizeof(*tmp));
>  		if (!handle->maps)
>  			handle->maps =3D tmp;
>  		if (last)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0VH1cACgkQMOfwapXb+vIlngCeJlrsuDhKQNw+wuy3UkcNZ1rC
9TYAoJLkmfehGUQQC2xIqPXa/zsPYkyS
=oZW7
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
