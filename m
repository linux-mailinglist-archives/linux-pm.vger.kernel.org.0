Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2594D22E2CF
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jul 2020 23:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGZVw1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jul 2020 17:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgGZVw1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Jul 2020 17:52:27 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52CC1206D7;
        Sun, 26 Jul 2020 21:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595800346;
        bh=NbaAX64KN9s+U/Kyg1aOaFKymX1k2hdqJxg9pdMOuug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfEL37rDZveHZB2G/SFDsfFGBAH2g4p+i0yTDIhtc8vs3d9syAQ92u3A1MtwuUcaa
         9oGe06DKGWI+Zp7yhDAZLFc9EtqCZqxrU5Lh+CW/yiBg8Q+z0oVOHi5y7erOkvpMnm
         4n3fqu7kWSGH2SNTLGNP8LDccd7Q56O/VQTTBUsw=
Received: by earth.universe (Postfix, from userid 1000)
        id 818E13C0B87; Sun, 26 Jul 2020 23:52:24 +0200 (CEST)
Date:   Sun, 26 Jul 2020 23:52:24 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: reset: keystone-reset: Replace HTTP links with
 HTTPS ones
Message-ID: <20200726215224.6lbxvs355gfsw6zr@earth.universe>
References: <20200718094340.93087-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cg6ijbao55d5aul2"
Content-Disposition: inline
In-Reply-To: <20200718094340.93087-1-grandmaster@al2klimov.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cg6ijbao55d5aul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 18, 2020 at 11:43:40AM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>=20
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>=20
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---

Thanks, queued.

-- Sebastian

>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=3DAlexander A. Klimov <grandmaster=
@al2klimov.de>' v5.7..master
>=20
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
>=20
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
>=20
>  If you apply the patch, please let me know.
>=20
>=20
>  drivers/power/reset/keystone-reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/k=
eystone-reset.c
> index ad11faae19c5..211eeef0c81a 100644
> --- a/drivers/power/reset/keystone-reset.c
> +++ b/drivers/power/reset/keystone-reset.c
> @@ -2,7 +2,7 @@
>  /*
>   * TI keystone reboot driver
>   *
> - * Copyright (C) 2014 Texas Instruments Incorporated. http://www.ti.com/
> + * Copyright (C) 2014 Texas Instruments Incorporated. https://www.ti.com/
>   *
>   * Author: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>   */
> --=20
> 2.27.0
>=20

--cg6ijbao55d5aul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8d+xUACgkQ2O7X88g7
+pqvHRAApFb3Yl5hhhv1VEmFgGiArp4446cgOTu5x4B1BBt5DootWgKSLdsEDlMv
DFlNckFPskaosl6UVZuQZz+6ka/CE9ojS0X4aiEEIjvnpDsI6LbjG7L3lFe7InDQ
nnRr70b3UlwYGnrFZggjf1H+SEa/XKXNNigxf2dCzR/gMHj9u+K8OIHmSlYdJmkN
4Fo7DnfbY7jOq49Bgtvek/gX65gteUmii971ERdjkXh/dSfap9nN1MyN6bwokOAH
G7PmgiWGb8+xhi5g5t1IXBlqZFmGBlskiCV2KohXC6TwJiIS2l2w3ZN1Gl4p7xWe
Q7h4kefAJVUS+7bAOvJP0l8domGV0u4RIS4Kt9hdD1LKdxBIzp9XPqmMgLd8aYp5
ZQs1yTdkiBO60qSLmUqso+8JnQRwrLEoO3Fe3Td/dSZtSbjjvUW/aqTuASbOK6Wu
l/6/CAKLJqent6THVyRFzfX/gU7iDTS7SPllcxsC2J9AV6fBKE4assPDQfA9PG5P
4GmTw0wL9daf8cqcQPDOfX0qjcso/Abgk2lGErCydFRz/F2Lzj5FnuDegsTTYFMo
FONlRhO6PxN87rK6Eci/hgPumvlVmZWTL8rZvK93rVL4RyWVr/MOVCZxgUrgk3el
EZoqQrRqzntPcLBguLRSCp+4gA29zwLscBx8V7FBgOcUUqkkJq0=
=daRY
-----END PGP SIGNATURE-----

--cg6ijbao55d5aul2--
