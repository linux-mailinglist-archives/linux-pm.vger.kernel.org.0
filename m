Return-Path: <linux-pm+bounces-11264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85124938009
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 10:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E461F221A1
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jul 2024 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C554903;
	Sat, 20 Jul 2024 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNFe64r4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103055C08;
	Sat, 20 Jul 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721464824; cv=none; b=GiAdroHgxEofh//PDMti2PXkSFoWUCzNQQb8JOcOrCeqpiSJqsNOiBcsTGpqRkE8IswRq4A93DwWXcsdi31rLjqQXzGRm/HN7+haExzlg13HDAzHxPTrHXhEi3pAITI89p5jwrNxiTLDJndJpHir4zyCfhfposa9qvOOWJO/JO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721464824; c=relaxed/simple;
	bh=88wjJlk7GrSPr8obbchMXqNk3ue/vih//iw+H4I36XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8kG3pU3bDUhd4qY5kUooeX0d5rAJZjd9qp4v6gq7LWj3LP6/Qd1lrLnDXXnZi/c6FkOqm3bXtbtP6q524tBFAR4k0GPbpq3DzV0Lyh7dGwn4QRf65wj31Uk9imxurRXsDtp+V4GiWwXC9Ydole6MXDML74D9EXHpBTSqx89NdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNFe64r4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F37CC4AF0A;
	Sat, 20 Jul 2024 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721464823;
	bh=88wjJlk7GrSPr8obbchMXqNk3ue/vih//iw+H4I36XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNFe64r4UzkykO14C6agyqXxJrooc3Y5lgbcJYubUdXIsJ10OeaKPN1idCUzi35V1
	 2/ltGtafUFTinxgha27eAAiOUNbQYWO3pPQxnDavmof+WYt08HVQfVADx0+7A/s/ev
	 Fks3g3JsvJMmdXrVjNGc9DjofBJL4s0qZADpcT5hvUBU9Dp7kNqc01D+vE8Net9wcP
	 Lb0BR3RUlbBpQbWD793gytFOXToxDqgygxmv6tQSRM62eqBxtRlZncOUisBGgmd+/f
	 BEzp+ENbaeK5gax/CTdiESwJewBqWenWJHZV/42deqwPzGGWl8R+cxxhLYSQqr484t
	 4yDThMgh3S5gg==
Received: by pali.im (Postfix)
	id 8DC3C8A0; Sat, 20 Jul 2024 10:40:19 +0200 (CEST)
Date: Sat, 20 Jul 2024 10:40:19 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
Message-ID: <20240720084019.hrnd4wgt4muorydp@pali>
References: <20240720012220.26d62a54@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720012220.26d62a54@5400>
User-Agent: NeoMutt/20180716

Hello,

I looked at your patch. I wrote some comments below. The main issue is
how to correctly interpret read token values.

Anyway, Dell in past published documentation and Python GPL code for
doing something with batteries. I'm not sure if it is different API or
something unrelated, but maybe it could be useful for your research:
https://github.com/dell/libsmbios/blob/master/src/bin/smbios-battery-ctl

On Saturday 20 July 2024 01:22:20 Andres Salomon wrote:
> The Dell BIOS allows you to set custom charging modes, which is useful
> in particular for extending battery life. This adds support for tweaking
> those various settings from Linux via sysfs knobs. One might, for
> example, have their laptop plugged into power at their desk the vast
> majority of the time and choose fairly aggressive battery-saving
> settings (only charging once the battery drops to 50% and only charging
> up to 80%). When leaving for a trip, they might want to switch those
> settings to charge to 100% and charge any time power is available;
> rebooting into the BIOS to change those settings is a hassle.
> 
> For the Custom charging type mode, we reuse the common
> charge_control_{start,end}_threshold sysfs power_supply entries. The
> BIOS also has a bunch of other charging modes with varying levels of
> usefulness, so this adds a new Dell-specific sysfs entry called
> 'charge_type' that's documented in sysfs-class-power-dell (and looks a
> lot like sysfs-class-power-wilco).
> 
> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
> Both of their email addresses bounce, so I'm assuming they're no longer
> with the company. I've reworked most of the patch to make it smaller and
> cleaner.

