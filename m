Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80DA36A9C4
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhDYWy1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Apr 2021 18:54:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59284 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhDYWy1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Apr 2021 18:54:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 336471C0B77; Mon, 26 Apr 2021 00:53:46 +0200 (CEST)
Date:   Mon, 26 Apr 2021 00:53:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PM: runtime: document common mistake with
 pm_runtime_get_sync()
Message-ID: <20210425225345.GN10996@amd>
References: <20210422164606.68231-1-krzysztof.kozlowski@canonical.com>
 <CAJZ5v0iUQBfrTtVmfrrDixZnnr1_THgaM1+mFu4TRT+OOYb2mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ggdAeHltlv4tpqCr"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iUQBfrTtVmfrrDixZnnr1_THgaM1+mFu4TRT+OOYb2mw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ggdAeHltlv4tpqCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> However, if the code wants to check the return value, that is:
>=20
> error =3D pm_runtime_resume_and_get(dev);
> if (error)
>         return error;

Well, we mostly expect people to check error values, and the "continue
on error" case seems to be pretty unusual and mostly result of
oversight.

Quite large percentage of -stable patches is fixes after people got
confused with unusual interface...

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--ggdAeHltlv4tpqCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCF8vgACgkQMOfwapXb+vJtVgCfUaLgQYF4oSk4oE+mS8CTACET
a1UAoIvVgBFy1hFvUbJVrwoofZ1NEA0D
=xDKw
-----END PGP SIGNATURE-----

--ggdAeHltlv4tpqCr--
