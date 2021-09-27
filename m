Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73905419454
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhI0Mfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 08:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhI0Mfv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 08:35:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCFC061575;
        Mon, 27 Sep 2021 05:34:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CB3791F42246
Received: by earth.universe (Postfix, from userid 1000)
        id 5CE603C0CA8; Mon, 27 Sep 2021 14:34:09 +0200 (CEST)
Date:   Mon, 27 Sep 2021 14:34:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org
Subject: Re: [patch 06/11] power: reset: ltc2952: Use hrtimer_forward_now()
Message-ID: <20210927123409.sl2ekpr3kcfqydar@earth.universe>
References: <20210923153311.225307347@linutronix.de>
 <20210923153339.746654947@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nvjiw4ieghtx42oh"
Content-Disposition: inline
In-Reply-To: <20210923153339.746654947@linutronix.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nvjiw4ieghtx42oh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 23, 2021 at 06:04:28PM +0200, Thomas Gleixner wrote:
> hrtimer_forward_now() provides the same functionality as the open coded
> hrtimer_forward() invocation. Prepares for removal of hrtimer_forward()
> from the public interfaces.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/reset/ltc2952-poweroff.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> --- a/drivers/power/reset/ltc2952-poweroff.c
> +++ b/drivers/power/reset/ltc2952-poweroff.c
> @@ -94,7 +94,6 @@ static struct ltc2952_poweroff *ltc2952_
>   */
>  static enum hrtimer_restart ltc2952_poweroff_timer_wde(struct hrtimer *t=
imer)
>  {
> -	ktime_t now;
>  	int state;
>  	struct ltc2952_poweroff *data =3D to_ltc2952(timer, timer_wde);
> =20
> @@ -104,8 +103,7 @@ static enum hrtimer_restart ltc2952_powe
>  	state =3D gpiod_get_value(data->gpio_watchdog);
>  	gpiod_set_value(data->gpio_watchdog, !state);
> =20
> -	now =3D hrtimer_cb_get_time(timer);
> -	hrtimer_forward(timer, now, data->wde_interval);
> +	hrtimer_forward_now(timer, data->wde_interval);
> =20
>  	return HRTIMER_RESTART;
>  }
>=20

--nvjiw4ieghtx42oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFRukEACgkQ2O7X88g7
+pqKFQ//T4fOnN3EQe4f7Pg4w++SqPoGhfrzFJUeAln5V4TpFHdHZGq4s7t6kZaK
GOXOBCyzGZ6jJEH5YRce4tdW3+01yIj4GBL1RmkM28AgFOfGEtqSmlsMSMOBn9xp
+q6CbOqWw5ZbbKPi3O9mbE5vcLKHR4tCpBxqDIbwG8FxHLuuKD2iUQ3MBoyU0ueW
fgO7dT1Y761yYtUg6/K50NhpjR/K5nendVqNkyBvy69h5ItqLGA8etK9oovMUaTj
7wHWiAq+S1uNCHN72DKJiXWh4CcssK1REPdGKF+c/Zpl74Cos6PYSFVgstfbdqbR
k7KugJPeZllc3gGiXLp5vre3bNKoahO2sNqNkDdFP84QGmEhl2dt222d89WbH/XB
0xw15rF4tFwFlXCwI60R5Fz4R+4FQhz3KWbQ3PZzTP5SD0LyMfTVn2sPtA9+FHlL
iGeutAwscHBSahlMwXP9BsfUwd5mFOV971ElszTuzLtdrOIXLtBHW0df6OBYi+1I
pUn4+D/KBTr7Y1rxrP95FPXoUwgxyqDly7pMhSUa/RiqB9um1MzLVbayF8hiE3lt
ASDwrGsWkOsgkeCPIen3H8ObaXO+d4ddnyeY2qAqgnj2GQg8F0ob6Dbg9WjBxump
kD7qNZioaB4CaOTypmfdr/AmVQIeS61vUmudIL1Pqt8piudrsqM=
=g6vN
-----END PGP SIGNATURE-----

--nvjiw4ieghtx42oh--
