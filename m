Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBD14014B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 02:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgAQBFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 20:05:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34368 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAQBFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 20:05:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 56B78293B0F
Received: by earth.universe (Postfix, from userid 1000)
        id 722923C0C7E; Fri, 17 Jan 2020 02:05:39 +0100 (CET)
Date:   Fri, 17 Jan 2020 02:05:39 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] power: supply: core: Update sysfs-class-power ABI
 document
Message-ID: <20200117010539.pihyxg7hodgys3xx@earth.universe>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="33szw2b3l7pfdgnr"
Content-Disposition: inline
In-Reply-To: <20200116175039.1317-2-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--33szw2b3l7pfdgnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 16, 2020 at 11:50:36AM -0600, Dan Murphy wrote:
> Add the "Over Current" string to /sys/class/power_supply/<supply_name>/he=
alth
> description.
>=20
> Fixes: e3e83cc601e57 ("power: supply: core: Add POWER_SUPPLY_HEALTH_OVERC=
URRENT constant")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 27edc06e2495..bf3b48f022dc 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -189,7 +189,8 @@ Description:
>  		Access: Read
>  		Valid values: "Unknown", "Good", "Overheat", "Dead",
>  			      "Over voltage", "Unspecified failure", "Cold",
> -			      "Watchdog timer expire", "Safety timer expire"
> +			      "Watchdog timer expire", "Safety timer expire",
> +			      "Over current"
> =20
>  What:		/sys/class/power_supply/<supply_name>/precharge_current
>  Date:		June 2017
> --=20
> 2.25.0
>=20

--33szw2b3l7pfdgnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4hCGMACgkQ2O7X88g7
+po/8Q/+O9m7orOagJFgFPU6VI5CdxmvX2G4A3xohqYajcz9zAqa0YxGjFK9LypK
YIr8KARKQtzSHcaebYzoDNNZYjDTryBe3EnTczLE/1NulM+EIvpd/W9Sw6ISVrVS
F52vW/cRIDthJtp3GSVP9i/Dyvk2g4Mfst1W370pSfn8cqkUUgPHA+rH2xH+gblO
WvdIk49/7pTOhltFMzG6WtDJkTOBZLgoxrHEyuzPPw+PZJXIGae1G5xtezIVpEi7
zM4Gcgbs5F3UNd64b5CATb/wpuMGCG+tfrjwVjmXv24TEeb+xHmgxv4AJJdAnY3E
pqkX925Pg7bodgsmtq7jk5PbSjTpwhG5UYW8XZl7iGA0gyEhREGt//oWk5SAiXDX
IERBUwXRnav5NaSNQRIqrL8PcxgGzsGOzCt/e1jmQx9qB/1f3bDxEYFJSY7c2gPa
NgBqvEVSxY7/4Rd4mh5wFRGf8Q7V1cQMGg4R/KWfkrx4gOJmyYb1b2zvcAGNLim5
IMYLFasbugNWCb1fDVhl8K2NbHhUxbcYMCgRps8Tqsu2SusBJSmuLE/4ykRyp2hB
DaPQT09jZZDsHdI9r5+IJz5vIsz/uHbu6GmbqCfTcAvvTnDNa55/ZgMU0Rmy2uPG
8WttQIo4k+5q7czNb5xmHvt53W0lnP2Zv2c39Hxeubmxb0mkH0E=
=J19c
-----END PGP SIGNATURE-----

--33szw2b3l7pfdgnr--
