Return-Path: <linux-pm+bounces-10521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40324925835
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A642BB25DEF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7D143744;
	Wed,  3 Jul 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VynSvlwP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BE142621
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001935; cv=none; b=J3JFh1uaCL9eNYUPrHSCJ/wXTbH/P9OJiR7VG491YvFcMky8dYD2vL2PVK8Dro+bCAtYSXknJ7tJGo+pRX3byWGWP8Vl77rnqe7t2twb6t6sokYMYBbIP3mydxNHgTipMLD9mqkMva+i2XICK+MFPiYbkS2hX3DsXYDnpbUFdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001935; c=relaxed/simple;
	bh=1BRxzCBctOyS3X4Tiksjd16ELjUs53AI5nxvo9UTsWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0bT8WvSEkdi6DBhLR64kHYTPVA+tPWENIc3nXbhHPsR7vsW9ds+tYFeWnYXqImOkK8eOubqfOXzoH1T6P+Dc3+mlv3mONjxRYV4nr2dawqS7Yho2x6Pi0gBzECEJD5DAklwMgpICFr1gjp8L9I63Ey/563/pvnKb3biTQY70Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VynSvlwP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa244db0b2so40988675ad.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001933; x=1720606733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdinxnkWP6EaaM3lF/TL5UpIWG0AtYiRqRNtIRJ/QlE=;
        b=VynSvlwPhIqzE5aQlNia66rQCmftu5pIWiaiKOzWgJspw/N0JpoNM9bRlBag61OXYj
         DrAAdGwNPpQIZHia7Xb37mkKA7wOSMH4MxRRoouzylheaJCSbmnBL+6hO+pMI3AqewxT
         bK89NiswKweu/faL3rZXY3E01RwscqaofzLq5GxMkZRqhvZA5ggzeFdHYneFjeb12ZT9
         7QRpF2VnRtRWDxAx/pnmFyJARr4IFBK4wTilX8aoNl1O6rMmtt52fynMCxN+edo4zLgB
         sPiwg1A2Nrsb2pmXQwyUG3E6V+LOP+pz/lAvgLM7rAuEGyvPIvDb5C1+gkG+umkwNKl8
         xb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001933; x=1720606733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdinxnkWP6EaaM3lF/TL5UpIWG0AtYiRqRNtIRJ/QlE=;
        b=ALYwm4YDZzSGtlzpRGQ8ARF3+sR/py/aOAAM1p2WAolzQzZ4KpzVk/UuTBNxor9bJn
         Mpbs2l8yCuaxvMQDmvdCRJpW5wr77CKtIAXoysjBS6c/c7feUaNupO7uFUVcXgxSpFCV
         4LOFleVewrQcAWCz4Hj7DYYeWlj1pCXYnk9BFrkz2HDoZ+8bKeVgeQrx0oN3GFuWBw3J
         6gNDx9kbBK1bQI4lg40pZe9EV/ZXuhLNAE0lL0HH11buW4+ms6hj7xsYsmD1GxAdJEwP
         4KkgLkpkl4AX9UZnYVrXfNYZMlRY+0DAX0HJH5Rg1KwrPCWPh8KenGzY0LUQHvSys8l6
         RAcw==
X-Forwarded-Encrypted: i=1; AJvYcCVrD0micfaX+4Nal4REoWQmoTaGOTPwHeXiqqnpnYM4MG9p5HNW/pO0ZlnI0wm7YtXIfACkl15fUq3MJ0QD0xdna/vwAX3u3w4=
X-Gm-Message-State: AOJu0Yy2qZZQzKQq2U52XISY98FJ//5hv0m/U10r/y1QIr30Zv1vsBqM
	kYWOc/HEpUWGdcLNT4DhVIqblYtCX5je1750IIF0lbuVLXjsTZqz3v8zR5QgEpw=
X-Google-Smtp-Source: AGHT+IEkvL6f83UIL9GGwApdi16O6qSPCG+QyrM1BJf1QQF5ni3fqWJtXbJ3+3UN9bH0t2KUK8Cq8g==
X-Received: by 2002:a17:902:ec8c:b0:1f7:1ae1:cd7a with SMTP id d9443c01a7336-1fadbd11ab6mr91657855ad.62.1720001932917;
        Wed, 03 Jul 2024 03:18:52 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159686csm99852705ad.266.2024.07.03.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:18:52 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:48:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V2 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
