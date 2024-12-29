Return-Path: <linux-pm+bounces-19823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE24B9FDE98
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 11:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E4716165C
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFDF13D8B1;
	Sun, 29 Dec 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPHZQCmM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141AB2B9BB;
	Sun, 29 Dec 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735468190; cv=none; b=ql8dm9jSjH7QslGEHEKADTvbFqzmVqcJ6vI5abheXJuX2v05WG3XJrHEaLCZLf4zjs1GskeQGfiOHiEphtWDaUdvbYVYKAe3pYzW5AKDy0BiQbYOSKcNzugk/7RWGeFsYE2G+8DVW6FeShYtskF/FYeWErLpyd+Zmtl6CReij4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735468190; c=relaxed/simple;
	bh=IfVVEaRLoUhLLF6GcV6R3jIUM8PhSibPs/ZcS5R4kmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysn0Qc3rYqFuqRuqxWdjQwbbq8Hxvs1+HEXRDeVWm1HsyvgbrjU0ONX4X1af5Pa0j9rO/FJ6aTAnk3yx5+IDb5E3ARE6TMT5tb7XLRvzgyvvCTcuoUp8TayDgysEKs1+Y0cMqrz3gcF1P/slEtnWH0UQ0wAvjHMXb5danfLOCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPHZQCmM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b1f05caso104767475ad.3;
        Sun, 29 Dec 2024 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735468188; x=1736072988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd1J1lt9ZugQL3W4KAEiU2nurrQzgTfj/cP10rm2XXw=;
        b=MPHZQCmMi2tkeK2SFXBXA02YRTI/avxWMCGPqmzg4UMXKT0xcSQLzSvxrsSv7FkQWv
         RyRncN1vomO/QRc2lt0pDmLhAy+ZgG/VUHqz5cqYx2Msoc8o5VLfv4ckv8ht3izQJSQ+
         3/RarPh56jkT+6dKb22Ya83/I92Ctr3RZoWOUo68e+tqeESsvHL0ijCXu9n0f9uZtmeT
         6aTIrY7nXH0qGjEYOlnnspsMyZnv3UPWN161usGEh2bFRWZA887nN/Rg0e/jxA4iw41P
         ihrcQ/GvXstFOweUNXhmb89Y1lynkelhlbC+egQMSvzGegRepwBFyt9n4fpZpsNO0LyG
         +OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735468188; x=1736072988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd1J1lt9ZugQL3W4KAEiU2nurrQzgTfj/cP10rm2XXw=;
        b=b/X4onMOD8QxLBmCuub5hWfcAVuT0GhJGwwlA6kaD1qpQng5F8KaappFrooWyqbJOt
         giD7Mb6+j39NWZ94Zhx4uBLAVOLYA+nSPqg72TlWrILp3ENxH9X+1abcSq7IsfPpNzCt
         RJolOsbsI7OBK2xHu6y9w/nS5oNweenXOfGc7HhdOEPWsm+uHMhUeet8x7s3nXxSdAxn
         X9tJDrjR4px62w2xTOx2aE5wo2kitKt574iDFUTzI3uLB6ZttxIDzktWeQIgPkrY+9US
         OGvabTUJPB83jlKpI+tEeSA+LYxAjA/Bgf5bvIpkpTkt+w6KKlI10phF3I2vtqgLk3Ej
         VGeA==
