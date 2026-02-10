Return-Path: <linux-pm+bounces-42377-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FyLLfR+imnVLAAAu9opvQ
	(envelope-from <linux-pm+bounces-42377-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 01:42:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F189115BA9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D869300B285
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92A24468B;
	Tue, 10 Feb 2026 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j4GqHLlG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92325B1D2
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 00:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684131; cv=none; b=od88ieUL2AJkZHEeHq8IaqQHXTzpHNhB3iDo2jFdxAATWNkQWPMdOvonWo1k5lQ7XoLBe3jJ2OE1O8CSeNohSaQz6zD1WLFuevMZMDG1G8t9MRpvbJNJKPk6tDdY5NNBN+Tb4d5lLd6txzGXxWd3Op/IStVe47GeOTMUS3co7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684131; c=relaxed/simple;
	bh=o8D6s0QTg3g0kvaHz97bW27K8xrDCqoBUW1QlHgQ2Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHjFhPM0dQ/e5sEAFR66hBZGVOie1uVoX6+By5ip98+y6Ad4Wwd1Vr9RoNbUKs8cgyGgJ5IYNNEE6bJ+VbVThFZZ6e0RzNfZKIjPzVE2VjG1GwGVjfhmVQPgEnl2ZxgwECwybbzB87BkzI01JO7ufXFo6DGdOGjySXSN9Smvy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j4GqHLlG; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba895adfeaso292651eec.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 16:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770684127; x=1771288927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/l01qI7JHOzKObdb7nDJ9HcBhB8QCBvin/5ZvlCPpE=;
        b=j4GqHLlG9rUvAMZVIp+OFDPFgjL2FaxJI77bmJkecIm0oUI/gUUEMV1MHNb+g5fG6d
         mtr6DdTuxHYT7Fodep8+KntE10hPTJwEnbBCnQfPi5zctyqyL5ZP3KsgXmCzbFsrkO1K
         yx2WjUU/nDRs4JQ6bRflaVimsVsSsxxnmLTnL4+OrO0JdyBDv8MxqYbBajOYnCzC7p6n
         VfI/BNrho2mDSQFhSzu6+XguRC/vgMKqpXkebHKG1UwGwew0yGZqBhjaCc0JvnGKss8F
         tqUJXKjgVbpdH2/j/MuCi3jomixBlaFJR4jEFWvB8VC6vLPSbjVYQprFqgzjnjEgS1Sj
         Js6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770684127; x=1771288927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/l01qI7JHOzKObdb7nDJ9HcBhB8QCBvin/5ZvlCPpE=;
        b=eqeJ+QXKhsAYWAXetS56wXA1UeXKQQOmywTc9Esv8V3/fvuMar71Pkz6sb/N/FXDIJ
         4s+3jjeuFIaJ+fQfHL7UpEn013ZlNtlReSkJ4XQNTeX8Z4Zd0kQ0K1OWg3zpRoChhxzG
         c51gJx7/gMvgCDsaqfvDsRqjmEmF/+CIuQg2UOQTm76PqpokH0yKMBZ6S+IZmey1k85y
         iDa+fVBr7VnpOJ0m5GBYMzqWHW5TETUt6ijaNmG8Lu0SfWuTd6PimRCwtymFMvn7Tkls
         jAFDqZfifVNKkBH1A86KHTav94xSwNCe4GSoq67zcvsyO5n0wLkWCCTZtuZIfTmfxDAJ
         51Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUdQthM4XmfqolieAkMtTm+z6MpJF9IvpxDEoy46imsl7YXfgcq7O0Z0IdB33D94rQ84Cm6qXuNVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQzq+M45F7L9MdHpiWA9RQ3kAUrVvjubHyemIgX6hOrWdU1D0
	51g10MwtZZ+xymtz17k202VAOJzo+fxKHW1rU+FIrKajp0ITyOF+MxzUd1m6K3ExGg==
X-Gm-Gg: AZuq6aLeE0/r2mdoC1Y7S1dG1k/XYEidT8SdDXyTT65gOTzV9l1F4R/ov5Dqrnfa6oq
	YRS3C2Ban3SgIyCUU7yV4QIo1iXLbEUngRYkj7IFlHfH4/YWnXR0BB7cWp4N5OcqXSdCFp79y+O
	xxTLMmSZLaHO6abYQ91gLKvrmEYH3tkgPprTPowpxtXY9skX7OLHPENZZbc0anODTQROTGlH7pf
	rSMSn4C+7X1XW6kvDL4nbN7TMUDwj6T2sxQ/hjiXKuOovhXiyLDsXs0puUEdDj4l4+YWhQXYIA0
	VhfhmQipiHbniQ3Ryv+kzhzYyuxguNCbhcgAUZKixWtM5XfesrN1YATDH8zoErGHTkKfG3/Qg70
	DLV8/cxdPMipGkaAPalttSCIcxtb2ou6j0Iu/wtFhT9oG1o6shOSnpB+ccrUnKSdBdQPHkk1y5U
	+88HbSqJ1RhtrjCHcwcrJWDx5W/28rNBQR7Cal3ASIGrcbHglziDMnVfLRVA2ZJ0UJhGTUF+fBt
	fvTySa1PmNdtVUfKHZErLoOHQ==
X-Received: by 2002:a05:7301:3c0e:b0:2b1:76f9:e094 with SMTP id 5a478bee46e88-2b856938e76mr5615199eec.36.1770684126433;
        Mon, 09 Feb 2026 16:42:06 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:9729:c601:aad0:f373? ([2a00:79e0:2e7c:8:9729:c601:aad0:f373])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c8a8f6sm8501918eec.32.2026.02.09.16.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:42:05 -0800 (PST)
Message-ID: <277e1c95-e221-4c07-a00e-d0f0a1a7553f@google.com>
Date: Mon, 9 Feb 2026 16:42:04 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] power: supply: max77759: add charger driver
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
References: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
 <20260203-max77759-charger-v5-4-b50395376a5f@google.com>
 <3ab2d8cd112441dc1d7ab5097f5b1b64c7e415ab.camel@linaro.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <3ab2d8cd112441dc1d7ab5097f5b1b64c7e415ab.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42377-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitsd@google.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[psy_work.work:url,dowhile0.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F189115BA9
X-Rspamd-Action: no action

Hi Andre',

On 2/4/26 4:49 AM, André Draszik wrote:
> On Tue, 2026-02-03 at 22:50 +0000, Amit Sunil Dhamne via B4 Relay wrote:
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
>>   drivers/power/supply/max77759_charger.c | 777 ++++++++++++++++++++++++++++++++
>>   4 files changed, 795 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 67db88b04537b431c927b73624993233eef43e3f..7f6d1c5c2569a1d1536642b075b3e6939553382a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15553,6 +15553,12 @@ F:	drivers/mfd/max77759.c
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
>> index 92f9f7aae92f249aa165e68dbcd4cebb569286ea..3a2cdb95c98e44324151ac2b86d740ae2923ee77 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -631,6 +631,17 @@ config CHARGER_MAX77705
>>   	help
>>   	  Say Y to enable support for the Maxim MAX77705 battery charger.
>>   
>> +config CHARGER_MAX77759
>> +	tristate "Maxim MAX77759 battery charger driver"
>> +	depends on MFD_MAX77759 && REGULATOR
>> +	default MFD_MAX77759
>> +	help
>> +	  Say M or Y here to enable the MAX77759 battery charger. MAX77759
>> +	  charger is a function of the MAX77759 PMIC. This is a dual input
>> +	  switch-mode charger. This driver supports buck and OTG boost modes.
>> +
>> +	  If built as a module, it will be called max77759_charger.
>> +
>>   config CHARGER_MAX77976
>>   	tristate "Maxim MAX77976 battery charger driver"
>>   	depends on I2C
>> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
>> index 4b79d5abc49a7fd1e37a26d0c89f94d9fe3a916f..6af905875ad5e3b393a7030405355b9a975870f6 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
>>   obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
>>   obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
>>   obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
>> +obj-$(CONFIG_CHARGER_MAX77759)	+= max77759_charger.o
>> diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..8c7465c1e7cdd0ff7e8d2a134752ebf7812f28ac
>> --- /dev/null
>> +++ b/drivers/power/supply/max77759_charger.c
>> @@ -0,0 +1,777 @@
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
>> +#include <linux/linear_range.h>
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
>> +#include <linux/workqueue.h>
>> +
>> +/* Default values for Fast Charge Current & Float Voltage */
>> +#define CHG_CC_DEFAULT_UA			2266770
>> +#define CHG_FV_DEFAULT_MV			4300
>> +
>> +#define MAX_NUM_RETRIES				3
>> +#define PSY_WORK_RETRY_DELAY_MS			10
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
>> +#define NUM_IRQS			ARRAY_SIZE(chgr_irqs_str)
>> +
>> +enum {
>> +	MAX77759_CHGR_RANGE_CHGCC,
>> +	MAX77759_CHGR_RANGE_CHG_CV_PRM_LO,
>> +	MAX77759_CHGR_RANGE_CHG_CV_PRM_HI,
>> +	MAX77759_CHGR_RANGE_CHGIN_ILIM,
>> +};
>> +
>> +static const struct linear_range chg_ranges[] = {
>> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHGCC, MAX77759_CHGR_CHGCC_MIN_UA,
>> +			 MAX77759_CHGR_CHGCC_MIN_REG,
>> +			 MAX77759_CHGR_CHGCC_MAX_REG,
>> +			 MAX77759_CHGR_CHGCC_STEP_UA),
>> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHG_CV_PRM_LO,
>> +			 MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV,
>> +			 MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG,
>> +			 MAX77759_CHGR_CHG_CV_PRM_LO_MAX_REG,
>> +			 MAX77759_CHGR_CHG_CV_PRM_LO_STEP_MV),
>> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHG_CV_PRM_HI,
>> +			 MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV,
>> +			 MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG,
>> +			 MAX77759_CHGR_CHG_CV_PRM_HI_MAX_REG,
>> +			 MAX77759_CHGR_CHG_CV_PRM_HI_STEP_MV),
>> +	LINEAR_RANGE_IDX(MAX77759_CHGR_RANGE_CHGIN_ILIM,
>> +			 MAX77759_CHGR_CHGIN_ILIM_MIN_UA,
>> +			 MAX77759_CHGR_CHGIN_ILIM_MIN_REG,
>> +			 MAX77759_CHGR_CHGIN_ILIM_MAX_REG,
>> +			 MAX77759_CHGR_CHGIN_ILIM_STEP_UA),
>> +};
> I wouldn't use macros for the selectors and values, as that makes it very
> hard to reason about. Please see existing regulator and power supply
> drivers, which almost all use the values directly for legibility. Then you
> can also drop them from the header file.

