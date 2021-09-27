Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35C1419829
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhI0Psk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 11:48:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhI0Psk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 11:48:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AA78F1F42F4F
Received: by earth.universe (Postfix, from userid 1000)
        id CF5473C0CA8; Mon, 27 Sep 2021 17:46:58 +0200 (CEST)
Date:   Mon, 27 Sep 2021 17:46:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] power: supply: cpcap-battery: remove redundant check
Message-ID: <20210927154658.mjrmbtu455cbprun@earth.universe>
References: <20210819121137.11928-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e2acn35dqxuwoc2q"
Content-Disposition: inline
In-Reply-To: <20210819121137.11928-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e2acn35dqxuwoc2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 19, 2021 at 08:11:37PM +0800, Tang Bin wrote:
> In the function cpcap_battery_probe(), the check of '!match->data'
> can actually never happen for the driver. First, this probe function
> will only be called if there is a match with an entry from the OF
> device ID table, and then all entries have .data set to a valid point.
> So remove the redundant check.
>=20
> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

NAK. Instead replace the complate of_match_device() part. The driver
only needs the data object and there is of_device_get_match_data()
for this. Also - even better - there is a non-DT specific variant
which is device_get_match_data(). Please use that:


const struct cpcap_battery_config *cfg =3D device_get_match_data(&pdev->dev=
);
if (!cfg)
    return -ENODEV;

memcpy(&ddata->config, cfg, sizeof(ddata->config));

Thanks,

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 8d62d4241..a3866826b 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -1035,12 +1035,6 @@ static int cpcap_battery_probe(struct platform_dev=
ice *pdev)
>  	if (!match)
>  		return -EINVAL;
> =20
> -	if (!match->data) {
> -		dev_err(&pdev->dev, "no configuration data found\n");
> -
> -		return -ENODEV;
> -	}
> -
>  	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
> --=20
> 2.20.1.windows.1
>=20
>=20
>=20

--e2acn35dqxuwoc2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFR524ACgkQ2O7X88g7
+pooYQ/+NeHXz6A/FJeXt+PuIJfwREJ6Jpf76z3ejcHUFeMLhInqRKBUFJLdXGlG
ZVJdFmfOhkUQWfVfbpojFQ+4xzwEKJ0gGx8EXem8XPY9ne7JFgOJCLEh3NkSVh7m
8FepV97I3p331IygNcAlPWEpG02B1PDFcERWQKWVpDbQvcaKZQXIka+YPriXVPuf
TnW8+0nlhsEkqcjktosQtX4ij3xSkYNgkQq3/RiqdkOHpZfQsEE0ejT7QDgTYj5w
4DzjE4mrgC5rPL0gvkK7Vn5WQMoPQsl18a0UmnDHGfsA8DwHAM1LMbwpnd2/688P
SGNRm4JVfPbGOjWsEL/5hrXQLglKejJjpMJ23SLMJzXV3AjGAsZDg1opyCaA5oYs
B3OdhrGbFPYfv5XrOwgk+Dir8GY4BmFGdqvNLG6dRHH9DSFwlM9vKfKOk59ZgUmh
I9k9zVj7JgBgYdINWPkShxlrTmtFaOd2lkjoPvzCP8baU9R2Eoy1WnLS51Rt3KU0
kGJI5CJkopwhWl4WAVXxxOIgVimNBbcPfN01tzwKYjhpkGgI2GXNg+Yam8oAvt/P
wh317POdIBJXBzoNGXyAdm4qaskGII9ES/YatcmfVudH4YqQUsr933cCyyqPQWtt
W5UU0/SdqicYcSB/EtQ8l4a8BJKrN3imzazkgLWZhy1voQ1XcgE=
=Pxi6
-----END PGP SIGNATURE-----

--e2acn35dqxuwoc2q--
