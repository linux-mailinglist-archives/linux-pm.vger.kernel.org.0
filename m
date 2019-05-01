Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3739110E96
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 23:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEAVbx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 17:31:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37240 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAVbx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 17:31:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B3C852787AD
Received: by earth.universe (Postfix, from userid 1000)
        id 578E63C0D1B; Wed,  1 May 2019 23:31:49 +0200 (CEST)
Date:   Wed, 1 May 2019 23:31:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: bq27xxx_battery: Notify also about
 status changes
Message-ID: <20190501213149.v4xifzj4pxym4vt3@earth.universe>
References: <1556272742-17232-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oo4nxb7vd5wfkt5c"
Content-Disposition: inline
In-Reply-To: <1556272742-17232-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oo4nxb7vd5wfkt5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 26, 2019 at 11:59:02AM +0200, Krzysztof Kozlowski wrote:
> User-space might be interested in receiving uevents when the charging
> starts/stops or if conditions of battery changes (e.g.
> over-temperature).  Notify about changes in battery also when the flags
> change, not only SoC.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued.

-- Sebastian

>=20
> ---
>=20
> Changes since v1:
> 1. Remove unneeded backslash (pointed by Pali).
> ---
>  drivers/power/supply/bq27xxx_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 29b3a4056865..195c18c2f426 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_i=
nfo *di)
>  			di->charge_design_full =3D bq27xxx_battery_read_dcap(di);
>  	}
> =20
> -	if (di->cache.capacity !=3D cache.capacity)
> +	if ((di->cache.capacity !=3D cache.capacity) ||
> +	    (di->cache.flags !=3D cache.flags))
>  		power_supply_changed(di->bat);
> =20
>  	if (memcmp(&di->cache, &cache, sizeof(cache)) !=3D 0)
> --=20
> 2.7.4
>=20

--oo4nxb7vd5wfkt5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzKEEUACgkQ2O7X88g7
+pqsLw//W11mBfBrUxXGdXS+/jzoIpCyS3GDnTLOyVCWYnHZoAWsj/+IK0pHJBDS
THqb6RxRE7ttV/pUdIzBkP7V9pSZRSJOWEX4kN0okrd4JuMBBFjSbQPkjgGY87dS
L6X2gLZiNvktq4j+Nsl8lAxZmEKB41XT7R4kkEPnpJ7Ykswchtip4PxIx5phThIa
7SQbU6QxurMi9Yj9sJM3nqm9U/72HQAEpQDk5v73IVskq+myeut0zHWB2GSnwN4R
cKFqlLf/ktjZNIL4ImmHWVPTmiB+LFdywmVuvzNzWxIaPke4/lH9yMSMjsQuwC85
wZEPcbaDqcSctlv5nVaSDOJGQ0B79YIUwLpE3mhCAg+hpTbfegQ4F1TVolEeHVMM
yrDp2jOtASj0pUN0g9fR3z4cgYrnPdOAmT2nHm/Ub5ZyZXDT+CDNDsmgCHtzPCUu
tMUotLhGQmIs2jNZqESSmSKBrm6lB+S8AddlAika4AbtVAGdYp0m3IGGA1IES8Ww
tgjtyaNwRX9gpcIKJnd/W8io9T/NwiT+XsvHLk63JzhqWIsnCLVFTbfYQvCQmfJ6
k7KrKg/Y5quiOr0tTVTEWSD+g7EeOtjyaVltZiGePpQsUw9j8qno2fAPnLsaSHU9
I5WlSAmpzfVeo+YFyiOIPsn4OC0dxL/N3RKnJJr87BGCKRTowBw=
=VC6P
-----END PGP SIGNATURE-----

--oo4nxb7vd5wfkt5c--