Sounds good.


> Also, the linear range APIs support arrays of ranges, so
> MAX77759_CHGR_RANGE_CHG_CV_PRM_LO and MAX77759_CHGR_RANGE_CHG_CV_PRM_HI
> could be moved into their own range[], allowing to simplify some code
> below.

I think I will create separate linear_range_array[] instance for each of 
{fast_charge_current, chg_cv_prm and chgin_ilim}. It seems to be cleaner 
and can help with limit checks.


>> +
>> +struct max77759_charger {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct power_supply *psy;
>> +	struct regulator_dev *chgin_otg_rdev;
>> +	struct notifier_block nb;
>> +	struct power_supply *tcpm_psy;
>> +	struct delayed_work psy_work;
>> +	u32 psy_work_retry_cnt;
>> +	int irqs[NUM_IRQS];
>> +	struct mutex lock; /* protects the state below */
>> +	enum max77759_chgr_mode mode;
>> +};
>> +
>> +static inline int unlock_prot_regs(struct max77759_charger *chg, bool unlock)
>> +{
>> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_06,
>> +				  MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT, unlock
>> +				  ? MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT : 0);
>> +}
>> +
>> +static int charger_input_valid(struct max77759_charger *chg)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return (val & MAX77759_CHGR_REG_CHG_INT_CHG) &&
>> +		(val & MAX77759_CHGR_REG_CHG_INT_CHGIN);
>> +}
>> +
>> +static int get_online(struct max77759_charger *chg)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = charger_input_valid(chg);
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_02, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	guard(mutex)(&chg->lock);
>> +	return (val & MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS) &&
>> +		(chg->mode == MAX77759_CHGR_MODE_CHG_BUCK_ON);
>> +}
>> +
>> +static int get_status(struct max77759_charger *chg)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS, val)) {
>> +	case MAX77759_CHGR_CHG_DTLS_PREQUAL:
>> +	case MAX77759_CHGR_CHG_DTLS_CC:
>> +	case MAX77759_CHGR_CHG_DTLS_CV:
>> +	case MAX77759_CHGR_CHG_DTLS_TO:
>> +		return POWER_SUPPLY_STATUS_CHARGING;
>> +	case MAX77759_CHGR_CHG_DTLS_DONE:
>> +		return POWER_SUPPLY_STATUS_FULL;
>> +	case MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:
>> +	case MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
>> +	case MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
>> +	case MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:
>> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
>> +	case MAX77759_CHGR_CHG_DTLS_OFF:
>> +		return POWER_SUPPLY_STATUS_DISCHARGING;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return POWER_SUPPLY_STATUS_UNKNOWN;
>> +}
>> +
>> +static int get_charge_type(struct max77759_charger *chg)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS, val)) {
>> +	case MAX77759_CHGR_CHG_DTLS_PREQUAL:
>> +		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
>> +	case MAX77759_CHGR_CHG_DTLS_CC:
>> +	case MAX77759_CHGR_CHG_DTLS_CV:
>> +		return POWER_SUPPLY_CHARGE_TYPE_FAST;
>> +	case MAX77759_CHGR_CHG_DTLS_TO:
>> +		return POWER_SUPPLY_CHARGE_TYPE_STANDARD;
>> +	case MAX77759_CHGR_CHG_DTLS_DONE:
>> +	case MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:
>> +	case MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
>> +	case MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
>> +	case MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:
>> +	case MAX77759_CHGR_CHG_DTLS_OFF:
>> +		return POWER_SUPPLY_CHARGE_TYPE_NONE;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
>> +}
>> +
>> +static int get_chg_health(struct max77759_charger *chg)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_00, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_OO_CHGIN_DTLS, val)) {
>> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
>> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE:
>> +		return POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
>> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE:
>> +		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>> +	case MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID:
>> +		return POWER_SUPPLY_HEALTH_GOOD;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return POWER_SUPPLY_HEALTH_UNKNOWN;
>> +}
>> +
>> +static int get_batt_health(struct max77759_charger *chg)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_BAT_DTLS, val)) {
>> +	case MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP:
>> +		return POWER_SUPPLY_HEALTH_NO_BATTERY;
>> +	case MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY:
>> +		return POWER_SUPPLY_HEALTH_DEAD;
>> +	case MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT:
>> +		return POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
>> +	case MAX77759_CHGR_BAT_DTLS_BAT_OKAY:
>> +	case MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE:
>> +		return POWER_SUPPLY_HEALTH_GOOD;
>> +	case MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE:
>> +		return POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
>> +	case MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE:
>> +		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>> +	case MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT:
>> +		return POWER_SUPPLY_HEALTH_OVERCURRENT;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return POWER_SUPPLY_HEALTH_UNKNOWN;
>> +}
>> +
>> +static int get_health(struct max77759_charger *chg)
>> +{
>> +	int ret;
>> +
>> +	ret = get_online(chg);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (ret) {
>> +		ret = get_chg_health(chg);
>> +		if (ret < 0 || ret != POWER_SUPPLY_HEALTH_GOOD)
>> +			return ret;
>> +	}
>> +
>> +	return get_batt_health(chg);
>> +}
>> +
>> +static int get_fast_charge_current(struct max77759_charger *chg)
>> +{
>> +	u32 regval, val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_02, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
>> +	if (regval <= MAX77759_CHGR_CHGCC_MIN_REG)
>> +		return MAX77759_CHGR_CHGCC_MIN_UA;
> I'd reference your linear range here, instead of open-coding/duplicating,
> making it less likely to reference a wrong value, or helping to avoid mistakes
> if chg_ranges[] ever changed in the future:
>
> +	if (regval < chg_ranges[MAX77759_CHGR_RANGE_CHGCC].min_sel)
> +		return chg_ranges[MAX77759_CHGR_RANGE_CHGCC].min;

I think with the new changes I am coming up with this limit check may 
not be needed.


>
>> +
>> +	ret = linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHGCC],
>> +				     regval, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ret ? ret : val;
> The above is duplicating the test of ret. How about:
>
> +	regval = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
> +	/* use max() here because first few selectors are valid and all same */
> +	regval = max(regval, chg_ranges[MAX77759_CHGR_RANGE_CHGCC].min_sel);
> +	
> +	ret = linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHGCC],
> +				     regval, &val);
> +
> +	return ret ? ret : val;

