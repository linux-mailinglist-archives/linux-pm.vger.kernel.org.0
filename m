Return-Path: <linux-pm+bounces-24339-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE0EA6AB5E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D23980222
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126EA223709;
	Thu, 20 Mar 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dizFEInD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEC19DF98;
	Thu, 20 Mar 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489207; cv=none; b=N6QqlefMNANt7roI7epvXMm9YwaGazdFtHZfwWhKFYvOEQWg71yoL39wcCynNTmLl5FhftfcijzEDbjchdQmKr+dIqr3i/JC/sli1YJ2M1Sr05cuu0b0k784nA6g8UcaozRggjPjXt9QBS5CDHOaDcqBlvOUqQIkWhuEz7BJfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489207; c=relaxed/simple;
	bh=8PzccMNrJT5W8W7N7Yc4hGCXeynPoeHzA1FX/c6gIjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnFicenqpwjk99wYbSxfQdM47/k6WrF9d+UGHpfLdwqEE759IApEMFoHIgpPc3dBp5Mvey3huCSc+nIzh70mTUQDAtxGT7JKoGXAT/+FN7n53hlier/w2PACFcq7DHwaHCriKDk59gRZV9jgBO1pJWPBBEcEfdyJslf4s60SMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dizFEInD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C461C4CEDD;
	Thu, 20 Mar 2025 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742489207;
	bh=8PzccMNrJT5W8W7N7Yc4hGCXeynPoeHzA1FX/c6gIjE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dizFEInDR/7AXa1hkGS5nkOJUqZ9O3fAVaDVd/TKU1TdEDC3ZQSZBPdrsxGNVlbgd
	 KxS26QNR6nTK3WwKfr9xBecSQq04Z/cTKML5TeVrW5d76Agce+6DLOSKrQqvZGzzfd
	 nSSMEa1eH+oV4H94FlefCPdwdCALF/Nf1/IS2ssgq8jfJdpYBFEvthr1E3vQc1RxWw
	 3Us6NaiRUhic6I4NE5ss2+PHQx9ujtEAT/5eptE0HWVxGynPZxR7CC/Maq9a3npYfu
	 ajQ4Dwt+of3XqYNRyMTCWAmtcP/k/0pfG4gZ5czOcHGD1DY6iKzwco7qjdTk9LlIwN
	 yChsoK5zgYtdg==
Message-ID: <1b54afae-cb86-4022-b9f5-e5c1fc075be8@kernel.org>
Date: Thu, 20 Mar 2025 11:46:44 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Huang Rui <ray.huang@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20250218190822.1039982-1-superm1@kernel.org>
 <20250218190822.1039982-5-superm1@kernel.org>
 <f90d49d6-e031-4722-b63f-26931eae1aa5@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <f90d49d6-e031-4722-b63f-26931eae1aa5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/19/2025 09:03, Ilpo Järvinen wrote:
