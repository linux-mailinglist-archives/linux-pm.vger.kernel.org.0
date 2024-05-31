Return-Path: <linux-pm+bounces-8439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471C8D5788
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 03:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C72F288961
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C377483;
	Fri, 31 May 2024 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZ2imBoO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134BD29E
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117514; cv=none; b=HKNLS5wPabMsQ0gRvFs62uDBz4J8JG0pIsF0x6SCC9uh1xflJEkLUWeB3v+o/gxckWoSMrn78g2d1LxFsrX2JRn8xroezJDv/UshL0AfasChsieaUx+eZ1rFzUPz3KeaccoRKLbPBH6QJPDffN7sqX33qZqW+T8pFC4J74ypqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117514; c=relaxed/simple;
	bh=uXfDEOjLv+ehvyI9BLqFEZ08MZc+Pu/2A0MFNLqubJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgQEVvCWcaAOriDIMBOt6K1ZP6SKqfCyE4pEjT9dPaP4/HyCnFwXfl4VMDidKIwNlnpHHu/4C0nG1ErU82qyTlKAPCUyQYGHpSUdX+HAwX6rZh79GhnwUnx7ArFP6EIwXG71Vb1aJ8IEnZhDFsp94CtF47yO5ZxzFDTlEbOmGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZ2imBoO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b86cfcbcaso593377e87.1
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717117510; x=1717722310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVbzQgiFaGguV//d78RBj3pAHXG3P0yCT4npYfngP5s=;
        b=PZ2imBoOD/Gla9oPGISBS5VRkqhq4CUqBmcLJRO2cnQe+5z/wQ7vLCAr6t+0LFL9GI
         JZviynR6AAOPVyaqj9w7lN4wf+ydNABI/O3xrrMGDrOcjpWUJXpj0gHVMqpJ0cuM3d2e
         r9MOwBMb5aNcMx9vfb32/ldlfY0Tqr4p89tmWHXJqTe1rtaCuHecSWKLz/CK+lIf8uni
         3/VcSepRvfxq0lMeH/O4+A8Xf4XZDVYdLlytmnnmVV3oR4Js986SJKnHvScJSdb5nHQU
         1lK7D6kjEId1n5NiojZar5VxtGWC35D2tcPmWAG31+dAryUD1fEtG1UBcgjFon0Sbf/m
         43wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717117510; x=1717722310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVbzQgiFaGguV//d78RBj3pAHXG3P0yCT4npYfngP5s=;
        b=p3zwvFBSn3nFFfIcCwX0f/g2akKUWU/8NCHbvYMPsTSZ/F0IVlSYE/m+Zo99vw92x7
         QrpGC2mYTJ11qEhfP57t+hooG9DfaqEcMhC8lfVfUh9MoqTChxyfe2nRh82tF1D2/5ge
         BVvAar0qRarAiJt9NWs0ZBULITH5eu78TZxdkzEud/FZhsK6t/A2RLKRMnLRECBMdWUm
         9jeFyAyELwBk8cUQ7fQRTeCBRECU0lXWBFcfktiEk474D0hy7EuuDoTk9J6ood+fuRvp
         gbJHq7EeWN+sc0ia+jYQSKEOCEI2wQQFi3bALUyMxVHNnMK/eEPIoRdtkcE2kKvj+vW4
         yrHw==
X-Forwarded-Encrypted: i=1; AJvYcCXiE1iKn67K9DnvYpwbQePiZ6718bEBRT4tH0073nJPpKQX3S7UOT1BCWBlWgmMe6cHFDnh6IO6sPJ8jSFS11vL5zCIhoSYFWU=
X-Gm-Message-State: AOJu0YwHJmX/+AcTMNa4vSIgQTSMyW7hmIPMMRc5hAoLxPNAg7ttrnbK
	BnbsF6cSF6VAbQ2nu5d5TGAXeagihmZhfbUS2qpIo1dokUU4Cgx7qAcb6uo6UXc=
X-Google-Smtp-Source: AGHT+IHomuQLV/a1+46r2/bjrhxItgrwS1B7Si5a5leUogKwVcxPn4v1vNxtZhU6lKWRVAcVsxarfw==
X-Received: by 2002:ac2:5548:0:b0:52b:88e8:1c82 with SMTP id 2adb3069b0e04-52b895a385fmr190738e87.47.1717117510049;
        Thu, 30 May 2024 18:05:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d75fd6sm142407e87.157.2024.05.30.18.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 18:05:09 -0700 (PDT)
