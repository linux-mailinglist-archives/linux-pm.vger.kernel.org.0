Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F544EF7D9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiDAQ0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbiDAQZl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 12:25:41 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2C14FBA3
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 08:55:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-df0940c4eeso3120547fac.8
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EAC2YihakS/CWu2cKpNWl7H/K7CcBg/XmCy85R1mPnQ=;
        b=d/yKuSD+wOaJRLlg+2YQUec/aGPima6UErIoeZXeQwh6Xk05djkiWbVEQ+bQB+ByL3
         IiYBkQ9hzmsJDaZexnCGNnE0IK2qRZTiz1M9o36ZnC9gmqLHN7/vmaMbT5BKfra4ZTGR
         kRAKTXmaZLFkBNKo+WRq5Sjlhm2uTRvuW5Qk2jU+IzkhRAH5p2zyOsFq7Zr6URpBXSjr
         NG44Rvano8uZx6jwEg5lXos+VGrvcSri0i17ZtafVUhSYjXBMr3MEoqiHsiD0tsdkP63
         0vaT1RpEJ0U8hx1Wz+scH5ABShZRYZM1yodP0SlhhnIlQSaraTmodf1bF3VeGKMfy6Zl
         zGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EAC2YihakS/CWu2cKpNWl7H/K7CcBg/XmCy85R1mPnQ=;
        b=5+9umyEt3y/bAPaWi4zwv6atOQ4dYcH4/dMhfGNjcD0kDMwfRVb34S8plKuI5zi7k2
         iE7VgjkNcskqMSHJYo5jTwtUcKSxRpO+dndXeBYCti0sgeA6xxrHlaF7OfH1qtGZwis3
         mE1jssKdcgcHbk6fIKmkoJyf+nkjzvUxWdPJLRxkvjeJ4qVpIaFQisqB2OmY2eafTxJ3
         eV55Vkh7Nsm2ZjdDK6whjTvFtl8ZWs7V/pS3Xi+h6ZmiRBN1uN1UlfYuNldQv5QhvzUR
         2Q4yeMsMDXQN+kVePLW+/etFiPnJVS6lxPvAbG7DfYoFaPdG8+e26ebe5lozSuIZOTPh
         oFkA==
X-Gm-Message-State: AOAM530/GGnyr/pd7yaHuhKAlGZjoD7v+/4OGs8cDE0UWm124LyLVZOe
        VS9Fn8fMAI6w1LvrY+wOxPU=
X-Google-Smtp-Source: ABdhPJxh1x6BAWR0yEPDjiuLovKIXDFZtH3ijW4As7/tO1NjvR2vPHThq7UfkOYnXfmArPoN1/oCMQ==
X-Received: by 2002:a05:6871:6a0:b0:dd:716f:5afd with SMTP id l32-20020a05687106a000b000dd716f5afdmr5177548oao.69.1648828529568;
        Fri, 01 Apr 2022 08:55:29 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568301e7100b005b256697d7csm1245343otr.72.2022.04.01.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:55:28 -0700 (PDT)
Date:   Fri, 1 Apr 2022 10:55:22 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 6/6 v3] power: supply: Static data for Samsung batteries
Message-ID: <20220401155522.GA17526@wintermute.localdomain>
References: <20220225001314.1881549-1-linus.walleij@linaro.org>
 <20220225001314.1881549-7-linus.walleij@linaro.org>
 <20220331192045.GA21680@wintermute.localdomain>
 <20220401153525.qhxyzj5gmh5mzghb@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401153525.qhxyzj5gmh5mzghb@mercury.elektranox.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 01, 2022 at 05:35:25PM +0200, Sebastian Reichel wrote:
> Hi Chris,
> 
> On Thu, Mar 31, 2022 at 02:20:45PM -0500, Chris Morgan wrote:
> > On Fri, Feb 25, 2022 at 01:13:14AM +0100, Linus Walleij wrote:
> > > If we detect a Samsung SDI battery, we return a static
> > > struct power_supply_battery_info and avoid looking further.
> > > 
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > 
> > I'm afraid this patch breaks my (currently work-in-progress) battery
> > driver for the rk817. I am not sure but I believe it might cause other
> > issues too for other downstream drivers (I don't have a device to test,
> > but I think maybe the ingenic driver looks like it could be affected
> > too).
> 
> I assume this fixes the issue for you?

I'll test it but I'm almost certain it will. Thank you.

