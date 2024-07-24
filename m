Return-Path: <linux-pm+bounces-11378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2A93B91C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 00:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4704D281F56
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157613C8F3;
	Wed, 24 Jul 2024 22:23:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147E13C9B3;
	Wed, 24 Jul 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859812; cv=none; b=DxyQ6lbc1Jzj9Jkv9j9aa1q6poBOL7KtxhVcW7IlISNZyspsuKyURq3i6ixoRiqFz3PvGSvym/EaDAAlWyT3e4v67sKBgMyYQw3YgnEsEUciAgg83Cfc5zLRiSy8rHmMflEmbxHqCEFZprEoWvYaQZA4Cf6BvaDSZiaHHF+MM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859812; c=relaxed/simple;
	bh=w3FS5N4QOgDe9Ot1FXaem/Hk6NATxIUkRh2aDuO3aP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9WYKF7G0mzQxh76vsndfnIS0tpVU0wKvI4xLa81gxGUo3lrcjyu2LiF3m1nSNOR3VVzXJ8RA4jGDK2kGCJ55dF/QwFW+hCSc4uWvS3zng0WBuocWZi6iDsV4GBdlVL1FnFE9N16T2LdjaPFKxR11o/gZQP2lAQ+NsPJ3cI/Nzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id C4482115A39; Wed, 24 Jul 2024 18:23:24 -0400 (EDT)
Received: from 5400 (unknown [172.56.164.186])
	by spindle.queued.net (Postfix) with ESMTPSA id 8063E10F64C;
	Wed, 24 Jul 2024 18:23:23 -0400 (EDT)
Date: Wed, 24 Jul 2024 18:23:18 -0400
From: Andres Salomon <dilinger@queued.net>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Matthew Garrett <mjg59@srcf.ucam.org>, Sebastian Reichel <sre@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240724182318.66578a48@5400>
In-Reply-To: <20240724204523.xb6rp7ba6yqi5klt@pali>
References: <20240723220502.77cb0401@5400>
	<20240724203403.zcrx2lshbla3o2gp@pali>
	<20240724204523.xb6rp7ba6yqi5klt@pali>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On Wed, 24 Jul 2024 22:45:23 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Wednesday 24 July 2024 22:34:03 Pali Roh=C3=A1r wrote:
> > Hello, the driver change looks good. I have just few minor comments for
> > this change below.
> >=20
> > Anyway, if there is somebody on the list with Dell laptop with 2 or 3
> > batteries, see below, it would be nice to check how such laptop would
> > behave with this patch. It does not seem that patch should cause
> > regression but always it is better to do testing if it is possible.
> >=20
> > On Tuesday 23 July 2024 22:05:02 Andres Salomon wrote: =20
[...]
> And because CLASS_TOKEN_WRITE is being repeated, what about defining
> something like this?
>=20
>     static inline int dell_set_token_value(struct calling_interface_buffe=
r *buffer, u16 class, u16 tokenid, u32 value)
>     {
>         dell_send_request_for_tokenid(buffer, class, CLASS_TOKEN_WRITE, t=
okenid, value);
>     }
>=20
> Just an idea. Do you think that it could be useful in second patch?
>=20

Let me implement the other changes first and then take a look.

> > > +
> > > +static int dell_battery_set_custom_charge_start(int start)
> > > +{
> > > +	struct calling_interface_buffer buffer;
> > > +	int end;
> > > +
> > > +	if (start < CHARGE_START_MIN)
> > > +		start =3D CHARGE_START_MIN;
> > > +	else if (start > CHARGE_START_MAX)
> > > +		start =3D CHARGE_START_MAX;
> > > +
> > > +	end =3D dell_battery_read(BAT_CUSTOM_CHARGE_END);
> > > +	/* a failed read is okay */ =20
> >=20
> > Why is failed read okay? It sounds strange if we ignore firmware errors.
> > I think that if reading the custom charge value is failing we should not
> > continue and trying to set/change custom charge value.

Because the check itself is simply a sanity check to ensure that the
start value is not larger than then end value. I thought that if it fails,
it's not a big deal; the sanity check originally wasn't even there.

However, you're right that if we're failing to communicate w/ SMBIOS,
that likely indicates a bigger problem and we probably shouldn't
continue.



> >=20
> > Also if the returned value is above 100 (%), should be continue?

Right, I'd forgotten that we shouldn't trust a BIOS. :)


