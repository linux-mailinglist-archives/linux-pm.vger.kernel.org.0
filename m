Return-Path: <linux-pm+bounces-40339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB2CFB5D5
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 00:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD4C3029200
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3730171A;
	Tue,  6 Jan 2026 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTsrDoGU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803A2FFF9B
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742884; cv=none; b=YTEtR8d/VvhdUDVtzREWVVGyyzZbQaQf6056PiZFzH3rdUyc/PRELY457SNMB6jabigLU/B4eEgQ739/JtAVJ9AKMDVq/WfW3SCyxYJhCbKgDiWc3owmHCr+s45NrkvuDvqyFtkGBZw5lpYACbEOlEzmTE0bywnsfu07Cbrvl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742884; c=relaxed/simple;
	bh=M2KQmH9gIfmKxwU7zVHlguKbue8LMpSZwqPpMZgaaQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnXeNCLjRIU3kI2ByS1b8eBMswrBopEkY/1Z4obNmSD3wETtiKXn3as01ZdUWYZcKgiuJY1I3bhzfQGG5qMRROiX5fkl9HcquROBK9BvJbASoJdkb2F4zr/s4afs4FCUl/AJIn4h90TpQ/nqCnGQKN5g1vf8NPFchXaJoH/8/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTsrDoGU; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-121bf277922so1130860c88.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767742881; x=1768347681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOdy4cc2P/dQA+KOO4O/Tcw0wFeu0CDW/7sZvsDaVnE=;
        b=aTsrDoGUJjkCFfLFA3P86IjrLUN6eVRKQUxp5agw2RJaZ4fx6MQ8/T1C7ZwWjmSOr3
         1LcjvT/72a5MjUNyUXb19Zs7M3IPIIim3kmDbb1sbJijbuD3xKHiSySP7t/dcQc7G6Np
         nIOduSnOMmNX1cqyGWcxXAWC6hntrFgTy/cOHCFMw1vLH3NmrxMsZBxZ878pXn2qw1Zd
         Rov1Sl33MJfLh6OlFIR6wlcuFh/9lwScpxyOGLK+ydMPhOuCqx4CRL6XKIFY9jpiDUDF
         EES/VmXMPWXpJaQ5DQTO3kqjZN6/DXxT28BEqFoZvoofXxgksNwD/ImasZ7kvYJGCRrz
         qaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742881; x=1768347681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOdy4cc2P/dQA+KOO4O/Tcw0wFeu0CDW/7sZvsDaVnE=;
        b=Ykyn/6hb3F7ah0LUS0gRlwinB6u6MBqGlkksa59Ljv0gr2g24v+f/ARyTN0XQ5kshh
         V/XQSGvKVdkJJ+hgusbCk/fnlsMQKpXYqb11kH1jVmfhsGjMyL4bDWjYhvVQAeBuBFVc
         kOpzzhmodukd9n69SflZMBqqQlDof6NIvD7xhlxtys92OIRtagc3iEmhoX4ipEwE6K07
         yVx9rYjBP9oEAMPRw/lmwk9aT5vHlhae9LqT0V3Klz8eWuW86wpMizBwhPkvBBqVm31I
         +QAn8rcw1n+JH/sOyL2VfgqtLU+R2J8n3lGFXHa0YtMni1L1VruceOFG6q31SQXaTZ9O
         FpYA==
X-Forwarded-Encrypted: i=1; AJvYcCXiR8TtWJ4FZBccrdq6xVPTe42Wq3j/U6X6abzVCg0VesoxBMA3hTHhIMYyty3cfeC5OJAc12xUVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TV8MJmBVQ7H90mousSyDVmlWY3b+dzCqovbMC+9pZlhhiLhR
	JlYamPbN8Ns098s7OKHwWduJU/8bBKgMQqK2Wtd675FDRidOro8tZM/ascUcvbZ42MPXPUPZuJx
	TnBijKL59
