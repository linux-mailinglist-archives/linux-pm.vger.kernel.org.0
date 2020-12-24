Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3A2E2767
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 14:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgLXNhw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 08:37:52 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51747 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgLXNhw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 08:37:52 -0500
Received: by mail-wm1-f50.google.com with SMTP id v14so1567052wml.1;
        Thu, 24 Dec 2020 05:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FCE5WE21N5MZx3cVhTL+26jN5aENt/JDk271U/g6f+w=;
        b=cYWWm6i4seXYIcdxvhlUIY/JfmJRIhrn8s9f8QWpBNk3HJk5dFRo9xIlW9+ZgTdDlZ
         kaqLGki7vlWGzFCt3hRA7iH3mbysw/tniVvD9kg+I5ztI+NJuZFl5+HXnb7aOj6CfVYW
         xJvSXTf5qmUuxC+J9VLabRbqmIAKGrSyMWjHzxK/f7wGArsMtlbJr5DSDaBzo15FIciu
         el4KeH/UAC3VNcQPljqO9ad0cEdL3On6c72NuavRj5avEN0Q2A4YpTFWMG3aJwCG77iK
         xW8u9APznhiiXZqa836QnlO8GTDHWhAtzuvuYHNudNxRcNMylnQs4mdICa7JFDHhOGhu
         Ddig==
X-Gm-Message-State: AOAM5302MzB79vjoYR+WKAurzkFdSfQoacXhdKBbz7R1ugy/WoXypVqT
        +Xg5B24wuWlz7MmtzTShogQ=
X-Google-Smtp-Source: ABdhPJwueUe+hMI4kHB/bhXr8nqNFFk+k83Yh3Z2ch2XfuWe+gJ0G1dhb1li0U6QTLVEFHB22UOm7w==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr4490273wml.78.1608817029074;
        Thu, 24 Dec 2020 05:37:09 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n11sm22189460wra.9.2020.12.24.05.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 05:37:07 -0800 (PST)
Date:   Thu, 24 Dec 2020 14:37:06 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 4/7] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201224133706.GA22856@kozik-lap>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
 <20201223134221.804943-4-timon.baetz@protonmail.com>
 <20201224095559.GB10937@kozik-lap>
 <20201224141246.7ad0ffc4.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201224141246.7ad0ffc4.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 24, 2020 at 01:13:02PM +0000, Timon Baetz wrote:
> On Thu, 24 Dec 2020 10:55:59 +0100, Krzysztof Kozlowski wrote:
> > On Wed, Dec 23, 2020 at 01:43:05PM +0000, Timon Baetz wrote:
> > > Register for extcon notification and set charging current depending on
> > > the detected cable type. Current values are taken from vendor kernel,
> > > where most charger types end up setting 650mA [0].
> > >
> > > Also enable and disable the CHARGER regulator based on extcon events.
> > >
> > > [0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic-4g-touch-sph-d710-exynos4210-dump/drivers/misc/max8997-muic.c#L1675-L1678
> > >
> > > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > > ---
> > >  drivers/power/supply/max8997_charger.c | 89 ++++++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > >
> > > diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> > > index 1947af25879a..e8532e2af451 100644
> > > --- a/drivers/power/supply/max8997_charger.c
> > > +++ b/drivers/power/supply/max8997_charger.c
> > > @@ -6,12 +6,14 @@
> > >  //  MyungJoo Ham <myungjoo.ham@samsung.com>
> > >
> > >  #include <linux/err.h>
> > > +#include <linux/extcon.h>
> > >  #include <linux/module.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/power_supply.h>
> > >  #include <linux/mfd/max8997.h>
> > >  #include <linux/mfd/max8997-private.h>
> > > +#include <linux/regulator/consumer.h>
> > >
> > >  /* MAX8997_REG_STATUS4 */
> > >  #define DCINOK_SHIFT		1
> > > @@ -31,6 +33,10 @@ struct charger_data {
> > >  	struct device *dev;
> > >  	struct max8997_dev *iodev;
> > >  	struct power_supply *battery;
> > > +	struct regulator *reg;
> > > +	struct extcon_dev *edev;
> > > +	struct notifier_block extcon_nb;
> > > +	struct work_struct extcon_work;
> > >  };
> > >
> > >  static enum power_supply_property max8997_battery_props[] = {
> > > @@ -88,6 +94,67 @@ static int max8997_battery_get_property(struct power_supply *psy,
> > >  	return 0;
> > >  }
> > >
> > > +static void max8997_battery_extcon_evt_stop_work(void *data)
> > > +{
> > > +	struct charger_data *charger = data;
> > > +
> > > +	cancel_work_sync(&charger->extcon_work);
> > > +}
> > > +
> > > +static void max8997_battery_extcon_evt_worker(struct work_struct *work)
> > > +{
> > > +	struct charger_data *charger =
> > > +	    container_of(work, struct charger_data, extcon_work);
> > > +	struct extcon_dev *edev = charger->edev;
> > > +	int current_limit;
> > > +
> > > +	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
> > > +		dev_dbg(charger->dev, "USB SDP charger is connected\n");
> > > +		current_limit = 450000;
> > > +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
> > > +		dev_dbg(charger->dev, "USB DCP charger is connected\n");
> > > +		current_limit = 650000;
> > > +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
> > > +		dev_dbg(charger->dev, "USB FAST charger is connected\n");
> > > +		current_limit = 650000;
> > > +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
> > > +		dev_dbg(charger->dev, "USB SLOW charger is connected\n");
> > > +		current_limit = 650000;
> > > +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
> > > +		dev_dbg(charger->dev, "USB CDP charger is connected\n");
> > > +		current_limit = 650000;
> > > +	} else {
> > > +		dev_dbg(charger->dev, "USB charger is diconnected\n");
> > > +		current_limit = -1;
> > > +	}
> > > +
> > > +	if (current_limit > 0) {
> > > +		int ret = regulator_set_current_limit(charger->reg, current_limit, current_limit);
> > > +
> > > +		if (ret) {
> > > +			dev_err(charger->dev, "failed to set current limit: %d\n", ret);
> > > +			return;
> > > +		}
> > > +		ret = regulator_enable(charger->reg);
> > > +		if (ret)
> > > +			dev_err(charger->dev, "failed to enable regulator: %d\n", ret);
> > > +	} else {
> > > +		int ret  = regulator_disable(charger->reg);
> > > +
> > > +		if (ret)
> > > +			dev_err(charger->dev, "failed to disable regulator: %d\n", ret);
> > > +	}
> > > +}
> > > +
> > > +static int max8997_battery_extcon_evt(struct notifier_block *nb,
> > > +				unsigned long event, void *param)
> > > +{
> > > +	struct charger_data *charger =
> > > +		container_of(nb, struct charger_data, extcon_nb);
> > > +	schedule_work(&charger->extcon_work);
> > > +	return NOTIFY_OK;
> > > +}
> > > +
> > >  static const struct power_supply_desc max8997_battery_desc = {
> > >  	.name		= "max8997_pmic",
> > >  	.type		= POWER_SUPPLY_TYPE_BATTERY,
> > > @@ -170,6 +237,28 @@ static int max8997_battery_probe(struct platform_device *pdev)
> > >  		return PTR_ERR(charger->battery);
> > >  	}
> > >
> > > +	charger->reg = devm_regulator_get(&pdev->dev, "charger");  
> > 
> > Since you do not use get_optional, you will always get a dummy
> > regulator. In case of error, you should either print it or entirely fail
> > the probe. Silently continuing makes it difficult to spot errors.
> > 
> > Since the driver could operate in case of extcon/regulator error, just
> > dev_err() so failure will be spotted with dmesg.
> 
> I will switch to devm_regulator_get_optional() and print an error on 
> failure, thanks.
> 
> > It will complain on older DTBs because you are introducing incompatible
> > change, but that's expected. Just correct all other in-tree DTS.
> 
> The other 2 in-tree DTS don't have CHARGER regulators. Not sure
> how to correct those. Should I add muic and charger nodes without a
> charger-supply? It will still complain in that case.

+Cc Marek,

This is why leaving the code as is - devm_regulator_get(), not optional
- makes sense. Core would provide dummy regulator, so you only have to
provide MUIC node.

If you change the code to devm_regulator_get_optional(), you need to add
everything: the charger regulator, the charger node and MUIC node.

For Trats, the configuration should be similar as i9100, although I
don't know the exact values of chargign voltage.

For Origen, there is no battery, so the power supply should not bind.
Maybe this could be achieved with "status disabled" for charger node? It
depends whether MFD will respect such field... If it disables the
charger, you're done.
The max8997 regulator driver is weird... AFAIU, it registers only
regulators present in DT. That's not how regulator driver should work.
Maybe you could confirm it? If it's true, then the value of charger
depends on bootloader settings and max8997 default values.

Best regards,
Krzysztof
