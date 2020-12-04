Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618142CF215
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgLDQmA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 11:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgLDQl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 11:41:57 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD87C061A52;
        Fri,  4 Dec 2020 08:41:17 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id ga15so9602572ejb.4;
        Fri, 04 Dec 2020 08:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M2XVxGZie5HRmCpQJUQTf3bEwLp0iblbGzUxF8xa7lU=;
        b=UI1nEYav51Hn4ujG5p/AvlH9PcGDcmgXdkxVBrOPGpXUraxv1g6jI9rBwl1kVC14fE
         ndHVmroDYjK2j5L0d67aLmi58bFJ9TqzJ5X85/hruKQHN6iYOUWzYvUNdignkEts48YZ
         36ythFzocoYRx4Zaq0Xoc5g2mLvhcf4UxDbhirw5AaAHqSV8wvzOzi7qN2gJY67rmgKZ
         avjUvA4lEVT0LnacUMCwlpPA9mBJ6vbXIWISxi3sCmSU5n8Wi0Y2E3RznQxjcV8TnVDz
         adZlp5cmwWZegiAzyCGaeHETF+GcFbt9euui60VbYrS78PwuUUk/kfY/fw2HV5MkIqm+
         KSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M2XVxGZie5HRmCpQJUQTf3bEwLp0iblbGzUxF8xa7lU=;
        b=fthdCtgcwniDAMz/zCcoWJqVm6S83PodQ580jfYKaOoEsQN2EYVlNKgTM0NFPDXaBq
         rK6R/Up/vGG3pPB5rfZNCG82GrqReviWQN/EqoTlyOzdVVvB98xH6BQJfKiu7xjsFWYY
         3+tv0r5v3CwCYMD8dasNjkvAMYlGvYGbJOCi36Il+3szRiUJ5SqZ2rkMCLixsYvdTRkD
         iI969wqDjucDfkadqzj1kxLVMSRotyHYZcg3YT2bFG+z+d6dl8Xomih0hptzS8yVgVXg
         Ciu7ABNe+RqFGCg1No4CsXfwzZq+cbXOUNQWeDZrX7Al29qalH/fKezXttU7DZQyetCl
         b2Yw==
X-Gm-Message-State: AOAM530eP/i0Aif0VF7eXSTYH/hT61AZ+Xmv5Rg8vxFjZliXv6TIKv87
        9804GHXy8JlaXvKhavyNZTQ=
X-Google-Smtp-Source: ABdhPJwOnDJdbYWgwHxG5698l0sPVH2yKo3jp0OGs5+eySbQWjwKIcydWjSDms7c8XbT0X1kIhTiPw==
X-Received: by 2002:a17:906:33c4:: with SMTP id w4mr7579886eja.380.1607100076059;
        Fri, 04 Dec 2020 08:41:16 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id u1sm3797220edf.65.2020.12.04.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:41:14 -0800 (PST)
Date:   Fri, 4 Dec 2020 17:41:13 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 04/10] memory: tegra124-emc: Make driver modular
Message-ID: <X8pmqVRFaBtkwDtr@ulmo>
References: <20201203192439.16177-1-digetx@gmail.com>
 <20201203192439.16177-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61ef+ZSvTD4BRcPI"