> 
> https://lore.kernel.org/linux-pm/20220329033226.535475-1-y.oudjana@protonmail.com/
> 
> I plan to send it to Linus for rc2.
> 
> Thanks,
> 
> -- Sebastian
> 
> > 
> > > ChangeLog v2->v3:
> > > - Fix a whole bunch of tables after realizing that completely
> > >   different battery data was used if CONFIG_SAMSUNG_BATTERY
> > >   was set for Golden, Kyle, Codina and Skomer.
> > > ChangeLog v1->v2:
> > > - Bump tolerance to 40% on all BTI resistances
> > > - Change config option to bool, as we are calling OUT from
> > >   the supply core this cannot be compiled into a module
> > > - Augment data to support low/high temperature charge current
> > >   and voltages. Sadly the vendor tree just provide one and the
> > >   same current and voltage for all of these.
> > > ---
> > >  drivers/power/supply/Kconfig               |   6 +
> > >  drivers/power/supply/Makefile              |   1 +
> > >  drivers/power/supply/power_supply_core.c   |  28 +-
> > >  drivers/power/supply/samsung-sdi-battery.c | 919 +++++++++++++++++++++
> > >  drivers/power/supply/samsung-sdi-battery.h |  13 +
> > >  5 files changed, 957 insertions(+), 10 deletions(-)
> > >  create mode 100644 drivers/power/supply/samsung-sdi-battery.c
> > >  create mode 100644 drivers/power/supply/samsung-sdi-battery.h
> > > 
> > > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > > index 6815e5a4c0bd..e9df4151f2e0 100644
> > > --- a/drivers/power/supply/Kconfig
> > > +++ b/drivers/power/supply/Kconfig
> > > @@ -181,6 +181,12 @@ config BATTERY_OLPC
> > >  	help
> > >  	  Say Y to enable support for the battery on the OLPC laptop.
> > >  
> > > +config BATTERY_SAMSUNG_SDI
> > > +	bool "Samsung SDI batteries"
> > > +	help
> > > +	  Say Y to enable support for Samsung SDI battery data.
> > > +	  These batteries are used in Samsung mobile phones.
> > > +
> > >  config BATTERY_TOSA
> > >  	tristate "Sharp SL-6000 (tosa) battery"
> > >  	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
> > > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > > index 2c1b264b2046..ebcd2f5fe26d 100644
> > > --- a/drivers/power/supply/Makefile
> > > +++ b/drivers/power/supply/Makefile
> > > @@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
> > >  obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
> > >  obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
> > >  obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
> > > +obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+= samsung-sdi-battery.o
> > >  obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
> > >  obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
> > >  obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
> > > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > > index 1c0b1be22067..43c66214bedf 100644
> > > --- a/drivers/power/supply/power_supply_core.c
> > > +++ b/drivers/power/supply/power_supply_core.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/thermal.h>
> > >  #include <linux/fixp-arith.h>
> > >  #include "power_supply.h"
> > > +#include "samsung-sdi-battery.h"
> > >  
> > >  /* exported for the APM Power driver, APM emulation */
> > >  struct class *power_supply_class;
> > > @@ -573,6 +574,23 @@ int power_supply_get_battery_info(struct power_supply *psy,
> > >  	int err, len, index;
> > >  	const __be32 *list;
> > >  
> > > +	if (!psy->of_node) {
> > > +		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> > > +			 __func__);
> > > +		return -ENXIO;
> > > +	}
> > > +
> > > +	battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
> > > +	if (!battery_np)
> > > +		return -ENODEV;
> > > +
> > > +	/* Try static batteries first */
> > > +	err = samsung_sdi_battery_get_info(&psy->dev, battery_np, &info);
> > If the device isn't a Samsung battery this puts -ENODEV in the err variable.
> > For my case I have a simple-battery that isn't a Samsung battery, and it
> > is causing power_supply_get_battery_info to return an error.
> > 
> > > +	if (!err) {
> > > +		*info_out = info;
> > > +		return err;
> > > +	}
> > > +
> > >  	info = devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> > >  	if (!info)
> > >  		return -ENOMEM;
> > > @@ -612,16 +630,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
> > >  		info->ocv_table_size[index]  = -EINVAL;
> > >  	}
> > >  
> > > -	if (!psy->of_node) {
> > > -		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> > > -			 __func__);
> > > -		return -ENXIO;
> > > -	}
> > > -
> > > -	battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
> > > -	if (!battery_np)
> > > -		return -ENODEV;
> > > -
> > >  	err = of_property_read_string(battery_np, "compatible", &value);
> > >  	if (err)
> > >  		goto out_put_node;
> > > diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
> > > new file mode 100644
> > > index 000000000000..8e718f0fc2b5
> > > --- /dev/null
> > > +++ b/drivers/power/supply/samsung-sdi-battery.c
> > > @@ -0,0 +1,919 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * Battery data and characteristics for Samsung SDI (Samsung Digital Interface)
> > > + * batteries. The data is retrieved automatically into drivers using
> > > + * the power_supply_get_battery_info() call.
> > > + *
> > > + * The BTI (battery type indicator) resistance in the code drops was very
> > > + * unreliable. The resistance listed here was obtained by simply measuring
> > > + * the BTI resistance with a multimeter on the battery.
> > > + */
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/power_supply.h>
> > > +#include "samsung-sdi-battery.h"
> > > +
> > > +struct samsung_sdi_battery {
> > > +	char *compatible;
> > > +	char *name;
> > > +	struct power_supply_battery_info info;
> > > +};
> > > +
> > > +/*
> > > + * Voltage to internal resistance tables. The internal resistance varies
> > > + * depending on the VBAT voltage, so look this up from a table. Different
> > > + * tables apply depending on whether we are charging or not.
> > > + */
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb_l1m7flu[] = {
> > > +	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
> > > +	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
> > > +	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
> > > +	{ .vbat_uv = 4160000, .ri_uohm = 184000 },
> > > +	{ .vbat_uv = 4140000, .ri_uohm = 191000 },
> > > +	{ .vbat_uv = 4120000, .ri_uohm = 204000 },
> > > +	{ .vbat_uv = 4076000, .ri_uohm = 220000 },
> > > +	{ .vbat_uv = 4030000, .ri_uohm = 227000 },
> > > +	{ .vbat_uv = 3986000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 3916000, .ri_uohm = 221000 },
> > > +	{ .vbat_uv = 3842000, .ri_uohm = 259000 },
> > > +	{ .vbat_uv = 3773000, .ri_uohm = 287000 },
> > > +	{ .vbat_uv = 3742000, .ri_uohm = 283000 },
> > > +	{ .vbat_uv = 3709000, .ri_uohm = 277000 },
> > > +	{ .vbat_uv = 3685000, .ri_uohm = 297000 },
> > > +	{ .vbat_uv = 3646000, .ri_uohm = 310000 },
> > > +	{ .vbat_uv = 3616000, .ri_uohm = 331000 },
> > > +	{ .vbat_uv = 3602000, .ri_uohm = 370000 },
> > > +	{ .vbat_uv = 3578000, .ri_uohm = 350000 },
> > > +	{ .vbat_uv = 3553000, .ri_uohm = 321000 },
> > > +	{ .vbat_uv = 3503000, .ri_uohm = 322000 },
> > > +	{ .vbat_uv = 3400000, .ri_uohm = 269000 },
> > > +	{ .vbat_uv = 3360000, .ri_uohm = 328000 },
> > > +	{ .vbat_uv = 3330000, .ri_uohm = 305000 },
> > > +	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb_l1m7flu[] = {
> > > +	{ .vbat_uv = 4302000, .ri_uohm = 230000 },
> > > +	{ .vbat_uv = 4276000, .ri_uohm = 345000 },
> > > +	{ .vbat_uv = 4227000, .ri_uohm = 345000 },
> > > +	{ .vbat_uv = 4171000, .ri_uohm = 346000 },
> > > +	{ .vbat_uv = 4134000, .ri_uohm = 311000 },
> > > +	{ .vbat_uv = 4084000, .ri_uohm = 299000 },
> > > +	{ .vbat_uv = 4052000, .ri_uohm = 316000 },
> > > +	{ .vbat_uv = 4012000, .ri_uohm = 309000 },
> > > +	{ .vbat_uv = 3961000, .ri_uohm = 303000 },
> > > +	{ .vbat_uv = 3939000, .ri_uohm = 280000 },
> > > +	{ .vbat_uv = 3904000, .ri_uohm = 261000 },
> > > +	{ .vbat_uv = 3850000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 232000 },
> > > +	{ .vbat_uv = 3750000, .ri_uohm = 177000 },
> > > +	{ .vbat_uv = 3712000, .ri_uohm = 164000 },
> > > +	{ .vbat_uv = 3674000, .ri_uohm = 161000 },
> > > +	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161la[] = {
> > > +	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
> > > +	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
> > > +	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
> > > +	{ .vbat_uv = 4160000, .ri_uohm = 184000 },
> > > +	{ .vbat_uv = 4140000, .ri_uohm = 191000 },
> > > +	{ .vbat_uv = 4120000, .ri_uohm = 204000 },
> > > +	{ .vbat_uv = 4080000, .ri_uohm = 200000 },
> > > +	{ .vbat_uv = 4027000, .ri_uohm = 202000 },
> > > +	{ .vbat_uv = 3916000, .ri_uohm = 221000 },
> > > +	{ .vbat_uv = 3842000, .ri_uohm = 259000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 262000 },
> > > +	{ .vbat_uv = 3742000, .ri_uohm = 263000 },
> > > +	{ .vbat_uv = 3709000, .ri_uohm = 277000 },
> > > +	{ .vbat_uv = 3685000, .ri_uohm = 312000 },
> > > +	{ .vbat_uv = 3668000, .ri_uohm = 258000 },
> > > +	{ .vbat_uv = 3660000, .ri_uohm = 247000 },
> > > +	{ .vbat_uv = 3636000, .ri_uohm = 293000 },
> > > +	{ .vbat_uv = 3616000, .ri_uohm = 331000 },
> > > +	{ .vbat_uv = 3600000, .ri_uohm = 349000 },
> > > +	{ .vbat_uv = 3593000, .ri_uohm = 345000 },
> > > +	{ .vbat_uv = 3585000, .ri_uohm = 344000 },
> > > +	{ .vbat_uv = 3572000, .ri_uohm = 336000 },
> > > +	{ .vbat_uv = 3553000, .ri_uohm = 321000 },
> > > +	{ .vbat_uv = 3517000, .ri_uohm = 336000 },
> > > +	{ .vbat_uv = 3503000, .ri_uohm = 322000 },
> > > +	{ .vbat_uv = 3400000, .ri_uohm = 269000 },
> > > +	{ .vbat_uv = 3360000, .ri_uohm = 328000 },
> > > +	{ .vbat_uv = 3330000, .ri_uohm = 305000 },
> > > +	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161la[] = {
> > > +	{ .vbat_uv = 4345000, .ri_uohm = 230000 },
> > > +	{ .vbat_uv = 4329000, .ri_uohm = 238000 },
> > > +	{ .vbat_uv = 4314000, .ri_uohm = 225000 },
> > > +	{ .vbat_uv = 4311000, .ri_uohm = 239000 },
> > > +	{ .vbat_uv = 4294000, .ri_uohm = 235000 },
> > > +	{ .vbat_uv = 4264000, .ri_uohm = 229000 },
> > > +	{ .vbat_uv = 4262000, .ri_uohm = 228000 },
> > > +	{ .vbat_uv = 4252000, .ri_uohm = 236000 },
> > > +	{ .vbat_uv = 4244000, .ri_uohm = 234000 },
> > > +	{ .vbat_uv = 4235000, .ri_uohm = 234000 },
> > > +	{ .vbat_uv = 4227000, .ri_uohm = 238000 },
> > > +	{ .vbat_uv = 4219000, .ri_uohm = 242000 },
> > > +	{ .vbat_uv = 4212000, .ri_uohm = 239000 },
> > > +	{ .vbat_uv = 4206000, .ri_uohm = 231000 },
> > > +	{ .vbat_uv = 4201000, .ri_uohm = 231000 },
> > > +	{ .vbat_uv = 4192000, .ri_uohm = 224000 },
> > > +	{ .vbat_uv = 4184000, .ri_uohm = 238000 },
> > > +	{ .vbat_uv = 4173000, .ri_uohm = 245000 },
> > > +	{ .vbat_uv = 4161000, .ri_uohm = 244000 },
> > > +	{ .vbat_uv = 4146000, .ri_uohm = 244000 },
> > > +	{ .vbat_uv = 4127000, .ri_uohm = 228000 },
> > > +	{ .vbat_uv = 4119000, .ri_uohm = 218000 },
> > > +	{ .vbat_uv = 4112000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 4108000, .ri_uohm = 209000 },
> > > +	{ .vbat_uv = 4102000, .ri_uohm = 214000 },
> > > +	{ .vbat_uv = 4096000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 4090000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 4083000, .ri_uohm = 219000 },
> > > +	{ .vbat_uv = 4078000, .ri_uohm = 208000 },
> > > +	{ .vbat_uv = 4071000, .ri_uohm = 205000 },
> > > +	{ .vbat_uv = 4066000, .ri_uohm = 208000 },
> > > +	{ .vbat_uv = 4061000, .ri_uohm = 210000 },
> > > +	{ .vbat_uv = 4055000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 4049000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 4042000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 4032000, .ri_uohm = 217000 },
> > > +	{ .vbat_uv = 4027000, .ri_uohm = 220000 },
> > > +	{ .vbat_uv = 4020000, .ri_uohm = 210000 },
> > > +	{ .vbat_uv = 4013000, .ri_uohm = 214000 },
> > > +	{ .vbat_uv = 4007000, .ri_uohm = 219000 },
> > > +	{ .vbat_uv = 4003000, .ri_uohm = 229000 },
> > > +	{ .vbat_uv = 3996000, .ri_uohm = 246000 },
> > > +	{ .vbat_uv = 3990000, .ri_uohm = 245000 },
> > > +	{ .vbat_uv = 3984000, .ri_uohm = 242000 },
> > > +	{ .vbat_uv = 3977000, .ri_uohm = 236000 },
> > > +	{ .vbat_uv = 3971000, .ri_uohm = 231000 },
> > > +	{ .vbat_uv = 3966000, .ri_uohm = 229000 },
> > > +	{ .vbat_uv = 3952000, .ri_uohm = 226000 },
> > > +	{ .vbat_uv = 3946000, .ri_uohm = 222000 },
> > > +	{ .vbat_uv = 3941000, .ri_uohm = 222000 },
> > > +	{ .vbat_uv = 3936000, .ri_uohm = 217000 },
> > > +	{ .vbat_uv = 3932000, .ri_uohm = 217000 },
> > > +	{ .vbat_uv = 3928000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3926000, .ri_uohm = 214000 },
> > > +	{ .vbat_uv = 3922000, .ri_uohm = 209000 },
> > > +	{ .vbat_uv = 3917000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 3914000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3912000, .ri_uohm = 220000 },
> > > +	{ .vbat_uv = 3910000, .ri_uohm = 226000 },
> > > +	{ .vbat_uv = 3903000, .ri_uohm = 226000 },
> > > +	{ .vbat_uv = 3891000, .ri_uohm = 222000 },
> > > +	{ .vbat_uv = 3871000, .ri_uohm = 221000 },
> > > +	{ .vbat_uv = 3857000, .ri_uohm = 219000 },
> > > +	{ .vbat_uv = 3850000, .ri_uohm = 216000 },
> > > +	{ .vbat_uv = 3843000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3835000, .ri_uohm = 206000 },
> > > +	{ .vbat_uv = 3825000, .ri_uohm = 217000 },
> > > +	{ .vbat_uv = 3824000, .ri_uohm = 220000 },
> > > +	{ .vbat_uv = 3820000, .ri_uohm = 237000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 232000 },
> > > +	{ .vbat_uv = 3750000, .ri_uohm = 177000 },
> > > +	{ .vbat_uv = 3712000, .ri_uohm = 164000 },
> > > +	{ .vbat_uv = 3674000, .ri_uohm = 161000 },
> > > +	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb425161lu[] = {
> > > +	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
> > > +	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
> > > +	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
> > > +	{ .vbat_uv = 4160000, .ri_uohm = 184000 },
> > > +	{ .vbat_uv = 4140000, .ri_uohm = 191000 },
> > > +	{ .vbat_uv = 4120000, .ri_uohm = 204000 },
> > > +	{ .vbat_uv = 4080000, .ri_uohm = 200000 },
> > > +	{ .vbat_uv = 4027000, .ri_uohm = 202000 },
> > > +	{ .vbat_uv = 3916000, .ri_uohm = 221000 },
> > > +	{ .vbat_uv = 3842000, .ri_uohm = 259000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 262000 },
> > > +	{ .vbat_uv = 3742000, .ri_uohm = 263000 },
> > > +	{ .vbat_uv = 3708000, .ri_uohm = 277000 },
> > > +	{ .vbat_uv = 3684000, .ri_uohm = 272000 },
> > > +	{ .vbat_uv = 3664000, .ri_uohm = 278000 },
> > > +	{ .vbat_uv = 3655000, .ri_uohm = 285000 },
> > > +	{ .vbat_uv = 3638000, .ri_uohm = 261000 },
> > > +	{ .vbat_uv = 3624000, .ri_uohm = 259000 },
> > > +	{ .vbat_uv = 3616000, .ri_uohm = 266000 },
> > > +	{ .vbat_uv = 3597000, .ri_uohm = 278000 },
> > > +	{ .vbat_uv = 3581000, .ri_uohm = 281000 },
> > > +	{ .vbat_uv = 3560000, .ri_uohm = 287000 },
> > > +	{ .vbat_uv = 3527000, .ri_uohm = 289000 },
> > > +	{ .vbat_uv = 3512000, .ri_uohm = 286000 },
> > > +	{ .vbat_uv = 3494000, .ri_uohm = 282000 },
> > > +	{ .vbat_uv = 3400000, .ri_uohm = 269000 },
> > > +	{ .vbat_uv = 3360000, .ri_uohm = 328000 },
> > > +	{ .vbat_uv = 3330000, .ri_uohm = 305000 },
> > > +	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb425161lu[] = {
> > > +	{ .vbat_uv = 4346000, .ri_uohm = 293000 },
> > > +	{ .vbat_uv = 4336000, .ri_uohm = 290000 },
> > > +	{ .vbat_uv = 4315000, .ri_uohm = 274000 },
> > > +	{ .vbat_uv = 4310000, .ri_uohm = 264000 },
> > > +	{ .vbat_uv = 4275000, .ri_uohm = 275000 },
> > > +	{ .vbat_uv = 4267000, .ri_uohm = 274000 },
> > > +	{ .vbat_uv = 4227000, .ri_uohm = 262000 },
> > > +	{ .vbat_uv = 4186000, .ri_uohm = 282000 },
> > > +	{ .vbat_uv = 4136000, .ri_uohm = 246000 },
> > > +	{ .vbat_uv = 4110000, .ri_uohm = 242000 },
> > > +	{ .vbat_uv = 4077000, .ri_uohm = 249000 },
> > > +	{ .vbat_uv = 4049000, .ri_uohm = 238000 },
> > > +	{ .vbat_uv = 4017000, .ri_uohm = 268000 },
> > > +	{ .vbat_uv = 3986000, .ri_uohm = 261000 },
> > > +	{ .vbat_uv = 3962000, .ri_uohm = 252000 },
> > > +	{ .vbat_uv = 3940000, .ri_uohm = 235000 },
> > > +	{ .vbat_uv = 3930000, .ri_uohm = 237000 },
> > > +	{ .vbat_uv = 3924000, .ri_uohm = 255000 },
> > > +	{ .vbat_uv = 3910000, .ri_uohm = 244000 },
> > > +	{ .vbat_uv = 3889000, .ri_uohm = 231000 },
> > > +	{ .vbat_uv = 3875000, .ri_uohm = 249000 },
> > > +	{ .vbat_uv = 3850000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 232000 },
> > > +	{ .vbat_uv = 3750000, .ri_uohm = 177000 },
> > > +	{ .vbat_uv = 3712000, .ri_uohm = 164000 },
> > > +	{ .vbat_uv = 3674000, .ri_uohm = 161000 },
> > > +	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb485159lu[] = {
> > > +	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
> > > +	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
> > > +	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
> > > +	{ .vbat_uv = 4160000, .ri_uohm = 184000 },
> > > +	{ .vbat_uv = 4140000, .ri_uohm = 191000 },
> > > +	{ .vbat_uv = 4120000, .ri_uohm = 204000 },
> > > +	{ .vbat_uv = 4080000, .ri_uohm = 200000 },
> > > +	{ .vbat_uv = 4027000, .ri_uohm = 202000 },
> > > +	{ .vbat_uv = 3916000, .ri_uohm = 221000 },
> > > +	{ .vbat_uv = 3842000, .ri_uohm = 259000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 262000 },
> > > +	{ .vbat_uv = 3715000, .ri_uohm = 340000 },
> > > +	{ .vbat_uv = 3700000, .ri_uohm = 300000 },
> > > +	{ .vbat_uv = 3682000, .ri_uohm = 233000 },
> > > +	{ .vbat_uv = 3655000, .ri_uohm = 246000 },
> > > +	{ .vbat_uv = 3639000, .ri_uohm = 260000 },
> > > +	{ .vbat_uv = 3621000, .ri_uohm = 254000 },
> > > +	{ .vbat_uv = 3583000, .ri_uohm = 266000 },
> > > +	{ .vbat_uv = 3536000, .ri_uohm = 274000 },
> > > +	{ .vbat_uv = 3502000, .ri_uohm = 300000 },
> > > +	{ .vbat_uv = 3465000, .ri_uohm = 245000 },
> > > +	{ .vbat_uv = 3438000, .ri_uohm = 225000 },
> > > +	{ .vbat_uv = 3330000, .ri_uohm = 305000 },
> > > +	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb485159lu[] = {
> > > +	{ .vbat_uv = 4302000, .ri_uohm = 200000 },
> > > +	{ .vbat_uv = 4258000, .ri_uohm = 206000 },
> > > +	{ .vbat_uv = 4200000, .ri_uohm = 231000 },
> > > +	{ .vbat_uv = 4150000, .ri_uohm = 198000 },
> > > +	{ .vbat_uv = 4134000, .ri_uohm = 268000 },
> > > +	{ .vbat_uv = 4058000, .ri_uohm = 172000 },
> > > +	{ .vbat_uv = 4003000, .ri_uohm = 227000 },
> > > +	{ .vbat_uv = 3972000, .ri_uohm = 241000 },
> > > +	{ .vbat_uv = 3953000, .ri_uohm = 244000 },
> > > +	{ .vbat_uv = 3950000, .ri_uohm = 213000 },
> > > +	{ .vbat_uv = 3900000, .ri_uohm = 225000 },
> > > +	{ .vbat_uv = 3850000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 232000 },
> > > +	{ .vbat_uv = 3750000, .ri_uohm = 177000 },
> > > +	{ .vbat_uv = 3712000, .ri_uohm = 164000 },
> > > +	{ .vbat_uv = 3674000, .ri_uohm = 161000 },
> > > +	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb535151vu[] = {
> > > +	{ .vbat_uv = 4071000, .ri_uohm = 158000 },
> > > +	{ .vbat_uv = 4019000, .ri_uohm = 187000 },
> > > +	{ .vbat_uv = 3951000, .ri_uohm = 191000 },
> > > +	{ .vbat_uv = 3901000, .ri_uohm = 193000 },
> > > +	{ .vbat_uv = 3850000, .ri_uohm = 273000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 305000 },
> > > +	{ .vbat_uv = 3750000, .ri_uohm = 205000 },
> > > +	{ .vbat_uv = 3700000, .ri_uohm = 290000 },
> > > +	{ .vbat_uv = 3650000, .ri_uohm = 262000 },
> > > +	{ .vbat_uv = 3618000, .ri_uohm = 290000 },
> > > +	{ .vbat_uv = 3505000, .ri_uohm = 235000 },
> > > +	{ .vbat_uv = 3484000, .ri_uohm = 253000 },
> > > +	{ .vbat_uv = 3413000, .ri_uohm = 243000 },
> > > +	{ .vbat_uv = 3393000, .ri_uohm = 285000 },
> > > +	{ .vbat_uv = 3361000, .ri_uohm = 281000 },
> > > +	{ .vbat_uv = 3302000, .ri_uohm = 286000 },
> > > +	{ .vbat_uv = 3280000, .ri_uohm = 250000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb535151vu[] = {
> > > +	{ .vbat_uv = 4190000, .ri_uohm = 214000 },
> > > +	{ .vbat_uv = 4159000, .ri_uohm = 252000 },
> > > +	{ .vbat_uv = 4121000, .ri_uohm = 245000 },
> > > +	{ .vbat_uv = 4069000, .ri_uohm = 228000 },
> > > +	{ .vbat_uv = 4046000, .ri_uohm = 229000 },
> > > +	{ .vbat_uv = 4026000, .ri_uohm = 233000 },
> > > +	{ .vbat_uv = 4007000, .ri_uohm = 240000 },
> > > +	{ .vbat_uv = 3982000, .ri_uohm = 291000 },
> > > +	{ .vbat_uv = 3945000, .ri_uohm = 276000 },
> > > +	{ .vbat_uv = 3924000, .ri_uohm = 266000 },
> > > +	{ .vbat_uv = 3910000, .ri_uohm = 258000 },
> > > +	{ .vbat_uv = 3900000, .ri_uohm = 271000 },
> > > +	{ .vbat_uv = 3844000, .ri_uohm = 279000 },
> > > +	{ .vbat_uv = 3772000, .ri_uohm = 217000 },
> > > +	{ .vbat_uv = 3673000, .ri_uohm = 208000 },
> > > +	{ .vbat_uv = 3571000, .ri_uohm = 208000 },
> > > +	{ .vbat_uv = 3510000, .ri_uohm = 228000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb585157lu[] = {
> > > +	{ .vbat_uv = 4194000, .ri_uohm = 121000 },
> > > +	{ .vbat_uv = 4169000, .ri_uohm = 188000 },
> > > +	{ .vbat_uv = 4136000, .ri_uohm = 173000 },
> > > +	{ .vbat_uv = 4108000, .ri_uohm = 158000 },
> > > +	{ .vbat_uv = 4064000, .ri_uohm = 143000 },
> > > +	{ .vbat_uv = 3956000, .ri_uohm = 160000 },
> > > +	{ .vbat_uv = 3847000, .ri_uohm = 262000 },
> > > +	{ .vbat_uv = 3806000, .ri_uohm = 280000 },
> > > +	{ .vbat_uv = 3801000, .ri_uohm = 266000 },
> > > +	{ .vbat_uv = 3794000, .ri_uohm = 259000 },
> > > +	{ .vbat_uv = 3785000, .ri_uohm = 234000 },
> > > +	{ .vbat_uv = 3779000, .ri_uohm = 227000 },
> > > +	{ .vbat_uv = 3772000, .ri_uohm = 222000 },
> > > +	{ .vbat_uv = 3765000, .ri_uohm = 221000 },
> > > +	{ .vbat_uv = 3759000, .ri_uohm = 216000 },
> > > +	{ .vbat_uv = 3754000, .ri_uohm = 206000 },
> > > +	{ .vbat_uv = 3747000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3743000, .ri_uohm = 208000 },
> > > +	{ .vbat_uv = 3737000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3733000, .ri_uohm = 200000 },
> > > +	{ .vbat_uv = 3728000, .ri_uohm = 203000 },
> > > +	{ .vbat_uv = 3722000, .ri_uohm = 207000 },
> > > +	{ .vbat_uv = 3719000, .ri_uohm = 208000 },
> > > +	{ .vbat_uv = 3715000, .ri_uohm = 209000 },
> > > +	{ .vbat_uv = 3712000, .ri_uohm = 211000 },
> > > +	{ .vbat_uv = 3709000, .ri_uohm = 210000 },
> > > +	{ .vbat_uv = 3704000, .ri_uohm = 216000 },
> > > +	{ .vbat_uv = 3701000, .ri_uohm = 218000 },
> > > +	{ .vbat_uv = 3698000, .ri_uohm = 222000 },
> > > +	{ .vbat_uv = 3694000, .ri_uohm = 218000 },
> > > +	{ .vbat_uv = 3692000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 3688000, .ri_uohm = 224000 },
> > > +	{ .vbat_uv = 3686000, .ri_uohm = 224000 },
> > > +	{ .vbat_uv = 3683000, .ri_uohm = 228000 },
> > > +	{ .vbat_uv = 3681000, .ri_uohm = 228000 },
> > > +	{ .vbat_uv = 3679000, .ri_uohm = 229000 },
> > > +	{ .vbat_uv = 3676000, .ri_uohm = 232000 },
> > > +	{ .vbat_uv = 3675000, .ri_uohm = 229000 },
> > > +	{ .vbat_uv = 3673000, .ri_uohm = 229000 },
> > > +	{ .vbat_uv = 3672000, .ri_uohm = 223000 },
> > > +	{ .vbat_uv = 3669000, .ri_uohm = 224000 },
> > > +	{ .vbat_uv = 3666000, .ri_uohm = 224000 },
> > > +	{ .vbat_uv = 3663000, .ri_uohm = 221000 },
> > > +	{ .vbat_uv = 3660000, .ri_uohm = 218000 },
> > > +	{ .vbat_uv = 3657000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 3654000, .ri_uohm = 212000 },
> > > +	{ .vbat_uv = 3649000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 3644000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 3636000, .ri_uohm = 215000 },
> > > +	{ .vbat_uv = 3631000, .ri_uohm = 206000 },
> > > +	{ .vbat_uv = 3623000, .ri_uohm = 205000 },
> > > +	{ .vbat_uv = 3616000, .ri_uohm = 193000 },
> > > +	{ .vbat_uv = 3605000, .ri_uohm = 193000 },
> > > +	{ .vbat_uv = 3600000, .ri_uohm = 198000 },
> > > +	{ .vbat_uv = 3597000, .ri_uohm = 198000 },
> > > +	{ .vbat_uv = 3592000, .ri_uohm = 203000 },
> > > +	{ .vbat_uv = 3591000, .ri_uohm = 188000 },
> > > +	{ .vbat_uv = 3587000, .ri_uohm = 188000 },
> > > +	{ .vbat_uv = 3583000, .ri_uohm = 177000 },
> > > +	{ .vbat_uv = 3577000, .ri_uohm = 170000 },
> > > +	{ .vbat_uv = 3568000, .ri_uohm = 135000 },
> > > +	{ .vbat_uv = 3552000, .ri_uohm = 54000 },
> > > +	{ .vbat_uv = 3526000, .ri_uohm = 130000 },
> > > +	{ .vbat_uv = 3501000, .ri_uohm = 48000 },
> > > +	{ .vbat_uv = 3442000, .ri_uohm = 183000 },
> > > +	{ .vbat_uv = 3326000, .ri_uohm = 372000 },
> > > +	{ .vbat_uv = 3161000, .ri_uohm = 452000 },
> > > +};
> > > +
> > > +struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb585157lu[] = {
> > > +	{ .vbat_uv = 4360000, .ri_uohm = 128000 },
> > > +	{ .vbat_uv = 4325000, .ri_uohm = 130000 },
> > > +	{ .vbat_uv = 4316000, .ri_uohm = 148000 },
> > > +	{ .vbat_uv = 4308000, .ri_uohm = 162000 },
> > > +	{ .vbat_uv = 4301000, .ri_uohm = 162000 },
> > > +	{ .vbat_uv = 4250000, .ri_uohm = 162000 },
> > > +	{ .vbat_uv = 4230000, .ri_uohm = 164000 },
> > > +	{ .vbat_uv = 4030000, .ri_uohm = 164000 },
> > > +	{ .vbat_uv = 4000000, .ri_uohm = 193000 },
> > > +	{ .vbat_uv = 3950000, .ri_uohm = 204000 },
> > > +	{ .vbat_uv = 3850000, .ri_uohm = 210000 },
> > > +	{ .vbat_uv = 3800000, .ri_uohm = 230000 },
> > > +	{ .vbat_uv = 3790000, .ri_uohm = 240000 },
> > > +	{ .vbat_uv = 3780000, .ri_uohm = 311000 },
> > > +	{ .vbat_uv = 3760000, .ri_uohm = 420000 },
> > > +	{ .vbat_uv = 3700000, .ri_uohm = 504000 },
> > > +	{ .vbat_uv = 3600000, .ri_uohm = 565000 },
> > > +};
> > > +
> > > +/*
> > > + * Temperature to internal resistance scaling tables.
> > > + *
> > > + * "resistance" is the percentage of the resistance determined from the voltage
> > > + * so this represents the capacity ratio at different temperatures.
> > > + *
> > > + * FIXME: the proper table is missing: Samsung does not provide the necessary
> > > + * temperature compensation tables so we just state 100% for every temperature.
> > > + * If you have the datasheets, please provide these tables.
> > > + */
> > > +static struct power_supply_resistance_temp_table samsung_temp2res[] = {
> > > +	{ .temp = 50, .resistance = 100 },
> > > +	{ .temp = 40, .resistance = 100 },
> > > +	{ .temp = 30, .resistance = 100 },
> > > +	{ .temp = 20, .resistance = 100 },
> > > +	{ .temp = 10, .resistance = 100 },
> > > +	{ .temp = 00, .resistance = 100 },
> > > +	{ .temp = -10, .resistance = 100 },
> > > +	{ .temp = -20, .resistance = 100 },
> > > +};
> > > +
> > > +/*
> > > + * Capacity tables for different Open Circuit Voltages (OCV).
> > > + * These must be sorted by falling OCV value.
> > > + */
> > > +
> > > +static struct power_supply_battery_ocv_table samsung_ocv_cap_eb485159lu[] = {
> > > +	{ .ocv = 4330000, .capacity = 100},
> > > +	{ .ocv = 4320000, .capacity = 99},
> > > +	{ .ocv = 4283000, .capacity = 95},
> > > +	{ .ocv = 4246000, .capacity = 92},
> > > +	{ .ocv = 4211000, .capacity = 89},
> > > +	{ .ocv = 4167000, .capacity = 85},
> > > +	{ .ocv = 4146000, .capacity = 83},
> > > +	{ .ocv = 4124000, .capacity = 81},
> > > +	{ .ocv = 4062000, .capacity = 75},
> > > +	{ .ocv = 4013000, .capacity = 70},
> > > +	{ .ocv = 3977000, .capacity = 66},
> > > +	{ .ocv = 3931000, .capacity = 60},
> > > +	{ .ocv = 3914000, .capacity = 58},
> > > +	{ .ocv = 3901000, .capacity = 57},
> > > +	{ .ocv = 3884000, .capacity = 56},
> > > +	{ .ocv = 3870000, .capacity = 55},
> > > +	{ .ocv = 3862000, .capacity = 54},
> > > +	{ .ocv = 3854000, .capacity = 53},
> > > +	{ .ocv = 3838000, .capacity = 50},
> > > +	{ .ocv = 3823000, .capacity = 47},
> > > +	{ .ocv = 3813000, .capacity = 45},
> > > +	{ .ocv = 3807000, .capacity = 43},
> > > +	{ .ocv = 3800000, .capacity = 41},
> > > +	{ .ocv = 3795000, .capacity = 40},
> > > +	{ .ocv = 3786000, .capacity = 37},
> > > +	{ .ocv = 3783000, .capacity = 35},
> > > +	{ .ocv = 3773000, .capacity = 30},
> > > +	{ .ocv = 3758000, .capacity = 25},
> > > +	{ .ocv = 3745000, .capacity = 22},
> > > +	{ .ocv = 3738000, .capacity = 20},
> > > +	{ .ocv = 3733000, .capacity = 19},
> > > +	{ .ocv = 3716000, .capacity = 17},
> > > +	{ .ocv = 3709000, .capacity = 16},
> > > +	{ .ocv = 3698000, .capacity = 15},
> > > +	{ .ocv = 3687000, .capacity = 14},
> > > +	{ .ocv = 3684000, .capacity = 13},
> > > +	{ .ocv = 3684000, .capacity = 12},
> > > +	{ .ocv = 3678000, .capacity = 10},
> > > +	{ .ocv = 3671000, .capacity = 9},
> > > +	{ .ocv = 3665000, .capacity = 8},
> > > +	{ .ocv = 3651000, .capacity = 7},
> > > +	{ .ocv = 3634000, .capacity = 6},
> > > +	{ .ocv = 3601000, .capacity = 5},
> > > +	{ .ocv = 3564000, .capacity = 4},
> > > +	{ .ocv = 3516000, .capacity = 3},
> > > +	{ .ocv = 3456000, .capacity = 2},
> > > +	{ .ocv = 3381000, .capacity = 1},
> > > +	{ .ocv = 3300000, .capacity = 0},
> > > +};
> > > +
> > > +/* Same capacity table is used by eb-l1m7flu, eb425161la, eb425161lu */
> > > +static struct power_supply_battery_ocv_table samsung_ocv_cap_1500mah[] = {
> > > +	{ .ocv = 4328000, .capacity = 100},
> > > +	{ .ocv = 4299000, .capacity = 99},
> > > +	{ .ocv = 4281000, .capacity = 98},
> > > +	{ .ocv = 4241000, .capacity = 95},
> > > +	{ .ocv = 4183000, .capacity = 90},
> > > +	{ .ocv = 4150000, .capacity = 87},
> > > +	{ .ocv = 4116000, .capacity = 84},
> > > +	{ .ocv = 4077000, .capacity = 80},
> > > +	{ .ocv = 4068000, .capacity = 79},
> > > +	{ .ocv = 4058000, .capacity = 77},
> > > +	{ .ocv = 4026000, .capacity = 75},
> > > +	{ .ocv = 3987000, .capacity = 72},
> > > +	{ .ocv = 3974000, .capacity = 69},
> > > +	{ .ocv = 3953000, .capacity = 66},
> > > +	{ .ocv = 3933000, .capacity = 63},
> > > +	{ .ocv = 3911000, .capacity = 60},
> > > +	{ .ocv = 3900000, .capacity = 58},
> > > +	{ .ocv = 3873000, .capacity = 55},
> > > +	{ .ocv = 3842000, .capacity = 52},
> > > +	{ .ocv = 3829000, .capacity = 50},
> > > +	{ .ocv = 3810000, .capacity = 45},
> > > +	{ .ocv = 3793000, .capacity = 40},
> > > +	{ .ocv = 3783000, .capacity = 35},
> > > +	{ .ocv = 3776000, .capacity = 30},
> > > +	{ .ocv = 3762000, .capacity = 25},
> > > +	{ .ocv = 3746000, .capacity = 20},
> > > +	{ .ocv = 3739000, .capacity = 18},
> > > +	{ .ocv = 3715000, .capacity = 15},
> > > +	{ .ocv = 3700000, .capacity = 12},
> > > +	{ .ocv = 3690000, .capacity = 10},
> > > +	{ .ocv = 3680000, .capacity = 9},
> > > +	{ .ocv = 3670000, .capacity = 7},
> > > +	{ .ocv = 3656000, .capacity = 5},
> > > +	{ .ocv = 3634000, .capacity = 4},
> > > +	{ .ocv = 3614000, .capacity = 3},
> > > +	{ .ocv = 3551000, .capacity = 2},
> > > +	{ .ocv = 3458000, .capacity = 1},
> > > +	{ .ocv = 3300000, .capacity = 0},
> > > +};
> > > +
> > > +static struct power_supply_battery_ocv_table samsung_ocv_cap_eb535151vu[] = {
> > > +	{ .ocv = 4178000, .capacity = 100},
> > > +	{ .ocv = 4148000, .capacity = 99},
> > > +	{ .ocv = 4105000, .capacity = 95},
> > > +	{ .ocv = 4078000, .capacity = 92},
> > > +	{ .ocv = 4057000, .capacity = 89},
> > > +	{ .ocv = 4013000, .capacity = 85},
> > > +	{ .ocv = 3988000, .capacity = 82},
> > > +	{ .ocv = 3962000, .capacity = 77},
> > > +	{ .ocv = 3920000, .capacity = 70},
> > > +	{ .ocv = 3891000, .capacity = 65},
> > > +	{ .ocv = 3874000, .capacity = 62},
> > > +	{ .ocv = 3839000, .capacity = 59},
> > > +	{ .ocv = 3816000, .capacity = 55},
> > > +	{ .ocv = 3798000, .capacity = 50},
> > > +	{ .ocv = 3778000, .capacity = 40},
> > > +	{ .ocv = 3764000, .capacity = 30},
> > > +	{ .ocv = 3743000, .capacity = 25},
> > > +	{ .ocv = 3711000, .capacity = 20},
> > > +	{ .ocv = 3691000, .capacity = 18},
> > > +	{ .ocv = 3685000, .capacity = 15},
> > > +	{ .ocv = 3680000, .capacity = 12},
> > > +	{ .ocv = 3662000, .capacity = 10},
> > > +	{ .ocv = 3638000, .capacity = 9},
> > > +	{ .ocv = 3593000, .capacity = 7},
> > > +	{ .ocv = 3566000, .capacity = 6},
> > > +	{ .ocv = 3497000, .capacity = 4},
> > > +	{ .ocv = 3405000, .capacity = 2},
> > > +	{ .ocv = 3352000, .capacity = 1},
> > > +	{ .ocv = 3300000, .capacity = 0},
> > > +};
> > > +
> > > +static struct power_supply_battery_ocv_table samsung_ocv_cap_eb585157lu[] = {
> > > +	{ .ocv = 4320000, .capacity = 100},
> > > +	{ .ocv = 4296000, .capacity = 99},
> > > +	{ .ocv = 4283000, .capacity = 98},
> > > +	{ .ocv = 4245000, .capacity = 95},
> > > +	{ .ocv = 4185000, .capacity = 90},
> > > +	{ .ocv = 4152000, .capacity = 87},
> > > +	{ .ocv = 4119000, .capacity = 84},
> > > +	{ .ocv = 4077000, .capacity = 80},
> > > +	{ .ocv = 4057000, .capacity = 78},
> > > +	{ .ocv = 4048000, .capacity = 77},
> > > +	{ .ocv = 4020000, .capacity = 74},
> > > +	{ .ocv = 4003000, .capacity = 72},
> > > +	{ .ocv = 3978000, .capacity = 69},
> > > +	{ .ocv = 3955000, .capacity = 66},
> > > +	{ .ocv = 3934000, .capacity = 63},
> > > +	{ .ocv = 3912000, .capacity = 60},
> > > +	{ .ocv = 3894000, .capacity = 58},
> > > +	{ .ocv = 3860000, .capacity = 55},
> > > +	{ .ocv = 3837000, .capacity = 52},
> > > +	{ .ocv = 3827000, .capacity = 50},
> > > +	{ .ocv = 3806000, .capacity = 45},
> > > +	{ .ocv = 3791000, .capacity = 40},
> > > +	{ .ocv = 3779000, .capacity = 35},
> > > +	{ .ocv = 3770000, .capacity = 30},
> > > +	{ .ocv = 3758000, .capacity = 25},
> > > +	{ .ocv = 3739000, .capacity = 20},
> > > +	{ .ocv = 3730000, .capacity = 18},
> > > +	{ .ocv = 3706000, .capacity = 15},
> > > +	{ .ocv = 3684000, .capacity = 13},
> > > +	{ .ocv = 3675000, .capacity = 10},
> > > +	{ .ocv = 3673000, .capacity = 9},
> > > +	{ .ocv = 3665000, .capacity = 7},
> > > +	{ .ocv = 3649000, .capacity = 5},
> > > +	{ .ocv = 3628000, .capacity = 4},
> > > +	{ .ocv = 3585000, .capacity = 3},
> > > +	{ .ocv = 3525000, .capacity = 2},
> > > +	{ .ocv = 3441000, .capacity = 1},
> > > +	{ .ocv = 3300000, .capacity = 0},
> > > +};
> > > +
> > > +struct power_supply_maintenance_charge_table samsung_maint_charge_table[] = {
> > > +	{
> > > +		/* Maintenance charging phase A, 60 hours */
> > > +		.charge_current_max_ua = 600000,
> > > +		.charge_voltage_max_uv = 4150000,
> > > +		.charge_safety_timer_minutes = 60*60,
> > > +	},
> > > +	{
> > > +		/* Maintenance charging phase B, 200 hours */
> > > +		.charge_current_max_ua = 600000,
> > > +		.charge_voltage_max_uv = 4100000,
> > > +		.charge_safety_timer_minutes = 200*60,
> > > +	}
> > > +};
> > > +
> > > +struct samsung_sdi_battery samsung_sdi_batteries[] = {
> > > +	{
> > > +		/*
> > > +		 * Used in Samsung GT-I8190 "Golden"
> > > +		 * Data from vendor boardfile board-golden-[bm|battery].c
> > > +		 */
> > > +		.compatible = "samsung,eb-l1m7flu",
> > > +		.name = "EB-L1M7FLU",
> > > +		.info = {
> > > +			.charge_full_design_uah = 1500000,
> > > +			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> > > +			.factory_internal_resistance_uohm = 100000,
> > > +			.factory_internal_resistance_charging_uohm = 200000,
> > > +			/* If you have data on this fix the min_design_uv */
> > > +			.voltage_min_design_uv = 3320000,
> > > +			.voltage_max_design_uv = 4340000,
> > > +			.overvoltage_limit_uv = 4500000,
> > > +			.constant_charge_current_max_ua = 900000,
> > > +			.constant_charge_voltage_max_uv = 4320000,
> > > +			.charge_term_current_ua = 200000,
> > > +			.charge_restart_voltage_uv = 4300000,
> > > +			.maintenance_charge = samsung_maint_charge_table,
> > > +			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
> > > +			.alert_low_temp_charge_current_ua = 300000,
> > > +			.alert_low_temp_charge_voltage_uv = 4000000,
> > > +			.alert_high_temp_charge_current_ua = 300000,
> > > +			.alert_high_temp_charge_voltage_uv = 4000000,
> > > +			.temp_min = -50,
> > > +			.temp_alert_min = 0,
> > > +			.temp_alert_max = 40,
> > > +			.temp_max = 60,
> > > +			.resist_table = samsung_temp2res,
> > > +			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
> > > +			/* If you have tables for more temperatures, add them */
> > > +			.ocv_temp[0] = 25,
> > > +			.ocv_table[0] = samsung_ocv_cap_1500mah,
> > > +			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_1500mah),
> > > +			.vbat2ri_discharging = samsung_vbat2res_discharging_eb_l1m7flu,
> > > +			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_eb_l1m7flu),
> > > +			.vbat2ri_charging = samsung_vbat2res_charging_eb_l1m7flu,
> > > +			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_eb_l1m7flu),
> > > +			.bti_resistance_ohm = 2400,
> > > +			.bti_resistance_tolerance = 40,
> > > +		},
> > > +	},
> > > +	{
> > > +		/*
> > > +		 * Used in Samsung SGH-T599 "Codina TMO" and SGH-I407 "Kyle"
> > > +		 * Data from vendor boardfile board-kyle-[bm|battery].c
> > > +		 */
> > > +		.compatible = "samsung,eb425161la",
> > > +		.name = "EB425161LA",
> > > +		.info = {
> > > +			.charge_full_design_uah = 1500000,
> > > +			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> > > +			.factory_internal_resistance_uohm = 136000,
> > > +			.factory_internal_resistance_charging_uohm = 200000,
> > > +			/* If you have data on this fix the min_design_uv */
> > > +			.voltage_min_design_uv = 3320000,
> > > +			.voltage_max_design_uv = 4340000,
> > > +			.overvoltage_limit_uv = 4500000,
> > > +			.constant_charge_current_max_ua = 900000,
> > > +			.constant_charge_voltage_max_uv = 4320000,
> > > +			.charge_term_current_ua = 200000,
> > > +			.charge_restart_voltage_uv = 4270000,
> > > +			.maintenance_charge = samsung_maint_charge_table,
> > > +			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
> > > +			.alert_low_temp_charge_current_ua = 300000,
> > > +			.alert_low_temp_charge_voltage_uv = 4000000,
> > > +			.alert_high_temp_charge_current_ua = 300000,
> > > +			.alert_high_temp_charge_voltage_uv = 4000000,
> > > +			.temp_min = -30,
> > > +			.temp_alert_min = 0,
> > > +			.temp_alert_max = 40,
> > > +			.temp_max = 47,
> > > +			.resist_table = samsung_temp2res,
> > > +			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
> > > +			/* If you have tables for more temperatures, add them */
> > > +			.ocv_temp[0] = 25,
> > > +			.ocv_table[0] = samsung_ocv_cap_1500mah,
> > > +			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_1500mah),
> > > +			.vbat2ri_discharging = samsung_vbat2res_discharging_eb425161la,
> > > +			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_eb425161la),
> > > +			.vbat2ri_charging = samsung_vbat2res_charging_eb425161la,
> > > +			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_eb425161la),
> > > +			.bti_resistance_ohm = 2400,
> > > +			.bti_resistance_tolerance = 40,
> > > +		},
> > > +	},
> > > +	{
> > > +		/*
> > > +		 * Used in Samsung GT-I8160 "Codina"
> > > +		 * Data from vendor boardfile board-codina-[bm|battery].c
> > > +		 */
> > > +		.compatible = "samsung,eb425161lu",
> > > +		.name = "EB425161LU",
> > > +		.info = {
> > > +			.charge_full_design_uah = 1500000,
> > > +			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> > > +			.factory_internal_resistance_uohm = 100000,
> > > +			.factory_internal_resistance_charging_uohm = 200000,
> > > +			/* If you have data on this fix the min_design_uv */
> > > +			.voltage_min_design_uv = 3320000,
> > > +			.voltage_max_design_uv = 4350000,
> > > +			.overvoltage_limit_uv = 4500000,
> > > +			.constant_charge_current_max_ua = 900000,
> > > +			.constant_charge_voltage_max_uv = 4340000,
> > > +			.charge_term_current_ua = 200000,
> > > +			.charge_restart_voltage_uv = 4280000,
> > > +			.maintenance_charge = samsung_maint_charge_table,
> > > +			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
> > > +			.alert_low_temp_charge_current_ua = 300000,
> > > +			.alert_low_temp_charge_voltage_uv = 4000000,
> > > +			.alert_high_temp_charge_current_ua = 300000,
> > > +			.alert_high_temp_charge_voltage_uv = 4000000,
> > > +			.temp_min = -50,
> > > +			.temp_alert_min = 0,
> > > +			.temp_alert_max = 43,
> > > +			.temp_max = 49,
> > > +			.resist_table = samsung_temp2res,
> > > +			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
> > > +			/* If you have tables for more temperatures, add them */
> > > +			.ocv_temp[0] = 25,
> > > +			.ocv_table[0] = samsung_ocv_cap_1500mah,
> > > +			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_1500mah),
> > > +			.vbat2ri_discharging = samsung_vbat2res_discharging_eb425161lu,
> > > +			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_eb425161lu),
> > > +			.vbat2ri_charging = samsung_vbat2res_charging_eb425161lu,
> > > +			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_eb425161lu),
> > > +			.bti_resistance_ohm = 2400,
> > > +			.bti_resistance_tolerance = 40,
> > > +		},
> > > +	},
> > > +	{
> > > +		/*
> > > +		 * Used in Samsung GT-S7710 "Skomer"
> > > +		 * Data from vendor boardfile board-skomer-[bm|battery].c
> > > +		 */
> > > +		.compatible = "samsung,eb485159lu",
> > > +		.name = "EB485159LU",
> > > +		.info = {
> > > +			.charge_full_design_uah = 1700000,
> > > +			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> > > +			.factory_internal_resistance_uohm = 100000,
> > > +			.factory_internal_resistance_charging_uohm = 200000,
> > > +			.voltage_min_design_uv = 3320000,
> > > +			.voltage_max_design_uv = 4350000,
> > > +			.overvoltage_limit_uv = 4500000,
> > > +			.constant_charge_current_max_ua = 900000,
> > > +			.constant_charge_voltage_max_uv = 4340000,
> > > +			.charge_term_current_ua = 200000,
> > > +			.charge_restart_voltage_uv = 4300000,
> > > +			.maintenance_charge = samsung_maint_charge_table,
> > > +			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
> > > +			.alert_low_temp_charge_current_ua = 300000,
> > > +			.alert_low_temp_charge_voltage_uv = 4000000,
> > > +			.alert_high_temp_charge_current_ua = 300000,
> > > +			.alert_high_temp_charge_voltage_uv = 4000000,
> > > +			.temp_min = -50,
> > > +			.temp_alert_min = 0,
> > > +			.temp_alert_max = 40,
> > > +			.temp_max = 60,
> > > +			.resist_table = samsung_temp2res,
> > > +			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
> > > +			/* If you have tables for more temperatures, add them */
> > > +			.ocv_temp[0] = 25,
> > > +			.ocv_table[0] = samsung_ocv_cap_eb485159lu,
> > > +			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_eb485159lu),
> > > +			/* CHECKME: vendor uses the 1500 mAh table, check against datasheet */
> > > +			.vbat2ri_discharging = samsung_vbat2res_discharging_eb485159lu,
> > > +			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_eb485159lu),
> > > +			.vbat2ri_charging = samsung_vbat2res_charging_eb485159lu,
> > > +			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_eb485159lu),
> > > +			.bti_resistance_ohm = 2400,
> > > +			.bti_resistance_tolerance = 40,
> > > +		},
> > > +	},
> > > +	{
> > > +		/*
> > > +		 * Used in Samsung GT-I9070 "Janice"
> > > +		 * Data from vendor boardfile board-janice-bm.c
> > > +		 */
> > > +		.compatible = "samsung,eb535151vu",
> > > +		.name = "EB535151VU",
> > > +		.info = {
> > > +			.charge_full_design_uah = 1500000,
> > > +			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> > > +			.factory_internal_resistance_uohm = 100000,
> > > +			.factory_internal_resistance_charging_uohm = 200000,
> > > +			/* If you have data on this fix the min_design_uv */
> > > +			.voltage_min_design_uv = 3300000,
> > > +			.voltage_max_design_uv = 4180000,
> > > +			.overvoltage_limit_uv = 4500000,
> > > +			.constant_charge_current_max_ua = 900000,
> > > +			.constant_charge_voltage_max_uv = 4200000,
> > > +			.charge_term_current_ua = 200000,
> > > +			.maintenance_charge = samsung_maint_charge_table,
> > > +			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
> > > +			.alert_low_temp_charge_current_ua = 300000,
> > > +			.alert_low_temp_charge_voltage_uv = 4000000,
> > > +			.alert_high_temp_charge_current_ua = 300000,
> > > +			.alert_high_temp_charge_voltage_uv = 4000000,
> > > +			.temp_min = -5,
> > > +			.temp_alert_min = 0,
> > > +			.temp_alert_max = 40,
> > > +			.temp_max = 60,
> > > +			.resist_table = samsung_temp2res,
> > > +			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
> > > +			/* If you have tables for more temperatures, add them */
> > > +			.ocv_temp[0] = 25,
> > > +			.ocv_table[0] = samsung_ocv_cap_eb585157lu,
> > > +			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_eb535151vu),
> > > +			.vbat2ri_discharging = samsung_vbat2res_discharging_eb535151vu,
> > > +			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_eb535151vu),
> > > +			.vbat2ri_charging = samsung_vbat2res_charging_eb535151vu,
> > > +			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_eb535151vu),
> > > +			.bti_resistance_ohm = 1500,
> > > +			.bti_resistance_tolerance = 40,
> > > +		},
> > > +	},
> > > +	{
> > > +		/*
> > > +		 * Used in Samsung GT-I8530 "Gavini"
> > > +		 * Data from vendor boardfile board-gavini-bm.c
> > > +		 */
> > > +		.compatible = "samsung,eb585157lu",
> > > +		.name = "EB585157LU",
> > > +		.info = {
> > > +			.charge_full_design_uah = 2000000,
> > > +			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
> > > +			.factory_internal_resistance_uohm = 105000,
> > > +			.factory_internal_resistance_charging_uohm = 160000,
> > > +			/* If you have data on this fix the min_design_uv */
> > > +			.voltage_min_design_uv = 3300000,
> > > +			.voltage_max_design_uv = 4320000,
> > > +			.overvoltage_limit_uv = 4500000,
> > > +			.constant_charge_current_max_ua = 1500000,
> > > +			.constant_charge_voltage_max_uv = 4350000,
> > > +			.charge_term_current_ua = 120000,
> > > +			.maintenance_charge = samsung_maint_charge_table,
> > > +			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
> > > +			.alert_low_temp_charge_current_ua = 300000,
> > > +			.alert_low_temp_charge_voltage_uv = 4000000,
> > > +			.alert_high_temp_charge_current_ua = 300000,
> > > +			.alert_high_temp_charge_voltage_uv = 4000000,
> > > +			.temp_min = -5,
> > > +			.temp_alert_min = 0,
> > > +			.temp_alert_max = 40,
> > > +			.temp_max = 60,
> > > +			.resist_table = samsung_temp2res,
> > > +			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
> > > +			/* If you have tables for more temperatures, add them */
> > > +			.ocv_temp[0] = 25,
> > > +			.ocv_table[0] = samsung_ocv_cap_eb585157lu,
> > > +			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_eb585157lu),
> > > +			.vbat2ri_discharging = samsung_vbat2res_discharging_eb585157lu,
> > > +			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_eb585157lu),
> > > +			.vbat2ri_charging = samsung_vbat2res_charging_eb585157lu,
> > > +			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_eb585157lu),
> > > +			.bti_resistance_ohm = 2400,
> > > +			.bti_resistance_tolerance = 40,
> > > +		},
> > > +	},
> > > +};
> > > +
> > > +int samsung_sdi_battery_get_info(struct device *dev,
> > > +				 struct device_node *np,
> > > +				 struct power_supply_battery_info **info)
> > > +{
> > > +	struct samsung_sdi_battery *batt;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(samsung_sdi_batteries); i++) {
> > > +		batt = &samsung_sdi_batteries[i];
> > > +		if (of_device_is_compatible(np, batt->compatible))
> > > +			break;
> > > +	}
> > > +
> > > +	if (i == ARRAY_SIZE(samsung_sdi_batteries))
> > > +		return -ENODEV;
> > > +
> > > +	*info = &batt->info;
> > > +	dev_info(dev, "Samsung SDI %s battery %d mAh\n",
> > > +		 batt->name, batt->info.charge_full_design_uah / 1000);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(samsung_sdi_battery_get_info);
> > > diff --git a/drivers/power/supply/samsung-sdi-battery.h b/drivers/power/supply/samsung-sdi-battery.h
> > > new file mode 100644
> > > index 000000000000..08783847dfcb
> > > --- /dev/null
> > > +++ b/drivers/power/supply/samsung-sdi-battery.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#if IS_ENABLED(CONFIG_BATTERY_SAMSUNG_SDI)
> > > +extern int samsung_sdi_battery_get_info(struct device *dev,
> > > +				struct device_node *np,
> > > +				struct power_supply_battery_info **info);
> > > +#else
> > > +static inline int samsung_sdi_battery_get_info(struct device *dev,
> > > +				struct device_node *np,
> > > +				struct power_supply_battery_info **info)
> > > +{
> > > +	return -ENODEV;
> > > +}
> > > +#endif
> > > -- 
> > > 2.34.1
> > > 


