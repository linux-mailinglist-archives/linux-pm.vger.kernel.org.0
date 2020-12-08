Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D965B2D2894
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 11:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgLHKMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 05:12:03 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56893 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729063AbgLHKMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 05:12:02 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BA0B5C4E;
        Tue,  8 Dec 2020 05:10:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 08 Dec 2020 05:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=IZMTMn4wRKlczmZfBuLVqpHG2s4
        w07cs+psbge8qouM=; b=LDCcM9gWBuPYaWTmfEAB2bJcoP3GjzN0AxqnNTlXG2j
        Mq4qYhbj1RBOiW2WuzAdRFwOxOlzdJ4KXQjTKxXXJbL7NcB2IEtbEiejTfXi7Lj1
        PbPWz7TEE0NiP+vv5nlfbKNDM8W64dggqW7r85a+hTsk+Agr5bqe15jd+BtYv2kc
        nI55rjJxivHsvxGVuUXcwQu5W6eWN+IPFGNJLs9TzzjoKOgesdhK1ml100FuKM1W
        UPrTGrHlILU092nDWHDjaL8Z/0e82aLdSBYf9fcyC9BSI9aFbgGxCYvLRBD2b37+
        g3C73khigvSN/XpGuWRkMTG4lyezTfuCdldiGvyV3lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=IZMTMn
        4wRKlczmZfBuLVqpHG2s4w07cs+psbge8qouM=; b=g6ccMHznz2ANZ/wJfEXtEu
        1r0lnW/H4PfqDZBEdOnCSnbtiMe2MYEVHWvwPU8hHf4kyAVPcpZEjAG8wBXsoCaj
        /a6MofJxwtKWiyYJeTXxJHon23Q2fLmsgsu2SWKdyMM5d2AcmPCDWO3X+sM+rLac
        3V9V5VHZRKMxSH9A5ntete7QJMZFgofJDGCwmVrExWKWB9qlydtCK9DGRbeKiPLr
        +xAR0BzzRWO+2rVGm38QVHORqZCAX0iZcMdNjN6kYtyN9s0ibYJmskIYqmSdk4v3
        Nu90Qx5Y+3dnKpHhZP+wIyMJRyQaJkN2kZeJUPaYbJ+6cQUmsvt2kLApMGFfgTGg
        ==
X-ME-Sender: <xms:LlHPX5GBWcGUthXFlKdoH37tufBKJGG1WS2DwuERXhZ2DkAYGh1mBg>
    <xme:LlHPX-WMJjUEStaSAddJ-i9UgN5Qd-gApQzYnUvTx3EUphOH4HRI1KWAy0n_WxXi2
    otPkylAyoMSzjUbBkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:LlHPX7ITfLQMTg7ABdZ3uHQDJ_fhY4uvuXkZ8O7RA4R_uJ6e_ierRw>
    <xmx:LlHPX_G6gRv1P0MM6XcpxorEGhqTVXmPvEXE1tOe0DoHRF6IWgPlgQ>
    <xmx:LlHPX_XioNQF8RjyVILaWps0ddfWvhmqvFIpRGbyw8x1BLPluJh4XQ>
    <xmx:L1HPXxJt3ovzrzlRIV9tvnNJ8Rfs7bPDhFjoNdPOwh2JDCqI6wmptA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0301A1080057;
        Tue,  8 Dec 2020 05:10:53 -0500 (EST)
Date:   Tue, 8 Dec 2020 11:10:52 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] power: reset: new driver regulator-poweroff
Message-ID: <20201208101052.ecq2hbixxi45h4mr@gilmour>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
 <20201207142756.17819-2-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oq2ncswqe5ho6wm"
