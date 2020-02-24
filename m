Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5516ACDD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 18:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBXRNu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 12:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgBXRNu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 12:13:50 -0500
Received: from earth.universe (dyndsl-091-096-061-166.ewe-ip-backbone.de [91.96.61.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F8B20836;
        Mon, 24 Feb 2020 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582564429;
        bh=Ai1gyeG8Ted5a1YKe7xePygaQZvcPxx/36/7ngnSPb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e2Pw6+wGpDTpdGNsCFI9u5iGeW6TtWpuvR/U5vwOenDcn+vVHi66lr61X9mpQu1aP
         MwSAc2qAqDxLw3wc6m1abpsy9COGAwzo2kO8AoD7q2tJ78koAcfBekaYZ7tsa11R+8
         45dQoIoacuT1mPw8ZyvETfUEPshjodWYrLSuLjbA=
Received: by earth.universe (Postfix, from userid 1000)
        id 9034C3C0C83; Mon, 24 Feb 2020 18:13:47 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:13:47 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 12/17] power: supply: cros: Use cros_ec_cmd()
Message-ID: <20200224171347.ghei34x5zn5umewg@earth.universe>
References: <20200205190028.183069-1-pmalani@chromium.org>
 <20200205190028.183069-13-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bzw77mvqr2inibwn"
Content-Disposition: inline
In-Reply-To: <20200205190028.183069-13-pmalani@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bzw77mvqr2inibwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 05, 2020 at 11:00:18AM -0800, Prashant Malani wrote:
> Replace cros_usbpd_charger_ec_command() with cros_ec_cmd() which does
> the same thing, but is defined in a common location in platform/chrome
> and exposed for other modules to use. This allows us to remove
> cros_usbpd_charger_ec_command() entirely.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> Changes in v2:
> - Updated to use new function name and parameter list.
>=20
>  drivers/power/supply/cros_usbpd-charger.c | 58 ++++-------------------
>  1 file changed, 10 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 30c3d37511c9e1..4631d96fda2ca1 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -91,46 +91,13 @@ static bool cros_usbpd_charger_port_is_dedicated(stru=
ct port_data *port)
>  	return port->port_number >=3D port->charger->num_usbpd_ports;
>  }
> =20
> -static int cros_usbpd_charger_ec_command(struct charger_data *charger,
> -					 unsigned int version,
> -					 unsigned int command,
> -					 void *outdata,
> -					 unsigned int outsize,
> -					 void *indata,
> -					 unsigned int insize)
> -{
> -	struct cros_ec_dev *ec_dev =3D charger->ec_dev;
> -	struct cros_ec_command *msg;
> -	int ret;
> -
> -	msg =3D kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> -	if (!msg)
> -		return -ENOMEM;
> -
> -	msg->version =3D version;
> -	msg->command =3D ec_dev->cmd_offset + command;
> -	msg->outsize =3D outsize;
> -	msg->insize =3D insize;
> -
> -	if (outsize)
> -		memcpy(msg->data, outdata, outsize);
> -
> -	ret =3D cros_ec_cmd_xfer_status(charger->ec_device, msg);
> -	if (ret >=3D 0 && insize)
> -		memcpy(indata, msg->data, insize);
> -
> -	kfree(msg);
> -	return ret;
> -}
> -
>  static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
>  {
>  	struct ec_response_charge_port_count resp;
>  	int ret;
> =20
> -	ret =3D cros_usbpd_charger_ec_command(charger, 0,
> -					    EC_CMD_CHARGE_PORT_COUNT,
> -					    NULL, 0, &resp, sizeof(resp));
> +	ret =3D cros_ec_cmd(charger->ec_device, 0, EC_CMD_CHARGE_PORT_COUNT, NU=
LL,
> +			  0, &resp, sizeof(resp), NULL);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -142,8 +109,8 @@ static int cros_usbpd_charger_get_usbpd_num_ports(str=
uct charger_data *charger)
>  	struct ec_response_usb_pd_ports resp;
>  	int ret;
> =20
> -	ret =3D cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
> -					    NULL, 0, &resp, sizeof(resp));
> +	ret =3D cros_ec_cmd(charger->ec_device, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> +			  &resp, sizeof(resp), NULL);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -159,10 +126,8 @@ static int cros_usbpd_charger_get_discovery_info(str=
uct port_data *port)
> =20
>  	req.port =3D port->port_number;
> =20
> -	ret =3D cros_usbpd_charger_ec_command(charger, 0,
> -					    EC_CMD_USB_PD_DISCOVERY,
> -					    &req, sizeof(req),
> -					    &resp, sizeof(resp));
> +	ret =3D cros_ec_cmd(charger->ec_device, 0, EC_CMD_USB_PD_DISCOVERY, &re=
q,
> +			  sizeof(req), &resp, sizeof(resp), NULL);
>  	if (ret < 0) {
>  		dev_err(charger->dev,
>  			"Unable to query discovery info (err:0x%x)\n", ret);
> @@ -189,10 +154,8 @@ static int cros_usbpd_charger_get_power_info(struct =
port_data *port)
>  	int ret;
> =20
>  	req.port =3D port->port_number;
> -	ret =3D cros_usbpd_charger_ec_command(charger, 0,
> -					    EC_CMD_USB_PD_POWER_INFO,
> -					    &req, sizeof(req),
> -					    &resp, sizeof(resp));
> +	ret =3D cros_ec_cmd(charger->ec_device, 0, EC_CMD_USB_PD_POWER_INFO, &r=
eq,
> +			  sizeof(req), &resp, sizeof(resp), NULL);
>  	if (ret < 0) {
>  		dev_err(dev, "Unable to query PD power info (err:0x%x)\n", ret);
>  		return ret;
> @@ -334,9 +297,8 @@ static int cros_usbpd_charger_set_ext_power_limit(str=
uct charger_data *charger,
>  	req.current_lim =3D current_lim;
>  	req.voltage_lim =3D voltage_lim;
> =20
> -	ret =3D cros_usbpd_charger_ec_command(charger, 0,
> -					    EC_CMD_EXTERNAL_POWER_LIMIT,
> -					    &req, sizeof(req), NULL, 0);
> +	ret =3D cros_ec_cmd(charger->ec_device, 0, EC_CMD_EXTERNAL_POWER_LIMIT,
> +			  &req, sizeof(req), NULL, 0, NULL);
>  	if (ret < 0)
>  		dev_err(charger->dev,
>  			"Unable to set the 'External Power Limit': %d\n", ret);
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20

--bzw77mvqr2inibwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5UBEMACgkQ2O7X88g7
+ppZ2A/8Dx23pfIa3OCbkEH9B+vKKdGZhQQSTuZgRnX76RGhgmJ56xswQxcn97XR
d95OxueYJC7NLXqGvJs4/UladL+5iEfa+rJrKcngFOYwKgVcPa8XeQrYVmVCrZbv
odxkh7dcN/J9AGErdovc52qspQ/WiJVs+yw3x1a9WzdrEIX1WW3v60uWlIojKaNi
KwQG7zaSEXlQZu7nrUyZ7fNb6yCc+DDhj04vSpWGEgYYa199aT5u2QvEgaj3pxEF
SpZt4c4JhtNHlqbVJX/bixN2f5OQJWikoOPjYYnk8CnSNZWqPRtETpROHLi+pxo5
C1sKf2+DryI/+z7yBONg/jqEYXEds9e9CERYxDtNa5ausTZvsEbLNpCZJoXW/lYU
7joBxMOynx0xpU2MhCfsQuLhxTEDyBWO+Z45qElvs5eMnA8BJMzr57sq8Knju2bx
BRiYQ82qEZ7duIe84YuuU1OywVfkKJADVXXYbIenOSh0GOqB6Izf39ANjgRlNIa+
07RU1YHPWi5JmObJSC1HO/8Of1Up11CxtszBp/5hZZd1VqEBbdMgMiRYdO+gIWGy
1O34uo5o20I3kRpobJthk89ZaBbIDUrVnF+ZUYOwl+j6p3/wPKjsbl60aLuNsSaK
J9q5XxkDkeDnqkeuM5kVo+kypVfKjdCR0YNlP3bwXa/uLlZgI+g=
=xsT6
-----END PGP SIGNATURE-----

--bzw77mvqr2inibwn--