> On Tue, 18 Feb 2025, Mario Limonciello wrote:
> 
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
>> provide behavioral classification and a dynamically updated ranking table
>> for the scheduler to use when choosing cores for tasks.
>>
>> There are two CPU core types defined: `Classic Core` and `Dense Core`.
>> "Classic" cores are the standard performance cores, while "Dense" cores
>> are optimized for area and efficiency.
>>
>> Heterogeneous compute refers to CPU implementations that are comprised
>> of more than one architectural class, each with two capabilities. This
>> means each CPU reports two separate capabilities: "perf" and "eff".
>>
>> Each capability lists all core ranking numbers between 0 and 255, where
>> a higher number represents a higher capability.
>>
>> Heterogeneous systems can also extend to more than two architectural
>> classes.
>>
>> The purpose of the scheduling feedback mechanism is to provide information
>> to the operating system scheduler in real time, allowing the scheduler to
>> direct threads to the optimal core during task scheduling.
>>
>> All core ranking data are provided by the PMFW via a shared memory ranking
>> table, which the driver reads and uses to update core capabilities to the
>> scheduler. When the hardware updates the table, it generates a platform
>> interrupt to notify the OS to read the new ranking table.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v8:
>>   * s,devm_kzalloc,devm_kcalloc,
>>   * fold newlines from patch 5 into this patch
>>   * Drop ->cpu member, push to later patch
>>   * s,for_each_present_cpu,for_each_possible_cpu,
>> v7:
>>   * Adjust Kconfig to 80 characters
>> ---
>>   drivers/platform/x86/amd/Kconfig      |   1 +
>>   drivers/platform/x86/amd/Makefile     |   1 +
>>   drivers/platform/x86/amd/hfi/Kconfig  |  20 ++++
>>   drivers/platform/x86/amd/hfi/Makefile |   7 ++
>>   drivers/platform/x86/amd/hfi/hfi.c    | 162 ++++++++++++++++++++++++++
>>   5 files changed, 191 insertions(+)
>>   create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>>   create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>>   create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
>>
>> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
>> index c3e086ea64fc6..589d61ebf726b 100644
>> --- a/drivers/platform/x86/amd/Kconfig
>> +++ b/drivers/platform/x86/amd/Kconfig
>> @@ -6,6 +6,7 @@
>>   source "drivers/platform/x86/amd/hsmp/Kconfig"
>>   source "drivers/platform/x86/amd/pmf/Kconfig"
>>   source "drivers/platform/x86/amd/pmc/Kconfig"
>> +source "drivers/platform/x86/amd/hfi/Kconfig"
>>   
>>   config AMD_3D_VCACHE
>>   	tristate "AMD 3D V-Cache Performance Optimizer Driver"
>> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
>> index 56f62fc9c97b4..c50e93c3334cf 100644
>> --- a/drivers/platform/x86/amd/Makefile
>> +++ b/drivers/platform/x86/amd/Makefile
>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
>>   obj-$(CONFIG_AMD_HSMP)		+= hsmp/
>>   obj-$(CONFIG_AMD_PMF)		+= pmf/
>>   obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
>> +obj-$(CONFIG_AMD_HFI)		+= hfi/
>> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
>> new file mode 100644
>> index 0000000000000..532939eb08a6a
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/Kconfig
>> @@ -0,0 +1,20 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# AMD Hardware Feedback Interface Driver
>> +#
>> +
>> +config AMD_HFI
>> +	bool "AMD Hetero Core Hardware Feedback Driver"
>> +	depends on ACPI
>> +	depends on CPU_SUP_AMD
>> +	help
>> +	 Select this option to enable the AMD Heterogeneous Core Hardware
>> +	 Feedback Interface. If selected, hardware provides runtime thread
>> +	 classification guidance to the operating system on the performance and
>> +	 energy efficiency capabilities of each heterogeneous CPU core. These
>> +	 capabilities may vary due to the inherent differences in the core types
>> +	 and can also change as a result of variations in the operating
>> +	 conditions of the system such as power and thermal limits. If selected,
> 
> This says the capabilities can change but metadata is only read and scores
> updated during probe?
> 
>> +	 the kernel relays updates in heterogeneous CPUs' capabilities to
>> +	 userspace, allowing for more optimal task scheduling and resource
>> +	 allocation, leveraging the diverse set of cores available.
> 
> How are the capabilities communicated to userspace as mentioned here? I'm
> asking this because I only noted debugfs interface, and that commit
> claimed the debug fs interface was to troubleshoot scheduler issues.

This is one of those cases that the split into multiple parts shows. 
Thinking through I feel it makes more sense to adjust for now and then 
we can change it again on the next part.

> 
>> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
>> new file mode 100644
>> index 0000000000000..672c6ac106e95
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# AMD Hardware Feedback Interface Driver
>> +#
>> +
>> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
>> +amd_hfi-objs := hfi.o
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
>> new file mode 100644
>> index 0000000000000..426f7e520b76c
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -0,0 +1,162 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Hardware Feedback Interface Driver
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> 
> 2025 ?

Ack.

Heh, earlier versions started in 2024!

