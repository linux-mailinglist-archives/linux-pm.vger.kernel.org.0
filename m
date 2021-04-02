Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB53352A7D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBMO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBMO2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 08:14:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99609C0613E6;
        Fri,  2 Apr 2021 05:14:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4EB681F46A50
Received: by earth.universe (Postfix, from userid 1000)
        id 2F4823C0C96; Fri,  2 Apr 2021 14:14:24 +0200 (CEST)
Date:   Fri, 2 Apr 2021 14:14:24 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 0/1] charger-supply for max8997_charger
Message-ID: <20210402121424.2imblhsxrkocjg7n@earth.universe>
References: <20210329143715.806981-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wbfo3p5zroxgn7zs"
Content-Disposition: inline
In-Reply-To: <20210329143715.806981-1-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wbfo3p5zroxgn7zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 29, 2021 at 02:37:47PM +0000, Timon Baetz wrote:
> Based on the discussion from [0] add an optional DT property to retrieve
> the regulator used for charging control in the max8997_charger driver.
>=20
> [0] https://lore.kernel.org/lkml/20210118124505.GG4455@sirena.org.uk/
>=20
> Changes in v2:
>=20
> * drop accepted patches
>=20
> Timon Baetz (1):
>   power: supply: max8997_charger: Switch to new binding
>=20
>  drivers/power/supply/max8997_charger.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Thanks, queued.

-- Sebastian

--wbfo3p5zroxgn7zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBnCpoACgkQ2O7X88g7
+ppTag/+IkqQNu9jDkrBooJ96hNXWxts8q4CbwpUn7dknkpGC7Ti2OOWYaeG55lo
BipXr6Seuiv4Ug9vasHK2PCy629aBfh6k/FbNus//iAgPl9dZH1OdPKJr6tw3NMf
zpPQWC2LeVAAgchUo7OxGyEXWDJOIOd01IIjwx+7pqyIU0/IrBbLUvlsYKyE4OtK
x1UQ2wZfE5j7ZTFiB/SXcJRUxBvESEURbvCY1fzVoFaMGEo+qDuE+21yDB0saJ2P
wlCz4LhNuHm7CCX8XhWDaibFWpsu8i7i7SSTzJPmICg1gCrl8/px2AZCjoQWJ+o8
SpyjZp6KmOHDUyirh4Ne9iFzrdNVLW97OvQ4aU5Z5cHBgtocbdhIH5sIHZHmJtbc
jnd8stIMeSuyA8SpQ+yk/GcR1Wn7fdMO0EopZ2NMth29Mh4t6/XRta7IpVMt99kl
3s+mAp3NCtkXNNzhrgVEvC9l2jb6D0NWsJaZPL///iuUcGbC7md+Y7KYzlR53QFg
9u8kF292MxQ1oZphJP9uicrGC0PycuR/F/lIZbn9JXUphJNwTjAoAZ1wYGXnppzn
YtKkzvxkcIbA0Jng9as00P5J1WphAElxkIrUmQl9EJO+mRMD7x2HoBkFPgd0ZX/j
cHSYYLVsWz/clGfxHmoAab9qw40YqaazVbsdYCt/zh0RjZm0ZXg=
=MzoX
-----END PGP SIGNATURE-----

--wbfo3p5zroxgn7zs--
