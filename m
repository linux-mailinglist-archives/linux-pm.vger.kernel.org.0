Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DFE456E1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFNICK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 04:02:10 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46167 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfFNICK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 04:02:10 -0400
X-Originating-IP: 90.88.23.150
Received: from localhost (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 33ACCE000E;
        Fri, 14 Jun 2019 08:02:01 +0000 (UTC)
Date:   Fri, 14 Jun 2019 10:02:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
Message-ID: <20190614080200.fc3mah5q3mmihxa5@flea>
References: <20190525181329.18657-1-tiny.windzz@gmail.com>
 <20190525181329.18657-2-tiny.windzz@gmail.com>
 <20190527122752.uc7q6zkjti3zag4q@flea>
 <CAEExFWtxEB67Pv-8x4ry=tZcJjOD6Kxydq_YB73Gox25VmQn7A@mail.gmail.com>
 <20190612154325.m6z7xsxlpdq4wkxv@flea>
 <CAEExFWskAsNquULKBLtBFUOosNpks8L6aUhw-+cF=oZ0aghAtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dxk6xy5el3dsgg5j"
Content-Disposition: inline
In-Reply-To: <CAEExFWskAsNquULKBLtBFUOosNpks8L6aUhw-+cF=oZ0aghAtQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dxk6xy5el3dsgg5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jun 13, 2019 at 11:35:15PM +0800, Frank Lee wrote:
> On Thu, Jun 13, 2019 at 9:26 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Jun 07, 2019 at 09:34:44PM +0800, Frank Lee wrote:
> > > On Mon, May 27, 2019 at 8:27 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > +     ret = devm_request_threaded_irq(dev, irq, NULL,
> > > > > +                                     tmdev->chip->irq_thread,
> > > > > +                                     IRQF_ONESHOT, "ths", tmdev);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > >
> > > > Is there any particular reason to use a threaded interrupt?
> > >
> > > Just to improve real-time.
> >
> > What do you mean by real-time here? If anything, that will increase
> > the latency of the interrupts here.
> >
> > And in preempt-rt, regular top-half interrupts will be forced into a
> > threaded interrupt anyway.
> >
> > > > > +static int sun8i_ths_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct ths_device *tmdev = platform_get_drvdata(pdev);
> > > > > +
> > > > > +     clk_disable_unprepare(tmdev->bus_clk);
> > > >
> > > > I know that we discussed that already, but I'm not sure why you switch
> > > > back to a regular call to regmap_init_mmio, while regmap_init_mmio_clk
> > > > will take care of enabling and disabling the bus clock for you?
> > >
> > > It seems that regmap_init_mmio_clk just get clk and prepare clk
> > > but no enable.
> >
> > At init time, yes. But it will enable it only when you access the
> > registers, which is what you want anyway.
>
> But after accessing the register, it turns the clock off, which
> affects the ad conversion and the occurrence of the interrupt.

Ah, so that's how it works. Yeah, it makes sense then.

> In addition, when resuming from suspend, we need to enable
> the clock, so I think it is necessary to have a clock pointer.

Yep, indeed.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dxk6xy5el3dsgg5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQNUbwAKCRDj7w1vZxhR
xTHXAQDbQy0XDEjBIuIG+GZONRc1Ot+viplVAkNIuNN7+kFqRQD/VS0rr3UB9Kuc
LhxMlX6QWweIU+7DDpUsc+GtkieIvAY=
=PMaQ
-----END PGP SIGNATURE-----

--dxk6xy5el3dsgg5j--
