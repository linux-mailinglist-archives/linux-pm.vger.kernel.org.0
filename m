Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1889034560
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfFDLZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:25:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfFDLZ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:25:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so8286996wrj.9;
        Tue, 04 Jun 2019 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lvcQvo1dL0ZC1d+EYzjKaa+0OOHuI5nTxQDS6FSwGQk=;
        b=nk4K9og7+4YBxV8FoGJ0oyWMXlnrH7Y4jRUAOu1tlCAN39qVmdy3pkxueqbYuR6eho
         cbMl9Vx5WsPoH7XfKGlPrGPt6/kOXsvqtRGkAraRVd1uqoNVwW04Sm6MGSdLAh2KV8SH
         rlKn8ektgdAeiqoE18rs9c0dk+wzxSh/MrZjX2HNpP/oFD2J8P2ZyOOZoj2PSRjOWnTK
         XFF0jCSrFjiEg8+pU7PU3iRs5aMf5FKXj7B04qrbkLO36qZvUSzVSKqq4hy43Nokd8YK
         eX68LjbL7ZXdU+nmyKDKt2ibg+6D1lquuz2cYS1QchpOrxQPn9rOJ7IyYpc+f3Aldvtm
         nayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lvcQvo1dL0ZC1d+EYzjKaa+0OOHuI5nTxQDS6FSwGQk=;
        b=F7mvOlkY75Ji40FDkiZt9KXu4RWYxbKvvefk2oMGE24hTlb5Q91syiHM6bVMbpQ4tv
         eCHYvltlzJaA9rYwwhfU9nsh5zUBivHU6/WwbCbXIHltSUEr41GQHkDEUmO209LPNtZa
         236fa7WhRw1WEiFRIniSgz1IJr8fp2RrRCyZvNm8+UQblgyBtn3xqjeOzdcPk6mnqYnH
         MjaparmhMGA5Vnz/bahWzXNQ/c3AvKQrRM57p7zgVwA96fdqSScm891i/bxRELMC2T2v
         IoTqUFbT4beFzrNY1dsyNzoZfPdb689/C3SbE0i3PTttSRLYDQBwJQ3dPUaILv4O0QUU
         wjgg==
X-Gm-Message-State: APjAAAWkTeNrrS6w81LAFn6SgDzWSZzMpTo5MXUVN+HTxstNddPFxlMr
        9t56i4xQdLz7JQb0CMZTdreA+r7f
X-Google-Smtp-Source: APXvYqxqrYdnjrNV0sIN9aOCKBdaH2Cz2G3JwSkzgBYhRzo6DTELUdNP0d2j9MiDXPyrEqsba6PlmQ==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr20026326wre.205.1559647526942;
        Tue, 04 Jun 2019 04:25:26 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id w14sm1551011wrt.59.2019.06.04.04.25.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:25:25 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:25:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/16] PM / devfreq: Introduce driver for NVIDIA
 Tegra20
Message-ID: <20190604112524.GP16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-17-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-17-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:15AM +0300, Dmitry Osipenko wrote:
> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
> reads out Memory Controller counters and adjusts memory frequency based
> on the memory clients activity.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  MAINTAINERS                       |   8 ++
>  drivers/devfreq/Kconfig           |  10 ++
>  drivers/devfreq/Makefile          |   1 +
>  drivers/devfreq/tegra20-devfreq.c | 212 ++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+)
>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98edc38bfd7b..e7e434f74038 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10098,6 +10098,14 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
> =20
> +MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
> +M:	Dmitry Osipenko <digetx@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
>  W:	http://www.linux-mm.org
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index a6bba6e1e7d9..1530dbefa31f 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -100,6 +100,16 @@ config ARM_TEGRA_DEVFREQ
>  	  It reads ACTMON counters of memory controllers and adjusts the
>  	  operating frequencies and voltages with OPP support.
> =20
> +config ARM_TEGRA20_DEVFREQ
> +	tristate "NVIDIA Tegra20 DEVFREQ Driver"
> +	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	select PM_OPP

