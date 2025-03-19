Return-Path: <linux-pm+bounces-24283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC63A68E6A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 15:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584C27A8DAD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AF019342F;
	Wed, 19 Mar 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlFU960e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43D7462;
	Wed, 19 Mar 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393033; cv=none; b=JMMEwudEfy8pZZuKq0pTrQzb5DxWGSqL/5Oi/HNOLpChmnQqLUhHOA0IjOYhXYu0Swf2NNmsE9zzzi7IkXP2JiBhQR9lAFapCFxPBMay8mA49h30hslf5WxlOfh3ZQelFsW/XvbnBO3ge1ndLTXjMuFOzLYxvxLJTHh0qnBiMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393033; c=relaxed/simple;
	bh=hhSIXKbvMJeJTIPSAe3MoL7hXyYlvLXO03A6Xbkrv08=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SJgzakkXNLmCYgMmHJrqH6MznXaEtlSbkHkCNiYh3xUVZlI78ILV05JoMwcU5Y6QiVCLE6/+xl1ciP0vcioNOu0HronNeCskPJTLRmeWMBXcbBe6Hkvu75fWq17VfyUIAdZB+YFOwifkiD4EUuvElhXSht/l8KCtzWh45xVW/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlFU960e; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742393022; x=1773929022;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hhSIXKbvMJeJTIPSAe3MoL7hXyYlvLXO03A6Xbkrv08=;
  b=LlFU960eSUrht2bRmN32feH6Bt2pGXlWuVDqsRpzbd+oZEl6vfxm5rXE
   FGfPJDp8OqY0TIIBB6Z+VVt1RNJbkiB3jp9UQsNU21YznJyJPi736Dnog
   +QaigoWaiuLyL210yemQvqyh3JVJNTLxny+tSdQJ1rbfRNPtGtvo/uJJ7
   /YRYwr1p2Gbx4XBPcD7XXo2waLhs78Zwsf6O9FhZe7rwmoD72yBcSV9sF
   3cHEy9pmd2lnYR7MwKim4OxbkAPlm/JXy18PdS2T/bClNfAD/4WhEaIHe
   zXNswDQAfs59iND/ln9Dkr9I38ofM1wAhnDjY75YzCCwjvNdOImqXoam6
   Q==;
X-CSE-ConnectionGUID: 2GrqXDu2SMiRIYeXYjPgGQ==
X-CSE-MsgGUID: vYsHVa49TVW5chwLwiTSTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47232611"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47232611"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:03:31 -0700
X-CSE-ConnectionGUID: +90ErYb6RJuwsSq+aW6u8g==
X-CSE-MsgGUID: 8PSvPRBWRiCZMrnWxKXTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127322778"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:03:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 16:03:18 +0200 (EET)
To: Mario Limonciello <superm1@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, 
    "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
    Huang Rui <ray.huang@amd.com>, 
    "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, 
    "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
    "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
    "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>, 
    Perry Yuan <Perry.Yuan@amd.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v8 04/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
In-Reply-To: <20250218190822.1039982-5-superm1@kernel.org>
Message-ID: <f90d49d6-e031-4722-b63f-26931eae1aa5@linux.intel.com>
References: <20250218190822.1039982-1-superm1@kernel.org> <20250218190822.1039982-5-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Feb 2025, Mario Limonciello wrote:

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
> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v8:
>  * s,devm_kzalloc,devm_kcalloc,
>  * fold newlines from patch 5 into this patch
>  * Drop ->cpu member, push to later patch
>  * s,for_each_present_cpu,for_each_possible_cpu,
> v7:
>  * Adjust Kconfig to 80 characters
> ---
>  drivers/platform/x86/amd/Kconfig      |   1 +
>  drivers/platform/x86/amd/Makefile     |   1 +
>  drivers/platform/x86/amd/hfi/Kconfig  |  20 ++++
>  drivers/platform/x86/amd/hfi/Makefile |   7 ++
>  drivers/platform/x86/amd/hfi/hfi.c    | 162 ++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+)
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

This says the capabilities can change but metadata is only read and scores 
updated during probe?

> +	 the kernel relays updates in heterogeneous CPUs' capabilities to
> +	 userspace, allowing for more optimal task scheduling and resource
> +	 allocation, leveraging the diverse set of cores available.

How are the capabilities communicated to userspace as mentioned here? I'm 
asking this because I only noted debugfs interface, and that commit 
claimed the debug fs interface was to troubleshoot scheduler issues.

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
> index 0000000000000..426f7e520b76c
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Hardware Feedback Interface Driver
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.

2025 ?

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
> +
> +#define AMD_HETERO_CPUID_27	0x80000027
> +
> +static struct platform_device *device;
> +
> +struct amd_hfi_data {
> +	const char	*name;
> +	struct device	*dev;
> +	struct mutex	lock;

Please mention what this protects.

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
> + * @class_index:	workload class ID index
> + * @nr_class:		max number of workload class supported
> + * @amd_hfi_classes:	current cpu workload class ranking data
> + *
> + * Parameters of a logical processor linked with hardware feedback class

missing .

> + */
> +struct amd_hfi_cpuinfo {
> +	int		cpu;
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

Is the signed type correct for this?

> +		dev_err(dev, "failed to get number of supported classes: %d\n",
> +			nr_class_id);

I'd reword the error message as the number of classes was just too
large / outside the allowed range.

> +		return -EINVAL;
> +	}
> +
> +	for_each_possible_cpu(idx) {
> +		struct amd_hfi_classes *classes;
> +
> +		classes = devm_kcalloc(dev,
> +				       nr_class_id,
> +				       sizeof(struct amd_hfi_classes),
> +				       GFP_KERNEL);
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

Why are these not in the opposite order than in init?

> +}
> +module_init(amd_hfi_init);
> +module_exit(amd_hfi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
> 

-- 
 i.


