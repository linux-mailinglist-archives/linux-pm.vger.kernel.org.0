Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84A2DFDA8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 16:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLUPn6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 10:43:58 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:55604 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgLUPn6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 10:43:58 -0500
Received: by mail-wm1-f52.google.com with SMTP id x22so10255726wmc.5;
        Mon, 21 Dec 2020 07:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBXm2ENZyMbUD/+MQkl1th7hjWBElaB2QBhgzFuNMgk=;
        b=pvUIYUflpCpo4w0XbAUkdVv5GcbXNhFxmhUHGm3HGJ8gV0VklfPOSl7O6ZjtIBxVOP
         tiVW3maPf6bPvn5xvBjgHjNlw0GhEMZ/fXIQigkrIQ8nrvGQHxBqSeXF360+W4q6tvIn
         j5eg/UpeAh+tkjTIlygBIHcSMKGnp7DqVHXuhkLsIR6TDZf+6BvU2QWRQEVykPTTKS4f
         VJff0FNvpuC/vFXFuyq3Xrs/Oy9ERsXHBix/nEGDHrgmkbIqgA3+SskPQ5mVPTY2X/vI
         w2zPT5vnlH5pvCo0tMhMhfNpXYewm//TJgTuo/dvojEdZdVquWHI8PeSfyJTa01wfqGz
         nR/A==
X-Gm-Message-State: AOAM531gMTXX2H86YZcc0pA43XNG1VsZwDunJAGRuAk7/0OJ32OMv7tF
        J3aZuedHC84r/PexZSHirog=
X-Google-Smtp-Source: ABdhPJzNKXswqKaexwUhV0ogVLvDGB0INsUBzTOsZEnTRDA4tEoNmgFKAq6a4KamldZzTxW0jAU7vg==
X-Received: by 2002:a05:600c:313:: with SMTP id q19mr17067442wmd.126.1608565394608;
        Mon, 21 Dec 2020 07:43:14 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v4sm24840766wrw.42.2020.12.21.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:43:13 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:43:11 +0100
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
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/6] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201221154311.GA43240@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201221095001.595366-1-timon.baetz@protonmail.com>
 <20201221095001.595366-2-timon.baetz@protonmail.com>
 <20201221141627.GB33797@kozik-lap>
 <20201221163455.2c3f095d.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221163455.2c3f095d.timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 03:35:07PM +0000, Timon Baetz wrote:
> On Mon, 21 Dec 2020 15:16:27 +0100, Krzysztof Kozlowski wrote:
> > On Mon, Dec 21, 2020 at 09:53:15AM +0000, Timon Baetz wrote:
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
> > >  drivers/mfd/max8997.c                  |  4 +-
> > >  drivers/power/supply/max8997_charger.c | 94 ++++++++++++++++++++++++++
> > >  2 files changed, 96 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
> > > index 68d8f2b95287..55d3a6f97783 100644
> > > --- a/drivers/mfd/max8997.c
> > > +++ b/drivers/mfd/max8997.c
> > > @@ -29,9 +29,9 @@
> > >  static const struct mfd_cell max8997_devs[] = {
> > >  	{ .name = "max8997-pmic", },
> > >  	{ .name = "max8997-rtc", },
> > > -	{ .name = "max8997-battery", },
> > > +	{ .name = "max8997-battery", .of_compatible = "maxim,max8997-battery", },
> > >  	{ .name = "max8997-haptic", },
> > > -	{ .name = "max8997-muic", },
> > > +	{ .name = "max8997-muic", .of_compatible = "maxim,max8997-muic", },  
> > 
> > Undocumented bindings. The checkpatch should complain about it, so I
> > assume you did not run it. Please run the checkpatch.
> > 
> > >  	{ .name = "max8997-led", .id = 1 },
> > >  	{ .name = "max8997-led", .id = 2 },
> > >  };
> > > diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> > > index 1947af25879a..6e8750e455ea 100644
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
> > > +	int current_limit, ret;
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
> > > +		ret = regulator_set_current_limit(charger->reg, current_limit, current_limit);
> > > +		if (ret) {
> > > +			dev_err(charger->dev, "failed to set current limit: %d\n", ret);
> > > +			goto regulator_disable;  
> > 
> > Unusual error path... if regulator was not enabled before and
> > regulator_set_current_limit() failed, you disable the regulator? Why?
> > Wasn't it already disabled?
> 
> Because I thought you asked me to in v1 of this patch:
> > Failure of setting the current should rather disable the charging.
> 
> I probably misunderstood you comment then. So I guess it should just
> return?

Yes, I was not specific enough. In v1 you enabled the charging even in
case of regulator_set_current_limit() error. Instead, the charging
should not be enabled, so just return here with error.

Best regards,
Krzysztof

