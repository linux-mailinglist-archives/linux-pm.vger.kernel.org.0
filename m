Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98114EF7B9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbiDAQMW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbiDAQKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 12:10:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EB2126581
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 08:35:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E222B1F47D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648827328;
        bh=Nro1y9GGMMCph1reIZ/vClksn/YbGrejFfCWlwfypmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QefqH6F0AmtdBA2p/CCcsmW9doi1H1eVVQYTf91NSKYD0GgJ++zi7dlzzcEacwgt4
         jFIZ2Cz74L8sV5BX+oJ+eOR7FLYeHGGYBtvc7ypOMknfJLMOoEGyAFsMFI+cKTNOvZ
         7W4euKtmsDz0TGNzX6Q6aRr/NBEYB2XbzsuBhe9204lBjCf26+/RCYPKYcqgwi9OH+
         v4RQCDn6i5yVefM/0ucnjXWdPOx4vKNnBgs1xGh79QmIXuWVuqbbP3lgrqhRjMLsn2
         PjQ6e798rqlZnG0JdH978qHRzk45SB/t4q5BSdoLLJD6KuMgHIMD0zE0CZaQY/MO4F
         kKmZ91EdWthNg==
Received: by mercury (Postfix, from userid 1000)
        id 8B04B1060582; Fri,  1 Apr 2022 17:35:25 +0200 (CEST)
Date:   Fri, 1 Apr 2022 17:35:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 6/6 v3] power: supply: Static data for Samsung batteries
Message-ID: <20220401153525.qhxyzj5gmh5mzghb@mercury.elektranox.org>
References: <20220225001314.1881549-1-linus.walleij@linaro.org>
 <20220225001314.1881549-7-linus.walleij@linaro.org>
 <20220331192045.GA21680@wintermute.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5umvzyqucxgj552y"
Content-Disposition: inline
In-Reply-To: <20220331192045.GA21680@wintermute.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5umvzyqucxgj552y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Mar 31, 2022 at 02:20:45PM -0500, Chris Morgan wrote:
> On Fri, Feb 25, 2022 at 01:13:14AM +0100, Linus Walleij wrote:
> > If we detect a Samsung SDI battery, we return a static
> > struct power_supply_battery_info and avoid looking further.
> >=20
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
>=20
> I'm afraid this patch breaks my (currently work-in-progress) battery
> driver for the rk817. I am not sure but I believe it might cause other
> issues too for other downstream drivers (I don't have a device to test,
> but I think maybe the ingenic driver looks like it could be affected
> too).

I assume this fixes the issue for you?

https://lore.kernel.org/linux-pm/20220329033226.535475-1-y.oudjana@protonma=
il.com/

I plan to send it to Linus for rc2.

Thanks,

-- Sebastian

