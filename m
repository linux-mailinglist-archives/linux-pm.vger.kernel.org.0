Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47600641321
	for <lists+linux-pm@lfdr.de>; Sat,  3 Dec 2022 03:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiLCCJa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 21:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiLCCJ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 21:09:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E365A7BC09
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 18:09:28 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC7066601811;
        Sat,  3 Dec 2022 02:09:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670033367;
        bh=ngc7WI+aXsGmY9tly7Zo9v661qRIKzlALyctUoCzbaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyLnbO/NgKJjbAq1F1hr87D50+Bzex76BdbV8k+7JI6HsXFfV+dAX5BQ3bYulj/J8
         Vfn0UtG/gbhcSWWmo+zLzirsl2GY36uVAqcD8xUtUCVDzfUu3o542HCb8S90rtP7fM
         p253Usvvc5PJTtrWoyy7nNuabyKZyVozmOsezNwedMteWn9fFphjloipgX5ga7MUg0
         if9DwG6u1VMOMGZBkG4UGwFqdiOrpdPDQdTKwQNMNWDjIw5Yz87ENRiHIov17h9p7j
         95y+zimOOHAhDrTGELmEmdX2av07R6pumOB33CH5dtPyBiVl8fub4VZWdEJmXVHCCf
         kV+4nwMm5BOjw==
Received: by mercury (Postfix, from userid 1000)
        id 397231060E96; Sat,  3 Dec 2022 03:09:25 +0100 (CET)
Date:   Sat, 3 Dec 2022 03:09:25 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/9] power: supply: bq25890: Fix usb-notifier probe
 and remove races
Message-ID: <20221203020925.4kqbaxuf36audzjb@mercury.elektranox.org>
References: <20221128092856.71619-1-hdegoede@redhat.com>
 <20221128092856.71619-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyzfeu46wyxa6cuk"
Content-Disposition: inline
In-Reply-To: <20221128092856.71619-3-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oyzfeu46wyxa6cuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 28, 2022 at 10:28:49AM +0100, Hans de Goede wrote:
> There are 2 races surrounding the usb-notifier:
>=20
> 1. The notifier, and thus usb_work, may run before the bq->charger
>    power_supply class device is registered. But usb_work may call
>    power_supply_changed() which relies on the psy device being registered.
>=20
> 2. usb_work may be pending/running at remove() time, so it needs to be
>    cancelled on remove after unregistering the usb-notifier.
>=20
> Fix 1. by moving usb-notifier registration to after the power_supply
> registration.
>=20
> Fix 2. by adding a cancel_work_sync() call directly after the usb-notifier
> unregistration.
>=20
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Use return dev_err_probe() for the exit path previously using goto
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 30 +++++++++++---------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 866c475bb735..2d731ea58323 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1391,40 +1391,34 @@ static int bq25890_probe(struct i2c_client *clien=
t)
>  	if (ret)
>  		return ret;
> =20
> -	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
> -		INIT_WORK(&bq->usb_work, bq25890_usb_work);
> -		bq->usb_nb.notifier_call =3D bq25890_usb_notifier;
> -		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
> -	}
> -
>  	ret =3D bq25890_power_supply_init(bq);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to register power supply\n");
> -		goto err_unregister_usb_notifier;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "registering power supply\n");
> =20
>  	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
>  					bq25890_irq_handler_thread,
>  					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					BQ25890_IRQ_PIN, bq);
>  	if (ret)
> -		goto err_unregister_usb_notifier;
> -
> -	return 0;
> +		return ret;
> =20
> -err_unregister_usb_notifier:
> -	if (!IS_ERR_OR_NULL(bq->usb_phy))
> -		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
> +	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
> +		INIT_WORK(&bq->usb_work, bq25890_usb_work);
> +		bq->usb_nb.notifier_call =3D bq25890_usb_notifier;
> +		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
> +	}
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static void bq25890_remove(struct i2c_client *client)
>  {
>  	struct bq25890_device *bq =3D i2c_get_clientdata(client);
> =20
> -	if (!IS_ERR_OR_NULL(bq->usb_phy))
> +	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
>  		usb_unregister_notifier(bq->usb_phy, &bq->usb_nb);
> +		cancel_work_sync(&bq->usb_work);
> +	}
> =20
>  	if (!bq->skip_reset) {
>  		/* reset all registers to default values */
> --=20
> 2.37.3
>=20

--oyzfeu46wyxa6cuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOKr9QACgkQ2O7X88g7
+pprFRAAhum4zAQBwK/oBf9qacAi/7Z16VI1HHXrkX6Gx9kWb4KNYmcP7bN+anwC
mBtxpsHp29G3CEYCMnAJABY9y5Mp0auldTqqwsfFZaEviHk3Kndw+izwA1qnhQOh
wDTXF4RNONiIC+N857s0pDv0fFKixGmDdN6+pardKL7fMMWj6JnirNlC/RHApU7f
0ZDdxk/3W0QecqaI+525g2jnyHd8WCLn2o+GHTJkcQBfNFeGy1PqWX1qHpQ3ZJ+c
tzU2DxpZGGGZjOA5h6b+g4ecVOOkl4yU3qrO66p/5flY5HlTeGylzm4qmzmGZ1MN
T3Dk7zt8Ue39JZR33cCNmp+zpIsLE3oefepbQpB6QZUoammWbtzaXM0PhiJWXOK6
z/PTA4ziRrOmosokWJS062nf3mMAiNsxf8I/QyXFxtmJLcPr5oyF0VzDs7pTAf4i
fR8bQxcacCXh0HAuAB3YWTefg8Vo2/AnaqD2yJUWvEynLhgdilMH5WxY9/pd06Gr
w2TCInqsaVae9ZWcoUUPIy4OVncisAYbgtGfr3Cc1KNf3EwGOp5KAO86kE31LbjX
4vBq2h/0pawpSxUZYgEr0Smdw0DJsQgOp0yZ1dnqS1vdHdH6/CnK01irGTGDcfQY
w3XbKkMmdgXuO8EC1UsU5Ehr2NvSVOTqpcjUQJ9teVp/P80frpM=
=Bs9T
-----END PGP SIGNATURE-----

--oyzfeu46wyxa6cuk--
