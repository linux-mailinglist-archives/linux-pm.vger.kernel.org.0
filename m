Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3704237C2A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfFFSXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 14:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbfFFSXg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 14:23:36 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D15F20872;
        Thu,  6 Jun 2019 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559845415;
        bh=uBH628PpMIXdWXns/puGxfoIumvbSwI35XKwjmJuMPI=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=pAMvr43M86UT2rG55Cqly5Tn4+ejdwFYUmkTyDUgTVX9PnwfMuUi1X7XfcKe8szEi
         rfDD1yuAV0bpfcGHhdnnBbjlfwJP2P4eXkiesvVyWpJirycBn8/bBrSBrdTLER4ReV
         hj49dvU7/xcvBAVugk2nadOfy48zsFnvITZS1pUU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <153579ddd7e6bd1e5c860a7a01115e47c78a1442.camel@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de> <20190606142255.29454-5-nsaenzjulienne@suse.de> <20190606170949.4A46720652@mail.kernel.org> <eb72a26b55cf17c29df6a7fd3c5def08182e00af.camel@suse.de> <20190606173609.2C3952083D@mail.kernel.org> <153579ddd7e6bd1e5c860a7a01115e47c78a1442.camel@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>, stefan.wahren@i2se.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 11:23:34 -0700
Message-Id: <20190606182335.1D15F20872@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Nicolas Saenz Julienne (2019-06-06 11:10:04)
> On Thu, 2019-06-06 at 10:36 -0700, Stephen Boyd wrote:
> > Quoting Nicolas Saenz Julienne (2019-06-06 10:22:16)
> > > Hi Stephen,
> > > Thanks for the review.
> > >=20
> > > On Thu, 2019-06-06 at 10:09 -0700, Stephen Boyd wrote:
> > > > Quoting Nicolas Saenz Julienne (2019-06-06 07:22:56)
> > > > > diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c
> > > > > b/drivers/cpufreq/raspberrypi-cpufreq.c
> > > > > new file mode 100644
> > > > > index 000000000000..99b59d5a50aa
> > > > > --- /dev/null
> > > > > +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> > > > [...]
> > > > > +
> > > > > +/*
> > > > > + * Since the driver depends on clk-raspberrypi, which may return
> > > > > EPROBE_DEFER,
> > > > > + * all the activity is performed in the probe, which may be defe=
red as
> > > > > well.
> > > > > + */
> > > > > +static struct platform_driver raspberrypi_cpufreq_driver =3D {
> > > > > +       .driver =3D {
> > > > > +               .name =3D "raspberrypi-cpufreq",
> > > > > +       },
> > > > > +       .probe          =3D raspberrypi_cpufreq_probe,
> > > > > +       .remove         =3D raspberrypi_cpufreq_remove,
> > > > > +};
> > > > > +module_platform_driver(raspberrypi_cpufreq_driver);
> > > >=20
> > > > How does this driver probe? Do you have a node in DT named
> > > > raspberrypi-cpufreq that matches and probes this? I would think this
> > > > would follow the drivers/cpufreq/cpufreq-dt-platdev.c design where =
it's
> > > > an initcall that probes the board compatible string.
> > > >=20
> > > > Or, if it depends on clk-raspberrypi probing, maybe it could create=
 the
> > > > platform device in that drivers probe function.
> > >=20
> > > Well you just reviewed that patch :)
> >=20
> > Ok. So what's your plan?
>=20
> So as discussed previously with the RPi mantainers, they preferred for the
> platform device for raspberrypi-clk to be created by the firmware interfa=
ce
> driver. IIRC Stefan said it was more flexible and the approach used with =
RPi's
> hwmon driver already. Also, it's not really clear whether this driver rea=
lly
> fits the device tree as it wouldn't be describing hardware.
>=20
> As far as raspberrypi-cpufreq is concerned the max and min frequencies are
> configurable in the firmware. So we can't really integrate cpufreq into t=
he
> device tree as we need to create the opp table dynamically. Hence the ded=
icated
> driver. On top of that the CPU might not have a clock during the init pro=
cess,
> as both the firmware interface and raspberrypi-clk can be compiled as mod=
ules.
> So I decided the simplest solution was to create the raspberrypi-cpufreq
> platform device at the end of raspberrypi-clk's probe.
>=20
> Once raspberrypi-cpufreq is loaded it queries the min/max frequencies,
> populates the CPU's opp table and creates an instance of cpufreq-dt. Which
> finally can operate, without the need of any dt info, as opp tables are
> populated and CPUs have a clock.
>=20
> I hope this makes it a little more clear :).
>=20

Yes, thanks. I see that largely follows the commit description so it
looks OK to me.

