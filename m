Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33520455B79
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbhKRM0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 07:26:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344657AbhKRM0Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 07:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637238194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8z10nVUuLThSGaC7z17W3SUgE6/tXKgk2oSZG6Kearc=;
        b=QpYEeXU0BSOoOXyWZ9gcjRDdaJDhUvtTc0HOiXQe8pJNvg1FjFqu9yJvSeHRK5sF8RO9yB
        HHkAkVyCDcsTEX1/UURxkrK7WsNIKm2FF/jYqyih5xWYJA4ZyCZyW/IstUzxMmShx7F4Q9
        95J9OhdQ845Zs7GMbvgDsWnWhR8hUWQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-EQj5JI8NP4KvCkeRBu3XUA-1; Thu, 18 Nov 2021 07:23:13 -0500
X-MC-Unique: EQj5JI8NP4KvCkeRBu3XUA-1
Received: by mail-ed1-f70.google.com with SMTP id p4-20020aa7d304000000b003e7ef120a37so5093323edq.16
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 04:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8z10nVUuLThSGaC7z17W3SUgE6/tXKgk2oSZG6Kearc=;
        b=54sV1FgPR5TNjmTaRq4R/rz0W5ttg0QhI+45MWfpaVkNceb8qRf3iT0armwEnB1sGO
         +EL3aK5xw52ufhP8n8gpt/EN0nEtRF8cKwAbIVkguV66oGrgPlM8vJcqmvwpeFUOIxf7
         fYVDkq+J35AYp/fMgq85pdpGaPVm3H1ddbcQNd6VLooSc8HT4FqkL4rMTcWFdGIfyoY5
         7+u9FBPqn01L7/5vrVn5R4wFnE35Tk3c05/T1QWpJNwYcyHlV0NhMlA/2gGQNSmhTReh
         hStX4sZMVp4DWKckrFi86MPwNmAeyfjd1SAxtF9H/JG/88tBh0mPuokcJY69DizwaM2x
         unjQ==
X-Gm-Message-State: AOAM5330IUfO95cd6qZUL+MMu8uhDwpWcLF8pwWnOjqj/dMPmAfRymTU
        5x1I/1Fdk0FhbvuGLV3/RtsOAKpJlh6Qg7ogpR/VOBoJZ9WcmSSoGOWwEiMdE1VwyPwcnAwZBCw
        9nHnCbnVv4U9GsT34K+Y=
X-Received: by 2002:a17:906:79c3:: with SMTP id m3mr32043412ejo.332.1637238192442;
        Thu, 18 Nov 2021 04:23:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXkZowzHNR4Kff8uzrLdpzFSDx11xdWSgEZrkn+GcIjq2GwcSEmYZYHEyqXcc24iAApiYDNA==
X-Received: by 2002:a17:906:79c3:: with SMTP id m3mr32043355ejo.332.1637238192136;
        Thu, 18 Nov 2021 04:23:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l16sm665254edb.59.2021.11.18.04.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 04:23:11 -0800 (PST)
