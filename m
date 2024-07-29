Return-Path: <linux-pm+bounces-11561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5697593FB9C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8ADAB21C52
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5F1154C15;
	Mon, 29 Jul 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mLka5y9y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B682139CEF;
	Mon, 29 Jul 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271339; cv=none; b=e33gXXLGKDSma7BOQbSTGbm5LaLgKUjbV/hvfHDGy9roGqXIk6+VMZGJpSsiWwtjCxPueQVCws3TDnNDQEg+cTuIsIlMjpw1dc6FyeraYIyndzoVOkp1iCCwv1BX0zonY3ot9ryG5tu7IRE+5a+csIxz6HD1MApP9/q2sTDwVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271339; c=relaxed/simple;
	bh=GsXvKYsAzdhPVP57nb1phSkTRV9dKz6Qla9TaZ/rFNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSkSFkd+IDpUHnXSgLXFBHAWor1ItiWOQ5Im/mve14rLUOYH/LxN6XQ+13pxm9a4o0bUBvt1c3XUg6Ohw+tvW5OJFPSzrwF8+l/lYoY9ugaKqH/D2PJqdwvv2rXMmR72Qz/MS8HZ/d2RQwNrtKj+Hl5/mCL46yp0QftRhkjZPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mLka5y9y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722271306; x=1722876106; i=w_armin@gmx.de;
	bh=+vSVPe9z8N9hx8N4/gpwQU7odRGbYIVPxD4eq0N8ONs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mLka5y9yt7eVrvEleIImx5fEUiCPlOItPiIIhBSjhXVkKw/spE/HWgIweVU8zzmQ
	 iUuzj4zGVPAVn5z9Tin1sOGvhyZTJ+Y/kquoyupM5ky1p6Zoh9DOfiez/q014bFyB
	 xdxdbDqkFyGtlb//VvGr+CEFdXDSuBZ14orUh4cvPP06Q8ebde4cow+k49DX/a4uI
	 YfUAWEe66LfVZMl9aZxLKJnoWPsj/uhxrLB2m7u/s9TspH+0AuaR810VCPUUTISeQ
	 ZFuf7y5ptEp3gW7nkydHyv/a3cNlOAE7SQ1LsrVXqTBLq+chDoirfW9KFll+wLdNT
	 PEGqdisy6nXNgsVzNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1run7K1Alk-00eUGe; Mon, 29
 Jul 2024 18:41:46 +0200
Message-ID: <c11ba6f5-5e7d-463d-9b1a-d2e56de21af9@gmx.de>
Date: Mon, 29 Jul 2024 18:41:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86:dell-laptop: Add knobs to change battery
 charge settings
To: Hans de Goede <hdegoede@redhat.com>, Andres Salomon
 <dilinger@queued.net>, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240720012220.26d62a54@5400>
 <148efb2f-ef26-4759-98d3-5f6687c3cf12@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <148efb2f-ef26-4759-98d3-5f6687c3cf12@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0remDjtmgzN1r9i7i2fG3t2JvejBCABaUj27f0dC+Ui++cPpTvq
 d2vz2g3KTeYshGf1qKygqs9bem0xsYVXlcQncq15Z+cFN8Jsbk+/MNUMNiJIOqcLLcFWS8o
 I32NukuUygOW9672EGXE/pHVmjSoA8kpyhFkN0AwEYFKa0vxcBa3itkvq057YmVt76eIqrx
 Yc1Dau5vKNsYjsdvHgyQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WFj7f0XtrkU=;1B03EhG1U5GolDvPWmWlLnzBljV
 afzvbuP1r78l8ht3oye7X59SfUhp+eth24ZSbsN66rfLn7UqHxKqVUZ6GwZRDLDS6EjyhfEhR
 XfBqXjITBOV5nCY9VoJ5ngqUbKkXFiCCT6NFB7o71PtZHLEhuPHns6Dc5AeIRJINepcvBaTdL
 aQSTAeeIZ0pRtTpoK2auphmZOHn+qfJWV/uKWeQfF10PbvhCHuA/+s40np9imOOX8XtghVdn5
 JXbSuyQKceUuFk0CDD/WIb+awVf7p7OI9UB45K0XhZGvSbRAZbX8BjdKvZttGcvN2Qfm6TdH3
 q4nVliVPGcKjbRfQQ2z2d4gQGXPAF4T5JV9wzrG4D4bJuryaiCQGqAro0sr6smHl25uCKikib
 a4g8oXdaYHMGdm8tmxLGMCIirUr4m522kgIuhK275xfpVIdCtHeLILmTSwLeuMxXBveczLg0z
 Zr/nujqIp2L1PCfbTVgz0nHhHHuOfkl2Um2uIvAO9BdjTnDOQhklfK+kEf/cPMrf4u9p0MCXu
 Jbxsi3pJBwf/G2ImCbep93NNP4tJ6e46wDXkTSJ++u7AiV8+IfGGARiFKBGqkncGx/apqC028
 mDpP+5cWVEz9hb20sMz3jr6jLHcD4imTd+FTe4kzygwzos/vv6s8SRHsJx8BdGdtPc0SPs1GY
 BgAj9JmtQ8HT4nK0oV58iAJ8uKORXaDEJyr/4BJd04gPZUky/v0PjFWX0dY3Z8uDin9Z+Tcbh
 7wR2+GqT2eYaVcNnVjNYRZXUo+6wEcsmgYtKutHphXGbBzGGjPa/5Uxs48RdfFRXdoy65Eku6
 bKx8vkExgjXFjlAYlaMMmicA==

