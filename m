Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD996439A1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfFMPPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 11:15:08 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44047 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbfFMN0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 09:26:10 -0400
X-Originating-IP: 90.88.159.246
Received: from localhost (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 48DD74000A;
        Thu, 13 Jun 2019 13:26:04 +0000 (UTC)
Date:   Wed, 12 Jun 2019 17:43:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
Message-ID: <20190612154325.m6z7xsxlpdq4wkxv@flea>
References: <20190525181329.18657-1-tiny.windzz@gmail.com>
 <20190525181329.18657-2-tiny.windzz@gmail.com>
 <20190527122752.uc7q6zkjti3zag4q@flea>
 <CAEExFWtxEB67Pv-8x4ry=tZcJjOD6Kxydq_YB73Gox25VmQn7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oy7r5ps7iphlasam"
Content-Disposition: inline
In-Reply-To: <CAEExFWtxEB67Pv-8x4ry=tZcJjOD6Kxydq_YB73Gox25VmQn7A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oy7r5ps7iphlasam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 09:34:44PM +0800, Frank Lee wrote:
> On Mon, May 27, 2019 at 8:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > +     ret = devm_request_threaded_irq(dev, irq, NULL,
> > > +                                     tmdev->chip->irq_thread,
> > > +                                     IRQF_ONESHOT, "ths", tmdev);
> > > +     if (ret)
> > > +             return ret;
> >
> > Is there any particular reason to use a threaded interrupt?
>
> Just to improve real-time.

What do you mean by real-time here? If anything, that will increase
the latency of the interrupts here.

And in preempt-rt, regular top-half interrupts will be forced into a
threaded interrupt anyway.

> > > +static int sun8i_ths_remove(struct platform_device *pdev)
> > > +{
> > > +     struct ths_device *tmdev = platform_get_drvdata(pdev);
> > > +
> > > +     clk_disable_unprepare(tmdev->bus_clk);
> >
> > I know that we discussed that already, but I'm not sure why you switch
> > back to a regular call to regmap_init_mmio, while regmap_init_mmio_clk
> > will take care of enabling and disabling the bus clock for you?
>
> It seems that regmap_init_mmio_clk just get clk and prepare clk
> but no enable.

At init time, yes. But it will enable it only when you access the
registers, which is what you want anyway.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--oy7r5ps7iphlasam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQEdnQAKCRDj7w1vZxhR
xXCpAQCYtE67+V1lgKQJZxd7NFi0spq61ecHzscNxJ/t6H+OXQD/ZYw/N1ST4pg3
MGrcJRd4vnNOs5alaAicdNFepVsmQQQ=
=g51D
-----END PGP SIGNATURE-----

--oy7r5ps7iphlasam--
