Return-Path: <linux-pm+bounces-20187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF66A08AC9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4D07A34EA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE182208978;
	Fri, 10 Jan 2025 08:57:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E59716DEA9;
	Fri, 10 Jan 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736499454; cv=none; b=s2IhtbqmKXBKtr1SDMxxOid5h6SuoznpLqLWZ9NjDO69bkfWr49aEGJfnUtKVNZ2ep7gx1AHDcwLMe4SiGxdKb3CorkKg876pyWd0NmXtsleBdb/LQYI5DtE6C1FVR/WN5GysI9mXfyiHNCK3U7zZ71l7n1lHR8uQ4R/T/72qpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736499454; c=relaxed/simple;
	bh=Tjw14NYUqYjRYbR6eRVWRYuV9iZjChtKW+k/ayQR6N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXzbHdQIZEDHzf7rBahotwhNGqY+5SNlnUQcIMAqIBcT67eSRNJX81ZbIMJb7lW0eYFUG72bT8D/3/Pk6hQwVOhzuA9MBfwikNAO3Dz9wEUzH84hykzBl0Do0ij2JCrselxUFEUo+EVyXBsMjfCV2PfulsrvfH/ulaQ+5uZ45qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC2B12FC;
	Fri, 10 Jan 2025 00:57:59 -0800 (PST)
Received: from [10.34.125.29] (e126645.nice.arm.com [10.34.125.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B2D13F673;
	Fri, 10 Jan 2025 00:57:29 -0800 (PST)
Message-ID: <2751313c-4862-4dfd-9017-68ca02671fdd@arm.com>
Date: Fri, 10 Jan 2025 09:57:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Move endif to the end of Kconfig file
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux-kernel@vger.kernel.org
References: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Viresh,

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

On 1/10/25 06:53, Viresh Kumar wrote:
> It is possible to enable few cpufreq drivers, without the framework
> being enabled. This happened due to a bug while moving the entries
> earlier. Fix it.
> 
> Fixes: 7ee1378736f0 ("cpufreq: Move CPPC configs to common Kconfig and add RISC-V")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ea9afdc119fb..d64b07ec48e5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -325,8 +325,6 @@ config QORIQ_CPUFREQ
>   	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
>   	  which are capable of changing the CPU's frequency dynamically.
>   
> -endif
> -
>   config ACPI_CPPC_CPUFREQ
>   	tristate "CPUFreq driver based on the ACPI CPPC spec"
>   	depends on ACPI_PROCESSOR
> @@ -355,4 +353,6 @@ config ACPI_CPPC_CPUFREQ_FIE
>   
>   	  If in doubt, say N.
>   
> +endif
> +
>   endmenu

