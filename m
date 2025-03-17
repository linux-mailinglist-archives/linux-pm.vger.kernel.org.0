Return-Path: <linux-pm+bounces-24155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45622A64EF6
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADFC3A70A9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14723BCFA;
	Mon, 17 Mar 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHS2M9Sp"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305D23BCF9
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214796; cv=none; b=AzPJ8kbEpoRFipeN5c48NH76gNhYe9r5Ao76fHdbNE0TEbqG9M4ESwN+26xNxBAoircqN/vUjZL3UID0PuJcn3lReO3cE6xH8sRjo5K7BDRDF3fS4og4UFvNhBQGES4DJuKOgGgDIciUFusG1tQ4oSyPf0tBQyKKpLXcWkQdOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214796; c=relaxed/simple;
	bh=HaoDdTNElxGgiWHcCwujbysz5G/lNSZtyXhMi7JJJig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp9VZ6IjIbxrOyFnu7INv7OztIJIOFa3Nw8pLPHVF9iZoBn/RsQiBzTiacHszQNPf+oDZHwzr1sgQazZmwt3+OHHTmKG9w9Wvq/ry6oIYw6iwMEHh/K32zX/RF07ELKVUno9U7I8L2ToE2CyP4AForEAsZMYk8n0hh2Ar8QOd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHS2M9Sp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742214793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JezHzOr4cH5CC3OkxH2pDIucxBNDf0tG1TD0C+sq9bs=;
	b=GHS2M9SpO3946coHXRks2K62EdGoFXpQlYRs8xpI2dCUpXY0+7Av8TDBsmTQhltOXhF8tj
	Bu7RjMMGdsLz0Cfatv7KPXrnTk/C2dni5ATxTYCPZImJgMn5dZIqxsxzjSPe010hzYICaZ
	mtJJvrlJ1wWvWxG94t9TJjSDa+9utS8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-90_aAQGFOX-lUYEygG9SSA-1; Mon, 17 Mar 2025 08:33:10 -0400
X-MC-Unique: 90_aAQGFOX-lUYEygG9SSA-1
X-Mimecast-MFC-AGG-ID: 90_aAQGFOX-lUYEygG9SSA_1742214788
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abec83a498cso335051066b.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 05:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742214788; x=1742819588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JezHzOr4cH5CC3OkxH2pDIucxBNDf0tG1TD0C+sq9bs=;
        b=X6nvueA8ZT5DUs9QREk+AZ3+c/OHTm9mtLfppp3opGv5XrydOqeYBgRnAhHZMVjqul
         5tSK3pEJcDkzgeQsZgkakG4hbJ3sCUs2DpCrJVi/epCVa2UciVe4ILlcsNxsVRFUm4Y9
         GcuHPQPtYR0lujMVbUnTKJjukafq0hRww6s6Ixx90tglsJDFJpIiYkdjUS9BL9hzaLyh
         YjNa9tj4WjsO0H/6sUVBbTZRlpY/ggahQ2y6SKo2UXklHSXp26WiE02YzEuMdqNEx6Tg
         ltT9RRSVETxZljWz862EqXcY0KC101k10BmD6Nf9udwiECS5qGTsRZBbiuGB/6iroshP
         oZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpYob3tqqBSEi79otXG6sjbKT47AosUeO4V5kteFDqIJGBEuFuWBam0WLK88GGZcny0rsdylNwiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOzjKhsWlpDLHH9rNvEo3Ww0LueRx/J+wZ3WdFD7TC1NepnwC
	H6kwxUJODG83de+uaVqGjJHEXz/+EMQXMjcXHZg7Q7metmarC7HDVP46UpFLq/KpIDx/7o0zMrt
	GUB9OpXK9c5yy5kk3UtIgTBgkq1rOb+7ByfWU0aMvNqMBqR4ztzjn7qHG