Date: Fri, 31 May 2024 04:05:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v4 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
Message-ID: <ndrp6ghnoibfm3t7qk7zuwfcukixh6uzqykj7vitobtiqntin6@ud242mjaivfl>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org>
 <20240528-yoga-ec-driver-v4-4-4fa8dfaae7b6@linaro.org>
 <6d957019-ccec-4129-9e6d-33204de88dd5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d957019-ccec-4129-9e6d-33204de88dd5@linaro.org>

On Wed, May 29, 2024 at 04:51:54PM +0100, Bryan O'Donoghue wrote:
> On 28/05/2024 21:44, Dmitry Baryshkov wrote:
> > On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> > and battery status. Add the driver to read power supply status on the
> > laptop.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/power/supply/Kconfig                    |   9 +
> >   drivers/power/supply/Makefile                   |   1 +
> >   drivers/power/supply/lenovo_yoga_c630_battery.c | 479 ++++++++++++++++++++++++
> >   3 files changed, 489 insertions(+)
> > 
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 3e31375491d5..55ab8e90747d 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
> >   	help
> >   	  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
> > +config BATTERY_LENOVO_YOGA_C630
> > +	tristate "Lenovo Yoga C630 battery"
> > +	depends on OF && EC_LENOVO_YOGA_C630
> > +	help
> > +	  This driver enables battery support on the Lenovo Yoga C630 laptop.
> > +
> > +	  To compile the driver as a module, choose M here: the module will be
> > +	  called lenovo_yoga_c630_battery.
> > +
> >   config BATTERY_PMU
> >   	tristate "Apple PMU battery"
> >   	depends on PPC32 && ADB_PMU
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > index 58b567278034..8ebbdcf92dac 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -32,6 +32,7 @@ obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
> >   obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
> >   obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
> >   obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
> > +obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) += lenovo_yoga_c630_battery.o
> >   obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
> >   obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
> >   obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
> > diff --git a/drivers/power/supply/lenovo_yoga_c630_battery.c b/drivers/power/supply/lenovo_yoga_c630_battery.c
> > new file mode 100644
> > index 000000000000..76152ad38d46
> > --- /dev/null
> > +++ b/drivers/power/supply/lenovo_yoga_c630_battery.c
> > @@ -0,0 +1,479 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2022-2024, Linaro Ltd
> > + * Authors:
> > + *    Bjorn Andersson
> > + *    Dmitry Baryshkov
> > + */
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_data/lenovo-yoga-c630.h>
> > +#include <linux/power_supply.h>
> > +
> > +struct yoga_c630_psy {
> > +	struct yoga_c630_ec *ec;
> > +	struct device *dev;
> > +	struct device_node *of_node;
> > +	struct notifier_block nb;
> > +	struct mutex lock;
> 
> Do locks still not require a
> 
> struct mutex lock; /* this mutex locks this thing */

Not required, but let me add the doc.

> 
> > +
> > +	struct power_supply *adp_psy;
> > +	struct power_supply *bat_psy;
> > +
> > +	unsigned long last_status_update;
> > +
> > +	bool adapter_online;
> > +
> > +	bool unit_mA;
> > +
> > +	bool bat_present;
> > +	unsigned int bat_status;
> > +	unsigned int design_capacity;
> > +	unsigned int design_voltage;
> > +	unsigned int full_charge_capacity;
> > +
> > +	unsigned int capacity_now;
> > +	unsigned int voltage_now;
> > +
> > +	int current_now;
> > +	int rate_now;
> > +};
> > +
> > +#define LENOVO_EC_CACHE_TIME		(10 * HZ)
> > +
> > +#define LENOVO_EC_ADPT_STATUS		0xa3
> > +#define LENOVO_EC_ADPT_PRESENT		BIT(7)
> > +#define LENOVO_EC_BAT_ATTRIBUTES	0xc0
> > +#define LENOVO_EC_BAT_ATTR_UNIT_IS_MA	BIT(1)
> > +#define LENOVO_EC_BAT_STATUS		0xc1
> > +#define LENOVO_EC_BAT_REMAIN_CAPACITY	0xc2
> > +#define LENOVO_EC_BAT_VOLTAGE		0xc6
> > +#define LENOVO_EC_BAT_DESIGN_VOLTAGE	0xc8
> > +#define LENOVO_EC_BAT_DESIGN_CAPACITY	0xca
> > +#define LENOVO_EC_BAT_FULL_CAPACITY	0xcc
> > +#define LENOVO_EC_BAT_CURRENT		0xd2
> > +#define LENOVO_EC_BAT_FULL_FACTORY	0xd6
> > +#define LENOVO_EC_BAT_PRESENT		0xda
> > +#define LENOVO_EC_BAT_FULL_REGISTER	0xdb
> > +#define LENOVO_EC_BAT_FULL_IS_FACTORY	BIT(0)
> > +
> > +/* the mutex should already be locked */
> > +static int yoga_c630_psy_update_bat_info(struct yoga_c630_psy *ecbat)
> > +{
> > +	struct yoga_c630_ec *ec = ecbat->ec;
> > +	int val;
> > +
> > +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_PRESENT);
> > +	if (val < 0)
> > +		return val;
> > +	ecbat->bat_present = !!(val & BIT(0));
> > +	if (!ecbat->bat_present)
> > +		return val;
> > +
> > +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
> > +	if (val < 0)
> > +		return val;
> > +	ecbat->unit_mA = val & LENOVO_EC_BAT_ATTR_UNIT_IS_MA;
> > +
> > +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_CAPACITY);
> > +	if (val < 0)
> > +		return val;
> > +	ecbat->design_capacity = val * 1000;
> > +
> > +	msleep(50);
> 
> What's this for ? Also do you really want to hold a mutex for 50
> milliseconds ?