>=20
> > ChangeLog v2->v3:
> > - Fix a whole bunch of tables after realizing that completely
> >   different battery data was used if CONFIG_SAMSUNG_BATTERY
> >   was set for Golden, Kyle, Codina and Skomer.
> > ChangeLog v1->v2:
> > - Bump tolerance to 40% on all BTI resistances
> > - Change config option to bool, as we are calling OUT from
> >   the supply core this cannot be compiled into a module
> > - Augment data to support low/high temperature charge current
> >   and voltages. Sadly the vendor tree just provide one and the
> >   same current and voltage for all of these.
> > ---
> >  drivers/power/supply/Kconfig               |   6 +
> >  drivers/power/supply/Makefile              |   1 +
> >  drivers/power/supply/power_supply_core.c   |  28 +-
> >  drivers/power/supply/samsung-sdi-battery.c | 919 +++++++++++++++++++++
> >  drivers/power/supply/samsung-sdi-battery.h |  13 +
> >  5 files changed, 957 insertions(+), 10 deletions(-)
> >  create mode 100644 drivers/power/supply/samsung-sdi-battery.c
> >  create mode 100644 drivers/power/supply/samsung-sdi-battery.h
> >=20
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 6815e5a4c0bd..e9df4151f2e0 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -181,6 +181,12 @@ config BATTERY_OLPC
> >  	help
> >  	  Say Y to enable support for the battery on the OLPC laptop.
> > =20
> > +config BATTERY_SAMSUNG_SDI
> > +	bool "Samsung SDI batteries"
> > +	help
> > +	  Say Y to enable support for Samsung SDI battery data.
> > +	  These batteries are used in Samsung mobile phones.
> > +
> >  config BATTERY_TOSA
> >  	tristate "Sharp SL-6000 (tosa) battery"
> >  	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
> > index 2c1b264b2046..ebcd2f5fe26d 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_GOLDFISH)	+=3D goldfish_battery.o
> >  obj-$(CONFIG_BATTERY_LEGO_EV3)	+=3D lego_ev3_battery.o
> >  obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
> >  obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
> > +obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+=3D samsung-sdi-battery.o
> >  obj-$(CONFIG_BATTERY_TOSA)	+=3D tosa_battery.o
> >  obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
> >  obj-$(CONFIG_BATTERY_INGENIC)	+=3D ingenic-battery.o
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/s=
upply/power_supply_core.c
> > index 1c0b1be22067..43c66214bedf 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/thermal.h>
> >  #include <linux/fixp-arith.h>
> >  #include "power_supply.h"
> > +#include "samsung-sdi-battery.h"
> > =20
> >  /* exported for the APM Power driver, APM emulation */
> >  struct class *power_supply_class;
> > @@ -573,6 +574,23 @@ int power_supply_get_battery_info(struct power_sup=
ply *psy,
> >  	int err, len, index;
> >  	const __be32 *list;
> > =20
> > +	if (!psy->of_node) {
> > +		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> > +			 __func__);
> > +		return -ENXIO;
> > +	}
> > +
> > +	battery_np =3D of_parse_phandle(psy->of_node, "monitored-battery", 0);
> > +	if (!battery_np)
> > +		return -ENODEV;
> > +
> > +	/* Try static batteries first */
> > +	err =3D samsung_sdi_battery_get_info(&psy->dev, battery_np, &info);
> If the device isn't a Samsung battery this puts -ENODEV in the err variab=
le.
> For my case I have a simple-battery that isn't a Samsung battery, and it
> is causing power_supply_get_battery_info to return an error.
>=20
> > +	if (!err) {
> > +		*info_out =3D info;
> > +		return err;
> > +	}
> > +
> >  	info =3D devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> >  	if (!info)
> >  		return -ENOMEM;
> > @@ -612,16 +630,6 @@ int power_supply_get_battery_info(struct power_sup=
ply *psy,
> >  		info->ocv_table_size[index]  =3D -EINVAL;
> >  	}
> > =20
> > -	if (!psy->of_node) {
> > -		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> > -			 __func__);
> > -		return -ENXIO;
> > -	}
> > -
> > -	battery_np =3D of_parse_phandle(psy->of_node, "monitored-battery", 0);
> > -	if (!battery_np)
> > -		return -ENODEV;
> > -
> >  	err =3D of_property_read_string(battery_np, "compatible", &value);
> >  	if (err)
> >  		goto out_put_node;
> > diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power=
/supply/samsung-sdi-battery.c
> > new file mode 100644
> > index 000000000000..8e718f0fc2b5
> > --- /dev/null
> > +++ b/drivers/power/supply/samsung-sdi-battery.c
> > @@ -0,0 +1,919 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Battery data and characteristics for Samsung SDI (Samsung Digital I=
nterface)
> > + * batteries. The data is retrieved automatically into drivers using
> > + * the power_supply_get_battery_info() call.
> > + *
> > + * The BTI (battery type indicator) resistance in the code drops was v=
ery
> > + * unreliable. The resistance listed here was obtained by simply measu=
ring
> > + * the BTI resistance with a multimeter on the battery.
> > + */
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/power_supply.h>
> > +#include "samsung-sdi-battery.h"
> > +
> > +struct samsung_sdi_battery {
> > +	char *compatible;
> > +	char *name;
> > +	struct power_supply_battery_info info;
> > +};
> > +
> > +/*
> > + * Voltage to internal resistance tables. The internal resistance vari=
es
> > + * depending on the VBAT voltage, so look this up from a table. Differ=
ent
> > + * tables apply depending on whether we are charging or not.
> > + */
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb_l1m7=
flu[] =3D {
> > +	{ .vbat_uv =3D 4240000, .ri_uohm =3D 160000 },
> > +	{ .vbat_uv =3D 4210000, .ri_uohm =3D 179000 },
> > +	{ .vbat_uv =3D 4180000, .ri_uohm =3D 183000 },
> > +	{ .vbat_uv =3D 4160000, .ri_uohm =3D 184000 },
> > +	{ .vbat_uv =3D 4140000, .ri_uohm =3D 191000 },
> > +	{ .vbat_uv =3D 4120000, .ri_uohm =3D 204000 },
> > +	{ .vbat_uv =3D 4076000, .ri_uohm =3D 220000 },
> > +	{ .vbat_uv =3D 4030000, .ri_uohm =3D 227000 },
> > +	{ .vbat_uv =3D 3986000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 3916000, .ri_uohm =3D 221000 },
> > +	{ .vbat_uv =3D 3842000, .ri_uohm =3D 259000 },
> > +	{ .vbat_uv =3D 3773000, .ri_uohm =3D 287000 },
> > +	{ .vbat_uv =3D 3742000, .ri_uohm =3D 283000 },
> > +	{ .vbat_uv =3D 3709000, .ri_uohm =3D 277000 },
> > +	{ .vbat_uv =3D 3685000, .ri_uohm =3D 297000 },
> > +	{ .vbat_uv =3D 3646000, .ri_uohm =3D 310000 },
> > +	{ .vbat_uv =3D 3616000, .ri_uohm =3D 331000 },
> > +	{ .vbat_uv =3D 3602000, .ri_uohm =3D 370000 },
> > +	{ .vbat_uv =3D 3578000, .ri_uohm =3D 350000 },
> > +	{ .vbat_uv =3D 3553000, .ri_uohm =3D 321000 },
> > +	{ .vbat_uv =3D 3503000, .ri_uohm =3D 322000 },
> > +	{ .vbat_uv =3D 3400000, .ri_uohm =3D 269000 },
> > +	{ .vbat_uv =3D 3360000, .ri_uohm =3D 328000 },
> > +	{ .vbat_uv =3D 3330000, .ri_uohm =3D 305000 },
> > +	{ .vbat_uv =3D 3300000, .ri_uohm =3D 339000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb_l1m7flu=
[] =3D {
> > +	{ .vbat_uv =3D 4302000, .ri_uohm =3D 230000 },
> > +	{ .vbat_uv =3D 4276000, .ri_uohm =3D 345000 },
> > +	{ .vbat_uv =3D 4227000, .ri_uohm =3D 345000 },
> > +	{ .vbat_uv =3D 4171000, .ri_uohm =3D 346000 },
> > +	{ .vbat_uv =3D 4134000, .ri_uohm =3D 311000 },
> > +	{ .vbat_uv =3D 4084000, .ri_uohm =3D 299000 },
> > +	{ .vbat_uv =3D 4052000, .ri_uohm =3D 316000 },
> > +	{ .vbat_uv =3D 4012000, .ri_uohm =3D 309000 },
> > +	{ .vbat_uv =3D 3961000, .ri_uohm =3D 303000 },
> > +	{ .vbat_uv =3D 3939000, .ri_uohm =3D 280000 },
> > +	{ .vbat_uv =3D 3904000, .ri_uohm =3D 261000 },
> > +	{ .vbat_uv =3D 3850000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 232000 },
> > +	{ .vbat_uv =3D 3750000, .ri_uohm =3D 177000 },
> > +	{ .vbat_uv =3D 3712000, .ri_uohm =3D 164000 },
> > +	{ .vbat_uv =3D 3674000, .ri_uohm =3D 161000 },
> > +	{ .vbat_uv =3D 3590000, .ri_uohm =3D 164000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb42516=
1la[] =3D {
> > +	{ .vbat_uv =3D 4240000, .ri_uohm =3D 160000 },
> > +	{ .vbat_uv =3D 4210000, .ri_uohm =3D 179000 },
> > +	{ .vbat_uv =3D 4180000, .ri_uohm =3D 183000 },
> > +	{ .vbat_uv =3D 4160000, .ri_uohm =3D 184000 },
> > +	{ .vbat_uv =3D 4140000, .ri_uohm =3D 191000 },
> > +	{ .vbat_uv =3D 4120000, .ri_uohm =3D 204000 },
> > +	{ .vbat_uv =3D 4080000, .ri_uohm =3D 200000 },
> > +	{ .vbat_uv =3D 4027000, .ri_uohm =3D 202000 },
> > +	{ .vbat_uv =3D 3916000, .ri_uohm =3D 221000 },
> > +	{ .vbat_uv =3D 3842000, .ri_uohm =3D 259000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 262000 },
> > +	{ .vbat_uv =3D 3742000, .ri_uohm =3D 263000 },
> > +	{ .vbat_uv =3D 3709000, .ri_uohm =3D 277000 },
> > +	{ .vbat_uv =3D 3685000, .ri_uohm =3D 312000 },
> > +	{ .vbat_uv =3D 3668000, .ri_uohm =3D 258000 },
> > +	{ .vbat_uv =3D 3660000, .ri_uohm =3D 247000 },
> > +	{ .vbat_uv =3D 3636000, .ri_uohm =3D 293000 },
> > +	{ .vbat_uv =3D 3616000, .ri_uohm =3D 331000 },
> > +	{ .vbat_uv =3D 3600000, .ri_uohm =3D 349000 },
> > +	{ .vbat_uv =3D 3593000, .ri_uohm =3D 345000 },
> > +	{ .vbat_uv =3D 3585000, .ri_uohm =3D 344000 },
> > +	{ .vbat_uv =3D 3572000, .ri_uohm =3D 336000 },
> > +	{ .vbat_uv =3D 3553000, .ri_uohm =3D 321000 },
> > +	{ .vbat_uv =3D 3517000, .ri_uohm =3D 336000 },
> > +	{ .vbat_uv =3D 3503000, .ri_uohm =3D 322000 },
> > +	{ .vbat_uv =3D 3400000, .ri_uohm =3D 269000 },
> > +	{ .vbat_uv =3D 3360000, .ri_uohm =3D 328000 },
> > +	{ .vbat_uv =3D 3330000, .ri_uohm =3D 305000 },
> > +	{ .vbat_uv =3D 3300000, .ri_uohm =3D 339000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161la=
[] =3D {
> > +	{ .vbat_uv =3D 4345000, .ri_uohm =3D 230000 },
> > +	{ .vbat_uv =3D 4329000, .ri_uohm =3D 238000 },
> > +	{ .vbat_uv =3D 4314000, .ri_uohm =3D 225000 },
> > +	{ .vbat_uv =3D 4311000, .ri_uohm =3D 239000 },
> > +	{ .vbat_uv =3D 4294000, .ri_uohm =3D 235000 },
> > +	{ .vbat_uv =3D 4264000, .ri_uohm =3D 229000 },
> > +	{ .vbat_uv =3D 4262000, .ri_uohm =3D 228000 },
> > +	{ .vbat_uv =3D 4252000, .ri_uohm =3D 236000 },
> > +	{ .vbat_uv =3D 4244000, .ri_uohm =3D 234000 },
> > +	{ .vbat_uv =3D 4235000, .ri_uohm =3D 234000 },
> > +	{ .vbat_uv =3D 4227000, .ri_uohm =3D 238000 },
> > +	{ .vbat_uv =3D 4219000, .ri_uohm =3D 242000 },
> > +	{ .vbat_uv =3D 4212000, .ri_uohm =3D 239000 },
> > +	{ .vbat_uv =3D 4206000, .ri_uohm =3D 231000 },
> > +	{ .vbat_uv =3D 4201000, .ri_uohm =3D 231000 },
> > +	{ .vbat_uv =3D 4192000, .ri_uohm =3D 224000 },
> > +	{ .vbat_uv =3D 4184000, .ri_uohm =3D 238000 },
> > +	{ .vbat_uv =3D 4173000, .ri_uohm =3D 245000 },
> > +	{ .vbat_uv =3D 4161000, .ri_uohm =3D 244000 },
> > +	{ .vbat_uv =3D 4146000, .ri_uohm =3D 244000 },
> > +	{ .vbat_uv =3D 4127000, .ri_uohm =3D 228000 },
> > +	{ .vbat_uv =3D 4119000, .ri_uohm =3D 218000 },
> > +	{ .vbat_uv =3D 4112000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 4108000, .ri_uohm =3D 209000 },
> > +	{ .vbat_uv =3D 4102000, .ri_uohm =3D 214000 },
> > +	{ .vbat_uv =3D 4096000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 4090000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 4083000, .ri_uohm =3D 219000 },
> > +	{ .vbat_uv =3D 4078000, .ri_uohm =3D 208000 },
> > +	{ .vbat_uv =3D 4071000, .ri_uohm =3D 205000 },
> > +	{ .vbat_uv =3D 4066000, .ri_uohm =3D 208000 },
> > +	{ .vbat_uv =3D 4061000, .ri_uohm =3D 210000 },
> > +	{ .vbat_uv =3D 4055000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 4049000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 4042000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 4032000, .ri_uohm =3D 217000 },
> > +	{ .vbat_uv =3D 4027000, .ri_uohm =3D 220000 },
> > +	{ .vbat_uv =3D 4020000, .ri_uohm =3D 210000 },
> > +	{ .vbat_uv =3D 4013000, .ri_uohm =3D 214000 },
> > +	{ .vbat_uv =3D 4007000, .ri_uohm =3D 219000 },
> > +	{ .vbat_uv =3D 4003000, .ri_uohm =3D 229000 },
> > +	{ .vbat_uv =3D 3996000, .ri_uohm =3D 246000 },
> > +	{ .vbat_uv =3D 3990000, .ri_uohm =3D 245000 },
> > +	{ .vbat_uv =3D 3984000, .ri_uohm =3D 242000 },
> > +	{ .vbat_uv =3D 3977000, .ri_uohm =3D 236000 },
> > +	{ .vbat_uv =3D 3971000, .ri_uohm =3D 231000 },
> > +	{ .vbat_uv =3D 3966000, .ri_uohm =3D 229000 },
> > +	{ .vbat_uv =3D 3952000, .ri_uohm =3D 226000 },
> > +	{ .vbat_uv =3D 3946000, .ri_uohm =3D 222000 },
> > +	{ .vbat_uv =3D 3941000, .ri_uohm =3D 222000 },
> > +	{ .vbat_uv =3D 3936000, .ri_uohm =3D 217000 },
> > +	{ .vbat_uv =3D 3932000, .ri_uohm =3D 217000 },
> > +	{ .vbat_uv =3D 3928000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3926000, .ri_uohm =3D 214000 },
> > +	{ .vbat_uv =3D 3922000, .ri_uohm =3D 209000 },
> > +	{ .vbat_uv =3D 3917000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 3914000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3912000, .ri_uohm =3D 220000 },
> > +	{ .vbat_uv =3D 3910000, .ri_uohm =3D 226000 },
> > +	{ .vbat_uv =3D 3903000, .ri_uohm =3D 226000 },
> > +	{ .vbat_uv =3D 3891000, .ri_uohm =3D 222000 },
> > +	{ .vbat_uv =3D 3871000, .ri_uohm =3D 221000 },
> > +	{ .vbat_uv =3D 3857000, .ri_uohm =3D 219000 },
> > +	{ .vbat_uv =3D 3850000, .ri_uohm =3D 216000 },
> > +	{ .vbat_uv =3D 3843000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3835000, .ri_uohm =3D 206000 },
> > +	{ .vbat_uv =3D 3825000, .ri_uohm =3D 217000 },
> > +	{ .vbat_uv =3D 3824000, .ri_uohm =3D 220000 },
> > +	{ .vbat_uv =3D 3820000, .ri_uohm =3D 237000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 232000 },
> > +	{ .vbat_uv =3D 3750000, .ri_uohm =3D 177000 },
> > +	{ .vbat_uv =3D 3712000, .ri_uohm =3D 164000 },
> > +	{ .vbat_uv =3D 3674000, .ri_uohm =3D 161000 },
> > +	{ .vbat_uv =3D 3590000, .ri_uohm =3D 164000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb42516=
1lu[] =3D {
> > +	{ .vbat_uv =3D 4240000, .ri_uohm =3D 160000 },
> > +	{ .vbat_uv =3D 4210000, .ri_uohm =3D 179000 },
> > +	{ .vbat_uv =3D 4180000, .ri_uohm =3D 183000 },
> > +	{ .vbat_uv =3D 4160000, .ri_uohm =3D 184000 },
> > +	{ .vbat_uv =3D 4140000, .ri_uohm =3D 191000 },
> > +	{ .vbat_uv =3D 4120000, .ri_uohm =3D 204000 },
> > +	{ .vbat_uv =3D 4080000, .ri_uohm =3D 200000 },
> > +	{ .vbat_uv =3D 4027000, .ri_uohm =3D 202000 },
> > +	{ .vbat_uv =3D 3916000, .ri_uohm =3D 221000 },
> > +	{ .vbat_uv =3D 3842000, .ri_uohm =3D 259000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 262000 },
> > +	{ .vbat_uv =3D 3742000, .ri_uohm =3D 263000 },
> > +	{ .vbat_uv =3D 3708000, .ri_uohm =3D 277000 },
> > +	{ .vbat_uv =3D 3684000, .ri_uohm =3D 272000 },
> > +	{ .vbat_uv =3D 3664000, .ri_uohm =3D 278000 },
> > +	{ .vbat_uv =3D 3655000, .ri_uohm =3D 285000 },
> > +	{ .vbat_uv =3D 3638000, .ri_uohm =3D 261000 },
> > +	{ .vbat_uv =3D 3624000, .ri_uohm =3D 259000 },
> > +	{ .vbat_uv =3D 3616000, .ri_uohm =3D 266000 },
> > +	{ .vbat_uv =3D 3597000, .ri_uohm =3D 278000 },
> > +	{ .vbat_uv =3D 3581000, .ri_uohm =3D 281000 },
> > +	{ .vbat_uv =3D 3560000, .ri_uohm =3D 287000 },
> > +	{ .vbat_uv =3D 3527000, .ri_uohm =3D 289000 },
> > +	{ .vbat_uv =3D 3512000, .ri_uohm =3D 286000 },
> > +	{ .vbat_uv =3D 3494000, .ri_uohm =3D 282000 },
> > +	{ .vbat_uv =3D 3400000, .ri_uohm =3D 269000 },
> > +	{ .vbat_uv =3D 3360000, .ri_uohm =3D 328000 },
> > +	{ .vbat_uv =3D 3330000, .ri_uohm =3D 305000 },
> > +	{ .vbat_uv =3D 3300000, .ri_uohm =3D 339000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161lu=
[] =3D {
> > +	{ .vbat_uv =3D 4346000, .ri_uohm =3D 293000 },
> > +	{ .vbat_uv =3D 4336000, .ri_uohm =3D 290000 },
> > +	{ .vbat_uv =3D 4315000, .ri_uohm =3D 274000 },
> > +	{ .vbat_uv =3D 4310000, .ri_uohm =3D 264000 },
> > +	{ .vbat_uv =3D 4275000, .ri_uohm =3D 275000 },
> > +	{ .vbat_uv =3D 4267000, .ri_uohm =3D 274000 },
> > +	{ .vbat_uv =3D 4227000, .ri_uohm =3D 262000 },
> > +	{ .vbat_uv =3D 4186000, .ri_uohm =3D 282000 },
> > +	{ .vbat_uv =3D 4136000, .ri_uohm =3D 246000 },
> > +	{ .vbat_uv =3D 4110000, .ri_uohm =3D 242000 },
> > +	{ .vbat_uv =3D 4077000, .ri_uohm =3D 249000 },
> > +	{ .vbat_uv =3D 4049000, .ri_uohm =3D 238000 },
> > +	{ .vbat_uv =3D 4017000, .ri_uohm =3D 268000 },
> > +	{ .vbat_uv =3D 3986000, .ri_uohm =3D 261000 },
> > +	{ .vbat_uv =3D 3962000, .ri_uohm =3D 252000 },
> > +	{ .vbat_uv =3D 3940000, .ri_uohm =3D 235000 },
> > +	{ .vbat_uv =3D 3930000, .ri_uohm =3D 237000 },
> > +	{ .vbat_uv =3D 3924000, .ri_uohm =3D 255000 },
> > +	{ .vbat_uv =3D 3910000, .ri_uohm =3D 244000 },
> > +	{ .vbat_uv =3D 3889000, .ri_uohm =3D 231000 },
> > +	{ .vbat_uv =3D 3875000, .ri_uohm =3D 249000 },
> > +	{ .vbat_uv =3D 3850000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 232000 },
> > +	{ .vbat_uv =3D 3750000, .ri_uohm =3D 177000 },
> > +	{ .vbat_uv =3D 3712000, .ri_uohm =3D 164000 },
> > +	{ .vbat_uv =3D 3674000, .ri_uohm =3D 161000 },
> > +	{ .vbat_uv =3D 3590000, .ri_uohm =3D 164000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb48515=
9lu[] =3D {
> > +	{ .vbat_uv =3D 4240000, .ri_uohm =3D 160000 },
> > +	{ .vbat_uv =3D 4210000, .ri_uohm =3D 179000 },
> > +	{ .vbat_uv =3D 4180000, .ri_uohm =3D 183000 },
> > +	{ .vbat_uv =3D 4160000, .ri_uohm =3D 184000 },
> > +	{ .vbat_uv =3D 4140000, .ri_uohm =3D 191000 },
> > +	{ .vbat_uv =3D 4120000, .ri_uohm =3D 204000 },
> > +	{ .vbat_uv =3D 4080000, .ri_uohm =3D 200000 },
> > +	{ .vbat_uv =3D 4027000, .ri_uohm =3D 202000 },
> > +	{ .vbat_uv =3D 3916000, .ri_uohm =3D 221000 },
> > +	{ .vbat_uv =3D 3842000, .ri_uohm =3D 259000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 262000 },
> > +	{ .vbat_uv =3D 3715000, .ri_uohm =3D 340000 },
> > +	{ .vbat_uv =3D 3700000, .ri_uohm =3D 300000 },
> > +	{ .vbat_uv =3D 3682000, .ri_uohm =3D 233000 },
> > +	{ .vbat_uv =3D 3655000, .ri_uohm =3D 246000 },
> > +	{ .vbat_uv =3D 3639000, .ri_uohm =3D 260000 },
> > +	{ .vbat_uv =3D 3621000, .ri_uohm =3D 254000 },
> > +	{ .vbat_uv =3D 3583000, .ri_uohm =3D 266000 },
> > +	{ .vbat_uv =3D 3536000, .ri_uohm =3D 274000 },
> > +	{ .vbat_uv =3D 3502000, .ri_uohm =3D 300000 },
> > +	{ .vbat_uv =3D 3465000, .ri_uohm =3D 245000 },
> > +	{ .vbat_uv =3D 3438000, .ri_uohm =3D 225000 },
> > +	{ .vbat_uv =3D 3330000, .ri_uohm =3D 305000 },
> > +	{ .vbat_uv =3D 3300000, .ri_uohm =3D 339000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb485159lu=
[] =3D {
> > +	{ .vbat_uv =3D 4302000, .ri_uohm =3D 200000 },
> > +	{ .vbat_uv =3D 4258000, .ri_uohm =3D 206000 },
> > +	{ .vbat_uv =3D 4200000, .ri_uohm =3D 231000 },
> > +	{ .vbat_uv =3D 4150000, .ri_uohm =3D 198000 },
> > +	{ .vbat_uv =3D 4134000, .ri_uohm =3D 268000 },
> > +	{ .vbat_uv =3D 4058000, .ri_uohm =3D 172000 },
> > +	{ .vbat_uv =3D 4003000, .ri_uohm =3D 227000 },
> > +	{ .vbat_uv =3D 3972000, .ri_uohm =3D 241000 },
> > +	{ .vbat_uv =3D 3953000, .ri_uohm =3D 244000 },
> > +	{ .vbat_uv =3D 3950000, .ri_uohm =3D 213000 },
> > +	{ .vbat_uv =3D 3900000, .ri_uohm =3D 225000 },
> > +	{ .vbat_uv =3D 3850000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 232000 },
> > +	{ .vbat_uv =3D 3750000, .ri_uohm =3D 177000 },
> > +	{ .vbat_uv =3D 3712000, .ri_uohm =3D 164000 },
> > +	{ .vbat_uv =3D 3674000, .ri_uohm =3D 161000 },
> > +	{ .vbat_uv =3D 3590000, .ri_uohm =3D 164000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb53515=
1vu[] =3D {
> > +	{ .vbat_uv =3D 4071000, .ri_uohm =3D 158000 },
> > +	{ .vbat_uv =3D 4019000, .ri_uohm =3D 187000 },
> > +	{ .vbat_uv =3D 3951000, .ri_uohm =3D 191000 },
> > +	{ .vbat_uv =3D 3901000, .ri_uohm =3D 193000 },
> > +	{ .vbat_uv =3D 3850000, .ri_uohm =3D 273000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 305000 },
> > +	{ .vbat_uv =3D 3750000, .ri_uohm =3D 205000 },
> > +	{ .vbat_uv =3D 3700000, .ri_uohm =3D 290000 },
> > +	{ .vbat_uv =3D 3650000, .ri_uohm =3D 262000 },
> > +	{ .vbat_uv =3D 3618000, .ri_uohm =3D 290000 },
> > +	{ .vbat_uv =3D 3505000, .ri_uohm =3D 235000 },
> > +	{ .vbat_uv =3D 3484000, .ri_uohm =3D 253000 },
> > +	{ .vbat_uv =3D 3413000, .ri_uohm =3D 243000 },
> > +	{ .vbat_uv =3D 3393000, .ri_uohm =3D 285000 },
> > +	{ .vbat_uv =3D 3361000, .ri_uohm =3D 281000 },
> > +	{ .vbat_uv =3D 3302000, .ri_uohm =3D 286000 },
> > +	{ .vbat_uv =3D 3280000, .ri_uohm =3D 250000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb535151vu=
[] =3D {
> > +	{ .vbat_uv =3D 4190000, .ri_uohm =3D 214000 },
> > +	{ .vbat_uv =3D 4159000, .ri_uohm =3D 252000 },
> > +	{ .vbat_uv =3D 4121000, .ri_uohm =3D 245000 },
> > +	{ .vbat_uv =3D 4069000, .ri_uohm =3D 228000 },
> > +	{ .vbat_uv =3D 4046000, .ri_uohm =3D 229000 },
> > +	{ .vbat_uv =3D 4026000, .ri_uohm =3D 233000 },
> > +	{ .vbat_uv =3D 4007000, .ri_uohm =3D 240000 },
> > +	{ .vbat_uv =3D 3982000, .ri_uohm =3D 291000 },
> > +	{ .vbat_uv =3D 3945000, .ri_uohm =3D 276000 },
> > +	{ .vbat_uv =3D 3924000, .ri_uohm =3D 266000 },
> > +	{ .vbat_uv =3D 3910000, .ri_uohm =3D 258000 },
> > +	{ .vbat_uv =3D 3900000, .ri_uohm =3D 271000 },
> > +	{ .vbat_uv =3D 3844000, .ri_uohm =3D 279000 },
> > +	{ .vbat_uv =3D 3772000, .ri_uohm =3D 217000 },
> > +	{ .vbat_uv =3D 3673000, .ri_uohm =3D 208000 },
> > +	{ .vbat_uv =3D 3571000, .ri_uohm =3D 208000 },
> > +	{ .vbat_uv =3D 3510000, .ri_uohm =3D 228000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb58515=
7lu[] =3D {
> > +	{ .vbat_uv =3D 4194000, .ri_uohm =3D 121000 },
> > +	{ .vbat_uv =3D 4169000, .ri_uohm =3D 188000 },
> > +	{ .vbat_uv =3D 4136000, .ri_uohm =3D 173000 },
> > +	{ .vbat_uv =3D 4108000, .ri_uohm =3D 158000 },
> > +	{ .vbat_uv =3D 4064000, .ri_uohm =3D 143000 },
> > +	{ .vbat_uv =3D 3956000, .ri_uohm =3D 160000 },
> > +	{ .vbat_uv =3D 3847000, .ri_uohm =3D 262000 },
> > +	{ .vbat_uv =3D 3806000, .ri_uohm =3D 280000 },
> > +	{ .vbat_uv =3D 3801000, .ri_uohm =3D 266000 },
> > +	{ .vbat_uv =3D 3794000, .ri_uohm =3D 259000 },
> > +	{ .vbat_uv =3D 3785000, .ri_uohm =3D 234000 },
> > +	{ .vbat_uv =3D 3779000, .ri_uohm =3D 227000 },
> > +	{ .vbat_uv =3D 3772000, .ri_uohm =3D 222000 },
> > +	{ .vbat_uv =3D 3765000, .ri_uohm =3D 221000 },
> > +	{ .vbat_uv =3D 3759000, .ri_uohm =3D 216000 },
> > +	{ .vbat_uv =3D 3754000, .ri_uohm =3D 206000 },
> > +	{ .vbat_uv =3D 3747000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3743000, .ri_uohm =3D 208000 },
> > +	{ .vbat_uv =3D 3737000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3733000, .ri_uohm =3D 200000 },
> > +	{ .vbat_uv =3D 3728000, .ri_uohm =3D 203000 },
> > +	{ .vbat_uv =3D 3722000, .ri_uohm =3D 207000 },
> > +	{ .vbat_uv =3D 3719000, .ri_uohm =3D 208000 },
> > +	{ .vbat_uv =3D 3715000, .ri_uohm =3D 209000 },
> > +	{ .vbat_uv =3D 3712000, .ri_uohm =3D 211000 },
> > +	{ .vbat_uv =3D 3709000, .ri_uohm =3D 210000 },
> > +	{ .vbat_uv =3D 3704000, .ri_uohm =3D 216000 },
> > +	{ .vbat_uv =3D 3701000, .ri_uohm =3D 218000 },
> > +	{ .vbat_uv =3D 3698000, .ri_uohm =3D 222000 },
> > +	{ .vbat_uv =3D 3694000, .ri_uohm =3D 218000 },
> > +	{ .vbat_uv =3D 3692000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 3688000, .ri_uohm =3D 224000 },
> > +	{ .vbat_uv =3D 3686000, .ri_uohm =3D 224000 },
> > +	{ .vbat_uv =3D 3683000, .ri_uohm =3D 228000 },
> > +	{ .vbat_uv =3D 3681000, .ri_uohm =3D 228000 },
> > +	{ .vbat_uv =3D 3679000, .ri_uohm =3D 229000 },
> > +	{ .vbat_uv =3D 3676000, .ri_uohm =3D 232000 },
> > +	{ .vbat_uv =3D 3675000, .ri_uohm =3D 229000 },
> > +	{ .vbat_uv =3D 3673000, .ri_uohm =3D 229000 },
> > +	{ .vbat_uv =3D 3672000, .ri_uohm =3D 223000 },
> > +	{ .vbat_uv =3D 3669000, .ri_uohm =3D 224000 },
> > +	{ .vbat_uv =3D 3666000, .ri_uohm =3D 224000 },
> > +	{ .vbat_uv =3D 3663000, .ri_uohm =3D 221000 },
> > +	{ .vbat_uv =3D 3660000, .ri_uohm =3D 218000 },
> > +	{ .vbat_uv =3D 3657000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 3654000, .ri_uohm =3D 212000 },
> > +	{ .vbat_uv =3D 3649000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 3644000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 3636000, .ri_uohm =3D 215000 },
> > +	{ .vbat_uv =3D 3631000, .ri_uohm =3D 206000 },
> > +	{ .vbat_uv =3D 3623000, .ri_uohm =3D 205000 },
> > +	{ .vbat_uv =3D 3616000, .ri_uohm =3D 193000 },
> > +	{ .vbat_uv =3D 3605000, .ri_uohm =3D 193000 },
> > +	{ .vbat_uv =3D 3600000, .ri_uohm =3D 198000 },
> > +	{ .vbat_uv =3D 3597000, .ri_uohm =3D 198000 },
> > +	{ .vbat_uv =3D 3592000, .ri_uohm =3D 203000 },
> > +	{ .vbat_uv =3D 3591000, .ri_uohm =3D 188000 },
> > +	{ .vbat_uv =3D 3587000, .ri_uohm =3D 188000 },
> > +	{ .vbat_uv =3D 3583000, .ri_uohm =3D 177000 },
> > +	{ .vbat_uv =3D 3577000, .ri_uohm =3D 170000 },
> > +	{ .vbat_uv =3D 3568000, .ri_uohm =3D 135000 },
> > +	{ .vbat_uv =3D 3552000, .ri_uohm =3D 54000 },
> > +	{ .vbat_uv =3D 3526000, .ri_uohm =3D 130000 },
> > +	{ .vbat_uv =3D 3501000, .ri_uohm =3D 48000 },
> > +	{ .vbat_uv =3D 3442000, .ri_uohm =3D 183000 },
> > +	{ .vbat_uv =3D 3326000, .ri_uohm =3D 372000 },
> > +	{ .vbat_uv =3D 3161000, .ri_uohm =3D 452000 },
> > +};
> > +
> > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb585157lu=
[] =3D {
> > +	{ .vbat_uv =3D 4360000, .ri_uohm =3D 128000 },
> > +	{ .vbat_uv =3D 4325000, .ri_uohm =3D 130000 },
> > +	{ .vbat_uv =3D 4316000, .ri_uohm =3D 148000 },
> > +	{ .vbat_uv =3D 4308000, .ri_uohm =3D 162000 },
> > +	{ .vbat_uv =3D 4301000, .ri_uohm =3D 162000 },
> > +	{ .vbat_uv =3D 4250000, .ri_uohm =3D 162000 },
> > +	{ .vbat_uv =3D 4230000, .ri_uohm =3D 164000 },
> > +	{ .vbat_uv =3D 4030000, .ri_uohm =3D 164000 },
> > +	{ .vbat_uv =3D 4000000, .ri_uohm =3D 193000 },
> > +	{ .vbat_uv =3D 3950000, .ri_uohm =3D 204000 },
> > +	{ .vbat_uv =3D 3850000, .ri_uohm =3D 210000 },
> > +	{ .vbat_uv =3D 3800000, .ri_uohm =3D 230000 },
> > +	{ .vbat_uv =3D 3790000, .ri_uohm =3D 240000 },
> > +	{ .vbat_uv =3D 3780000, .ri_uohm =3D 311000 },
> > +	{ .vbat_uv =3D 3760000, .ri_uohm =3D 420000 },
> > +	{ .vbat_uv =3D 3700000, .ri_uohm =3D 504000 },
> > +	{ .vbat_uv =3D 3600000, .ri_uohm =3D 565000 },
> > +};
> > +
> > +/*
> > + * Temperature to internal resistance scaling tables.
> > + *
> > + * "resistance" is the percentage of the resistance determined from th=
e voltage
> > + * so this represents the capacity ratio at different temperatures.
> > + *
> > + * FIXME: the proper table is missing: Samsung does not provide the ne=
cessary
> > + * temperature compensation tables so we just state 100% for every tem=
perature.
> > + * If you have the datasheets, please provide these tables.
> > + */
> > +static struct power_supply_resistance_temp_table samsung_temp2res[] =
=3D {
> > +	{ .temp =3D 50, .resistance =3D 100 },
> > +	{ .temp =3D 40, .resistance =3D 100 },
> > +	{ .temp =3D 30, .resistance =3D 100 },
> > +	{ .temp =3D 20, .resistance =3D 100 },
> > +	{ .temp =3D 10, .resistance =3D 100 },
> > +	{ .temp =3D 00, .resistance =3D 100 },
> > +	{ .temp =3D -10, .resistance =3D 100 },
> > +	{ .temp =3D -20, .resistance =3D 100 },
> > +};
> > +
> > +/*
> > + * Capacity tables for different Open Circuit Voltages (OCV).
> > + * These must be sorted by falling OCV value.
> > + */
> > +
> > +static struct power_supply_battery_ocv_table samsung_ocv_cap_eb485159l=
u[] =3D {
> > +	{ .ocv =3D 4330000, .capacity =3D 100},
> > +	{ .ocv =3D 4320000, .capacity =3D 99},
> > +	{ .ocv =3D 4283000, .capacity =3D 95},
> > +	{ .ocv =3D 4246000, .capacity =3D 92},
> > +	{ .ocv =3D 4211000, .capacity =3D 89},
> > +	{ .ocv =3D 4167000, .capacity =3D 85},
> > +	{ .ocv =3D 4146000, .capacity =3D 83},
> > +	{ .ocv =3D 4124000, .capacity =3D 81},
> > +	{ .ocv =3D 4062000, .capacity =3D 75},
> > +	{ .ocv =3D 4013000, .capacity =3D 70},
> > +	{ .ocv =3D 3977000, .capacity =3D 66},
> > +	{ .ocv =3D 3931000, .capacity =3D 60},
> > +	{ .ocv =3D 3914000, .capacity =3D 58},
> > +	{ .ocv =3D 3901000, .capacity =3D 57},
> > +	{ .ocv =3D 3884000, .capacity =3D 56},
> > +	{ .ocv =3D 3870000, .capacity =3D 55},
> > +	{ .ocv =3D 3862000, .capacity =3D 54},
> > +	{ .ocv =3D 3854000, .capacity =3D 53},
> > +	{ .ocv =3D 3838000, .capacity =3D 50},
> > +	{ .ocv =3D 3823000, .capacity =3D 47},
> > +	{ .ocv =3D 3813000, .capacity =3D 45},
> > +	{ .ocv =3D 3807000, .capacity =3D 43},
> > +	{ .ocv =3D 3800000, .capacity =3D 41},
> > +	{ .ocv =3D 3795000, .capacity =3D 40},
> > +	{ .ocv =3D 3786000, .capacity =3D 37},
> > +	{ .ocv =3D 3783000, .capacity =3D 35},
> > +	{ .ocv =3D 3773000, .capacity =3D 30},
> > +	{ .ocv =3D 3758000, .capacity =3D 25},
> > +	{ .ocv =3D 3745000, .capacity =3D 22},
> > +	{ .ocv =3D 3738000, .capacity =3D 20},
> > +	{ .ocv =3D 3733000, .capacity =3D 19},
> > +	{ .ocv =3D 3716000, .capacity =3D 17},
> > +	{ .ocv =3D 3709000, .capacity =3D 16},
> > +	{ .ocv =3D 3698000, .capacity =3D 15},
> > +	{ .ocv =3D 3687000, .capacity =3D 14},
> > +	{ .ocv =3D 3684000, .capacity =3D 13},
> > +	{ .ocv =3D 3684000, .capacity =3D 12},
> > +	{ .ocv =3D 3678000, .capacity =3D 10},
> > +	{ .ocv =3D 3671000, .capacity =3D 9},
> > +	{ .ocv =3D 3665000, .capacity =3D 8},
> > +	{ .ocv =3D 3651000, .capacity =3D 7},
> > +	{ .ocv =3D 3634000, .capacity =3D 6},
> > +	{ .ocv =3D 3601000, .capacity =3D 5},
> > +	{ .ocv =3D 3564000, .capacity =3D 4},
> > +	{ .ocv =3D 3516000, .capacity =3D 3},
> > +	{ .ocv =3D 3456000, .capacity =3D 2},
> > +	{ .ocv =3D 3381000, .capacity =3D 1},
> > +	{ .ocv =3D 3300000, .capacity =3D 0},
> > +};
> > +
> > +/* Same capacity table is used by eb-l1m7flu, eb425161la, eb425161lu */
> > +static struct power_supply_battery_ocv_table samsung_ocv_cap_1500mah[]=
 =3D {
> > +	{ .ocv =3D 4328000, .capacity =3D 100},
> > +	{ .ocv =3D 4299000, .capacity =3D 99},
> > +	{ .ocv =3D 4281000, .capacity =3D 98},
> > +	{ .ocv =3D 4241000, .capacity =3D 95},
> > +	{ .ocv =3D 4183000, .capacity =3D 90},
> > +	{ .ocv =3D 4150000, .capacity =3D 87},
> > +	{ .ocv =3D 4116000, .capacity =3D 84},
> > +	{ .ocv =3D 4077000, .capacity =3D 80},
> > +	{ .ocv =3D 4068000, .capacity =3D 79},
> > +	{ .ocv =3D 4058000, .capacity =3D 77},
> > +	{ .ocv =3D 4026000, .capacity =3D 75},
> > +	{ .ocv =3D 3987000, .capacity =3D 72},
> > +	{ .ocv =3D 3974000, .capacity =3D 69},
> > +	{ .ocv =3D 3953000, .capacity =3D 66},
> > +	{ .ocv =3D 3933000, .capacity =3D 63},
> > +	{ .ocv =3D 3911000, .capacity =3D 60},
> > +	{ .ocv =3D 3900000, .capacity =3D 58},
> > +	{ .ocv =3D 3873000, .capacity =3D 55},
> > +	{ .ocv =3D 3842000, .capacity =3D 52},
> > +	{ .ocv =3D 3829000, .capacity =3D 50},
> > +	{ .ocv =3D 3810000, .capacity =3D 45},
> > +	{ .ocv =3D 3793000, .capacity =3D 40},
> > +	{ .ocv =3D 3783000, .capacity =3D 35},
> > +	{ .ocv =3D 3776000, .capacity =3D 30},
> > +	{ .ocv =3D 3762000, .capacity =3D 25},
> > +	{ .ocv =3D 3746000, .capacity =3D 20},
> > +	{ .ocv =3D 3739000, .capacity =3D 18},
> > +	{ .ocv =3D 3715000, .capacity =3D 15},
> > +	{ .ocv =3D 3700000, .capacity =3D 12},
> > +	{ .ocv =3D 3690000, .capacity =3D 10},
> > +	{ .ocv =3D 3680000, .capacity =3D 9},
> > +	{ .ocv =3D 3670000, .capacity =3D 7},
> > +	{ .ocv =3D 3656000, .capacity =3D 5},
> > +	{ .ocv =3D 3634000, .capacity =3D 4},
> > +	{ .ocv =3D 3614000, .capacity =3D 3},
> > +	{ .ocv =3D 3551000, .capacity =3D 2},
> > +	{ .ocv =3D 3458000, .capacity =3D 1},
> > +	{ .ocv =3D 3300000, .capacity =3D 0},
> > +};
> > +
> > +static struct power_supply_battery_ocv_table samsung_ocv_cap_eb535151v=
u[] =3D {
> > +	{ .ocv =3D 4178000, .capacity =3D 100},
> > +	{ .ocv =3D 4148000, .capacity =3D 99},
> > +	{ .ocv =3D 4105000, .capacity =3D 95},
> > +	{ .ocv =3D 4078000, .capacity =3D 92},
> > +	{ .ocv =3D 4057000, .capacity =3D 89},
> > +	{ .ocv =3D 4013000, .capacity =3D 85},
> > +	{ .ocv =3D 3988000, .capacity =3D 82},
> > +	{ .ocv =3D 3962000, .capacity =3D 77},
> > +	{ .ocv =3D 3920000, .capacity =3D 70},
> > +	{ .ocv =3D 3891000, .capacity =3D 65},
> > +	{ .ocv =3D 3874000, .capacity =3D 62},
> > +	{ .ocv =3D 3839000, .capacity =3D 59},
> > +	{ .ocv =3D 3816000, .capacity =3D 55},
> > +	{ .ocv =3D 3798000, .capacity =3D 50},
> > +	{ .ocv =3D 3778000, .capacity =3D 40},
> > +	{ .ocv =3D 3764000, .capacity =3D 30},
> > +	{ .ocv =3D 3743000, .capacity =3D 25},
> > +	{ .ocv =3D 3711000, .capacity =3D 20},
> > +	{ .ocv =3D 3691000, .capacity =3D 18},
> > +	{ .ocv =3D 3685000, .capacity =3D 15},
> > +	{ .ocv =3D 3680000, .capacity =3D 12},
> > +	{ .ocv =3D 3662000, .capacity =3D 10},
> > +	{ .ocv =3D 3638000, .capacity =3D 9},
> > +	{ .ocv =3D 3593000, .capacity =3D 7},
> > +	{ .ocv =3D 3566000, .capacity =3D 6},
> > +	{ .ocv =3D 3497000, .capacity =3D 4},
> > +	{ .ocv =3D 3405000, .capacity =3D 2},
> > +	{ .ocv =3D 3352000, .capacity =3D 1},
> > +	{ .ocv =3D 3300000, .capacity =3D 0},
> > +};
> > +
> > +static struct power_supply_battery_ocv_table samsung_ocv_cap_eb585157l=
u[] =3D {
> > +	{ .ocv =3D 4320000, .capacity =3D 100},
> > +	{ .ocv =3D 4296000, .capacity =3D 99},
> > +	{ .ocv =3D 4283000, .capacity =3D 98},
> > +	{ .ocv =3D 4245000, .capacity =3D 95},
> > +	{ .ocv =3D 4185000, .capacity =3D 90},
> > +	{ .ocv =3D 4152000, .capacity =3D 87},
> > +	{ .ocv =3D 4119000, .capacity =3D 84},
> > +	{ .ocv =3D 4077000, .capacity =3D 80},
> > +	{ .ocv =3D 4057000, .capacity =3D 78},
> > +	{ .ocv =3D 4048000, .capacity =3D 77},
> > +	{ .ocv =3D 4020000, .capacity =3D 74},
> > +	{ .ocv =3D 4003000, .capacity =3D 72},
> > +	{ .ocv =3D 3978000, .capacity =3D 69},
> > +	{ .ocv =3D 3955000, .capacity =3D 66},
> > +	{ .ocv =3D 3934000, .capacity =3D 63},
> > +	{ .ocv =3D 3912000, .capacity =3D 60},
> > +	{ .ocv =3D 3894000, .capacity =3D 58},
> > +	{ .ocv =3D 3860000, .capacity =3D 55},
> > +	{ .ocv =3D 3837000, .capacity =3D 52},
> > +	{ .ocv =3D 3827000, .capacity =3D 50},
> > +	{ .ocv =3D 3806000, .capacity =3D 45},
> > +	{ .ocv =3D 3791000, .capacity =3D 40},
> > +	{ .ocv =3D 3779000, .capacity =3D 35},
> > +	{ .ocv =3D 3770000, .capacity =3D 30},
> > +	{ .ocv =3D 3758000, .capacity =3D 25},
> > +	{ .ocv =3D 3739000, .capacity =3D 20},
> > +	{ .ocv =3D 3730000, .capacity =3D 18},
> > +	{ .ocv =3D 3706000, .capacity =3D 15},
> > +	{ .ocv =3D 3684000, .capacity =3D 13},
> > +	{ .ocv =3D 3675000, .capacity =3D 10},
> > +	{ .ocv =3D 3673000, .capacity =3D 9},
> > +	{ .ocv =3D 3665000, .capacity =3D 7},
> > +	{ .ocv =3D 3649000, .capacity =3D 5},
> > +	{ .ocv =3D 3628000, .capacity =3D 4},
> > +	{ .ocv =3D 3585000, .capacity =3D 3},
> > +	{ .ocv =3D 3525000, .capacity =3D 2},
> > +	{ .ocv =3D 3441000, .capacity =3D 1},
> > +	{ .ocv =3D 3300000, .capacity =3D 0},
> > +};
> > +
> > +struct power_supply_maintenance_charge_table samsung_maint_charge_tabl=
e[] =3D {
> > +	{
> > +		/* Maintenance charging phase A, 60 hours */
> > +		.charge_current_max_ua =3D 600000,
> > +		.charge_voltage_max_uv =3D 4150000,
> > +		.charge_safety_timer_minutes =3D 60*60,
> > +	},
> > +	{
> > +		/* Maintenance charging phase B, 200 hours */
> > +		.charge_current_max_ua =3D 600000,
> > +		.charge_voltage_max_uv =3D 4100000,
> > +		.charge_safety_timer_minutes =3D 200*60,
> > +	}
> > +};
> > +
> > +struct samsung_sdi_battery samsung_sdi_batteries[] =3D {
> > +	{
> > +		/*
> > +		 * Used in Samsung GT-I8190 "Golden"
> > +		 * Data from vendor boardfile board-golden-[bm|battery].c
> > +		 */
> > +		.compatible =3D "samsung,eb-l1m7flu",
> > +		.name =3D "EB-L1M7FLU",
> > +		.info =3D {
> > +			.charge_full_design_uah =3D 1500000,
> > +			.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> > +			.factory_internal_resistance_uohm =3D 100000,
> > +			.factory_internal_resistance_charging_uohm =3D 200000,
> > +			/* If you have data on this fix the min_design_uv */
> > +			.voltage_min_design_uv =3D 3320000,
> > +			.voltage_max_design_uv =3D 4340000,
> > +			.overvoltage_limit_uv =3D 4500000,
> > +			.constant_charge_current_max_ua =3D 900000,
> > +			.constant_charge_voltage_max_uv =3D 4320000,
> > +			.charge_term_current_ua =3D 200000,
> > +			.charge_restart_voltage_uv =3D 4300000,
> > +			.maintenance_charge =3D samsung_maint_charge_table,
> > +			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
> > +			.alert_low_temp_charge_current_ua =3D 300000,
> > +			.alert_low_temp_charge_voltage_uv =3D 4000000,
> > +			.alert_high_temp_charge_current_ua =3D 300000,
> > +			.alert_high_temp_charge_voltage_uv =3D 4000000,
> > +			.temp_min =3D -50,
> > +			.temp_alert_min =3D 0,
> > +			.temp_alert_max =3D 40,
> > +			.temp_max =3D 60,
> > +			.resist_table =3D samsung_temp2res,
> > +			.resist_table_size =3D ARRAY_SIZE(samsung_temp2res),
> > +			/* If you have tables for more temperatures, add them */
> > +			.ocv_temp[0] =3D 25,
> > +			.ocv_table[0] =3D samsung_ocv_cap_1500mah,
> > +			.ocv_table_size[0] =3D ARRAY_SIZE(samsung_ocv_cap_1500mah),
> > +			.vbat2ri_discharging =3D samsung_vbat2res_discharging_eb_l1m7flu,
> > +			.vbat2ri_discharging_size =3D ARRAY_SIZE(samsung_vbat2res_dischargi=
ng_eb_l1m7flu),
> > +			.vbat2ri_charging =3D samsung_vbat2res_charging_eb_l1m7flu,
> > +			.vbat2ri_charging_size =3D ARRAY_SIZE(samsung_vbat2res_charging_eb_=
l1m7flu),
> > +			.bti_resistance_ohm =3D 2400,
> > +			.bti_resistance_tolerance =3D 40,
> > +		},
> > +	},
> > +	{
> > +		/*
> > +		 * Used in Samsung SGH-T599 "Codina TMO" and SGH-I407 "Kyle"
> > +		 * Data from vendor boardfile board-kyle-[bm|battery].c
> > +		 */
> > +		.compatible =3D "samsung,eb425161la",
> > +		.name =3D "EB425161LA",
> > +		.info =3D {
> > +			.charge_full_design_uah =3D 1500000,
> > +			.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> > +			.factory_internal_resistance_uohm =3D 136000,
> > +			.factory_internal_resistance_charging_uohm =3D 200000,
> > +			/* If you have data on this fix the min_design_uv */
> > +			.voltage_min_design_uv =3D 3320000,
> > +			.voltage_max_design_uv =3D 4340000,
> > +			.overvoltage_limit_uv =3D 4500000,
> > +			.constant_charge_current_max_ua =3D 900000,
> > +			.constant_charge_voltage_max_uv =3D 4320000,
> > +			.charge_term_current_ua =3D 200000,
> > +			.charge_restart_voltage_uv =3D 4270000,
> > +			.maintenance_charge =3D samsung_maint_charge_table,
> > +			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
> > +			.alert_low_temp_charge_current_ua =3D 300000,
> > +			.alert_low_temp_charge_voltage_uv =3D 4000000,
> > +			.alert_high_temp_charge_current_ua =3D 300000,
> > +			.alert_high_temp_charge_voltage_uv =3D 4000000,
> > +			.temp_min =3D -30,
> > +			.temp_alert_min =3D 0,
> > +			.temp_alert_max =3D 40,
> > +			.temp_max =3D 47,
> > +			.resist_table =3D samsung_temp2res,
> > +			.resist_table_size =3D ARRAY_SIZE(samsung_temp2res),
> > +			/* If you have tables for more temperatures, add them */
> > +			.ocv_temp[0] =3D 25,
> > +			.ocv_table[0] =3D samsung_ocv_cap_1500mah,
> > +			.ocv_table_size[0] =3D ARRAY_SIZE(samsung_ocv_cap_1500mah),
> > +			.vbat2ri_discharging =3D samsung_vbat2res_discharging_eb425161la,
> > +			.vbat2ri_discharging_size =3D ARRAY_SIZE(samsung_vbat2res_dischargi=
ng_eb425161la),
> > +			.vbat2ri_charging =3D samsung_vbat2res_charging_eb425161la,
> > +			.vbat2ri_charging_size =3D ARRAY_SIZE(samsung_vbat2res_charging_eb4=
25161la),
> > +			.bti_resistance_ohm =3D 2400,
> > +			.bti_resistance_tolerance =3D 40,
> > +		},
> > +	},
> > +	{
> > +		/*
> > +		 * Used in Samsung GT-I8160 "Codina"
> > +		 * Data from vendor boardfile board-codina-[bm|battery].c
> > +		 */
> > +		.compatible =3D "samsung,eb425161lu",
> > +		.name =3D "EB425161LU",
> > +		.info =3D {
> > +			.charge_full_design_uah =3D 1500000,
> > +			.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> > +			.factory_internal_resistance_uohm =3D 100000,
> > +			.factory_internal_resistance_charging_uohm =3D 200000,
> > +			/* If you have data on this fix the min_design_uv */
> > +			.voltage_min_design_uv =3D 3320000,
> > +			.voltage_max_design_uv =3D 4350000,
> > +			.overvoltage_limit_uv =3D 4500000,
> > +			.constant_charge_current_max_ua =3D 900000,
> > +			.constant_charge_voltage_max_uv =3D 4340000,
> > +			.charge_term_current_ua =3D 200000,
> > +			.charge_restart_voltage_uv =3D 4280000,
> > +			.maintenance_charge =3D samsung_maint_charge_table,
> > +			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
> > +			.alert_low_temp_charge_current_ua =3D 300000,
> > +			.alert_low_temp_charge_voltage_uv =3D 4000000,
> > +			.alert_high_temp_charge_current_ua =3D 300000,
> > +			.alert_high_temp_charge_voltage_uv =3D 4000000,
> > +			.temp_min =3D -50,
> > +			.temp_alert_min =3D 0,
> > +			.temp_alert_max =3D 43,
> > +			.temp_max =3D 49,
> > +			.resist_table =3D samsung_temp2res,
> > +			.resist_table_size =3D ARRAY_SIZE(samsung_temp2res),
> > +			/* If you have tables for more temperatures, add them */
> > +			.ocv_temp[0] =3D 25,
> > +			.ocv_table[0] =3D samsung_ocv_cap_1500mah,
> > +			.ocv_table_size[0] =3D ARRAY_SIZE(samsung_ocv_cap_1500mah),
> > +			.vbat2ri_discharging =3D samsung_vbat2res_discharging_eb425161lu,
> > +			.vbat2ri_discharging_size =3D ARRAY_SIZE(samsung_vbat2res_dischargi=
ng_eb425161lu),
> > +			.vbat2ri_charging =3D samsung_vbat2res_charging_eb425161lu,
> > +			.vbat2ri_charging_size =3D ARRAY_SIZE(samsung_vbat2res_charging_eb4=
25161lu),
> > +			.bti_resistance_ohm =3D 2400,
> > +			.bti_resistance_tolerance =3D 40,
> > +		},
> > +	},
> > +	{
> > +		/*
> > +		 * Used in Samsung GT-S7710 "Skomer"
> > +		 * Data from vendor boardfile board-skomer-[bm|battery].c
> > +		 */
> > +		.compatible =3D "samsung,eb485159lu",
> > +		.name =3D "EB485159LU",
> > +		.info =3D {
> > +			.charge_full_design_uah =3D 1700000,
> > +			.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> > +			.factory_internal_resistance_uohm =3D 100000,
> > +			.factory_internal_resistance_charging_uohm =3D 200000,
> > +			.voltage_min_design_uv =3D 3320000,
> > +			.voltage_max_design_uv =3D 4350000,
> > +			.overvoltage_limit_uv =3D 4500000,
> > +			.constant_charge_current_max_ua =3D 900000,
> > +			.constant_charge_voltage_max_uv =3D 4340000,
> > +			.charge_term_current_ua =3D 200000,
> > +			.charge_restart_voltage_uv =3D 4300000,
> > +			.maintenance_charge =3D samsung_maint_charge_table,
> > +			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
> > +			.alert_low_temp_charge_current_ua =3D 300000,
> > +			.alert_low_temp_charge_voltage_uv =3D 4000000,
> > +			.alert_high_temp_charge_current_ua =3D 300000,
> > +			.alert_high_temp_charge_voltage_uv =3D 4000000,
> > +			.temp_min =3D -50,
> > +			.temp_alert_min =3D 0,
> > +			.temp_alert_max =3D 40,
> > +			.temp_max =3D 60,
> > +			.resist_table =3D samsung_temp2res,
> > +			.resist_table_size =3D ARRAY_SIZE(samsung_temp2res),
> > +			/* If you have tables for more temperatures, add them */
> > +			.ocv_temp[0] =3D 25,
> > +			.ocv_table[0] =3D samsung_ocv_cap_eb485159lu,
> > +			.ocv_table_size[0] =3D ARRAY_SIZE(samsung_ocv_cap_eb485159lu),
> > +			/* CHECKME: vendor uses the 1500 mAh table, check against datasheet=
 */
> > +			.vbat2ri_discharging =3D samsung_vbat2res_discharging_eb485159lu,
> > +			.vbat2ri_discharging_size =3D ARRAY_SIZE(samsung_vbat2res_dischargi=
ng_eb485159lu),
> > +			.vbat2ri_charging =3D samsung_vbat2res_charging_eb485159lu,
> > +			.vbat2ri_charging_size =3D ARRAY_SIZE(samsung_vbat2res_charging_eb4=
85159lu),
> > +			.bti_resistance_ohm =3D 2400,
> > +			.bti_resistance_tolerance =3D 40,
> > +		},
> > +	},
> > +	{
> > +		/*
> > +		 * Used in Samsung GT-I9070 "Janice"
> > +		 * Data from vendor boardfile board-janice-bm.c
> > +		 */
> > +		.compatible =3D "samsung,eb535151vu",
> > +		.name =3D "EB535151VU",
> > +		.info =3D {
> > +			.charge_full_design_uah =3D 1500000,
> > +			.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> > +			.factory_internal_resistance_uohm =3D 100000,
> > +			.factory_internal_resistance_charging_uohm =3D 200000,
> > +			/* If you have data on this fix the min_design_uv */
> > +			.voltage_min_design_uv =3D 3300000,
> > +			.voltage_max_design_uv =3D 4180000,
> > +			.overvoltage_limit_uv =3D 4500000,
> > +			.constant_charge_current_max_ua =3D 900000,
> > +			.constant_charge_voltage_max_uv =3D 4200000,
> > +			.charge_term_current_ua =3D 200000,
> > +			.maintenance_charge =3D samsung_maint_charge_table,
> > +			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
> > +			.alert_low_temp_charge_current_ua =3D 300000,
> > +			.alert_low_temp_charge_voltage_uv =3D 4000000,
> > +			.alert_high_temp_charge_current_ua =3D 300000,
> > +			.alert_high_temp_charge_voltage_uv =3D 4000000,
> > +			.temp_min =3D -5,
> > +			.temp_alert_min =3D 0,
> > +			.temp_alert_max =3D 40,
> > +			.temp_max =3D 60,
> > +			.resist_table =3D samsung_temp2res,
> > +			.resist_table_size =3D ARRAY_SIZE(samsung_temp2res),
> > +			/* If you have tables for more temperatures, add them */
> > +			.ocv_temp[0] =3D 25,
> > +			.ocv_table[0] =3D samsung_ocv_cap_eb585157lu,
> > +			.ocv_table_size[0] =3D ARRAY_SIZE(samsung_ocv_cap_eb535151vu),
> > +			.vbat2ri_discharging =3D samsung_vbat2res_discharging_eb535151vu,
> > +			.vbat2ri_discharging_size =3D ARRAY_SIZE(samsung_vbat2res_dischargi=
ng_eb535151vu),
> > +			.vbat2ri_charging =3D samsung_vbat2res_charging_eb535151vu,
> > +			.vbat2ri_charging_size =3D ARRAY_SIZE(samsung_vbat2res_charging_eb5=
35151vu),
> > +			.bti_resistance_ohm =3D 1500,
> > +			.bti_resistance_tolerance =3D 40,
> > +		},
> > +	},
> > +	{
> > +		/*
> > +		 * Used in Samsung GT-I8530 "Gavini"
> > +		 * Data from vendor boardfile board-gavini-bm.c
> > +		 */
> > +		.compatible =3D "samsung,eb585157lu",
> > +		.name =3D "EB585157LU",
> > +		.info =3D {
> > +			.charge_full_design_uah =3D 2000000,
> > +			.technology =3D POWER_SUPPLY_TECHNOLOGY_LION,
> > +			.factory_internal_resistance_uohm =3D 105000,
> > +			.factory_internal_resistance_charging_uohm =3D 160000,
> > +			/* If you have data on this fix the min_design_uv */
> > +			.voltage_min_design_uv =3D 3300000,
> > +			.voltage_max_design_uv =3D 4320000,
> > +			.overvoltage_limit_uv =3D 4500000,
> > +			.constant_charge_current_max_ua =3D 1500000,
> > +			.constant_charge_voltage_max_uv =3D 4350000,
> > +			.charge_term_current_ua =3D 120000,
> > +			.maintenance_charge =3D samsung_maint_charge_table,
> > +			.maintenance_charge_size =3D ARRAY_SIZE(samsung_maint_charge_table),
> > +			.alert_low_temp_charge_current_ua =3D 300000,
> > +			.alert_low_temp_charge_voltage_uv =3D 4000000,
> > +			.alert_high_temp_charge_current_ua =3D 300000,
> > +			.alert_high_temp_charge_voltage_uv =3D 4000000,
> > +			.temp_min =3D -5,
> > +			.temp_alert_min =3D 0,
> > +			.temp_alert_max =3D 40,
> > +			.temp_max =3D 60,
> > +			.resist_table =3D samsung_temp2res,
> > +			.resist_table_size =3D ARRAY_SIZE(samsung_temp2res),
> > +			/* If you have tables for more temperatures, add them */
> > +			.ocv_temp[0] =3D 25,
> > +			.ocv_table[0] =3D samsung_ocv_cap_eb585157lu,
> > +			.ocv_table_size[0] =3D ARRAY_SIZE(samsung_ocv_cap_eb585157lu),
> > +			.vbat2ri_discharging =3D samsung_vbat2res_discharging_eb585157lu,
> > +			.vbat2ri_discharging_size =3D ARRAY_SIZE(samsung_vbat2res_dischargi=
ng_eb585157lu),
> > +			.vbat2ri_charging =3D samsung_vbat2res_charging_eb585157lu,
> > +			.vbat2ri_charging_size =3D ARRAY_SIZE(samsung_vbat2res_charging_eb5=
85157lu),
> > +			.bti_resistance_ohm =3D 2400,
> > +			.bti_resistance_tolerance =3D 40,
> > +		},
> > +	},
> > +};
> > +
> > +int samsung_sdi_battery_get_info(struct device *dev,
> > +				 struct device_node *np,
> > +				 struct power_supply_battery_info **info)
> > +{
> > +	struct samsung_sdi_battery *batt;
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(samsung_sdi_batteries); i++) {
> > +		batt =3D &samsung_sdi_batteries[i];
> > +		if (of_device_is_compatible(np, batt->compatible))
> > +			break;
> > +	}
> > +
> > +	if (i =3D=3D ARRAY_SIZE(samsung_sdi_batteries))
> > +		return -ENODEV;
> > +
> > +	*info =3D &batt->info;
> > +	dev_info(dev, "Samsung SDI %s battery %d mAh\n",
> > +		 batt->name, batt->info.charge_full_design_uah / 1000);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(samsung_sdi_battery_get_info);
> > diff --git a/drivers/power/supply/samsung-sdi-battery.h b/drivers/power=
/supply/samsung-sdi-battery.h
> > new file mode 100644
> > index 000000000000..08783847dfcb
> > --- /dev/null
> > +++ b/drivers/power/supply/samsung-sdi-battery.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#if IS_ENABLED(CONFIG_BATTERY_SAMSUNG_SDI)
> > +extern int samsung_sdi_battery_get_info(struct device *dev,
> > +				struct device_node *np,
> > +				struct power_supply_battery_info **info);
> > +#else
> > +static inline int samsung_sdi_battery_get_info(struct device *dev,
> > +				struct device_node *np,
> > +				struct power_supply_battery_info **info)
> > +{
> > +	return -ENODEV;
> > +}
> > +#endif
> > --=20
> > 2.34.1
> >=20

--5umvzyqucxgj552y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJHG70ACgkQ2O7X88g7
+pqJZxAAm5wy6vbLpLsaD5LmnbGXioAIuWPxaBfFi6pEPylW2ZkLnUYfJx9H7cLG
qTk3SGGwWHvDuBqzUPTkpcMCwBLezQFxvg6olH5Q0uAohFX5XRob9UW14ScnB9DS
c7HweIfFiPBtkOy9kAlTkY4e5/iI0/N6+lJJO9LZvMBMqxl/yqqJsC5DEZdcHxdM
Vrf9pOTAvtHM8IAz2Rmoi8/Jp2Tt3exgz4t5kHFgCDSu/kLJeDj0wYdji453jzFE
rax9xzoJK91453cuFsaC+FHdNrwmec9XumZyfh93Zypb+rSSvRzsgmav+J4HXda4
18Rgcov+rzvFjjSc1GKcdesrN3qwUiqBso9YUCqWOgPZosQ3Jc1SEsqJkZ/NqaJ3
x7djMqK8WFqgN1RLQrh5WVNVZTnwAYSPhhKkvT+PWsrF0ocdBUK/9PQ3BFVMVBHy
opRLzo/ZdQUMZPZBVjNOwCJDWhUynZAG7gpfnAwXNX5FskU1AqgIQ1HekCV/HQQO
G5DyzW/o0ZqTbnU4+erq2IzX6Xbvqra6dlUJ5aFVIGpj/uwAcnqVFSP4D/QscNTP
s2nqnQ3PvAgivwhwfIWcm9kLCU1WqzFUaPDVRWWww9sK6vEhP6+Hyl+VOFwes1FB
OiOl/hJDKCxPtYxu4WC1rELAqhsPPBu1Xy4+y6FrAzhcpLfhYJw=
=bEfu
-----END PGP SIGNATURE-----

--5umvzyqucxgj552y--
