Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D0B41FCEC
	for <lists+linux-pm@lfdr.de>; Sat,  2 Oct 2021 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhJBQFL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Oct 2021 12:05:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57036 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhJBQFK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Oct 2021 12:05:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BB6DF1F4418A
Received: by earth.universe (Postfix, from userid 1000)
        id 7764F3C0CA8; Sat,  2 Oct 2021 18:03:20 +0200 (CEST)
Date:   Sat, 2 Oct 2021 18:03:20 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: cpcap-battery: use
 device_get_match_data() to simplify code
Message-ID: <20211002160320.24clt5v2nevynuco@earth.universe>
References: <20210928020623.21192-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p5fpuwijhyki46dm"
Content-Disposition: inline
In-Reply-To: <20210928020623.21192-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p5fpuwijhyki46dm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 28, 2021 at 10:06:23AM +0800, Tang Bin wrote:
> In the function cpcap_battery_probe(), the driver only needs the
> data object, so use device_get_match_data() instead, to make the
> code cleaner.
>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

Thanks, queued.

-- Sebastian

> Changes from v1
>  - change the title and commit message.
>  - change the code to use other api to make code simple.
> ---
>  drivers/power/supply/cpcap-battery.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 8d62d4241..18e3ff0e1 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -1026,20 +1026,13 @@ static const struct power_supply_desc cpcap_charg=
er_battery_desc =3D {
>  static int cpcap_battery_probe(struct platform_device *pdev)
>  {
>  	struct cpcap_battery_ddata *ddata;
> -	const struct of_device_id *match;
>  	struct power_supply_config psy_cfg =3D {};
>  	int error;
> +	const struct cpcap_battery_config *cfg;
> =20
> -	match =3D of_match_device(of_match_ptr(cpcap_battery_id_table),
> -				&pdev->dev);
> -	if (!match)
> -		return -EINVAL;
> -
> -	if (!match->data) {
> -		dev_err(&pdev->dev, "no configuration data found\n");
> -
> +	cfg =3D device_get_match_data(&pdev->dev);
> +	if (!cfg)
>  		return -ENODEV;
> -	}
> =20
>  	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
> @@ -1047,7 +1040,7 @@ static int cpcap_battery_probe(struct platform_devi=
ce *pdev)
> =20
>  	INIT_LIST_HEAD(&ddata->irq_list);
>  	ddata->dev =3D &pdev->dev;
> -	memcpy(&ddata->config, match->data, sizeof(ddata->config));
> +	memcpy(&ddata->config, cfg, sizeof(ddata->config));
> =20
>  	ddata->reg =3D dev_get_regmap(ddata->dev->parent, NULL);
>  	if (!ddata->reg)
> --=20
> 2.20.1.windows.1
>=20
>=20
>=20

--p5fpuwijhyki46dm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFYgsgACgkQ2O7X88g7
+pqV+A/+IWRbLr8ueUYq5cmxH1A/cnfQhibQuHCWDfQ7mZDld82vBzvi7xQ4MciH
x5goyvXWZLX3ZB336fEoqZAwi7ve1PxB5s4NCFG08+adh4hxi+//yd+DslImSsbt
oE3srIc3AiFArJ853omaUZp3hh4C0FmuXJP867LlMz+I4TUoDumF4wdBaVm+bwtQ
tHPA7TrRl4wcgLI+p6BklVhIBDnZAnBMV2ypUiaJZLMLGLrnJ7XJ2jTWbPTrIqLf
KEeHpJ1Rx4q3CR7FtgdpS7Haj01+9GoLd7IFCT5yQQsM83vCMxTpOxK0icCiK/e+
dI9l/hHfvJoTqoB1WLUG37oSS6A+suta0+ebkL0Xne0IaZSrAJgKtt6jgFtmiGWX
i1tdNgpAQ1hsB8nwvkFGseL8tE9JGJFZEBFrUQIihBAynuOnqg1bGMcBJeWK7ppF
UWWdko6Y7yDWQeCTQQfKqbY+oDxFJOJ4C3+L7o9T8SDRchAvh/fN3UpaGTrytkQx
7FmtuQ0u/FSu5x3vvab9zjtEJO9gyNxDBEZl7C2wTkE/erS9GaTJ33+4OR0dT674
Wnle0DZWfTGLwF3wiLCJOJYrFr3438b7RpmhseIoHIB/h+cgI69kYoede4w+Jjo6
bTn7dyFgHYrGDaCajGQbttOEF5nxcBp76fAsVF/JaVv9vrOi4L4=
=lVLE
-----END PGP SIGNATURE-----

--p5fpuwijhyki46dm--
