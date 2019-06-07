Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66FBE3898D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfFGL6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 07:58:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:39404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbfFGL6B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 07:58:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32422AF19;
        Fri,  7 Jun 2019 11:57:59 +0000 (UTC)
Message-ID: <c1686c85beff2acbfec0b44fc2ad0e67099c6b94.camel@suse.de>
Subject: Re: [PATCH v2 4/7] cpufreq: add driver for Raspbery Pi
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
Date:   Fri, 07 Jun 2019 13:57:57 +0200
In-Reply-To: <c967bbfd-ce83-7c89-7f18-98f2c66aa333@i2se.com>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
         <20190606142255.29454-5-nsaenzjulienne@suse.de>
         <c967bbfd-ce83-7c89-7f18-98f2c66aa333@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-m2BvIrpJbVtYJFQFjMnr"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-m2BvIrpJbVtYJFQFjMnr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-07 at 13:42 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 06.06.19 um 16:22 schrieb Nicolas Saenz Julienne:
> > Raspberry Pi's firmware offers and interface though which update it's
> > performance requirements. It allows us to request for specific runtime
> > frequencies, which the firmware might or might not respect, depending o=
n
> > the firmware configuration and thermals.
> >=20
> > As the maximum and minimum frequencies are configurable in the firmware
> > there is no way to know in advance their values. So the Raspberry Pi
> > cpufreq driver queries them, builds an opp frequency table to then
> > launch cpufreq-dt.
> >=20
> > Also, as the firmware interface might be configured as a module, making
> > the cpu clock unavailable during init, this implements a full fledged
> > driver, as opposed to most drivers registering cpufreq-dt, which only
> > make use of an init routine.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Acked-by: Eric Anholt <eric@anholt.net>
> >=20
> > ---
> >=20
> > Changes since v1:
> >   - Remove compatible checks
> >   - Add module support, now full fledged driver
> >   - Use NULL in clk_get()
> >=20
> >  drivers/cpufreq/Kconfig.arm           |   8 +++
> >  drivers/cpufreq/Makefile              |   1 +
> >  drivers/cpufreq/raspberrypi-cpufreq.c | 100 ++++++++++++++++++++++++++
> >  3 files changed, 109 insertions(+)
> >  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
> >=20
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index f8129edc145e..5e9204d443ff 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -133,6 +133,14 @@ config ARM_QCOM_CPUFREQ_HW
> >  	  The driver implements the cpufreq interface for this HW engine.
> >  	  Say Y if you want to support CPUFreq HW.
> > =20
> > +config ARM_RASPBERRYPI_CPUFREQ
> > +	tristate "Raspberry Pi cpufreq support"
> > +	depends on CLK_RASPBERRYPI || COMPILE_TEST
> > +	help
> > +	  This adds the CPUFreq driver for Raspberry Pi
> > +
> > +	  If in doubt, say N.
> > +
> >  config ARM_S3C_CPUFREQ
> >  	bool
> >  	help
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 689b26c6f949..121c1acb66c0 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -64,6 +64,7 @@ obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+=3D pxa2xx-cpufreq.=
o
> >  obj-$(CONFIG_PXA3xx)			+=3D pxa3xx-cpufreq.o
> >  obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+=3D qcom-cpufreq-hw.o
> >  obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+=3D qcom-cpufreq-kryo.o
> > +obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+=3D raspberrypi-cpufreq.o
> >  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+=3D s3c2410-cpufreq.o
> >  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+=3D s3c2412-cpufreq.o
> >  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+=3D s3c2416-cpufreq.o
> > diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c
> > b/drivers/cpufreq/raspberrypi-cpufreq.c
> > new file mode 100644
> > index 000000000000..99b59d5a50aa
> > --- /dev/null
> > +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Raspberry Pi cpufreq driver
> > + *
> > + * Copyright (C) 2019, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/cpu.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_opp.h>
> > +
> > +static struct platform_device *cpufreq_dt;
> > +
> > +static int raspberrypi_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +	struct device *cpu_dev;
> > +	unsigned long min, max;
> > +	unsigned long rate;
> > +	struct clk *clk;
> > +	int ret;
> > +
> > +	cpu_dev =3D get_cpu_device(0);
> > +	if (!cpu_dev) {
> > +		pr_err("Cannot get CPU for cpufreq driver\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	clk =3D clk_get(cpu_dev, NULL);
> > +	if (IS_ERR(clk)) {
> > +		dev_err(cpu_dev, "Cannot get clock for CPU0\n");
> > +		return PTR_ERR(clk);
> > +	}
> > +
> > +	/*
> > +	 * The max and min frequencies are configurable in the Raspberry Pi
> > +	 * firmware, so we query them at runtime
> > +	 */
> > +	min =3D clk_round_rate(clk, 0);
> > +	max =3D clk_round_rate(clk, ULONG_MAX);
> > +	clk_put(clk);
> > +
> > +	for (rate =3D min; rate < max; rate +=3D 100000000) {
> > +		ret =3D dev_pm_opp_add(cpu_dev, rate, 0);
> > +		if (ret)
> > +			goto remove_opp;
> > +	}
>=20
> i played a little bit with my Raspberry Pi Zero W and this series. Looks
> fine so far.
>=20
> Sorry for this nitpicking, but i expect user questions about the
> differences between sysfs and vcgencmd measure_clock.
>=20
> scaling_available_frequencies gives
>=20
> 699999 799999 899999 999999
>=20
> but vcgencmd measure_clock return the rounded up values.
>=20
> I know we shouldn't fake anything, but adding the OPPs rounded up may
> avoid confusion.
>=20
> Stefan

Agree, I'll change this in v3.


--=-m2BvIrpJbVtYJFQFjMnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz6UUUACgkQlfZmHno8
x/7JCgf/Zk1fHhJfUoEiHOt3zSZ7agmFFGFgo6lyeQtztQd0/4Igo7AglYuknLit
NnXmmlyf7AtGDtkZo3KkNfc0s5NrMI5EiFc4z5zB0oAiUY/sFfThl2pBDxVEcTs6
1Vn7SLScGnKk7RMZKug58GnCg2FvrKogeouOHtoWDdw8jtnflsQK0U/TwQXg0Qk8
CVakyVtX6aSmhQyMih6/Ohn0RSfUUQQ8tQN/sZlujEIEWJjrmHAsMpWGUBVAi2se
Cn/XRt4o6vn9rx4bGyVURAjWyGjDM0OQAyojjqbd4864aDjwJFBpjyvG1a3s5BQA
JMTNhMuoEtBWIB/E182qN9Zgz2Y6RA==
=hgrI
-----END PGP SIGNATURE-----

--=-m2BvIrpJbVtYJFQFjMnr--

