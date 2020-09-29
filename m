Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28C127D8E8
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgI2Ujo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgI2Uf6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 16:35:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F775C061755;
        Tue, 29 Sep 2020 13:35:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so4836890pgl.9;
        Tue, 29 Sep 2020 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7esz1zpt/WRpXyKl5QBUf62b8nnV+Gd47cnXXKzqgyU=;
        b=b4kMDljIAeqLuKRJnctW240uQGdoGfQAkLo3ph8CZgwpWg48QQnbi/R+5Z4VyMM1CS
         Ph5SAa+9fED864kN9iNXHJiyPNNqRZIkSw4YgzjGEhT0OKMG1ipbCXsPiriv/u05Nul5
         ejIck+eDbFmjyi4iLXiqwLBC6wCEjxBDw0pDZ2cmE/S65AmDYyUVjYzc9/V+CqTkZazj
         9piNsKFUAWBabBMEKlJrcAi2LQ0ExDLrKS5k3vzLOioIJjCjjHW5zwKOLZuqSGmeA9kO
         nh1dQYljG5WuUFkw5264yKnZK8ucI2n2hmUdIqBjh4gHzjNp8RxkApUpW5bQX8ZVc1z/
         vIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7esz1zpt/WRpXyKl5QBUf62b8nnV+Gd47cnXXKzqgyU=;
        b=iUAxBUHHxY7zKq6w6ADhHcvg4CcMTaHImjmJFEPMTImn33olc8Xou6jqc3D6UHZkcC
         vYPfESGXBYwNDoMcQ+Cv/rfLkr/J4MK+3x8wBxkphusvQomplFH5wyEGxCzUwxT0C1f2
         SvhOlhanO9mJJl/OBN/QGl7asCCeEl77PJVRZj1fBzZp/HTREoOzZ/BwxpKLZMcbS9Kf
         8O6BfT+P/nx/vidWinfdvcVBQDJXdBUh3z4iMObmh3KnlP0+AepqcKSMNAFGcK6sHF/S
         bB1haRQavWu/KaGEuBWB2fiKeB99WJuhifMjLOW0cyr7NhXzIvJOHMLjIRRCXFbrdHRL
         2xLw==
X-Gm-Message-State: AOAM530dehJQBmnrHNpJZ4yUyQYg31lw0KNyVcFit8S/40Wz8Emw4XYw
        tv46K2xkPC/qeiNgrBrKZVQ=
X-Google-Smtp-Source: ABdhPJyS3CEUv2UhlHUk/i0VyYBwQvljBMHHfzucFaHTqjc9SI+um/lHZzdn7uQ2Dsi5s3jJdDTMyw==
X-Received: by 2002:a17:902:ee02:b029:d1:8c50:aa73 with SMTP id z2-20020a170902ee02b02900d18c50aa73mr6692510plb.42.1601411757287;
        Tue, 29 Sep 2020 13:35:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id in10sm5418946pjb.11.2020.09.29.13.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:35:56 -0700 (PDT)
Date:   Tue, 29 Sep 2020 13:35:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/6] input: atc260x: Add onkey driver for ATC260x PMICs
Message-ID: <20200929203554.GA3313608@dtor-ws>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <aec6ea5cfc9bf820cb4bb4a92297d2eecf6d285d.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200914210941.GC1681290@dtor-ws>
 <20200918103503.GA27182@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918103503.GA27182@BV030612LT>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Cristian,