Mario is in AMD, I'm adding his address to the loop, so in case is
interesting can look at this.

> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
>  .../ABI/testing/sysfs-class-power-dell        |  31 +++
>  drivers/platform/x86/dell/Kconfig             |   1 +
>  drivers/platform/x86/dell/dell-laptop.c       | 263 ++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h       |  17 ++
>  4 files changed, 312 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documentation/ABI/testing/sysfs-class-power-dell
> new file mode 100644
> index 000000000000..ef72c5f797ce
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-dell
> @@ -0,0 +1,31 @@
> +What:		/sys/class/power_supply/<supply_name>/charge_type
> +Date:		July 2024
> +KernelVersion:	6.11
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Select the charging algorithm to use for the (primary)
> +		battery.
> +
> +		Standard:
> +			Fully charge the battery at a moderate rate.
> +		ExpressCharge™:
> +			Quickly charge the battery using fast-charge
> +			technology. This is harder on the battery than
> +			standard charging and may lower its lifespan.
> +		Primarily AC Use:
> +			Users who primarily operate the system while
> +			plugged into an external power source can extend
> +			battery life with this mode.
> +		Adaptive:
> +			Automatically optimize battery charge rate based
> +			on typical usage.
> +		Custom:
> +			Use the charge_control_* properties to determine
> +			when to start and stop charging. Advanced users
> +			can use this to drastically extend battery life.
> +
> +		Access: Read, Write
> +		Valid values:
> +			      "standard", "express", "primarily_ac",
> +			      "adaptive", "custom"
> +
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 85a78ef91182..02405793163c 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -49,6 +49,7 @@ config DELL_LAPTOP
>  	default m
>  	depends on DMI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on ACPI_BATTERY
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
>  	depends on RFKILL || RFKILL = n
>  	depends on DELL_WMI || DELL_WMI = n
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 6552dfe491c6..54f47b685a46 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -22,11 +22,13 @@
>  #include <linux/io.h>
>  #include <linux/rfkill.h>
>  #include <linux/power_supply.h>
> +#include <linux/sysfs.h>
>  #include <linux/acpi.h>
>  #include <linux/mm.h>
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <acpi/battery.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> @@ -98,6 +100,14 @@ static struct rfkill *wwan_rfkill;
>  static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
> +static enum battery_charging_mode bat_chg_current = DELL_BAT_MODE_NONE;
> +static const char * const battery_state[DELL_BAT_MODE_MAX] = {
> +	[DELL_BAT_MODE_STANDARD] = "standard",
> +	[DELL_BAT_MODE_EXPRESS] = "express",
> +	[DELL_BAT_MODE_PRIMARILY_AC] = "primarily_ac",
> +	[DELL_BAT_MODE_ADAPTIVE] = "adaptive",
> +	[DELL_BAT_MODE_CUSTOM] = "custom",
> +};
>  
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
> @@ -2183,6 +2193,256 @@ static struct led_classdev mute_led_cdev = {
>  	.default_trigger = "audio-mute",
>  };
>  
> +static int dell_battery_read_req(const int type, int *val)
> +{
> +	struct calling_interface_buffer buffer;
> +	struct calling_interface_token *token;
> +	int err;
> +
> +	token = dell_smbios_find_token(type);
> +	if (!token)
> +		return -ENODEV;
> +
> +	dell_fill_request(&buffer, token->location, 0, 0, 0);
> +	err = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> +	if (!err)
> +		*val = buffer.output[1];
> +
> +	return err;
> +}

dell_send_request() returns negative value on error. As the read value
seems to be always non-negative number, you can change API of the
dell_battery_read_req() function to have read value in the return value
(instead of in *val pointer). E.g.

