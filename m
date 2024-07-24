Return-Path: <linux-pm+bounces-11370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BC593B814
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 22:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9341F21BA3
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53A7173C;
	Wed, 24 Jul 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c65VN+68"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3713C9C4;
	Wed, 24 Jul 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853248; cv=none; b=kKYvrBjebHemVHi03w/Ndp8CqoU9UpDITNPnEkMCEC1MGTMfTCMi0ndr75Y4NEaDrs9ejO3qEhTRtM1jy7tJIZccYEk1kSor47uJ16dNOjx7vFVnozepdlj70Yl9fucXSZQrX4JssngZ92ArdQOUWBbVWrWeV2oiXN/qJ2U7OQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853248; c=relaxed/simple;
	bh=NFAwPkI8W7ec4Ko9blqPXr5liy0J0ySpk9fRRaMwwKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJB4bmQjzf6zQu6OYMoEvQwdVFWlY+SB8kb0y2OkUioHxF+tnNNOoHIm2FSNGJHJeI2K+97pFGk8nUhXF878xnfkzGVmbqNaRFXauOnZ2JBXNuz9Py7xSbJ2RAHLGspa5TkoaUivhZp3glKym7l+JzKQy634bPJgLYykckw/R7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c65VN+68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F864C32781;
	Wed, 24 Jul 2024 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721853247;
	bh=NFAwPkI8W7ec4Ko9blqPXr5liy0J0ySpk9fRRaMwwKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c65VN+68xH5QQkosxTiczR48GICpAedLUAplQmr0kG9+w6NIBH6yVf/NTP/EO1HG4
	 q0WeKV79YMm8wve4BTLgWJQUPY+fR1EoeYzfOKUHtHtFIUG/XTo2ZfqlA9901updpk
	 BIACWXNPZWjDakn/br7Vvt8D9NVe4PBjFW/XoFuO1tZEzy9GE1JSsltfNFs8IMdwjb
	 hj8OBufV+/do7IyhrxyqvXyVF4/aYUh5aSGXlwvY+WpL4m7egaGXgxZM+8HEiRWUR5
	 qwxy/tFppft0a7ckzRZ+08FcehOdsgl3lqB9QJX++qDYlA5JJLA4GgEYafgPf+VgD5
	 TgG4XBzld0x3g==
Received: by pali.im (Postfix)
	id 7D57E726; Wed, 24 Jul 2024 22:34:03 +0200 (CEST)
Date: Wed, 24 Jul 2024 22:34:03 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240724203403.zcrx2lshbla3o2gp@pali>
References: <20240723220502.77cb0401@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723220502.77cb0401@5400>
User-Agent: NeoMutt/20180716

Hello, the driver change looks good. I have just few minor comments for
this change below.

Anyway, if there is somebody on the list with Dell laptop with 2 or 3
batteries, see below, it would be nice to check how such laptop would
behave with this patch. It does not seem that patch should cause
regression but always it is better to do testing if it is possible.

On Tuesday 23 July 2024 22:05:02 Andres Salomon wrote:
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
> BIOS also has a bunch of other charging modes (with varying levels of
> usefulness), so this adds a new Dell-specific sysfs entry called
> 'charge_type' that's documented in sysfs-class-power-dell (and looks a
> lot like sysfs-class-power-wilco).
> 
> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
> Both of their email addresses bounce, so I'm assuming they're no longer
> with the company. I've reworked most of the patch to make it smaller and
> cleaner.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> Changes in v2, based on extensive feedback from Pali Rohár <pali@kernel.org>:
>     - code style changes
>     - change battery write API to use token->value instead of passed value
>     - stop caching current mode, instead querying SMBIOS as needed
>     - drop the separate list of charging modes enum
>     - rework the list of charging mode strings
>     - query SMBIOS for supported charging modes
>     - split dell_battery_custom_set() up
> ---
>  .../ABI/testing/sysfs-class-power-dell        |  31 ++
>  drivers/platform/x86/dell/Kconfig             |   1 +
>  drivers/platform/x86/dell/dell-laptop.c       | 288 ++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h       |   7 +
>  4 files changed, 327 insertions(+)
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
> index 6552dfe491c6..aae9a95fb188 100644
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
> @@ -99,6 +101,18 @@ static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
>  
> +static const struct {
> +	int token;
> +	const char *label;
> +} battery_modes[] = {
> +	{ BAT_STANDARD_MODE_TOKEN, "standard" },
> +	{ BAT_EXPRESS_MODE_TOKEN, "express" },
> +	{ BAT_PRI_AC_MODE_TOKEN, "primarily_ac" },
> +	{ BAT_ADAPTIVE_MODE_TOKEN, "adaptive" },
> +	{ BAT_CUSTOM_MODE_TOKEN, "custom" },
> +};
> +static u32 battery_supported_modes;
> +
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
>  
> @@ -2183,6 +2197,277 @@ static struct led_classdev mute_led_cdev = {
>  	.default_trigger = "audio-mute",
>  };
>  
> +static int dell_send_request_by_token_loc(struct calling_interface_buffer *buffer,
> +					  u16 class, u16 select, int type,
> +					  u32 val)

