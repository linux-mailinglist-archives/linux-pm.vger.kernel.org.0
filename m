Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA372CC92B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 22:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLBVvm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 16:51:42 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44145 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgLBVvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 16:51:42 -0500
Received: by mail-ej1-f65.google.com with SMTP id m19so289938ejj.11;
        Wed, 02 Dec 2020 13:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tUAab35rF6lnneOH96CQNbNoct6bAobczRr2vD0hIU0=;
        b=NY/gy1KpfzGKryXwfG9+KOgJZYoCjjP6yv2FpSszjg6yWcnGVa2JPfUZkvQbRQtzOP
         PsP776r274sR2cwnAZ5sZKKMq8nbrhMZjY98ZkofivnzBzTSFGNOTx6nuEADvG+7TbhZ
         8SiyVdtSSEHQP/ta9vdzeqPqz9w0Kt3dIV/HzSZ/tzrxRo51LbiCTatTE2dglKRMSVwA
         jxH0n1ia83JOBndNf1K8ujpzpr9u7OCMlvCfDPYL300ifC8RObG4stjwUG9EAzZRNS3F
         9elpWv58PMtfxZ82+eOuIPJYbhhvtyx5OqF+lQV5ZXArl46dOz1bpttuGoHarENkR+sC
         Sh2A==
X-Gm-Message-State: AOAM532EuCdf8eo8WZz2VrNJaY4pv92T2Zn62s5WDTjsU7wEoXtFIIqi
        UCo3KvsxDs9WsSw0eod5mcQ=
X-Google-Smtp-Source: ABdhPJxFJdNekGxJGIwPUEqa1Ok5VRdnDf1X4lIvst0vcnSvkiomAogFk8Sojcuq0Hngndpn+8Gx2A==
X-Received: by 2002:a17:906:451:: with SMTP id e17mr1699790eja.228.1606945859840;
        Wed, 02 Dec 2020 13:50:59 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i2sm9199edk.93.2020.12.02.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 13:50:58 -0800 (PST)
Date:   Wed, 2 Dec 2020 23:50:57 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/3] power: supply: max8997_charger: Set CHARGER current
 limit
