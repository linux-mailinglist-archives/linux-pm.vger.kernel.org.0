Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09663F31CF
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhHTQ7w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 12:59:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhHTQ7w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Aug 2021 12:59:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 869B91F4489C
Received: by earth.universe (Postfix, from userid 1000)
        id A945F3C0C98; Fri, 20 Aug 2021 18:59:11 +0200 (CEST)
Date:   Fri, 20 Aug 2021 18:59:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] power: supply: core: Fix parsing of battery
 chemistry/technology
Message-ID: <20210820165911.ecpgxfhxyyhemnwo@earth.universe>
References: <20210819235111.25357-1-digetx@gmail.com>
 <CACRpkda=hcw5dN8TfV01egb4_fzSi3kNOCz1UguYcKyQKDW9mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3f4ojlolkkyg7fff"
Content-Disposition: inline
In-Reply-To: <CACRpkda=hcw5dN8TfV01egb4_fzSi3kNOCz1UguYcKyQKDW9mA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3f4ojlolkkyg7fff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 20, 2021 at 03:41:56PM +0200, Linus Walleij wrote:
> On Fri, Aug 20, 2021 at 1:51 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>=20
> > The power_supply_get_battery_info() fails if device-chemistry property
> > is missing in a device-tree because error variable is propagated to the
> > final return of the function, fix it.
> >
> > Fixes: 4eef766b7d4d ("power: supply: core: Parse battery chemistry/tech=
nology")
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>=20
> Oops,
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued.

-- Sebastian

--3f4ojlolkkyg7fff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEf308ACgkQ2O7X88g7
+poS1Q//ZI+PmHqDuWeotKFoAKYjxxcTgqJeDe3MwFXGh15cdVXMjXxt4Hmh/UAS
wRQVr8TkHSAeTpcpf0zuUxoXguqN8pdX0v5fiGe7ZY9Th1/EyY6V04R1uRYvRvIt
jySe6Qvm+Lqd1NV2CyQ2pML4+uAClP42DLWlSYRwgVucSlHk+i2+uOCIb0sn5En9
y4psP7+OpiNZIFbkeQZ0LF+mhRg9whkTP5NEmqCVnDeaeIEEpcsx24ymrmjOfxmX
iIn+kbeYLhJU8RZKlph9tb2jGNKxhoaGybSLvitehs8d12WnyXPlrQ25Ue+FkRNV
PFMP5s8q1dT90fAoEP8YDNf/tr4/Iy98PRYRuDtKSdbb0sm3oy3UiHc5fU8QBml4
ky00Z3gtfGNQHoeNwepHNoqHaofRku2vnfuXJbArwX+j3glLqqFupaQ4NJ3YdQfO
uz09yJfc2aFrC0VW/vmeJZa8JPkSeV7iype2Btl6NvhumXYd5Bn4ZkZWH2YDp363
3eVRb8v/PMyI1alqQcPgdqk1Y1rzLaddBj1My1u+NIGOocnbEPEDdE1YQMiu7K0F
a5IAFR32crLCqjAIsJLcsZ4ysUW++SYC168qsFl47RwPRJ/qM5Qu/+1rBJaEYv9A
Siux44wn+5ZM6zJcPOY+v0dq7Vx11n7+R5GII51iM2zX7zHxzdg=
=HlZL
-----END PGP SIGNATURE-----

--3f4ojlolkkyg7fff--
