Return-Path: <linux-pm+bounces-12883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D495F437
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F74282FD1
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F888193406;
	Mon, 26 Aug 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqNGEklU"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1779192D67
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683484; cv=none; b=GCVrkdnZKLtXriBUpHHyhtCp4swNExbj5U3LO4fTcGxwhuNOeVLdTzRDhKGx4Tjs3io6eWRS/iiYfWZI7RMUiRWNeSBeXnovyaZrVeNCeGbaIjQvkfsPzlGtCFGxdKmnr9RgL5jkW70gSgbXLlVvkqRwfik9LtAKODnvPuja8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683484; c=relaxed/simple;
	bh=OCJdLZ1r9mUAYY9g366e1v5YUxJ1Qc0t3f521lYydN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9qke6p/f3PvL++8W/Gs1YDK52SqjX/a6KXiRPhcbeor4X+b5sp2E+uuVrn+clvUQrophPNy5uQTtmXsH/arpccXOsZAEkGd5QXntrOsuAQT4vg6C8Sy5LWVBYfB54MZWnr2J5ubwnZsTupYMgtgnLNS3mQcBpUbqJf8UBOdAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqNGEklU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724683479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voVs2V+KLc2Dgz5w27ok/5RwY17c917gvImy74UQzjc=;
	b=JqNGEklUQao/9+bDGRElMVBUNVDoHbWYWASmULcmec/NY1hmo3DMYK2B6x14v1JOz5XbcE
	pm9ceCmwtFyrf84b6J1xquyZXYjsvdymVk+XFOotnLPvkIsM0apOowW6qVRJoen32qGK6H
	QmvlkIjry95wkKVFiEJ3e+VOVuZwMtE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-sbUGsuc5NLWwzdO8eNxwuQ-1; Mon, 26 Aug 2024 10:44:38 -0400
X-MC-Unique: sbUGsuc5NLWwzdO8eNxwuQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bed8949b39so3488830a12.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 07:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683477; x=1725288277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voVs2V+KLc2Dgz5w27ok/5RwY17c917gvImy74UQzjc=;
        b=iqrMed14s1qxpInZR8nKxLYRvGPXhLs5cAo5pFIAjxR2plR0Swy3RDU19Dj4Z8w1Cn
         oHv7QPIm2k5yShWPZTCn5nrLfjyy5e6vr9v//nTOrHYWsFUGj2GvhR3cFcQQU+5Bq7ku
         DDorn+4qZfqNe7zV+lz1OYJXBngb3xmnsMZNI8u5TKC0+THft6jx0s1XOglKThD/Fh9A
         LkGPRBCDf8vr+U74Ce6ZT8jrOmhxgzOifjpzgMqul47P3YaV/hkosH7Qi7aP786NRLae
         Ivyv0MRn/fQcw8jLdHcWI9/4tq+YMgFJuEtVS1yZfLAe8QI04r4m+UHGNTnTj1JVicH8
         ddHg==
X-Forwarded-Encrypted: i=1; AJvYcCXG4HmZRIL9iLBAvR2W1SHQd48BXdAgxbxHSkdFCweEHdEAvnZ+dLXZ/2HOGxfjGBcD3UxV1Kgl0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0dVbRcaANKXsfxaiiyHps7i7csxeLgN3zBZ4YKeV/RdD+G29
	bjdv4sPdsyMRzif4XPBtnidIb19O8rVl5UOoAdbJPgtRJekygIJIvaskPgDsZ4Ob0i4KjZ1AGoA
	VBqpphrAcPJIX5Ho0HoRmqn4YIxjcgiJ2ejmpOkadxorZEOp7hncaF/0r
X-Received: by 2002:a17:907:94ce:b0:a86:c7d2:158d with SMTP id a640c23a62f3a-a86c7d21b49mr351086966b.46.1724683477125;
        Mon, 26 Aug 2024 07:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwNmq9Ko1amBRlAEutaL8tthCFX4ODTmB8Z93FKSLcoauCzOdlqZGXCsoOp/3trQbpCj4wiQ==
X-Received: by 2002:a17:907:94ce:b0:a86:c7d2:158d with SMTP id a640c23a62f3a-a86c7d21b49mr351084666b.46.1724683476543;
        Mon, 26 Aug 2024 07:44:36 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d2bsm677441466b.43.2024.08.26.07.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:44:36 -0700 (PDT)
Message-ID: <04d48a7c-cad1-4490-bbcd-ceb332c740bd@redhat.com>
Date: Mon, 26 Aug 2024 16:44:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
To: Andres Salomon <dilinger@queued.net>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
 Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
References: <20240820033005.09e03af1@5400>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240820033005.09e03af1@5400>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andres,

