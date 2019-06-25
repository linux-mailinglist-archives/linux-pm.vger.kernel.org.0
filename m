Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D618B5267A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfFYIZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 04:25:17 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45845 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIZQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 04:25:16 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 84BD740008;
        Tue, 25 Jun 2019 08:25:07 +0000 (UTC)
Date:   Tue, 25 Jun 2019 10:25:07 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        edubezval@gmail.com, wens@csie.org, robh+dt@kernel.org,
        mchehab+samsung@kernel.org, rui.zhang@intel.com,
        paulmck@linux.ibm.com, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 08/11] thermal: sun8i: support ahb clocks
Message-ID: <20190625082507.mgycs6rzlxpvgqgu@flea>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
 <20190623164206.7467-9-tiny.windzz@gmail.com>
 <20190624182333.di7avywtdvzwukms@flea>
 <20190625003416.pxve36mrxmotg2bq@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ry5qotdx34xj2snb"
Content-Disposition: inline
In-Reply-To: <20190625003416.pxve36mrxmotg2bq@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ry5qotdx34xj2snb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2019 at 02:34:16AM +0200, Ond=C5=99ej Jirman wrote:
> On Mon, Jun 24, 2019 at 08:23:33PM +0200, Maxime Ripard wrote:
> > On Sun, Jun 23, 2019 at 12:42:03PM -0400, Yangtao Li wrote:
> > > H3 has extra clock, so introduce something in ths_thermal_chip/ths_de=
vice
> > > and adds the process of the clock.
> > >
> > > This is pre-work for supprt it.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_=
thermal.c
> > > index ed1c19bb27cf..04f53ffb6a14 100644
> > > --- a/drivers/thermal/sun8i_thermal.c
> > > +++ b/drivers/thermal/sun8i_thermal.c
> > > @@ -54,6 +54,7 @@ struct tsensor {
> > >  };
> > >
> > >  struct ths_thermal_chip {
> > > +	bool            has_ahb_clk;
> > >  	int		sensor_num;
> > >  	int		offset;
> > >  	int		scale;
> > > @@ -69,6 +70,7 @@ struct ths_device {
> > >  	struct regmap				*regmap;
> > >  	struct reset_control			*reset;
> > >  	struct clk				*bus_clk;
> > > +	struct clk                              *ahb_clk;
> >
> > Hmm, thinking a bit about this, the name of those two clocks doesn't
> > make sense. AHB is the bus being used to access that device, so the
> > bus clock is the AHB clock.
> >
> > What is that clock being used for?
>
> To control the A/D and sample averaging logic, I suppose. It's controlled=
 by the
> THS_CLK_REG (THS Clock Register) in H3 user manual.
>
> bus_clk controls THS_GATING in BUS_CLK_GATING_REG2 (THS module is connect=
ed to
> APB bus).
>
> I'd call it ths_clk and bus_clk.

Thanks. We've tried to make clock names a bit more generic and
consistent, so let's use mod instead.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ry5qotdx34xj2snb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRHaYwAKCRDj7w1vZxhR
xQrlAP9wwKwsQ2PbVvHGyuOJSFjRJZ9ASA22w83xIaKJDErjhgEAsmUAcw4APZyi
BhQMziRi3MAIeW70nBIvZFtQhI4YBwI=
=YZIB
-----END PGP SIGNATURE-----

--ry5qotdx34xj2snb--
