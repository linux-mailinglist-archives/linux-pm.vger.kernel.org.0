Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27DD898F8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfHLItV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 04:49:21 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55959 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfHLItV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 04:49:21 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8E8D6200006;
        Mon, 12 Aug 2019 08:49:16 +0000 (UTC)
Date:   Mon, 12 Aug 2019 10:49:15 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v5 15/18] thermal: sun8i: allow to use custom temperature
 calculation function
Message-ID: <20190812084915.lasb4dh25bfeoigr@flea>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-16-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f4uotbkobwqxzt7r"
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-16-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f4uotbkobwqxzt7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Aug 10, 2019 at 05:28:26AM +0000, Yangtao Li wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> The H5 temperature calculation function is strange. Firstly, it's
> segmented. Secondly, the formula of two sensors are different in the
> second segment.
>
> Allow to use a custom temperature calculation function, in case of
> the function is complex.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

When you send a patch on someone else's behalf, you need to put your
Signed-off-by as well.

> ---
>  drivers/thermal/sun8i_thermal.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 3259081da841..a761e2afda08 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -76,6 +76,7 @@ struct ths_thermal_chip {
>  				     u16 *caldata, int callen);
>  	int		(*init)(struct ths_device *tmdev);
>  	int             (*irq_ack)(struct ths_device *tmdev);
> +	int		(*calc_temp)(int id, int reg);
>  };
>
>  struct ths_device {
> @@ -90,9 +91,12 @@ struct ths_device {
>
>  /* Temp Unit: millidegree Celsius */
>  static int sun8i_ths_reg2temp(struct ths_device *tmdev,
> -			      int reg)
> +			      int id, int reg)
>  {
> -	return (reg + tmdev->chip->offset) * tmdev->chip->scale;
> +	if (tmdev->chip->calc_temp)
> +		return tmdev->chip->calc_temp(id, reg);
> +	else
> +		return (reg + tmdev->chip->offset) * tmdev->chip->scale;

You're not consistent here compared to the other callbacks you have
introduced: calibrate, init and irq_ack all need to be set and will
fail (hard) if you don't set them, yet this one will have a different
behaviour (that behaviour being to use the H6 formula, which is the
latest SoC, which is a bit odd in itself).

I guess we should either make it mandatory as the rest of the
callbacks, or document which callbacks are mandatory and which are
optional (and the behaviour when it's optional).

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f4uotbkobwqxzt7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVEoCwAKCRDj7w1vZxhR
xfQmAP9xX6EXk3hDLg/bBSbrnJp6QkeJeiCQrfENROxox3MBTQD/Xm0PpUdxbQaF
HD4uZ6W1In3fv39oufKd/j0DlKZ5Lwc=
=i8aL
-----END PGP SIGNATURE-----

--f4uotbkobwqxzt7r--
