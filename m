Return-Path: <linux-pm+bounces-20237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E7A093B8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727DD3AAA84
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25F211283;
	Fri, 10 Jan 2025 14:43:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386020E709;
	Fri, 10 Jan 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520200; cv=none; b=ahQnxFu7sJFWAUtdsMlpu+KqKZvrO07acnfGU8QhfIYC+JAqZF1CiVBYQrlSj+UXCGEkD99venM4W64HoS+7epddh3LO6wzZPqKs1ShnVhvxLaggPGiF0cEVRtVAtMem7yUp2cPFw/VF4zNxEsJ9iMD/vNkmwW7n5UYlG31vjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520200; c=relaxed/simple;
	bh=nIMz0d9P6zrHS8PFXzTOS07bZr4FkJ5AhzqfSDFr8N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiqN4kqZj9wea+v57v3kPQSpfKIBEtXryo58Wbw8VLVIIlpDEM36YKB4zQE4UglBW0H1qK9CCBDbeOdUYVetzhaz3B/be4zhgT66SOOHPQi1oJyDHaniBU6Icr2WyEu/Qv4Uy7HF48spLrTmLGkvmkr4uqKat9yqKqDiZrYnBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C1431477;
	Fri, 10 Jan 2025 06:43:45 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4A13F59E;
	Fri, 10 Jan 2025 06:43:15 -0800 (PST)
Date: Fri, 10 Jan 2025 14:43:13 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Pierre Gondois <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Move endif to the end of Kconfig file
Message-ID: <Z4EyAQuuBSOV5Xwd@bogus>
References: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>

On Fri, Jan 10, 2025 at 11:23:10AM +0530, Viresh Kumar wrote:
> It is possible to enable few cpufreq drivers, without the framework
> being enabled. This happened due to a bug while moving the entries
> earlier. Fix it.
>

Surprising to see how randconfigs has not managed to catch this so far.

Anyways,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Fixes: 7ee1378736f0 ("cpufreq: Move CPPC configs to common Kconfig and add RISC-V")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index ea9afdc119fb..d64b07ec48e5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -325,8 +325,6 @@ config QORIQ_CPUFREQ
>  	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
>  	  which are capable of changing the CPU's frequency dynamically.
>  
> -endif
> -
>  config ACPI_CPPC_CPUFREQ
>  	tristate "CPUFreq driver based on the ACPI CPPC spec"
>  	depends on ACPI_PROCESSOR
> @@ -355,4 +353,6 @@ config ACPI_CPPC_CPUFREQ_FIE
>  
>  	  If in doubt, say N.
>  
> +endif
> +
>  endmenu
> -- 
> 2.31.1.272.g89b43f80a514
> 

-- 
Regards,
Sudeep

