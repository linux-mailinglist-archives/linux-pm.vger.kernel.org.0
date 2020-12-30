Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7042E773F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Dec 2020 09:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL3IyN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Dec 2020 03:54:13 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:40799 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3IyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2020 03:54:12 -0500
Received: by mail-ed1-f44.google.com with SMTP id h16so14770393edt.7;
        Wed, 30 Dec 2020 00:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+wQy2o26jMtvHnmORIqXJqx6UqjuXqke4h03tDcQHA=;
        b=KW6YFOhChQBQVZTM+pPO/zIRNrz844kNFFEN+6ksogcP4ZUbpCf6tuF1WOB6mrehOn
         NdT8ltwS+/NOhEDZjbUTo8hUE6VGj2+t3fOCfKXLZ+M/6P5vgv30IeiCtal+M1zlWu/1
         l+fccLfCEWd+Hn0x5PIuHJG0VYU1gKfvuW75ITWAn072JUqYAMRfDMKKa8FyAfIsrQ6a
         O19yk6hSXw/cNB923CmJvw24iuo1ke+wJ7M0eFN1Txux0xnFUr42p5ziMC4kWY3YtPBv
         6qjpZMvjhqap+TuRCXyJGvy3ZRdeUoJusmi5ad0fp2GVLFXdAKgdpzty2vTe32zHBVHW
         c7tA==
X-Gm-Message-State: AOAM530M6z1WfroRIzi128oIgRjxYWkNE0h01BunNEkJ6Bn5yLzzXRMv
        BmXq1jffV0+m/3ZYKmQg8CY=
X-Google-Smtp-Source: ABdhPJwHxR8cKFIHZ2OHMoPngNV7/RHznHyY6wIsr3Ae8CaOiQ9eJR7pRDBejM27r5rJT6pUUzVMfw==
X-Received: by 2002:aa7:c919:: with SMTP id b25mr48339596edt.108.1609318409771;
        Wed, 30 Dec 2020 00:53:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p12sm18766183ejc.116.2020.12.30.00.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 00:53:28 -0800 (PST)
Date:   Wed, 30 Dec 2020 09:53:27 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Subject: Re: [PATCH v5 3/8] power: supply: max8997_charger: Set CHARGER
 current limit
Message-ID: <20201230085327.GB9214@kozik-lap>
References: <20201228113507.1292506-1-timon.baetz@protonmail.com>
 <20201228113507.1292506-3-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201228113507.1292506-3-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 28, 2020 at 11:36:02AM +0000, Timon Baetz wrote:
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
>  drivers/power/supply/max8997_charger.c | 96 ++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> index 1947af25879a..f0f725385dfc 100644
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
> @@ -170,6 +237,35 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		return PTR_ERR(charger->battery);
>  	}
>  
> +	charger->reg = devm_regulator_get_optional(&pdev->dev, "charger");
> +	if (IS_ERR(charger->reg)) {
> +		if (PTR_ERR(charger->reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_err(&pdev->dev, "couldn't get charger regulator\n");

This should be dev_info, as we discussed. Otherwise it will scream on
every boot with a DTS which does not have charger node.

Best regards,
Krzysztof