Message-ID: <20240703101850.dtck223pleiiwfxp@vireshk-i7>
References: <20240702152737.1184244-1-chenhuacai@loongson.cn>
 <20240702152737.1184244-3-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702152737.1184244-3-chenhuacai@loongson.cn>

On 02-07-24, 23:27, Huacai Chen wrote:
> Some of LoongArch processors (Loongson-3 series) support DVFS, their
> IOCSR.FEATURES has IOCSRF_FREQSCALE set. And they has a micro-core in
> the package called SMC (System Management Controller), which can be
> used to detect temperature, control fans, scale frequency and voltage,
> etc.
> 
> The Loongson-3 CPUFreq driver is very simple now, it communicate with
> SMC, get DVFS info, set target frequency from CPUFreq core, and so on.
> 
> There is a command list to interact with SMC, widely-used commands in
> the CPUFreq driver include:
> 
> CMD_GET_VERSION: Get SMC firmware version.
> 
> CMD_GET_FEATURE: Get enabled SMC features.
> 
> CMD_SET_FEATURE: Enable SMC features, such as basic DVFS, BOOST.
> 
> CMD_GET_FREQ_LEVEL_NUM: Get the number of normal frequency levels.
> 
> CMD_GET_FREQ_BOOST_NUM: Get the number of boost frequency levels.
> 
> CMD_GET_FREQ_LEVEL_INFO: Get the detail info of a frequency level.
> 
> CMD_GET_FREQ_INFO: Get the current frequency.
> 
> CMD_SET_FREQ_INFO: Set the target frequency.
> 
> In future we will add automatic frequency scaling, which is similar to
> Intel's HWP (HardWare P-State).
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/cpufreq/Kconfig             |  12 +
>  drivers/cpufreq/Makefile            |   1 +
>  drivers/cpufreq/loongson3_cpufreq.c | 399 ++++++++++++++++++++++++++++
>  4 files changed, 413 insertions(+)
>  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd2ca0c3158e..2af33319f1ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12968,6 +12968,7 @@ F:	Documentation/arch/loongarch/
>  F:	Documentation/translations/zh_CN/arch/loongarch/
>  F:	arch/loongarch/
>  F:	drivers/*/*loongarch*
> +F:	drivers/cpufreq/loongson3_cpufreq.c
>  
>  LOONGSON GPIO DRIVER
>  M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 94e55c40970a..10cda6f2fe1d 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -262,6 +262,18 @@ config LOONGSON2_CPUFREQ
>  	  If in doubt, say N.
>  endif
>  
> +if LOONGARCH
> +config LOONGSON3_CPUFREQ
> +	tristate "Loongson3 CPUFreq Driver"
> +	help
> +	  This option adds a CPUFreq driver for Loongson processors which
> +	  support software configurable cpu frequency.
> +
> +	  Loongson-3 family processors support this feature.
> +
> +	  If in doubt, say N.
> +endif
> +
>  if SPARC64
>  config SPARC_US3_CPUFREQ
>  	tristate "UltraSPARC-III CPU Frequency driver"
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d141c71b016..0f184031dd12 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -103,6 +103,7 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
>  # Other platform drivers
>  obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
> +obj-$(CONFIG_LOONGSON3_CPUFREQ)		+= loongson3_cpufreq.o
>  obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
>  obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
>  obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> new file mode 100644
> index 000000000000..6d7da2238542
> --- /dev/null
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CPUFreq driver for the loongson-3 processors

A full stop at the end please.

> + *
> + * All revisions of Loongson-3 processor support this feature.

What do you mean by `feature` here ?

> + *
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2024 Loongson Technology Corporation Limited

Can't really use 2020 here. We are adding the driver for the first
time in 2024 only.

> + */
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>

Please keep them in alphabetical order.  And you are missing few other
headers (which are getting included indirectly for now). Like for
mutex. Please cross check all types you are using and include their
headers directly.

