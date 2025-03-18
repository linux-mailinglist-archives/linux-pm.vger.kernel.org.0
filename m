Return-Path: <linux-pm+bounces-24228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C4A66D03
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 08:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703203A6E6C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF821E8356;
	Tue, 18 Mar 2025 07:58:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E461DFE04;
	Tue, 18 Mar 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284724; cv=none; b=UwSQ9d+6LGtr/3/YreAdnUXvm5EO0epwVJB+h2O2DVRF2gn5H60pIFULpn6m4UqOnAZ/xAJI3ivAP7DtNsxD0H49Kqi41sIcgYK6Zu1d3ZKDUUCdBT8e4CCeRoZEZ3wKkGC+zTaTbkQUkYd+VKzj4YgTQUc9zS/pb2mpbCjjsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284724; c=relaxed/simple;
	bh=/DhwVu8DKF/R610pyPOmLKSv2pleUHx+A2HvVxAwuJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWGF6L5Dmy5ZVhpzamVX46hO/AjhFpAwhxIyctIjp+K/e2A1s26yjnZiUoUXaQS8lQT/ThAbrMK90JOvYAeUrbupeTedBVVd0Id261jYjVgP+SYVz4JbqtlZ3C9S9I06f78jhysnHuumvqam6GYXZiawWG3ok7aQWqafwpeehfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af679.dynamic.kabel-deutschland.de [95.90.246.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B1EB361E6479F;
	Tue, 18 Mar 2025 08:58:22 +0100 (CET)
Message-ID: <9a533395-f991-469d-a916-c1ee39d8bc5d@molgen.mpg.de>
Date: Tue, 18 Mar 2025 08:58:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/19] cpufreq/amd-pstate: Show a warning when a CPU
 fails to setup
To: Mario Limonciello <superm1@kernel.org>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
References: <20250226074934.1667721-1-superm1@kernel.org>
 <20250226074934.1667721-3-superm1@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250226074934.1667721-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mario,


Thank you for the patch.

Am 26.02.25 um 08:49 schrieb Mario Limonciello:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> I came across a system that MSR_AMD_CPPC_CAP1 for some CPUs isn't
> populated.  This is an unexpected behavior that is most likely a
> BIOS bug. In the event it happens I'd like users to report bugs
> to properly root cause and get this fixed.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Reviewed-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a093389a8fe3e..1b98f5d76894d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1034,6 +1034,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   free_cpudata2:
>   	freq_qos_remove_request(&cpudata->req[0]);
>   free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);

 From a user/operator point of view, having a recommended action in the 
log message would help a lot, as I am not able to judge the 
consequences, and where to go to. So, I’d propose:

Failed to initialize CPU %d: %d. This is likely a firmware error, and 
should be reported to the vendor.

The Linux kernel also has some macros. From `include/linux/printk.h`:

```
/*
  * FW_BUG
  * Add this to a message where you are sure the firmware is buggy or 
behaves
  * really stupid or out of spec. Be aware that the responsible BIOS 
developer
  * should be able to fix this issue or at least get a concrete idea of the
  * problem by reading your message without the need of looking at the 
kernel
  * code.
  *
  * Use it for definite and high priority BIOS bugs.
  *
  * FW_WARN
  * Use it for not that clear (e.g. could the kernel messed up things 
already?)
  * and medium priority BIOS bugs.
  *
  * FW_INFO
  * Use this one if you want to tell the user or vendor about something
  * suspicious, but generally harmless related to the firmware.
  *
  * Use it for information or very low priority BIOS bugs.
  */
#define FW_BUG          "[Firmware Bug]: "
#define FW_WARN         "[Firmware Warn]: "
#define FW_INFO         "[Firmware Info]: "
```

For ACPI:

     drivers/acpi/acpica/acutils.h:#define ACPI_MSG_BIOS_ERROR 
"Firmware Error (ACPI): "

>   	kfree(cpudata);
>   	return ret;
>   }
> @@ -1527,6 +1528,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	return 0;
>   
>   free_cpudata1:
> +	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>   	kfree(cpudata);
>   	return ret;
>   }


Kind regards,

Paul

