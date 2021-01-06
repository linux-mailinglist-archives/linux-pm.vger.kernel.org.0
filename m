Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2312EC153
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAFQmN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 11:42:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhAFQmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 11:42:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 01BB61F441BB
Received: by earth.universe (Postfix, from userid 1000)
        id 8A49C3C0C94; Wed,  6 Jan 2021 17:41:28 +0100 (CET)
Date:   Wed, 6 Jan 2021 17:41:28 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: max8997_charger: fix spelling
 mistake "diconnected" -> "disconnected"
Message-ID: <20210106164128.bzgjjmwindeif5uj@earth.universe>
References: <20210104130513.35563-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e7yiclziilajll5w"
Content-Disposition: inline
In-Reply-To: <20210104130513.35563-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e7yiclziilajll5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 04, 2021 at 01:05:13PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a dev_dbg message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/max8997_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/suppl=
y/max8997_charger.c
> index 23df91ed2c72..321bd6b8ee41 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -124,7 +124,7 @@ static void max8997_battery_extcon_evt_worker(struct =
work_struct *work)
>  		dev_dbg(charger->dev, "USB CDP charger is connected\n");
>  		current_limit =3D 650000;
>  	} else {
> -		dev_dbg(charger->dev, "USB charger is diconnected\n");
> +		dev_dbg(charger->dev, "USB charger is disconnected\n");
>  		current_limit =3D -1;
>  	}
> =20

Thanks, queued.

-- Sebastian

--e7yiclziilajll5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/16C0ACgkQ2O7X88g7
+pqs4g//cJYftTes0OMiYJr8wVHkQ9Phzi6b+PRUKi6xs/EPB2IR0jO/XnW+E+rT
xHTCIklbLQ/VDThj7uw2/SYsFSb/eT0KDAgZ8PJX8pz8aQ+SVSV+LPAvmVbpI46y
+75FNaNrQM25PiJT1zC72cxZwCx2X4ZdpzEoXL9/ctoyFL2fubfK+QxrTuWiVSEY
Vu5/RJ4Hw86hX6sXLzb0wDuBzHaEly3g/yMISByvfoJ7hO1bhvCKD1/iY9sqqWsL
n2Pg96WYHeyAbUCtwygO715zVBtMgH/pZJUhS+di9yujI1x3oFuSXAV3zZl/Hwae
hER5dn0vUYbCI8VVohjD8iQb548L5emdzx6FgONgltSQGGTl+CJXhtlqZfl7URAv
QG/EJ3918exK5x5uu4BeZgQa+84IqukOC9LQUgrCHqCAX/6kIVho3ly3IdS8VJys
e48J9+3/pppCBm3mO074cN6XAM8MIcOU4M5/Sn1sfqsg0eFzqbfwPzODqqYwbYCg
FzMLDKeqBxLFcnOPHEMDodCQ+j/E2HZwWJhj/i+54Dj6v+zJp2fjZ5aEwqqR/LZ1
fgX3h9bkOVsDLVBW7eV7inbNJR5LEfd03pXR3VxYi9kNFPn58AQ+tKUFeriNoeQb
xCY2w0WEnBS+ITf6E4Uht55MGmfvzuaKbHHKVjkOeBFPNMNwQWg=
=t64x
-----END PGP SIGNATURE-----

--e7yiclziilajll5w--