"int type" argument is not type, but tokenid. tokenid is 16-bit unsigned
integer, so it would be better to use "u16 tokenid" instead of "int type".
And same applies for all functions below too.

And I think that better name for this function could be
"dell_set_token_value" or something like that. "_by_token_loc" sounds
strange, this function is setting smbios token to some value.

> +{
> +	struct calling_interface_token *token;
> +
> +	token = dell_smbios_find_token(type);
> +	if (!token)
> +		return -ENODEV;
> +
> +	/* -1 is a sentinel value, telling us to use token->value */
> +	if (val == (u32)-1)
> +		val = token->value;
> +
> +	dell_fill_request(buffer, token->location, val, 0, 0);
> +	return dell_send_request(buffer, class, select);
> +}
> +
> +static int dell_battery_set_mode(const int type)
> +{
> +	struct calling_interface_buffer buffer;
> +
> +	/* -1 means use the value from the token */
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, type, -1);
> +}
> +
> +static int dell_battery_read(const int type)
> +{
> +	struct calling_interface_buffer buffer;
> +	int err;
> +
> +	err = dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_READ,
> +			SELECT_TOKEN_STD, type, 0);
> +	if (err)
> +		return err;
> +
> +	return buffer.output[1];

buffer.output[1] is of type u32. So theoretically it can contain value
above 2^31. For safety it would be better to check if the output[1]
value fits into INT_MAX and if not then return something like -ERANGE
(or some other better errno code).

> +}
> +
> +static bool dell_battery_mode_is_active(const int type)
> +{
> +	struct calling_interface_token *token;
> +
> +	token = dell_smbios_find_token(type);
> +	if (!token)
> +		return false;

This check is redundant and can be dropped.

dell_battery_read() returns -ENODEV when token (type) does not exist.
So you could treat negative return value from dell_battery_read() as
"return false".

> +
> +	return token->value == dell_battery_read(type);

token->value is of unsigned u16 type and dell_battery_read() returns
signed int. So maybe some explicit cast could useful for documentation
purposes.

> +}
> +
> +/* The rules: the minimum start charging value is 50%. The maximum

nit: Multiline non-network comment starts with "/*" on separate line and
comment text continue on next line (not the same line).

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
> +static int dell_battery_set_custom_charge_start(int start)
> +{
> +	struct calling_interface_buffer buffer;
> +	int end;
> +
> +	if (start < CHARGE_START_MIN)
> +		start = CHARGE_START_MIN;
> +	else if (start > CHARGE_START_MAX)
> +		start = CHARGE_START_MAX;
> +
> +	end = dell_battery_read(BAT_CUSTOM_CHARGE_END);
> +	/* a failed read is okay */

Why is failed read okay? It sounds strange if we ignore firmware errors.
I think that if reading the custom charge value is failing we should not
continue and trying to set/change custom charge value.

Also if the returned value is above 100 (%), should be continue?

> +	if (end < 0)
> +		end = CHARGE_END_MAX;
> +	if ((end - start) < CHARGE_MIN_DIFF)

nit: I'm not sure what is the correct coding style for kernel drivers
but I thought that parenthesis around (end - start) are not being
written.

> +		start = end - CHARGE_MIN_DIFF;
> +
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_START, start);
> +}
> +
> +static int dell_battery_set_custom_charge_end(int end)
> +{
> +	struct calling_interface_buffer buffer;
> +	int start;
> +
> +	if (end < CHARGE_END_MIN)
> +		end = CHARGE_END_MIN;
> +	else if (end > CHARGE_END_MAX)
> +		end = CHARGE_END_MAX;
> +
> +	start = dell_battery_read(BAT_CUSTOM_CHARGE_START);
> +	/* a failed read is okay */
> +	if (start < 0)
> +		start = CHARGE_START_MIN;
> +	if ((end - start) < CHARGE_MIN_DIFF)
> +		end = start + CHARGE_MIN_DIFF;
> +
> +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_END, end);
> +}
> +
> +static ssize_t charge_type_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	ssize_t count = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +		bool active;
> +
> +		if (!(battery_supported_modes & BIT(i)))
> +			continue;
> +
> +		active = dell_battery_mode_is_active(battery_modes[i].token);
> +		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> +				battery_modes[i].label);
> +	}
> +
> +	/* convert the last space to a newline */
> +	if (count > 0)
> +		count--;
> +	count += sysfs_emit_at(buf, count, "\n");
> +
> +	return count;
> +}
> +
> +static ssize_t charge_type_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	bool matched = false;
> +	int err, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {

nit: Personally I would put the "if (!(battery_supported_modes & BIT(i)))"
check here with continue, to have same pattern in _show and _store
functions. And also if we want to support battery mode which will have
different tokens on different machines (see below for possibility).

> +		if (sysfs_streq(battery_modes[i].label, buf)) {
> +			matched = true;
> +			break;
> +		}
> +	}
> +	if (!matched || !(battery_supported_modes & BIT(i)))
> +		return -EINVAL;
> +
> +	err = dell_battery_set_mode(battery_modes[i].token);
> +	if (err)
> +		return err;
> +
> +	return size;
> +}
> +
> +static ssize_t charge_control_start_threshold_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int start;
> +
> +	start = dell_battery_read(BAT_CUSTOM_CHARGE_START);
> +	if (start < 0)
> +		return start;

