Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01796306890
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhA1AVQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:21:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36342 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhA1AUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:20:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A400A1F45620
Received: by earth.universe (Postfix, from userid 1000)
        id 383F73C0C97; Thu, 28 Jan 2021 01:19:23 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:19:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     angkery <angkery@163.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xinjian@yulong.com, Junlin Yang <yangjunlin@yulong.com>
Subject: Re: [PATCH] power: supply: charger-manager: fix typo
Message-ID: <20210128001923.pkj4verkqk7cy5jm@earth.universe>
References: <20210120124553.751-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sj4vynfx4u6awy4a"
Content-Disposition: inline
In-Reply-To: <20210120124553.751-1-angkery@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sj4vynfx4u6awy4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 20, 2021 at 08:45:53PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
>=20
> Change 'exeeds' to 'exceeds'.
>=20
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 6fcebe4..731351d8 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -570,7 +570,7 @@ static int cm_get_target_status(struct charger_manage=
r *cm)
>  		return POWER_SUPPLY_STATUS_DISCHARGING;
> =20
>  	if (cm_check_thermal_status(cm)) {
> -		/* Check if discharging duration exeeds limit. */
> +		/* Check if discharging duration exceeds limit. */
>  		if (check_charging_duration(cm))
>  			goto charging_ok;
>  		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> @@ -578,7 +578,7 @@ static int cm_get_target_status(struct charger_manage=
r *cm)
> =20
>  	switch (cm->battery_status) {
>  	case POWER_SUPPLY_STATUS_CHARGING:
> -		/* Check if charging duration exeeds limit. */
> +		/* Check if charging duration exceeds limit. */
>  		if (check_charging_duration(cm))
>  			return POWER_SUPPLY_STATUS_FULL;
>  		fallthrough;
> --=20
> 1.9.1
>=20
>=20

--sj4vynfx4u6awy4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASAwsACgkQ2O7X88g7
+porsQ//WeO1oSMnapNEbZWhqTOlk3L0zPhwScghWOEy57QTRucBX8gBf+afQke+
eQk1rQD4GDMf56TXtXUJZtjSDnvfb9D6l+NTVDyHsYKwIfSVr4MTVTl89omOO2DT
m0NiHOVJTUPlS9990Rx5VD7w8tgtRHKTq86JvlTbb6vgR/6QIW3cGRSOBggo8Lpp
Lbh7OHRNrt5JaAu+qYQO+5YOfiVCaEg+DSw161Jbwtma5WSGZv0HD+4K7LAmwbsE
nRui9iNbbTvFqNiEr3VnFKgLszxr3/w2QfU0Ftg84ER9v0FKpU0YMgDTNV8FifnX
Xw3mBiI/KnLlwkjYodGCq5K8TlXmqFcAtakIfRfwC7qTWJf++2S9wXgAR4Vg3qK7
TLvS2kIOOcxTvflBxhHXyoYJWa2OwWAxKdYdNSnNsT0Rh9T0+w7ODIjdOW6bp9Dr
XuzsVViW57Dcy/OZVfL3D+8q3hgWsUkKOruLoJ8x7kg/7S+tE11LNXOh27wdzOpc
53g3UL5Zi1492wAT2/9k4v4PyPkdrvpinHAHJ3UMsJ2thErqNkM+kbqh1+1lRWNE
Tk2tTg9wR/yNFRi7hZ5DnKeXX7MOuBGUtCXCeHQKjMWPo5lt/x9tg82/ZcMf8K9H
67uLkptnhHXdopIkBnkwAPqBYGkNXZFnj6l3EFTl+w5qLtl/TJI=
=QyWT
-----END PGP SIGNATURE-----

--sj4vynfx4u6awy4a--
