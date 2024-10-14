Return-Path: <linux-pm+bounces-15611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5029E99C6EF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 12:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825E9B213D8
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB8158D6A;
	Mon, 14 Oct 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb9JhZjl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B701BC58;
	Mon, 14 Oct 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900866; cv=none; b=ehISrkK1lI0mf5SWgLRmABzI0ySBIgGGPUOMRs46ojPZQLxlgLk+EAji2zO6W6HUUGHHgYKMiBmylLGA9D0Yo3cY7PKN9JkMnc4jyYu2EJ+oIo9mBYjkaslaPXQ2zGK/FGSRJ30EEBFufEO5ISqmnQhac93IKSDSXl0bnkFDX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900866; c=relaxed/simple;
	bh=WSfdIdbikJBmvjnqt9T+LbkLqxcwGf4Wx4fWItSV2ys=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NHWp5oopuVbDNznxWAsb54LqrLjucn5OXOTP+wTIE0RUwU7haUrhXT4ngtzMNKMR7571QJ36HOapXnySZJGMvPKdtkgzTuCiOS69YnJX+vAVKcJL27vQt6p9zgjh9vyc+ET9EFWV+C+dZZ7PWtT2vB7WVVFtwb33L1y1CFTYdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mb9JhZjl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728900865; x=1760436865;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WSfdIdbikJBmvjnqt9T+LbkLqxcwGf4Wx4fWItSV2ys=;
  b=mb9JhZjlH0tj1//Fz2Bt7fFrbBh+xoJMs2NCil43RiJBMLr18ZzhdBLI
   bsgzrHfUYUg1uGk9Yt9qejKSsXOTMo0IVyCqf5AwJutf1FQ7qN3l0cn4X
   Bya6UaajxoradjYH1aRsye2hZrc6H/a85Qz0oKOpIMFOxFdNgXTzvRkvs
   bLs8zYhRBs5p9SEHjk8ikBRPrW3CMUgpGL8VKsFADm0l61ubnJsqanNZt
   AlwYd71BY+Xs68WyT2ErcZPn2yiHEWLYVGdneQn+Wk90ValogT9h+2k2q
   MUMjKpJJ1K7cGKgJhuJ7FBt/W9wJ6h72K0M3PnA3t65L1igs2XnS1nMpv
   g==;
X-CSE-ConnectionGUID: C1OEcvTERqOq9rRFnOoAkg==
X-CSE-MsgGUID: mAilXZAvRg+E66A8ToKwVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28195837"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28195837"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:14:25 -0700
X-CSE-ConnectionGUID: y/3a9hZEQYqZ5EoJbjDO5w==
X-CSE-MsgGUID: v8ogmImySgq1K8o8/jXoKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="78359179"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:14:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Oct 2024 13:14:17 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v2 06/13] platform/x86: hfi: parse CPU core ranking data
 from shared memory
