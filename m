Return-Path: <linux-pm+bounces-11379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F893B95C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 01:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4123E283206
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 23:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D013AA4E;
	Wed, 24 Jul 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyyCSDhO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375F2E639;
	Wed, 24 Jul 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721862123; cv=none; b=p+3Vxhu1hRWPj4G45hxuqyr8q4wMdn8Ewos+T8V/bRLmbczsI1lMFx/5KAB1IK7wRZvfPhzXiLAFcP2YFHysRFK9YhA7y1BC1q592ai78Hpa8ysjX+eisgysnOsZd7211LHpji5+EI2LojM8gqfpHiGj+r6pJOUVFMVGj1JBFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721862123; c=relaxed/simple;
	bh=6UGXiohfk9uS2ig1dpjMd7ofASWx8zHaC7F3+Ppc33c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAOBkqHGud3+XRPMW4+AxUuDTl1pZWnTSg+4R1X27sfX6xzLASdad0jhXf5/JkmE6FOOLAZIpuroyK68zY2DZSxb25ntEa8+yryiH1MMFQSb2cOgBXPfVdWUzBwiuPEijxPTjd27HsYO4CWUVfNfgCZQnc7Gy26ExZp6MXxa/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyyCSDhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB41BC32781;
	Wed, 24 Jul 2024 23:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721862123;
	bh=6UGXiohfk9uS2ig1dpjMd7ofASWx8zHaC7F3+Ppc33c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyyCSDhOnauD2GYk6cSU0aYnxo2ujZW+OH4k/nXwvyBhshUJ5QC3Mz33Q/5uR11/l
	 8jWF7RK68JNid7TdoqjCXpeuOz2FNk1EKbjxwoy28dN1IbElfR190jVGaqcBNWyvaK
	 6SW2u8gxDr8hKJtwivCDthJAiswE8lkUSXHDhZltpcDfu6Oe/TTtQi5TkeRlDmK5on
	 AX5+ywTNwS15ZsD9PyYMoInE/G09a2xXVkrTPna1bXs9YzL6zWyZysbXknuVomG+f2
	 dlGaXzYpq4De/REWP//ddaRxU/HFLQi4yaJwcE+l2sUYUe/hAs0pFOMAorypcAivLg
	 ByYpM1syszkSQ==
Received: by pali.im (Postfix)
	id 0C763726; Thu, 25 Jul 2024 01:01:58 +0200 (CEST)
Date: Thu, 25 Jul 2024 01:01:58 +0200
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
Message-ID: <20240724230158.nsmxdgagfpanjtzi@pali>
References: <20240723220502.77cb0401@5400>
 <20240724203403.zcrx2lshbla3o2gp@pali>
 <20240724204523.xb6rp7ba6yqi5klt@pali>
 <20240724182318.66578a48@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724182318.66578a48@5400>
User-Agent: NeoMutt/20180716

On Wednesday 24 July 2024 18:23:18 Andres Salomon wrote:
> On Wed, 24 Jul 2024 22:45:23 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Wednesday 24 July 2024 22:34:03 Pali Rohár wrote:
> > > Hello, the driver change looks good. I have just few minor comments for
> > > this change below.
> > > 
> > > Anyway, if there is somebody on the list with Dell laptop with 2 or 3
> > > batteries, see below, it would be nice to check how such laptop would
> > > behave with this patch. It does not seem that patch should cause
> > > regression but always it is better to do testing if it is possible.
> > > 
> > > On Tuesday 23 July 2024 22:05:02 Andres Salomon wrote:  
> [...]
> > And because CLASS_TOKEN_WRITE is being repeated, what about defining
> > something like this?
> > 
> >     static inline int dell_set_token_value(struct calling_interface_buffer *buffer, u16 class, u16 tokenid, u32 value)
> >     {
> >         dell_send_request_for_tokenid(buffer, class, CLASS_TOKEN_WRITE, tokenid, value);
> >     }
> > 
> > Just an idea. Do you think that it could be useful in second patch?
> > 
> 
> Let me implement the other changes first and then take a look.

Ok.

