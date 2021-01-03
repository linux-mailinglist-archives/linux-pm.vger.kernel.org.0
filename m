Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFED2E89F2
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jan 2021 02:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbhACB6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jan 2021 20:58:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48484 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbhACB6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2021 20:58:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 67E621F410AD
Received: by earth.universe (Postfix, from userid 1000)
        id 2125E3C0C94; Sun,  3 Jan 2021 02:57:52 +0100 (CET)
Date:   Sun, 3 Jan 2021 02:57:52 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH] power: supply: cpcap: Add missing IRQF_ONESHOT to fix
 regression
Message-ID: <20210103015752.gzonx5h54v4mseye@earth.universe>
References: <20201230101911.11747-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpuvl2wfhpbvnyzq"
Content-Disposition: inline
In-Reply-To: <20201230101911.11747-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zpuvl2wfhpbvnyzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Wed, Dec 30, 2020 at 12:19:11PM +0200, Tony Lindgren wrote:
> Commit 25d76fed7ffe ("phy: cpcap-usb: Use IRQF_ONESHOT") started causing
> errors loading phy-cpcap-usb driver:
>=20
> cpcap_battery cpcap_battery.0: failed to register power supply
> genirq: Flags mismatch irq 211. 00002080 (se0conn) vs. 00000080 (se0conn)
> cpcap-usb-phy cpcap-usb-phy.0: could not get irq se0conn: -16
>=20
> Let's fix this by adding the missing IRQF_ONESHOT to also cpcap-battery
> and cpcap-charger drivers.
>=20
> Fixes: 25d76fed7ffe ("phy: cpcap-usb: Use IRQF_ONESHOT")
> Reported-by: Merlijn Wajer <merlijn@wizzup.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 2 +-
>  drivers/power/supply/cpcap-charger.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -666,7 +666,7 @@ static int cpcap_battery_init_irq(struct platform_dev=
ice *pdev,
> =20
>  	error =3D devm_request_threaded_irq(ddata->dev, irq, NULL,
>  					  cpcap_battery_irq_thread,
> -					  IRQF_SHARED,
> +					  IRQF_SHARED | IRQF_ONESHOT,
>  					  name, ddata);
>  	if (error) {
>  		dev_err(ddata->dev, "could not get irq %s: %i\n",
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -708,7 +708,7 @@ static int cpcap_usb_init_irq(struct platform_device =
*pdev,
> =20
>  	error =3D devm_request_threaded_irq(ddata->dev, irq, NULL,
>  					  cpcap_charger_irq_thread,
> -					  IRQF_SHARED,
> +					  IRQF_SHARED | IRQF_ONESHOT,
>  					  name, ddata);
>  	if (error) {
>  		dev_err(ddata->dev, "could not get irq %s: %i\n",
> --=20
> 2.29.2

--zpuvl2wfhpbvnyzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/xJJ8ACgkQ2O7X88g7
+prleQ//R0GUUY+IU+a8e2Rq8GB3xZ2h8WqIZgdfs/Y20DytOseTM3MoHS3aYLDL
lRuhHrklNRZKYTXAPSE089eejt3S3LcrH99iQ6hpkR/rHo5Sn9vmf0bp9iPOdQql
CTLLsU5RTD0+7bEZ2KM7LLG+T6WpGJ8TGW+qCmXg6mwL1SO8Nvb2gewmIopANNLu
EB27UVUgtrzYcvmwAftVXFsxDgJm2cMv1BR6fyFYcwtr5z1zOVGlitkj9PhvZ/uI
psEjGZB+ufsvW9ZfmmzWRpnygB1yIHRkdmTXA6xKY8u/aEWgcIWu5NUyikk/etl0
Q22LSB73+3IIXXq4YMlAdvi5j9nNiBDWzQ4yGThnLVhNMw/SB5OgAI8x5E+Iho/W
b/+Bx3FD0ddgJXp9+5uHj6kH1W0bFy8WxgSV98rPBMZ3AdvjXixXVgt7Q50IaWTM
cI5l8ij7TpbNri+QHHkxZGpqbEOYLaa73Lk0YDJByX/mOuaJMu+xyP3wvTFSWfVG
7iLGdwf1Uj81FzarS2aHhZK9WjMPj5OikmWk+DSE+tzVHv8Fs2cAPQuXwliTEyeN
8dP8yZDc9Y5DCexUGSYcnjwPN8VfkRGyF9L+yHfoDRp+UmdFM2fNkibZfD24Ov3X
kZjrArMOwbAYtupa1So3g9+VJOfYrV2bx5RbzMk/Ch/ErRJh3ws=
=aLC9
-----END PGP SIGNATURE-----

--zpuvl2wfhpbvnyzq--
