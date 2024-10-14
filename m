Return-Path: <linux-pm+bounces-15612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996A99C6F6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 12:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2A21C224E9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED79156676;
	Mon, 14 Oct 2024 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsRxUtbr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220033998;
	Mon, 14 Oct 2024 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900951; cv=none; b=XDVgRKh2nZbQWg0asMglqKpciM5NuL8soCIHAeZG14i0WGG0XLk9N1gJ7G4vtxOslN4vztghqdDvyPO6iG6ZcHmcMaYczM0fEYv38vZXCdv6EtrmR5EeBC/TEn5eSDhMhl0Hn/sU54sJURBSZ/nMEpdg9SxffkQ1w0SylM5BXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900951; c=relaxed/simple;
	bh=dRXN5el4NbVo29rKzPFTfEbrmk+mmaJvKdOnqYUl02I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MIlqyeoOXDi0agDR0ZL5o/404fSvMS+YTlpROV4D4J5TNQBZBZEirhNy4tNJaecXaZa/XknxUcCr69wzDzXJSEfjhqZ6/dtBxJ+ve/khLiBd3UdT5AryV8ISfAC4O133e+B1VaL1Jwt8rAmdWwlwSRpC8ZqQg+k31rpQld1MhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsRxUtbr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728900950; x=1760436950;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dRXN5el4NbVo29rKzPFTfEbrmk+mmaJvKdOnqYUl02I=;
  b=AsRxUtbrvy3U1dij87aLkUmgRESawTxYVnAZZuk9OXsnJy5XteZv5yGn
   UKIj1fK5lEVo8tEOHSVNiu5B/tUGgkR+H0l4gmOYMXZ1b3pEoQQavYXxw
   I6jj68uO8XJObRR0j2ERPAsaNkVoOz53NQ1WTTWWeUS1qKwMQF5Tf0CL8
   Y6/3xbB5ZIr/5goS007xXmGTqhH7aFZTGgpB3J0adTIRS559CIUEBOQi7
   jVwXZJIgGUr+rNkp2lEtGfrMgu17vKwW9BmJE2Xunv/YpLHBy64CPjktP
   aSlgfctusN5YL/vnEZYEC/Nv07E16mAq60k+9Z1+1gXCOPbGkZmGdoLMP
   A==;
X-CSE-ConnectionGUID: Bt50ptE5SeWduN1JxWt5Lw==
X-CSE-MsgGUID: 01QiwDniRLKgDLD+GkxNSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="27725636"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="27725636"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:15:49 -0700
X-CSE-ConnectionGUID: 7z5LAh2WQuWygs0J/HRvhw==
X-CSE-MsgGUID: BAyiMR17Sr6fZhf7TIBjIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="108325958"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:15:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Oct 2024 13:15:43 +0300 (EEST)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
    x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v2 07/13] platform/x86: hfi: init per-cpu scores for each
 class
In-Reply-To: <20241010193705.10362-8-mario.limonciello@amd.com>
Message-ID: <9c434cd5-24d6-4da9-89b5-b7ce42e6374a@linux.intel.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com> <20241010193705.10362-8-mario.limonciello@amd.com>
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
> Initialize per cpu score `amd_hfi_ipcc_scores` which store energy score
> and performance score data for each class.
> 
> `Classic core` and `Dense core` are ranked according to those values as
> energy efficiency capability or performance capability.
> OS scheduler will pick cores from the ranking list on each class ID for
> the thread which provide the class id got from hardware feedback
> interface.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Rework
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 32 ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 10651399cf75..c0065ba0ed18 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -119,6 +119,8 @@ struct amd_hfi_cpuinfo {
>  
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>  
> +static DEFINE_MUTEX(hfi_cpuinfo_lock);
> +
>  static int find_cpu_index_by_apicid(unsigned int target_apicid)
>  {
>  	int cpu_index;
> @@ -233,6 +235,31 @@ static void amd_hfi_remove(struct platform_device *pdev)
>  	mutex_destroy(&dev->lock);
>  }
>  
> +static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
> +{
> +	for (int i = 0; i < hfi_cpuinfo->nr_class; i++)
> +		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
> +			   hfi_cpuinfo->amd_hfi_classes[i].perf);
> +
> +	return 0;
> +}
> +
> +static int update_hfi_ipcc_scores(struct amd_hfi_data *amd_hfi_data)
> +{
> +	int cpu;
> +	int ret;
> +
> +	for_each_online_cpu(cpu) {
> +		struct amd_hfi_cpuinfo *hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
> +
> +		ret = amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int amd_hfi_metadata_parser(struct platform_device *pdev,
>  				   struct amd_hfi_data *amd_hfi_data)
>  {
> @@ -330,6 +357,11 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out;
>  
> +	/* set up IPCC scores */
> +	ret = update_hfi_ipcc_scores(amd_hfi_data);
> +	if (ret)
> +		goto out;

return ret;

or

directly:

return update_hfi_ipcc_scores(amd_hfi_data);

> +
>  out:
>  	return ret;
>  }
> 

-- 
 i.