On 8/20/24 9:30 AM, Andres Salomon wrote:
> The Dell BIOS allows you to set custom charging modes, which is useful
> in particular for extending battery life. This adds support for tweaking
> those various settings from Linux via sysfs knobs. One might, for
> example, have their laptop plugged into power at their desk the vast
> majority of the time and choose fairly aggressive battery-saving
> settings (eg, only charging once the battery drops below 50% and only
> charging up to 80%). When leaving for a trip, it would be more useful
> to instead switch to a standard charging mode (top off at 100%, charge
> any time power is available). Rebooting into the BIOS to change the
> charging mode settings is a hassle.
> 
> For the Custom charging type mode, we reuse the common
> charge_control_{start,end}_threshold sysfs power_supply entries. The
> BIOS also has a bunch of other charging modes (with varying levels of
> usefulness), so this also adds a 'charge_type' sysfs entry that maps the
> standard values to Dell-specific ones.
> 
> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> Reviewed-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v4:
>     - fix improper __exit use by dell_battery_exit
>     - break apart battery_modes definition/declaration and visually align
>       values
>     - drop sysfs-class-power-dell
>     - use clamp() instead of manually if/else'ing
>     - drop redundant check in charge_type_store()

Sorry I missed some important issues with my last review, so I'm afraid
that this is not ready for merging yet.

See comments inline below.

