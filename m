Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F251258FE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLSBAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:00:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSBAT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:00:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 86E7F2911A3
Received: by earth.universe (Postfix, from userid 1000)
        id 7F8683C0C7B; Thu, 19 Dec 2019 02:00:15 +0100 (CET)
Date:   Thu, 19 Dec 2019 02:00:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        fparent@baylibre.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: cros_usbpd: Remove dev_err() getting the
 number of ports
Message-ID: <20191219010015.kpz4jmlhtmcqpx2j@earth.universe>
References: <20191129215916.17105-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tc5xmfdszhykl2al"
Content-Disposition: inline
In-Reply-To: <20191129215916.17105-1-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--tc5xmfdszhykl2al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 29, 2019 at 10:59:16PM +0100, Enric Balletbo i Serra wrote:
> When a device has no support to get the charger number of ports, it
> doesn't have to result in a dev_err(), print saying "Could not get
> charger port count" using a dev_info() would suffice. In such case,
> the dev_info() message is already printed but the dev_err() is annoying,
> specially, on those devices that doesn't support the command. So remove
> the dev_err().
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>=20
>  drivers/power/supply/cros_usbpd-charger.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 6cc7c3910e09..ffad9ee03a68 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -132,11 +132,8 @@ static int cros_usbpd_charger_get_num_ports(struct c=
harger_data *charger)
>  	ret =3D cros_usbpd_charger_ec_command(charger, 0,
>  					    EC_CMD_CHARGE_PORT_COUNT,
>  					    NULL, 0, &resp, sizeof(resp));
> -	if (ret < 0) {
> -		dev_err(charger->dev,
> -			"Unable to get the number of ports (err:0x%x)\n", ret);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	return resp.port_count;
>  }
> @@ -148,11 +145,8 @@ static int cros_usbpd_charger_get_usbpd_num_ports(st=
ruct charger_data *charger)
> =20
>  	ret =3D cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
>  					    NULL, 0, &resp, sizeof(resp));
> -	if (ret < 0) {
> -		dev_err(charger->dev,
> -			"Unable to get the number or ports (err:0x%x)\n", ret);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	return resp.num_ports;
>  }
> --=20
> 2.20.1
>=20

--tc5xmfdszhykl2al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36y58ACgkQ2O7X88g7
+prLww/7Bf169HA2U2qHk4iijeWqbV5ZJQY5aaMdl/vLHAEh6jD6m1i738TqbCNf
uWgjUNLJZDm2zqk2PbeH0nRNBzw8ev5TlAU12MPkALPP3gIiRUMxs5kCpsAR7e4l
+61t3+nN52kbB+m43GvAe0pFk8kBjN0HeLaCiiuEeQ5C5+uBsurewjl4cX1hKEXx
WyElL98dKK+dnXJaVhtkBdk3vwJOn5/fjh8gUxeqSYfdVlzn1Prh9Abd7/RtEAq6
B4BsKBizyjt8B1tNvifdZ3h5xuykAzPrjxqR1jToscATNZq/krj/Ql7G/n5FC86H
OAkhZ+fNfmYYlML2SMABTlZF0hILL0w6X1s8h6UJsr/Gg2oPNx4GtzYd3RXE2VxK
7O89jXJ8TYtKuT5axlZSlBmi+qSSeVqWjup0EJnAjgtUffff3ggod6KGkB2pYe6T
4RIHkzpDQVWDgBRVraduoTIOQzn/xtwbzQCsamvsGPKv0qzNJVkajnuVpGsqLq5D
C4SNA7H3zJPXX7sQNCSQxJ/hfd+twO0G/r1aLnr25s4Hr+uv/EHwnCVGBLD+WJdl
Zz+6UVXHNkKlZLa9eLN7yc8xptJZWmONqyJjf6SQP0VfqR5XqvG4GZZO4tfCCXCR
h2uubx7V9TJtumqhGxxg/BwPfJC87UXUiam0j9AmrNDIPiH23XY=
=lTtG
-----END PGP SIGNATURE-----

--tc5xmfdszhykl2al--
