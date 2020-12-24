Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892FD2E25CD
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgLXJ4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 04:56:45 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52227 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgLXJ4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 04:56:45 -0500
Received: by mail-wm1-f48.google.com with SMTP id a6so1141066wmc.2;
        Thu, 24 Dec 2020 01:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQ47tmkeP0DrGeHawifdFzRAR5VdAIvwAYy3NMH+MDY=;
        b=YhZGMjZiarLh6DubI1QVVGJx2xTjmVIwUVKiJ58WI9GOEzHz24hMLsPdB/eIfc3SgK
         /TmQ/4CeXSrulcAjpqJpWIW70XCQpgRX859OGGoMq/0Cxqef24282huhw79e5fA6SuKV
         AMwdphRBOezMbWonPKkhtB1RVDyD4qoJTqCTbdlFdAM2GATELqAWfFS64nRaEoUNu3aj
         VIpgVzPCuiuVqW0eJf3LIW7bEunmhYJmH5E0RnLp7x5zrxGus4m7ov4191ZqKo415SL3
         k/3x8Vyv51FzTrmKKkWbtIiaqA6jh/pCFxzSNOUWaaWqKYv2+AiBEIoAZUsHY4g5b3No
         x8Gg==
X-Gm-Message-State: AOAM531qp6NX2tRCS96MZrRE45kIY3cSOkZ+Kfhlfoe1WaJlQQhE2sxh
        0BOPHIMPn/D+Jkxkmhbtbfw=
X-Google-Smtp-Source: ABdhPJxmf6qw/SurLPa7171mcvsx/MR/mZ+Arr9m4C0y3Ps2Ov2COD95YRQIZEk7GrnB2r+2GuGxWg==
X-Received: by 2002:a1c:a5d8:: with SMTP id o207mr3727438wme.30.1608803761556;
        Thu, 24 Dec 2020 01:56:01 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x18sm44965801wrg.55.2020.12.24.01.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 01:56:00 -0800 (PST)
Date:   Thu, 24 Dec 2020 10:55:59 +0100
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
Subject: Re: [PATCH v4 4/7] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201224095559.GB10937@kozik-lap>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
 <20201223134221.804943-4-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223134221.804943-4-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 23, 2020 at 01:43:05PM +0000, Timon Baetz wrote:
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
>  drivers/power/supply/max8997_charger.c | 89 ++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> index 1947af25879a..e8532e2af451 100644
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
> @@ -170,6 +237,28 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		return PTR_ERR(charger->battery);
>  	}
>  
> +	charger->reg = devm_regulator_get(&pdev->dev, "charger");

Since you do not use get_optional, you will always get a dummy
regulator. In case of error, you should either print it or entirely fail
the probe. Silently continuing makes it difficult to spot errors.

Since the driver could operate in case of extcon/regulator error, just
dev_err() so failure will be spotted with dmesg.

It will complain on older DTBs because you are introducing incompatible
change, but that's expected. Just correct all other in-tree DTS.

Best regards,
Krzysztof


> +	charger->edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
> +	if (PTR_ERR(charger->reg) == -EPROBE_DEFER ||
> +	    PTR_ERR(charger->edev) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (!IS_ERR(charger->reg) && !IS_ERR(charger->edev)) {
> +		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
> +		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", ret);
> +			return ret;
> +		}
> +		charger->extcon_nb.notifier_call = max8997_battery_extcon_evt;
> +		ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
> +							&charger->extcon_nb);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to register extcon notifier\n");
> +			return ret;
> +		};
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 
> 
