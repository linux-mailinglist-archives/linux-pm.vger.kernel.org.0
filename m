Return-Path: <linux-pm+bounces-15615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020F99C72B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 12:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F2D1F2383A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD1415D5C5;
	Mon, 14 Oct 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOTmEKiV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61F15CD6E;
	Mon, 14 Oct 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901762; cv=none; b=fYGGuvlYBCgUb3UhjHwZeQJ+txdJuEVbvFWL9LDh/Sx0+2+x8BUSbzBV5i2b5bVAka/j5dNQ2UB1bJDKhxF1Ledh++txa9UFxLj29E+iLyof6176ZksidyhoQVx/+sP9hv/KxKCr8u7LmV7PpKaOpKihwaXM5t5FvbL7g50mYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901762; c=relaxed/simple;
	bh=O1zDNala9EX9k298pR/ciiTZ0akbpeN3NpSMWyoMxbo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uQPiBBbu8K266X00pb1rawlMCgPP094IZO8oLun2st68FbvJFfZLLKZrNnOLwMDgQ51944EFOOYeua5pkYZJmLtN/AfNjb3sLHU2eBU4AxPr0RLPk7v3IO06Ge/WLsgzpb9ZRtQcZ0krKDRMcxBF/SliIpQ2ch+yRUEvuM43070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOTmEKiV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728901761; x=1760437761;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O1zDNala9EX9k298pR/ciiTZ0akbpeN3NpSMWyoMxbo=;
  b=LOTmEKiVspVm40m1EBv9GqLply8B0BtMV0H07oNxKxC0rC/llKZX6oLh
   WB1oiSm6ovU48ujFIZSS9SEVrJjSTgNNZgVRSgFn0CuwJYC3ltNC3hU3r
   fMpJrrDK9tU9oMJ9qvht06DGTJ/01Itk7/yhnDrpFyaFfAFVSc1bFgoHC
   RKzOJyw6Ohn+qTOPd4PtPcgZFkUvWrILAGiF1R1EehYUP6OsXyTNtfCgh
   EMuMu+5h53B00bwlJ24r/Zj8cNT0FR1rgSPK3EcB1nfqTHwbqI5GJvtUc
   pF5JJ58hyD/gdkTeuK1hkmm/+ThgYJVjwRLXTUTidS/fUp4XGE33M0aOa
   A==;
X-CSE-ConnectionGUID: 6MfdOEbCSlu6pULaLAwETw==
X-CSE-MsgGUID: FT34iGjZRneqA9o7NbMFsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="45748579"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="45748579"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:29:14 -0700
X-CSE-ConnectionGUID: IAnYW3iKRMGEwWR+Bt1iHg==
X-CSE-MsgGUID: Oi6qp8o+RueXZiG1amHnMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77545723"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:29:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Oct 2024 13:29:07 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v2 09/13] platform/x86: hfi: add power management
 callback
In-Reply-To: <20241010193705.10362-10-mario.limonciello@amd.com>
Message-ID: <d83fb93d-322a-180d-1cc6-6b898ad63b92@linux.intel.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com> <20241010193705.10362-10-mario.limonciello@amd.com>
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
> Introduces power management callbacks for the `amd_hfi` driver.
> Specifically, the `suspend` and `resume` callbacks have been added
> to handle the necessary operations during system low power states
> and wake-up.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Whitespace changes
>  * Use on online CPUs not present ones
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index c969ee7ea5ee..0263993b0a94 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -407,6 +407,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int amd_hfi_pm_resume(struct device *dev)
> +{
> +	int ret, cpu;
> +
> +	for_each_present_cpu(cpu) {
> +		ret = amd_hfi_set_state(cpu, true);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable workload class config: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_hfi_pm_suspend(struct device *dev)
> +{
> +	int ret, cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		ret = amd_hfi_set_state(cpu, false);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to disable workload class config: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops, amd_hfi_pm_suspend, amd_hfi_pm_resume);
> +
>  static const struct acpi_device_id amd_hfi_platform_match[] = {
>  	{ "AMDI0104", 0},
>  	{ }
> @@ -458,6 +490,7 @@ static struct platform_driver amd_hfi_driver = {
>  	.driver = {
>  		.name = AMD_HFI_DRIVER,
>  		.owner = THIS_MODULE,
> +		.pm	= &amd_hfi_pm_ops,

This is inconsistent.

>  		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>  	},
>  	.probe = amd_hfi_probe,
> 

-- 
 i.


