Return-Path: <linux-pm+bounces-24286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A43A68E86
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 15:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBF7A2C82
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989051B4F09;
	Wed, 19 Mar 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEiGP4Gw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA11A3056;
	Wed, 19 Mar 2025 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393126; cv=none; b=LTB9xPa74bZG4bU6rVrv5o6uVFpkdSfmdSdcpq+osQwolgm/KE5/Na0V4Uermy08jAuzrlWVgaGQN9YEdqjlXFRQ6fUnS+4tT7DpGrP/Jyh5AiCm6PqACs0CSF9gOhWZyQtYkRuUuSX80MwLpO9bW4zjW3YLU8HLo5VK5bpjNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393126; c=relaxed/simple;
	bh=FykKi5B1OIIrB8kV/rDesHGQ7kViOrYXaOuFqKji6kk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uqq5R7UEmCMnSkiIItTjQPyfkk/8f21md+MMHfElngNxUFJtRB4cDI+22WP4OzQM3bXP0tKczZYuOWDtLqqHWbQBL6TFNQZtIWKIFmzkPTf8zJDFTin3acMfGKKo/RJbv/gWb2u393xVO12LydcEZre4KtR0HRl0AC0f+1153ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEiGP4Gw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742393126; x=1773929126;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FykKi5B1OIIrB8kV/rDesHGQ7kViOrYXaOuFqKji6kk=;
  b=LEiGP4GwtaeYo4pEluo+WcGa1b8/IhsgoiszzW6kDJey5khjNH6T71lm
   UXO6CHWfoSpscQxxZwwwWNDvVLVUnWQCRCpm4M4Slv8BXEk9t88dx6kSj
   AzueLnSDOQFHImh3Q9hwhMUqeTkCjq+9JFYZ2I4wy3p37MZA40+AduiU8
   7IaL3X7Kl1RTDV5m4IhuwTyjiIxVIaVshUjFgzPO84gwm8q0x8elFBRwq
   mCdXAJwGaQW8Xm3TidP19lKEXpm/0pROMvr4oFEu/01fPjbmZYdCMn8fj
   EDUlbKFJahsCsrG6jYy3NnODBmRDg9ej2HPDCkq359Cxmxc4Lhmd0DEoz
   g==;
X-CSE-ConnectionGUID: XRbVggPMRfuHZVwO6e3Pjw==
X-CSE-MsgGUID: IMe9F9wgSpG143fDeIL8ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47233470"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47233470"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:05:24 -0700
X-CSE-ConnectionGUID: xdB9ZGvyRyWA5i3/n3IEbw==
X-CSE-MsgGUID: TG6HtdmlS5CiPVL7P6LI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123567657"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:05:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 16:05:14 +0200 (EET)
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
    "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 12/13] platform/x86/amd: hfi: Add debugfs support
In-Reply-To: <20250218190822.1039982-13-superm1@kernel.org>
Message-ID: <051984c1-c70b-3782-bda2-a00ed190525e@linux.intel.com>
References: <20250218190822.1039982-1-superm1@kernel.org> <20250218190822.1039982-13-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Feb 2025, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Add a dump of the class and capabilities table to debugfs to assist
> with debugging scheduler issues.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v8:
>  * s,for_each_present_cpu,for_each_possible_cpu,
> v3:
>  * Move idx to earlier line
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 35 ++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 14378a0e09e21..79d065d7b6441 100644
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
> @@ -235,6 +238,13 @@ static int amd_hfi_alloc_class_data(struct platform_device *pdev)
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
> @@ -389,6 +399,26 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int class_capabilities_show(struct seq_file *s, void *unused)
> +{
> +	int cpu, idx;
> +
> +	seq_puts(s, "CPU #\tWLC\tPerf\tEff\n");
> +	for_each_possible_cpu(cpu) {
> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +
> +		seq_printf(s, "%d", cpu);
> +		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
> +			seq_printf(s, "\t%d\t%d\t%d\n", idx,
> +				   hfi_cpuinfo->amd_hfi_classes[idx].perf,
> +				   hfi_cpuinfo->amd_hfi_classes[idx].eff);

Please use %u for unsigned variables.

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
> @@ -468,6 +498,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
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
> @@ -479,6 +513,7 @@ static struct platform_driver amd_hfi_driver = {
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


