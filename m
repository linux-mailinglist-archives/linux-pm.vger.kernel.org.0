Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F631C2F5B
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgECVKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 17:10:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgECVKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 17:10:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 95BF32A083E
Received: by earth.universe (Postfix, from userid 1000)
        id 823973C08C7; Sun,  3 May 2020 23:10:37 +0200 (CEST)
Date:   Sun, 3 May 2020 23:10:37 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] power: bq25890: protect view of the chip's state
Message-ID: <20200503211037.eovuhtugmg2vy4er@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <3291ca81bf8eb1b0401579ae08e7835e71dfc1ff.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avukksuw7xknvrq2"
Content-Disposition: inline
In-Reply-To: <3291ca81bf8eb1b0401579ae08e7835e71dfc1ff.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--avukksuw7xknvrq2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:11PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Extend bq->lock over whole updating of the chip's state. Might get
> useful later for switching ADC modes correctly.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 82 ++++++++------------------
>  1 file changed, 26 insertions(+), 56 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index c4a69fd69f34..9339e216651f 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -510,74 +510,50 @@ static int bq25890_get_chip_state(struct bq25890_de=
vice *bq,
>  	return 0;
>  }
> =20
> -static bool bq25890_state_changed(struct bq25890_device *bq,
> -				  struct bq25890_state *new_state)
> -{
> -	struct bq25890_state old_state;
> -
> -	mutex_lock(&bq->lock);
> -	old_state =3D bq->state;
> -	mutex_unlock(&bq->lock);
> -
> -	return (old_state.chrg_status !=3D new_state->chrg_status ||
> -		old_state.chrg_fault !=3D new_state->chrg_fault	||
> -		old_state.online !=3D new_state->online		||
> -		old_state.bat_fault !=3D new_state->bat_fault	||
> -		old_state.boost_fault !=3D new_state->boost_fault ||
> -		old_state.vsys_status !=3D new_state->vsys_status);
> -}
> -
> -static void bq25890_handle_state_change(struct bq25890_device *bq,
> -					struct bq25890_state *new_state)
> +static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
>  {
> +	struct bq25890_state new_state;
>  	int ret;
> -	struct bq25890_state old_state;
> =20
> -	mutex_lock(&bq->lock);
> -	old_state =3D bq->state;
> -	mutex_unlock(&bq->lock);
> +	ret =3D bq25890_get_chip_state(bq, &new_state);
> +	if (ret < 0)
> +		return IRQ_NONE;
> =20
> -	if (!new_state->online) {			     /* power removed */
> +	if (!memcmp(&bq->state, &new_state, sizeof(new_state)))
> +		return IRQ_NONE;
> +
> +	if (!new_state.online && bq->state.online) {	    /* power removed */
>  		/* disable ADC */
>  		ret =3D bq25890_field_write(bq, F_CONV_START, 0);
>  		if (ret < 0)
>  			goto error;
> -	} else if (!old_state.online) {			    /* power inserted */
> +	} else if (new_state.online && !bq->state.online) { /* power inserted */
>  		/* enable ADC, to have control of charge current/voltage */
>  		ret =3D bq25890_field_write(bq, F_CONV_START, 1);
>  		if (ret < 0)
>  			goto error;
>  	}
> =20
> -	return;
> +	bq->state =3D new_state;
> +	power_supply_changed(bq->charger);
> =20
> +	return IRQ_HANDLED;
>  error:
> -	dev_err(bq->dev, "Error communicating with the chip.\n");
> +	dev_err(bq->dev, "Error communicating with the chip: %pe\n",
> +		ERR_PTR(ret));
> +	return IRQ_HANDLED;
>  }
> =20
>  static irqreturn_t bq25890_irq_handler_thread(int irq, void *private)
>  {
>  	struct bq25890_device *bq =3D private;
> -	int ret;
> -	struct bq25890_state state;
> -
> -	ret =3D bq25890_get_chip_state(bq, &state);
> -	if (ret < 0)
> -		goto handled;
> -
> -	if (!bq25890_state_changed(bq, &state))
> -		goto handled;
> -
> -	bq25890_handle_state_change(bq, &state);
> +	irqreturn_t ret;
> =20
>  	mutex_lock(&bq->lock);
> -	bq->state =3D state;
> +	ret =3D __bq25890_handle_irq(bq);
>  	mutex_unlock(&bq->lock);
> =20
> -	power_supply_changed(bq->charger);
> -
> -handled:
> -	return IRQ_HANDLED;
> +	return ret;
>  }
> =20
>  static int bq25890_chip_reset(struct bq25890_device *bq)
> @@ -607,7 +583,6 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>  {
>  	int ret;
>  	int i;
> -	struct bq25890_state state;
> =20
>  	const struct {
>  		enum bq25890_fields id;
> @@ -655,16 +630,12 @@ static int bq25890_hw_init(struct bq25890_device *b=
q)
>  		return ret;
>  	}
> =20
> -	ret =3D bq25890_get_chip_state(bq, &state);
> +	ret =3D bq25890_get_chip_state(bq, &bq->state);
>  	if (ret < 0) {
>  		dev_dbg(bq->dev, "Get state failed %d\n", ret);
>  		return ret;
>  	}
> =20
> -	mutex_lock(&bq->lock);
> -	bq->state =3D state;
> -	mutex_unlock(&bq->lock);
> -
>  	return 0;
>  }
> =20
> @@ -1001,19 +972,16 @@ static int bq25890_suspend(struct device *dev)
>  static int bq25890_resume(struct device *dev)
>  {
>  	int ret;
> -	struct bq25890_state state;
>  	struct bq25890_device *bq =3D dev_get_drvdata(dev);
> =20
> -	ret =3D bq25890_get_chip_state(bq, &state);
> +	mutex_lock(&bq->lock);
> +
> +	ret =3D bq25890_get_chip_state(bq, &bq->state);
>  	if (ret < 0)
>  		return ret;
> =20
> -	mutex_lock(&bq->lock);
> -	bq->state =3D state;
> -	mutex_unlock(&bq->lock);
> -
>  	/* Re-enable ADC only if charger is plugged in. */
> -	if (state.online) {
> +	if (bq->state.online) {
>  		ret =3D bq25890_field_write(bq, F_CONV_START, 1);
>  		if (ret < 0)
>  			return ret;
> @@ -1022,6 +990,8 @@ static int bq25890_resume(struct device *dev)
>  	/* signal userspace, maybe state changed while suspended */
>  	power_supply_changed(bq->charger);
> =20
> +	mutex_unlock(&bq->lock);
> +
>  	return 0;
>  }
>  #endif
> --=20
> 2.20.1
>=20

--avukksuw7xknvrq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vM0cACgkQ2O7X88g7
+poI0BAAihCMYr96iK1zSZzrOUb6cFWbGTK9kk735UpGterCN8qlVqwEHZcOW5lw
TSL83l9sz3FwoYiMrZA98K4zY86slknBOmod7GcQjfEvWLQRQ7tWSrdUWcfNgC4u
2AZjFkenrUxXeTCqqTY3vLZEcTrBa9kznIr3kCdQsxLt3c9QgQ+xr33RwojmsFdJ
VMvnDopLfYF4kqMtf7oMSFH8c3Dmest/oFlg//k16VhliNyLGCcQnY8+swR4Lcc0
1uMWEAtyRQ5okupCpg7gu5HejB3er0NVf7KWSUrzjYdJxmuWIKSVQTO7oJgaP0lo
eVJ//Smin3bBNL0CrnsySPiEpMhgAhpF4Klc7hP78SyM92h080GQqzOq4Ej63Tj5
g3w5q0+oSqbgr0ekvnMrHwlLJk9mQX7516qFbIAP9fLQh7x/ZmGgpFgZdqOkzZ4B
qYR2fm/r5VARFOfJEIgQBk/0ChvUDe4wxckxVj2ZBvVlkBqnsVmhp9Mnr6Y5NMxH
4Tq8l35AtRrotAamV2NhffB1kB+NWuXOwgdQxmaTRyfz4yOyhOrbnEErBt7OZqKq
fnjW0L3+Kkl0LBgHciWLdPvpTf2cI8i//50spxIDU4aOeYoaIcyjLw4ish2ebyR5
1r1rfhB2H9DSmCLr/J10NTRCgWH7ejiwq2j0J/wsrLNOL6WTNAc=
=N5HG
-----END PGP SIGNATURE-----

--avukksuw7xknvrq2--
