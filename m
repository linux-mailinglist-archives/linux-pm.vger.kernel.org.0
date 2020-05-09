Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443201CBBDE
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 02:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgEIAif (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 20:38:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55480 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgEIAie (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 20:38:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9C32F2A04C1
Received: by earth.universe (Postfix, from userid 1000)
        id 7F6DE3C08C6; Sat,  9 May 2020 02:38:30 +0200 (CEST)
Date:   Sat, 9 May 2020 02:38:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mathew King <mathewk@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Cleanup power_supply_sysfs.c
Message-ID: <20200509003830.bnajxac4vb7yll7x@earth.universe>
References: <20200504202930.228453-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tg6rfky5idyprao4"
Content-Disposition: inline
In-Reply-To: <20200504202930.228453-1-mathewk@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tg6rfky5idyprao4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for this nice patchset, I queued all patches to power-supply's
for-next branch. Next time please rebase to latest state of for-next
branch before sending new patch versions. I had to fix patch context
to apply them because of

de46e0289310 ("power: supply: core: reduce power_supply_show_usb_type() par=
ameters")

-- Sebastian

On Mon, May 04, 2020 at 02:29:26PM -0600, Mathew King wrote:
> A few various patches to cleanup the power_supply sysfs implementation.
> ---
> v2: - Don't create attributes for unlisted properties
>     - Use a char array for lower case name so no allocations neeed in
>       init
>     - Fix patch #2 does not compile because of change meant for patch #3
>=20
> Mathew King (4):
>   power_supply: Cleanup power supply sysfs attribute list
>   power_supply: Use designated initializer for property text arrays
>   power_supply: Add a macro that maps enum properties to text values
>   power_supply: Add power supply type property to uevent env
>=20
>  drivers/power/supply/power_supply_sysfs.c | 471 ++++++++++++----------
>  1 file changed, 255 insertions(+), 216 deletions(-)
>=20
> --=20
> 2.26.2.526.g744177e7f7-goog
>=20

--tg6rfky5idyprao4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl61+4YACgkQ2O7X88g7
+ppxvhAAkw65RJOoOACuodO/L19xuVGodin+p9Rz7I3LA7p1YcWnhVstfO/IZXbY
x6/Dq3ijFYhnsUI134f9n569oGFZYS7B5/13zkweRhEG7yl9mIkmk33m2QdEbQ7P
QelqTxjbc/NnImTo2Tw1Hd3csCNKTxN6RxjYFs/qsu28zKXlZ7AWRnF/3jggQFay
cpcpXg153rHfbFzrCTkbtZe7ACC92cKBG4AMSDA0U1nqlDohnT7xfftj7XkLvwGi
Hx9ii/L3YLq2CiOa8evj9SEzmVyV89eaGAEfzYwyZxTy1JH9U5lQl45cBvCPVxuf
qR6iN4nEJwvWbOlKNQJlzXoc2relF6tzZZzKIP0a5/5Ldu7kTD+m07JP24TOU43/
fryQjnc2hOtIB02FOXJ1G57vOF8+AmrQZO6b0w5/yMdnJPlMDkbqmG0N7O2s3GEn
WqV1GXHbRAfrmKSKOtKPlc7IC5sWw4v6cu6O1MPTahlIq4X1e1K6bSI98TTVKeuo
vzgJtqiaENZ9heXL9g9jUO+XJ9Kz2TAtKCMit8gluvojwjSqWRjNk2Fkmy8GE+C7
3ud00EBr1XXsrN31z6KjwjM03otkjZLtXfSyxkK1lDZSxG8BCslT0CWZy0RLJCdT
9u5I/vpZPghJbF5K82H2rDjmbtyfNoqR1SJ500IUa2JdtBhMInc=
=Ydtk
-----END PGP SIGNATURE-----

--tg6rfky5idyprao4--