> +
> +#include <asm/idle.h>
> +#include <asm/loongarch.h>
> +#include <asm/loongson.h>
> +
> +/* Message */
> +union smc_message {
> +	u32 value;
> +	struct {
> +		u32 id		: 4;
> +		u32 info	: 4;
> +		u32 val		: 16;
> +		u32 cmd		: 6;
> +		u32 extra	: 1;
> +		u32 complete	: 1;
> +	};
> +};
> +
> +/* Command return values */
> +#define CMD_OK				0  /* No error */
> +#define CMD_ERROR			1  /* Regular error */
> +#define CMD_NOCMD			2  /* Command does not support */
> +#define CMD_INVAL			3  /* Invalid Parameter */
> +
> +/* Version commands */
> +/*
> + * CMD_GET_VERSION - Get interface version
> + * Input: none
> + * Output: version
> + */
> +#define CMD_GET_VERSION			0x1
> +
> +/* Feature commands */
> +/*
> + * CMD_GET_FEATURE - Get feature state
> + * Input: feature ID
> + * Output: feature flag
> + */
> +#define CMD_GET_FEATURE			0x2
> +
> +/*
> + * CMD_SET_FEATURE - Set feature state
> + * Input: feature ID, feature flag
> + * output: none
> + */
> +#define CMD_SET_FEATURE			0x3
> +
> +/* Feature IDs */
> +#define FEATURE_SENSOR			0
> +#define FEATURE_FAN			1
> +#define FEATURE_DVFS			2
> +
> +/* Sensor feature flags */
> +#define FEATURE_SENSOR_ENABLE		BIT(0)
> +#define FEATURE_SENSOR_SAMPLE		BIT(1)
> +
> +/* Fan feature flags */
> +#define FEATURE_FAN_ENABLE		BIT(0)
> +#define FEATURE_FAN_AUTO		BIT(1)
> +
> +/* DVFS feature flags */
> +#define FEATURE_DVFS_ENABLE		BIT(0)
> +#define FEATURE_DVFS_BOOST		BIT(1)
> +#define FEATURE_DVFS_AUTO		BIT(2)
> +#define FEATURE_DVFS_SINGLE_BOOST	BIT(3)
> +
> +/* Sensor commands */
> +/*
> + * CMD_GET_SENSOR_NUM - Get number of sensors
> + * Input: none
> + * Output: number
> + */
> +#define CMD_GET_SENSOR_NUM		0x4
> +
> +/*
> + * CMD_GET_SENSOR_STATUS - Get sensor status
> + * Input: sensor ID, type
> + * Output: sensor status
> + */
> +#define CMD_GET_SENSOR_STATUS		0x5
> +
> +/* Sensor types */
> +#define SENSOR_INFO_TYPE		0
> +#define SENSOR_INFO_TYPE_TEMP		1
> +
> +/* Fan commands */
> +/*
> + * CMD_GET_FAN_NUM - Get number of fans
> + * Input: none
> + * Output: number
> + */
> +#define CMD_GET_FAN_NUM			0x6
> +
> +/*
> + * CMD_GET_FAN_INFO - Get fan status
> + * Input: fan ID, type
> + * Output: fan info
> + */
> +#define CMD_GET_FAN_INFO		0x7
> +
> +/*
> + * CMD_SET_FAN_INFO - Set fan status
> + * Input: fan ID, type, value
> + * Output: none
> + */
> +#define CMD_SET_FAN_INFO		0x8
> +
> +/* Fan types */
> +#define FAN_INFO_TYPE_LEVEL		0
> +
> +/* DVFS commands */
> +/*
> + * CMD_GET_FREQ_LEVEL_NUM - Get number of freq levels
> + * Input: CPU ID
> + * Output: number
> + */
> +#define CMD_GET_FREQ_LEVEL_NUM		0x9
> +
> +/*
> + * CMD_GET_FREQ_BOOST_LEVEL - Get number of boost levels
> + * Input: CPU ID
> + * Output: number
> + */
> +#define CMD_GET_FREQ_BOOST_LEVEL	0x10
> +
> +/*
> + * CMD_GET_FREQ_LEVEL_INFO - Get freq level info
> + * Input: CPU ID, level ID
> + * Output: level info
> + */
> +#define CMD_GET_FREQ_LEVEL_INFO		0x11
> +
> +/*
> + * CMD_GET_FREQ_INFO - Get freq info
> + * Input: CPU ID, type
> + * Output: freq info
> + */
> +#define CMD_GET_FREQ_INFO		0x12
> +
> +/*
> + * CMD_SET_FREQ_INFO - Set freq info
> + * Input: CPU ID, type, value
> + * Output: none
> + */
> +#define CMD_SET_FREQ_INFO		0x13
> +
> +/* Freq types */
> +#define FREQ_INFO_TYPE_FREQ		0
> +#define FREQ_INFO_TYPE_LEVEL		1
> +
> +#define FREQ_MAX_LEVEL			(16 + 1)
> +
> +enum freq {
> +	FREQ_LEV0, /* Reserved */
> +	FREQ_LEV1, FREQ_LEV2, FREQ_LEV3, FREQ_LEV4,
> +	FREQ_LEV5, FREQ_LEV6, FREQ_LEV7, FREQ_LEV8,
> +	FREQ_LEV9, FREQ_LEV10, FREQ_LEV11, FREQ_LEV12,
> +	FREQ_LEV13, FREQ_LEV14, FREQ_LEV15, FREQ_LEV16,
> +	FREQ_RESV
> +};
> +
> +static struct mutex cpufreq_mutex[MAX_PACKAGES];
> +static struct cpufreq_driver loongson3_cpufreq_driver;
> +static DEFINE_PER_CPU(struct cpufreq_frequency_table *, freq_table);
> +
> +static inline int do_service_request(u32 id, u32 info, u32 cmd, u32 val, u32 extra)
> +{
> +	int retries;
> +	unsigned int cpu = smp_processor_id();
> +	unsigned int package = cpu_data[cpu].package;
> +	union smc_message msg, last;
> +
> +	mutex_lock(&cpufreq_mutex[package]);
> +
> +	last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +	if (!last.complete) {
> +		mutex_unlock(&cpufreq_mutex[package]);
> +		return -EPERM;
> +	}
> +
> +	msg.id		= id;
> +	msg.info	= info;
> +	msg.cmd		= cmd;
> +	msg.val		= val;
> +	msg.extra	= extra;
> +	msg.complete	= 0;
> +
> +	iocsr_write32(msg.value, LOONGARCH_IOCSR_SMCMBX);
> +	iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MISC_FUNC_SOFT_INT,
> +		      LOONGARCH_IOCSR_MISC_FUNC);
> +
> +	for (retries = 0; retries < 10000; retries++) {
> +		msg.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +		if (msg.complete)
> +			break;
> +
> +		usleep_range(8, 12);
> +	}
> +
> +	if (!msg.complete || msg.cmd != CMD_OK) {
> +		mutex_unlock(&cpufreq_mutex[package]);
> +		return -EPERM;
> +	}
> +
> +	mutex_unlock(&cpufreq_mutex[package]);
> +
> +	return msg.val;

