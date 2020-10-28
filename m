Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5BE29D447
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgJ1Vux (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:50:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51889 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbgJ1Vuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:50:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 828AA5C010C;
        Wed, 28 Oct 2020 09:51:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 28 Oct 2020 09:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=XEi3b/ikOzRZVpcIsCkFHJrCB0T
        T9mRX4XPqsjVQReA=; b=fb7A58dUoMME0Qr6F9aQlgZriS/wrT+3poHSDO6y647
        JTBlMKVm7YbjpZpjHhumIwdng77By3lkD/Kit1AhYkSU5R4ygqtdbPDmRwrw6Ob/
        bLsURf4AHlaimAdwovgdk/a+XfwqCkgccJGa3AWFqSKL+RKq8j2l+Np5tRCxROZ3
        MB7OtZgz3/dkkwbZ5KQFvXzS7afMVzSrAsYJQQxjJubQDuFCjuvTQUFtPx86RL6i
        8ulfh3E+ApUMtx0MbEkVeeMHqUKPZOuCAFrp6dKDaMNFSIVQwgA79NF4xnoD/T/H
        AQv0jwO8bNdEUmH0bdApHeZavQXuYPcHvJN6DGze3jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XEi3b/
        ikOzRZVpcIsCkFHJrCB0TT9mRX4XPqsjVQReA=; b=Cb5ujczzgyomEnKfYrlyOX
        j7j5g8idPNdVYE4podVHeADBdkjjfNsQkY1Aw3eTOr4/DdiJuWCyCCL1iUe0m7ob
        0P3q9IZcVOjIfuhhQu/lInwu3zY+idQDDRrto12R5rSFLymr8QaqPrT+Y7a8/sVs
        jV1bRcFfRaWaTDx3hbMpy9TLbKvuqgigb5Ao1QV7iYnhwCsMXGzS3M1cWpt19aKf
        rLJM8eXT6xR/ORj3BvcH+q97sLOEI5k54a+bwoJMnHRdV7rYJFO/panrliniUoBl
        E7uO7Pj6CYyhqNK7+Kh5vsVOp+4Xs7em097359eOkQPa1p4rKyO8ZYmiuXzhpdUA
        ==
X-ME-Sender: <xms:U3eZXzbiXxIssPOos5U_6u1h3e0iVOtYKy3B7o7pzxV-5gvOLJHCbg>
    <xme:U3eZXybxzZ0FwymzrmCBjv1dGiFcSgw2lg7k8GSpcTKpO_giGXE7mlOPxS3j5eQcc
    7Ms_9DkCW_L7l3cwxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrledugdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:U3eZX18pwHGczpU3JJfeabsIIQDr3yPTahGofD8VPmpM-jfjsypzVA>
    <xmx:U3eZX5pjdN4rNg2LQyPLC8aiJ9W3t9EF4S6BjstCvc0MgoqiwMYo3Q>
    <xmx:U3eZX-qIRuO4WL6h53oAkUaLc2-U6FiNkUZMukBiZNge-AwL54ReOg>
    <xmx:VneZX-IQziRa6JmkEOZSGe0xbJHKNqjYxDCSvcqUythnZmmcuBnghA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E44E3328005D;
        Wed, 28 Oct 2020 09:51:14 -0400 (EDT)
Date:   Wed, 28 Oct 2020 14:51:13 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: sun8i: Use bitmap API instead of open code
Message-ID: <20201028135113.tpuofnv2eyaiqjc5@gilmour.lan>
References: <20201019115836.13982-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6recr47zk4glx63l"
Content-Disposition: inline
In-Reply-To: <20201019115836.13982-1-frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6recr47zk4glx63l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Mon, Oct 19, 2020 at 07:58:36PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Thw bitmap_* API is the standard way to access data in the bitfield.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 35 +++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_ther=
mal.c
> index f8b13071a6f4..f2e4a4f18101 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -8,6 +8,7 @@
>   * Based on the work of Josef Gajdusek <atx@atx.name>
>   */
> =20
> +#include <linux/bitmap.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> @@ -74,7 +75,7 @@ struct ths_thermal_chip {
>  	int		(*calibrate)(struct ths_device *tmdev,
>  				     u16 *caldata, int callen);
>  	int		(*init)(struct ths_device *tmdev);
> -	int             (*irq_ack)(struct ths_device *tmdev);
> +	void		(*irq_ack)(struct ths_device *tmdev);
>  	int		(*calc_temp)(struct ths_device *tmdev,
>  				     int id, int reg);
>  };
> @@ -82,6 +83,7 @@ struct ths_thermal_chip {
>  struct ths_device {
>  	const struct ths_thermal_chip		*chip;
>  	struct device				*dev;
> +	DECLARE_BITMAP(irq_bitmap, MAX_SENSOR_NUM);
>  	struct regmap				*regmap;
>  	struct reset_control			*reset;
>  	struct clk				*bus_clk;
> @@ -146,9 +148,11 @@ static const struct regmap_config config =3D {
>  	.max_register =3D 0xfc,
>  };
> =20
> -static int sun8i_h3_irq_ack(struct ths_device *tmdev)
> +static void sun8i_h3_irq_ack(struct ths_device *tmdev)
>  {
> -	int i, state, ret =3D 0;
> +	int i, state;
> +
> +	bitmap_zero(tmdev->irq_bitmap, tmdev->chip->sensor_num);
> =20
>  	regmap_read(tmdev->regmap, SUN8I_THS_IS, &state);
> =20
> @@ -156,16 +160,16 @@ static int sun8i_h3_irq_ack(struct ths_device *tmde=
v)
>  		if (state & SUN8I_THS_DATA_IRQ_STS(i)) {
>  			regmap_write(tmdev->regmap, SUN8I_THS_IS,
>  				     SUN8I_THS_DATA_IRQ_STS(i));
> -			ret |=3D BIT(i);
> +			bitmap_set(tmdev->irq_bitmap, i, 1);
>  		}
>  	}
> -
> -	return ret;
>  }
> =20
> -static int sun50i_h6_irq_ack(struct ths_device *tmdev)
> +static void sun50i_h6_irq_ack(struct ths_device *tmdev)
>  {
> -	int i, state, ret =3D 0;
> +	int i, state;
> +
> +	bitmap_zero(tmdev->irq_bitmap, tmdev->chip->sensor_num);
> =20
>  	regmap_read(tmdev->regmap, SUN50I_H6_THS_DIS, &state);
> =20
> @@ -173,24 +177,21 @@ static int sun50i_h6_irq_ack(struct ths_device *tmd=
ev)
>  		if (state & SUN50I_H6_THS_DATA_IRQ_STS(i)) {
>  			regmap_write(tmdev->regmap, SUN50I_H6_THS_DIS,
>  				     SUN50I_H6_THS_DATA_IRQ_STS(i));
> -			ret |=3D BIT(i);
> +			bitmap_set(tmdev->irq_bitmap, i, 1);
>  		}
>  	}
> -
> -	return ret;

The bitfield of the acked interrupts is mostly something internal to the
handler, so I'm not really convinced about sharing that through the
global structure.

With that being said...

>  }
> =20
>  static irqreturn_t sun8i_irq_thread(int irq, void *data)
>  {
>  	struct ths_device *tmdev =3D data;
> -	int i, state;
> +	int i;
> =20
> -	state =3D tmdev->chip->irq_ack(tmdev);
> +	tmdev->chip->irq_ack(tmdev);
> =20
> -	for (i =3D 0; i < tmdev->chip->sensor_num; i++) {
> -		if (state & BIT(i))
> -			thermal_zone_device_update(tmdev->sensor[i].tzd,
> -						   THERMAL_EVENT_UNSPECIFIED);
> +	for_each_set_bit(i, tmdev->irq_bitmap, tmdev->chip->sensor_num) {
> +		thermal_zone_device_update(tmdev->sensor[i].tzd,
> +					   THERMAL_EVENT_UNSPECIFIED);

=2E. for_each_set_bit is definitely cleaner and more readable.

Since it can operate on any unsigned long pointer, maybe we can just
make irq_ack return an unsigned long, and iterate over it here?

Maxime

--6recr47zk4glx63l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5l3UQAKCRDj7w1vZxhR
xQEKAP48BfIcj9Q8gxnE2YBEXYyU7tgQIfISkMi7dzn50h8wbwEA3yd3/OWl142x
5IZCV0EeZJVQ8kBG4+H8a/zJLoh7dgM=
=1WKP
-----END PGP SIGNATURE-----

--6recr47zk4glx63l--