On Fri, Sep 18, 2020 at 01:35:03PM +0300, Cristian Ciocaltea wrote:
> Hi Dmitry,
> 
> Thanks for the review!
> 
> On Mon, Sep 14, 2020 at 02:09:41PM -0700, Dmitry Torokhov wrote:
> > Hi Cristian,
> > 
> > On Sat, Aug 22, 2020 at 01:19:51AM +0300, Cristian Ciocaltea wrote:
> > > The Actions Semi ATC260x PMICs are able to manage an onkey button.
> > > This driver exposes the ATC260x onkey as an input device. It can also
> > > be configured to force a system reset on a long key-press with an
> > > adjustable duration.
> > > 
> > > The currently supported chip variants are ATC2603C and ATC2609A.
> > > 
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > ---
> > >  drivers/input/misc/Kconfig         |  11 ++
> > >  drivers/input/misc/Makefile        |   2 +-
> > >  drivers/input/misc/atc260x-onkey.c | 304 +++++++++++++++++++++++++++++
> > >  3 files changed, 316 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/input/misc/atc260x-onkey.c
> > > 
> > > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > > index 362e8a01980c..9e297ebdea57 100644
> > > --- a/drivers/input/misc/Kconfig
> > > +++ b/drivers/input/misc/Kconfig
> > > @@ -83,6 +83,17 @@ config INPUT_ARIZONA_HAPTICS
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called arizona-haptics.
> > >  
> > > +config INPUT_ATC260X_ONKEY
> > > +	tristate "Actions Semi ATC260x PMIC ONKEY"
> > > +	depends on MFD_ATC260X
> > > +	help
> > > +	  Support the ONKEY of ATC260x PMICs as an input device reporting
> > > +	  power button status. ONKEY can be used to wakeup from low power
> > > +	  modes and force a reset on long press.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called atc260x-onkey.
> > > +
> > >  config INPUT_ATMEL_CAPTOUCH
> > >  	tristate "Atmel Capacitive Touch Button Driver"
> > >  	depends on OF || COMPILE_TEST
> > > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > > index a48e5f2d859d..7f854c6ecefa 100644
> > > --- a/drivers/input/misc/Makefile
> > > +++ b/drivers/input/misc/Makefile
> > > @@ -16,6 +16,7 @@ obj-$(CONFIG_INPUT_ADXL34X_I2C)		+= adxl34x-i2c.o
> > >  obj-$(CONFIG_INPUT_ADXL34X_SPI)		+= adxl34x-spi.o
> > >  obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
> > >  obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)	+= arizona-haptics.o
> > > +obj-$(CONFIG_INPUT_ATC260X_ONKEY)	+= atc260x-onkey.o
> > >  obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
> > >  obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
> > >  obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
> > > @@ -84,4 +85,3 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
> > >  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
> > >  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
> > >  obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
> > > -
> > > diff --git a/drivers/input/misc/atc260x-onkey.c b/drivers/input/misc/atc260x-onkey.c
> > > new file mode 100644
> > > index 000000000000..7caec7d6f9ac
> > > --- /dev/null
> > > +++ b/drivers/input/misc/atc260x-onkey.c
> > > @@ -0,0 +1,304 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Onkey driver for Actions Semi ATC260x PMICs.
> > > + *
> > > + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/input.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mfd/atc260x/core.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +/* <2s for short press, >2s for long press */
> > > +#define KEY_PRESS_TIME_SEC	2
> > > +
> > > +/* Driver internals */
> > > +enum atc260x_onkey_reset_status {
> > > +	KEY_RESET_HW_DEFAULT,
> > > +	KEY_RESET_DISABLED,
> > > +	KEY_RESET_USER_SEL,
> > > +};
> > > +
> > > +struct atc260x_onkey_params {
> > > +	u32 reg_int_ctl;
> > > +	u32 kdwn_state_bm;
> > > +	u32 long_int_pnd_bm;
> > > +	u32 short_int_pnd_bm;
> > > +	u32 kdwn_int_pnd_bm;
> > > +	u32 press_int_en_bm;
> > > +	u32 kdwn_int_en_bm;
> > > +	u32 press_time_bm;
> > > +	u32 reset_en_bm;
> > > +	u32 reset_time_bm;
> > > +};
> > > +
> > > +struct atc260x_onkey {
> > > +	struct atc260x *atc260x;
> > > +	const struct atc260x_onkey_params *params;
> > > +	struct input_dev *input_dev;
> > > +	struct delayed_work work;
> > > +};
> > > +
> > > +static const struct atc260x_onkey_params atc2603c_onkey_params = {
> > > +	.reg_int_ctl		= ATC2603C_PMU_SYS_CTL2,
> > > +	.long_int_pnd_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_LONG_PRESS,
> > > +	.short_int_pnd_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_SHORT_PRESS,
> > > +	.kdwn_int_pnd_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_PD,
> > > +	.press_int_en_bm	= ATC2603C_PMU_SYS_CTL2_ONOFF_INT_EN,
> > > +	.kdwn_int_en_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_INT_EN,
> > > +	.kdwn_state_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS,
> > > +	.press_time_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
> > > +	.reset_en_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_RESET_EN,
> > > +	.reset_time_bm		= ATC2603C_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
> > > +};
> > > +
> > > +static const struct atc260x_onkey_params atc2609a_onkey_params = {
> > > +	.reg_int_ctl		= ATC2609A_PMU_SYS_CTL2,
> > > +	.long_int_pnd_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_LONG_PRESS,
> > > +	.short_int_pnd_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_SHORT_PRESS,
> > > +	.kdwn_int_pnd_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_PD,
> > > +	.press_int_en_bm	= ATC2609A_PMU_SYS_CTL2_ONOFF_LSP_INT_EN,
> > > +	.kdwn_int_en_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_INT_EN,
> > > +	.kdwn_state_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS,
> > > +	.press_time_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
> > > +	.reset_en_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_EN,
> > > +	.reset_time_bm		= ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
> > > +};
> > > +
> > > +static int atc2603x_onkey_hw_init(struct atc260x_onkey *onkey,
> > > +				  enum atc260x_onkey_reset_status reset_status,
> > > +				  u32 reset_time, u32 press_time)
> > > +{
> > > +	u32 reg_bm, reg_val;
> > > +
> > > +	reg_bm = onkey->params->long_int_pnd_bm |
> > > +		 onkey->params->short_int_pnd_bm |
> > > +		 onkey->params->kdwn_int_pnd_bm |
> > > +		 onkey->params->press_int_en_bm |
> > > +		 onkey->params->kdwn_int_en_bm;
> > > +
> > > +	reg_val = reg_bm | press_time;
> > > +	reg_bm |= onkey->params->press_time_bm;
> > > +
> > > +	if (reset_status == KEY_RESET_DISABLED) {
> > > +		reg_bm |= onkey->params->reset_en_bm;
> > > +	} else if (reset_status == KEY_RESET_USER_SEL) {
> > > +		reg_bm |= onkey->params->reset_en_bm |
> > > +			  onkey->params->reset_time_bm;
> > > +		reg_val |= onkey->params->reset_en_bm | reset_time;
> > > +	}
> > > +
> > > +	return regmap_update_bits(onkey->atc260x->regmap,
> > > +				  onkey->params->reg_int_ctl, reg_bm, reg_val);
> > > +}
> > > +
> > > +static void atc260x_onkey_query(struct atc260x_onkey *onkey)
> > > +{
> > > +	u32 reg_bits;
> > > +	int ret, key_down;
> > > +
> > > +	ret = regmap_read(onkey->atc260x->regmap,
> > > +			  onkey->params->reg_int_ctl, &key_down);
> > > +	if (ret) {
> > > +		key_down = 1;
> > > +		dev_err(onkey->atc260x->dev,
> > > +			"Failed to read onkey status: %d\n", ret);
> > > +	} else {
> > > +		key_down &= onkey->params->kdwn_state_bm;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The hardware generates interrupt only when the onkey pin is
> > > +	 * asserted. Hence, the deassertion of the pin is simulated through
> > > +	 * work queue.
> > > +	 */
> > > +	if (key_down) {
> > > +		schedule_delayed_work(&onkey->work, msecs_to_jiffies(200));
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The key-down status bit is cleared when the On/Off button
> > > +	 * is released.
> > > +	 */
> > > +	input_report_key(onkey->input_dev, KEY_POWER, 0);
> > > +	input_sync(onkey->input_dev);
> > > +
> > > +	reg_bits = onkey->params->long_int_pnd_bm |
> > > +		   onkey->params->short_int_pnd_bm |
> > > +		   onkey->params->kdwn_int_pnd_bm |
> > > +		   onkey->params->press_int_en_bm |
> > > +		   onkey->params->kdwn_int_en_bm;
> > > +
> > > +	/* Clear key press pending events and enable key press interrupts. */
> > > +	regmap_update_bits(onkey->atc260x->regmap, onkey->params->reg_int_ctl,
> > > +			   reg_bits, reg_bits);
> > > +}
> > > +
> > > +static void atc260x_onkey_work(struct work_struct *work)
> > > +{
> > > +	struct atc260x_onkey *onkey = container_of(work, struct atc260x_onkey,
> > > +						   work.work);
> > > +	atc260x_onkey_query(onkey);
> > > +}
> > > +
> > > +static irqreturn_t atc260x_onkey_irq(int irq, void *data)
> > > +{
> > > +	struct atc260x_onkey *onkey = data;
> > > +	int ret;
> > > +
> > > +	/* Disable key press interrupts. */
> > > +	ret = regmap_update_bits(onkey->atc260x->regmap,
> > > +				 onkey->params->reg_int_ctl,
> > > +				 onkey->params->press_int_en_bm |
> > > +				 onkey->params->kdwn_int_en_bm, 0);
> > > +	if (ret)
> > > +		dev_err(onkey->atc260x->dev,
> > > +			"Failed to disable interrupts: %d\n", ret);
> > > +
> > > +	input_report_key(onkey->input_dev, KEY_POWER, 1);
> > > +	input_sync(onkey->input_dev);
> > > +
> > > +	atc260x_onkey_query(onkey);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int atc260x_onkey_probe(struct platform_device *pdev)
> > > +{
> > > +	struct atc260x *atc260x = dev_get_drvdata(pdev->dev.parent);
> > > +	struct atc260x_onkey *onkey;
> > > +	struct input_dev *input_dev;
> > > +	enum atc260x_onkey_reset_status reset_status;
> > > +	u32 press_time = KEY_PRESS_TIME_SEC, reset_time = 0;
> > > +	int val, irq, ret;
> > > +
> > > +	if (!pdev->dev.of_node)
> > > +		return -ENXIO;
> > 
> > Why is this needed?
> 
> The idea was to allow the user enable/disable the ONKEY functionality
> of the MFD device via the 'onkey' DTS node. So if this node is not
> present, the driver will not be loaded.
> 
> Is there a better/recommended way to handle this scenario?

I believe the best way is not to create correspnding platform device if
functionality is disabled. So the logic shoudl go into MFD piece.

> 
> > > +
> > > +	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> > > +	if (!onkey)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = device_property_read_u32(&pdev->dev,
> > > +				       "actions,reset-time-sec", &val);
> > 
> > Call this "error" please.
> 
> Would something like bellow suffice?
> 
> 	if (ret) {
> 		dev_err(&pdev->dev, "Failed to read actions,reset-time-sec\n");
> 		return ret;
> 	}


I meant

	error = device_property_read_u32(&pdev->dev,
					 "actions,reset-time-sec", &val);
	if (error) {
		reset_status = KEY_RESET_HW_DEFAULT;
	}


> 
> > > +	if (ret) {
> > > +		reset_status = KEY_RESET_HW_DEFAULT;
> > > +	} else if (val) {
> > > +		if (val < 6 || val > 12) {
> > > +			dev_err(&pdev->dev, "actions,reset-time-sec out of range\n");
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		reset_status = KEY_RESET_USER_SEL;
> > > +		reset_time = (val - 6) / 2;
> > > +	} else {
> > > +		reset_status = KEY_RESET_DISABLED;
> > > +		dev_info(&pdev->dev, "Disabled reset on long-press\n");

dev_dbg();

> > > +	}
> > > +
> > > +	switch (atc260x->ic_type) {
> > > +	case ATC2603C:
> > > +		onkey->params = &atc2603c_onkey_params;
> > > +		press_time = FIELD_PREP(ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
> > > +					press_time);
> > > +		reset_time = FIELD_PREP(ATC2603C_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
> > > +					reset_time);
> > > +		break;
> > > +	case ATC2609A:
> > > +		onkey->params = &atc2609a_onkey_params;
> > > +		press_time = FIELD_PREP(ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_TIME,
> > > +					press_time);
> > > +		reset_time = FIELD_PREP(ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL,
> > > +					reset_time);
> > > +		break;
> > > +	default:
> > > +		dev_err(&pdev->dev,
> > > +			"OnKey not supported for ATC260x PMIC type: %u\n",
> > > +			atc260x->ic_type);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	input_dev = devm_input_allocate_device(&pdev->dev);
> > > +	if (!input_dev) {
> > > +		dev_err(&pdev->dev, "Failed to allocate input device\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	onkey->input_dev = input_dev;
> > > +	onkey->atc260x = atc260x;
> > > +
> > > +	input_dev->name = "atc260x-onkey";
> > > +	input_dev->phys = "atc260x-onkey/input0";
> > > +	input_dev->evbit[0] = BIT_MASK(EV_KEY);
> > 
> > Not needed.
> 
> Done.
> 
> > > +	input_set_capability(input_dev, EV_KEY, KEY_POWER);
> > > +
> > > +	INIT_DELAYED_WORK(&onkey->work, atc260x_onkey_work);
> > > +
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq < 0)
> > > +		return irq;
> > > +
> > > +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > > +					atc260x_onkey_irq,
> > > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > 
> > Do we need to force the trigger type? Can we rely on the parent to
> > configure it as needed?
> 
> Done, I removed the trigger type enforcement.
> 
> > > +					dev_name(&pdev->dev), onkey);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev,
> > > +			"Failed to register IRQ %d: %d\n", irq, ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = input_register_device(input_dev);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev,
> > > +			"Failed to register input device: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = atc2603x_onkey_hw_init(onkey, reset_status,
> > > +				     reset_time, press_time);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	platform_set_drvdata(pdev, onkey);
> > > +	device_init_wakeup(&pdev->dev, true);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int atc260x_onkey_remove(struct platform_device *pdev)
> > > +{
> > > +	struct atc260x_onkey *onkey = platform_get_drvdata(pdev);
> > > +
> > > +	cancel_delayed_work_sync(&onkey->work);
> > 
> > This is racy. Past this point the interrupts are not disabled, so if key
> > happens to be pressed you will re-schedule the work and it will go BOOM.
> > 
> > You are using threaded interrupt. Maybe consider sleeping and
> > re-checking the key status right there.
> 
> I've seen this approach in a few drivers: da9055_onkey.c,
> palmas-pwrbutton.c, wm831x-on.c
> 
> I noticed they also call 'free_irq()' right before
> 'cancel_delayed_work_sync()'. Would this help mitigate the racing issue?

Yes, but this messes up with devm releasing resources.

Another option is to implement open/close and call enable_irq() in open
and disable_irq/cancel_work_sync in close.

Thanks.

-- 
Dmitry