Thanks for the suggestion. Will fix.


>> +}
>> +
>> +static int set_fast_charge_current_limit(struct max77759_charger *chg,
>> +					 u32 cc_max_ua)
>> +{
>> +	bool found;
>> +	u32 regval;
>> +	int ret;
>> +
>> +	ret = linear_range_get_selector_high(&chg_ranges[MAX77759_CHGR_RANGE_CHGCC],
>> +					     cc_max_ua, &regval, &found);
>> +	if (!found)
>> +		return -EINVAL;
>> +
>> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_02,
>> +				  MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
>> +}
>> +
>> +static int get_float_voltage(struct max77759_charger *chg)
>> +{
>> +	u32 regval, val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_04, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM, regval);
>> +	switch (regval) {
>> +	case MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG ... MAX77759_CHGR_CHG_CV_PRM_HI_MAX_REG:
>> +		ret = linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHG_CV_PRM_HI],
>> +					     regval, &val);
>> +		break;
>> +	case MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG ... MAX77759_CHGR_CHG_CV_PRM_LO_MAX_REG:
>> +		ret = linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHG_CV_PRM_LO],
>> +					     regval, &val);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret ? ret : val;
>> +}
> For the case statements, I'd again reference each linear range's .min_sel
> and .max_sel here, instead of open-coding.
>
> That said, if you switched to using linear_range_get_value_array() instead
> of manually determining which range to use, you wouldn't need the switch
> statement in the first place.