> > > > +
> > > > +static int dell_battery_set_custom_charge_start(int start)
> > > > +{
> > > > +	struct calling_interface_buffer buffer;
> > > > +	int end;
> > > > +
> > > > +	if (start < CHARGE_START_MIN)
> > > > +		start = CHARGE_START_MIN;
> > > > +	else if (start > CHARGE_START_MAX)
> > > > +		start = CHARGE_START_MAX;
> > > > +
> > > > +	end = dell_battery_read(BAT_CUSTOM_CHARGE_END);
> > > > +	/* a failed read is okay */  
> > > 
> > > Why is failed read okay? It sounds strange if we ignore firmware errors.
> > > I think that if reading the custom charge value is failing we should not
> > > continue and trying to set/change custom charge value.
> 
> Because the check itself is simply a sanity check to ensure that the
> start value is not larger than then end value. I thought that if it fails,
> it's not a big deal; the sanity check originally wasn't even there.
> 
> However, you're right that if we're failing to communicate w/ SMBIOS,
> that likely indicates a bigger problem and we probably shouldn't
> continue.
> 
> 
> 
> > > 
> > > Also if the returned value is above 100 (%), should be continue?
> 
> Right, I'd forgotten that we shouldn't trust a BIOS. :)

For example in driver dell-smm-hwmon.c we have to validate what BIOS
returns because sometimes it returns bogus value. This is not some
hypothetical condition, but real problem confirmed by more users.

So checking what Dell BIOS returns is really good idea.