> >  =20
> > > +	if (end < 0)
> > > +		end =3D CHARGE_END_MAX;
> > > +	if ((end - start) < CHARGE_MIN_DIFF) =20
> >=20
> > nit: I'm not sure what is the correct coding style for kernel drivers
> > but I thought that parenthesis around (end - start) are not being
> > written.
> >  =20
> > > +		start =3D end - CHARGE_MIN_DIFF;
> > > +
> > > +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> > > +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_START, start);
> > > +}
> > > +
> > > +static int dell_battery_set_custom_charge_end(int end)
> > > +{
> > > +	struct calling_interface_buffer buffer;
> > > +	int start;
> > > +
> > > +	if (end < CHARGE_END_MIN)
> > > +		end =3D CHARGE_END_MIN;
> > > +	else if (end > CHARGE_END_MAX)
> > > +		end =3D CHARGE_END_MAX;
> > > +
> > > +	start =3D dell_battery_read(BAT_CUSTOM_CHARGE_START);
> > > +	/* a failed read is okay */
> > > +	if (start < 0)
> > > +		start =3D CHARGE_START_MIN;
> > > +	if ((end - start) < CHARGE_MIN_DIFF)
> > > +		end =3D start + CHARGE_MIN_DIFF;
> > > +
> > > +	return dell_send_request_by_token_loc(&buffer, CLASS_TOKEN_WRITE,
> > > +			SELECT_TOKEN_STD, BAT_CUSTOM_CHARGE_END, end);
> > > +}
> > > +
> > > +static ssize_t charge_type_show(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		char *buf)
> > > +{
> > > +	ssize_t count =3D 0;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > +		bool active;
> > > +
> > > +		if (!(battery_supported_modes & BIT(i)))
> > > +			continue;
> > > +
> > > +		active =3D dell_battery_mode_is_active(battery_modes[i].token);
> > > +		count +=3D sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> > > +				battery_modes[i].label);
> > > +	}
> > > +
> > > +	/* convert the last space to a newline */
> > > +	if (count > 0)
> > > +		count--;
> > > +	count +=3D sysfs_emit_at(buf, count, "\n");
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +static ssize_t charge_type_store(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		const char *buf, size_t size)
> > > +{
> > > +	bool matched =3D false;
> > > +	int err, i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) { =20
> >=20
> > nit: Personally I would put the "if (!(battery_supported_modes & BIT(i)=
))"
> > check here with continue, to have same pattern in _show and _store
> > functions. And also if we want to support battery mode which will have
> > different tokens on different machines (see below for possibility).
> >  =20

Certainly for possible future cases; yeah, it's smarter to handle modes with
conflicting names.