Will fix.


>> +
>> +static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_mv)
>> +{
>> +	u32 regval;
>> +	bool found;
>> +	int ret;
>> +
>> +	if (fv_mv >= MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV &&
>> +	    fv_mv <= MAX77759_CHGR_CHG_CV_PRM_LO_MAX_MV) {
>> +		ret = linear_range_get_selector_high(&chg_ranges[MAX77759_CHGR_RANGE_CHG_CV_PRM_LO],
>> +						     fv_mv, &regval, &found);
>> +	} else if (fv_mv >= MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV &&
>> +		   fv_mv <= MAX77759_CHGR_CHG_CV_PRM_HI_MAX_MV) {
>> +		ret = linear_range_get_selector_high(&chg_ranges[MAX77759_CHGR_RANGE_CHG_CV_PRM_HI],
>> +						     fv_mv, &regval, &found);
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!found)
>> +		return -EINVAL;
> If you're only going by found, you don't need ret.
>
> Is there an underlying reason to use linear_range_get_selector_high()?
> Could it use linear_range_get_selector_low_array() instead? Or maybe
> it'd make sense to introduce a linear_range_get_selector_high_array()?

I want to use the rounded_up value. I will implement the 
linear_range_get_selector_high_array().


>
>> +
>> +	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_04,
>> +				  MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM,
>> +				  regval);
>> +}
>> +
>> +static int get_input_current_limit(struct max77759_charger *chg)
>> +{
>> +	u32 regval, val;
>> +	int ret;
>> +
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09, &regval);
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM, regval);
>> +	if (regval <= MAX77759_CHGR_CHGIN_ILIM_MIN_REG)
>> +		return MAX77759_CHGR_CHGIN_ILIM_MIN_UA;
>> +
>> +	ret = linear_range_get_value(&chg_ranges[MAX77759_CHGR_RANGE_CHGIN_ILIM],
>> +				     regval, &val);
>> +
>> +	return ret ? ret : val;
> Similar to get_fast_charge_current() above.

