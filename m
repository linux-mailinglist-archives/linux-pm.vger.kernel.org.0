Return-Path: <linux-pm+bounces-24219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EADEEA65C1E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 19:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471C817AEC9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA001CAA92;
	Mon, 17 Mar 2025 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iZ+fbdMs"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47B1B4240;
	Mon, 17 Mar 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235181; cv=none; b=tM59zE9cFhYISUFp5cJxxqAySaHPZPmpZen7/iMELyMLnoCFJd9u0GL+jHouF1B2xF+icFwEQliiLUmph6NG4sIxqnApNfnnnQR7ktYi1/wqUeECKKnRSAlpOOKmoAVP9Kq0QXfP13x4nsjf36y8s82T8h2XqHubkynpg/yLxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235181; c=relaxed/simple;
	bh=qsSTjhE5fdyEUv/1+5Wp0M3tLWOO1tI1rSxmFRlOKcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpP73SETU2jm1YtvPkoJaQnVlq+81BdVXeNTuN6qt8iU0LpwS/TRVShDJwWGfab12Iy9H8FL7fH90Kwi6zq8SyJdRqSQfq2IOas02zjyNuQclQiR5VkoRVW4zsUDAZLn9C94A6DrpQkdobvDQWb2kgG6oYzT5GmU++pC7Hxybw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iZ+fbdMs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742235176;
	bh=qsSTjhE5fdyEUv/1+5Wp0M3tLWOO1tI1rSxmFRlOKcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZ+fbdMswZiNHLsPHy3g+Pl+T+XJDhUf7PGcW6x+KXGv5064WqNJTQbpEdJrSV6Gk
	 n/nic+7nuPDpmEefJ6zDNxMESNN6u94OLmiYrJtABAeECTeFw59Z6s7G2KUKvd9Sro
	 n4EnrogmzJuZtLIToYG4UxkHVCAZulEb1wV+BLOY=
Date: Mon, 17 Mar 2025 19:12:56 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org
Subject: Re: [PATCH v5 13/13] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
Message-ID: <ce0727b4-bf47-4dc7-9103-d87d88a0e213@t-8ch.de>
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-14-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317155349.1236188-14-lkml@antheas.dev>

On 2025-03-17 16:53:49+0100, Antheas Kapenekakis wrote:
> With the X1 (AMD), OneXPlayer added a charge limit and charge inhibit
> feature to their devices. Charge limit allows for choosing an arbitrary
> battery charge setpoint in percentages. Charge ihibit allows to instruct
                                                 inhibit

> the device to stop charging either when it is awake or always.
> 
> This feature was then extended for the F1Pro as well. OneXPlayer also
> released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> add support for this feature. Therefore, enable it for all F1 and
> X1 devices.

What happens for devices without the BIOS update?
Can the availability be detected during probe and handled properly?

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/Kconfig |   1 +
>  drivers/platform/x86/oxpec.c | 164 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 161 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 82cfc76bc5c9f..f4d993658c01f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1189,6 +1189,7 @@ config SEL3350_PLATFORM
>  config OXP_EC
>  	tristate "OneXPlayer EC platform control"
>  	depends on ACPI_EC
> +	depends on ACPI_BATTERY
>  	depends on HWMON
>  	depends on X86
>  	help
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 39a29295f9cfe..88d839c2a4834 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/processor.h>
> +#include <acpi/battery.h>
>  
>  /* Handle ACPI lock mechanism */
>  static u32 oxp_mutex;
> @@ -60,6 +61,7 @@ enum oxp_board {
>  };
>  
>  static enum oxp_board board;
> +static struct device *oxp_dev;

Using a global variable is ugly.
An explicit parameter passed through
battery_hook_register() -> add_battery()
would be nicer.
It would require changes to the core code and all its users, though.