X-Gm-Gg: AY/fxX66y83zsajLltJCzHv/xQ1OJ9N+uuNnSdK8jZcYLydmKM0FdIHNEMZTqKGRrm9
	yBangT6lbS0VSHMaA1pq5ZNvKOH3IANDKJIOCs9qtFM/uycAcJxQ3Ot/8k8J7un2uI9166h1Wzy
	sZPyRqaNhZZrjk5TNJgQW7kqRwUrSu8q/6QoMpIJlGZXt0EvGiRnZWBDSbZ2r5m8J2Rgosx07Cu
	vVNbSbsQNeZ72Gy5gKwMXZFi+K/SwoAn4x3BqYoE4wMihm45UdlfY42t96xJrOpcTVc93s2ttlF
	3JPiY6oXLtzaYUbvemhoAwJYs4kOaSTh8RpeXAMLR+Wxfn9FaQcrur8JIHp0/YoOiWZogWZkPc1
	4A/MJddtqiOaydjBe8IkWvRaD0bgWaNkfw4MDOa+pkTr5D30S2Ypt0eVimr8q538aU63iqrhBAp
	YtTz9iBJsNRnpfQ8p6kkV+nAdpqCjAyBbdp2gCpazgBQAkdNd9Cb+PtIJbwEf+EcaL5ejVE41PN
	KNMU2YQ8POiAJP03sclMDuB
