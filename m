Return-Path: <linux-pm+bounces-2362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C895883251D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 08:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24E41C23436
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jan 2024 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65786CA4A;
	Fri, 19 Jan 2024 07:42:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385C288CE
	for <linux-pm@vger.kernel.org>; Fri, 19 Jan 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650158; cv=none; b=WMe+Bny7hqIyiRzrzRV5hux+lt4k/HXvyrCIpEGfQVOQ/R6kb4KYOw35y4HbWrbw9JfOlrgt4FrQYwEvx1KRQlql4Cxuj2kuYkJOzfdIMezG5C/cdPSVrc2D4QsRirtPcW9crBXi/2UGKCFIwLXs+5cPAzrWv0fygjWXQ7pVKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650158; c=relaxed/simple;
	bh=2Q/S9JaEhMWV4llT9dpxkOjOQi7+SfmsULuw8YByC18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tut/8xvyhr5ZKLt9GnYj6xkYuiXVQe0ZvJNi3fpPqV5FvmtagyPtpmzhmVeZGp5wAUUZUVDVtRKXU+47MsuVlFROmzKIWFwgBmcOriqHFheugLadk01uz3Mm9vo9A0nSGMnHklGsECtZwlFFAFo/BRDLmZm/rggq02ZRMMyUQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQjWJ-00024q-Rj; Fri, 19 Jan 2024 08:42:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQjWI-000rt2-Uu; Fri, 19 Jan 2024 08:42:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQjWI-0034W7-2n;
	Fri, 19 Jan 2024 08:42:30 +0100
Date: Fri, 19 Jan 2024 08:42:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Jindong Yue <jindong.yue@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <festevam@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] pmdomain: imx8m-blk-ctrl: imx8mp-blk-ctrl: Error out
 if domains are missing in DT
Message-ID: <asamq53uiegrgwo5c25sjn7n47bsv6xa3ybkueuhb2d42m66ze@t6ujdompm2gs>
References: <20240119014807.268694-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwcpdyvgxjgrw4uv"
Content-Disposition: inline
In-Reply-To: <20240119014807.268694-1-marex@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org


--zwcpdyvgxjgrw4uv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 02:47:41AM +0100, Marek Vasut wrote:
> This driver assumes that domain->power_dev is non-NULL in its suspend/res=
ume
> path. The assumption is valid, since all the devices that are being looke=
d up
> here should be described in DT. In case they are not described in DT, bea=
use
> the DT is faulty, suspend/resume attempt would trigger NULL pointer deref=
erence.
> To avoid this failure, check whether the power_dev assignment is not NULL=
 right
> away in probe callback and fail early if it is.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jindong Yue <jindong.yue@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> ---
> V2: Add extra check for domain being NULL (thanks Peng)
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 9 ++++++---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx=
/imx8m-blk-ctrl.c
> index 1341a707f61bc..ca942d7929c2b 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -258,11 +258,14 @@ static int imx8m_blk_ctrl_probe(struct platform_dev=
ice *pdev)
> =20
>  		domain->power_dev =3D
>  			dev_pm_domain_attach_by_name(dev, data->gpc_name);
> -		if (IS_ERR(domain->power_dev)) {
> -			dev_err_probe(dev, PTR_ERR(domain->power_dev),
> +		if (IS_ERR_OR_NULL(domain->power_dev)) {
> +			if (!domain->power_dev)
> +				ret =3D -ENODEV;
> +			else
> +				ret =3D PTR_ERR(domain->power_dev);
> +			dev_err_probe(dev, ret,
>  				      "failed to attach power domain \"%s\"\n",
>  				      data->gpc_name);
> -			ret =3D PTR_ERR(domain->power_dev);
>  			goto cleanup_pds;
>  		}
> =20
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/im=
x/imx8mp-blk-ctrl.c
> index e3203eb6a0229..e488cf79b8007 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -687,11 +687,14 @@ static int imx8mp_blk_ctrl_probe(struct platform_de=
vice *pdev)
> =20
>  		domain->power_dev =3D
>  			dev_pm_domain_attach_by_name(dev, data->gpc_name);
> -		if (IS_ERR(domain->power_dev)) {
> -			dev_err_probe(dev, PTR_ERR(domain->power_dev),
> +		if (IS_ERR_OR_NULL(domain->power_dev)) {
> +			if (!domain->power_dev)
> +				ret =3D -ENODEV;
> +			else
> +				ret =3D PTR_ERR(domain->power_dev);
> +			dev_err_probe(dev, ret,
>  				      "failed to attach power domain %s\n",
>  				      data->gpc_name);
> -			ret =3D PTR_ERR(domain->power_dev);

This could be made a bit more compact using:

	domain->power_dev =3D
		dev_pm_domain_attach_by_name(dev, data->gpc_name) ||
		ERR_PTR(-ENODEV);
	if (IS_ERR(domain->power_dev)) {
		ret =3D PTR_ERR(domain->power_dev);
		...

I'm unsure though if this is human friendly enough?!

Having said that I wonder about dev_pm_domain_attach_by_name(). IMHO if
NULL is an error case it and other errors are signaled by error
pointers, there is something to fix there.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zwcpdyvgxjgrw4uv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWqJ+UACgkQj4D7WH0S
/k5gLAf9GkpnOgxJ/Zrj7Yyk/Dn1zQqgkJz5IYDHqqgYcaDKvsn0fOu7nSopnMSs
Y3JNMl7HnHnYAifPeHnjNU5ocAaFM7O8qRenB0rKF5s6d3wlGNPPFiP8DayVJ58s
N5WBDpFiFOgSGGRTnnfqAOeooiXK6gpuh1d90SHEdnNeThD/xx/BIZhufTv+gMek
UFUcQwiZEtaQZSkkPjo+ghn0NkaFxtrRUlM5GduVj6UGyITP5UW26jfqpgX6T0Cq
OVVJYJnqBUmKite1sxvdtgCeE65gi6wgOGvTZsDGrzYpEIKOx1svb7ewkRGT9y1L
WtzGo4Z6y9X/63q8J4Y9kcO2RyIT5Q==
=XTfY
-----END PGP SIGNATURE-----

--zwcpdyvgxjgrw4uv--