Am 29.07.24 um 12:02 schrieb Hans de Goede:

> Hi,
>
> On 7/20/24 7:22 AM, Andres Salomon wrote:
>> The Dell BIOS allows you to set custom charging modes, which is useful
>> in particular for extending battery life. This adds support for tweakin=
g
>> those various settings from Linux via sysfs knobs. One might, for
>> example, have their laptop plugged into power at their desk the vast
>> majority of the time and choose fairly aggressive battery-saving
>> settings (only charging once the battery drops to 50% and only charging
>> up to 80%). When leaving for a trip, they might want to switch those
>> settings to charge to 100% and charge any time power is available;
>> rebooting into the BIOS to change those settings is a hassle.
>>
>> For the Custom charging type mode, we reuse the common
>> charge_control_{start,end}_threshold sysfs power_supply entries. The
>> BIOS also has a bunch of other charging modes with varying levels of
>> usefulness, so this adds a new Dell-specific sysfs entry called
>> 'charge_type' that's documented in sysfs-class-power-dell (and looks a
>> lot like sysfs-class-power-wilco).
>>
>> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
>> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:
>> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
>> Both of their email addresses bounce, so I'm assuming they're no longer
>> with the company. I've reworked most of the patch to make it smaller an=
d
>> cleaner.
>>
>> Signed-off-by: Andres Salomon <dilinger@queued.net>
> Thank you for working on this and it is great to see the discussion
> to improve the code between you and Pali going on.
>
> One concern which I have is that work is underway for both upower
> and GNOME to add support for
> /sys/class/power_supply/*/charge_[start|stop]_threshold
>
> to gnome-control-center.
>
> But if I understand things correctly then these limits will only
> be honored when the charging-type is set to custom.
>
> So we need to do something to avoid userspace exposing those
> controls when the charging-type is not custom.
>
> I think it would be best to not have the charge_[start|stop]_threshold
> attributes visible when the charging mode is not custom.
>
> Regards,
>
> Hans

Hi,

the documentation of the "charge_type" sysfs attribute states that:

	"Custom" means that the charger uses the charge_control_* properties as
	 configuration for some different algorithm.

So i believe that "charge_[start|stop]_threshold" attributes should not be=
 unregistered
if "charge_type" is not "Custom" because:

1. The power supply subsystem does not allow that for power supplies, and =
i see little
reason to deviate from this behavior here.

2. It is the responsibility of userspace to also set "charge_type" to "Cus=
tom" when using
the "charge_[start|stop]_threshold" attributes.

Maybe we could clarify what happens when "charge_[start|stop]_threshold" i=
s written without
"charge_type" being "Custom". This might help userspace to correctly switc=
h to custom charging
and set the charging thresholds.

Basically, we could define that writes to "charge_[start|stop]_threshold" =
will get buffered by
the driver if two conditions are met:

1. "charge_type" is not "Custom".

2. The hardware does not support setting the charging thresholds when "cha=
rge_type" is not "Custom".

Userspace can then first set "charge_[start|stop]_threshold" and then swit=
ch to custom charging.
This prevents any problems should the hardware have no default value for t=
he charging thresholds
when switching to custom charging for the first time.

Thanks,
Armin Wolf

>> ---
>>   .../ABI/testing/sysfs-class-power-dell        |  31 +++
>>   drivers/platform/x86/dell/Kconfig             |   1 +
>>   drivers/platform/x86/dell/dell-laptop.c       | 263 +++++++++++++++++=
+
>>   drivers/platform/x86/dell/dell-smbios.h       |  17 ++
>>   4 files changed, 312 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-power-dell
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power-dell b/Documen=
tation/ABI/testing/sysfs-class-power-dell
>> new file mode 100644
>> index 000000000000..ef72c5f797ce
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-power-dell
>> @@ -0,0 +1,31 @@
>> +What:		/sys/class/power_supply/<supply_name>/charge_type
>> +Date:		July 2024
>> +KernelVersion:	6.11
>> +Contact:	linux-pm@vger.kernel.org
>> +Description:
>> +		Select the charging algorithm to use for the (primary)
>> +		battery.
>> +
>> +		Standard:
>> +			Fully charge the battery at a moderate rate.
>> +		ExpressCharge=E2=84=A2:
>> +			Quickly charge the battery using fast-charge
>> +			technology. This is harder on the battery than
>> +			standard charging and may lower its lifespan.
>> +		Primarily AC Use:
>> +			Users who primarily operate the system while
>> +			plugged into an external power source can extend
>> +			battery life with this mode.
>> +		Adaptive:
>> +			Automatically optimize battery charge rate based
>> +			on typical usage.
>> +		Custom:
>> +			Use the charge_control_* properties to determine
>> +			when to start and stop charging. Advanced users
>> +			can use this to drastically extend battery life.
>> +
>> +		Access: Read, Write
>> +		Valid values:
>> +			      "standard", "express", "primarily_ac",
>> +			      "adaptive", "custom"
>> +
>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/d=
ell/Kconfig
>> index 85a78ef91182..02405793163c 100644
>> --- a/drivers/platform/x86/dell/Kconfig
>> +++ b/drivers/platform/x86/dell/Kconfig
>> @@ -49,6 +49,7 @@ config DELL_LAPTOP
>>   	default m
>>   	depends on DMI
>>   	depends on BACKLIGHT_CLASS_DEVICE
>> +	depends on ACPI_BATTERY
>>   	depends on ACPI_VIDEO || ACPI_VIDEO =3D n
>>   	depends on RFKILL || RFKILL =3D n
>>   	depends on DELL_WMI || DELL_WMI =3D n
>> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform=
/x86/dell/dell-laptop.c
>> index 6552dfe491c6..54f47b685a46 100644
>> --- a/drivers/platform/x86/dell/dell-laptop.c
>> +++ b/drivers/platform/x86/dell/dell-laptop.c
>> @@ -22,11 +22,13 @@
>>   #include <linux/io.h>
>>   #include <linux/rfkill.h>
>>   #include <linux/power_supply.h>
>> +#include <linux/sysfs.h>
>>   #include <linux/acpi.h>
>>   #include <linux/mm.h>
>>   #include <linux/i8042.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/seq_file.h>
>> +#include <acpi/battery.h>
>>   #include <acpi/video.h>
>>   #include "dell-rbtn.h"
>>   #include "dell-smbios.h"
>> @@ -98,6 +100,14 @@ static struct rfkill *wwan_rfkill;
>>   static bool force_rfkill;
>>   static bool micmute_led_registered;
>>   static bool mute_led_registered;
>> +static enum battery_charging_mode bat_chg_current =3D DELL_BAT_MODE_NO=
NE;
>> +static const char * const battery_state[DELL_BAT_MODE_MAX] =3D {
>> +	[DELL_BAT_MODE_STANDARD] =3D "standard",
>> +	[DELL_BAT_MODE_EXPRESS] =3D "express",
>> +	[DELL_BAT_MODE_PRIMARILY_AC] =3D "primarily_ac",
>> +	[DELL_BAT_MODE_ADAPTIVE] =3D "adaptive",
>> +	[DELL_BAT_MODE_CUSTOM] =3D "custom",
>> +};
>>
>>   module_param(force_rfkill, bool, 0444);
>>   MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted mode=
ls");
>> @@ -2183,6 +2193,256 @@ static struct led_classdev mute_led_cdev =3D {
>>   	.default_trigger =3D "audio-mute",
>>   };
>>
>> +static int dell_battery_read_req(const int type, int *val)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	struct calling_interface_token *token;
>> +	int err;
>> +
>> +	token =3D dell_smbios_find_token(type);
>> +	if (!token)
>> +		return -ENODEV;
>> +
>> +	dell_fill_request(&buffer, token->location, 0, 0, 0);
>> +	err =3D dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD=
);
>> +	if (!err)
>> +		*val =3D buffer.output[1];
>> +
>> +	return err;
>> +}
>> +
>> +static int dell_battery_write_req(const int type, int val)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	struct calling_interface_token *token;
>> +
>> +	token =3D dell_smbios_find_token(type);
>> +	if (!token)
>> +		return -ENODEV;
>> +
>> +	dell_fill_request(&buffer, token->location, val, 0, 0);
>> +	return dell_send_request(&buffer,
>> +			CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
>> +}
>> +
>> +/* The rules: the minimum start charging value is 50%. The maximum
>> + * start charging value is 95%. The minimum end charging value is
>> + * 55%. The maximum end charging value is 100%. And finally, there
>> + * has to be at least a 5% difference between start & end values.
>> + */
>> +#define CHARGE_START_MIN	50
>> +#define CHARGE_START_MAX	95
>> +#define CHARGE_END_MIN		55
>> +#define CHARGE_END_MAX		100
>> +#define CHARGE_MIN_DIFF		5
>> +
>> +static int dell_battery_custom_set(const int type, int val)
>> +{
>> +	if (type =3D=3D BAT_CUSTOM_CHARGE_START) {
>> +		int end =3D CHARGE_END_MAX;
>> +
>> +		if (val < CHARGE_START_MIN)
>> +			val =3D CHARGE_START_MIN;
>> +		else if (val > CHARGE_START_MAX)
>> +			val =3D CHARGE_START_MAX;
>> +
>> +		dell_battery_read_req(BAT_CUSTOM_CHARGE_END, &end);
>> +		if ((end - val) < CHARGE_MIN_DIFF)
>> +			val =3D end - CHARGE_MIN_DIFF;
>> +	} else if (type =3D=3D BAT_CUSTOM_CHARGE_END) {
>> +		int start =3D CHARGE_START_MIN;
>> +
>> +		if (val < CHARGE_END_MIN)
>> +			val =3D CHARGE_END_MIN;
>> +		else if (val > CHARGE_END_MAX)
>> +			val =3D CHARGE_END_MAX;
>> +
>> +		dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
>> +		if ((val - start) < CHARGE_MIN_DIFF)
>> +			val =3D start + CHARGE_MIN_DIFF;
>> +	}
>> +
>> +	return dell_battery_write_req(type, val);
>> +}
>> +
>> +static int battery_charging_mode_set(enum battery_charging_mode mode)
>> +{
>> +	int err;
>> +
>> +	switch (mode) {
>> +	case DELL_BAT_MODE_STANDARD:
>> +		err =3D dell_battery_write_req(BAT_STANDARD_MODE_TOKEN, mode);
>> +		break;
>> +	case DELL_BAT_MODE_EXPRESS:
>> +		err =3D dell_battery_write_req(BAT_EXPRESS_MODE_TOKEN, mode);
>> +		break;
>> +	case DELL_BAT_MODE_PRIMARILY_AC:
>> +		err =3D dell_battery_write_req(BAT_PRI_AC_MODE_TOKEN, mode);
>> +		break;
>> +	case DELL_BAT_MODE_ADAPTIVE:
>> +		err =3D dell_battery_write_req(BAT_ADAPTIVE_MODE_TOKEN, mode);
>> +		break;
>> +	case DELL_BAT_MODE_CUSTOM:
>> +		err =3D dell_battery_write_req(BAT_CUSTOM_MODE_TOKEN, mode);
>> +		break;
>> +	default:
>> +		err =3D -EINVAL;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static ssize_t charge_type_show(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	enum battery_charging_mode mode;
>> +	ssize_t count =3D 0;
>> +
>> +	for (mode =3D DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode+=
+) {
>> +		if (battery_state[mode]) {
>> +			count +=3D sysfs_emit_at(buf, count,
>> +				mode =3D=3D bat_chg_current ? "[%s] " : "%s ",
>> +				battery_state[mode]);
>> +		}
>> +	}
>> +
>> +	/* convert the last space to a newline */
>> +	count--;
>> +	count +=3D sysfs_emit_at(buf, count, "\n");
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t charge_type_store(struct device *dev,
>> +		struct device_attribute *attr,
>> +		const char *buf, size_t size)
>> +{
>> +	enum battery_charging_mode mode;
>> +	const char *label;
>> +	int ret =3D -EINVAL;
>> +
>> +	for (mode =3D DELL_BAT_MODE_STANDARD; mode < DELL_BAT_MODE_MAX; mode+=
+) {
>> +		label =3D battery_state[mode];
>> +		if (label && sysfs_streq(label, buf))
>> +			break;
>> +	}
>> +
>> +	if (mode > DELL_BAT_MODE_NONE && mode < DELL_BAT_MODE_MAX) {
>> +		ret =3D battery_charging_mode_set(mode);
>> +		if (!ret) {
>> +			bat_chg_current =3D mode;
>> +			ret =3D size;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t charge_control_start_threshold_show(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	int ret, start;
>> +
>> +	ret =3D dell_battery_read_req(BAT_CUSTOM_CHARGE_START, &start);
>> +	if (!ret)
>> +		ret =3D sysfs_emit(buf, "%d\n", start);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t charge_control_start_threshold_store(struct device *dev=
,
>> +		struct device_attribute *attr,
>> +		const char *buf, size_t size)
>> +{
>> +	int ret, start;
>> +
>> +	ret =3D kstrtoint(buf, 10, &start);
>> +	if (!ret)
>> +		ret =3D dell_battery_custom_set(BAT_CUSTOM_CHARGE_START, start);
>> +	if (!ret)
>> +		ret =3D size;
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t charge_control_end_threshold_show(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	int ret, end;
>> +
>> +	ret =3D dell_battery_read_req(BAT_CUSTOM_CHARGE_END, &end);
>> +	if (!ret)
>> +		ret =3D sysfs_emit(buf, "%d\n", end);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t charge_control_end_threshold_store(struct device *dev,
>> +		struct device_attribute *attr,
>> +		const char *buf, size_t size)
>> +{
>> +	int ret, end;
>> +
>> +	ret =3D kstrtouint(buf, 10, &end);
>> +	if (!ret)
>> +		ret =3D dell_battery_custom_set(BAT_CUSTOM_CHARGE_END, end);
>> +	if (!ret)
>> +		ret =3D size;
>> +
>> +	return ret;
>> +}
>> +
>> +static DEVICE_ATTR_RW(charge_control_start_threshold);
>> +static DEVICE_ATTR_RW(charge_control_end_threshold);
>> +static DEVICE_ATTR_RW(charge_type);
>> +
>> +static struct attribute *dell_battery_attrs[] =3D {
>> +	&dev_attr_charge_control_start_threshold.attr,
>> +	&dev_attr_charge_control_end_threshold.attr,
>> +	&dev_attr_charge_type.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(dell_battery);
>> +
>> +static int dell_battery_add(struct power_supply *battery,
>> +		struct acpi_battery_hook *hook)
>> +{
>> +	return device_add_groups(&battery->dev, dell_battery_groups);
>> +}
>> +
>> +static int dell_battery_remove(struct power_supply *battery,
>> +		struct acpi_battery_hook *hook)
>> +{
>> +	device_remove_groups(&battery->dev, dell_battery_groups);
>> +	return 0;
>> +}
>> +
>> +static struct acpi_battery_hook dell_battery_hook =3D {
>> +	.add_battery =3D dell_battery_add,
>> +	.remove_battery =3D dell_battery_remove,
>> +	.name =3D "Dell Primary Battery Extension",
>> +};
>> +
>> +static void __init dell_battery_init(struct device *dev)
>> +{
>> +	enum battery_charging_mode current_mode =3D DELL_BAT_MODE_NONE;
>> +
>> +	dell_battery_read_req(BAT_CUSTOM_MODE_TOKEN, (int *) &current_mode);
>> +	if (current_mode !=3D DELL_BAT_MODE_NONE) {
>> +		bat_chg_current =3D current_mode;
>> +		battery_hook_register(&dell_battery_hook);
>> +	}
>> +}
>> +
>> +static void __exit dell_battery_exit(void)
>> +{
>> +	if (bat_chg_current !=3D DELL_BAT_MODE_NONE)
>> +		battery_hook_unregister(&dell_battery_hook);
>> +}
>> +
>>   static int __init dell_init(void)
>>   {
>>   	struct calling_interface_token *token;
>> @@ -2219,6 +2479,7 @@ static int __init dell_init(void)
>>   		touchpad_led_init(&platform_device->dev);
>>
>>   	kbd_led_init(&platform_device->dev);
>> +	dell_battery_init(&platform_device->dev);
>>
>>   	dell_laptop_dir =3D debugfs_create_dir("dell_laptop", NULL);
>>   	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
>> @@ -2293,6 +2554,7 @@ static int __init dell_init(void)
>>   	if (mute_led_registered)
>>   		led_classdev_unregister(&mute_led_cdev);
>>   fail_led:
>> +	dell_battery_exit();
>>   	dell_cleanup_rfkill();
>>   fail_rfkill:
>>   	platform_device_del(platform_device);
>> @@ -2311,6 +2573,7 @@ static void __exit dell_exit(void)
>>   	if (quirks && quirks->touchpad_led)
>>   		touchpad_led_exit();
>>   	kbd_led_exit();
>> +	dell_battery_exit();
>>   	backlight_device_unregister(dell_backlight_device);
>>   	if (micmute_led_registered)
>>   		led_classdev_unregister(&micmute_led_cdev);
>> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform=
/x86/dell/dell-smbios.h
>> index ea0cc38642a2..f7c07b4d72e3 100644
>> --- a/drivers/platform/x86/dell/dell-smbios.h
>> +++ b/drivers/platform/x86/dell/dell-smbios.h
>> @@ -33,11 +33,28 @@
>>   #define KBD_LED_AUTO_50_TOKEN	0x02EB
>>   #define KBD_LED_AUTO_75_TOKEN	0x02EC
>>   #define KBD_LED_AUTO_100_TOKEN	0x02F6
>> +#define BAT_PRI_AC_MODE_TOKEN	0x0341
>> +#define BAT_ADAPTIVE_MODE_TOKEN	0x0342
>> +#define BAT_CUSTOM_MODE_TOKEN	0x0343
>> +#define BAT_STANDARD_MODE_TOKEN	0x0346
>> +#define BAT_EXPRESS_MODE_TOKEN	0x0347
>> +#define BAT_CUSTOM_CHARGE_START	0x0349
>> +#define BAT_CUSTOM_CHARGE_END	0x034A
>>   #define GLOBAL_MIC_MUTE_ENABLE	0x0364
>>   #define GLOBAL_MIC_MUTE_DISABLE	0x0365
>>   #define GLOBAL_MUTE_ENABLE	0x058C
>>   #define GLOBAL_MUTE_DISABLE	0x058D
>>
>> +enum battery_charging_mode {
>> +	DELL_BAT_MODE_NONE =3D 0,
>> +	DELL_BAT_MODE_STANDARD,
>> +	DELL_BAT_MODE_EXPRESS,
>> +	DELL_BAT_MODE_PRIMARILY_AC,
>> +	DELL_BAT_MODE_ADAPTIVE,
>> +	DELL_BAT_MODE_CUSTOM,
>> +	DELL_BAT_MODE_MAX,
>> +};
>> +
>>   struct notifier_block;
>>
>>   struct calling_interface_token {
>