IIRC the value is in percentage. So we should also check that returned
value is not above 100 (and return some error in case).

> +
> +	return sysfs_emit(buf, "%d\n", start);
> +}
> +
> +static ssize_t charge_control_start_threshold_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	int ret, start;
> +
> +	ret = kstrtoint(buf, 10, &start);
> +	if (ret)
> +		return ret;

I think that there should be some sanity validation. If format is
percentage then we should not accept from userspace value outside of
[0, 100] range.

> +
> +	ret = dell_battery_set_custom_charge_start(start);
> +	if (ret)
> +		return ret;
> +
> +	return size;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int end;
> +
> +	end = dell_battery_read(BAT_CUSTOM_CHARGE_END);
> +	if (end < 0)
> +		return end;
> +
> +	return sysfs_emit(buf, "%d\n", end);
> +}
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	int ret, end;
> +
> +	ret = kstrtouint(buf, 10, &end);
> +	if (ret)
> +		return ret;
> +
> +	ret = dell_battery_set_custom_charge_end(end);
> +	if (ret)
> +		return ret;
> +
> +	return size;
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
> +static u32 __init battery_get_supported_modes(void)
> +{
> +	u32 modes = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +		if (dell_smbios_find_token(battery_modes[i].token))
> +			modes |= BIT(i);
> +	}
> +
> +	return modes;
> +}
> +
> +static void __init dell_battery_init(struct device *dev)
> +{
> +	battery_supported_modes = battery_get_supported_modes();
> +
> +	if (battery_supported_modes != 0)
> +		battery_hook_register(&dell_battery_hook);

Anyway, how is this battery_hook_register() suppose to work on systems
with multiple batteries? The provided API is only for the primary
battery, but on older Dell laptop it was possible to connect up to
3 batteries. Would not this case some issues?

I have one Dell laptop which has an option to connect secondary
battery, but I do not have the compatible secondary battery to test it.

Has somebody Dell laptop with 2 or 3 batteries? It would be really good
to test this patch how it would behave...

> +}
> +
> +static void __exit dell_battery_exit(void)
> +{
> +	if (battery_supported_modes != 0)
> +		battery_hook_unregister(&dell_battery_hook);
> +}
> +
>  static int __init dell_init(void)
>  {
>  	struct calling_interface_token *token;
> @@ -2219,6 +2504,7 @@ static int __init dell_init(void)
>  		touchpad_led_init(&platform_device->dev);
>  
>  	kbd_led_init(&platform_device->dev);
> +	dell_battery_init(&platform_device->dev);
>  
>  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
>  	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> @@ -2293,6 +2579,7 @@ static int __init dell_init(void)
>  	if (mute_led_registered)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
> +	dell_battery_exit();
>  	dell_cleanup_rfkill();
>  fail_rfkill:
>  	platform_device_del(platform_device);
> @@ -2311,6 +2598,7 @@ static void __exit dell_exit(void)
>  	if (quirks && quirks->touchpad_led)
>  		touchpad_led_exit();
>  	kbd_led_exit();
> +	dell_battery_exit();
>  	backlight_device_unregister(dell_backlight_device);
>  	if (micmute_led_registered)
>  		led_classdev_unregister(&micmute_led_cdev);
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index ea0cc38642a2..77baa15eb523 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -33,6 +33,13 @@
>  #define KBD_LED_AUTO_50_TOKEN	0x02EB
>  #define KBD_LED_AUTO_75_TOKEN	0x02EC
>  #define KBD_LED_AUTO_100_TOKEN	0x02F6
> +#define BAT_PRI_AC_MODE_TOKEN	0x0341
> +#define BAT_ADAPTIVE_MODE_TOKEN	0x0342
> +#define BAT_CUSTOM_MODE_TOKEN	0x0343
> +#define BAT_STANDARD_MODE_TOKEN	0x0346
> +#define BAT_EXPRESS_MODE_TOKEN	0x0347

There is defined also tokenid 0x0348 which is per dell libsmbios's
token_list.csv documentation also for custom mode. It is marked as
deprecated, so seems that it is for old laptops, which do not support
tokenid 0x0343.

What about defining '#define BAT_CUSTOM_OLD_MODE_TOKEN 0x0348', then
adding '{ BAT_CUSTOM_OLD_MODE_TOKEN, "custom" }' into battery_modes and
changing battery_get_supported_modes() to mask out custom_old bit when
the normal custom is supported? Seems that it would be OK, just the
charge_type_store() needs modification as written above.

Just an idea. What do you think?

> +#define BAT_CUSTOM_CHARGE_START	0x0349
> +#define BAT_CUSTOM_CHARGE_END	0x034A
>  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
>  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
>  #define GLOBAL_MUTE_ENABLE	0x058C
> -- 
> 2.39.2
> 
> 
> 
> 
> -- 
> I'm available for contract & employment work, see:
> https://spindle.queued.net/~dilinger/resume-tech.pdf

