Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9B125859
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLSARK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:17:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38894 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSARK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:17:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 26F1C2929BD
Received: by earth.universe (Postfix, from userid 1000)
        id 35B703C0C7B; Thu, 19 Dec 2019 01:17:06 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:17:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: pda_power: add missed
 usb_unregister_notifier
Message-ID: <20191219001706.aqbugbkgahhqmoyk@earth.universe>
References: <20191115062515.7087-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4docmszilkkqxav"
Content-Disposition: inline
In-Reply-To: <20191115062515.7087-1-hslester96@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f4docmszilkkqxav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 15, 2019 at 02:25:15PM +0800, Chuhong Yuan wrote:
> The driver forgets to unregister the notifier in remove.
> Add the call to fix it.
>=20
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/pda_power.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/power/supply/pda_power.c b/drivers/power/supply/pda_=
power.c
> index 3ae5707d39fa..03a37fd6be27 100644
> --- a/drivers/power/supply/pda_power.c
> +++ b/drivers/power/supply/pda_power.c
> @@ -429,6 +429,10 @@ static int pda_power_probe(struct platform_device *p=
dev)
> =20
>  static int pda_power_remove(struct platform_device *pdev)
>  {
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +	if (!IS_ERR_OR_NULL(transceiver) && pdata->use_otg_notifier)
> +		usb_unregister_notifier(transceiver, &otg_nb);
> +#endif
>  	if (pdata->is_usb_online && usb_irq)
>  		free_irq(usb_irq->start, pda_psy_usb);
>  	if (pdata->is_ac_online && ac_irq)
> --=20
> 2.24.0
>=20

--f4docmszilkkqxav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36wYIACgkQ2O7X88g7
+po3UQ/+ISbvFHfheQl6Tkshh0G7pDFueKpZBvcFzwbBeOFc005KU0whEcYS7j24
geeQFw+pM08ppAx+9J/Ud84FzksWgkHeRIdQVHfli3rvuW+P/r5I0zPpqTWf5naD
uuVfiDGZ7uXEaZBMyZ2NF3yNy7D9HU6G+IOFzA0XlNCKt/c8QFOb7NWRGCLTPoZI
eRtapu+zK2eMLXxlNFgrcLx/xqAUBnXQZ1zHQiBq+qGeQTkacQH8zvhi7ctzqSXM
7wr/7ehp3PmsjF1Sl9thDTAI9uMv7rt+nFdhr2YZ0pCmNKkopukA04r9JxweOQEz
lwbkkxBjT1+taMLBl62MZm7EeXlVm6sTTzg7eSbvPAArIkNZi+ZZT1JqdKcxPZCp
gb4tcOP1RvsXqn4WVaP4iUunX8L5GidwIsQU9FcD9rUsDGcYyv+crpG+Un0zgBY0
/jVvKQb197///lgMD/sUgN46O5lGx6U1YkrIJXYcgU86GTyjn22E0ey8gcWD38nY
BYJhBZEFVFLLc8J2jE0yvDTolI2wCL2svpD0JlFU+P5E55uVHBA721c0H1/kOwWC
eMk/z8IJKkyRzTWqQ24MWa6fWU87/aScWhzI3smMX2peux0y+keTE2nVWDcoBZrU
xrzWtJ5zPBWLwVNCnT/ocemnol2FpTmGVHbaliiDdsxCEEM9phQ=
=r9B5
-----END PGP SIGNATURE-----

--f4docmszilkkqxav--
