Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217F937B24
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 19:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfFFRgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 13:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfFFRgJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 13:36:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C3952083D;
        Thu,  6 Jun 2019 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559842569;
        bh=pdq8qWIQe2AXVUfwDoQAl3L/f1GBHM2CtgEayvOOJOg=;
        h=In-Reply-To:References:To:Subject:From:Cc:Date:From;
        b=BwVfvF8v2Q979AL6mVsnn+nE3xjQrUjwkRimjqFEJhiFbEf8SR2T9nCVGTybohqdR
         AOoYSR0emcwc0BLcR1DkGl8wBOGZukuLZfVlGmkot+thcQ2z546O2TpYYmzUUHW5zj
         KTFdSDZq6kGs2i8xJJOqYFuh01E18mzPP7/+4R5Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eb72a26b55cf17c29df6a7fd3c5def08182e00af.camel@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de> <20190606142255.29454-5-nsaenzjulienne@suse.de> <20190606170949.4A46720652@mail.kernel.org> <eb72a26b55cf17c29df6a7fd3c5def08182e00af.camel@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>, stefan.wahren@i2se.com
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 10:36:08 -0700
Message-Id: <20190606173609.2C3952083D@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-06 10:22:16)
> Hi Stephen,
> Thanks for the review.
>=20
> On Thu, 2019-06-06 at 10:09 -0700, Stephen Boyd wrote:
> > Quoting Nicolas Saenz Julienne (2019-06-06 07:22:56)
> > > diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c
> > > b/drivers/cpufreq/raspberrypi-cpufreq.c
> > > new file mode 100644
> > > index 000000000000..99b59d5a50aa
> > > --- /dev/null
> > > +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> > [...]
> > > +
> > > +/*
> > > + * Since the driver depends on clk-raspberrypi, which may return
> > > EPROBE_DEFER,
> > > + * all the activity is performed in the probe, which may be defered =
as
> > > well.
> > > + */
> > > +static struct platform_driver raspberrypi_cpufreq_driver =3D {
> > > +       .driver =3D {
> > > +               .name =3D "raspberrypi-cpufreq",
> > > +       },
> > > +       .probe          =3D raspberrypi_cpufreq_probe,
> > > +       .remove         =3D raspberrypi_cpufreq_remove,
> > > +};
> > > +module_platform_driver(raspberrypi_cpufreq_driver);
> >=20
> > How does this driver probe? Do you have a node in DT named
> > raspberrypi-cpufreq that matches and probes this? I would think this
> > would follow the drivers/cpufreq/cpufreq-dt-platdev.c design where it's
> > an initcall that probes the board compatible string.
> >
> > Or, if it depends on clk-raspberrypi probing, maybe it could create the
> > platform device in that drivers probe function.
>=20
> Well you just reviewed that patch :)

Ok. So what's your plan?

>=20
> > > +
> > > +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
> > > +MODULE_DESCRIPTION("Raspberry Pi cpufreq driver");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_ALIAS("platform:raspberrypi-cpufreq");
> >=20
> > I don't think the module alias is needed anymore.
>=20
> That's surprising. I remember the driver not being loaded by udev without=
 it.
>=20

Maybe I'm wrong. Could be not needed for DT based platform devices with
an OF table.