X-Google-Smtp-Source: AGHT+IECuND7IR3yvlHFs9iQusCFRfIlMO6PkG+ni39sFPy5JEaI/kO3iCIqzURddBgv95+k2hg8fg==
X-Received: by 2002:a05:693c:60c1:b0:2b0:6a03:e69f with SMTP id 5a478bee46e88-2b17d211668mr371276eec.11.1767742880702;
        Tue, 06 Jan 2026 15:41:20 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:b5c0:c506:467d:ed5e? ([2a00:79e0:2e7c:8:b5c0:c506:467d:ed5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673266sm5569667eec.1.2026.01.06.15.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 15:41:20 -0800 (PST)
Message-ID: <50c29a62-1fdb-4de2-8887-0d551eee5ec0@google.com>
Date: Tue, 6 Jan 2026 15:41:18 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] power: supply: max77759: add charger driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-4-54e664f5ca92@google.com>
 <298ca35590d2180fdcf334f94964b6110e17c606.camel@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <298ca35590d2180fdcf334f94964b6110e17c606.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andre',

On 1/5/26 9:32 AM, André Draszik wrote:
> Hi Amit,
>
> I haven't done a full review, but a few things caught my eye.
>
> On Sat, 2025-12-27 at 00:04 +0000, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add support for MAX77759 battery charger driver. This is a 4A 1-Cell
>> Li+/LiPoly dual input switch mode charger. While the device can support
>> USB & wireless charger inputs, this implementation only supports USB
>> input. This implementation supports both buck and boost modes.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
>>   MAINTAINERS                             |   6 +
>>   drivers/power/supply/Kconfig            |  11 +
>>   drivers/power/supply/Makefile           |   1 +
>>   drivers/power/supply/max77759_charger.c | 764 ++++++++++++++++++++++++++++++++
>>   4 files changed, 782 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dc731d37c8fe..26a9654ab75e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15539,6 +15539,12 @@ F:	drivers/mfd/max77759.c
>>   F:	drivers/nvmem/max77759-nvmem.c
>>   F:	include/linux/mfd/max77759.h
>>   
>> +MAXIM MAX77759 BATTERY CHARGER DRIVER
>> +M:	Amit Sunil Dhamne <amitsd@google.com>
>> +L:	linux-kernel@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/power/supply/max77759_charger.c
>> +
>>   MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
>>   M:	Javier Martinez Canillas <javier@dowhile0.org>
>>   L:	linux-kernel@vger.kernel.org
>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>> index 92f9f7aae92f..e172fd980fde 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -1132,4 +1132,15 @@ config FUEL_GAUGE_MM8013
>>   	  the state of charge, temperature, cycle count, actual and design
>>   	  capacity, etc.
>>   
>> +config CHARGER_MAX77759
>> +	tristate "MAX77759 Charger Driver"
>> +	depends on MFD_MAX77759 && REGULATOR
>> +	default MFD_MAX77759
>> +	help
>> +	  Say M or Y here to enable the MAX77759 Charger Driver. MAX77759
>> +	  charger is a function of the MAX77759 PMIC. This is a dual input
>> +	  switch-mode charger. This driver supports buck and OTG boost modes.
>> +
>> +	  If built as a module, it will be called max77759_charger.
>> +
> It might make sense to add this block near the existing MAX77... charger drivers,
> while updating the tristate string and keeping alphabetical order of entries.
>
>>   endif # POWER_SUPPLY
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
>> index 4b79d5abc49a..6af905875ad5 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
>>   obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
>>   obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
>>   obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
>> +obj-$(CONFIG_CHARGER_MAX77759)	+= max77759_charger.o
>> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
>> new file mode 100644
>> index 000000000000..3d255b069fb9
>> --- /dev/null
>> +++ b/drivers/power/supply/max77759_charger.c
>> @@ -0,0 +1,764 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * max77759_charger.c - Battery charger driver for MAX77759 charger device.
>> + *
>> + * Copyright 2025 Google LLC.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/device.h>
>> +#include <linux/devm-helpers.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/math64.h>
>> +#include <linux/mfd/max77759.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/string_choices.h>
>> +
>> +/* Default values for Fast Charge Current & Float Voltage */
>> +#define CHG_CC_DEFAULT_UA			2266770
>> +#define CHG_FV_DEFAULT_MV			4300
>> +
>> +#define FOREACH_IRQ(S)			\
>> +	S(AICL),			\
>> +	S(CHGIN),			\
>> +	S(CHG),				\
>> +	S(INLIM),			\
>> +	S(BAT_OILO),			\
>> +	S(CHG_STA_CC),			\
>> +	S(CHG_STA_CV),			\
>> +	S(CHG_STA_TO),			\
>> +	S(CHG_STA_DONE)
>> +
>> +#define GENERATE_ENUM(e)		e
>> +#define GENERATE_STRING(s)		#s
>> +
>> +enum {
>> +	FOREACH_IRQ(GENERATE_ENUM)
>> +};
>> +
>> +static const char *const chgr_irqs_str[] = {
>> +	FOREACH_IRQ(GENERATE_STRING)
>> +};
>> +
>> +static int irqs[ARRAY_SIZE(chgr_irqs_str)];
> No global variables please, this is not a singleton.
>
>> [...]
>>
>> +static int set_input_current_limit(struct max77759_charger *chg, int ilim_ua)
>> +{
>> +	u32 regval;
>> +
>> +	if (ilim_ua < 0)
>> +		return -EINVAL;
>> +
>> +	if (ilim_ua == 0)
>> +		ilim_ua = MAX77759_CHGR_CHGIN_ILIM_MIN_UA;
>> +	else if (ilim_ua > MAX77759_CHGR_CHGIN_ILIM_MAX_UA)
>> +		ilim_ua = MAX77759_CHGR_CHGIN_ILIM_MAX_UA;
> What if ilim_ua == 1 (or any other value < min_uA)? You could use clamp()
> instead of open-coding.
>
>> +
>> +	regval = val_to_regval(ilim_ua, MAX77759_CHGR_CHGIN_ILIM_MIN_UA,
>> +			       MAX77759_CHGR_CHGIN_ILIM_STEP_UA,
>> +			       MAX77759_CHGR_CHGIN_ILIM_REG_OFFSET);
>> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09,
>> +				  MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
>> +				  regval);
>> +}
>> +
>> +static const enum power_supply_property max77759_charger_props[] = {
>> +	POWER_SUPPLY_PROP_ONLINE,
>> +	POWER_SUPPLY_PROP_PRESENT,
>> +	POWER_SUPPLY_PROP_STATUS,
>> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
>> +	POWER_SUPPLY_PROP_HEALTH,
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>> +};
>> +
>> +static int max77759_charger_get_property(struct power_supply *psy,
>> +					 enum power_supply_property psp,
>> +					 union power_supply_propval *pval)
>> +{
>> +	struct max77759_charger *chg = power_supply_get_drvdata(psy);
>> +	int ret;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_ONLINE:
>> +		ret = get_online(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_PRESENT:
>> +		ret = charger_input_valid(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		ret = get_status(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
>> +		ret = get_charge_type(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_HEALTH:
>> +		ret = get_health(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>> +		ret = get_fast_charge_current(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> +		ret = get_float_voltage(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +		ret = get_input_current_limit(chg);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	pval->intval = ret;
>> +	return ret < 0 ? ret : 0;
>> +}
>> +
>> +static const struct power_supply_desc max77759_charger_desc = {
>> +	.name = "max77759-charger",
>> +	.type = POWER_SUPPLY_TYPE_USB,
>> +	.properties = max77759_charger_props,
>> +	.num_properties = ARRAY_SIZE(max77759_charger_props),
>> +	.get_property = max77759_charger_get_property,
>> +};
>> +
>> +static int charger_set_mode(struct max77759_charger *chg,
>> +			    enum max77759_chgr_mode mode)
>> +{
>> +	int ret;
>> +
>> +	guard(mutex)(&chg->lock);
>> +
>> +	if (chg->mode == mode)
>> +		return 0;
>> +
>> +	if ((mode == MAX77759_CHGR_MODE_CHG_BUCK_ON ||
>> +	     mode == MAX77759_CHGR_MODE_OTG_BOOST_ON) &&
>> +	    chg->mode != MAX77759_CHGR_MODE_OFF) {
>> +		dev_err(chg->dev, "Invalid mode transition from %d to %d",
>> +			chg->mode, mode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00,
>> +				 MAX77759_CHGR_REG_CHG_CNFG_00_MODE, mode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	chg->mode = mode;
>> +	return 0;
>> +}
>> +
>> +static int enable_chgin_otg(struct regulator_dev *rdev)
>> +{
>> +	struct max77759_charger *chg = rdev_get_drvdata(rdev);
>> +
>> +	return charger_set_mode(chg, MAX77759_CHGR_MODE_OTG_BOOST_ON);
>> +}
>> +
>> +static int disable_chgin_otg(struct regulator_dev *rdev)
>> +{
>> +	struct max77759_charger *chg = rdev_get_drvdata(rdev);
>> +
>> +	return charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
>> +}
>> +
>> +static int chgin_otg_status(struct regulator_dev *rdev)
>> +{
>> +	struct max77759_charger *chg = rdev_get_drvdata(rdev);
>> +
>> +	guard(mutex)(&chg->lock);
>> +	return chg->mode == MAX77759_CHGR_MODE_OTG_BOOST_ON;
>> +}
>> +
>> +static const struct regulator_ops chgin_otg_reg_ops = {
>> +	.enable = enable_chgin_otg,
>> +	.disable = disable_chgin_otg,
>> +	.is_enabled = chgin_otg_status,
>> +};
>> +
>> +static const struct regulator_desc chgin_otg_reg_desc = {
>> +	.name = "chgin-otg",
>> +	.of_match = of_match_ptr("chgin-otg-regulator"),
>> +	.owner = THIS_MODULE,
>> +	.ops = &chgin_otg_reg_ops,
>> +	.fixed_uV = 5000000,
>> +	.n_voltages = 1,
>> +};
>> +
>> +static irqreturn_t irq_handler(int irq, void *data)
>> +{
>> +	struct max77759_charger *chg = data;
>> +	struct device *dev = chg->dev;
>> +	u32 chgint_ok;
>> +	int i;
>> +
>> +	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &chgint_ok);
> You might want to check the return value and return IRQ_NONE if it didn't
> work?
>
>> +
>> +	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
>> +		if (irqs[i] == irq)
>> +			break;
>> +	}
>> +
>> +	switch (i) {
>> +	case AICL:
>> +		dev_dbg(dev, "AICL mode: %s",
>> +			str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_AICL));
>> +		break;
>> +	case CHGIN:
>> +		dev_dbg(dev, "CHGIN input valid: %s",
>> +			str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHGIN));
>> +		break;
>> +	case CHG:
>> +		dev_dbg(dev, "CHG status okay/off: %s",
>> +			str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHG));
>> +		break;
>> +	case INLIM:
>> +		dev_dbg(dev, "Current Limit reached: %s",
>> +			str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_INLIM));
>> +		break;
>> +	case BAT_OILO:
>> +		dev_dbg(dev, "Battery over-current threshold crossed");
>> +		break;
>> +	case CHG_STA_CC:
>> +		dev_dbg(dev, "Charger reached CC stage");
>> +		break;
>> +	case CHG_STA_CV:
>> +		dev_dbg(dev, "Charger reached CV stage");
>> +		break;
>> +	case CHG_STA_TO:
>> +		dev_dbg(dev, "Charger reached TO stage");
>> +		break;
>> +	case CHG_STA_DONE:
>> +		dev_dbg(dev, "Charger reached TO stage");
>> +		break;
> Are the above debug messages really all needed?
>
>> +	default:
>> +		dev_err(dev, "Unrecognized irq: %d", i);
>> +		return IRQ_HANDLED;
> I'm not sure it should return IRQ_HANDLED in this case.
>
>> +	}
>> +
>> +	power_supply_changed(chg->psy);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int max77759_init_irqhandler(struct max77759_charger *chg)
>> +{
>> +	struct device *dev = chg->dev;
>> +	unsigned long irq_flags;
>> +	struct irq_data *irqd;
>> +	int i, ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(chgr_irqs_str); i++) {
>> +		ret = platform_get_irq_byname(to_platform_device(dev),
>> +					      chgr_irqs_str[i]);
>> +		if (ret < 0) {
>> +			dev_err(dev,
>> +				"Failed to get irq resource for %s, ret=%d",
>> +				chgr_irqs_str[i], ret);
>> +			return ret;
>> +		}
> You should use return dev_err_probe() here, and drop the additional dev_err_probe()
> in max77759_charger_probe().
>
>> +
>> +		irqs[i] = ret;
>> +		irq_flags = IRQF_ONESHOT;
>> +		irqd = irq_get_irq_data(irqs[i]);
>> +		if (irqd)
>> +			irq_flags |= irqd_get_trigger_type(irqd);
> The above three lines are not needed, and then you can also drop irq_flags and
> use its value in the below call directly.
>
>> +
>> +		ret = devm_request_threaded_irq(dev, irqs[i], NULL, irq_handler,
>> +						irq_flags, dev_name(dev), chg);
>> +		if (ret) {
>> +			dev_err(dev,
>> +				"Unable to register irq handler for %s, ret=%d",
>> +				chgr_irqs_str[i], ret);
>> +			return ret;
> dev_err_probe() please.
>
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int max77759_charger_init(struct max77759_charger *chg)
>> +{
>> +	struct power_supply_battery_info *info;
>> +	u32 regval, fast_chg_curr, fv;
>> +	int ret;
>> +
>> +	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval);
>> +	chg->mode = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
>> +	ret = charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (power_supply_get_battery_info(chg->psy, &info)) {
>> +		fv = CHG_FV_DEFAULT_MV;
>> +		fast_chg_curr = CHG_CC_DEFAULT_UA;
>> +	} else {
>> +		fv = info->constant_charge_voltage_max_uv / 1000;
>> +		fast_chg_curr = info->constant_charge_current_max_ua;
>> +	}
>> +
>> +	ret = set_fast_charge_current_limit(chg, fast_chg_curr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = set_float_voltage_limit(chg, fv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = unlock_prot_regs(chg, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Disable wireless charging input */
>> +	regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
>> +			   MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
>> +
>> +	regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
>> +			   MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
> I think it's good practice to check return values.
>
>> +
>> +	return unlock_prot_regs(chg, false);
>> +}
>> +
>> +static void psy_work_item(struct work_struct *work)
>> +{
>> +	struct max77759_charger *chg =
>> +		container_of(work, struct max77759_charger, psy_work);
>> +	union power_supply_propval current_limit = { 0 }, online = { 0 };
>> +	int ret;
>> +
>> +	power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_CURRENT_MAX,
>> +				  &current_limit);
>> +	power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLINE,
>> +				  &online);
> Would it make sense to rework this and check the return values? Then you can also
> drop the greedy init at function entry.
>
>> +
>> +	if (online.intval && current_limit.intval) {
>> +		ret = set_input_current_limit(chg, current_limit.intval);
>> +		if (ret)
>> +			dev_err(chg->dev,
>> +				"Unable to set current limit, ret=%d", ret);
>> +
>> +		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
>> +	} else {
>> +		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
>> +	}
>> +}
>> +
>> +static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
>> +{
>> +	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
>> +						    nb);
>> +	const char *psy_name = "tcpm-source";
>> +	struct power_supply *psy = data;
>> +
>> +	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
>> +	    evt != PSY_EVENT_PROP_CHANGED)
>> +		return NOTIFY_OK;
>> +
>> +	chg->tcpm_psy = psy;
>> +	schedule_work(&chg->psy_work);
> Maybe add a newline here.
>
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static void max_tcpci_unregister_psy_notifier(void *nb)
>> +{
>> +	power_supply_unreg_notifier(nb);
>> +}
>> +
>> +static int max77759_charger_probe(struct platform_device *pdev)
>> +{
>> +	struct regulator_config chgin_otg_reg_cfg;
>> +	struct power_supply_config psy_cfg;
>> +	struct device *dev = &pdev->dev;
>> +	struct max77759_charger *chg;
>> +	int ret;
>> +
>> +	device_set_of_node_from_dev(dev, dev->parent);
>> +	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
>> +	if (!chg)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, chg);
>> +	chg->dev = dev;
>> +	chg->regmap = dev_get_regmap(dev->parent, "charger");
>> +	if (!chg->regmap)
>> +		return dev_err_probe(dev, -ENODEV, "Missing regmap");
>> +
>> +	ret = devm_mutex_init(dev, &chg->lock);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to initialize lock");
>> +
>> +	psy_cfg.fwnode = dev_fwnode(dev);
>> +	psy_cfg.drv_data = chg;
>> +	chg->psy = devm_power_supply_register(dev, &max77759_charger_desc,
>> +					      &psy_cfg);
>> +	if (IS_ERR(chg->psy))
>> +		return dev_err_probe(dev, -EPROBE_DEFER,
>> +				     "Failed to register psy, ret=%ld",
>> +				     PTR_ERR(chg->psy));
>> +
>> +	ret = max77759_charger_init(chg);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to initialize max77759 charger");
>> +
>> +	chgin_otg_reg_cfg.dev = dev;
>> +	chgin_otg_reg_cfg.driver_data = chg;
>> +	chgin_otg_reg_cfg.of_node = dev_of_node(dev);
>> +	chg->chgin_otg_rdev = devm_regulator_register(dev, &chgin_otg_reg_desc,
>> +						      &chgin_otg_reg_cfg);
>> +	if (IS_ERR(chg->chgin_otg_rdev))
>> +		return dev_err_probe(dev, PTR_ERR(chg->chgin_otg_rdev),
>> +				     "Failed to register chgin otg regulator");
>> +
>> +	ret = devm_work_autocancel(dev, &chg->psy_work, psy_work_item);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to initialize psy work");
>> +
>> +	chg->nb.notifier_call = psy_changed;
>> +	ret = power_supply_reg_notifier(&chg->nb);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Unable to register psy notifier");
>> +
>> +	ret = devm_add_action_or_reset(dev, max_tcpci_unregister_psy_notifier,
>> +				       &chg->nb);
>> +	if (ret)
>> +		return ret;
> You could print a message here as well.

Thanks for the detailed review! I will fix all the flagged issues in the 
next rev.


BR,

Amit

>
> Cheers,
> Andre'