DSDT has these delays after each read, so I can only assume it is required.
Sleeping outside of the mutex() would mean that a concurrent thread
might break into this delay and query the EC.

[skipped]


> > +static int yoga_c630_psy_probe(struct auxiliary_device *adev,
> > +				   const struct auxiliary_device_id *id)
> > +{
> > +	struct yoga_c630_ec *ec = adev->dev.platform_data;
> > +	struct power_supply_config adp_cfg = {};
> > +	struct device *dev = &adev->dev;
> > +	struct yoga_c630_psy *ecbat;
> > +	int ret;
> > +
> > +	ecbat = devm_kzalloc(&adev->dev, sizeof(*ecbat), GFP_KERNEL);
> > +	if (!ecbat)
> > +		return -ENOMEM;
> > +
> > +	ecbat->ec = ec;
> > +	ecbat->dev = dev;
> > +	mutex_init(&ecbat->lock);
> > +	ecbat->of_node = adev->dev.parent->of_node;
> > +	ecbat->nb.notifier_call = yoga_c630_psy_notify;
> > +
> > +	auxiliary_set_drvdata(adev, ecbat);
> > +
> > +	adp_cfg.drv_data = ecbat;
> > +	adp_cfg.of_node = ecbat->of_node;
> > +	adp_cfg.supplied_to = (char **)&yoga_c630_psy_bat_psy_desc_mA.name;
> > +	adp_cfg.num_supplicants = 1;
> > +	ecbat->adp_psy = devm_power_supply_register_no_ws(dev, &yoga_c630_psy_adpt_psy_desc, &adp_cfg);
> > +	if (IS_ERR(ecbat->adp_psy)) {
> > +		dev_err(dev, "failed to register AC adapter supply\n");
> > +		return PTR_ERR(ecbat->adp_psy);
> > +	}
> > +
> > +	mutex_lock(&ecbat->lock);
> 
> Do you really need this lock here in your probe() function ? What's the
> parallel path of execution you are mitigating against here ?

Notifications from the battery driver can already happen at this point.
Also once the fist power supply is registered, userspace can potentially
access it, triggering EC access and updates of the PSY registration.

> 
> > +
> > +	ret = yoga_c630_psy_update_bat_info(ecbat);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> > +	ret = yoga_c630_psy_register_bat_psy(ecbat);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> > +	mutex_unlock(&ecbat->lock);
> > +


-- 
With best wishes
Dmitry