> > > +		if (sysfs_streq(battery_modes[i].label, buf)) {
> > > +			matched =3D true;
> > > +			break;
> > > +		}
> > > +	}
> > > +	if (!matched || !(battery_supported_modes & BIT(i)))
> > > +		return -EINVAL;
> > > +
> > > +	err =3D dell_battery_set_mode(battery_modes[i].token);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	return size;
> > > +}
> > > +
> > > +static ssize_t charge_control_start_threshold_show(struct device *de=
v,
> > > +		struct device_attribute *attr,
> > > +		char *buf)
> > > +{
> > > +	int start;
> > > +
> > > +	start =3D dell_battery_read(BAT_CUSTOM_CHARGE_START);
> > > +	if (start < 0)
> > > +		return start; =20
> >=20
> > IIRC the value is in percentage. So we should also check that returned
> > value is not above 100 (and return some error in case).
> >  =20
> > > +
> > > +	return sysfs_emit(buf, "%d\n", start);
> > > +}
> > > +
> > > +static ssize_t charge_control_start_threshold_store(struct device *d=
ev,
> > > +		struct device_attribute *attr,
> > > +		const char *buf, size_t size)
> > > +{
> > > +	int ret, start;
> > > +
> > > +	ret =3D kstrtoint(buf, 10, &start);
> > > +	if (ret)
> > > +		return ret; =20
> >=20
> > I think that there should be some sanity validation. If format is
> > percentage then we should not accept from userspace value outside of
> > [0, 100] range.
> >  =20

dell_battery_set_custom_charge_start() does validate that the userspace
values are correct. It will actually round up or down rather than
returning -EINVAL. So if userspace sends the "150" for start charge,
it will round it down to 95% (CHARGE_START_MAX) and then round it down
further to the end charge value minus 5% (CHARGE_MIN_DIFF). This behavior
matches what's documented in Documentation/ABI/testing/sysfs-class-power


> > > +
> > > +	ret =3D dell_battery_set_custom_charge_start(start);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return size;
> > > +}
> > > +
> > > +static ssize_t charge_control_end_threshold_show(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		char *buf)
> > > +{
> > > +	int end;
> > > +
> > > +	end =3D dell_battery_read(BAT_CUSTOM_CHARGE_END);
> > > +	if (end < 0)
> > > +		return end;
> > > +
> > > +	return sysfs_emit(buf, "%d\n", end);
> > > +}
> > > +
> > > +static ssize_t charge_control_end_threshold_store(struct device *dev,
> > > +		struct device_attribute *attr,
> > > +		const char *buf, size_t size)
> > > +{
> > > +	int ret, end;
> > > +
> > > +	ret =3D kstrtouint(buf, 10, &end);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D dell_battery_set_custom_charge_end(end);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return size;
> > > +}
> > > +
> > > +static DEVICE_ATTR_RW(charge_control_start_threshold);
> > > +static DEVICE_ATTR_RW(charge_control_end_threshold);
> > > +static DEVICE_ATTR_RW(charge_type);
> > > +
> > > +static struct attribute *dell_battery_attrs[] =3D {
> > > +	&dev_attr_charge_control_start_threshold.attr,
> > > +	&dev_attr_charge_control_end_threshold.attr,
> > > +	&dev_attr_charge_type.attr,
> > > +	NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(dell_battery);
> > > +
> > > +static int dell_battery_add(struct power_supply *battery,
> > > +		struct acpi_battery_hook *hook)
> > > +{
> > > +	return device_add_groups(&battery->dev, dell_battery_groups);
> > > +}
> > > +
> > > +static int dell_battery_remove(struct power_supply *battery,
> > > +		struct acpi_battery_hook *hook)
> > > +{
> > > +	device_remove_groups(&battery->dev, dell_battery_groups);
> > > +	return 0;
> > > +}
> > > +
> > > +static struct acpi_battery_hook dell_battery_hook =3D {
> > > +	.add_battery =3D dell_battery_add,
> > > +	.remove_battery =3D dell_battery_remove,
> > > +	.name =3D "Dell Primary Battery Extension",
> > > +};
> > > +
> > > +static u32 __init battery_get_supported_modes(void)
> > > +{
> > > +	u32 modes =3D 0;
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> > > +		if (dell_smbios_find_token(battery_modes[i].token))
> > > +			modes |=3D BIT(i);
> > > +	}
> > > +
> > > +	return modes;
> > > +}
> > > +
> > > +static void __init dell_battery_init(struct device *dev)
> > > +{
> > > +	battery_supported_modes =3D battery_get_supported_modes();
> > > +
> > > +	if (battery_supported_modes !=3D 0)
> > > +		battery_hook_register(&dell_battery_hook); =20
> >=20
> > Anyway, how is this battery_hook_register() suppose to work on systems
> > with multiple batteries? The provided API is only for the primary
> > battery, but on older Dell laptop it was possible to connect up to
> > 3 batteries. Would not this case some issues?

This interface is _only_ for controlling charging of the primary battery.
In theory, it should hopefully ignore any other batteries, which would
need to have their settings changed in the BIOS or with a special tool or
whatever.

However, I'm basing that assumption on the SMBIOS interface. These tokens
are marked "Primary Battery". There are separate tokens marked "Battery
Slice", which from my understanding was an older type of battery that
plugged into the docking port on old E* series Latitudes:
https://dl.dell.com/manuals/all-products/esuprt_laptop/esuprt_latitude_lapt=
op/latitude-e5420_user's%20guide_en-us.pdf
There are also separate tokens marked "Dock Battery", which control
charging behavior for batteries that are.. part of the dock? It's
unclear, and I don't have the hardware.

So I'm pretty comfortable with the assumption that this charging
control interface will ignore all batteries other than the primary
battery.

Of course, more testing would be great, and I haven't personally
dealt with multiple batteries.



> >=20
> > I have one Dell laptop which has an option to connect secondary
> > battery, but I do not have the compatible secondary battery to test it.

How does it connect? Is the interface one of the types that I mentioned
above (slice & dock), or a different type?


> >=20
> > Has somebody Dell laptop with 2 or 3 batteries? It would be really good
> > to test this patch how it would behave...

Agreed.


> >  =20
> > > +}
> > > +
> > > +static void __exit dell_battery_exit(void)
> > > +{
> > > +	if (battery_supported_modes !=3D 0)
> > > +		battery_hook_unregister(&dell_battery_hook);
> > > +}
> > > +
> > >  static int __init dell_init(void)
> > >  {
> > >  	struct calling_interface_token *token;
> > > @@ -2219,6 +2504,7 @@ static int __init dell_init(void)
> > >  		touchpad_led_init(&platform_device->dev);
> > > =20
> > >  	kbd_led_init(&platform_device->dev);
> > > +	dell_battery_init(&platform_device->dev);
> > > =20
> > >  	dell_laptop_dir =3D debugfs_create_dir("dell_laptop", NULL);
> > >  	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> > > @@ -2293,6 +2579,7 @@ static int __init dell_init(void)
> > >  	if (mute_led_registered)
> > >  		led_classdev_unregister(&mute_led_cdev);
> > >  fail_led:
> > > +	dell_battery_exit();
> > >  	dell_cleanup_rfkill();
> > >  fail_rfkill:
> > >  	platform_device_del(platform_device);
> > > @@ -2311,6 +2598,7 @@ static void __exit dell_exit(void)
> > >  	if (quirks && quirks->touchpad_led)
> > >  		touchpad_led_exit();
> > >  	kbd_led_exit();
> > > +	dell_battery_exit();
> > >  	backlight_device_unregister(dell_backlight_device);
> > >  	if (micmute_led_registered)
> > >  		led_classdev_unregister(&micmute_led_cdev);
> > > diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platfo=
rm/x86/dell/dell-smbios.h
> > > index ea0cc38642a2..77baa15eb523 100644
> > > --- a/drivers/platform/x86/dell/dell-smbios.h
> > > +++ b/drivers/platform/x86/dell/dell-smbios.h
> > > @@ -33,6 +33,13 @@
> > >  #define KBD_LED_AUTO_50_TOKEN	0x02EB
> > >  #define KBD_LED_AUTO_75_TOKEN	0x02EC
> > >  #define KBD_LED_AUTO_100_TOKEN	0x02F6
> > > +#define BAT_PRI_AC_MODE_TOKEN	0x0341
> > > +#define BAT_ADAPTIVE_MODE_TOKEN	0x0342
> > > +#define BAT_CUSTOM_MODE_TOKEN	0x0343
> > > +#define BAT_STANDARD_MODE_TOKEN	0x0346
> > > +#define BAT_EXPRESS_MODE_TOKEN	0x0347 =20
> >=20
> > There is defined also tokenid 0x0348 which is per dell libsmbios's
> > token_list.csv documentation also for custom mode. It is marked as
> > deprecated, so seems that it is for old laptops, which do not support
> > tokenid 0x0343.
> >=20
> > What about defining '#define BAT_CUSTOM_OLD_MODE_TOKEN 0x0348', then
> > adding '{ BAT_CUSTOM_OLD_MODE_TOKEN, "custom" }' into battery_modes and
> > changing battery_get_supported_modes() to mask out custom_old bit when
> > the normal custom is supported? Seems that it would be OK, just the
> > charge_type_store() needs modification as written above.
> >=20
> > Just an idea. What do you think?
> >  =20

Generally, I'm nervous about touching stuff like that that I can't
personally test. I don't know if 0348 works the same way as 0343, and
the libsmbios code that added 0343 usage
(<https://github.com/dell/libsmbios/commit/0eab0085e8f0db3c2a0f8ae0146d3352=
c40d785a>)
never actually used 0348 previously. Or, it could be that 0348 was
deprecated due to buggy semantics or implementation. I just don't
know.

If there's old code or documentation somewhere that shows how 0348
worked, and it turns out to be similar to 0343, then I wouldn't be
opposed to adding BAT_CUSTOM_OLD_MODE_TOKEN and checking for it.
However, without any kind of example, I'd prefer to just ignore it
and only support custom mode charging on machines that have 0343.
My 10yo Latitude has 0343, so I suspect that we're targeting the vast
majority of (still working) hardware with 0343.


> > > +#define BAT_CUSTOM_CHARGE_START	0x0349
> > > +#define BAT_CUSTOM_CHARGE_END	0x034A
> > >  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
> > >  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
> > >  #define GLOBAL_MUTE_ENABLE	0x058C
> > > --=20
> > > 2.39.2
> > >=20
> > >=20
> > >=20
> > >=20
> > > --=20
> > > I'm available for contract & employment work, see:
> > > https://spindle.queued.net/~dilinger/resume-tech.pdf =20



--=20
I'm available for contract & employment work, see:
https://spindle.queued.net/~dilinger/resume-tech.pdf

