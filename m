Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5EA3068AD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhA1Ae3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1AeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:34:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579D0C061573;
        Wed, 27 Jan 2021 16:33:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2E8521F45627
Received: by earth.universe (Postfix, from userid 1000)
        id 6C5903C0C97; Thu, 28 Jan 2021 01:33:35 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:33:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     xinjian <xinjian34324@163.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xinjian <xinjian@yulong.com>
Subject: Re: [PATCH] power: supply: bq25980: Fix repetive bq25975 with bq25960
Message-ID: <20210128003335.clpbwb2cuwp5bnel@earth.universe>
References: <20210122064052.40880-1-xinjian34324@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zgmr2dkejh6fdxdm"
Content-Disposition: inline
In-Reply-To: <20210122064052.40880-1-xinjian34324@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zgmr2dkejh6fdxdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 22, 2021 at 02:40:52PM +0800, xinjian wrote:
> From: xinjian <xinjian@yulong.com>
>=20
> The i2c_device_id bq25975 is repeated, and should be bq25960.
>=20
> Signed-off-by: xinjian <xinjian@yulong.com>
> ---
>  drivers/power/supply/bq25980_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/suppl=
y/bq25980_charger.c
> index c936f311eb4f..530ff4025b31 100644
> --- a/drivers/power/supply/bq25980_charger.c
> +++ b/drivers/power/supply/bq25980_charger.c
> @@ -1285,7 +1285,7 @@ static int bq25980_probe(struct i2c_client *client,
>  static const struct i2c_device_id bq25980_i2c_ids[] =3D {
>  	{ "bq25980", BQ25980 },
>  	{ "bq25975", BQ25975 },
> -	{ "bq25975", BQ25975 },
> +	{ "bq25960", BQ25960 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq25980_i2c_ids);

Thanks, queued.

-- Sebastian

--zgmr2dkejh6fdxdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASBl8ACgkQ2O7X88g7
+poMKw/7BXkCy6q72ZWt+LVLD2Qysg46XCRp+IRGfR1GpjQAeNeL9foURna7sGs3
aZqnwWKRJyAR2DkSmoAp0Bp9zEGQdMZsd/0Id4rtJyy6NBzy4fTOaWd609xvuuQ3
cBIxSELlKE1nDEOySbHZxBYQn7xnzQpqt8AgfAAEKJTbTlhQmxYGEnC2BDMdmHFA
AfPmSBcLHjf7VE1xEU5Zh07KGMVjPw4kgUowaO84NKUcAJfC+UyTPXCPvl01fh8P
4nkHxYTsBSlnGOhKAI4GUo8lZvd9puGjkx8pnw2HAtUN/Q+6MROE+ew7brlRrVPS
uN1kDrOwtaRIt0bu13cRua5s196PsG9xKytKZDMAwem5iE9c6x8ZgIyox6mJdPuK
D8nLY9ADK5uGYnMqpnL2zLLQ8avMQ8zHwr+kzS7l5qTHYYa+xODrnGAanB8nNcAp
siAfNdekTDW5QAHqjPbZjJFvln2zo8ZCu13QFKKYe3yrUdlXs5rsRPHsgzmp/Rg9
X2LHG1uXPrSC4RGuEiQDUC9spSMlNJhn88h4tnmgWcwr7CYc4/38AZc8Op0WON/1
84yuxe2n6GI6BreqH1q7tYVnhM0hu+r9mkxlX/QRPpWJfxWJA1qFbeV1i9XpCgT4
qDZmUgrCl7u0P/sMZN1kV9V9LnUWF/nGduzq2+J0xIDinjTghc0=
=pFYr
-----END PGP SIGNATURE-----

--zgmr2dkejh6fdxdm--
