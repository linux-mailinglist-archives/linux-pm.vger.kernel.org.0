Return-Path: <linux-pm+bounces-19521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2C9F7D41
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1C0168F71
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C282253E0;
	Thu, 19 Dec 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEQkaC1x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686341C64;
	Thu, 19 Dec 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619182; cv=none; b=C92Dx3iNbBK0iOc3rHo0f4CTae6eTBZ905aQigbQhJhCgOMBIqhFYxX7CP/ralYQlO2c//i/ZjcCCfOUmbFhI8vwNi6UmYcFoTzzUqf715Ig4CWQSTZG37aCiqdKHvdtLvrO7jnZSS9g8jpMG+QxIiMTTDC5JB0SAu9kS3pMzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619182; c=relaxed/simple;
	bh=S+UfMY1vVhn5lcjqWfM26VYummzYqtnHzdbWrInp4Fo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q1+14U0FhD2h0TuRE7LkqWvuQirpjxkErX3XHHOodYHwFnorRBk50FQLppmhHK7dX9rGL55Ly4VkvP5UTBJH5BmoJNjpIcSREcZUdssslDtD3zT7APzJwEzoQhcrlyLOVe9qyN8KavhPmoC8r4rPz7UMWMkbdlLS0z99KVDBKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEQkaC1x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734619181; x=1766155181;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S+UfMY1vVhn5lcjqWfM26VYummzYqtnHzdbWrInp4Fo=;
  b=ZEQkaC1xxsVpImxBisYiBMo07CLZPzUXUVpanKUV1fq2UNXnfJcXr2d3
   7dRsQhYrGayTxnZ6MJJqc2GXyNgiv3oBry0AznhfqItsNf6lSYXkdyAsv
   G5qWBDWdCZM8LqSbC1xOdUz+FyJ124ySFyZC0MgY8RA9uTQw8KRmTyWG6
   2J6iPxbbe680r7wFz1ND30wzZlHKH0PlFhmmQi7fkaVbQiNu+56K/Yqhr
   uqW4YOhdsZmi5+ac//hToOb9ABewALAvVS5R5WskMUaNv6ITUt1yUE6uO
   FY+/09zHhW9DYLS8cdHK9ovJ2DOGRLuj7HB2MeALCrScPQFs0w6CAumjI
   A==;
