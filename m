Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434711C18D4
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgEAO6o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 10:58:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33270 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgEAO6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 10:58:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 10F6F2A30D9
Received: by earth.universe (Postfix, from userid 1000)
        id EEA473C08C7; Fri,  1 May 2020 16:58:40 +0200 (CEST)
Date:   Fri, 1 May 2020 16:58:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: charger-manager: clarify num_properties starting
 value
Message-ID: <20200501145840.ezo4udnmvwdopz5p@earth.universe>
References: <20200501135109.45gwxpczcqdt3fbb@earth.universe>
 <c262c4b0921d916712de6a15133ff016fb721c4f.1588343350.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eei2x72djf2ji37"
Content-Disposition: inline
In-Reply-To: <c262c4b0921d916712de6a15133ff016fb721c4f.1588343350.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4eei2x72djf2ji37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 04:30:43PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Initialize num_properties with length of the copied array instead
> of relying on previously memcpy'd value. This makes it clear how
> the array and the counter are related.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 415a9efa6816..2ef53dc1f2fb 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1729,7 +1729,7 @@ static int charger_manager_probe(struct platform_de=
vice *pdev)
>  	memcpy(properties, default_charger_props,
>  		sizeof(enum power_supply_property) *
>  		ARRAY_SIZE(default_charger_props));
> -	num_properties =3D psy_default.num_properties;
> +	num_properties =3D ARRAY_SIZE(default_charger_props);
> =20
>  	/* Find which optional psy-properties are available */
>  	fuel_gauge =3D power_supply_get_by_name(desc->psy_fuel_gauge);
> --=20
> 2.20.1
>=20

--4eei2x72djf2ji37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sORwACgkQ2O7X88g7
+ppsAg/8C4Cd02OyvvtTrE9r6iALN1WxEkpaSi4DXQ7S4Pf422WXYy20+K0tAPyU
jh//lkSSnA7ivhhwnPG4WFC9CDiej0QgPGS9vXr3Iu+08QdavowtvM/Cpiv5lVv5
FYMC2K4q7oN2WCie7UlN2aGmaXSvsR6QqVIU1zrBVFfGJjIwGNX6ejITgz976x04
61RcYo4YuEZeaMDaWa0NVB7EPnR5EILzYrpkK8OVrvm6qxgC2zzdL0V7gdE3mAfV
qt28WF/c8zlj2firppeuCwDqvNGt8Syjg5s+g3xNiuaKlbtJlrYE2ku35slfm6D0
c1WHBPHGOMGnTeFa9xgmuGiUG9a4lKyQXfFc2A59zR0sdp2Lte6VXdRwmEQsoDx2
254NgrYYjj70v888kuIL426tzYGkXOgeHruQ98fABFuD874ZGH0Q61iDuWFhrWjY
bGzPRGb9tL8tgjl8ueUghxITNdB44BpClB3LWJZeqVd5MDGZBn7GFGIoExCRqVUI
YljFl1ybgSu4ksbjGYVxlpa8O7rXWQR1ZJWxvIq0tCDAAKCIpnjqsBGbaX54rTjw
a+NMDPbQl6HB0snsL0IRUU4ji4k5joVfcqADlIpPRO0Pt6A73wI4ghAeIfHT2H6M
TRMYPIu6pUX9II/XbVCICdeJ0m5Q1qA1fSybHf70xBGRfYQV4LM=
=ADgy
-----END PGP SIGNATURE-----

--4eei2x72djf2ji37--
