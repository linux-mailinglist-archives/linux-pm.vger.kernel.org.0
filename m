Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD65A6C4561
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 09:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCVIvk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 04:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCVIvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 04:51:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF658B49
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 01:51:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peuBx-0004Cz-9I; Wed, 22 Mar 2023 09:51:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peuBv-005sXh-Hv; Wed, 22 Mar 2023 09:51:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peuBu-0070Tz-RA; Wed, 22 Mar 2023 09:51:30 +0100
Date:   Wed, 22 Mar 2023 09:51:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>, "lee@kernel.org" <lee@kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH] backlight: pwm_bl: Disable PWM on shutdown and suspend
 disabled PWM emiting inactive state")
Message-ID: <20230322085129.jxxz55tbcxkc6usd@pengutronix.de>
References: <DB9PR04MB84779AF9758B7FE747C6693D80869@DB9PR04MB8477.eurprd04.prod.outlook.com>
 <20230322070352.xfwmnqyrao3mifuu@pengutronix.de>
 <DB9PR04MB8477FD24740251860648786380869@DB9PR04MB8477.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnyoujtffpjsk2ms"
Content-Disposition: inline
In-Reply-To: <DB9PR04MB8477FD24740251860648786380869@DB9PR04MB8477.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lnyoujtffpjsk2ms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
per backlight toggle") calling pwm_backlight_power_off() doesn't disable
the PWM any more. However this is necessary to suspend, because PWM
drivers usually refuse to suspend if they are still enabled.

Also adapt shutdown to disable the PWM for similar reasons.

Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per backli=
ght toggle")
Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
On Wed, Mar 22, 2023 at 08:10:54AM +0000, Aisheng Dong wrote:
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Sent: 2023=E5=B9=B43=E6=9C=8822=E6=97=A5 15:04
> >=20
> > Hello,
> >=20
> > hmm, the subject is wrong, this is about commit deaeeda2051f
> > ("backlight: pwm_bl: Don't rely on a disabled PWM emiting inactive
> > state") and not 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only on=
ce
> > per backlight toggle"). I fixed it accordingly.
>=20
> I just double checked that only revert deaeeda2051f can't fix the issue.
> I have to revert 00e7e698bff1 as well.

Ah, I see, because of 00e7e698bff1 the pwm isn't modified any more if
only pwm_backlight_power_off() (but not pwm_backlight_update_status())
is called. But that is what the suspend callback (and also shutdown)
does.

> > On Wed, Mar 22, 2023 at 05:13:24AM +0000, Aisheng Dong wrote:
> > > It seems this patch changed the behavior of pwm_backlight_suspend a
> > > little bit in
> > > pwm_backlight_power_off() that pwm state keep unchanged during
> > suspend.
> > > Then pwm_imx_tpm_suspend() will return -Ebusy due to
> > tpm->enable_count > 0.
> > > Was this intended behavior? Should we fix pwm core or the driver?
> >=20
> > A I see. The problem is the combination of the following facts:
> >=20
> >  - Some PWMs don't emit a constant inactive signal when disabled, so a
> >    consumer who wants a constant inactive signal must not disable the
> >    PWM.
> >=20
> >  - A used PWM is supposed to be disabled by its consumer on suspend.
> >    (This is right IMHO because on suspend the PWM is likely to stop
> >    oscillating and if the consumer requested some output wave form a
> >    suspend usually stops to adhere to the consumer's request.)
> >=20
> > So the options to fix this are (in order of my preference):
> >=20
> >  a) Improve the check in the pwm_bl driver when it's safe to disable the
> >     PWM.
> >=20
> >  b) Disable the PWM on suspend in the pwm_bl driver.
> >=20
> >  c) If the pwm-imx-tpm's PWM output is configured with duty_cycle =3D 0=
 and
> >     is known not to continue driving a constant inactive signal on
> >     suspend, it might continue to suspend.
> >=20
> > I think a) is not possible in general. To determine that: Which machine=
 do you
> > experience this regression on?
>=20
> Imx7ulp evk.

OK, so a backlight with neither an enable-gpio nor a regulator. So this
is a configuration where the PWM isn't disabled any more when
brightness=3D0 is set. Iff the driver emits its inactive state when
disabled (for both polarities), it might disable if .duty_cycle =3D 0 is
requested to safe some power.

> > b) is the right one from the PWM framework's POV. If you have a PWM like
> > pwm-imx27 that might result in the backlight going on on suspend. That'=
s bad,
> > but compared to the pre-deaeeda2051f state it's still an improvement (as
> > there the backlight went on on disable *and* suspend).
> > Depending on the machine the backlight might or might not go off again =
later
> > when suspend progresses.
> >=20
>=20
> This seems like the previous working behavior on mx7ulp without this patc=
h.
> Would you help make a patch to fix it?

Sure. I expect this fixes your issue, but I didn't test it. So if you
give it a shot that would be great.

Best regards
Uwe

 drivers/video/backlight/pwm_bl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c
index fb388148d98f..577714e41694 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -643,8 +643,13 @@ static void pwm_backlight_shutdown(struct platform_dev=
ice *pdev)
 {
 	struct backlight_device *bl =3D platform_get_drvdata(pdev);
 	struct pwm_bl_data *pb =3D bl_get_data(bl);
+	struct pwm_state state;
=20
 	pwm_backlight_power_off(pb);
+	pwm_get_state(pb->pwm, &state);
+	state.duty_cycle =3D 0;
+	state.enabled =3D false;
+	pwm_apply_state(pb->pwm, &state);
 }
=20
 #ifdef CONFIG_PM_SLEEP
@@ -652,12 +657,24 @@ static int pwm_backlight_suspend(struct device *dev)
 {
 	struct backlight_device *bl =3D dev_get_drvdata(dev);
 	struct pwm_bl_data *pb =3D bl_get_data(bl);
+	struct pwm_state state;
=20
 	if (pb->notify)
 		pb->notify(pb->dev, 0);
=20
 	pwm_backlight_power_off(pb);
=20
+	/*
+	 * Note that disabling the PWM doesn't guarantee that the output stays
+	 * at its inactive state. However without the PWM disabled, the PWM
+	 * driver refuses to suspend. So disable here even though this might
+	 * enable the backlight on poorly designed boards.
+	 */
+	pwm_get_state(pb->pwm, &state);
+	state.duty_cycle =3D 0;
+	state.enabled =3D false;
+	pwm_apply_state(pb->pwm, &state);
+
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, 0);
=20
--=20
2.39.2

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lnyoujtffpjsk2ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQawZAACgkQj4D7WH0S
/k5oYwgAqmY82ymAX/xjQNTNnLZsaisXn7naE8efbMWtVc7RdEksnq8+N+DiPBj2
nMz+5ZUXoZFB+rMBIk08PDqK3NHecniotMHIt8nFhRsHT1AqmPKuzNu9Ezqos3cQ
IBFljFORVLcddhKnUYPqDA7Y3YlaTIlsswUCDzu+Wzx1LUzp4BjcSrhY60SMBi5C
allTJPpy+p6kTcq4VrVTKNZQn9nikvLtUvY6rAjjeHdLj/d+CQC6F7nxdVyYI5Oc
SPB1ogZFXTz0eC9TmgXDTuAO4vkbAywEhTFW89Sq7BprwIQaW1/dFBsHmTjWiJF2
dkxHpgUTh4DSckSKEMO+9dREMp2nvQ==
=WBYO
-----END PGP SIGNATURE-----

--lnyoujtffpjsk2ms--