X-Forwarded-Encrypted: i=1; AJvYcCUDWFDsNgE+YO+FN2fapD6jN9UqZtvIFLSotd28ZMS5mRNfUPV0hRe4D3NzY6xrx/731T2N03WzVYr3@vger.kernel.org, AJvYcCUlAVoJ60lfTmWEH4+aU7/K9Ty7OZGiASk8PhHNvyOQBsAy4l91D1L5Yboc9UBoV+533+GaYQaCYe8br62+@vger.kernel.org, AJvYcCWN1J/lf8E8qFoLU5JOuQCCeo87wPZcHGMLnL11J00MTQYsrBGkXYRxqelpnSSgtoi8CXbuk9ZSNOBg039NgQ==@vger.kernel.org, AJvYcCX+jybgJ/DxZJEC76F74hOlc00Ca0ugeoCux+hudAnrYowwQHl03pqcmI/CEomevO3G+ixxZ+g1bZry@vger.kernel.org, AJvYcCX82njbdvFgL4Gvz+XVPOw7mDV60ROHIi4Pknhp6yW8DI+rML/gg2Khe/9KpOna/WGO3Q4hNSvYFIo=@vger.kernel.org, AJvYcCXw3FuryUpctoJe51LYiDC3OhA9Y8xllndB0C5LyU+r0ucDaNp72S+rXyiR+geLaqzEBVOnPcvS4jWDouKF9CutMoxebQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZxsTeRszgKU1TaosuGWe9BOfqrIDgaovKig282FrW1AH87vF
	Zinynkz1O5DWNQ3bys998YUhmYZO9gi9NEjKZ8hql+P53foHh+xT
X-Gm-Gg: ASbGnct9BG7zBPitbHUzk/KUgvmzUhFNk4a19pBQbfItJYlyRQOk2zUo60eFhqWc2B0
	fRavy3+idkWXLfDnoYCIe4pYPOnz6qqDou6QsQWaGu97eBCNPznYAqcQhKKwAh3qOeXQ69ntOM1
	StDJqzcQj64Np9jr2WAoXXzOSNVXXeX7r4GuMLIW0IONXrRQ1HBOYespxgRrHnezdPaz9sBl1NL
	lT4IYbNg7Le7pwhBM85Dg9dGVdj2Hi7FrAnBma3dmo=
X-Google-Smtp-Source: AGHT+IHYac6E3hYd6SahXjIE3xEWFW803EhWZh2wzZyu70zsyT3kYpWg2MyCEuVNJIvYANeccOR7SA==
X-Received: by 2002:a05:6a00:4486:b0:725:eb85:f802 with SMTP id d2e1a72fcca58-72abdd5ede1mr46452582b3a.2.1735468188286;
        Sun, 29 Dec 2024 02:29:48 -0800 (PST)
