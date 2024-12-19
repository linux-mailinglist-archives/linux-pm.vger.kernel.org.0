Return-Path: <linux-pm+bounces-19526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303119F7D7D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66154189200B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B8225A37;
	Thu, 19 Dec 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Felxzg6m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED72236EB;
	Thu, 19 Dec 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620401; cv=none; b=mpJaBuXfjftQhmlEMczfaH9uZQJ3wl0PYyHTn7SX8B98uJG/PGboWY+ddzsoX8Lx+1jU7E+ZZmMv009GLOEcHemqIOCYj5i8oQDQ+3g6AOmVQGuKGMdtbbxkoR+LlzXoDM0Tt1NevgsvAS2OM7lVdsACCpPBPx/KcfOERhcAIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620401; c=relaxed/simple;
	bh=+ESgxVMeGq7FX4b9sbG18XbWI8wDYxA3NcS6XuGbBKc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R46JjGHAt3aESX4WcRf22qWrzEFLwSyIr6qTWt/kb+myDl+CMJL4czvXDVmIKnmpGE15rcR0BGPtnvRbWnzw87w5bPh803+vErkUri8DtjeCmM5tLXRDFLFs9UYrp9MNrgs2mRshwrG3jUneQUfgYnOog6MYt+mLALG87eP8xKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Felxzg6m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734620400; x=1766156400;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+ESgxVMeGq7FX4b9sbG18XbWI8wDYxA3NcS6XuGbBKc=;
  b=Felxzg6mhVmegy601CejGugeRksoXtQ8RVSc7Y9pfIEuE3e/8ogNrFoG
   OWdxiCDcvGUbpiUyAqCjeyKVUsW5oBVg/LDnzCvEl6RT5/K68w49m3GfR
   +bF4Cq9wwE0S8wGc6Klm0jXZDBYDiE1TVe84BfasCvXklEps6gRCP8qas
   x3LO2YEJJSolaP35Ue5C6EDADAMOKEyRC9IIyYx1aXLzt2hq7FuZTwUXf
   dDxZ3hTG527kcBa3zZwtmP5hsEp/zH/ahrkJgqL3zNCy589m2D/fR3GXF
   MUiEGmkMHqgScgyXr6Pll06WkcHIWxXg3cJMSDseA6xP97QQ+HTM+C+K7
   Q==;
X-CSE-ConnectionGUID: Asj3hQwxT7y68gCkFVlbMg==
X-CSE-MsgGUID: wybHjxlgRtKZ/bdNT+Gmiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35021932"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="35021932"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 06:59:59 -0800
X-CSE-ConnectionGUID: i+kBy8kWRvyYo/A7aUfOGQ==
X-CSE-MsgGUID: yJFEefPRRKCvKQUebpzGzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98042442"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 06:59:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Dec 2024 16:59:52 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v7 12/12] platform/x86/amd: hfi: Add debugfs support
In-Reply-To: <20241130152023.684-13-mario.limonciello@amd.com>
Message-ID: <b98a11c6-27d7-5c59-34b5-dc6f86b854d4@linux.intel.com>
References: <20241130152023.684-1-mario.limonciello@amd.com> <20241130152023.684-13-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 30 Nov 2024, Mario Limonciello wrote:

> Add a dump of the class and capabilities table to debugfs to assist
> with debugging scheduler issues.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 36 ++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 0940950dd7adc..b6dc379bfd546 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -13,6 +13,7 @@
>  #include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/cpumask.h>
> +#include <linux/debugfs.h>
>  #include <linux/gfp.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -74,6 +75,8 @@ struct amd_hfi_data {
>  	void __iomem		*pcc_comm_addr;
>  	struct acpi_subtable_header	*pcct_entry;
>  	struct amd_shmem_info	*shmem;
> +
> +	struct dentry *dbgfs_dir;
>  };
>  
>  /**
> @@ -234,6 +237,13 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void amd_hfi_remove(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(dev->dbgfs_dir);
> +}
> +
>  static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
>  {
>  	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
> @@ -388,6 +398,27 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int class_capabilities_show(struct seq_file *s, void *unused)
> +{
> +	int cpu, idx;
> +
> +	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
> +	for_each_present_cpu(cpu) {
> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +
> +		seq_printf(s, "%d", cpu);
> +		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
> +			seq_printf(s, "\t%d\t%d\t%d\n",
> +				   idx,

Put idx to the previous line.

> +				   hfi_cpuinfo->amd_hfi_classes[idx].perf,
> +				   hfi_cpuinfo->amd_hfi_classes[idx].eff);
> +		}
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(class_capabilities);
> +
>  static int amd_hfi_pm_resume(struct device *dev)
>  {
>  	int ret, cpu;
> @@ -463,6 +494,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  
>  	schedule_work(&sched_amd_hfi_itmt_work);
>  
> +	amd_hfi_data->dbgfs_dir = debugfs_create_dir("amd_hfi", arch_debugfs_dir);
> +	debugfs_create_file("class_capabilities", 0644, amd_hfi_data->dbgfs_dir, pdev,
> +			    &class_capabilities_fops);
> +
>  	return 0;
>  }
>  
> @@ -474,6 +509,7 @@ static struct platform_driver amd_hfi_driver = {
>  		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>  	},
>  	.probe = amd_hfi_probe,
> +	.remove = amd_hfi_remove,
>  };
>  
>  static int __init amd_hfi_init(void)
> 

-- 
 i.


