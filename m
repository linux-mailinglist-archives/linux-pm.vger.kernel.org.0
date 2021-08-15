Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B1D3ECB8B
	for <lists+linux-pm@lfdr.de>; Sun, 15 Aug 2021 23:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhHOVyM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Aug 2021 17:54:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55358 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhHOVyL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Aug 2021 17:54:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 481211F42390
Received: by earth.universe (Postfix, from userid 1000)
        id 235823C0C9B; Sun, 15 Aug 2021 23:53:37 +0200 (CEST)
Date:   Sun, 15 Aug 2021 23:53:37 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Kezhou Li <kezhou.li@tinno.com>
Cc:     pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External][PATCH] power: supply: bq2415x: fix deadlock in
 bq2415x_set_autotimer
Message-ID: <20210815215337.kvxngq2ba7viqfip@earth.universe>
References: <1624277660-11440-1-git-send-email-kezhou.li@tinno.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrodfk3q7x4pfbmq"
Content-Disposition: inline
In-Reply-To: <1624277660-11440-1-git-send-email-kezhou.li@tinno.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lrodfk3q7x4pfbmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 21, 2021 at 08:14:20PM +0800, Kezhou Li wrote:
> From: "Kezhou Li" <kezhou.li@tinno.com>
>=20
> The bq2415x_timer_error called by bq2415x_timer_work when some error
> happens, and then calls cancel_delayed_work_sync(&bq->work). Finally
> this function is waiting for the work to finish but the work is
> waiting for the return of the function. So it causes a deadlock.
>=20
> Signed-off-by: Kezhou Li <kezhou.li@tinno.com>
> ---

The patch is not correct, since bq2415x_sysfs_set_timer() should
call cancel_delayed_work_sync() for the "off" case.

-- Sebastian

>  drivers/power/supply/bq2415x_charger.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/suppl=
y/bq2415x_charger.c
> index 5724001..7889edb 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -862,8 +862,6 @@ static void bq2415x_set_autotimer(struct bq2415x_devi=
ce *bq, int state)
>  		schedule_delayed_work(&bq->work, BQ2415X_TIMER_TIMEOUT * HZ);
>  		bq2415x_exec_command(bq, BQ2415X_TIMER_RESET);
>  		bq->timer_error =3D NULL;
> -	} else {
> -		cancel_delayed_work_sync(&bq->work);
>  	}
> =20
>  	mutex_unlock(&bq2415x_timer_mutex);
> --=20
> 1.9.1
>=20

--lrodfk3q7x4pfbmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEZjN4ACgkQ2O7X88g7
+ppnvRAAodF+sl1yWvvtAQSg15s5o+umWBmRxDTGaMYidY/rZ3z9uD/X2KbLwP0h
nB9FzHo6Gzw0P2JFtFGU1ZCmmhNgZhd/+jhtVMFQGUqmRCCW+N5bu8ybO3ATElKp
9wQEb47NMWCI1Qj0WJf3+n16xifopuZGEerbIuHJ9fI3BejBzW890p4dcXMp7TjR
SDpJAIuxLltSGkxHrd1Av3UmCDYu48MbMgyuGQInwt/hIL8yNV3j6AtnRsAD+mF4
dcE9EExUQXNCEW5bFtMtqqwdtqWkErNFYBfTZK75GpWm5LWdvLzHNuMtBvF/llaB
H5PDV1AySzr/ton1TG/ieD5P7iVpacQj6ahpGtLmFdx+BqU1kj5RLp+ILv7BRSj4
WAsZBMODDObjmkgQAEWjf5h3uLGRR9iR8loZdSye6wbWQacd0KPKkpQSaLaL7jkE
IRcnGH17x9TCuCFDwd4xlqFCMcXdui9mbwLa6lr2vPxK6vlrVOwjuXpCObcGKIFY
zLSSDsZxt3ZCr714eIr+JEIEqHow34W2Ty8f7WoqW1PJZM+en3wRRAfKWTmtHBV3
Nb/MV7mFhj5CO5pvVJ0otcycmB4KZQLQqg/eRno+i+MZ74DRQHAtvmB7qw2xCspf
RajjK4c+75QkKy8MKDWAG+Q90UKQorL1py+o/HZLcZVbKZHp9xM=
=GbaK
-----END PGP SIGNATURE-----

--lrodfk3q7x4pfbmq--
