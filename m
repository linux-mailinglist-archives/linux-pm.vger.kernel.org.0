Return-Path: <linux-pm+bounces-15772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0E9A0A12
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 14:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C26285DEF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F6208962;
	Wed, 16 Oct 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVwJElp1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054C207A2C;
	Wed, 16 Oct 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082328; cv=none; b=izz8hvbPPS5fid108RFvLlMGCxa1nIlX74LXkpTvlSRcopc93hd9q3QBYKrLgvSMIWKDthOO4TsMS1h2B76Lj187jBVksU/G/ksfcPB6Tk9fFAEvWfY2VXHjBdowkLsxkODcwJv1+B8vS8KK9XJSjhkXS78sVZT5LO8aQNW9zMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082328; c=relaxed/simple;
	bh=pG5z/h1vkVwxMvN3uPx4hrWsE2KHzIpOD2t9beUqJBo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sBscEVuITyc+PlYc//FcWD/hRZFrhvRleyWYwiZdV2/7Iczv4n9ko+ddN/lELVKUjTm/S0BTDGsexLndTDDg0cVHXS937BHFpHP6lA/CPJD0R0EyLITKVuw619RbFlv+uJtuz/kXoAPiznEXWyJqGTzglESEV1mkX+W4+ZPlaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVwJElp1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729082327; x=1760618327;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pG5z/h1vkVwxMvN3uPx4hrWsE2KHzIpOD2t9beUqJBo=;
  b=lVwJElp1FVrXw91XKMKJupu15Kl+EHXPqZ7kQRHps447/k6ChXANWDtm
   FLYnOfxPIVy1DYYDgmSyj7aCd5sNdncbU+RbHkoRsp1cQ/lStDffvjERT
   aQfj7CmIEqC0Sqyy8eSE64XR5QCXN0wk5FLRkMfW1QJeTEFMmd9Zp18O/
   5Sh5SBdnIubNLbhSpuZkdmusUKzeg8WXFmbxL2tMQnI8ssIS9MUkKGDeH
   UWlG+LirZJVBHvyhrUprZSy5gKilUp8KA9XtpmJnZWGgbqCqG8quvBwoe
   5lJ9npvvp9scIcbjxOYV5okDDkFTJloz6Pmy8FnETKwBuP5w1JTwcyl2X
   Q==;
X-CSE-ConnectionGUID: E/iXUnu8RZuFZE74ssLMCg==
X-CSE-MsgGUID: k4Si4Mu+RXifEaQPfWCXeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51061969"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51061969"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:38:45 -0700
X-CSE-ConnectionGUID: rrDgVVaVSeia2IFsuK+8OQ==
X-CSE-MsgGUID: PKsPXAJLQwCf1cHK7TBpAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="79048427"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:38:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 16 Oct 2024 15:38:36 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 14/14] platform/x86: hfi: Add debugfs support
In-Reply-To: <20241015213645.1476-15-mario.limonciello@amd.com>
Message-ID: <7b3a2e3b-9c37-09a3-238a-9cc90726c929@linux.intel.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com> <20241015213645.1476-15-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 15 Oct 2024, Mario Limonciello wrote:

> Add a dump of the class and capabilities table to debugfs to assist
> with debugging scheduler issues.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>   * New patch
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 6c90b50f0a40..6df80f6ac73c 100644
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
> @@ -79,6 +80,8 @@ struct amd_hfi_data {
>  	void __iomem		*pcc_comm_addr;
>  	struct acpi_subtable_header	*pcct_entry;
>  	struct amd_shmem_info	*shmem;
> +
> +	struct dentry *dbgfs_dir;
>  };
>  
>  /**
> @@ -243,6 +246,8 @@ static void amd_hfi_remove(struct platform_device *pdev)
>  {
>  	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
>  
> +	debugfs_remove_recursive(dev->dbgfs_dir);
> +
>  	mutex_destroy(&dev->lock);
>  }
>  
> @@ -400,6 +405,28 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
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
> +		seq_printf(s, "%d\t", cpu);
> +		for (idx = 0; idx < hfi_cpuinfo->nr_class; idx++) {
> +			seq_printf(s, "%s%d\t%d\t%d\n",
> +				   idx == 0 ? "" : "\t",

Is this conditional printing really required? Why cannot you just print \t 
always here and remove it from the cpu print line?

-- 
 i.

> +				   idx,
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
> @@ -473,6 +500,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
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
> 


