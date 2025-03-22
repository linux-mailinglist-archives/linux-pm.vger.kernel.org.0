Return-Path: <linux-pm+bounces-24406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9CA6C851
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 09:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F008F463A72
	for <lists+linux-pm@lfdr.de>; Sat, 22 Mar 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5FA1D63E4;
	Sat, 22 Mar 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="b4sbHhjl"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD35125B9;
	Sat, 22 Mar 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742632071; cv=none; b=CkHL6vWPr3GwCcAA2o/vdx0USsZ1+KemMpG4wojfDAq2PECLyuuGqk/130JaaYvHDGPyD9Mf/cfR7PH0vruYRg6ltjTmO2cSzbWZs6I+p1j5BizWZftlSOFI8b6UD5VMAhSL7yMGOYX+J5nzutwDriaaWhnILhOWQjrv501hDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742632071; c=relaxed/simple;
	bh=NQHaUUWzptTM+mnw75QsbGHoGuQWMrb7x4ZKP6YaLfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5LT0OdibdX9bPiJGuwbaN0cCRcXwuu0fBIKkIXgtMjQOfzzYEUyApVMmZ1U+YE0slWLBHsEiCCnWVdauNg6aLq4WlMxW2MFyy0abeWSSgl4RbgiJRvbvBTu8d7sUI05NQR7940cbVfIferdYILU5GWlZH7d6jU0kSRT9I8oOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=b4sbHhjl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742632066;
	bh=NQHaUUWzptTM+mnw75QsbGHoGuQWMrb7x4ZKP6YaLfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4sbHhjlF0ZC5JGElnJjHJPqA51VcDN8Zz4/H5zJ99pYDqylujPf0d4kiFanH3vMi
	 wX4dyH51ZfkhDX2/w0itdHdKZoIMLN/2jahEES+2b8XnbvDFv5B/XbSiO9SOH3EeJD
	 LKjQ1GVM9euYw0PCq5+rZUnomHZWrL8EnflO27po=
Date: Sat, 22 Mar 2025 09:27:46 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org, ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v6 14/14] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
Message-ID: <0061f04a-e07f-4616-9db5-8b0ba319fd17@t-8ch.de>
References: <20250319175512.27059-1-lkml@antheas.dev>
 <20250319175512.27059-15-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319175512.27059-15-lkml@antheas.dev>

On 2025-03-19 18:55:09+0100, Antheas Kapenekakis wrote:
> With the X1 (AMD), OneXPlayer added a charge limit and charge inhibit
> feature to their devices. Charge limit allows for choosing an arbitrary
> battery charge setpoint in percentages. Charge ihibit allows to instruct
> the device to stop charging either when it is awake or always.
> 
> This feature was then extended for the F1Pro as well. OneXPlayer also
> released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> add support for this feature. Therefore, enable it for all F1 and
> X1 devices.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/Kconfig |   1 +
>  drivers/platform/x86/oxpec.c | 160 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 157 insertions(+), 4 deletions(-)
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
> index fe76973fa0c2c..2e9a1f17fef96 100644
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
>  
>  /* Fan reading and PWM */
>  #define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 registers long */
> @@ -93,6 +95,23 @@ static enum oxp_board board;
>  #define OXP_X1_TURBO_LED_OFF           0x01
>  #define OXP_X1_TURBO_LED_ON            0x02
>  
> +/* Battery extension settings */
> +#define EC_CHARGE_CONTROL_BEHAVIOURS	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
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
> @@ -507,6 +526,129 @@ static ssize_t tt_led_show(struct device *dev,
>  
>  static DEVICE_ATTR_RW(tt_led);
>  
> +/* Callbacks for charge behaviour attributes */
> +static bool oxp_psy_ext_supported(void)
> +{
> +	switch (board) {
> +	case oxp_x1:
> +	case oxp_fly:
> +		return true;
> +	default:
> +		break;
> +	}
> +	return false;
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

Theoretically raw_val could be < 0.

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
> +	.charge_behaviours	= EC_CHARGE_CONTROL_BEHAVIOURS,
> +	.get_property		= oxp_psy_ext_get_prop,
> +	.set_property		= oxp_psy_ext_set_prop,
> +	.property_is_writeable	= oxp_psy_prop_is_writeable,
> +};
> +
> +static int oxp_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
> +{
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
> +	.add_battery	= oxp_add_battery,
> +	.remove_battery	= oxp_remove_battery,
> +	.name		= "OneXPlayer Battery",
> +};
> +
>  /* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
> @@ -845,12 +987,22 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
>  static int oxp_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device *hwdev;
> +	int ret;
> +
> +	oxp_dev = dev;
> +	ret = PTR_ERR_OR_ZERO(devm_hwmon_device_register_with_info(
> +		dev, "oxp_ec", NULL, &oxp_ec_chip_info, NULL));
>  
> -	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> -						     &oxp_ec_chip_info, NULL);
> +	if (ret)
> +		return ret;
>  
> -	return PTR_ERR_OR_ZERO(hwdev);
> +	if (oxp_psy_ext_supported()) {
> +		ret = devm_battery_hook_register(dev, &battery_hook);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static struct platform_driver oxp_platform_driver = {
> -- 
> 2.48.1
> 

