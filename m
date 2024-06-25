Return-Path: <linux-pm+bounces-9935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F491607E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E5AB21F6C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF01146D7C;
	Tue, 25 Jun 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihFDOdlD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35C146A86
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302212; cv=none; b=qBFqRZ57vZoWRKEqMwTFdCXXBZLp9x8HnZ4CADr4ED3gKXe6lYY5Dnq0oHu39K7AEsjXXle+xWWonqYD4faCXta0mIcXYxd03bEFb1ekuJocKE9Jll5p54EqYtqRs7HDUf5uY3s37AvJIHGdYcjjsHGM3JDYSbieepUoXJgzeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302212; c=relaxed/simple;
	bh=Er54hzoJL/uBqscVhrnJB4RPDvTokiz2zlLnOKZuEeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i99eeVze3vvvR0ZWO1Hn+w+JJkMHkY80RuFohzHW2a2U3reQBMREesM3KfGUAF5g+WC+jW2d7SNaukNJ8satpQfeqPueD9dkW3MWeLj9UnmBSJQ8CYaeosTzD5Bco6X+nTOdBBXwtZd8FyF5l3eUGG5joEJuoFPh7Rp850fxtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ihFDOdlD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9b52ef481so42149375ad.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719302208; x=1719907008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IEOsHLG09FJ166d3yJqKGK3joSXVHY47hFt5h8JjELw=;
        b=ihFDOdlD24gpdN5Fv8teF4iq8uMQgrqBnWrzdNZTyhA5bFySlSSD4UK5Q3oGhAczKb
         AMG95q68Nb4/5+x57nDMD4LGKk8oK53SIhJ5tL1papflRZGqU8j18QokNahEuEu6UY1n
         DFrEbxnQBAw7fh+BeqTSrJy4SzpDoIIhIVAoEJdan3POQVIeOvgCFRrBWa7nKZfjHWAY
         PU94lpH0XleurKTL5kOf/MhROEf4K7FHSMy0ivm8iZObakLsHrMyRpGkYbLKHMbD5SD2
         fvHt7CaXsgxd+nossTv4pDu3Acihg49yjcRIY6JUuQom28WSY9Sup4I+/+oQ5RBn5GTh
         2nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302208; x=1719907008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEOsHLG09FJ166d3yJqKGK3joSXVHY47hFt5h8JjELw=;
        b=W3zkKwOqCR0PrN6fE0tNZqlAZx0rk9DMR4vcAqgBARbcn1EBamW9bxcM80ch/UHgG+
         eNhNeIFWH9DZ6NKEO3XBHxacfQT4xzcWHX6u05Un2DPsKh50jXSGLJ2CEi5A9bh02Bmo
         CKR3KJOmXfERdEe2LnVn2g66y6xgbuIuUd6/dfKZzUYmj1uXihySzAGkI+FLAgHXoTMd
         GNhG+eRuL+zwwOJlOCZgPVq9iqkU9aB+XJm0zC2EVO1fMDWYSEos1eJHCSQVXWjLvCWj
         JeyWouw9qAiELbR4G1Rte3rjssjrBNzr963c41QNtil52tyDaexv4/LPs4ncowPMa6+b
         Alyg==
X-Forwarded-Encrypted: i=1; AJvYcCVOUzEB82ZgD8wojHVuCJaQDhFQFl8fy3PPmYeHKgnaO3y/UKA2rJbiGk/MBhAAsX5i16iQ1tkToKMI6ASp1YPDrGtt1MQqFek=
X-Gm-Message-State: AOJu0YzMYr5jtteO2+MrgaJzodr2mLe8oSJFbNW6j89O8guD6RhqCZA2
	ggPiJLMvhcUVP55CWANsKqwgKlerkS9iz1VPr3dixB+BbQDNN+uYgoUa+BzWVhA=
X-Google-Smtp-Source: AGHT+IGEp15Jfy3REpH/U6UeTo/Wcw4MB9bvqxwK9Qh1Za/yONGMRp85aZ2O5Nx+Mef6DjIyKoOjXw==
X-Received: by 2002:a17:902:f54c:b0:1f7:3763:5ffb with SMTP id d9443c01a7336-1fa23f2696dmr78289395ad.59.1719302208164;
        Tue, 25 Jun 2024 00:56:48 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7ccasm74462435ad.299.2024.06.25.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:56:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:26:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
Message-ID: <20240625075645.m372bpbe7m2dozil@vireshk-i7>
References: <20240612064205.2041548-1-chenhuacai@loongson.cn>
 <20240612064205.2041548-3-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612064205.2041548-3-chenhuacai@loongson.cn>

