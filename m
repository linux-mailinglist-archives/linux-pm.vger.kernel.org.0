Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2073EB6BB
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhHMOdC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhHMOdC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 10:33:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB3C061756;
        Fri, 13 Aug 2021 07:32:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 093741F44936
Received: by earth.universe (Postfix, from userid 1000)
        id DC4D53C0C99; Fri, 13 Aug 2021 16:32:28 +0200 (CEST)
Date:   Fri, 13 Aug 2021 16:32:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>, wens@csie.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] power: supply: axp288_charger: Use the defined variable
 to clean code
Message-ID: <20210813143228.i5ngphf7qbeem2kc@earth.universe>
References: <20210811104929.24608-1-tangbin@cmss.chinamobile.com>
 <60b7038f-2c68-4559-6a97-a5f2bc97647f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p34b5vbjhvnni57o"
Content-Disposition: inline
In-Reply-To: <60b7038f-2c68-4559-6a97-a5f2bc97647f@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p34b5vbjhvnni57o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 12, 2021 at 05:20:25PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 8/11/21 12:49 PM, Tang Bin wrote:
> > Use the defined variable "dev" to make the code cleaner.
> >=20
> > Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> > Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>=20
> Thanks, patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

>=20
> Regards,
>=20
> Hans
>=20
>=20
> > ---
> >  drivers/power/supply/axp288_charger.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supp=
ly/axp288_charger.c
> > index a4df1ea92..b9553be9b 100644
> > --- a/drivers/power/supply/axp288_charger.c
> > +++ b/drivers/power/supply/axp288_charger.c
> > @@ -813,7 +813,7 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
> >  	if (val =3D=3D 0)
> >  		return -ENODEV;
> > =20
> > -	info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> > +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> >  	if (!info)
> >  		return -ENOMEM;
> > =20
> > @@ -823,7 +823,7 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
> > =20
> >  	info->cable.edev =3D extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> >  	if (info->cable.edev =3D=3D NULL) {
> > -		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
> > +		dev_dbg(dev, "%s is not ready, probe deferred\n",
> >  			AXP288_EXTCON_DEV_NAME);
> >  		return -EPROBE_DEFER;
> >  	}
> > @@ -834,8 +834,7 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
> >  			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> >  			return -EPROBE_DEFER;
> >  		}
> > -		dev_info(&pdev->dev,
> > -			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
> > +		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
> >  	}
> > =20
> >  	platform_set_drvdata(pdev, info);
> > @@ -874,7 +873,7 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
> >  	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
> >  	info->otg.id_nb.notifier_call =3D axp288_charger_handle_otg_evt;
> >  	if (info->otg.cable) {
> > -		ret =3D devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
> > +		ret =3D devm_extcon_register_notifier(dev, info->otg.cable,
> >  					EXTCON_USB_HOST, &info->otg.id_nb);
> >  		if (ret) {
> >  			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
> > @@ -899,7 +898,7 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
> >  					NULL, axp288_charger_irq_thread_handler,
> >  					IRQF_ONESHOT, info->pdev->name, info);
> >  		if (ret) {
> > -			dev_err(&pdev->dev, "failed to request interrupt=3D%d\n",
> > +			dev_err(dev, "failed to request interrupt=3D%d\n",
> >  								info->irq[i]);
> >  			return ret;
> >  		}
> >=20
>=20

--p34b5vbjhvnni57o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWgnUACgkQ2O7X88g7
+ppfRQ//YjORzu6Bjkgl9QouyJ/6F37ZKr4QtMIvQCPWEuPup+AIGu+u746KTHty
GwKu7cSFuW4MFITvJz3YwR0/L5Ky4QXlmB04pHPb5+4BfIAItZmUP9uJZhcnAeo0
eCvG651r3wvrWEUwKuYHJA7W3LL0PxbfOG4oNs2O67tXSVAWLOJA+k5LPQm4b4NA
zQcTIh/fMYiKHUX2OHeWGl0v0Sl5zifMQxauS1Sm2N/Q6pHs/PxwQJLMp1rolMmh
2vNWfZm0ffmwrtOS+SVW1xoRl48ib+BQazbzgFt6EziBsI6ulDGPsumt3EeDdJ/D
vwSE3+CW+LR4mE4QnYWl/e0YxeZd/p6wUHamsh75GXjDEgrJ3HkZR/ykaGsxlrBr
hZGv67GhIipVWzR6t/rZe5OWh+1P5Pbt5+9P79KzTY6F2ARvI60YRFIbOsqHdcJB
MCVX9qV0k6eRHT+p/9IRHRiuBi5ddAgSaZoR2BXxfDK+8lkgCdLRzzRG5cVlTmpg
qXj64+EMmZqoZM/dzC+Qu/ETaEM00y/QdS0ednvm3EYEWIfnmAtbvNG7rdE7VzbY
XHagSFNjFsFyPXQn4d7KfRLUYT9ZnQ2qZMZ2tJHMOBd2/RrF+m8bWaTqDNPoL1j8
gFrP1cBtJWE5MnGV/EpJKurnz9LKF35+z4dRWzzbrMzEoFePUTo=
=P4N8
-----END PGP SIGNATURE-----

--p34b5vbjhvnni57o--