In-Reply-To: <20241010193705.10362-7-mario.limonciello@amd.com>
Message-ID: <21e35bbf-a7d7-2b6b-60bf-e4eeceeb9bd3@linux.intel.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com> <20241010193705.10362-7-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 10 Oct 2024, Mario Limonciello wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
> to retrieve the shared memory address which contains the CPU core ranking
> table. This table includes a header that specifies the number of ranking
> data entries to be parsed and rank each CPU core with the Performance and
> Energy Efficiency capability as implemented by the CPU power management
> firmware.
> 
> Once the table has been parsed, each CPU is assigned a ranking score
> within its class. Subsequently, when the scheduler selects cores, it
> chooses from the ranking list based on the assigned scores in each class,
> thereby ensuring the optimal selection of CPU cores according to their
> predefined classifications and priorities.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Rework amd_hfi_fill_metatadata to directly use structure instead of
>    pointer math.
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 215 ++++++++++++++++++++++++++++-
>  1 file changed, 212 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index da2e667107e8..10651399cf75 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -18,22 +18,78 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
> +#include <linux/percpu-defs.h>
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
>  #include <linux/smp.h>
>  #include <linux/string.h>
> +#include <linux/topology.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/cpu_device_id.h>
> +
> +#include <acpi/pcc.h>
> +#include <acpi/cppc_acpi.h>
>  
>  #define AMD_HFI_DRIVER		"amd_hfi"
> +#define AMD_HFI_MAILBOX_COUNT	1
> +#define AMD_HETERO_RANKING_TABLE_VER	2
> +
>  #define AMD_HETERO_CPUID_27	0x80000027
> +
>  static struct platform_device *device;
>  
> +/**
> + * struct amd_shmem_info - Shared memory table for AMD HFI
> + *
> + * @signature:	The PCC signature. The signature of a subspace is computed by
> + *		a bitwise of the value 0x50434300 with the subspace ID.
> + * @flags:	Notify on completion
> + * @length:	Length of payload being transmitted including command field
> + * @command:	Command being sent over the subspace
> + * @version_number:		Version number of the table
> + * @n_logical_processors:	Number of logical processors
> + * @n_capabilities:		Number of ranking dimensions (performance, efficiency, etc)
> + * @table_update_context:	Command being sent over the subspace
> + * @n_bitmaps:			Number of 32-bit bitmaps to enumerate all the APIC IDs
> + *				This is based on the maximum APIC ID enumerated in the system
> + * @reserved:			24 bit spare
> + * @table_data:			Bit Map(s) of enabled logical processors
> + *				Followed by the ranking data for each logical processor
> + */
> +struct amd_shmem_info {
> +	struct acpi_pcct_ext_pcc_shared_memory header;
> +	u32	version_number		:8,
> +		n_logical_processors	:8,
> +		n_capabilities		:8,
> +		table_update_context	:8;
> +	u32	n_bitmaps		:8,
> +		reserved		:24;
> +	u32	table_data[];
> +} __packed;
> +
>  struct amd_hfi_data {
>  	const char	*name;
>  	struct device	*dev;
>  	struct mutex	lock;
> +
> +	/* PCCT table related*/
> +	struct pcc_mbox_chan	*pcc_chan;
> +	void __iomem		*pcc_comm_addr;
> +	struct acpi_subtable_header	*pcct_entry;
> +	struct amd_shmem_info	*shmem;
>  };
>  
> +/**
> + * struct amd_hfi_classes - HFI class capabilities per CPU
> + * @perf:	Performance capability
> + * @eff:	Power efficiency capability
> + *
> + * Capabilities of a logical processor in the ranking table. These capabilities
> + * are unitless and specific to each HFI class.
> + */
>  struct amd_hfi_classes {
>  	u32	perf;
>  	u32	eff;
> @@ -42,23 +98,105 @@ struct amd_hfi_classes {
>  /**
>   * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>   * @cpu:		cpu index
> + * @apic_id:		apic id of the current cpu
>   * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
>   * @class_index:	workload class ID index
>   * @nr_class:		max number of workload class supported
> + * @ipcc_scores:	ipcc scores for each class
>   * @amd_hfi_classes:	current cpu workload class ranking data
>   *
>   * Parameters of a logical processor linked with hardware feedback class
>   */
>  struct amd_hfi_cpuinfo {
>  	int		cpu;
> +	u32		apic_id;
>  	cpumask_var_t	cpus;
>  	s16		class_index;
>  	u8		nr_class;
> +	int		*ipcc_scores;
>  	struct amd_hfi_classes	*amd_hfi_classes;
>  };
>  
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>  
> +static int find_cpu_index_by_apicid(unsigned int target_apicid)
> +{
> +	int cpu_index;
> +
> +	for_each_possible_cpu(cpu_index) {
> +		struct cpuinfo_x86 *info = &cpu_data(cpu_index);
> +
> +		if (info->topo.apicid == target_apicid) {
> +			pr_debug("match APIC id %d for CPU index: %d",

Missing \n

> +				 info->topo.apicid, cpu_index);
> +			return cpu_index;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
> +{
> +	struct acpi_pcct_ext_pcc_slave *pcct_ext =
> +		(struct acpi_pcct_ext_pcc_slave *)amd_hfi_data->pcct_entry;
> +	void __iomem *pcc_comm_addr;
> +
> +	pcc_comm_addr = acpi_os_ioremap(amd_hfi_data->pcc_chan->shmem_base_addr,
> +					amd_hfi_data->pcc_chan->shmem_size);
> +	if (!pcc_comm_addr) {
> +		pr_err("failed to ioremap PCC common region mem\n");
> +		return -ENOMEM;
> +	}
> +
> +	memcpy_fromio(amd_hfi_data->shmem, pcc_comm_addr, pcct_ext->length);
> +	iounmap(pcc_comm_addr);
> +
> +	if (amd_hfi_data->shmem->header.signature != PCC_SIGNATURE) {
> +		pr_err("Invalid signature in shared memory\n");
> +		return -EINVAL;
> +	}
> +	if (amd_hfi_data->shmem->version_number != AMD_HETERO_RANKING_TABLE_VER) {
> +		pr_err("Invalid veresion %d\n", amd_hfi_data->shmem->version_number);

version

> +		return -EINVAL;
> +	}
> +
> +	for (u32 i = 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
> +		u32 bitmap = amd_hfi_data->shmem->table_data[i];
> +
> +		for (u32 j = 0; j < BITS_PER_TYPE(u32); j++) {

Are these u32 really the types you want to use for the loop vars, why?

> +			struct amd_hfi_cpuinfo *info;
> +			int apic_id = i * BITS_PER_TYPE(u32) + j;
> +			int cpu_index;
> +
> +			if (!(bitmap & BIT(j)))
> +				continue;
> +
> +			cpu_index = find_cpu_index_by_apicid(apic_id);
> +			if (cpu_index < 0) {
> +				pr_warn("APIC ID %d not found\n", apic_id);
> +				continue;
> +			}
> +
> +			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
> +			info->apic_id = apic_id;
> +
> +			/* Fill the ranking data for each logical processor */
> +			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
> +			for (int k = 0; k < info->nr_class; k++) {

unsigned int

> +				u32 *table = amd_hfi_data->shmem->table_data +
> +					     amd_hfi_data->shmem->n_bitmaps +
> +					     i * info->nr_class;
> +
> +				info->amd_hfi_classes[k].eff = table[apic_id + 2 * k];
> +				info->amd_hfi_classes[k].perf = table[apic_id + 2 * k + 1];
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>  {
>  	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> @@ -68,8 +206,7 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>  
>  	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
>  	if (nr_class_id < 0 || nr_class_id > 255) {
> -		dev_warn(dev, "failed to get supported class number from CPUID %d\n",
> -				AMD_HETERO_CPUID_27);
> +		dev_warn(dev, "failed to get number of supported classes\n");

This message was added in the previous patch and now immediately changed.

>  		return -EINVAL;
>  	}
>  
> @@ -79,7 +216,10 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>  				sizeof(struct amd_hfi_classes), GFP_KERNEL);
>  		if (!hfi_cpuinfo->amd_hfi_classes)
>  			return -ENOMEM;
> -
> +		hfi_cpuinfo->ipcc_scores = devm_kcalloc(dev, nr_class_id,
> +							sizeof(int), GFP_KERNEL);
> +		if (!hfi_cpuinfo->ipcc_scores)
> +			return -ENOMEM;
>  		hfi_cpuinfo->nr_class = nr_class_id;
>  	}
>  
> @@ -93,6 +233,70 @@ static void amd_hfi_remove(struct platform_device *pdev)
>  	mutex_destroy(&dev->lock);
>  }
>  
> +static int amd_hfi_metadata_parser(struct platform_device *pdev,
> +				   struct amd_hfi_data *amd_hfi_data)
> +{
> +	struct acpi_pcct_ext_pcc_slave *pcct_ext;
> +	struct acpi_subtable_header *pcct_entry;
> +	struct mbox_chan *pcc_mbox_channels;
> +	struct acpi_table_header *pcct_tbl;
> +	struct pcc_mbox_chan *pcc_chan;
> +	acpi_status status;
> +	int ret;
> +
> +	pcc_mbox_channels = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
> +					 sizeof(*pcc_mbox_channels), GFP_KERNEL);
> +	if (!pcc_mbox_channels) {
> +		ret = -ENOMEM;
> +		goto out;

Please return directly if there is nothing to rollback.

> +	}
> +
> +	pcc_chan = devm_kcalloc(&pdev->dev, AMD_HFI_MAILBOX_COUNT,
> +				sizeof(*pcc_chan), GFP_KERNEL);
> +	if (!pcc_chan) {
> +		ret = -ENOMEM;
> +		goto out;

Ditto.

> +	}
> +
> +	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
> +	if (ACPI_FAILURE(status) || !pcct_tbl) {
> +		ret = -ENODEV;
> +		goto out;

Ditto.

> +	}
> +
> +	/* get pointer to the first PCC subspace entry */
> +	pcct_entry = (struct acpi_subtable_header *) (
> +			(unsigned long)pcct_tbl + sizeof(struct acpi_table_pcct));
> +
> +	pcc_chan->mchan = &pcc_mbox_channels[0];
> +
> +	amd_hfi_data->pcc_chan = pcc_chan;
> +	amd_hfi_data->pcct_entry = pcct_entry;
> +	pcct_ext = (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
> +
> +	if (pcct_ext->length <= 0) {
> +		ret = -EINVAL;
> +		goto out;

Ditto.

> +	}
> +
> +	amd_hfi_data->shmem = devm_kmalloc(amd_hfi_data->dev, pcct_ext->length, GFP_KERNEL);

Why kmalloc ?

> +	if (!amd_hfi_data->shmem) {
> +		ret = -ENOMEM;
> +		goto out;

Return directly.

> +	}
> +
> +	pcc_chan->shmem_base_addr = pcct_ext->base_address;
> +	pcc_chan->shmem_size = pcct_ext->length;
> +
> +	/* parse the shared memory info from the pcct table */
> +	ret = amd_hfi_fill_metadata(amd_hfi_data);
> +
> +	acpi_put_table(pcct_tbl);
> +
> +out:
> +	return ret;
> +}
> +
>  static const struct acpi_device_id amd_hfi_platform_match[] = {
>  	{ "AMDI0104", 0},
>  	{ }
> @@ -121,6 +325,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out;

This should do return ret; directly, not jump to out label which does 
nothing but return.

>  
> +	/* parse PCCT table */
> +	ret = amd_hfi_metadata_parser(pdev, amd_hfi_data);
> +	if (ret)
> +		goto out;
> +
>  out:
>  	return ret;

Might again be there for churn avoidance, otherwise, please consider:

	return amd_hfi_metadata_parser(pdev, amd_hfi_data);

That goto out should again just return ret directly.

>  }
> 

-- 
 i.


