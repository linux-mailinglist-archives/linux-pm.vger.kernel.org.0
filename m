Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13122FE53
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG1AJX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 20:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgG1AJW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 20:09:22 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADDE520786;
        Tue, 28 Jul 2020 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595894962;
        bh=K1Jwt+CiWgjpwCuB/A8HDxni5foS28/ROXvaTPCzAJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=to/Seqp0rn3C1Kqoa1/ayXn5xAoETkbUgaqZ96fuTVjNEBmI+rpb43fgSMa8mOstB
         bjjpq53q4W99EEyv1WrCqe/xfXiuwKne0hz1G/RngXLx1bY1g8rn548Ik2vC6yBmbS
         0PlYN9xb93Yy37kXSSbkXnjaQnPLC6aYq0LE625g=
Received: by earth.universe (Postfix, from userid 1000)
        id BE2373C0B87; Tue, 28 Jul 2020 02:09:13 +0200 (CEST)
Date:   Tue, 28 Jul 2020 02:09:13 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     pali@kernel.org, afd@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq2xxxx: Replace HTTP links with HTTPS
 ones
Message-ID: <20200728000913.vbijq3toa5vqijvv@earth.universe>
References: <20200713191638.37311-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e7g6drv22bw3eue3"
Content-Disposition: inline
In-Reply-To: <20200713191638.37311-1-grandmaster@al2klimov.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e7g6drv22bw3eue3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 13, 2020 at 09:16:38PM +0200, Alexander A. Klimov wrote:
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

[...]

>  drivers/power/supply/bq2415x_charger.c     | 16 ++++----
>  drivers/power/supply/bq24257_charger.c     |  6 +--
>  drivers/power/supply/bq27xxx_battery.c     | 44 +++++++++++-----------
>  drivers/power/supply/bq27xxx_battery_hdq.c |  2 +-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +-
>  5 files changed, 35 insertions(+), 35 deletions(-)

Thanks, queued.

-- Sebastian

--e7g6drv22bw3eue3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8fbKYACgkQ2O7X88g7
+prAtxAAmU9pmGt7EtCDGrTcI4KlPEgzYckp/LqN3Zrx0FW7qQgKDBeoMQmJiDiI
bBnPoDV6zxFbWbmtjR5XoSceTgxojLZVgf37o4M4UsWTQMdippg2D/kxQU+r2j8P
VzuHPM9YD/0xPchgcllF337K8FpYOGYuG8pXLq+OEBCYvsuTi9tATJnv1pXMewqE
PedGHds9GOeNCcpudMqinUeWnXCFamy6MnYqZmVTq1QwLDEnEhdY0Q+An7324VpU
5LB8hqYYu5dhusbBo5zy34CnYZ4l00G0Wj5Gk9ytqJ7A5WQ4OjkWpJFa+9iNV03+
yd8neV4o8GjVYh4YcXiX5TqBrFgpRIzsy3QaHrpTzoQpunMbwADaq7SzghyBSjWn
khkbYYcjqqgsRpqBNMg9FSmJpAo8gtSBF5y2f2ndr9Vw/bN9TJOGzw7GeQMreMTZ
c8mm34ZJ9J+KfgS0hoV5gXs0tROf7ctr5zJD49KGP76P8iQ8z9cu19Ie/yFbA4Ks
kp4Kf6/lrCcWQIoDGbXbCacBlLBFjxOceES70evtl+MxaUAmpHX0IhxhXHiDMuhG
PP5bE20JyHy+3SmZBBRigc7bEo6Y5+dwppNDVI2qkP2y4IDvmQ6KiSJvwN19quN3
5VXpHC0HPuqf2AL4aHJCUCbntH6x2Eoy6SCHVvwwFIRI5Al1mI8=
=m61K
-----END PGP SIGNATURE-----

--e7g6drv22bw3eue3--