> Changes in v3:
>     - switch tokenid and class types
>     - be stricter with results from both userspace and BIOS
>     - no longer allow failed BIOS reads
>     - rename/move dell_send_request_by_token_loc, and add helper function
>     - only allow registration for BAT0
>     - rename charge_type modes to match power_supply names
> Changes in v2, based on extensive feedback from Pali Rohár <pali@kernel.org>:
>     - code style changes
>     - change battery write API to use token->value instead of passed value
>     - stop caching current mode, instead querying SMBIOS as needed
>     - drop the separate list of charging modes enum
>     - rework the list of charging mode strings
>     - query SMBIOS for supported charging modes
>     - split dell_battery_custom_set() up
> ---
>  drivers/platform/x86/dell/Kconfig       |   1 +
>  drivers/platform/x86/dell/dell-laptop.c | 310 ++++++++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h |   7 +
>  3 files changed, 318 insertions(+)
> 
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
> index 6552dfe491c6..4053af8f7676 100644
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
> @@ -99,6 +101,20 @@ static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
>  
> +struct battery_mode_info {
> +	int token;
> +	const char *label;
> +};
> +
> +static const struct battery_mode_info battery_modes[] = {
> +	{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> +	{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
> +	{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
> +	{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> +	{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
> +};
> +static u32 battery_supported_modes;
> +
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
>  
> @@ -353,6 +369,32 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
>  	{ }
>  };
>  
> +/* -1 is a sentinel value, telling us to use token->value */
> +#define USE_TVAL ((u32) -1)
> +static int dell_send_request_for_tokenid(struct calling_interface_buffer *buffer,
> +					 u16 class, u16 select, u16 tokenid,
> +					 u32 val)
> +{
> +	struct calling_interface_token *token;
> +
> +	token = dell_smbios_find_token(tokenid);
> +	if (!token)
> +		return -ENODEV;
> +
> +	if (val == USE_TVAL)
> +		val = token->value;
> +
> +	dell_fill_request(buffer, token->location, val, 0, 0);
> +	return dell_send_request(buffer, class, select);
> +}
> +
> +static inline int dell_set_std_token_value(struct calling_interface_buffer *buffer,
> +		u16 tokenid, u32 value)
> +{
> +	return dell_send_request_for_tokenid(buffer, CLASS_TOKEN_WRITE,
> +			SELECT_TOKEN_STD, tokenid, value);
> +}
> +
>  /*
>   * Derived from information in smbios-wireless-ctl:
>   *
> @@ -2183,6 +2225,271 @@ static struct led_classdev mute_led_cdev = {
>  	.default_trigger = "audio-mute",
>  };
>  
> +static int dell_battery_set_mode(const u16 tokenid)
> +{
> +	struct calling_interface_buffer buffer;
> +
> +	return dell_set_std_token_value(&buffer, tokenid, USE_TVAL);
> +}
> +
> +static int dell_battery_read(const u16 tokenid)
> +{
> +	struct calling_interface_buffer buffer;
> +	int err;
> +
> +	err = dell_send_request_for_tokenid(&buffer, CLASS_TOKEN_READ,
> +			SELECT_TOKEN_STD, tokenid, 0);
> +	if (err)
> +		return err;
> +
> +	if (buffer.output[1] > INT_MAX)
> +		return -EIO;
> +
> +	return buffer.output[1];
> +}
> +
> +static bool dell_battery_mode_is_active(const u16 tokenid)
> +{
> +	struct calling_interface_token *token;
> +	int ret;
> +
> +	ret = dell_battery_read(tokenid);
> +	if (ret < 0)
> +		return false;
> +
> +	token = dell_smbios_find_token(tokenid);
> +	/* token's already verified by dell_battery_read() */
> +
> +	return token->value == (u16) ret;
> +}
> +
> +/*
> + * The rules: the minimum start charging value is 50%. The maximum
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
> +	start = clamp(start, CHARGE_START_MIN, CHARGE_START_MAX);
> +	end = dell_battery_read(BAT_CUSTOM_CHARGE_END);
> +	if (end < 0)
> +		return end;
> +	if ((end - start) < CHARGE_MIN_DIFF)
> +		start = end - CHARGE_MIN_DIFF;
> +
> +	return dell_set_std_token_value(&buffer, BAT_CUSTOM_CHARGE_START,
> +			start);
> +}
> +
> +static int dell_battery_set_custom_charge_end(int end)
> +{
> +	struct calling_interface_buffer buffer;
> +	int start;
> +
> +	end = clamp(end, CHARGE_END_MIN, CHARGE_END_MAX);
> +	start = dell_battery_read(BAT_CUSTOM_CHARGE_START);
> +	if (start < 0)
> +		return start;
> +	if ((end - start) < CHARGE_MIN_DIFF)
> +		end = start + CHARGE_MIN_DIFF;
> +
> +	return dell_set_std_token_value(&buffer, BAT_CUSTOM_CHARGE_END, end);
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

If you look at the way how charge_type is shown by the power_supply_sysfs.c
file which is used for power-supply drivers which directly register
a power-supply themselves rather then extending an existing driver, this
is not the correct format.

drivers/power/supply/power_supply_sysfs.c

lists charge_type as:

        POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),

and ENUM type properties use the following for show() :

	default:
		if (ps_attr->text_values_len > 0 &&
				value.intval < ps_attr->text_values_len && value.intval >= 0) {
			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
		} else {
			ret = sysfs_emit(buf, "%d\n", value.intval);
		}
	}

with in this case text_values pointing to:

static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
	[POWER_SUPPLY_CHARGE_TYPE_UNKNOWN]	= "Unknown",
	[POWER_SUPPLY_CHARGE_TYPE_NONE]		= "N/A",
	[POWER_SUPPLY_CHARGE_TYPE_TRICKLE]	= "Trickle",
	[POWER_SUPPLY_CHARGE_TYPE_FAST]		= "Fast",
	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	= "Standard",
	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	= "Adaptive",
	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	= "Custom",
	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	= "Long Life",
	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	= "Bypass",
};

So value.intval will be within the expected range hitting:

			ret = sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);

IOW instead of outputting something like this:

Fast [Standard] Long Life

which is what your show() function does it outputs only
the active value as a string, e.g.:

Standard

Yes not being able to see the supported values is annoying I actually
wrote an email about that earlier today:

https://lore.kernel.org/linux-pm/49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com/

but we need to make sure that the output is consistent between drivers otherwise
userspace can never know how to use the API, so for charge_type the dell
driver should only output the active type, not all the options.

This reminds me that there was a patch-series to allow battery extension drivers
like this one to actually use the power-supply core code for show()/store()
Thomas IIRC that series was done by you ?  What is the status of that ?

Also looking at the userspace API parts of this again I wonder
if mapping  BAT_PRI_AC_MODE_TOKEN -> "Trickle" is the right thing do
maybe "Long Life" would be a better match ?  That depends on what the option
actually does under the hood I guess. Is this known ?

Regards,

Hans





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
> +		if (!(battery_supported_modes & BIT(i)))
> +			continue;
> +
> +		if (sysfs_streq(battery_modes[i].label, buf)) {
> +			matched = true;
> +			break;
> +		}
> +	}
> +	if (!matched)
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
> +
> +	if (start > CHARGE_START_MAX)
> +		return -EIO;
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
> +	if (start < 0 || start > 100)
> +		return -EINVAL;
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
> +	if (end > CHARGE_END_MAX)
> +		return -EIO;
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
> +	if (end < 0 || end > 100)
> +		return -EINVAL;
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
> +	/* this currently only supports the primary battery */
> +	if (strcmp(battery->desc->name, "BAT0") != 0)
> +		return -ENODEV;
> +
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
> +}
> +
> +static void dell_battery_exit(void)
> +{
> +	if (battery_supported_modes != 0)
> +		battery_hook_unregister(&dell_battery_hook);
> +}
> +
>  static int __init dell_init(void)
>  {
>  	struct calling_interface_token *token;
> @@ -2219,6 +2526,7 @@ static int __init dell_init(void)
>  		touchpad_led_init(&platform_device->dev);
>  
>  	kbd_led_init(&platform_device->dev);
> +	dell_battery_init(&platform_device->dev);
>  
>  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
>  	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> @@ -2293,6 +2601,7 @@ static int __init dell_init(void)
>  	if (mute_led_registered)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
> +	dell_battery_exit();
>  	dell_cleanup_rfkill();
>  fail_rfkill:
>  	platform_device_del(platform_device);
> @@ -2311,6 +2620,7 @@ static void __exit dell_exit(void)
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
> +#define BAT_CUSTOM_CHARGE_START	0x0349
> +#define BAT_CUSTOM_CHARGE_END	0x034A
>  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
>  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
>  #define GLOBAL_MUTE_ENABLE	0x058C