static int dell_battery_read_req(const int type)
{
	...
	err = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
	if (err)
		return err;

	return buffer.output[1];
}

> +
> +static int dell_battery_write_req(const int type, int val)
> +{
> +	struct calling_interface_buffer buffer;
> +	struct calling_interface_token *token;
> +
> +	token = dell_smbios_find_token(type);
> +	if (!token)
> +		return -ENODEV;
> +
> +	dell_fill_request(&buffer, token->location, val, 0, 0);
> +	return dell_send_request(&buffer,
> +			CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +}
> +
> +/* The rules: the minimum start charging value is 50%. The maximum
> + * start charging value is 95%. The minimum end charging value is
> + * 55%. The maximum end charging value is 100%. And finally, there
> + * has to be at least a 5% difference between start & end values.
> + */
> +#define CHARGE_START_MIN	50
> +#define CHARGE_START_MAX	95
> +#define CHARGE_END_MIN		55
> +#define CHARGE_END_MAX		100
> +#define CHARGE_MIN_DIFF		5
> +
> +static int dell_battery_custom_set(const int type, int val)
> +{
> +	if (type == BAT_CUSTOM_CHARGE_START) {
> +		int end = CHARGE_END_MAX;
> +
> +		if (val < CHARGE_START_MIN)
> +			val = CHARGE_START_MIN;
> +		else if (val > CHARGE_START_MAX)
> +			val = CHARGE_START_MAX;
> +
> +		dell_battery_read_req(BAT_CUSTOM_CHARGE_END, &end);

Missing check for failure of dell_battery_read_req.

> +		if ((end - val) < CHARGE_MIN_DIFF)
> +			val = end - CHARGE_MIN_DIFF;
> +	} else if (type == BAT_CUSTOM_CHARGE_END) {
> +		int start = CHARGE_START_MIN;
> +
> +		if (val < CHARGE_END_MIN)
> +			val = CHARGE_END_MIN;
> +		else if (val > CHARGE_END_MAX)
> +			val = CHARGE_END_MAX;
> +
> +		dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);

Missing check for failure of dell_battery_read_req.

> +		if ((val - start) < CHARGE_MIN_DIFF)
> +			val = start + CHARGE_MIN_DIFF;
> +	}
> +
> +	return dell_battery_write_req(type, val);
> +}
> +
> +static int battery_charging_mode_set(enum battery_charging_mode mode)
> +{
> +	int err;
> +
> +	switch (mode) {
> +	case DELL_BAT_MODE_STANDARD:
> +		err = dell_battery_write_req(BAT_STANDARD_MODE_TOKEN, mode);
> +		break;
> +	case DELL_BAT_MODE_EXPRESS:
> +		err = dell_battery_write_req(BAT_EXPRESS_MODE_TOKEN, mode);
> +		break;
> +	case DELL_BAT_MODE_PRIMARILY_AC:
> +		err = dell_battery_write_req(BAT_PRI_AC_MODE_TOKEN, mode);
> +		break;
> +	case DELL_BAT_MODE_ADAPTIVE:
> +		err = dell_battery_write_req(BAT_ADAPTIVE_MODE_TOKEN, mode);
> +		break;
> +	case DELL_BAT_MODE_CUSTOM:
> +		err = dell_battery_write_req(BAT_CUSTOM_MODE_TOKEN, mode);
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}

You can make whole function smaller by avoiding err variable:

static int battery_charging_mode_set(enum battery_charging_mode mode)
{
	switch (mode) {
	case DELL_BAT_MODE_STANDARD:
		return dell_battery_write_req(BAT_STANDARD_MODE_TOKEN, mode);
	case DELL_BAT_MODE_EXPRESS:
		return dell_battery_write_req(BAT_EXPRESS_MODE_TOKEN, mode);
	case DELL_BAT_MODE_PRIMARILY_AC:
		return dell_battery_write_req(BAT_PRI_AC_MODE_TOKEN, mode);
	case DELL_BAT_MODE_ADAPTIVE:
		return dell_battery_write_req(BAT_ADAPTIVE_MODE_TOKEN, mode);
	case DELL_BAT_MODE_CUSTOM:
		return dell_battery_write_req(BAT_CUSTOM_MODE_TOKEN, mode);
	default:
		return -EINVAL;
	}
}

> +
> +static ssize_t charge_type_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	enum battery_charging_mode mode;
> +	ssize_t count = 0;
> +
> +	for (mode = DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode++) {
> +		if (battery_state[mode]) {
> +			count += sysfs_emit_at(buf, count,
> +				mode == bat_chg_current ? "[%s] " : "%s ",
> +				battery_state[mode]);
> +		}
> +	}
> +
> +	/* convert the last space to a newline */
> +	count--;
> +	count += sysfs_emit_at(buf, count, "\n");

Here is missing protection in the case when number of valid modes is
zero, so count is 0 and buf was untouched.

> +
> +	return count;
> +}
> +
> +static ssize_t charge_type_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	enum battery_charging_mode mode;
> +	const char *label;
> +	int ret = -EINVAL;
> +
> +	for (mode = DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode++) {
> +		label = battery_state[mode];
> +		if (label && sysfs_streq(label, buf))
> +			break;
> +	}
> +
> +	if (mode > DELL_BAT_MODE_NONE && mode < DELL_BAT_MODE_MAX) {
> +		ret = battery_charging_mode_set(mode);
> +		if (!ret) {
> +			bat_chg_current = mode;
> +			ret = size;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t charge_control_start_threshold_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int ret, start;
> +
> +	ret = dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
> +	if (!ret)
> +		ret = sysfs_emit(buf, "%d\n", start);
> +
> +	return ret;
> +}

This function and also following 3 functions have unusual error
handling. Normally error handling is done by early return, as:

    ret = func1();
    if (ret)
        return ret;

    ret = func2();
    if (ret)
        return ret;

    return 0;

You can change it something like:

{
	int ret, start;

	ret = dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
	if (ret)
		return ret;

	return sysfs_emit(buf, "%d\n", start);
}

> +static ssize_t charge_control_start_threshold_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	int ret, start;
> +
> +	ret = kstrtoint(buf, 10, &start);
> +	if (!ret)
> +		ret = dell_battery_custom_set(BAT_CUSTOM_CHARGE_START, start);
> +	if (!ret)
> +		ret = size;
> +
> +	return ret;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int ret, end;
> +
> +	ret = dell_battery_read_req(BAT_CUSTOM_CHARGE_END, &end);
> +	if (!ret)
> +		ret = sysfs_emit(buf, "%d\n", end);
> +
> +	return ret;
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	int ret, end;
> +
> +	ret = kstrtouint(buf, 10, &end);
> +	if (!ret)
> +		ret = dell_battery_custom_set(BAT_CUSTOM_CHARGE_END, end);
> +	if (!ret)
> +		ret = size;
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_start_threshold);
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +static DEVICE_ATTR_RW(charge_type);
> +
> +static struct attribute *dell_battery_attrs[] = {
> +	&dev_attr_charge_control_start_threshold.attr,
> +	&dev_attr_charge_control_end_threshold.attr,
> +	&dev_attr_charge_type.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(dell_battery);
> +
> +static int dell_battery_add(struct power_supply *battery,
> +		struct acpi_battery_hook *hook)
> +{
> +	return device_add_groups(&battery->dev, dell_battery_groups);
> +}
> +
> +static int dell_battery_remove(struct power_supply *battery,
> +		struct acpi_battery_hook *hook)
> +{
> +	device_remove_groups(&battery->dev, dell_battery_groups);
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook dell_battery_hook = {
> +	.add_battery = dell_battery_add,
> +	.remove_battery = dell_battery_remove,
> +	.name = "Dell Primary Battery Extension",
> +};
> +
> +static void __init dell_battery_init(struct device *dev)
> +{
> +	enum battery_charging_mode current_mode = DELL_BAT_MODE_NONE;
> +
> +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
> +	if (current_mode != DELL_BAT_MODE_NONE) {

I quite do not understand how is this code suppose to work.

Why is there mix of custom kernel enum battery_charging_mode and return
value from Dell's API?

My feeling is that dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN) checks
if the token BAT_CUSTOM_MODE_TOKEN is set or not.

Could you please check what is stored in every BAT_*_MODE_TOKEN token at
this init stage?

I think it should work similarly, like keyboard backlight tokens as
implemented in functions: kbd_set_token_bit, kbd_get_token_bit,
kbd_get_first_active_token_bit.

> +		bat_chg_current = current_mode;
> +		battery_hook_register(&dell_battery_hook);
> +	}
> +}
> +
> +static void __exit dell_battery_exit(void)
> +{
> +	if (bat_chg_current != DELL_BAT_MODE_NONE)
> +		battery_hook_unregister(&dell_battery_hook);
> +}
> +
>  static int __init dell_init(void)
>  {
>  	struct calling_interface_token *token;
> @@ -2219,6 +2479,7 @@ static int __init dell_init(void)
>  		touchpad_led_init(&platform_device->dev);
>  
>  	kbd_led_init(&platform_device->dev);
> +	dell_battery_init(&platform_device->dev);
>  
>  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
>  	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> @@ -2293,6 +2554,7 @@ static int __init dell_init(void)
>  	if (mute_led_registered)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
> +	dell_battery_exit();
>  	dell_cleanup_rfkill();
>  fail_rfkill:
>  	platform_device_del(platform_device);
> @@ -2311,6 +2573,7 @@ static void __exit dell_exit(void)
>  	if (quirks && quirks->touchpad_led)
>  		touchpad_led_exit();
>  	kbd_led_exit();
> +	dell_battery_exit();
>  	backlight_device_unregister(dell_backlight_device);
>  	if (micmute_led_registered)
>  		led_classdev_unregister(&micmute_led_cdev);
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index ea0cc38642a2..f7c07b4d72e3 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -33,11 +33,28 @@
>  #define KBD_LED_AUTO_50_TOKEN	0x02EB
>  #define KBD_LED_AUTO_75_TOKEN	0x02EC
>  #define KBD_LED_AUTO_100_TOKEN	0x02F6
> +#define BAT_PRI_AC_MODE_TOKEN	0x0341
> +#define BAT_ADAPTIVE_MODE_TOKEN	0x0342
> +#define BAT_CUSTOM_MODE_TOKEN	0x0343
> +#define BAT_STANDARD_MODE_TOKEN	0x0346
> +#define BAT_EXPRESS_MODE_TOKEN	0x0347
> +#define BAT_CUSTOM_CHARGE_START	0x0349
> +#define BAT_CUSTOM_CHARGE_END	0x034A
>  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
>  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
>  #define GLOBAL_MUTE_ENABLE	0x058C
>  #define GLOBAL_MUTE_DISABLE	0x058D
>  
> +enum battery_charging_mode {
> +	DELL_BAT_MODE_NONE = 0,
> +	DELL_BAT_MODE_STANDARD,
> +	DELL_BAT_MODE_EXPRESS,
> +	DELL_BAT_MODE_PRIMARILY_AC,
> +	DELL_BAT_MODE_ADAPTIVE,
> +	DELL_BAT_MODE_CUSTOM,
> +	DELL_BAT_MODE_MAX,
> +};
> +

I think that this is just an internal driver enum, not Dell API. So this
enum should be in the dell-laptop.c file.

>  struct notifier_block;
>  
>  struct calling_interface_token {
> -- 
> 2.39.2
> 
> 
> 
> -- 
> I'm available for contract & employment work, see:
> https://spindle.queued.net/~dilinger/resume-tech.pdf