Again, I'm not sure the COMPILE_TEST will work here unless you add a few
more dependencies.

Thierry

> +	help
> +	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
> +	  It reads Memory Controller counters and adjusts the operating
> +	  frequencies and voltages with OPP support.
> +
>  config ARM_RK3399_DMC_DEVFREQ
>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>  	depends on ARCH_ROCKCHIP
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 47e5aeeebfd1..338ae8440db6 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive=
=2Eo
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+=3D rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+=3D tegra30-devfreq.o
> +obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+=3D tegra20-devfreq.o
> =20
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+=3D event/
> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-=
devfreq.c
> new file mode 100644
> index 000000000000..ff82bac9ee4e
> --- /dev/null
> +++ b/drivers/devfreq/tegra20-devfreq.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVIDIA Tegra20 devfreq driver
> + *
> + * Copyright (C) 2019 GRATE-DRIVER project
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#include <soc/tegra/mc.h>
> +
> +#include "governor.h"
> +
> +#define MC_STAT_CONTROL				0x90
> +#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
> +#define MC_STAT_EMC_CLOCKS			0xa4
> +#define MC_STAT_EMC_CONTROL			0xa8
> +#define MC_STAT_EMC_COUNT			0xb8
> +
> +#define EMC_GATHER_CLEAR			(1 << 8)
> +#define EMC_GATHER_ENABLE			(3 << 8)
> +
> +struct tegra_devfreq {
> +	struct devfreq *devfreq;
> +	struct clk *emc_clock;
> +	void __iomem *regs;
> +};
> +
> +static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> +				u32 flags)
> +{
> +	struct tegra_devfreq *tegra =3D dev_get_drvdata(dev);
> +	struct devfreq *devfreq =3D tegra->devfreq;
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	int err;
> +
> +	opp =3D devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	rate =3D dev_pm_opp_get_freq(opp);
> +	dev_pm_opp_put(opp);
> +
> +	err =3D clk_set_min_rate(tegra->emc_clock, rate);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_set_rate(tegra->emc_clock, 0);
> +	if (err)
> +		goto restore_min_rate;
> +
> +	return 0;
> +
> +restore_min_rate:
> +	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
> +
> +	return err;
> +}
> +
> +static int tegra_devfreq_get_dev_status(struct device *dev,
> +					struct devfreq_dev_status *stat)
> +{
> +	struct tegra_devfreq *tegra =3D dev_get_drvdata(dev);
> +
> +	/*
> +	 * EMC_COUNT returns number of memory events, that number is lower
> +	 * than the number of clocks. Conversion ratio of 1/8 results in a
> +	 * bit higher bandwidth than actually needed, it is good enough for
> +	 * the time being because drivers don't support requesting minimum
> +	 * needed memory bandwidth yet.
> +	 *
> +	 * TODO: adjust the ratio value once relevant drivers will support
> +	 * memory bandwidth management.
> +	 */
> +	stat->busy_time =3D readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
> +	stat->total_time =3D readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / =
8;
> +	stat->current_frequency =3D clk_get_rate(tegra->emc_clock);
> +
> +	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
> +	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile tegra_devfreq_profile =3D {
> +	.polling_ms	=3D 500,
> +	.target		=3D tegra_devfreq_target,
> +	.get_dev_status	=3D tegra_devfreq_get_dev_status,
> +};
> +
> +static struct tegra_mc *tegra_get_memory_controller(void)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	struct tegra_mc *mc;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
> +	if (!np)
> +		return ERR_PTR(-ENOENT);
> +
> +	pdev =3D of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	mc =3D platform_get_drvdata(pdev);
> +	if (!mc)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return mc;
> +}
> +
> +static int tegra_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct tegra_devfreq *tegra;
> +	struct tegra_mc *mc;
> +	unsigned long max_rate;
> +	unsigned long rate;
> +	int err;
> +
> +	mc =3D tegra_get_memory_controller();
> +	if (IS_ERR(mc)) {
> +		err =3D PTR_ERR(mc);
> +		dev_err(&pdev->dev, "failed to get memory controller: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	tegra =3D devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> +	if (!tegra)
> +		return -ENOMEM;
> +
> +	/* EMC is a system-critical clock that is always enabled */
> +	tegra->emc_clock =3D devm_clk_get(&pdev->dev, "emc");
> +	if (IS_ERR(tegra->emc_clock)) {
> +		err =3D PTR_ERR(tegra->emc_clock);
> +		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
> +		return err;
> +	}
> +
> +	tegra->regs =3D mc->regs;
> +
> +	max_rate =3D clk_round_rate(tegra->emc_clock, ULONG_MAX);
> +
> +	for (rate =3D 0; rate <=3D max_rate; rate++) {
> +		rate =3D clk_round_rate(tegra->emc_clock, rate);
> +
> +		err =3D dev_pm_opp_add(&pdev->dev, rate, 0);
> +		if (err) {
> +			dev_err(&pdev->dev, "failed to add opp: %d\n", err);
> +			goto remove_opps;
> +		}
> +	}
> +
> +	/*
> +	 * Reset statistic gathers state, select global bandwidth for the
> +	 * statistics collection mode and set clocks counter saturation
> +	 * limit to maximum.
> +	 */
> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
> +	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);
> +
> +	platform_set_drvdata(pdev, tegra);
> +
> +	tegra->devfreq =3D devfreq_add_device(&pdev->dev, &tegra_devfreq_profil=
e,
> +					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
> +	if (IS_ERR(tegra->devfreq)) {
> +		err =3D PTR_ERR(tegra->devfreq);
> +		goto remove_opps;
> +	}
> +
> +	return 0;
> +
> +remove_opps:
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> +
> +	return err;
> +}
> +
> +static int tegra_devfreq_remove(struct platform_device *pdev)
> +{
> +	struct tegra_devfreq *tegra =3D platform_get_drvdata(pdev);
> +
> +	devfreq_remove_device(tegra->devfreq);
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tegra_devfreq_driver =3D {
> +	.probe		=3D tegra_devfreq_probe,
> +	.remove		=3D tegra_devfreq_remove,
> +	.driver		=3D {
> +		.name	=3D "tegra20-devfreq",
> +	},
> +};
> +module_platform_driver(tegra_devfreq_driver);
> +
> +MODULE_ALIAS("platform:tegra20-devfreq");
> +MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra20 devfreq driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.21.0
>=20

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2VSQACgkQ3SOs138+
s6Fpnw//ShKwtgVr1pHOxNmjT8I+pZUxGNzv6vi+49HAZRpNeatucR0WBoVRquK+
Xt/ZarB9driAZRg8UkbCb5i9HAKilBcWXfso1q+judg9jy34HFwX5U6qGQGylybJ
hNx87Nn+Gx4am7fYy6MMmmFH6xflA2dJHCABZlYlapbbXYJcVZHneZEIj5sDopVo
xOLK3BQvg426d7ArSfw+hXMBkrW4I32QbuRsqnblLRx2PUx0sjQnH3jQpM4nHaIX
5oK9hyGyYnfQiGR8amAwvkl9knffZa19MSIxH3b5u4ESXn78HyN9rWXzIfbutci9
cFzoKWj7Qw1m0Syo1IAEpySULsKydjaxZMJGXjwDytCUPcAyOfef72W8G8C5ixA1
6oYuG2H0OJWXHSViZzJImXP9vIO3eB+sShDLsc+qsei9hrHAaA+lELiozgL9N4/a
NWf9DuDjE1VnVhUmbUygW4GzNVY5tkJAKUBAGyqMvfrksWOvvrRY2M4jTdsy7vMA
i/2IN7noBl5TDtxUk2l2H1wp5ZRixjvLXa49ElAMgF4SB7+UuNU10rDqRWkgnGtQ
Q/+UZstvhaoHMBtZVXyC8COFaTUG3IHS12NQRxGxq5Ar1SkVWNpT7NCSqQOrtMfO
a6UkKzobei7mtYqPfmfHHW2HN87CL/xDmABbYoBO3oZO4q6gu5A=
=eJ30
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--