On 12-06-24, 14:42, Huacai Chen wrote:
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
>  drivers/cpufreq/Kconfig             |  12 +
>  drivers/cpufreq/Makefile            |   1 +
>  drivers/cpufreq/loongson3_cpufreq.c | 442 ++++++++++++++++++++++++++++
>  3 files changed, 455 insertions(+)
>  create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aacccb376c28..f2e47ec28d77 100644
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
> index 000000000000..5dbac0d55a32
> --- /dev/null
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -0,0 +1,442 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CPUFreq driver for the loongson-3 processors
> + *
> + * All revisions of Loongson-3 processor support this feature.
> + *
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
> + */
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
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
> +struct loongson3_freq_data {
> +	unsigned int cur_cpu_freq;

You never use it. Remove it.

> +	struct cpufreq_frequency_table table[];
> +};
> +
> +static struct mutex cpufreq_mutex[MAX_PACKAGES];
> +static struct cpufreq_driver loongson3_cpufreq_driver;
> +static DEFINE_PER_CPU(struct loongson3_freq_data *, freq_data);
> +
> +static inline int do_service_request(union smc_message *msg)
> +{
> +	int retries;
> +	union smc_message last;
> +
> +	last.value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +	if (!last.complete)
> +		return -EPERM;
> +
> +	iocsr_write32(msg->value, LOONGARCH_IOCSR_SMCMBX);
> +	iocsr_write32(iocsr_read32(LOONGARCH_IOCSR_MISC_FUNC) | IOCSR_MISC_FUNC_SOFT_INT,
> +		      LOONGARCH_IOCSR_MISC_FUNC);
> +
> +	for (retries = 0; retries < 10000; retries++) {
> +		msg->value = iocsr_read32(LOONGARCH_IOCSR_SMCMBX);
> +		if (msg->complete)
> +			break;
> +
> +		usleep_range(8, 12);
> +	}
> +
> +	if (!msg->complete || msg->cmd != CMD_OK)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static unsigned int loongson3_cpufreq_get(unsigned int cpu)
> +{
> +	union smc_message msg;
> +
> +	msg.id		= cpu;
> +	msg.info	= FREQ_INFO_TYPE_FREQ;
> +	msg.cmd		= CMD_GET_FREQ_INFO;
> +	msg.extra	= 0;
> +	msg.complete	= 0;
> +	do_service_request(&msg);
> +
> +	per_cpu(freq_data, cpu)->cur_cpu_freq = msg.val * KILO;
> +
> +	return per_cpu(freq_data, cpu)->cur_cpu_freq;
> +}
> +
> +static int loongson3_cpufreq_set(struct cpufreq_policy *policy, int freq_level)
> +{
> +	union smc_message msg;
> +
> +	msg.id		= cpu_data[policy->cpu].core;
> +	msg.info	= FREQ_INFO_TYPE_LEVEL;
> +	msg.val		= freq_level;
> +	msg.cmd		= CMD_SET_FREQ_INFO;
> +	msg.extra	= 0;
> +	msg.complete	= 0;
> +	do_service_request(&msg);
> +
> +	return 0;
> +}
> +
> +/*
> + * Here we notify other drivers of the proposed change and the final change.
> + */
> +static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
> +{
> +	unsigned int cpu = policy->cpu;
> +	unsigned int package = cpu_data[cpu].package;
> +
> +	if (!cpu_online(cpu))

No need to check this.

> +		return -ENODEV;
> +
> +	/* setting the cpu frequency */
> +	mutex_lock(&cpufreq_mutex[package]);

No locking required here. Core doesn't call them in parallel.

> +	loongson3_cpufreq_set(policy, index);
> +	mutex_unlock(&cpufreq_mutex[package]);
> +
> +	return 0;
> +}
> +
> +static int loongson3_cpufreq_get_freq_table(int cpu)
> +{
> +	union smc_message msg;
> +	int i, ret, boost_level, max_level, freq_level;
> +	struct loongson3_freq_data *data;
> +
> +	if (per_cpu(freq_data, cpu))
> +		return 0;

Will this ever be true ?

> +
> +	msg.id		= cpu;
> +	msg.cmd		= CMD_GET_FREQ_LEVEL_NUM;
> +	msg.extra	= 0;
> +	msg.complete	= 0;
> +	ret = do_service_request(&msg);
> +	if (ret < 0)
> +		return ret;
> +	max_level = msg.val;
> +


> +	msg.id		= cpu;
> +	msg.cmd		= CMD_GET_FREQ_BOOST_LEVEL;
> +	msg.extra	= 0;
> +	msg.complete	= 0;
> +	ret = do_service_request(&msg);
> +	if (ret < 0)
> +		return ret;
> +	boost_level = msg.val;

This stuff is repeated a lot, maybe create a generic function for this
?

> +
> +	freq_level = min(max_level, FREQ_MAX_LEVEL);
> +	data = kzalloc(struct_size(data, table, freq_level + 1), GFP_KERNEL);

devm_kzalloc(pdev, ...) ?

> +	if (!data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < freq_level; i++) {
> +		msg.id		= cpu;
> +		msg.info	= FREQ_INFO_TYPE_FREQ;
> +		msg.cmd		= CMD_GET_FREQ_LEVEL_INFO;
> +		msg.val		= i;
> +		msg.complete	= 0;
> +
> +		ret = do_service_request(&msg);
> +		if (ret < 0) {
> +			kfree(data);
> +			return ret;
> +		}
> +
> +		data->table[i].frequency = msg.val * KILO;
> +		data->table[i].driver_data = FREQ_LEV0 + i;
> +		data->table[i].flags = (i >= boost_level) ? CPUFREQ_BOOST_FREQ : 0;
> +	}
> +
> +	data->table[freq_level].frequency = CPUFREQ_TABLE_END;
> +	data->table[freq_level].driver_data = FREQ_RESV;
> +	data->table[freq_level].flags = 0;
> +
> +	per_cpu(freq_data, cpu) = data;
> +
> +	return 0;
> +}
> +
> +static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	if (!cpu_online(policy->cpu))

No need to check this. Core takes care of this already.

> +		return -ENODEV;
> +
> +	ret = loongson3_cpufreq_get_freq_table(policy->cpu);
> +	if (ret < 0)
> +		return ret;
> +
> +	policy->cur = loongson3_cpufreq_get(policy->cpu);
> +	policy->cpuinfo.transition_latency = 10000;
> +	policy->freq_table = per_cpu(freq_data, policy->cpu)->table;
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
> +	return 0;
> +}