Content-Disposition: inline
In-Reply-To: <20201203192439.16177-5-digetx@gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--61ef+ZSvTD4BRcPI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 10:24:33PM +0300, Dmitry Osipenko wrote:
> Add modularization support to the Tegra124 EMC driver, which now can be
> compiled as a loadable kernel module.
>=20
> Note that EMC clock must be registered at clk-init time, otherwise PLLM
> will be disabled as unused clock at boot time if EMC driver is compiled
> as a module. Hence add a prepare/complete callbacks. similarly to what is
> done for the Tegra20/30 EMC drivers.
>=20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/Kconfig            |  3 ++
>  drivers/clk/tegra/Makefile           |  2 +-
>  drivers/clk/tegra/clk-tegra124-emc.c | 41 ++++++++++++++++++++++++----
>  drivers/clk/tegra/clk-tegra124.c     | 26 ++++++++++++++++--
>  drivers/clk/tegra/clk.h              | 18 ++++++++----
>  drivers/memory/tegra/Kconfig         |  3 +-
>  drivers/memory/tegra/tegra124-emc.c  | 31 ++++++++++++++-------
>  include/linux/clk/tegra.h            |  8 ++++++
>  include/soc/tegra/emc.h              | 16 -----------
>  9 files changed, 106 insertions(+), 42 deletions(-)
>  delete mode 100644 include/soc/tegra/emc.h
>=20
> diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
> index deaa4605824c..90df619dc087 100644
> --- a/drivers/clk/tegra/Kconfig
> +++ b/drivers/clk/tegra/Kconfig
> @@ -7,3 +7,6 @@ config TEGRA_CLK_DFLL
>  	depends on ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
>  	select PM_OPP
>  	def_bool y
> +
> +config TEGRA124_CLK_EMC
> +	bool
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index eec2313fd37e..7b1816856eb5 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -22,7 +22,7 @@ obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+=3D clk-tegra20-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+=3D clk-tegra114.o
>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D clk-tegra124.o
>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+=3D clk-tegra124-dfll-fcpu.o
> -obj-$(CONFIG_TEGRA124_EMC)		+=3D clk-tegra124-emc.o
> +obj-$(CONFIG_TEGRA124_CLK_EMC)		+=3D clk-tegra124-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+=3D clk-tegra124.o
>  obj-y					+=3D cvb.o
>  obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D clk-tegra210.o
> diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk=
-tegra124-emc.c
> index 745f9faa98d8..bdf6f4a51617 100644
> --- a/drivers/clk/tegra/clk-tegra124-emc.c
> +++ b/drivers/clk/tegra/clk-tegra124-emc.c
> @@ -11,7 +11,9 @@
>  #include <linux/clk-provider.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk/tegra.h>
>  #include <linux/delay.h>
> +#include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -21,7 +23,6 @@
>  #include <linux/string.h>
> =20
>  #include <soc/tegra/fuse.h>
> -#include <soc/tegra/emc.h>
> =20
>  #include "clk.h"
> =20
> @@ -80,6 +81,9 @@ struct tegra_clk_emc {
>  	int num_timings;
>  	struct emc_timing *timings;
>  	spinlock_t *lock;
> +
> +	tegra124_emc_prepare_timing_change_cb *prepare_timing_change;
> +	tegra124_emc_complete_timing_change_cb *complete_timing_change;
>  };
> =20
>  /* Common clock framework callback implementations */
> @@ -176,6 +180,9 @@ static struct tegra_emc *emc_ensure_emc_driver(struct=
 tegra_clk_emc *tegra)