> 
> > >   
> > > > +	if (end < 0)
> > > > +		end = CHARGE_END_MAX;
> > > > +	if ((end - start) < CHARGE_MIN_DIFF)  
> > > 
> > > nit: I'm not sure what is the correct coding style for kernel drivers
> > > but I thought that parenthesis around (end - start) are not being
> > > written.
> > >   
> > > > +		start = end - CHARGE_MIN_DIFF;
> > > > +
> > > > +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> > > > +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_START, start);
> > > > +}
> > > > +
> > > > +static int dell_battery_set_custom_charge_end(int end)
> > > > +{
> > > > +	struct calling_interface_buffer buffer;
> > > > +	int start;
> > > > +
> > > > +	if (end < CHARGE_END_MIN)
> > > > +		end = CHARGE_END_MIN;
> > > > +	else if (end > CHARGE_END_MAX)
> > > > +		end = CHARGE_END_MAX;
> > > > +
> > > > +	start = dell_battery_read(BAT_CUSTOM_CHARGE_START);
> > > > +	/* a failed read is okay */
> > > > +	if (start < 0)
> > > > +		start = CHARGE_START_MIN;
> > > > +	if ((end - start) < CHARGE_MIN_DIFF)
> > > > +		end = start + CHARGE_MIN_DIFF;
> > > > +
> > > > +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> > > > +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_END, end);
> > > > +}
> > > > +
> > > > +static ssize_t charge_type_show(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		char *buf)
> > > > +{
> > > > +	ssize_t count = 0;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > > +		bool active;
> > > > +
> > > > +		if (!(battery_supported_modes & BIT(i)))
> > > > +			continue;
> > > > +
> > > > +		active = dell_battery_mode_is_active(battery_modes[i].token);
> > > > +		count += sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> > > > +				battery_modes[i].label);
> > > > +	}
> > > > +
> > > > +	/* convert the last space to a newline */
> > > > +	if (count > 0)
> > > > +		count--;
> > > > +	count += sysfs_emit_at(buf, count, "\n");
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static ssize_t charge_type_store(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		const char *buf, size_t size)
> > > > +{
> > > > +	bool matched = false;
> > > > +	int err, i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {  
> > > 
> > > nit: Personally I would put the "if (!(battery_supported_modes & BIT(i)))"
> > > check here with continue, to have same pattern in _show and _store
> > > functions. And also if we want to support battery mode which will have
> > > different tokens on different machines (see below for possibility).
> > >   
> 
> Certainly for possible future cases; yeah, it's smarter to handle modes with
> conflicting names.
> 
> 
> > > > +		if (sysfs_streq(battery_modes[i].label, buf)) {
> > > > +			matched = true;
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +	if (!matched || !(battery_supported_modes & BIT(i)))
> > > > +		return -EINVAL;
> > > > +
> > > > +	err = dell_battery_set_mode(battery_modes[i].token);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > > +	return size;
> > > > +}
> > > > +
> > > > +static ssize_t charge_control_start_threshold_show(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		char *buf)
> > > > +{
> > > > +	int start;
> > > > +
> > > > +	start = dell_battery_read(BAT_CUSTOM_CHARGE_START);
> > > > +	if (start < 0)
> > > > +		return start;  
> > > 
> > > IIRC the value is in percentage. So we should also check that returned
> > > value is not above 100 (and return some error in case).
> > >   
> > > > +
> > > > +	return sysfs_emit(buf, "%d\n", start);
> > > > +}
> > > > +
> > > > +static ssize_t charge_control_start_threshold_store(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		const char *buf, size_t size)
> > > > +{
> > > > +	int ret, start;
> > > > +
> > > > +	ret = kstrtoint(buf, 10, &start);
> > > > +	if (ret)
> > > > +		return ret;  
> > > 
> > > I think that there should be some sanity validation. If format is
> > > percentage then we should not accept from userspace value outside of
> > > [0, 100] range.
> > >   
> 
> dell_battery_set_custom_charge_start() does validate that the userspace
> values are correct. It will actually round up or down rather than
> returning -EINVAL. So if userspace sends the "150" for start charge,
> it will round it down to 95% (CHARGE_START_MAX) and then round it down
> further to the end charge value minus 5% (CHARGE_MIN_DIFF). This behavior
> matches what's documented in Documentation/ABI/testing/sysfs-class-power

Rounding value to the nearest supported value is correct (e.g. 99% to 95%)
and documented in that file.

But it is really correct to accept value -1% or 1000000%?

Now I have just opened the first driver platform/x86/asus-wmi.c which
implements this interface and it returns -EINVAL for value < 0 || value > 100.

> 
> > > > +
> > > > +	ret = dell_battery_set_custom_charge_start(start);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return size;
> > > > +}
> > > > +
> > > > +static ssize_t charge_control_end_threshold_show(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		char *buf)
> > > > +{
> > > > +	int end;
> > > > +
> > > > +	end = dell_battery_read(BAT_CUSTOM_CHARGE_END);
> > > > +	if (end < 0)
> > > > +		return end;
> > > > +
> > > > +	return sysfs_emit(buf, "%d\n", end);
> > > > +}
> > > > +
> > > > +static ssize_t charge_control_end_threshold_store(struct device *dev,
> > > > +		struct device_attribute *attr,
> > > > +		const char *buf, size_t size)
> > > > +{
> > > > +	int ret, end;
> > > > +
> > > > +	ret = kstrtouint(buf, 10, &end);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = dell_battery_set_custom_charge_end(end);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return size;
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RW(charge_control_start_threshold);
> > > > +static DEVICE_ATTR_RW(charge_control_end_threshold);
> > > > +static DEVICE_ATTR_RW(charge_type);
> > > > +
> > > > +static struct attribute *dell_battery_attrs[] = {
> > > > +	&dev_attr_charge_control_start_threshold.attr,
> > > > +	&dev_attr_charge_control_end_threshold.attr,
> > > > +	&dev_attr_charge_type.attr,
> > > > +	NULL,
> > > > +};
> > > > +ATTRIBUTE_GROUPS(dell_battery);
> > > > +
> > > > +static int dell_battery_add(struct power_supply *battery,
> > > > +		struct acpi_battery_hook *hook)
> > > > +{
> > > > +	return device_add_groups(&battery->dev, dell_battery_groups);
> > > > +}
> > > > +
> > > > +static int dell_battery_remove(struct power_supply *battery,
> > > > +		struct acpi_battery_hook *hook)
> > > > +{
> > > > +	device_remove_groups(&battery->dev, dell_battery_groups);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static struct acpi_battery_hook dell_battery_hook = {
> > > > +	.add_battery = dell_battery_add,
> > > > +	.remove_battery = dell_battery_remove,
> > > > +	.name = "Dell Primary Battery Extension",
> > > > +};
> > > > +
> > > > +static u32 __init battery_get_supported_modes(void)
> > > > +{
> > > > +	u32 modes = 0;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > > +		if (dell_smbios_find_token(battery_modes[i].token))
> > > > +			modes |= BIT(i);
> > > > +	}
> > > > +
> > > > +	return modes;
> > > > +}
> > > > +
> > > > +static void __init dell_battery_init(struct device *dev)
> > > > +{
> > > > +	battery_supported_modes = battery_get_supported_modes();
> > > > +
> > > > +	if (battery_supported_modes != 0)
> > > > +		battery_hook_register(&dell_battery_hook);  
> > > 
> > > Anyway, how is this battery_hook_register() suppose to work on systems
> > > with multiple batteries? The provided API is only for the primary
> > > battery, but on older Dell laptop it was possible to connect up to
> > > 3 batteries. Would not this case some issues?
> 
> This interface is _only_ for controlling charging of the primary battery.
> In theory, it should hopefully ignore any other batteries, which would
> need to have their settings changed in the BIOS or with a special tool or
> whatever.

That is OK. But where it is specified that the hook is being registered
only for the primary battery? Because from the usage it looks like that
the hook is applied either for all batteries present in the system or
for some one arbitrary chosen battery.

> However, I'm basing that assumption on the SMBIOS interface. These tokens
> are marked "Primary Battery". There are separate tokens marked "Battery
> Slice", which from my understanding was an older type of battery that

From SMBIOS perspective it is clear, each battery seems to have its own
tokens.

The issue here is: how to tell kernel that the particular
dell_battery_hook has to be bound with the primary battery?

> plugged into the docking port on old E* series Latitudes:
> https://dl.dell.com/manuals/all-products/esuprt_laptop/esuprt_latitude_laptop/latitude-e5420_user's%20guide_en-us.pdf
> There are also separate tokens marked "Dock Battery", which control
> charging behavior for batteries that are.. part of the dock? It's
> unclear, and I don't have the hardware.

IIRC both "Dock Battery" and "Slice Battery" means battery type
connected to the connector on the bottom of the laptop. Same connector
is used for connecting laptop to dock. As different models had different
type of connector, probably also different name for battery were used.

And there was also another "Media Bay" battery which was being connected
to the slot where was normally either optical drive or second HDD.

> So I'm pretty comfortable with the assumption that this charging
> control interface will ignore all batteries other than the primary
> battery.

The SMBIOS code will ignore for sure.

But would not the battery_hook_register() function hook the SMBIOS
interface to the "wrong" battery?

> Of course, more testing would be great, and I haven't personally
> dealt with multiple batteries.
> 
> 
> 
> > > 
> > > I have one Dell laptop which has an option to connect secondary
> > > battery, but I do not have the compatible secondary battery to test it.
> 
> How does it connect? Is the interface one of the types that I mentioned
> above (slice & dock), or a different type?

Via bottom connector. So it is either slice or dock, do not know
exactly as I do not have that battery.

> 
> > > 
> > > Has somebody Dell laptop with 2 or 3 batteries? It would be really good
> > > to test this patch how it would behave...
> 
> Agreed.
> 
> 
> > >   
> > > > +}
> > > > +
> > > > +static void __exit dell_battery_exit(void)
> > > > +{
> > > > +	if (battery_supported_modes != 0)
> > > > +		battery_hook_unregister(&dell_battery_hook);
> > > > +}
> > > > +
> > > >  static int __init dell_init(void)
> > > >  {
> > > >  	struct calling_interface_token *token;
> > > > @@ -2219,6 +2504,7 @@ static int __init dell_init(void)
> > > >  		touchpad_led_init(&platform_device->dev);
> > > >  
> > > >  	kbd_led_init(&platform_device->dev);
> > > > +	dell_battery_init(&platform_device->dev);
> > > >  
> > > >  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
> > > >  	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > > > @@ -2293,6 +2579,7 @@ static int __init dell_init(void)
> > > >  	if (mute_led_registered)
> > > >  		led_classdev_unregister(&mute_led_cdev);
> > > >  fail_led:
> > > > +	dell_battery_exit();
> > > >  	dell_cleanup_rfkill();
> > > >  fail_rfkill:
> > > >  	platform_device_del(platform_device);
> > > > @@ -2311,6 +2598,7 @@ static void __exit dell_exit(void)
> > > >  	if (quirks && quirks->touchpad_led)
> > > >  		touchpad_led_exit();
> > > >  	kbd_led_exit();
> > > > +	dell_battery_exit();
> > > >  	backlight_device_unregister(dell_backlight_device);
> > > >  	if (micmute_led_registered)
> > > >  		led_classdev_unregister(&micmute_led_cdev);
> > > > diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> > > > index ea0cc38642a2..77baa15eb523 100644
> > > > --- a/drivers/platform/x86/dell/dell-smbios.h
> > > > +++ b/drivers/platform/x86/dell/dell-smbios.h
> > > > @@ -33,6 +33,13 @@
> > > >  #define KBD_LED_AUTO_50_TOKEN	0x02EB
> > > >  #define KBD_LED_AUTO_75_TOKEN	0x02EC
> > > >  #define KBD_LED_AUTO_100_TOKEN	0x02F6
> > > > +#define BAT_PRI_AC_MODE_TOKEN	0x0341
> > > > +#define BAT_ADAPTIVE_MODE_TOKEN	0x0342
> > > > +#define BAT_CUSTOM_MODE_TOKEN	0x0343
> > > > +#define BAT_STANDARD_MODE_TOKEN	0x0346
> > > > +#define BAT_EXPRESS_MODE_TOKEN	0x0347  
> > > 
> > > There is defined also tokenid 0x0348 which is per dell libsmbios's
> > > token_list.csv documentation also for custom mode. It is marked as
> > > deprecated, so seems that it is for old laptops, which do not support
> > > tokenid 0x0343.
> > > 
> > > What about defining '#define BAT_CUSTOM_OLD_MODE_TOKEN 0x0348', then
> > > adding '{ BAT_CUSTOM_OLD_MODE_TOKEN, "custom" }' into battery_modes and
> > > changing battery_get_supported_modes() to mask out custom_old bit when
> > > the normal custom is supported? Seems that it would be OK, just the
> > > charge_type_store() needs modification as written above.
> > > 
> > > Just an idea. What do you think?
> > >   
> 
> Generally, I'm nervous about touching stuff like that that I can't
> personally test. I don't know if 0348 works the same way as 0343, and
> the libsmbios code that added 0343 usage
> (<https://github.com/dell/libsmbios/commit/0eab0085e8f0db3c2a0f8ae0146d3352c40d785a>)
> never actually used 0348 previously. Or, it could be that 0348 was
> deprecated due to buggy semantics or implementation. I just don't
> know.
> 
> If there's old code or documentation somewhere that shows how 0348
> worked, and it turns out to be similar to 0343, then I wouldn't be
> opposed to adding BAT_CUSTOM_OLD_MODE_TOKEN and checking for it.
> However, without any kind of example, I'd prefer to just ignore it
> and only support custom mode charging on machines that have 0343.
> My 10yo Latitude has 0343, so I suspect that we're targeting the vast
> majority of (still working) hardware with 0343.

Ok, I think that for now let it as is.

It can be extended in the future after proper inspection. That mentioned
dell commit does not contain any useful information about it.

> 
> > > > +#define BAT_CUSTOM_CHARGE_START	0x0349
> > > > +#define BAT_CUSTOM_CHARGE_END	0x034A
> > > >  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
> > > >  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
> > > >  #define GLOBAL_MUTE_ENABLE	0x058C
> > > > -- 
> > > > 2.39.2
> > > > 
> > > > 
> > > > 
> > > > 
> > > > -- 
> > > > I'm available for contract & employment work, see:
> > > > https://spindle.queued.net/~dilinger/resume-tech.pdf  
> 
> 
> 
> -- 
> I'm available for contract & employment work, see:
> https://spindle.queued.net/~dilinger/resume-tech.pdf