X-Gm-Gg: ASbGncvFPlwXWqsNhOvz78h0MthDDTKaEQ6DF+3ub5OdOBTWLYMqAtYuTohnznm4z9b
	cejK5N8wI21p0S2Lsx127c5YXnjtTVStBHX+BNFnelTeSl/JL7+qlCvkcT6fRAGvwGTDqou+7qS
	AWJjSz1D/pPh15desy6jRRmGmwcbTCkQyH2HU9JER8wXj1MDBQbKXIss3DcUOpzFiU2IvSP7q++
	TONX4HMJIga0BcWqpYYITDiUnB+jHiT6m51LDz3MIVDXQKpNXAHq8ezoghbnlwhM5FI6tCUVm7I
	VKA+aHvaXEW5ywTCYko=
X-Received: by 2002:a17:907:d92:b0:abf:6b14:6cf0 with SMTP id a640c23a62f3a-ac3301de27bmr1318319766b.12.1742214787907;
        Mon, 17 Mar 2025 05:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWN4ituXBhYLFP8L5JaUI3RJRAtsiwYlQaRBm96BxIsMNoPk9NSO6TYSOqRrxmgRK86+9NZw==
X-Received: by 2002:a17:907:d92:b0:abf:6b14:6cf0 with SMTP id a640c23a62f3a-ac3301de27bmr1318315766b.12.1742214787390;
        Mon, 17 Mar 2025 05:33:07 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a4bf4dsm659816866b.154.2025.03.17.05.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:33:06 -0700 (PDT)
Message-ID: <c7a198b5-bebb-498b-9e77-17b467f4dc48@redhat.com>
Date: Mon, 17 Mar 2025 13:32:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-7-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250311165406.331046-7-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Mar-25 17:53, Antheas Kapenekakis wrote:
> With the X1 (AMD), OneXPlayer added a charge limit and charge bypass to
> their devices. Charge limit allows for choosing an arbitrary battery
> charge setpoint in percentages. Charge bypass allows to instruct the
> device to stop charging either when it is in s0 or always.

Again please don't use the word bypass, use inhibit instead.

> This feature was then extended for the F1Pro as well. OneXPlayer also
> released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> add support for this feature. Therefore, enable it for all F1 and
> X1 devices.
> 
> Add both of these under the standard sysfs battery endpoints for them,
> by looking for the battery. OneXPlayer devices have a single battery.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/Kconfig |   1 +
>  drivers/platform/x86/oxpec.c | 217 +++++++++++++++++++++++++++++++++++
>  2 files changed, 218 insertions(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 82cfc76bc5c9..f4d993658c01 100644
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
> index dc3a0871809c..d73a10598d8f 100644
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
> @@ -87,6 +88,24 @@ static enum oxp_board board;
>  
>  #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
>  
> +/* Battery bypass settings */
> +#define EC_CHARGE_CONTROL_BEHAVIOURS_X1	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
> +					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)    | \
> +					 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0))
> +
> +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> +#define OXP_X1_CHARGE_BYPASS_REG     0xA4 /* X1 bypass charging */
> +
> +#define OXP_X1_CHARGE_BYPASS_MASK_S0 0x01

Again avoid the word BYPASS please, if OneXPlayer are calling this bypass in their 
own documentation maybe add a note here when defining the registers that OneXPlayer
calls this bypass and then use inhibit from there on.

> +/*
> + * Cannot control S3, S5 individually.
> + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> + * but the extra bit on the X1 does nothing.
> + */
> +#define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02

Ok, so suspend is treated as off, but that is for S3 suspend, what about
s2idle, or does this hw not do s2idle ?

