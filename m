Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D428354AA
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 02:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFEAS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 20:18:59 -0400
Received: from anholt.net ([50.246.234.109]:50678 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfFEAS6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 20:18:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F1D8510A04E7;
        Tue,  4 Jun 2019 17:18:57 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id v6jXS3FLFHVr; Tue,  4 Jun 2019 17:18:55 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A54C710A288F;
        Tue,  4 Jun 2019 17:18:55 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 280592FE3AAE; Tue,  4 Jun 2019 17:18:55 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mbrugger@suse.de, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] cpufreq: add driver for Raspbery Pi
In-Reply-To: <20190604173223.4229-5-nsaenzjulienne@suse.de>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de> <20190604173223.4229-5-nsaenzjulienne@suse.de>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 04 Jun 2019 17:18:54 -0700
Message-ID: <87d0jszxxt.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:

> Raspberry Pi's firmware offers and interface though which update it's
> performance requirements. It allows us to request for specific runtime
> frequencies, which the firmware might or might not respect, depending on
> the firmware configuration and thermals.
>
> As the maximum and minimum frequencies are configurable in the firmware
> there is no way to know in advance their values. So the Raspberry Pi
> cpufreq driver queries them, builds an opp frequency table to then
> launch cpufreq-dt.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> Changes since RFC:
>   - Alphabetically ordered relevant stuff
>   - Updated Kconfig to select firmware interface
>   - Correctly unref clk_dev after use
>   - Remove all opps on failure
>   - Remove use of dev_pm_opp_set_sharing_cpus()
>
>  drivers/cpufreq/Kconfig.arm           |  8 +++
>  drivers/cpufreq/Makefile              |  1 +
>  drivers/cpufreq/raspberrypi-cpufreq.c | 84 +++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index f8129edc145e..556d432cc826 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -133,6 +133,14 @@ config ARM_QCOM_CPUFREQ_HW
>  	  The driver implements the cpufreq interface for this HW engine.
>  	  Say Y if you want to support CPUFreq HW.
>=20=20
> +config ARM_RASPBERRYPI_CPUFREQ
> +	tristate "Raspberry Pi cpufreq support"
> +	select RASPBERRYPI_FIRMWARE
> +	help
> +	  This adds the CPUFreq driver for Raspberry Pi
> +
> +	  If in doubt, say N.
> +
>  config ARM_S3C_CPUFREQ
>  	bool
>  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 689b26c6f949..121c1acb66c0 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+=3D pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)			+=3D pxa3xx-cpufreq.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+=3D qcom-cpufreq-hw.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+=3D qcom-cpufreq-kryo.o
> +obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+=3D raspberrypi-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+=3D s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+=3D s3c2412-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+=3D s3c2416-cpufreq.o
> diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/rasp=
berrypi-cpufreq.c
> new file mode 100644
> index 000000000000..2b3a195a9d37
> --- /dev/null
> +++ b/drivers/cpufreq/raspberrypi-cpufreq.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Raspberry Pi cpufreq driver
> + *
> + * Copyright (C) 2019, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +
> +static const struct of_device_id machines[] __initconst =3D {
> +	{ .compatible =3D "raspberrypi,3-model-b-plus" },
> +	{ .compatible =3D "raspberrypi,3-model-b" },
> +	{ .compatible =3D "raspberrypi,2-model-b" },
> +	{ /* sentinel */ }
> +};

I think I'd skip the compatible string check here.  The firmware's
clock-management should be well-tested by folks playing with clocking in
the downstream tree.  There aren't any firmware differences in the
processing of these clock management packets, to my recollection.

Other than that, I'm happy with the series and would give it my
acked-by.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlz3Cm4ACgkQtdYpNtH8
nugFjg/7BW+vK+pRjIN9r/4ejWmipNwzyurktOyEn+OwCgwTSTkdlvGm/SllSKHr
3Y4BBLmSFf3xE87lNTkLmpkryi0LyBa1NokmCo0P21QoAkKpg4ZswtA+ti6o2cuR
oHw+cZ9o0sC3HvBFQknojZ7k/y91lROfQb/0h0FgE+9fQwpf/tfzazbSGHj8BF4x
Qil0ZEdJaw+dRzAJCSr250SGOqdifxcswEeIjesZZeR1uIOjgm74j9gEMrHagPQq
86Nq5RqOEe9eIUv7tADT+pFHFqQwmoWp5FSCgGxXhTraJlEf0O2bOUVWE9tXvovl
3Zz4vcEeyzUz5QTqVHERPyN4gbeHO+6x4QoRQeq7Z7GiIJKCMX74OkoGgNAIR0gT
N2gnGxiAcSyY8crQkfa4kdf7jCGEWLIkBHo1R2N4ee3yYZP3ncCQeL4YoJ/jv2gG
I6q9SzydecKAkQyQZaOElK3aJAIOdnuxs3H41r6lPhjB8B+ayevWUJL5ZkyVDlCr
Ic1HXmyvoTLZQ6/doXsnu9DFSiZj45kUjyymVpvUpoygu8KhcSIdnuuYoidNkvnv
bpSww6H3sFRU5b5CAPBM/kC7tnxzEK4kWIgZEqP7jA0vtv/2g08k0KwaqgPQDQDa
sBQ2QqaHMXDXVaDMFEnDFDeFDl8UwhpZqvIhiKwy7iU9LkRH/mE=
=V302
-----END PGP SIGNATURE-----
--=-=-=--
