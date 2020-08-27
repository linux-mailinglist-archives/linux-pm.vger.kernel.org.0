Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42B92550D2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 00:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgH0WAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 18:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0WAN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Aug 2020 18:00:13 -0400
Received: from earth.universe (dyndsl-037-138-189-082.ewe-ip-backbone.de [37.138.189.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C51F2080C;
        Thu, 27 Aug 2020 22:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598565612;
        bh=ISnvnnw4q1n8vrvbNVzSVaRAYXFBVRIQdyZVhj20nd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQzPSIrMbBlM25JDMF1jjL2fJxHbTOab3xFy1dGbXhHdX0lndKqse8BXVoBsu72Db
         N1bZv2z3dTZDNk4DTdzyZhKrrEGY+VWvEOiHk905GuRhoMSdMSK94xUjQHuswiNP+z
         7ocssHb9fekWmuXs4/SBA1u9tzH6nnClk+gm2Fhs=
Received: by earth.universe (Postfix, from userid 1000)
        id 787173C0C82; Fri, 28 Aug 2020 00:00:10 +0200 (CEST)
Date:   Fri, 28 Aug 2020 00:00:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org
Subject: Re: [PATCH v3 2/2] power: supply: sbs-battery: don't assume i2c
 errors as battery disconnect
Message-ID: <20200827220010.tq5564p3ysebmtwu@earth.universe>
References: <0200811065307.2094930-1-ikjn@chromium.org>
 <20200813051008.3461515-1-ikjn@chromium.org>
 <20200813051008.3461515-3-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i5aefmzmjc2r6wel"
Content-Disposition: inline
In-Reply-To: <20200813051008.3461515-3-ikjn@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--i5aefmzmjc2r6wel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 13, 2020 at 01:10:08PM +0800, Ikjoon Jang wrote:
> Current sbs-battery considers all smbus errors as disconnection events
> when battery-detect pin isn't supplied, and restored to present state back
> when any successful transaction is made.
>=20
> This can lead to unlimited state changes between present and !present
> when one unsupported command was requested and other following commands
> were successful, e.g. udev rules tries to read multiple properties.
>=20
> This patch checks battery presence by reading known good command to
> check battery existence.
>=20
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---

Does not apply, please rebase. Also we probably should add
another compatible value for your specific chip not supporting
some properties, so that they are not exposed?

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 6acb4ea25d2a..2e32fde04628 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -878,10 +878,17 @@ static int sbs_get_property(struct power_supply *ps=
y,
>  	if (!chip->enable_detection)
>  		goto done;
> =20
> -	if (!chip->gpio_detect &&
> -		chip->is_present !=3D (ret >=3D 0)) {
> -		sbs_update_presence(chip, (ret >=3D 0));
> -		power_supply_changed(chip->power_supply);
> +	if (!chip->gpio_detect && chip->is_present !=3D (ret >=3D 0)) {
> +		bool old_present =3D chip->is_present;
> +		union power_supply_propval val;
> +
> +		ret =3D sbs_get_battery_presence_and_health(
> +				client, POWER_SUPPLY_PROP_PRESENT, &val);
> +
> +		sbs_update_presence(chip, !ret && val.intval);
> +
> +		if (old_present !=3D chip->is_present)
> +			power_supply_changed(chip->power_supply);
>  	}
> =20
>  done:
> @@ -1067,11 +1074,13 @@ static int sbs_probe(struct i2c_client *client)
>  	 * to the battery.
>  	 */
>  	if (!(force_load || chip->gpio_detect)) {
> -		rc =3D sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> +		union power_supply_propval val;
> =20
> -		if (rc < 0) {
> -			dev_err(&client->dev, "%s: Failed to get device status\n",
> -				__func__);
> +		rc =3D sbs_get_battery_presence_and_health(
> +				client, POWER_SUPPLY_PROP_PRESENT, &val);
> +		if (rc < 0 || !val.intval) {
> +			dev_err(&client->dev, "Failed to get present status\n");
> +			rc =3D -ENODEV;
>  			goto exit_psupply;
>  		}
>  	}
> --=20
> 2.28.0.236.gb10cc79966-goog
>=20

--i5aefmzmjc2r6wel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9ILOoACgkQ2O7X88g7
+pqC1hAAqfSJSqu1BxbcySSfPVAih62h33MfQ+uU8G2m7B6GOjmZad3SHD7tEdph
hHLzUuCjYvJtxwl4RGCosRSKnrYmtGdmvWGKRtorYm7Mtx/jbKRzjLiMLzw/jAI8
bKvZT1mhtZ0IMrGJannXBY9xGzBevW/wB6qh9l9Fv/ETFEByhBWqh/NXxxKLGubP
wqhmtIrEsG43RlFoXMB2ofFtd1n21Oohl/wRoWmf1OjHH56+itydGt1Ktlv3Fwsk
xBZHT9lbAEbiIZerFXko9Af2LXV1CX1Eay5iGbgzQsY+mTos688zq5bC5pywrI9p
YIRqRjoxQp2s4a0bezmsStwMjx7xitL7dYMpN0Vb2O2nXRaMNOwgSOPGO8OxaETx
WROctaVo4Lr3mFi04k7Im/HsFDUnnJWKenA9hvBiqGb/eX06npS367o8BrOC/12m
r+0+x0zK8RDN7BJv7kCTL0AvNrYD+lu21bgLKLj2+ALoxghEORz/bOeSzep9sXgI
WelPwDJeDY6yZDiy+AfvpkF2uC/Ns72IXs2jbiZlDENIUgzwJXYqwGO+gVhWVdx0
noZsuPZmpEzX72fz1k8QuoNWxFgf2tb7TvFYeJ7xsgSDWp/ejNy3RazRwKgEGfU1
97q5H2YsNSyHDn67r7KrGttXJ7HcjR8wzZD5DZ7iZJvwP0BdQuE=
=4s3K
-----END PGP SIGNATURE-----

--i5aefmzmjc2r6wel--