Message-ID: <20201202215057.GA135888@kozik-lap>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201202203516.43053-2-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202203516.43053-2-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 02, 2020 at 09:07:19PM +0000, Timon Baetz wrote:
> Register for extcon notification and set charging current depending on
> the detected cable type. Current values are taken from i9100 kernel
> fork.
> 
> Enable and disable the CHARGER regulator based on extcon events and
> remove regulator-always-on from the device tree.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  arch/arm/boot/dts/exynos4210-i9100.dts |  1 -
>  drivers/power/supply/max8997_charger.c | 92 ++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
> index 6d0c04d77a39..9f8d927e0d21 100644
> --- a/arch/arm/boot/dts/exynos4210-i9100.dts
> +++ b/arch/arm/boot/dts/exynos4210-i9100.dts
> @@ -560,7 +560,6 @@ charger_reg: CHARGER {
>  				regulator-name = "CHARGER";
>  				regulator-min-microamp = <60000>;
>  				regulator-max-microamp = <2580000>;
> -				regulator-always-on;

Thanks for the patch.

The DTS changes always go separately.

>  			};
>  
>  			chargercv_reg: CHARGER_CV {
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> index 1947af25879a..26cd271576ec 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -6,6 +6,7 @@
>  //  MyungJoo Ham <myungjoo.ham@samsung.com>
>  
>  #include <linux/err.h>
> +#include <linux/extcon.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> @@ -31,6 +32,12 @@ struct charger_data {
>  	struct device *dev;
>  	struct max8997_dev *iodev;
>  	struct power_supply *battery;
> +	struct regulator *reg;

You need to include regulator consumer.h.

> +	struct {

It makes all dereferences longer. Just add a comment that these are
related to the extcon.

> +		struct extcon_dev *edev;
> +		struct notifier_block nb;
> +		struct work_struct work;
> +	} extcon;
>  };
>  
>  static enum power_supply_property max8997_battery_props[] = {
> @@ -88,6 +95,63 @@ static int max8997_battery_get_property(struct power_supply *psy,
>  	return 0;
>  }
>  
> +static void max8997_battery_extcon_evt_stop_work(void *data)
> +{
> +	struct charger_data *charger = data;
> +
> +	cancel_work_sync(&charger->extcon.work);
> +}
> +
> +static void max8997_battery_extcon_evt_worker(struct work_struct *work)
> +{
> +	struct charger_data *charger =
> +	    container_of(work, struct charger_data, extcon.work);
> +	int ret, current_limit;
> +	struct extcon_dev *edev = charger->extcon.edev;
> +

It would be useful to report the current with POWER_SUPPLY_PROP_* but
it is a different patch.

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

The charger provides 500 mA, so I wonder whether 650 here is correct. Is
it at different voltage?

> +	} else if (extcon_get_state(edev, EXTCON_CHG_USB_CDP) > 0) {
> +		dev_dbg(charger->dev, "USB CDP charger is connected\n");
> +		current_limit = 650000;
> +	} else {
> +		dev_dbg(charger->dev, "USB charger is diconnected\n");
> +		current_limit = -1;
> +	}
> +
> +	if (current_limit > 0) {

ret should be declared here.

> +		ret = regulator_set_current_limit(charger->reg, current_limit, current_limit);
> +		if (ret)
> +			dev_err(charger->dev, "failed to set current limit: %d\n", ret);

Failure of setting the current should rather disable the charging.

> +		ret = regulator_enable(charger->reg);
> +		if (ret)
> +			dev_err(charger->dev, "failed to enable regulator: %d\n", ret);
> +	} else {

ret should be declared here.

> +		ret = regulator_disable(charger->reg);
> +		if (ret)
> +			dev_err(charger->dev, "failed to disable regulator: %d\n", ret);
> +	}

What about top-off charging?

> +}
> +
> +static int max8997_battery_extcon_evt(struct notifier_block *nb,
> +				unsigned long event, void *param)
> +{
> +	struct charger_data *charger =
> +		container_of(nb, struct charger_data, extcon.nb);
> +	schedule_work(&charger->extcon.work);
> +	return NOTIFY_OK;
> +}
> +
>  static const struct power_supply_desc max8997_battery_desc = {
>  	.name		= "max8997_pmic",
>  	.type		= POWER_SUPPLY_TYPE_BATTERY,
> @@ -104,6 +168,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  	struct i2c_client *i2c = iodev->i2c;
>  	struct max8997_platform_data *pdata = iodev->pdata;
>  	struct power_supply_config psy_cfg = {};
> +	struct extcon_dev *edev;
>  
>  	if (!pdata) {
>  		dev_err(&pdev->dev, "No platform data supplied.\n");
> @@ -151,6 +216,12 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	edev = extcon_get_extcon_dev("max8997-muic");

Store it directly under charger->edev.

> +	if (edev == NULL) {

if (!edev) {

> +		dev_info(&pdev->dev, "extcon is not ready, probe deferred\n");

Do not print anything on deferrals.

> +		return -EPROBE_DEFER;
> +	}
> +
>  	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
>  	if (!charger)
>  		return -ENOMEM;
> @@ -170,6 +241,27 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		return PTR_ERR(charger->battery);
>  	}
>  
> +	charger->reg = regulator_get(&pdev->dev, "CHARGER");

Here and in extcon_get_extcon_dev() - you make all these devices tightly
coupled. It will work, but I am afraid it's easy to break later.

Instead you should have a device node in DTS to which the charger could
bind and where the driver will find regulator supply and extcon
phandles (with extcon_get_edev_by_phandle() for example).

> +	if (IS_ERR(charger->reg)) {
> +		dev_err(&pdev->dev, "couldn't get CHARGER regulator\n");
> +		return PTR_ERR(charger->reg);
> +	}
> +
> +	INIT_WORK(&charger->extcon.work, max8997_battery_extcon_evt_worker);
> +	ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add extcon evt stop action: %d\n", ret);

Missing regulator_put() here and in other places. Use devm-().

> +		return ret;
> +	}
> +	charger->extcon.edev = edev;
> +	charger->extcon.nb.notifier_call = max8997_battery_extcon_evt;
> +	ret = devm_extcon_register_notifier_all(&pdev->dev, charger->extcon.edev,
> +			&charger->extcon.nb);

Align the arguments with opening '('.

Best regards,
Krzysztof
