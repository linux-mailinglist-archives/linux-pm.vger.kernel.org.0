Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A1639E31
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 00:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK0XRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 18:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK0XRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 18:17:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657DBFD16
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 15:17:20 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C837F660296C;
        Sun, 27 Nov 2022 23:17:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669591038;
        bh=qziKedAAOFRL56AxUP+/ZF4zfAn/NfQeF+sKoJA8b04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mn5Dp5/c2S4+mWhako/Zkr7gw16H6mum7PkVXrwTSYfh/lfwWt+aVyo4FM7N7/af8
         RMQBvjMPagTQdWsrzctmCoOG1Ooy9QOz/vq9HDX8j3ikavDSL/WijN+i/qsEF+xXtz
         yG+QUKyu+YebwUu+BVdM+7+3T8P2FIjGRryDkKGpweA6h67Q3wsjq5F65ldHO683M9
         R2Urn++VwLutE2Jmz0y2n1oCQNL+NgjYUUj8jsWB8PKWE9TCXBt4MrI81kY1qKPiuL
         JFhZuP+WUX+BiCLsNVj5dlrlWkFAnd2EUniMJhYhOBDTnP2V8FClnnOwTp/pOZhcGL
         osrZwFRa22jWw==
Received: by mercury (Postfix, from userid 1000)
        id B308D1060B5B; Mon, 28 Nov 2022 00:17:16 +0100 (CET)
Date:   Mon, 28 Nov 2022 00:17:16 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/10] power: supply: bq25890: Ensure pump_express_work
 is cancelled on remove
Message-ID: <20221127231716.dtt5nrpvv7dheeqd@mercury.elektranox.org>
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2eepvjfbx4lc5ke"
Content-Disposition: inline
In-Reply-To: <20221127180233.103678-3-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--w2eepvjfbx4lc5ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 27, 2022 at 07:02:25PM +0100, Hans de Goede wrote:
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
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 512c81662eea..30d77afab839 100644
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
> @@ -1372,6 +1379,10 @@ static int bq25890_probe(struct i2c_client *client)
>  	/* OTG reporting */
>  	bq->usb_phy =3D devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> =20
> +	ret =3D devm_add_action_or_reset(dev, bq25890_non_devm_cleanup, bq);
> +	if (ret)
> +		return ret;

ret =3D devm_delayed_work_autocancel(dev, &bq->pump_express_work, bq25890_p=
ump_express_work);
if (ret)
    return ret;

(+ removing the INIT_DELAYED_WORK)

-- Sebastian

> +
>  	ret =3D bq25890_register_regulator(bq);
>  	if (ret)
>  		return ret;
> --=20
> 2.38.1
>=20

--w2eepvjfbx4lc5ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOD7/gACgkQ2O7X88g7
+pozZg/+PLDhjc4a8UFdq840/S++S7MEHZY2hxQdUEeKCC4xY1F1m3iWpZmcc4xW
NdtkseA5dXI/VNjP0UBQE3yIUjHt8K9M4E8tUK8nVmPSwRFVCRz/xcyy5+SPVq+P
9MbyY8D5sLoVym2qBq3ojjxuaRp5OzvVJ8OtatKAsaNsm3ojn1vXuj7LLr3sN+w0
Ze2aAI12F8/gKeO2B1GltbC9IGcySnkByDZfjHwx6+fYo9zeIQ/OMLJY9WmANwMl
toRO8ra0Vpj5WQ3H7CNiyZtWMDanjyM9jl7weeR4VcFn0eshIUUwd1GmX7MNp1Mq
N8A9pJJozl+5SnZghU9gD0CliU7iVbO+9THhbYrFVyEv4wpZzBy/XYmUy5AT4Qvk
dJogoFQRVQDyJfgRj2Iv0DwNa+jtv0whKnN23hBbgZPDZn2nxv2YwHGA3nSlThbe
ihyF/ZqHRD7C3/XKpH6TRhZ3M4ZJQpjCQ/XCj715RYHyIA/1zzpozAnajHi97z5x
b3drzfiHizfDQYotmcT/fmq2r2OMlYJsyNfZfGDBc3PDZvIKNei+w1ky5DJFTzaB
babXcaD6WAjD8LkXkTtgIwBmWnPWMt1ma7SVylcDdbv3nK6BCQwCCexULalzHDlL
NK2OJun0xZrw2IEJh88AP6XjPoCHrjtxRQd/KJZZgLF05k2GszE=
=L/sz
-----END PGP SIGNATURE-----

--w2eepvjfbx4lc5ke--