>  
>  /* Fan reading and PWM */
>  #define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
> @@ -93,6 +95,23 @@ static enum oxp_board board;
>  #define OXP_X1_TURBO_LED_OFF           0x01
>  #define OXP_X1_TURBO_LED_ON            0x02
>  
> +/* Battery extension settings */
> +#define EC_CHARGE_CONTROL_BEHAVIOURS_X1	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
> +					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)    | \
> +					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE))
> +
> +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> +#define OXP_X1_CHARGE_INHIBIT_REG     0xA4 /* X1 bypass charging */
> +
> +#define OXP_X1_CHARGE_INHIBIT_MASK_AWAKE 0x01
> +/*
> + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> + * but the extra bit on the X1 does nothing.
> + */
> +#define OXP_X1_CHARGE_INHIBIT_MASK_OFF 0x02
> +#define OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS (OXP_X1_CHARGE_INHIBIT_MASK_AWAKE | \
> +	OXP_X1_CHARGE_INHIBIT_MASK_OFF)
> +
>  static const struct dmi_system_id dmi_table[] = {
>  	{
>  		.matches = {
> @@ -507,6 +526,136 @@ static ssize_t tt_led_show(struct device *dev,
>  
>  static DEVICE_ATTR_RW(tt_led);
>  
> +/* Callbacks for charge behaviour attributes */
> +static bool oxp_psy_ext_supported(void)
> +{
> +	switch (board) {
> +	case oxp_x1:
> +	case oxp_fly:
> +		return 1;
> +	default:
> +		break;
> +	}
> +	return 0;

For 'bool' use 'true' and 'false.

> +}
> +
> +static int oxp_psy_ext_get_prop(struct power_supply *psy,
> +				       const struct power_supply_ext *ext,
> +				       void *data,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	long raw_val;
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		ret = read_from_ec(OXP_X1_CHARGE_LIMIT_REG, 1, &raw_val);
> +		if (ret)
> +			return ret;
> +		if (raw_val > 100)
> +			return -EINVAL;
> +		val->intval = raw_val;
> +		return 0;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		ret = read_from_ec(OXP_X1_CHARGE_INHIBIT_REG, 1, &raw_val);
> +		if (ret)
> +			return ret;
> +		if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS) ==
> +		    OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS)
> +			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +		else if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_AWAKE) ==
> +			 OXP_X1_CHARGE_INHIBIT_MASK_AWAKE)
> +			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE;
> +		else
> +			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int oxp_psy_ext_set_prop(struct power_supply *psy,
> +				       const struct power_supply_ext *ext,
> +				       void *data,
> +				       enum power_supply_property psp,
> +				       const union power_supply_propval *val)
> +{
> +	long raw_val;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +		if (val->intval > 100)
> +			return -EINVAL;
> +		return write_to_ec(OXP_X1_CHARGE_LIMIT_REG, val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		switch (val->intval) {
> +		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +			raw_val = 0;
> +			break;
> +		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE:
> +			raw_val = OXP_X1_CHARGE_INHIBIT_MASK_AWAKE;
> +			break;
> +		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +			raw_val = OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return write_to_ec(OXP_X1_CHARGE_INHIBIT_REG, raw_val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int oxp_psy_prop_is_writeable(struct power_supply *psy,
> +					    const struct power_supply_ext *ext,
> +					    void *data,
> +					    enum power_supply_property psp)
> +{
> +	return true;
> +}
> +
> +static const enum power_supply_property oxp_psy_ext_props[] = {
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +};
> +
> +struct power_supply_ext oxp_psy_ext = {

static const

> +	.name			= "oxp-charge-control",
> +	.properties		= oxp_psy_ext_props,
> +	.num_properties		= ARRAY_SIZE(oxp_psy_ext_props),
> +	.charge_behaviours	= EC_CHARGE_CONTROL_BEHAVIOURS_X1,

The charge control behaviours are named "X1", but nothing else.
Seems inconsistent.

> +	.get_property		= oxp_psy_ext_get_prop,
> +	.set_property		= oxp_psy_ext_set_prop,
> +	.property_is_writeable	= oxp_psy_prop_is_writeable,
> +};
> +
> +static int oxp_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
> +{
> +	/* OneXPlayer devices only have one battery. */
> +	if (strcmp(battery->desc->name, "BAT0") != 0 &&
> +	    strcmp(battery->desc->name, "BAT1") != 0 &&
> +	    strcmp(battery->desc->name, "BATC") != 0 &&
> +	    strcmp(battery->desc->name, "BATT") != 0)
> +		return -ENODEV;

If they only have one battery, why is the check necessary?

> +
> +	return power_supply_register_extension(battery, &oxp_psy_ext, oxp_dev, NULL);
> +}
> +
> +static int oxp_remove_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
> +{
> +	power_supply_unregister_extension(battery, &oxp_psy_ext);
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook battery_hook = {
> +	.add_battery = oxp_add_battery,
> +	.remove_battery = oxp_remove_battery,
> +	.name = "OneXPlayer Battery",

This struct can also be aligned.

> +};
> +
>  /* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
> @@ -845,12 +994,19 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
>  static int oxp_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device *hwdev;
> +	int ret;
>  
> -	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> -						     &oxp_ec_chip_info, NULL);
> +	oxp_dev = dev;
> +	ret = PTR_ERR_OR_ZERO(devm_hwmon_device_register_with_info(
> +		dev, "oxp_ec", NULL, &oxp_ec_chip_info, NULL));
>  
> -	return PTR_ERR_OR_ZERO(hwdev);
> +	if (ret)
> +		return ret;
> +
> +	if (oxp_psy_ext_supported())
> +		return devm_battery_hook_register(dev, &battery_hook);

If the driver is extended in the future this line will need to be touch
again as it is an unconditional early return.

This is more future-proof:

if (oxp_psy_ext_supported()) {
	ret = devm_battery_hook_register(dev, &battery_hook);
	if (ret)
		return ret;
}

> +
> +	return 0;
>  }
>  
>  static struct platform_driver oxp_platform_driver = {
> -- 
> 2.48.1
> 

