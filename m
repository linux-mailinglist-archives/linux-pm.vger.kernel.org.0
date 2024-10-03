Return-Path: <linux-pm+bounces-15128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A42598FA57
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 01:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04BC2825C1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450981CF28D;
	Thu,  3 Oct 2024 23:17:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754DA1ABEAB;
	Thu,  3 Oct 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997453; cv=none; b=lY/t7qbrEKuxEWQ4Jw1fpSY9GfAYAEsqsxpFh2y55dmnoU/6yZGEuIz2vOYvDnR/jRQNUKf4IODPGOgMj0hpBeUBxCewj1y2jOMBmr3wuk2+i3xo2WIQeF0mfexETEdliDs1qs/jjQOMwx4QbvIgoAWzn2vZJYahJY/dpaGc19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997453; c=relaxed/simple;
	bh=P5UcpAipfbHxuw26N/La74wzuf3cWkCq92gj8uBLqhI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kNLb7RItqkMDJxsZn54dDxtbuEn3e1yUbv9JPRJHbX3as5OkYBbPTL8u/+VxM6yM4sl7/pRVaO/cVasN0adkPa0KyIuUEGNtGI+lIhZnimcJ6PrG5R09Wa7Pa7uHpYqwj7n9tcwThZyBtULIFKRBQ08aQvL5Y1Gk2fAe7ggoUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.1.164] (77-32-42-93.dyn.eolo.it [77.32.42.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9600561E5FE05;
	Fri,  4 Oct 2024 01:16:20 +0200 (CEST)
Message-ID: <862f7737-c88b-4e19-a384-52a3ecb43111@molgen.mpg.de>
Date: Fri, 4 Oct 2024 01:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] platform/x86:intel/pmc: Disable ACPI PM Timer disabling
 on Sky and Kabe Lake
To: Hans de Goede <hdegoede@redhat.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Todd Brandt <todd.e.brandt@intel.com>,
 Marek Maslanka <mmaslanka@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, regressions@lists.linux.dev,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241003202614.17181-1-hdegoede@redhat.com>
 <20241003202614.17181-2-hdegoede@redhat.com>
Content-Language: en-US
In-Reply-To: <20241003202614.17181-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Hans,


Thank you for the patch.

Am 03.10.24 um 22:26 schrieb Hans de Goede:
> There have been multiple reports that the ACPI PM Timer disabling is
> causing Sky and Kabe Lake systems to hang on all suspend (s2idle, s3,

Kab*y* (also in the summary)

> hibernate) methods.
> 
> Remove the acpi_pm_tmr_ctl_offset and acpi_pm_tmr_disable_bit settings from
> spt_reg_map to disable the ACPI PM Timer disabling on Sky and Kabe Lake to

Ditto.

> fix the hang on suspend.
> 
> Fixes: e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be turned off when suspended")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/linux-pm/18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de/
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219346
> Cc: Marek Maslanka <mmaslanka@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/platform/x86/intel/pmc/spt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
> index 2cd2b3c68e46..ab993a69e33e 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -130,8 +130,6 @@ const struct pmc_reg_map spt_reg_map = {
>   	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
>   	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
>   	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
> -	.acpi_pm_tmr_ctl_offset = SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> -	.acpi_pm_tmr_disable_bit = SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>   	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
>   	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
>   };

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 
9360/0596KF, BIOS 2.21.0 06/02/2022 (suspend/resume with deep and s2idle)


Kind regards,

Paul

