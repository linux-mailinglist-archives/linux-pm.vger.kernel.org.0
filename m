Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F42E075C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 09:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLVIkt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 03:40:49 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45271 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLVIkt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 03:40:49 -0500
Received: by mail-wr1-f51.google.com with SMTP id d26so13651078wrb.12;
        Tue, 22 Dec 2020 00:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mc9YlhklgHyo+ZWWiXFF+G5IvrUtXxS5OoPxIUrgAi8=;
        b=i/yaw8YvaLzDey8ctzS7W2RHMfHwGuZCmUq4wlz1cplDf9xfY4yQPf3ZecnpUiZHHn
         Gn/uIeIPJ/RbIHzOaID3Ylp6BPcTaP0msc/DzuaXTcmSYDPUSDLYiFHbMKkwLj8VVOmv
         k4tlBGdrVbhwPSNoaRfcB3KTRSJSsCVODYmnONHio6K1sKRwPY0mkMsjvbSp+oKZ6ey4
         huwG9GCmqq4PWxLCcr+yU06cCWjcs6zD8itFNUpokmADcZHuMudG/ggoIUueq1VWGJQa
         XORFmcEcin4tad20kkcnWKIEXqLh2kxcsFPBRPLNTga5CHEb2VxPbD9mD4VbYOYxIb7K
         vEhw==
X-Gm-Message-State: AOAM532fOaEKUNkiOQ3ukmDz16LHzN/VHXLclw6zrpAT1z6viSO17xHU
        SoS7j5YlfOLLYx7P+vPsxW0=
X-Google-Smtp-Source: ABdhPJxlDP78lehfTDWIpBPpCIU0VDik+63U+FbSYlT6DrBR8XdQpBIIFnmsnOXGe61CfTe9azDZOw==
X-Received: by 2002:adf:f401:: with SMTP id g1mr22765242wro.258.1608626406804;
        Tue, 22 Dec 2020 00:40:06 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h13sm29700988wrm.28.2020.12.22.00.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 00:40:05 -0800 (PST)
Date:   Tue, 22 Dec 2020 09:40:04 +0100
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
Subject: Re: [PATCH v3 4/7] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201222084004.GD5026@kozik-lap>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
 <20201222070520.710096-4-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222070520.710096-4-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 22, 2020 at 07:31:40AM +0000, Timon Baetz wrote:
> Register for extcon notification and set charging current depending on
> the detected cable type. Current values are taken from vendor kernel,
> where most charger types end up setting 650mA [0].
> 
> Also enable and disable the CHARGER regulator based on extcon events.
> 
> [0] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-s2-epic-4g-touch-sph-d710-exynos4210-dump/drivers/misc/max8997-muic.c#L1675-L1678
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  drivers/power/supply/max8997_charger.c | 94 ++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> index 1947af25879a..673ffff14ae0 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -6,12 +6,14 @@
>  //  MyungJoo Ham <myungjoo.ham@samsung.com>
>  
>  #include <linux/err.h>
> +#include <linux/extcon.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
> +#include <linux/regulator/consumer.h>
>  
>  /* MAX8997_REG_STATUS4 */
>  #define DCINOK_SHIFT		1
> @@ -31,6 +33,10 @@ struct charger_data {
>  	struct device *dev;
>  	struct max8997_dev *iodev;
>  	struct power_supply *battery;
> +	struct regulator *reg;
> +	struct extcon_dev *edev;
> +	struct notifier_block extcon_nb;
> +	struct work_struct extcon_work;
>  };
>  
>  static enum power_supply_property max8997_battery_props[] = {
> @@ -88,6 +94,67 @@ static int max8997_battery_get_property(struct power_supply *psy,
>  	return 0;
>  }
>  
> +static void max8997_battery_extcon_evt_stop_work(void *data)
> +{
> +	struct charger_data *charger = data;
> +
> +	cancel_work_sync(&charger->extcon_work);
> +}
> +
> +static void max8997_battery_extcon_evt_worker(struct work_struct *work)
> +{
> +	struct charger_data *charger =
> +	    container_of(work, struct charger_data, extcon_work);
> +	struct extcon_dev *edev = charger->edev;
> +	int current_limit;
> +
> +	if (extcon_get_state(edev, EXTCON_CHG_USB_SDP) > 0) {
> +		dev_dbg(charger->dev, "USB SDP charger is connected\n");
> +		current_limit = 450000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_DCP) > 0) {
> +		dev_dbg(charger->dev, "USB DCP charger is connected\n");
> +		current_limit = 650000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_FAST) > 0) {
> +		dev_dbg(charger->dev, "USB FAST charger is connected\n");
> +		current_limit = 650000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_SLOW) > 0) {
> +		dev_dbg(charger->dev, "USB SLOW charger is connected\n");
> +		current_limit = 650000;
> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
> +		dev_dbg(charger->dev, "USB CDP charger is connected\n");
> +		current_limit = 650000;
> +	} else {
> +		dev_dbg(charger->dev, "USB charger is diconnected\n");
> +		current_limit = -1;
> +	}
> +
> +	if (current_limit > 0) {
> +		int ret = regulator_set_current_limit(charger->reg, current_limit, current_limit);
> +
> +		if (ret) {
> +			dev_err(charger->dev, "failed to set current limit: %d\n", ret);
> +			return;
> +		}
> +		ret = regulator_enable(charger->reg);
> +		if (ret)
> +			dev_err(charger->dev, "failed to enable regulator: %d\n", ret);
> +	} else {
> +		int ret  = regulator_disable(charger->reg);
> +
> +		if (ret)
> +			dev_err(charger->dev, "failed to disable regulator: %d\n", ret);
> +	}
> +}
> +
> +static int max8997_battery_extcon_evt(struct notifier_block *nb,
> +				unsigned long event, void *param)
> +{
> +	struct charger_data *charger =
> +		container_of(nb, struct charger_data, extcon_nb);
> +	schedule_work(&charger->extcon_work);
> +	return NOTIFY_OK;
> +}
> +
>  static const struct power_supply_desc max8997_battery_desc = {
>  	.name		= "max8997_pmic",
>  	.type		= POWER_SUPPLY_TYPE_BATTERY,
> @@ -170,6 +237,33 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		return PTR_ERR(charger->battery);
>  	}
>  
> +	charger->reg = devm_regulator_get(&pdev->dev, "charger");

The code looks good but isn't it breaking all existing platforms?

Best regards,
Krzysztof


> +	if (IS_ERR(charger->reg)) {
> +		dev_err(&pdev->dev, "couldn't get charger regulator\n");
> +		return PTR_ERR(charger->reg);
> +	}
> +