Just drop the routine, it is optional.

> +
> +static struct cpufreq_driver loongson3_cpufreq_driver = {
> +	.name = "loongson3",
> +	.flags = CPUFREQ_CONST_LOOPS,
> +	.init = loongson3_cpufreq_cpu_init,
> +	.exit = loongson3_cpufreq_cpu_exit,
> +	.verify = cpufreq_generic_frequency_table_verify,
> +	.target_index = loongson3_cpufreq_target,
> +	.get = loongson3_cpufreq_get,
> +	.attr = cpufreq_generic_attr,
> +};
> +
> +static struct platform_device_id cpufreq_id_table[] = {
> +	{ "loongson3_cpufreq", },
> +	{ /* sentinel */ }
> +};
> +

Remove this blank line please.

> +MODULE_DEVICE_TABLE(platform, cpufreq_id_table);
> +
> +static struct platform_driver loongson3_platform_driver = {
> +	.driver = {
> +		.name = "loongson3_cpufreq",
> +	},
> +	.id_table = cpufreq_id_table,
> +};
> +
> +static int configure_cpufreq_info(void)
> +{
> +	int ret;
> +	union smc_message msg;
> +
> +	msg.cmd		= CMD_GET_VERSION;
> +	msg.extra	= 0;
> +	msg.complete	= 0;
> +	ret = do_service_request(&msg);
> +	if (ret < 0 || msg.val < 0x1)
> +		return -EPERM;
> +
> +	msg.id		= FEATURE_DVFS;
> +	msg.cmd		= CMD_SET_FEATURE;
> +	msg.val		= FEATURE_DVFS_ENABLE | FEATURE_DVFS_BOOST;
> +	msg.extra	= 0;
> +	msg.complete	= 0;
> +	ret = do_service_request(&msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __init cpufreq_init(void)
> +{
> +	int i, ret;
> +
> +	ret = platform_driver_register(&loongson3_platform_driver);
> +	if (ret)
> +		return ret;

What is the use of this platform driver ? I thought the whole purpose
of the platform device/driver in your case was to probe this driver.
In that case cpufreq_init() should only be doing above and not the
below part. The rest should be handled in the probe() function of the
driver.

> +
> +	ret = configure_cpufreq_info();
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < MAX_PACKAGES; i++)
> +		mutex_init(&cpufreq_mutex[i]);

You don't need this at all.

> +
> +	ret = cpufreq_register_driver(&loongson3_cpufreq_driver);
> +	if (ret)
> +		goto err;
> +
> +	pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");

Make this pr_debug if you want.. There is not much use of this for the
user.

> +
> +	return 0;
> +
> +err:
> +	platform_driver_unregister(&loongson3_platform_driver);
> +	return ret;
> +}
> +
> +static void __exit cpufreq_exit(void)
> +{
> +	cpufreq_unregister_driver(&loongson3_cpufreq_driver);
> +	platform_driver_unregister(&loongson3_platform_driver);
> +}
> +
> +module_init(cpufreq_init);
> +module_exit(cpufreq_exit);

You can just use: module_platform_driver() instead of above functions
and declarations.

> +
> +MODULE_AUTHOR("Huacai Chen <chenhuacai@loongson.cn>");
> +MODULE_DESCRIPTION("CPUFreq driver for Loongson-3 processors");
> +MODULE_LICENSE("GPL");

-- 
viresh

