Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0991E5376
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 03:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgE1B4U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 21:56:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42501 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1B4U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 21:56:20 -0400
Received: by mail-io1-f68.google.com with SMTP id d5so18796261ios.9;
        Wed, 27 May 2020 18:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vfVnDrSq58NuSUbJV6oCnXeF8igJvtjoYDR7txMoucI=;
        b=VcwpsdGUWCz0rmZ+d1lj9WfZ3sS7d8TymolJGbG8h/nthXmYXLnVkeZLItIwdStv4g
         4IxfkqEjuX2Zd8z/XyzS+0kirz3qtfiSVMSexpikMhyCo6tij8vFdXoxuIo2YnKlcZ8m
         9A3f4+sHKEpv2MTETtE0q3B4NpuR+xIyJBHrsFTFIPNbeXgZyRMGHJUW2UGLWm1+iNSa
         Xm8CVdxaw0W86XgcJWA+1/5nWl65mt+fatZuPJIiDQvDqjYT5JyPWxsd1I/m1QzgTdJ4
         aPG72i0xfz0oNrCulhyyQGWf6xgqzgQtj/rxmv+Ku8vWxBu2qhFBZcVihkR/9TX+JsFk
         gvSw==
X-Gm-Message-State: AOAM531wux+aZYaB1qCMZ+dvsaFV0VvQV0uTfuVubdbT9f1o5OKYHp7L
        4JtxIpAeSRQzTi3N9e8EFg==
X-Google-Smtp-Source: ABdhPJxaHxQAWPnSJbLYGHQUKYtfFRSIbQacusShN81P1loJnHfWOcq+ktlnRrmd7BFrGngwxu5qTg==
X-Received: by 2002:a05:6638:a50:: with SMTP id 16mr443081jap.71.1590630977260;
        Wed, 27 May 2020 18:56:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r68sm2438424ilb.37.2020.05.27.18.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:56:16 -0700 (PDT)
Received: (nullmailer pid 3201004 invoked by uid 1000);
        Thu, 28 May 2020 01:56:15 -0000
Date:   Wed, 27 May 2020 19:56:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 1/2] power: supply: gpio-charger: add
 charge-current-limit feature
Message-ID: <20200528015615.GA3176121@bogus>
References: <20200513115601.360642-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513115601.360642-1-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 01:56:00PM +0200, Sebastian Reichel wrote:
> Add new charge-current-limit feature to gpio-charger. This also
> makes the online status GPIO optional, since hardware might only
> expose the charge-current-limit feature and there is no good reason
> to have it mandatory now that different GPIOs are supported.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/gpio-charger.txt    |  11 +-
>  drivers/power/supply/gpio-charger.c           | 176 ++++++++++++++++--
>  2 files changed, 174 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index 0fb33b2c62a6..dbfd29029f69 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -2,8 +2,6 @@ gpio-charger
>  
>  Required properties :
>   - compatible : "gpio-charger"
> - - gpios : GPIO indicating the charger presence.
> -   See GPIO binding in bindings/gpio/gpio.txt .
>   - charger-type : power supply type, one of
>       unknown
>       battery
> @@ -15,7 +13,13 @@ Required properties :
>       usb-aca (USB accessory charger adapter)
>  
>  Optional properties:
> + - gpios : GPIO indicating the charger presence.
> +   See GPIO binding in bindings/gpio/gpio.txt .
>   - charge-status-gpios: GPIO indicating whether a battery is charging.
> + - charge-current-limit-gpios: Output GPIOs specifiers for limiting the charge current
> + - charge-current-limit-mapping: List of touples with current in uA and a GPIO bitmap (in this order).
> +                                The GPIOs are encoded in the same order as specified in charge-current-limit-gpios.

TBC, index 0 GPIO is bit 0?

> +				The touples must be provided in descending order of the current limit.

tuples

Wrap at 80 columns.