>  	if (tegra->emc)
>  		return tegra->emc;
> =20
> +	if (!tegra->prepare_timing_change || !tegra->complete_timing_change)
> +		return NULL;
> +
>  	if (!tegra->emc_node)
>  		return NULL;
> =20
> @@ -241,7 +248,7 @@ static int emc_set_timing(struct tegra_clk_emc *tegra,
> =20
>  	div =3D timing->parent_rate / (timing->rate / 2) - 2;
> =20
> -	err =3D tegra_emc_prepare_timing_change(emc, timing->rate);
> +	err =3D tegra->prepare_timing_change(emc, timing->rate);
>  	if (err)
>  		return err;
> =20
> @@ -259,7 +266,7 @@ static int emc_set_timing(struct tegra_clk_emc *tegra,
> =20
>  	spin_unlock_irqrestore(tegra->lock, flags);
> =20
> -	tegra_emc_complete_timing_change(emc, timing->rate);
> +	tegra->complete_timing_change(emc, timing->rate);
> =20
>  	clk_hw_reparent(&tegra->hw, __clk_get_hw(timing->parent));
>  	clk_disable_unprepare(tegra->prev_parent);
> @@ -473,8 +480,8 @@ static const struct clk_ops tegra_clk_emc_ops =3D {
>  	.get_parent =3D emc_get_parent,
>  };
> =20
> -struct clk *tegra_clk_register_emc(void __iomem *base, struct device_nod=
e *np,
> -				   spinlock_t *lock)
> +struct clk *tegra124_clk_register_emc(void __iomem *base, struct device_=
node *np,
> +				      spinlock_t *lock)
>  {
>  	struct tegra_clk_emc *tegra;
>  	struct clk_init_data init;
> @@ -538,3 +545,27 @@ struct clk *tegra_clk_register_emc(void __iomem *bas=
e, struct device_node *np,
> =20
>  	return clk;
>  };
> +
> +void tegra124_clk_set_emc_callbacks(tegra124_emc_prepare_timing_change_c=
b *prep_cb,
> +				    tegra124_emc_complete_timing_change_cb *complete_cb)
> +{
> +	struct clk *clk =3D __clk_lookup("emc");
> +	struct tegra_clk_emc *tegra;
> +	struct clk_hw *hw;
> +
> +	if (clk) {
> +		hw =3D __clk_get_hw(clk);
> +		tegra =3D container_of(hw, struct tegra_clk_emc, hw);
> +
> +		tegra->prepare_timing_change =3D prep_cb;
> +		tegra->complete_timing_change =3D complete_cb;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(tegra124_clk_set_emc_callbacks);
> +
> +bool tegra124_clk_emc_driver_available(struct clk_hw *hw)
> +{
> +	struct tegra_clk_emc *tegra =3D container_of(hw, struct tegra_clk_emc, =
hw);
> +
> +	return tegra->prepare_timing_change && tegra->complete_timing_change;
> +}

This looks a bit hackish and I prefer the way this was done for
Tegra210. But that's mostly an implementation detail and we can always
restructure this if we want to.

> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-teg=
ra124.c
> index e931319dcc9d..934520aab6e3 100644
> --- a/drivers/clk/tegra/clk-tegra124.c
> +++ b/drivers/clk/tegra/clk-tegra124.c
> @@ -1500,6 +1500,26 @@ static void __init tegra124_132_clock_init_pre(str=
uct device_node *np)
>  	writel(plld_base, clk_base + PLLD_BASE);
>  }
> =20
> +static struct clk *tegra124_clk_src_onecell_get(struct of_phandle_args *=
clkspec,
> +						void *data)
> +{
> +	struct clk_hw *hw;
> +	struct clk *clk;
> +
> +	clk =3D of_clk_src_onecell_get(clkspec, data);
> +	if (IS_ERR(clk))
> +		return clk;
> +
> +	hw =3D __clk_get_hw(clk);
> +
> +	if (clkspec->args[0] =3D=3D TEGRA124_CLK_EMC) {
> +		if (!tegra124_clk_emc_driver_available(hw))
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	return clk;
> +}

Hm... why exactly do we need this? On Tegra210 and later, the EMC driver
is the only consumer of the EMC clock and since it also provides some of
the necessary parts to scale the EMC clock, that's a chicken and egg
problem. I'm not sure I fully understand how this is supposed to work
here and why we can't do this in a similar way than Tegra210.

Thierry

--61ef+ZSvTD4BRcPI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KZqYACgkQ3SOs138+
s6HElBAAmI+dncsQH9d1DsySeHPXmETkxQmW8BLKfmxK+RawFP7AsCRJrUARdZ4e
mcaGDF7v4uNfYPcYbB7214yifQCRkgaADjWNR+aA3w5IBKndPzgqhKWtgLRGo2c3
o7oQIM5BY4TFrdQKGTbIRcFgSOxqdyEDqNDgyeNM63TtcF3C1JDLge/7crd7VAQo
6bSQsP7dwuwBd17FZRbYA6xzXatAT4PwQEtoOXf58VMEsBu5Oxxdp7HnrEIiuJ84
OjpyfLQWUjRuGNpzDW5uDDhZ24cGeDquoT3bQrAc8r3o2gg0jMxufAQZqyXXT55N
4TO02x4XwG95NMA0wt/EQlkG5gld82EpKTTq0ORYK6cqXaPI3ZvmyOhDn2wDsfTN
Fai2/OxLCb2yLDA6Ays82+gdpB0sg/+NAZQJYlZB1SgD9wq/67DoXflM440cWs/N
OGGsSw9/xwtheZp54LcjWNpEkVVicWKZL25XtiQsN99P+hy9gw0amzRoZjdb+yG/
hoTaevLWYMh6oOGXI/gQs/OHWXdclSpR2kaX+K2u6mB7BOKt994OqEgsbvV7Ogfs
tcbraFsN9rcANLcmnM/DEKwJ58KjFxYRKLbbnljNoXhY/aMeIPdHAhbI/AClCn/x
hcrqsYc5dN+k7/08AdA9d0va8DZ+MS41VVlhGltcR9IgxMnkquo=
=M/bm
-----END PGP SIGNATURE-----

--61ef+ZSvTD4BRcPI--
