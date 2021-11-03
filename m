Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725A14441B4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 13:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKCMn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 08:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231411AbhKCMn0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 08:43:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FE0261175;
        Wed,  3 Nov 2021 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635943249;
        bh=PfdPMn8THwD7MPJd6FdRC7fBH8LHeMi65GkAkDFNsfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8S+PefzJQlycoyB+Dlj67jn06Xp3gB1Do50lo0D8Xuz8mut29MJYdGQhBZUYBhpG
         8QU+ZUrD836+V0G1QeBs8oo9qWhMIPI5W1qYbo2ezaVFINbPsnsIUMivqF7F8y1YZe
         5my9jiRUgcCdT53sxuRib06f8nx5kjHSqz1XEdn+TMoCGKTQnFRDjU153tq+YrMyto
         0cKcFVUmrt/SDBorQ+ZghEefwzkaOCy2jVVwZwySbh80MGNzbab9xtXVM+7bU/y/QT
         g0g4XUFFuSuBeo7a0kpC5R4g9amxnCpF/ReGfZjt8h3WHaj8Z2BUG516FchVUaKdks
         LF4f9jKzIG6mQ==
Received: by earth.universe (Postfix, from userid 1000)
        id EA6443C0F95; Wed,  3 Nov 2021 13:40:46 +0100 (CET)
Date:   Wed, 3 Nov 2021 13:40:46 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Burton <paul.burton@mips.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/9] Remove unused headers <linux/jz4740-adc.h> and
 <linux/power/jz4740-battery.h>
Message-ID: <20211103124046.te5rfhfvkbw2tby3@earth.universe>
References: <20211102220203.940290-1-corbet@lwn.net>
 <20211102220203.940290-2-corbet@lwn.net>
 <YYI9t2Ng1Uppkiav@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="an6co72dydfgj767"
Content-Disposition: inline
In-Reply-To: <YYI9t2Ng1Uppkiav@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--an6co72dydfgj767
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 03, 2021 at 07:43:51AM +0000, Lee Jones wrote:
> On Tue, 02 Nov 2021, Jonathan Corbet wrote:
> > Commit ff71266aa490 ("mfd: Drop obsolete JZ4740 driver") removed the la=
st
> > file to include <linux/jz4740-adc.h> but left the header file itself
> > behind.  Nothing uses it, remove it now.
> >=20
> > Similarly, aea12071d6fc ("power/supply: Drop obsolete JZ4740 driver")
> > deleted the last use of <linux/power/jz4740-battery.h>, so remove that =
one
> > too.

Thanks for the cleanup Jonathan.

> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > ---
> >  include/linux/jz4740-adc.h           | 33 ----------------------------
> >  include/linux/power/jz4740-battery.h | 15 -------------
>=20
> It appears as though there are still references to both of these
> *devices* in the kernel tree.  Should those be removed also?
>=20
> >  2 files changed, 48 deletions(-)
> >  delete mode 100644 include/linux/jz4740-adc.h
> >  delete mode 100644 include/linux/power/jz4740-battery.h
>=20
> Patch looks fine though.
>=20
> Let me know if you want me to take it in via MFD.  Otherwise:
>=20
> Acked-by: Lee Jones <lee.jones@linaro.org>

You can take it through MFD, no immutable branch needed.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--an6co72dydfgj767
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGCg0sACgkQ2O7X88g7
+pqdJw//XJ5guSGnd/+nBuxlcgnDWIw4e+/DCoEFHKG+jrPAEwxU/BzAxq2iMdZy
vstTfiEobkL36pWJW+OKB1uM5ZlBp657Z2gOFC0XAZdqMGniNfLL0/rTFBIkBVWj
uiHQwd4EHhvK0QScJKRC5wKAgDt2/MQ+kRqhBc+lXufxqoTNoKRFzMIAn3iZgtKz
JmUt7+ZZf+rO5uHpCjVW4/0Nl4UnHY6qKBnIfkVFIJGFw1W+QxynFZkZ5sHdPJDR
LGBZPNuzCIFROeXldT4N0x/dcRPQWq9Hw8cLRQISLxEGyKHLEHC89fZJffv0w/BN
2T1YrqgXLCK+R+D9I7n85LJWdkNMk0YXqWyTLBdoad3XGYt4Yg93u7XgZJf5+kyU
RDrO+VWW7ft1g/+A4cmZHc/0NavJplW3fETuXX0/1raJYGtN0YDyaoYYTQJQRqbJ
7zo/7oF7D8rAPcc5Ky2WNyrcyw4dCSBgdeny6HEYAdU9P2PBAF6iBprtRU0M07zl
zx4UDWEqycwmT9+dVhNx78ypRpTsd8apGxq4LgmnN7Uyb5liL1BM4P9NljR39cS8
aZ+4TFsNFNmG8maKe+uq8ZX9gffR5U9oOxF6sheA0864rk6xDPSjCkLrWh1Ode5M
6+GZN8d+ghNT/7AdqtLm5Vqk8umK/7UMERdUAT5Dx5grXF9r5M8=
=vzYR
-----END PGP SIGNATURE-----

--an6co72dydfgj767--