X-CSE-ConnectionGUID: ANgfCdjdTJOmM1jecUY9cQ==
X-CSE-MsgGUID: qgA6sb9sTdKhzYpIvqa+pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45730061"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="45730061"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 06:39:32 -0800
X-CSE-ConnectionGUID: 1xTirdLBRM6BJkMONemJMA==
X-CSE-MsgGUID: NBJVfSNJTweZCx7AMQZXJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98103765"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 06:39:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Dec 2024 16:39:24 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v7 04/12] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
In-Reply-To: <20241130152023.684-5-mario.limonciello@amd.com>
Message-ID: <8f95fad6-216c-ee66-dfa4-bc4bf37ae93f@linux.intel.com>
References: <20241130152023.684-1-mario.limonciello@amd.com> <20241130152023.684-5-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 30 Nov 2024, Mario Limonciello wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
> 
> There are two CPU core types defined: `Classic Core` and `Dense Core`.
> "Classic" cores are the standard performance cores, while "Dense" cores
> are optimized for area and efficiency.
> 
> Heterogeneous compute refers to CPU implementations that are comprised
> of more than one architectural class, each with two capabilities. This
> means each CPU reports two separate capabilities: "perf" and "eff".
> 
> Each capability lists all core ranking numbers between 0 and 255, where
> a higher number represents a higher capability.
> 
> Heterogeneous systems can also extend to more than two architectural
> classes.
> 
> The purpose of the scheduling feedback mechanism is to provide information
> to the operating system scheduler in real time, allowing the scheduler to
> direct threads to the optimal core during task scheduling.
> 
> All core ranking data are provided by the PMFW via a shared memory ranking
> table, which the driver reads and uses to update core capabilities to the
> scheduler. When the hardware updates the table, it generates a platform
> interrupt to notify the OS to read the new ranking table.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>  * Adjust Kconfig to 80 characters
> ---
>  drivers/platform/x86/amd/Kconfig      |   1 +
>  drivers/platform/x86/amd/Makefile     |   1 +
>  drivers/platform/x86/amd/hfi/Kconfig  |  20 ++++
>  drivers/platform/x86/amd/hfi/Makefile |   7 ++
>  drivers/platform/x86/amd/hfi/hfi.c    | 161 ++++++++++++++++++++++++++
>  5 files changed, 190 insertions(+)
>  create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>  create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>  create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index c3e086ea64fc6..589d61ebf726b 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -6,6 +6,7 @@
>  source "drivers/platform/x86/amd/hsmp/Kconfig"
>  source "drivers/platform/x86/amd/pmf/Kconfig"
>  source "drivers/platform/x86/amd/pmc/Kconfig"
> +source "drivers/platform/x86/amd/hfi/Kconfig"
>  
>  config AMD_3D_VCACHE
>  	tristate "AMD 3D V-Cache Performance Optimizer Driver"
> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
> index 56f62fc9c97b4..c50e93c3334cf 100644
> --- a/drivers/platform/x86/amd/Makefile
> +++ b/drivers/platform/x86/amd/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
>  obj-$(CONFIG_AMD_HSMP)		+= hsmp/
>  obj-$(CONFIG_AMD_PMF)		+= pmf/
>  obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
> +obj-$(CONFIG_AMD_HFI)		+= hfi/
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> new file mode 100644
> index 0000000000000..532939eb08a6a
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +config AMD_HFI
> +	bool "AMD Hetero Core Hardware Feedback Driver"
> +	depends on ACPI
> +	depends on CPU_SUP_AMD
> +	help
> +	 Select this option to enable the AMD Heterogeneous Core Hardware
> +	 Feedback Interface. If selected, hardware provides runtime thread
> +	 classification guidance to the operating system on the performance and
> +	 energy efficiency capabilities of each heterogeneous CPU core. These
> +	 capabilities may vary due to the inherent differences in the core types
> +	 and can also change as a result of variations in the operating
> +	 conditions of the system such as power and thermal limits. If selected,
> +	 the kernel relays updates in heterogeneous CPUs' capabilities to
> +	 userspace, allowing for more optimal task scheduling and resource
> +	 allocation, leveraging the diverse set of cores available.
> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
> new file mode 100644
> index 0000000000000..672c6ac106e95
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
> +amd_hfi-objs := hfi.o
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> new file mode 100644
> index 0000000000000..2cd71d79a22c9
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Hardware Feedback Interface Driver
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Authors: Perry Yuan <Perry.Yuan@amd.com>
> + *          Mario Limonciello <mario.limonciello@amd.com>
> + */
> +
> +#define pr_fmt(fmt)  "amd-hfi: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +
> +#define AMD_HFI_DRIVER		"amd_hfi"
> +#define AMD_HETERO_CPUID_27	0x80000027
> +static struct platform_device *device;
> +
> +struct amd_hfi_data {
> +	const char	*name;
> +	struct device	*dev;
> +	struct mutex	lock;
> +};
> +
> +struct amd_hfi_classes {
> +	u32	perf;
> +	u32	eff;
> +};
> +
> +/**
> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
> + * @cpu:		cpu index
> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
> + * @class_index:	workload class ID index
> + * @nr_class:		max number of workload class supported
> + * @amd_hfi_classes:	current cpu workload class ranking data
> + *
> + * Parameters of a logical processor linked with hardware feedback class
> + */
> +struct amd_hfi_cpuinfo {
> +	int		cpu;
> +	cpumask_var_t	cpus;
> +	s16		class_index;
> +	u8		nr_class;
> +	struct amd_hfi_classes	*amd_hfi_classes;
> +};
> +
> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
> +
> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
> +{
> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> +	struct device *dev = &pdev->dev;
> +	int idx;
> +	int nr_class_id;
> +
> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
> +	if (nr_class_id < 0 || nr_class_id > 255) {
> +		dev_err(dev, "failed to get number of supported classes: %d\n",
> +			nr_class_id);
> +		return -EINVAL;
> +	}
> +
> +	for_each_present_cpu(idx) {
> +		struct amd_hfi_classes *classes;
> +
> +		classes = devm_kzalloc(dev,
> +				       nr_class_id * sizeof(struct amd_hfi_classes),
> +				       GFP_KERNEL);

devm_kcalloc()?

-- 
 i.

> +		if (!classes)
> +			return -ENOMEM;
> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
> +		hfi_cpuinfo->amd_hfi_classes = classes;
> +		hfi_cpuinfo->nr_class = nr_class_id;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id amd_hfi_platform_match[] = {
> +	{"AMDI0104", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
> +
> +static int amd_hfi_probe(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *amd_hfi_data;
> +	int ret;
> +
> +	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
> +		return -ENODEV;
> +
> +	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
> +	if (!amd_hfi_data)
> +		return -ENOMEM;
> +
> +	amd_hfi_data->dev = &pdev->dev;
> +	ret = devm_mutex_init(&pdev->dev, &amd_hfi_data->lock);
> +	if (ret)
> +		return ret;
> +	platform_set_drvdata(pdev, amd_hfi_data);
> +
> +	ret = amd_hfi_alloc_class_data(pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver amd_hfi_driver = {
> +	.driver = {
> +		.name = AMD_HFI_DRIVER,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
> +	},
> +	.probe = amd_hfi_probe,
> +};
> +
> +static int __init amd_hfi_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled ||
> +	    !cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
> +	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
> +		return -ENODEV;
> +
> +	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
> +	if (IS_ERR(device)) {
> +		pr_err("unable to register HFI platform device\n");
> +		return PTR_ERR(device);
> +	}
> +
> +	ret = platform_driver_register(&amd_hfi_driver);
> +	if (ret)
> +		pr_err("failed to register HFI driver\n");
> +
> +	return ret;
> +}
> +
> +static __exit void amd_hfi_exit(void)
> +{
> +	platform_device_unregister(device);
> +	platform_driver_unregister(&amd_hfi_driver);
> +}
> +module_init(amd_hfi_init);
> +module_exit(amd_hfi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
> 

