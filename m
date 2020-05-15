Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589611D4F39
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 15:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEON05 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 09:26:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43696 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgEON05 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 09:26:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: evelikov)
        with ESMTPSA id B1F332A2B8B
Date:   Fri, 15 May 2020 14:24:16 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 1/2] power: supply: gpio-charger: add
 charge-current-limit feature
Message-ID: <20200515132416.GA2836808@arch-x1c3>
References: <20200513115601.360642-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513115601.360642-1-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

I've left a few trivial suggestions, although I suspect only one of them
really matters. Namely - I think as-is the code changes the legacy behaviour
when OF is missing.

Mind you, this is my third time skimming through power/supply, so take it with
a grain of salt.

On 2020/05/13, Sebastian Reichel wrote:
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
> +				The touples must be provided in descending order of the current limit.

Minor tweaks:

	List of tuples with current in uA and a GPIO bitmap.
	Tuples must be sorted in descending order of the current limit.
	GPIOs are encoded in the order as specified in charge-current-limit-gpios.


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

The properly is optional, although I'm not sure if having an 'empty' properly
(len == 0) should be considered an error as indicated by -ENOMEM below or not.

Worth documenting that, unless it's covered already.

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
Would make sense to use something more descriptive than "invalid". Say "not
sorted by current descending order"?


> @@ -137,18 +270,19 @@ static int gpio_charger_probe(struct platform_device *pdev)

>  	/*
>  	 * If this fails and we're not using device tree, try the
>  	 * legacy platform data method.
>  	 */
> -	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
> +	if (!gpio_charger->gpiod && !dev->of_node) {
The original code will attempt the legacy code for ... (from the doc)

 * ..., -ENOENT if no GPIO has been assigned to the requested function, or
 * another IS_ERR() code if an error occurred while trying to acquire the GPIO.

While the new code will only consider -ENOENT.

Using IS_ERR_OR_NULL(gpio_charger->gpiod) should preserve the original
behaviour.


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
The ARRAY_SIZE() check here (and below) are always true, albeit not dead code.

IMHO the beefy comment above gpio_charger_properties, plus review process is
enough to catch these issues, so it can be dropped.


>  	charger_desc = &gpio_charger->charger_desc;
>  	charger_desc->properties = gpio_charger_properties;

Aside: any particular reason why power_supply_desc::properties isn't const?

-Emil