> +#define OXP_X1_CHARGE_BYPASS_MASK_ALWAYS (OXP_X1_CHARGE_BYPASS_MASK_S0 | \
> +	OXP_X1_CHARGE_BYPASS_MASK_S3S5)
> +
>  static const struct dmi_system_id dmi_table[] = {
>  	{
>  		.matches = {
> @@ -434,6 +453,194 @@ static ssize_t tt_toggle_show(struct device *dev,
>  
>  static DEVICE_ATTR_RW(tt_toggle);
>  
> +/* Callbacks for charge behaviour attributes */
> +static bool charge_behaviour_supported(void)
> +{
> +	switch (board) {
> +	case oxp_x1:
> +	case oxp_fly:
> +		return 1;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t charge_behaviour_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t count)
> +{
> +	unsigned int available;
> +	long val, s0, always;
> +	int ret;
> +	u8 reg;
> +
> +	switch (board) {
> +	case oxp_x1:
> +	case oxp_fly:
> +		s0 = OXP_X1_CHARGE_BYPASS_MASK_S0;
> +		always = OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> +		reg = OXP_X1_CHARGE_BYPASS_REG;
> +		available = EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> +		break;

Since these are always the same this does not seem useful, please
use the defines directly below.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = power_supply_charge_behaviour_parse(available, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (ret) {
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +		val = 0;
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0:
> +		val = s0;
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +		val = always;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = write_to_ec(reg, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t charge_behaviour_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	long val, s0, always, sel;
> +	unsigned int available;
> +	int ret;
> +	u8 reg;
> +
> +	switch (board) {
> +	case oxp_x1:
> +	case oxp_fly:
> +		s0 = OXP_X1_CHARGE_BYPASS_MASK_S0;
> +		always = OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> +		reg = OXP_X1_CHARGE_BYPASS_REG;
> +		available = EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = read_from_ec(reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val & always) == always)
> +		sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +	else if ((val & s0) == s0)
> +		sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0;
> +	else
> +		sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +
> +	return power_supply_charge_behaviour_show(dev, available, sel, buf);
> +}
> +
> +static DEVICE_ATTR_RW(charge_behaviour);
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t count)
> +{
> +	u64 val, reg;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > 100)
> +		return -EINVAL;
> +
> +	switch (board) {
> +	case oxp_x1:
> +	case oxp_fly:
> +		reg = OXP_X1_CHARGE_LIMIT_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = write_to_ec(reg, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	long val;
> +	int ret;
> +	u8 reg;
> +
> +	switch (board) {
> +	case oxp_x1:
> +	case oxp_fly:
> +		reg = OXP_X1_CHARGE_LIMIT_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = read_from_ec(reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +
> +static int oxp_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
> +{
> +	/* OneXPlayer devices only have one battery. */
> +	if (strcmp(battery->desc->name, "BAT0") != 0 &&
> +	    strcmp(battery->desc->name, "BAT1") != 0 &&
> +	    strcmp(battery->desc->name, "BATC") != 0 &&
> +	    strcmp(battery->desc->name, "BATT") != 0)
> +		return -ENODEV;
> +
> +	if (device_create_file(&battery->dev,
> +	    &dev_attr_charge_control_end_threshold))
> +		return -ENODEV;
> +
> +	if (device_create_file(&battery->dev,
> +	    &dev_attr_charge_behaviour)) {
> +		device_remove_file(&battery->dev,
> +				&dev_attr_charge_control_end_threshold);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int oxp_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
> +{
> +	device_remove_file(&battery->dev,
> +			   &dev_attr_charge_control_end_threshold);
> +	device_remove_file(&battery->dev,
> +			   &dev_attr_charge_behaviour);
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook battery_hook = {
> +	.add_battery = oxp_battery_add,
> +	.remove_battery = oxp_battery_remove,
> +	.name = "OneXPlayer Battery",
> +};
> +

Since this is new code it should use the new power-supply extension support instead
of the old battery_hook mechanism:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6037802bbae892f3ad0c7b4c4faee39b967e32b0



>  /* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
> @@ -716,15 +923,25 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
>  						     &oxp_ec_chip_info, NULL);
>  
> +	if (charge_behaviour_supported())
> +		battery_hook_register(&battery_hook);
> +
>  	return PTR_ERR_OR_ZERO(hwdev);
>  }
>  
> +static void oxp_platform_remove(struct platform_device *device)
> +{
> +	if (charge_behaviour_supported())
> +		battery_hook_unregister(&battery_hook);
> +}
> +
>  static struct platform_driver oxp_platform_driver = {
>  	.driver = {
>  		.name = "oxp-platform",
>  		.dev_groups = oxp_ec_groups,
>  	},
>  	.probe = oxp_platform_probe,
> +	.remove = oxp_platform_remove,
>  };
>  
>  static struct platform_device *oxp_platform_device;

Regards,

Hans



