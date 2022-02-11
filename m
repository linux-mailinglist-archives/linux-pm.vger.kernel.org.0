Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254454B2D2A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 19:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiBKSyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Feb 2022 13:54:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiBKSx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Feb 2022 13:53:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15774CD8
        for <linux-pm@vger.kernel.org>; Fri, 11 Feb 2022 10:53:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D97F41F472A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644605637;
        bh=HwSL/b2IPew4etCOQjafc/Zilxrk5LosOwm4KEnV+1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L10oq96j8owN7lEFQ3XmNQSzzJjE+thOaIof/1SZqiwUgN9sPEsyoS0hlaEOM8odP
         6yFtvv0CS3my0t3v41piAPgld3hmAXCNfKRAXrvnhu1nvCymJwH/tHs+kUDWQriSuV
         or32aO1TBYUUecQ8OF477qoV/GrJLFPRHyutPI0pBtnngYZg5xXhJfU2UZpeOCZmp+
         qwR7qvCoMd/wf/MCzbV+emyk1GJIdXjW9ep+k64x1HFLD75Dzh3evX7J6ZGWgnTbwW
         2VKe+0QGoTRQQPjgiQitfcy4GtTpz+QDL2TdzvzE7afkxYbZf+XZ07rNZGBCt9gYP7
         BmNwlzEahn3Og==
Received: by mercury (Postfix, from userid 1000)
        id 8F3571060908; Fri, 11 Feb 2022 19:53:53 +0100 (CET)
Date:   Fri, 11 Feb 2022 19:53:53 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: rt9455: Don't pass an error code in
 remove callback
Message-ID: <20220211185353.lkoefqgnk7yzw5wy@mercury.elektranox.org>
References: <20220205183512.11038-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bwt3sb4vp7tieum"
Content-Disposition: inline
In-Reply-To: <20220205183512.11038-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4bwt3sb4vp7tieum
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 05, 2022 at 07:35:12PM +0100, Uwe Kleine-K=F6nig wrote:
> When ret is not zero there were already one or two error messages emitted
> about a problem (because rt9455_register_reset() emits a message in most
> cases then). Passing on that error code to the i2c core only results in
> another error message. Suppress that by returning zero unconditionally.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/rt9455_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply=
/rt9455_charger.c
> index 594bb3b8a4d1..74ee54320e6a 100644
> --- a/drivers/power/supply/rt9455_charger.c
> +++ b/drivers/power/supply/rt9455_charger.c
> @@ -1716,7 +1716,7 @@ static int rt9455_remove(struct i2c_client *client)
>  	cancel_delayed_work_sync(&info->max_charging_time_work);
>  	cancel_delayed_work_sync(&info->batt_presence_work);
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static const struct i2c_device_id rt9455_i2c_id_table[] =3D {
>=20
> base-commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60
> --=20
> 2.34.1
>=20

--4bwt3sb4vp7tieum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGsMEACgkQ2O7X88g7
+ppoIg/+IGFHO2DZIn3kJ/yThP+/hsr8MoYX1eF6eLD+AISE0uJeidD6McYFr97B
OAVbXxJuctQmtRPHSM2mYJMrr+UXM3Wz6gpvqA+/+XxmV//vXjyfqNwqTBZr39kj
Bgb9jlWnTnjx1mbDEiQQgRWN5Qtmn0O0Z8nXnX6mb1TuY4X8WMQI+kXdxRfDzf8w
O0vrBRJcYHRP2oXlvEbscBXBGy6OTdlJ1/ot1QrJJgz94ZVLJUlkhHEW2rJLSuYf
wEFgIIZizVEv83l/+24WqI3yci4q2beHspaVzqSeeQK1XAL1l1fzM7N/bXapTzW1
Pk8zEYAcCQhkqbEK3HisxZMaeOsjnnGeU+iHQTk7sXnyTFxPcetJveXSDPEU4PNR
87Vn71GCjz7vSe4oyDyB+4+AvQcyepG+o9Kl5QN7uLN6MQU6WUz/DVKsk5cPnLlU
nwgsgYy6DuUQ89L5VUdJId2ZoJcfCUGzyphmVFtGLxlWHlSSR/ujKd+RDhcgu14A
g6jBrbTxUSiWl8cHOYal5ZkGxaqDE8dCvRSU/btGrS5KdibkakOTCIgZOSuf+UQp
eemwMRSj8PoJPHD+GU9ljA9+tiZHAH/8JhY2rAPpLk+D9ceza6kS+oDemmb14BzJ
SQWexcmIfENw5I3bTyQSl+rYQcV6TTU4NDa6jIawFRll4A3DeNg=
=8dUD
-----END PGP SIGNATURE-----

--4bwt3sb4vp7tieum--