Message-ID: <3908d07c-f397-2af3-83f0-a190968130d9@redhat.com>
Date:   Thu, 18 Nov 2021 13:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] extcon: fix extcon_get_extcon_dev() error handling
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20211118113026.GG1147@kili>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211118113026.GG1147@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/18/21 12:32, Dan Carpenter wrote:
> The extcon_get_extcon_dev() function returns error pointers on error
> and NULL when it's a -EPROBE_DEFER defer situation.  There are eight
> callers and only two of them handled this correctly.  In the other
> callers an error pointer return would lead to a crash.
> 
> What prevents crashes is that errors can only happen in the case of
> a bug in the caller or if CONFIG_EXTCON is disabled.  Six out of
> eight callers use the Kconfig to either depend on or select
> CONFIG_EXTCON.  Thus the real life impact of these bugs is tiny.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> The two callers where the drivers can be built without CONFIG_EXTCON
> are TYPEC_FUSB302 and CHARGER_MAX8997.
> 
> If we apply this patch, it might be a good idea to send it to -stable
> so that backported code that relies on handling error pointers does
> not break silently.
> 
>  drivers/extcon/extcon.c                |  2 +-
>  drivers/power/supply/axp288_charger.c  | 17 ++++++++++-------
>  drivers/power/supply/charger-manager.c |  7 ++-----
>  drivers/power/supply/max8997_charger.c | 10 +++++-----
>  drivers/usb/dwc3/drd.c                 |  9 ++-------
>  drivers/usb/phy/phy-omap-otg.c         |  4 ++--
>  drivers/usb/typec/tcpm/fusb302.c       |  4 ++--
>  drivers/extcon/extcon-axp288.c         |  4 ++--
>  8 files changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e7a9561a826d..a35e99928807 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -876,7 +876,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  		if (!strcmp(sd->name, extcon_name))
>  			goto out;
>  	}
> -	sd = NULL;
> +	sd = ERR_PTR(-EPROBE_DEFER);
>  out:
>  	mutex_unlock(&extcon_dev_list_lock);
>  	return sd;
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index ec41f6cd3f93..4acfeb52a44e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -848,17 +848,20 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	info->regmap_irqc = axp20x->regmap_irqc;
>  
>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
> -	if (info->cable.edev == NULL) {
> -		dev_dbg(dev, "%s is not ready, probe deferred\n",
> -			AXP288_EXTCON_DEV_NAME);
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(info->cable.edev)) {
> +		dev_err_probe(dev, PTR_ERR(info->cable.edev),
> +			      "extcon_get_extcon_dev(%s) failed\n",
> +			      AXP288_EXTCON_DEV_NAME);
> +		return PTR_ERR(info->cable.edev);
>  	}
>  
>  	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
>  		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> -		if (info->otg.cable == NULL) {
> -			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(info->otg.cable)) {
> +			dev_err_probe(dev, PTR_ERR(info->otg.cable),
> +				      "extcon_get_extcon_dev(%s) failed\n",
> +				      USB_HOST_EXTCON_NAME);
> +			return PTR_ERR(info->otg.cable);
>  		}
>  		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>  	}
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
> index d67edb760c94..92db79400a6a 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -985,13 +985,10 @@ static int charger_extcon_init(struct charger_manager *cm,
>  	cable->nb.notifier_call = charger_extcon_notifier;
>  
>  	cable->extcon_dev = extcon_get_extcon_dev(cable->extcon_name);
> -	if (IS_ERR_OR_NULL(cable->extcon_dev)) {
> +	if (IS_ERR(cable->extcon_dev)) {
>  		pr_err("Cannot find extcon_dev for %s (cable: %s)\n",
>  			cable->extcon_name, cable->name);
> -		if (cable->extcon_dev == NULL)
> -			return -EPROBE_DEFER;
> -		else
> -			return PTR_ERR(cable->extcon_dev);
> +		return PTR_ERR(cable->extcon_dev);
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(extcon_mapping); i++) {
> diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
> index 25207fe2aa68..634658adf313 100644
> --- a/drivers/power/supply/max8997_charger.c
> +++ b/drivers/power/supply/max8997_charger.c
> @@ -248,13 +248,13 @@ static int max8997_battery_probe(struct platform_device *pdev)
>  		dev_info(&pdev->dev, "couldn't get charger regulator\n");
>  	}
>  	charger->edev = extcon_get_extcon_dev("max8997-muic");
> -	if (IS_ERR_OR_NULL(charger->edev)) {
> -		if (!charger->edev)
> -			return -EPROBE_DEFER;
> -		dev_info(charger->dev, "couldn't get extcon device\n");
> +	if (IS_ERR(charger->edev)) {
> +		dev_err_probe(charger->dev, PTR_ERR(charger->edev),
> +			      "couldn't get extcon device: max8997-muic\n");
> +		return PTR_ERR(charger->edev);
>  	}
>  
> -	if (!IS_ERR(charger->reg) && !IS_ERR_OR_NULL(charger->edev)) {
> +	if (!IS_ERR(charger->reg)) {
>  		INIT_WORK(&charger->extcon_work, max8997_battery_extcon_evt_worker);
>  		ret = devm_add_action(&pdev->dev, max8997_battery_extcon_evt_stop_work, charger);
>  		if (ret) {
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index d7f76835137f..a490f79131c1 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -454,13 +454,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>  	 * This device property is for kernel internal use only and
>  	 * is expected to be set by the glue code.
>  	 */
> -	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> -		edev = extcon_get_extcon_dev(name);
> -		if (!edev)
> -			return ERR_PTR(-EPROBE_DEFER);
> -
> -		return edev;
> -	}
> +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
> +		return extcon_get_extcon_dev(name);
>  
>  	/*
>  	 * Try to get an extcon device from the USB PHY controller's "port"
> diff --git a/drivers/usb/phy/phy-omap-otg.c b/drivers/usb/phy/phy-omap-otg.c
> index ee0863c6553e..6e6ef8c0bc7e 100644
> --- a/drivers/usb/phy/phy-omap-otg.c
> +++ b/drivers/usb/phy/phy-omap-otg.c
> @@ -95,8 +95,8 @@ static int omap_otg_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	extcon = extcon_get_extcon_dev(config->extcon);
> -	if (!extcon)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(extcon))
> +		return PTR_ERR(extcon);
>  
>  	otg_dev = devm_kzalloc(&pdev->dev, sizeof(*otg_dev), GFP_KERNEL);
>  	if (!otg_dev)
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 7a2a17866a82..8594b59bd527 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1706,8 +1706,8 @@ static int fusb302_probe(struct i2c_client *client,
>  	 */
>  	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
>  		chip->extcon = extcon_get_extcon_dev(name);
> -		if (!chip->extcon)
> -			return -EPROBE_DEFER;
> +		if (IS_ERR(chip->extcon))
> +			return PTR_ERR(chip->extcon);
>  	}
>  
>  	chip->vbus = devm_regulator_get(chip->dev, "vbus");
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index 7c6d5857ff25..180be768c215 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -394,8 +394,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>  		if (adev) {
>  			info->id_extcon = extcon_get_extcon_dev(acpi_dev_name(adev));
>  			put_device(&adev->dev);
> -			if (!info->id_extcon)
> -				return -EPROBE_DEFER;
> +			if (IS_ERR(info->id_extcon))
> +				return PTR_ERR(info->id_extcon);
>  
>  			dev_info(dev, "controlling USB role\n");
>  		} else {
> 