>  
>  Example:
>  
> @@ -24,6 +28,9 @@ Example:
>  		charger-type = "usb-sdp";
>  		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
>  		charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
> +
> +		charge-current-limit-gpios = <&gpioA 11 GPIO_ACTIVE_HIGH>, <&gpioA 12 GPIO_ACTIVE_HIGH>;
> +		charge-current-limit-mapping = <2500000 0x00>, <700000 0x01>, <0 0x02>;
>  	};
>  
>  	battery {
> diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
> index 1b959c7f8b0e..4a5eac7cc36c 100644
> --- a/drivers/power/supply/gpio-charger.c
> +++ b/drivers/power/supply/gpio-charger.c
> @@ -18,7 +18,13 @@
>  
>  #include <linux/power/gpio-charger.h>
>  
> +struct gpio_mapping {
> +	u32 limit_ua;
> +	u32 gpiodata;
> +} __packed;
> +
>  struct gpio_charger {
> +	struct device *dev;
>  	unsigned int irq;
>  	unsigned int charge_status_irq;
>  	bool wakeup_enabled;
> @@ -27,6 +33,11 @@ struct gpio_charger {
>  	struct power_supply_desc charger_desc;
>  	struct gpio_desc *gpiod;
>  	struct gpio_desc *charge_status;
> +
> +	struct gpio_descs *current_limit_gpios;
> +	struct gpio_mapping *current_limit_map;
> +	u32 current_limit_map_size;
> +	u32 charge_current_limit;
>  };
>  
>  static irqreturn_t gpio_charger_irq(int irq, void *devid)
> @@ -43,6 +54,35 @@ static inline struct gpio_charger *psy_to_gpio_charger(struct power_supply *psy)
>  	return power_supply_get_drvdata(psy);
>  }
>  
> +static int set_charge_current_limit(struct gpio_charger *gpio_charger, int val)
> +{
> +	struct gpio_mapping mapping;
> +	int ndescs = gpio_charger->current_limit_gpios->ndescs;
> +	struct gpio_desc **gpios = gpio_charger->current_limit_gpios->desc;
> +	int i;
> +
> +	if (!gpio_charger->current_limit_map_size)
> +		return -EINVAL;
> +
> +	for (i = 0; i < gpio_charger->current_limit_map_size; i++) {
> +		if (gpio_charger->current_limit_map[i].limit_ua <= val)
> +			break;
> +	}
> +	mapping = gpio_charger->current_limit_map[i];
> +
> +	for (i = 0; i < ndescs; i++) {
> +		bool val = (mapping.gpiodata >> i) & 1;
> +		gpiod_set_value_cansleep(gpios[ndescs-i-1], val);
> +	}
> +
> +	gpio_charger->charge_current_limit = mapping.limit_ua;
> +
> +	dev_dbg(gpio_charger->dev, "set charge current limit to %d (requested: %d)\n",
> +		gpio_charger->charge_current_limit, val);
> +
> +	return 0;
> +}
> +
>  static int gpio_charger_get_property(struct power_supply *psy,
>  		enum power_supply_property psp, union power_supply_propval *val)
>  {
> @@ -58,6 +98,9 @@ static int gpio_charger_get_property(struct power_supply *psy,
>  		else
>  			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		val->intval = gpio_charger->charge_current_limit;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -65,6 +108,34 @@ static int gpio_charger_get_property(struct power_supply *psy,
>  	return 0;
>  }
>  
> +static int gpio_charger_set_property(struct power_supply *psy,
> +	enum power_supply_property psp, const union power_supply_propval *val)
> +{
> +	struct gpio_charger *gpio_charger = psy_to_gpio_charger(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return set_charge_current_limit(gpio_charger, val->intval);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gpio_charger_property_is_writeable(struct power_supply *psy,
> +					      enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return 1;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static enum power_supply_type gpio_charger_get_type(struct device *dev)
>  {
>  	const char *chargetype;
> @@ -112,9 +183,70 @@ static int gpio_charger_get_irq(struct device *dev, void *dev_id,
>  	return irq;
>  }
>  
> +static int init_charge_current_limit(struct device *dev,
> +				    struct gpio_charger *gpio_charger)
> +{
> +	int i, len;
> +	u32 cur_limit = U32_MAX;
> +
> +	gpio_charger->current_limit_gpios = devm_gpiod_get_array_optional(dev,
> +		"charge-current-limit", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpio_charger->current_limit_gpios)) {
> +		dev_err(dev, "error getting current-limit GPIOs\n");
> +		return PTR_ERR(gpio_charger->current_limit_gpios);
> +	}
> +
> +	if (!gpio_charger->current_limit_gpios)
> +		return 0;
> +
> +	len = device_property_read_u32_array(dev, "charge-current-limit-mapping",
> +		NULL, 0);
> +	if (len < 0)
> +		return len;
> +
> +	if (len % 2) {
> +		dev_err(dev, "invalid charge-current-limit-mapping length\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio_charger->current_limit_map = devm_kmalloc_array(dev,
> +		len / 2, sizeof(*gpio_charger->current_limit_map), GFP_KERNEL);
> +	if (!gpio_charger->current_limit_map)
> +		return -ENOMEM;
> +
> +	gpio_charger->current_limit_map_size = len / 2;
> +
> +	len = device_property_read_u32_array(dev, "charge-current-limit-mapping",
> +		(u32*) gpio_charger->current_limit_map, len);
> +	if (len < 0)
> +		return len;
> +
> +	for (i=0; i < gpio_charger->current_limit_map_size; i++) {
> +		if (gpio_charger->current_limit_map[i].limit_ua > cur_limit) {
> +			dev_err(dev, "invalid charge-current-limit-mapping\n");
> +			return -EINVAL;
> +		}
> +
> +		cur_limit = gpio_charger->current_limit_map[i].limit_ua;
> +	}
> +
> +	/* default to smallest current limitation for safety reasons */
> +	len = gpio_charger->current_limit_map_size - 1;
> +	set_charge_current_limit(gpio_charger,
> +		gpio_charger->current_limit_map[len].limit_ua);
> +
> +	return 0;
> +}
> +
> +/*
> + * The entries will be overwritten by driver's probe routine depending
> + * on the available features. This list ensures, that the array is big
> + * enough for all optional features.
> + */
>  static enum power_supply_property gpio_charger_properties[] = {
>  	POWER_SUPPLY_PROP_ONLINE,
> -	POWER_SUPPLY_PROP_STATUS /* Must always be last in the array. */
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  };
>  
>  static int gpio_charger_probe(struct platform_device *pdev)
> @@ -128,6 +260,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
>  	int charge_status_irq;
>  	unsigned long flags;
>  	int ret;
> +	int num_props = 0;
>  
>  	if (!pdata && !dev->of_node) {
>  		dev_err(dev, "No platform data\n");
> @@ -137,18 +270,19 @@ static int gpio_charger_probe(struct platform_device *pdev)
>  	gpio_charger = devm_kzalloc(dev, sizeof(*gpio_charger), GFP_KERNEL);
>  	if (!gpio_charger)
>  		return -ENOMEM;
> +	gpio_charger->dev = dev;
>  
>  	/*
>  	 * This will fetch a GPIO descriptor from device tree, ACPI or
>  	 * boardfile descriptor tables. It's good to try this first.
>  	 */
> -	gpio_charger->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
> +	gpio_charger->gpiod = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
>  
>  	/*
>  	 * If this fails and we're not using device tree, try the
>  	 * legacy platform data method.
>  	 */
> -	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
> +	if (!gpio_charger->gpiod && !dev->of_node) {
>  		/* Non-DT: use legacy GPIO numbers */
>  		if (!gpio_is_valid(pdata->gpio)) {
>  			dev_err(dev, "Invalid gpio pin in pdata\n");
> @@ -173,18 +307,38 @@ static int gpio_charger_probe(struct platform_device *pdev)
>  		return PTR_ERR(gpio_charger->gpiod);
>  	}
>  
> +	if (gpio_charger->gpiod &&
> +	    num_props < ARRAY_SIZE(gpio_charger_properties)) {
> +		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_ONLINE;
> +		num_props++;
> +	}
> +
>  	charge_status = devm_gpiod_get_optional(dev, "charge-status", GPIOD_IN);
> -	gpio_charger->charge_status = charge_status;
> -	if (IS_ERR(gpio_charger->charge_status))
> -		return PTR_ERR(gpio_charger->charge_status);
> +	if (IS_ERR(charge_status))
> +		return PTR_ERR(charge_status);
> +	if (charge_status && num_props < ARRAY_SIZE(gpio_charger_properties)) {
> +		gpio_charger->charge_status = charge_status;
> +		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_STATUS;
> +		num_props++;
> +	}
> +
> +	ret = init_charge_current_limit(dev, gpio_charger);
> +	if (ret < 0)
> +		return ret;
> +	if (gpio_charger->current_limit_map &&
> +	    num_props < ARRAY_SIZE(gpio_charger_properties)) {
> +		gpio_charger_properties[num_props] =
> +			POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
> +		num_props++;
> +	}
>  
>  	charger_desc = &gpio_charger->charger_desc;
>  	charger_desc->properties = gpio_charger_properties;
> -	charger_desc->num_properties = ARRAY_SIZE(gpio_charger_properties);
> -	/* Remove POWER_SUPPLY_PROP_STATUS from the supported properties. */
> -	if (!gpio_charger->charge_status)
> -		charger_desc->num_properties -= 1;
> +	charger_desc->num_properties = num_props;
>  	charger_desc->get_property = gpio_charger_get_property;
> +	charger_desc->set_property = gpio_charger_set_property;
> +	charger_desc->property_is_writeable =
> +					gpio_charger_property_is_writeable;
>  
>  	psy_cfg.of_node = dev->of_node;
>  	psy_cfg.drv_data = gpio_charger;
> @@ -269,6 +423,6 @@ static struct platform_driver gpio_charger_driver = {
>  module_platform_driver(gpio_charger_driver);
>  
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> -MODULE_DESCRIPTION("Driver for chargers which report their online status through a GPIO");
> +MODULE_DESCRIPTION("Driver for chargers only communicating via GPIO(s)");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:gpio-charger");
> -- 
> 2.26.2
> 
