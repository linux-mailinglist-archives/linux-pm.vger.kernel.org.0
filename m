Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16111641320
	for <lists+linux-pm@lfdr.de>; Sat,  3 Dec 2022 03:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiLCCJL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 21:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiLCCJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 21:09:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B757BC09
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 18:09:10 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 893226601811;
        Sat,  3 Dec 2022 02:09:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670033348;
        bh=jeUKRnw1kSdUok/LD3l9qfDWkB2vuorWTrg1zcISEyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qx19omPunQsGW9gwV+ouNzkn8kdbSTHpBi6bFazFIQQsq2Op/yTSIi0uduC510/+F
         X4d1a/Dnvy34ShV7fonK+AND1wkrVZSYU7gDyiS6szRehTTwsJ1ezum8rH4k8aMF04
         aUBNFiq69ount7NGyFy39PfhOTR7BcCPiZ2T+xZGvqbUURgMySC6VNh30bMNJTOCUz
         YmkYIPW6Qw4yynrSlwsIyrIcMwuYnu9CihK80Kddw8p322XG6fug9S72E+VseEqJFj
         UQX2jyF6QsO7C+q0rL+fHcItTaVwxOZI7D/E9QWe642ew0W1lhlj2+iZ+GKAtItnm+
         G1mRL4lMVu9Lg==
Received: by mercury (Postfix, from userid 1000)
        id 486211060E96; Sat,  3 Dec 2022 03:09:06 +0100 (CET)
Date:   Sat, 3 Dec 2022 03:09:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/9] power: supply: bq25890: Ensure pump_express_work
 is cancelled on remove
Message-ID: <20221203020906.csjbvlokrjtxhxwn@mercury.elektranox.org>
References: <20221128092856.71619-1-hdegoede@redhat.com>
 <20221128092856.71619-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qywsddjhqnm4qa4w"
Content-Disposition: inline
In-Reply-To: <20221128092856.71619-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qywsddjhqnm4qa4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 28, 2022 at 10:28:48AM +0100, Hans de Goede wrote:
> The pump_express_work which gets queued from an external_power_changed
> callback might be pending / running on remove() (or on probe failure).
>=20
> Add a devm action cancelling the work, to ensure that it is cancelled.
>=20
> Note the devm action is added before devm_power_supply_register(), making
> it run after devm unregisters the power_supply, so that the work cannot
> be queued anymore (this is also why a devm action is used for this).
>=20
> Fixes: 48f45b094dbb ("power: supply: bq25890: Support higher charging vol=
tages through Pump Express+ protocol")
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

> Changes in v2:
> - Add comment that the devm_add_action() call must be done before
>   devm registering the power_supply, to guarantee it running after
>   the unregister
> ---
>  drivers/power/supply/bq25890_charger.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 512c81662eea..866c475bb735 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1317,6 +1317,13 @@ static int bq25890_fw_probe(struct bq25890_device =
*bq)
>  	return 0;
>  }
> =20
> +static void bq25890_non_devm_cleanup(void *data)
> +{
> +	struct bq25890_device *bq =3D data;
> +
> +	cancel_delayed_work_sync(&bq->pump_express_work);
> +}
> +
>  static int bq25890_probe(struct i2c_client *client)
>  {
>  	struct device *dev =3D &client->dev;
> @@ -1372,6 +1379,14 @@ static int bq25890_probe(struct i2c_client *client)
>  	/* OTG reporting */
>  	bq->usb_phy =3D devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> =20
> +	/*
> +	 * This must be before bq25890_power_supply_init(), so that it runs
> +	 * after devm unregisters the power_supply.
> +	 */
> +	ret =3D devm_add_action_or_reset(dev, bq25890_non_devm_cleanup, bq);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D bq25890_register_regulator(bq);
>  	if (ret)
>  		return ret;
> --=20
> 2.37.3
>=20

--qywsddjhqnm4qa4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOKr78ACgkQ2O7X88g7
+pps0RAAiPqDvYC+cnnyaWUfhucQH2Xym9bAadbrlkOrrSjS6aVbXe2gdWoNcwOD
RW/N85MlWiuaSTUWcShR0LcJy77hMIXmZqEwyhaEm/7k5S7UVdL81uTjoqfYlOqd
nbIPMXfWJpdem2aqO3ll2dk/hXaoZYcU++6iFUQw3F28/QGhiGDPhrtQNLp4UDqZ
tCJgI7+6UCHd18nPjODcy9XPnMXhwG82FaHE8Uqjo0Jr+ra8EvHDmMsoT0YwQBf/
uIgzyd0bWBQuVXodw4QJvxmSIxGzzpuHZCWH1uaqD02XZvGXxxf1Qn4RK420dxck
ZzZs8Vn6vrA1hD/4hWJ1NF7OvyhFpROFLjbmAilv6yH7o6Hl4p2QtyRCEENGZA8s
sr5YVLE6Ha6wfdZVKmokmpv/GeNWzUNXBM4HHbBD0lcgKrkyKLKtG9zn7ge8KAoP
w/CVGAz7QfSgYUtY/aiqCD/wq/v1pwYYlz65f8u4SvUDpHVnDzMiS05eKdI4e/Vr
kt4nXcCCa86hn3bGxe01hJ6l7i4WLzMCWKZvtHu98VB1aqMDBP9ch4Tw78Qi8xen
3ZxxFrodXlb//WHNiuqiwTi1ilHjpHhAQp+OJZcY8jvrOwO6c/Ae6cFcfmFFo1Nd
W0vZ9R40Eaj0hFkIIDC2eaqQjLUyf8vqC/YLsqzMjoyNa7s8GG0=
=oX0O
-----END PGP SIGNATURE-----

--qywsddjhqnm4qa4w--