Thanks, this looks much better now.

> +}
> +
> +static unsigned int loongson3_cpufreq_get(unsigned int cpu)
> +{
> +	int ret;
> +
> +	ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_INFO, 0, 0);
> +
> +	return ret * KILO;
> +}
> +
> +static int loongson3_cpufreq_set(struct cpufreq_policy *policy, int freq_level)
> +{
> +	return do_service_request(cpu_data[policy->cpu].core, FREQ_INFO_TYPE_LEVEL, CMD_SET_FREQ_INFO, freq_level, 0);
> +}
> +
> +/*
> + * Here we notify other drivers of the proposed change and the final change.

What do you mean by other drivers here ? I would just drop the
comment.

> + */
> +static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
> +{
> +	/* setting the cpu frequency */

The obvious comments can be dropped.

> +	return loongson3_cpufreq_set(policy, index);

Why use a separate function for calling do_service_request() ? Just
open code it here.

> +}
> +
> +static int loongson3_cpufreq_get_freq_table(int cpu)

If you want to simplify the naming a bit, you can just call all
internal routines without `loongson3_cpufreq_` prefix. Just
create_freq_table() would be appropriate here.

For all routines passed to core, via the cpufreq_driver pointers, you
can keep using the prefix.

> +{
> +	int i, ret, boost_level, max_level, freq_level;
> +	struct cpufreq_frequency_table *table;
> +
> +	if (per_cpu(freq_table, cpu))
> +		return 0;
> +
> +	ret = do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +	max_level = ret;
> +
> +	ret = do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +	boost_level = ret;
> +
> +	freq_level = min(max_level, FREQ_MAX_LEVEL);
> +	table = kzalloc(sizeof(struct cpufreq_frequency_table) * (freq_level + 1), GFP_KERNEL);

devm_kcalloc(pdev, ...) instead ?

sizeof(*table) instead.

Also please run `scripts/checkpatch.pl --strict` on your patches to
find out general formatting issues.

> +	if (!table)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < freq_level; i++) {
> +		ret = do_service_request(cpu, FREQ_INFO_TYPE_FREQ, CMD_GET_FREQ_LEVEL_INFO, i, 0);
> +		if (ret < 0) {
> +			kfree(table);
> +			return ret;
> +		}
> +
> +		table[i].frequency = ret * KILO;

> +		table[i].driver_data = FREQ_LEV0 + i;

I don't think you are using this, you don't have to fill it at all.

> +		table[i].flags = (i >= boost_level) ? CPUFREQ_BOOST_FREQ : 0;
> +	}
> +
> +	table[freq_level].frequency = CPUFREQ_TABLE_END;
> +	table[freq_level].driver_data = FREQ_RESV;
> +	table[freq_level].flags = 0;
> +
> +	per_cpu(freq_table, cpu) = table;
> +
> +	return 0;
> +}
> +
> +static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	ret = loongson3_cpufreq_get_freq_table(policy->cpu);
> +	if (ret < 0)
> +		return ret;
> +
> +	policy->cur = loongson3_cpufreq_get(policy->cpu);