Received: from nuvole.. ([2a09:bac1:76a0:dd10::2e9:e5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-8e2478b59bcsm3923284a12.72.2024.12.29.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 02:29:47 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: krzk@kernel.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Sun, 29 Dec 2024 18:28:31 +0800
Message-ID: <20241229102832.61841-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <0fc279b2-fa58-404a-af8e-ed18d4e2f514@kernel.org>
References: <0fc279b2-fa58-404a-af8e-ed18d4e2f514@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 29, 2024 at 5:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 28/12/2024 12:34, Pengyu Luo wrote:
> >> On Sat, Dec 28, 2024 at 5:58 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On 27/12/2024 18:13, Pengyu Luo wrote:
> >>> +
> >>> +#include <linux/platform_data/huawei-gaokun-ec.h>
> >>> +
> >>> +#define EC_EVENT             0x06
> >>> +
> >>> +/* Also can be found in ACPI specification 12.3 */
> >>> +#define EC_READ                      0x80
> >>> +#define EC_WRITE             0x81
> >>> +#define EC_BURST             0x82
> >>> +#define EC_QUERY             0x84
> >>> +
> >>> +
> >>> +#define EC_EVENT_LID         0x81
> >>> +
> >>> +#define EC_LID_STATE         0x80
> >>> +#define EC_LID_OPEN          BIT(1)
> >>> +
> >>> +#define UCSI_REG_SIZE                7
> >>> +
> >>> +/* for tx, command sequences are arranged as
> >>
> >> Use Linux style comments, see coding style.
> >>
> >
> > Agree
> >
> >>> + * {master_cmd, slave_cmd, data_len, data_seq}
> >>> + */
> >>> +#define REQ_HDR_SIZE         3
> >>> +#define INPUT_SIZE_OFFSET    2
> >>> +#define INPUT_DATA_OFFSET    3
> >>> +
> >>> +/* for rx, data sequences are arranged as
> >>> + * {status, data_len(unreliable), data_seq}
> >>> + */
> >>> +#define RESP_HDR_SIZE                2
> >>> +#define DATA_OFFSET          2
> >>> +
> >>> +
> >>> +struct gaokun_ec {
> >>> +     struct i2c_client *client;
> >>> +     struct mutex lock;
> >>
> >> Missing doc. Run Checkpatch --strict, so you will know what is missing here.
> >>
> >
> > I see. A comment for mutex lock.
> >
> >>> +     struct blocking_notifier_head notifier_list;
> >>> +     struct input_dev *idev;
> >>> +     bool suspended;
> >>> +};
> >>> +
> >>
> >>
> >>
> >> ...
> >>
> >>> +
> >>> +static DEVICE_ATTR_RO(temperature);
> >>> +
> >>> +static struct attribute *gaokun_wmi_features_attrs[] = {
> >>> +     &dev_attr_charge_control_thresholds.attr,
> >>> +     &dev_attr_smart_charge_param.attr,
> >>> +     &dev_attr_smart_charge.attr,
> >>> +     &dev_attr_fn_lock_state.attr,
> >>> +     &dev_attr_temperature.attr,
> >>> +     NULL,
> >>> +};
> >>
> >>
> >> No, don't expose your own interface. Charging is already exposed by
> >> power supply framework. Temperature by hwmon sensors. Drop all these and
> >> never re-implement existing kernel user-space interfaces.
> >>
> >
> > I don't quite understand what you mean. You mean I should use hwmon
> > interface like hwmon_device_register_with_groups to register it, right?
>
> You added sysfs interface, I think. My comment is: do not. We have
> existing interfaces.
>

I agree with you, but device_add_groups is used to add sysfs interface
everywhere, device_add_groups are wrapped in acpi_battery_hook, they
handle charge_control_thresholds like this, since qcom arm64 do not
support acpi on linux, we do not use acpi_battery_hook to implement it,
so it is reasonable to implement it in PSY drivers.

some examples:

drivers/platform/x86/thinkpad_acpi.c
> static struct attribute *tpacpi_battery_attrs[] = {
> 	&dev_attr_charge_control_start_threshold.attr,
> 	&dev_attr_charge_control_end_threshold.attr,
> 	&dev_attr_charge_start_threshold.attr,
> 	&dev_attr_charge_stop_threshold.attr,
> 	&dev_attr_charge_behaviour.attr,
> 	NULL,
> };
>
> ATTRIBUTE_GROUPS(tpacpi_battery);
>
> /* ACPI battery hooking */
>
> static int tpacpi_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
> {
> 	int batteryid = tpacpi_battery_get_id(battery->desc->name);
>
> 	if (tpacpi_battery_probe(batteryid))
> 		return -ENODEV;
> 	if (device_add_groups(&battery->dev, tpacpi_battery_groups))
> 		return -ENODEV;
> 	return 0;
> }

drivers/platform/x86/dell/dell-laptop.c
> static struct attribute *dell_battery_attrs[] = {
> 	&dev_attr_charge_control_start_threshold.attr,
> 	&dev_attr_charge_control_end_threshold.attr,
> 	&dev_attr_charge_types.attr,
> 	NULL,
> };
> ATTRIBUTE_GROUPS(dell_battery);
>
> static bool dell_battery_supported(struct power_supply *battery)
> {
> 	/* We currently only support the primary battery */
> 	return strcmp(battery->desc->name, "BAT0") == 0;
> }
>
> static int dell_battery_add(struct power_supply *battery,
> 		struct acpi_battery_hook *hook)
> {
> 	/* Return 0 instead of an error to avoid being unloaded */
> 	if (!dell_battery_supported(battery))
> 		return 0;
>
> 	return device_add_groups(&battery->dev, dell_battery_groups);
> }

> > As for battery, get/set_propery allow us to handle charging thresholds
> > things, but there are smart_charge_param, smart_charge and fn_lock to handle.
>
> So where is the ABI documentation? Where is any explanation why existing
> interfaces are not enough?
>

OK, if you insist, I will explain it in v2.

Best wishes,
Pengyu

