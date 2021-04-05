Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E27E354503
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhDEQOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhDEQOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 12:14:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE9C061788;
        Mon,  5 Apr 2021 09:14:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B47591F44A08
Received: by earth.universe (Postfix, from userid 1000)
        id 40B3B3C0C96; Mon,  5 Apr 2021 18:14:44 +0200 (CEST)
Date:   Mon, 5 Apr 2021 18:14:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Immutable branch between MFD and Power due for the
 v5.13 merge window
Message-ID: <20210405161444.adgoalifr4cl23wx@earth.universe>
References: <20210312083604.3708890-1-linus.walleij@linaro.org>
 <20210323085748.GH2916463@dell>
 <CACRpkdYK4m_zsa_FMYDOpYaBLPsWk=DG-V3yeOhq4hdBp4prwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iieyb7z3wubg5mkx"
Content-Disposition: inline
In-Reply-To: <CACRpkdYK4m_zsa_FMYDOpYaBLPsWk=DG-V3yeOhq4hdBp4prwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iieyb7z3wubg5mkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 23, 2021 at 10:11:18AM +0100, Linus Walleij wrote:
> On Tue, Mar 23, 2021 at 9:57 AM Lee Jones <lee.jones@linaro.org> wrote:
>=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-powe=
r-v5.13
>=20
> Thanks so much for fixing this Lee!
>=20
> Sebastian: if you decide to pull this in I can iterate some more
> patches to the AB8500 BM code this merge window, else I will
> just defer to after v5.13-rc1.

I pulled this in, but it's probably too late for 5.13 now. But it
means you do not need to wait before (re)sending the remaining
patches.

Thanks,

-- Sebastian

--iieyb7z3wubg5mkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBrN3MACgkQ2O7X88g7
+ppnXQ/8DaArE0bE2zKYmxgYDMzY/S6Ylwi0D3gDBbVS8kYnJ5hUUELbNgEUlzah
yNyrFfAG591fBhD/WD4FV+dT9dkGHV094CgWHEuxeK6QYUzH9SY08oWAxkuDvnV1
fZTc8RqTuAfnWddkpiIplzkfM87wWjrR9loEIqkq6bvh6hOZQzpE7dPwLj4PhNbh
kVGfkmqYrT6LNWY7WJdTTg6WZVsZtMGbJZgxPmQLbUwzyyvL17r9KX/Kooq64n3h
+dCWHTAPEC8Fm1z9l6w5oJxrM++cod8pUCwraKAF1fISoxTgj+HZphaWj9sJUcc1
51N355UYTl/6BNYhb1JHMMEEW4aVOliwt1/V1kM781fvTG3bYXUONT9NstNaqacv
8h+D9iHQ9UfS+WNIbSaaTKDkQyQeCKTnzd2xjhoN+H2jPe7Y4ac5P5w8um98lmi8
VH/QYUW915RJ6+p/+oveEvQkyDFgTiyU3aBUNqYifP1LkWscMdj6Bgoe1ZxNtapZ
BPPRDmVTqfky/Fgcju50CT0Wv/mbcLzvvdIYltg2l0BDry+BA/Jw6KrGBU7kC8+t
8VdN/AbO+0Cse6a8IsoUlDsHwbFjx6B4LUourYY++P8ZECL1lqDXTCazr7gyyL8j
41Ogi1pZbzAJGG7pD4eTWNgsAFT8jWIckOL9cUbjlC7Q5Lqge78=
=ohxa
-----END PGP SIGNATURE-----

--iieyb7z3wubg5mkx--