Content-Disposition: inline
In-Reply-To: <20201207142756.17819-2-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2oq2ncswqe5ho6wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 03:27:54PM +0100, Michael Klein wrote:
> This driver registers a pm_power_off function to disable a set of
> regulators defined in the devicetree to turn off the board.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  drivers/power/reset/Kconfig              |   7 ++
>  drivers/power/reset/Makefile             |   1 +
>  drivers/power/reset/regulator-poweroff.c | 107 +++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/power/reset/regulator-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index d55b3727e00e..ae6cb7b0bd4d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -177,6 +177,13 @@ config POWER_RESET_QNAP
> =20
>  	  Say Y if you have a QNAP NAS.
> =20
> +config POWER_RESET_REGULATOR
> +	bool "Regulator subsystem power-off driver"
> +	depends on OF && REGULATOR
> +	help
> +	  This driver supports turning off your board by disabling a set
> +	  of regulators defined in the devicetree.
> +
>  config POWER_RESET_RESTART
>  	bool "Restart power-off driver"
>  	help
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index c51eceba9ea3..9dc49d3a57ff 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-rese=
t.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
> +obj-$(CONFIG_POWER_RESET_REGULATOR) +=3D regulator-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
>  obj-$(CONFIG_POWER_RESET_ST) +=3D st-poweroff.o
>  obj-$(CONFIG_POWER_RESET_VERSATILE) +=3D arm-versatile-reboot.o
> diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/res=
et/regulator-poweroff.c
> new file mode 100644
> index 000000000000..df2ca4fdcc49
> --- /dev/null
> +++ b/drivers/power/reset/regulator-poweroff.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Force-disables a regulator to power down a device
> + *
> + * Michael Klein <michael@fossekall.de>
> + *
> + * Copyright (C) 2020 Michael Klein
> + *
> + * Based on the gpio-poweroff driver.
> + */
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define DEFAULT_TIMEOUT_MS 3000
> +
> +/*
> + * Hold configuration here, cannot be more than one instance of the driv=
er
> + * since pm_power_off itself is global.
> + */
> +static struct regulator **poweroff_regulators;
> +static u32 timeout =3D DEFAULT_TIMEOUT_MS;
> +
> +static void regulator_poweroff_do_poweroff(void)
> +{
> +	struct regulator **it;
> +
> +	if (poweroff_regulators)
> +		for (it =3D poweroff_regulators; *it; ++it)
> +			if (regulator_is_enabled(*it))
> +				regulator_force_disable(*it);
> +
> +	/* give it some time */
> +	mdelay(timeout);
> +
> +	WARN_ON(1);
> +}
> +
> +static int regulator_poweroff_probe(struct platform_device *pdev)
> +{
> +	int count;
> +	const char *name;
> +	struct regulator **it;
> +	struct property *prop;
> +	struct device_node *node =3D pdev->dev.of_node;
> +
> +	/* If a pm_power_off function has already been added, leave it alone */
> +	if (pm_power_off !=3D NULL) {
> +		dev_err(&pdev->dev,
> +			"%s: pm_power_off function already registered\n",
> +		       __func__);
> +		return -EBUSY;
> +	}
> +
> +	count =3D of_property_count_strings(node, "regulator-names");
> +	if (count <=3D 0)
> +		return -ENOENT;
> +
> +	poweroff_regulators =3D devm_kcalloc(&pdev->dev, count + 1,
> +		sizeof(struct regulator *), GFP_KERNEL);
> +
> +	it =3D poweroff_regulators;
> +	of_property_for_each_string(node, "regulator-names", prop, name) {
> +		*it =3D devm_regulator_get(&pdev->dev, name);
> +		if (IS_ERR(*it))
> +			return PTR_ERR(*it);
> +		it++;
> +	}
> +
> +	of_property_read_u32(node, "timeout-ms", &timeout);
> +
> +	pm_power_off =3D &regulator_poweroff_do_poweroff;
> +	return 0;
> +}
> +
> +static int regulator_poweroff_remove(__maybe_unused struct platform_devi=
ce *pdev)
> +{
> +	if (pm_power_off =3D=3D &regulator_poweroff_do_poweroff)
> +		pm_power_off =3D NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_regulator_poweroff_match[] =3D {
> +	{ .compatible =3D "regulator-poweroff", },
> +	{},
> +};
> +
> +static struct platform_driver regulator_poweroff_driver =3D {
> +	.probe =3D regulator_poweroff_probe,
> +	.remove =3D regulator_poweroff_remove,
> +	.driver =3D {
> +		.name =3D "poweroff-regulator",
> +		.of_match_table =3D of_regulator_poweroff_match,
> +	},
> +};
> +
> +module_platform_driver(regulator_poweroff_driver);

Since this can't be compiled as a module, you can use
module_platform_driver_probe instead.

Maxime

--2oq2ncswqe5ho6wm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX89RLAAKCRDj7w1vZxhR
xYtVAP0c0fzec8KxHO/a2lG5JN9lp/jXTsHoamD5+8e8G53xnwEAniwDyn2gvqjS
f1ceoeFITgRaS9n7Noj1lGaieeO0cwY=
=2QeK
-----END PGP SIGNATURE-----

--2oq2ncswqe5ho6wm--
