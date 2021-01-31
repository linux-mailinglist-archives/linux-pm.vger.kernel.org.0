Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA97309ECB
	for <lists+linux-pm@lfdr.de>; Sun, 31 Jan 2021 21:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhAaUNq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 Jan 2021 15:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhAaTfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2021 14:35:44 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE01FC061788;
        Sun, 31 Jan 2021 09:28:45 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b9so1081763ejy.12;
        Sun, 31 Jan 2021 09:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gd1kwiYZVZqHxGZ4QrLOcLWC/Yc7tIB41MFJH1DjrOE=;
        b=QKzEiLQ6NzOtXTY2GxWnm1OdzuV/+KIMM/bxqzcl6AWarRDPmlWsg5XZL634VlvtFk
         dd0MlMtSNlXnR8BWUFra+7oftF4sCQ/GJOimxqAGa+q2pnfQwAlmIcedzH+B4CrOZ6rH
         IkbRaW7sGUAmRnPz5KD09KHhUTVl259sUtA1e9LxKU/Ax+rGivv+Mh0QTmLiVWfRiBT8
         LAiCLoe59/4adve4f9340PyPFbscXnQ2OmBY96w9kwsEGVxlmcibAvM84HoRut599jmL
         hHdOZZ0XN6ZS3f/hmzJQ484+qTzMtIXqYygLDvuI9S2ybTUgjWcuK0IvNhomx5kfpvpF
         HqaA==
X-Gm-Message-State: AOAM5324J7qqm+F/v8dRWbl+jWpZFR9WPNEVdoQ4zsf7SlWHRVCWdzLS
        1GEZc9L0j9gbzPgLAuW7m50=
X-Google-Smtp-Source: ABdhPJz+pSN0UgQq9d30A0QB6sxrw8CN2kA2ipY6zlnjIn+rBf6kLJaK1Mc4wolK/V1jCHU+t7Yg1w==
X-Received: by 2002:a17:906:f144:: with SMTP id gw4mr14257685ejb.189.1612114123011;
        Sun, 31 Jan 2021 09:28:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u23sm7486937edt.87.2021.01.31.09.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:28:41 -0800 (PST)
Date:   Sun, 31 Jan 2021 18:28:40 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: max8997_charger: Switch to new binding
Message-ID: <20210131172840.fxaadhhsafa4aeex@kozik-lap>
References: <20210130172747.2022977-1-timon.baetz@protonmail.com>
 <20210130172747.2022977-4-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210130172747.2022977-4-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jan 30, 2021 at 05:30:14PM +0000, Timon Baetz wrote:
> Get regulator from parent device's node and extcon by name.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  drivers/power/supply/max8997_charger.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> index 321bd6b8ee41..625d8cc4312a 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -168,6 +168,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  	int ret = 0;
>  	struct charger_data *charger;
>  	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *np = pdev->dev.of_node;
>  	struct i2c_client *i2c = iodev->i2c;
>  	struct max8997_platform_data *pdata = iodev->pdata;
>  	struct power_supply_config psy_cfg = {};
> @@ -237,20 +238,23 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		return PTR_ERR(charger->battery);
>  	}
>  
> +	// grab regulator from parent device's node
> +	pdev->dev.of_node = iodev->dev->of_node;
>  	charger->reg = devm_regulator_get_optional(&pdev->dev, "charger");
> +	pdev->dev.of_node = np;

I think the device does not have its own node anymore. Or did I miss
something?

>  	if (IS_ERR(charger->reg)) {
>  		if (PTR_ERR(charger->reg) == -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
>  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
>  	}
> -	charger->edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
> -	if (IS_ERR(charger->edev)) {
> -		if (PTR_ERR(charger->edev) == -EPROBE_DEFER)
> +	charger->edev = extcon_get_extcon_dev("max8997-muic");
> +	if (IS_ERR_OR_NULL(charger->edev)) {
> +		if (!charger->edev)

Isn't NULL returned when there is simply no extcon? It's different than
deferred probe. Returning here EPROBE_DEFER might lead to infinite probe
tries (on every new device probe) instead of just failing it.

Best regards,
Krzysztof


>  			return -EPROBE_DEFER;
>  		dev_info(charger->dev, "couldn't get extcon device\n");
>  	}
>  
> -	if (!IS_ERR(charger->reg) && !IS_ERR(charger->edev)) {
> +	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
>  		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
>  		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
>  		if (ret) {
> -- 
> 2.25.1
> 
> 