Will fix.


>> +}
>> +
>> +static int set_input_current_limit(struct max77759_charger *chg, int ilim_ua)
>> +{
>> +	u32 regval;
>> +
>> +	if (ilim_ua < 0)
>> +		return -EINVAL;
>> +
>> +	linear_range_get_selector_within(&chg_ranges[MAX77759_CHGR_RANGE_CHGIN_ILIM],
>> +					 ilim_ua, &regval);
>> +
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
>> +	int i;
>> +
>> +	for (i = 0; i < NUM_IRQS && chg->irqs[i] != irq; i++)
>> +		;
>> +
>> +	if (i == NUM_IRQS) {
>> +		dev_err(dev, "Unable to handle irq=%d", irq);
> This needs to be dev_err_ratelimited() as mentioned before. You don't want
> to render the system unusable due to excessive potential logging.

Will fix.


>
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	if (i == BAT_OILO)
>> +		dev_warn(dev, "Battery over-current threshold crossed");
> dev_warn_ratelimited()

Will fix.


>
>> +
>> +	power_supply_changed(chg->psy);
>> +	return IRQ_HANDLED;
>> +}
> It seems the i==NUM_IRQS test is only required because it's trying to
> figure out if it is the BAT_OILO irq. How about instead:

It's also checking if this irq handler callback is called with a valid 
irq number. But I think that may not be required as it's redundant.


>
>
> static irqreturn_t irq_handler(int irq, void *data)
> {
> 	struct max77759_charger *chg = data;
>
> 	power_supply_changed(chg->psy);
>
> 	return IRQ_HANDLED;
> }
>
> static irqreturn_t bat_oilo_irq_handler(int irq, void *data)
> {
> 	struct max77759_charger *chg = data;
>
> 	dev_warn_ratelimited(chg->dev, "Battery over-current threshold crossed");
>
> 	return irq_handler(irq, data);
> }
>
> and then in max77759_init_irqhandler(), you pick bat_oilo_irq_handler()
> for i==BAT_OILO and irq_handler() otherwise? This way, lots of unnecessary
> tests are avoided for the usual cases, and even for unexpected ones.
>
> Would that work?

LGTM. Will fix.


>
>> +
>> +static int max77759_init_irqhandler(struct max77759_charger *chg)
>> +{
>> +	struct device *dev = chg->dev;
>> +	int i, ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(chgr_irqs_str); i++) {
>> +		ret = platform_get_irq_byname(to_platform_device(dev),
>> +					      chgr_irqs_str[i]);
>> +		if (ret < 0)
>> +			return dev_err_probe(dev, ret,
>> +					     "Failed to get irq resource for %s",
>> +					     chgr_irqs_str[i]);
>> +
>> +		chg->irqs[i] = ret;
>> +		ret = devm_request_threaded_irq(dev, chg->irqs[i], NULL,
>> +						irq_handler, 0, dev_name(dev),
>> +						chg);
> Could you supplement dev_name() here with the irq description please,
> to e.g. give more meaningful output in /proc/interrupts etc:
>
> 	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", dev_name(dev),
> 			      chgr_irqs_str[i]);
>
> (+ error handling), and then use name in the request irq call instead of
> dev_name(dev).

Will fix.


>
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "Unable to register irq handler for %s",
>> +					     chgr_irqs_str[i]);
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
>> +	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval);
>> +	if (ret)
>> +		return ret;
>> +
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
>> +	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
>> +				 MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
>> +				 MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return unlock_prot_regs(chg, false);
>> +}
>> +
>> +static void psy_work_item(struct work_struct *work)
>> +{
>> +	struct max77759_charger *chg =
>> +		container_of(work, struct max77759_charger, psy_work.work);
>> +	union power_supply_propval current_limit, online;
>> +	int ret;
>> +
>> +	ret = power_supply_get_property(chg->tcpm_psy,
>> +					POWER_SUPPLY_PROP_CURRENT_MAX,
>> +					&current_limit);
>> +	if (ret) {
>> +		dev_err(chg->dev,
>> +			"Failed to get CURRENT_MAX psy property, ret=%d",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	ret = power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLINE,
>> +					&online);
>> +	if (ret) {
>> +		dev_err(chg->dev,
>> +			"Failed to get ONLINE psy property, ret=%d",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	if (online.intval && current_limit.intval) {
>> +		ret = set_input_current_limit(chg, current_limit.intval);
>> +		if (ret) {
>> +			dev_err(chg->dev,
>> +				"Unable to set current limit, ret=%d", ret);
>> +			goto err;
>> +		}
>> +
>> +		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
>> +	} else {
>> +		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
>> +	}
>> +
>> +	chg->psy_work_retry_cnt = 0;
>> +	return;
>> +
>> +err:
>> +	charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
>> +	if (chg->psy_work_retry_cnt >= MAX_NUM_RETRIES)
>> +		return;
> I'd say this final giving up could benefit from a dev_err(), while ...

I want to clarify if you want me to add this final giving up print just 
once or every time I am returning early?


>
>> +
>> +	++chg->psy_work_retry_cnt;
>> +	dev_err(chg->dev, "Retrying %u/%u chg psy_work",
>> +		chg->psy_work_retry_cnt, MAX_NUM_RETRIES);
> ... this one could be demoted (but doesn't have to).
>
> That'd make it easier to determine if it's still in the process of
> trying, or if it has given up fully.

I was assuming the printing of "3/3" would indicate the final giving up 
and sufficient.


>
>> +	schedule_delayed_work(&chg->psy_work,
>> +			      msecs_to_jiffies(PSY_WORK_RETRY_DELAY_MS));
>> +}
>> +
>> +static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
>> +{
>> +	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
>> +						    nb);
>> +	static const char *psy_name = "tcpm-source";
>> +	struct power_supply *psy = data;
>> +
>> +	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
>> +	    evt != PSY_EVENT_PROP_CHANGED)
>> +		return NOTIFY_OK;
>> +
>> +	chg->tcpm_psy = psy;
> Do you need locking here? What if this is changed while a previous
> psy_work_item() is still executing?

I  don't think that's ever possible in this case though. The power 
supply that this driver registers is downstream of the tcpm's. I could 
possibly optimize this by means of conditional initialization.


BR,

Amit

>
> Cheers,
> Andre'
>
>
>> +	schedule_delayed_work(&chg->psy_work, 0);
>> +
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
>> +	ret = devm_delayed_work_autocancel(dev, &chg->psy_work, psy_work_item);
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
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to add devm action to unregister psy notifier");
>> +
>> +	return max77759_init_irqhandler(chg);
>> +}
>> +
>> +static const struct platform_device_id max77759_charger_id[] = {
>> +	{ .name = "max77759-charger", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, max77759_charger_id);
>> +
>> +static struct platform_driver max77759_charger_driver = {
>> +	.driver = {
>> +		.name = "max77759-charger",
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +	.probe = max77759_charger_probe,
>> +	.id_table = max77759_charger_id,
>> +};
>> +module_platform_driver(max77759_charger_driver);
>> +
>> +MODULE_AUTHOR("Amit Sunil Dhamne <amitsd@google.com>");
>> +MODULE_DESCRIPTION("Maxim MAX77759 charger driver");
>> +MODULE_LICENSE("GPL");