> 
>> + *
>> + * Authors: Perry Yuan <Perry.Yuan@amd.com>
>> + *          Mario Limonciello <mario.limonciello@amd.com>
>> + */
>> +
>> +#define pr_fmt(fmt)  "amd-hfi: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/gfp.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/smp.h>
>> +
>> +#define AMD_HFI_DRIVER		"amd_hfi"
>> +
>> +#define AMD_HETERO_CPUID_27	0x80000027
>> +
>> +static struct platform_device *device;
>> +
>> +struct amd_hfi_data {
>> +	const char	*name;
>> +	struct device	*dev;
>> +	struct mutex	lock;
> 
> Please mention what this protects.

As a comment at the end like this, right?

struct mutex lock; /* lock the foo */

> 
>> +};
>> +
>> +struct amd_hfi_classes {
>> +	u32	perf;
>> +	u32	eff;
>> +};
>> +
>> +/**
>> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>> + * @cpu:		cpu index
>> + * @class_index:	workload class ID index
>> + * @nr_class:		max number of workload class supported
>> + * @amd_hfi_classes:	current cpu workload class ranking data
>> + *
>> + * Parameters of a logical processor linked with hardware feedback class
> 
> missing .

Ack

> 
>> + */
>> +struct amd_hfi_cpuinfo {
>> +	int		cpu;
>> +	s16		class_index;
>> +	u8		nr_class;
>> +	struct amd_hfi_classes	*amd_hfi_classes;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>> +
>> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
>> +	struct device *dev = &pdev->dev;
>> +	int idx;
>> +	int nr_class_id;
>> +
>> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
>> +	if (nr_class_id < 0 || nr_class_id > 255) {
> 
> Is the signed type correct for this?
> 
>> +		dev_err(dev, "failed to get number of supported classes: %d\n",
>> +			nr_class_id);
> 
> I'd reword the error message as the number of classes was just too
> large / outside the allowed range.

OK.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_possible_cpu(idx) {
>> +		struct amd_hfi_classes *classes;
>> +
>> +		classes = devm_kcalloc(dev,
>> +				       nr_class_id,
>> +				       sizeof(struct amd_hfi_classes),
>> +				       GFP_KERNEL);
>> +		if (!classes)
>> +			return -ENOMEM;
>> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
>> +		hfi_cpuinfo->amd_hfi_classes = classes;
>> +		hfi_cpuinfo->nr_class = nr_class_id;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id amd_hfi_platform_match[] = {
>> +	{"AMDI0104", 0},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
>> +
>> +static int amd_hfi_probe(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_data *amd_hfi_data;
>> +	int ret;
>> +
>> +	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
>> +		return -ENODEV;
>> +
>> +	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
>> +	if (!amd_hfi_data)
>> +		return -ENOMEM;
>> +
>> +	amd_hfi_data->dev = &pdev->dev;
>> +	ret = devm_mutex_init(&pdev->dev, &amd_hfi_data->lock);
>> +	if (ret)
>> +		return ret;
>> +	platform_set_drvdata(pdev, amd_hfi_data);
>> +
>> +	ret = amd_hfi_alloc_class_data(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver amd_hfi_driver = {
>> +	.driver = {
>> +		.name = AMD_HFI_DRIVER,
>> +		.owner = THIS_MODULE,
>> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>> +	},
>> +	.probe = amd_hfi_probe,
>> +};
>> +
>> +static int __init amd_hfi_init(void)
>> +{
>> +	int ret;
>> +
>> +	if (acpi_disabled ||
>> +	    !cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
>> +	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
>> +		return -ENODEV;
>> +
>> +	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
>> +	if (IS_ERR(device)) {
>> +		pr_err("unable to register HFI platform device\n");
>> +		return PTR_ERR(device);
>> +	}
>> +
>> +	ret = platform_driver_register(&amd_hfi_driver);
>> +	if (ret)
>> +		pr_err("failed to register HFI driver\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static __exit void amd_hfi_exit(void)
>> +{
>> +	platform_device_unregister(device);
>> +	platform_driver_unregister(&amd_hfi_driver);
> 
> Why are these not in the opposite order than in init?

Oversight.  Will fix it.

> 
>> +}
>> +module_init(amd_hfi_init);
>> +module_exit(amd_hfi_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
>>
> 