cpufreq core does this during initialization. The drivers don't need
to do it.

> +	policy->cpuinfo.transition_latency = 10000;
> +	policy->freq_table = per_cpu(freq_table, policy->cpu);
> +	cpumask_copy(policy->cpus, topology_sibling_cpumask(policy->cpu));
> +
> +	if (policy_has_boost_freq(policy)) {
> +		ret = cpufreq_enable_boost_support();
> +		if (ret < 0) {
> +			pr_warn("cpufreq: Failed to enable boost: %d\n", ret);
> +			return ret;
> +		}
> +		loongson3_cpufreq_driver.boost_enabled = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int loongson3_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	kfree(policy->freq_table);
> +	return 0;
> +}
> +
> +static int loongson3_cpufreq_cpu_online(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
> +static int loongson3_cpufreq_cpu_offline(struct cpufreq_policy *policy)
> +{
> +	return 0;
> +}
> +
> +static struct cpufreq_driver loongson3_cpufreq_driver = {
> +	.name = "loongson3",
> +	.flags = CPUFREQ_CONST_LOOPS,
> +	.init = loongson3_cpufreq_cpu_init,
> +	.exit = loongson3_cpufreq_cpu_exit,
> +	.online = loongson3_cpufreq_cpu_online,
> +	.offline = loongson3_cpufreq_cpu_offline,
> +	.verify = cpufreq_generic_frequency_table_verify,
> +	.target_index = loongson3_cpufreq_target,
> +	.get = loongson3_cpufreq_get,
> +	.attr = cpufreq_generic_attr,
> +};
> +
> +static int configure_cpufreq_info(void)
> +{
> +	int ret;
> +
> +	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
> +	if (ret <= 0)
> +		return -EPERM;
> +
> +	return do_service_request(FEATURE_DVFS, 0, CMD_SET_FEATURE, FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST, 0);
> +}
> +
> +static int loongson3_cpufreq_probe(struct platform_device *pdev)
> +{
> +	int i, ret;
> +
> +	ret = configure_cpufreq_info();

Maybe just open code the function here.. It is just two function calls
which are quite straight forward.

> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < MAX_PACKAGES; i++)
> +		mutex_init(&cpufreq_mutex[i]);

This must be initialized before calling configure_cpufreq_info() as
you end up using them there.

> +	ret = cpufreq_register_driver(&loongson3_cpufreq_driver);
> +	if (ret)
> +		return ret;
> +
> +	pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");
> +
> +	return 0;
> +}
> +
> +static void loongson3_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&loongson3_cpufreq_driver);
> +}
> +
> +static struct platform_device_id cpufreq_id_table[] = {
> +	{ "loongson3_cpufreq", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, cpufreq_id_table);
> +
> +static struct platform_driver loongson3_platform_driver = {
> +	.driver = {
> +		.name = "loongson3_cpufreq",
> +	},
> +	.id_table = cpufreq_id_table,
> +	.probe = loongson3_cpufreq_probe,
> +	.remove_new = loongson3_cpufreq_remove,
> +};
> +module_platform_driver(loongson3_platform_driver);
> +
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION("CPUFreq driver for Loongson-3 processors");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0

-- 
viresh

