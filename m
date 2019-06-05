Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0193735953
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfFEJM3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 05:12:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:57824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfFEJM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 05:12:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27ABFAE16;
        Wed,  5 Jun 2019 09:12:27 +0000 (UTC)
Message-ID: <98f49600aa5adea62308a6fa23bca9b3a8007500.camel@suse.de>
Subject: Re: [PATCH 4/4] cpufreq: add driver for Raspbery Pi
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>, stefan.wahren@i2se.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
Date:   Wed, 05 Jun 2019 11:12:25 +0200
In-Reply-To: <87d0jszxxt.fsf@anholt.net>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
         <20190604173223.4229-5-nsaenzjulienne@suse.de> <87d0jszxxt.fsf@anholt.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YLOqxA/CMFHs8ZRZMhU9"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-YLOqxA/CMFHs8ZRZMhU9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 2019-06-04 at 17:18 -0700, Eric Anholt wrote:
> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
>=20
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
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Changes since RFC:
> >   - Alphabetically ordered relevant stuff
> >   - Updated Kconfig to select firmware interface
> >   - Correctly unref clk_dev after use
> >   - Remove all opps on failure
> >   - Remove use of dev_pm_opp_set_sharing_cpus()
> >=20
> >  drivers/cpufreq/Kconfig.arm           |  8 +++
> >  drivers/cpufreq/Makefile              |  1 +
> >  drivers/cpufreq/raspberrypi-cpufreq.c | 84 +++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+)
> >  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
> >=20
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index f8129edc145e..556d432cc826 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -133,6 +133,14 @@ config ARM_QCOM_CPUFREQ_HW
> >  	  The driver implements the cpufreq interface for this HW engine.
> >  	  Say Y if you want to support CPUFreq HW.
> > =20
> > +config ARM_RASPBERRYPI_CPUFREQ
> > +	tristate "Raspberry Pi cpufreq support"
> > +	select RASPBERRYPI_FIRMWARE
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
> > index 000000000000..2b3a195a9d37
> > --- /dev/null
> > +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> > @@ -0,0 +1,84 @@
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
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_opp.h>
> > +
> > +static const struct of_device_id machines[] __initconst =3D {
> > +	{ .compatible =3D "raspberrypi,3-model-b-plus" },
> > +	{ .compatible =3D "raspberrypi,3-model-b" },
> > +	{ .compatible =3D "raspberrypi,2-model-b" },
> > +	{ /* sentinel */ }
> > +};
>=20
> I think I'd skip the compatible string check here.  The firmware's
> clock-management should be well-tested by folks playing with clocking in
> the downstream tree.  There aren't any firmware differences in the
> processing of these clock management packets, to my recollection.

Fair enough, I'll remove it.

> Other than that, I'm happy with the series and would give it my
> acked-by.

Thanks!

Regads,
Nicolas


--=-YLOqxA/CMFHs8ZRZMhU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz3h3kACgkQlfZmHno8
x/6smgf/UUSqRVE6DWDoOngfdK1dV08nv36oNigDe6Wai1oez3OWjqVnoAwsgSRP
opyBaH52l/mUFOt+yUSfMDzq38C1DhBpgOIc/8loIZNlckblnOM+vzLjGb9e/90K
n2TevvBQhxHpjcA29ad/ss8kNdgDRxJYC8AXKCK/uUm0hjeAtuER2ZrBglGqwTmm
ZP3FU2xNX9FCVkAhI24x1frJaTRvrko29wvnu95ulGMbA1eUB7fn/A6rcA+O8kdK
oqzN7hSQdHaAWc3TFJvUwoP0RGFnMU/eTvPGghPyzOmQLg5th6fDsGTR7KFRYxeV
lqE6qbb0cP8Vw+wwR5iWF4GX9PgCJQ==
=W4hf
-----END PGP SIGNATURE-----

--=-YLOqxA/CMFHs8ZRZMhU9--

