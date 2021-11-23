Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96E245A506
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 15:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbhKWORZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 09:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236704AbhKWORY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 09:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637676856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QtwLj19jx/7I3ECN6je0qkmvum8Oj7tldDxVoAetQE=;
        b=P/5VukuFe2MA4+N4kCtqji+gHK9R3Lkn39ho0+n8fjo8l8mg1snlpsqqwr9CK22m2QjGen
        PNzyKhxZyAElkj9krLooP8gBiI0AzWUHFvlB1s1G/YcmGL8oQKg475AKh62t3QfWG7Lovu
        COxxvbzlJs4oD8Tn7Yd2EQJpMk/BbLY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-nTye_1q6OdaBHr1ImqJrHQ-1; Tue, 23 Nov 2021 09:14:15 -0500
X-MC-Unique: nTye_1q6OdaBHr1ImqJrHQ-1
Received: by mail-ed1-f69.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so18005664edx.9
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 06:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4QtwLj19jx/7I3ECN6je0qkmvum8Oj7tldDxVoAetQE=;
        b=sQKVJg0PC6V52XmKHNanPQnXXXCxHkYvQ13rIl8npXfkLJdt2LurzTNgxEnaap1sqb
         l/8leCtRY6+Hks9nfyYsiMwSR81tekPl7TssKYaNyhgb8zgdxudkIDLzfYPpImUW7PI0
         ftUYvgNZ+RVc56YzoHQs6iSqAF4dxKRQ5Yr9Rr0LjiZBde56lMwp/JACqX2hESw3Y4v2
         7/AfeysOWb0Fhl7qYXK1+mlMqyAtdby+qddHyGW9hwYIoL0TUTIlpP/5zX9QFP5PwlRL
         B1YtDfwrKtdd7YDOXYqe1MRTLZRd3mdDP8qJKDNY2DVfIYE5KLtxCsSeUlooyoOvX5qc
         oWOg==
X-Gm-Message-State: AOAM533F2lHQCtys0WotZtTW9uxYAPu7nw8cNCgTq8E9J7TH1LpnV2+Z
        HCXa9unoeR/3vT8lk5nzK+poQsWPkRYNn8g5Erx2EKwyHVKCG46c/Xu2d7y97l0rHEjdbkuwHQw
        mUQCPupCJWcz6he6dfmo=
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr9891208edd.257.1637676853561;
        Tue, 23 Nov 2021 06:14:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFqmB749eOSBMtNTLwkTJHhnSQg0ZwzXgPuUsqjARmGQgXQ3WmLj9YAle23weKdyVDSt+PIA==
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr9891138edd.257.1637676853195;
        Tue, 23 Nov 2021 06:14:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u16sm5269970ejy.16.2021.11.23.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:14:12 -0800 (PST)
Message-ID: <ebd20322-847d-2df7-5dc1-4ac5dc100c9b@redhat.com>
Date:   Tue, 23 Nov 2021 15:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] extcon: fix extcon_get_extcon_dev() error handling
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20211123083925.GA3277@kili>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211123083925.GA3277@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/23/21 09:43, Dan Carpenter wrote:
> The extcon_get_extcon_dev() function returns error pointers on error,
> NULL when it's a -EPROBE_DEFER defer situation, and ERR_PTR(-ENODEV)
> when the CONFIG_EXTCON option is disabled.  This is very complicated for
> the callers to handle and a number of them had bugs that would lead to
> an Oops.
> 
> In real life, there are two things which prevented crashes.  First,
> error pointers would only be returned if there was bug in the caller
> where they passed a NULL "extcon_name" and none of them do that.
> Second, only two out of the eight drivers will build when CONFIG_EXTCON
> is disabled.
> 
> The normal way to write this would be to return -EPROBE_DEFER directly
> when appropriate and return NULL when CONFIG_EXTCON is disabled.  Then
> the error handling is simple and just looks like:
> 
> 	dev->edev = extcon_get_extcon_dev(acpi_dev_name(adev));
> 	if (IS_ERR(dev->edev))
> 		return PTR_ERR(dev->edev);
> 
> For the two drivers which can build with CONFIG_EXTCON disabled, then
> extcon_get_extcon_dev() will now return NULL which is not treated as an
> error and the probe will continue successfully.  Those two drivers are
> "typec_fusb302" and "max8997-battery".  In the original code, the
> typec_fusb302 driver had an 800ms hang in tcpm_get_current_limit() but
> now that function is a no-op.  For the max8997-battery driver everything
> should continue working as is.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
> v2: return NULL when CONFIG_EXTCON is disabled
> 
> If we apply this patch, it might be a good idea to send it to -stable
> so that backported code that relies on handling error pointers does
> not break silently.
> 
>  drivers/extcon/extcon-axp288.c         |    4 ++--
>  drivers/extcon/extcon.c                |    2 +-
>  drivers/power/supply/axp288_charger.c  |   17 ++++++++++-------
>  drivers/power/supply/charger-manager.c |    7 ++-----
>  drivers/power/supply/max8997_charger.c |   10 +++++-----
>  drivers/usb/dwc3/drd.c                 |    9 ++-------
>  drivers/usb/phy/phy-omap-otg.c         |    4 ++--
>  drivers/usb/typec/tcpm/fusb302.c       |    4 ++--
>  include/linux/extcon.h                 |    2 +-
>  9 files changed, 27 insertions(+), 32 deletions(-)
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
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 0c19010da77f..685401d94d39 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -296,7 +296,7 @@ static inline void devm_extcon_unregister_notifier_all(struct device *dev,
>  
>  static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  {
> -	return ERR_PTR(-ENODEV);
> +	return NULL;
>  }
>  
>  static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
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
> index 72f9001b0792..96c55eaf3f80 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1708,8 +1708,8 @@ static int fusb302_probe(struct i2c_client *client,
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
> 

