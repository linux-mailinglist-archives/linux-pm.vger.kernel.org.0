Return-Path: <linux-pm+bounces-19506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45AF9F7829
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 10:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607B316440C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AF8221459;
	Thu, 19 Dec 2024 09:17:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F901F63EC;
	Thu, 19 Dec 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599845; cv=none; b=ttsHlg+fdTD22t42ZpbD0J32vP1gixSSQAwkWYKZ3YJzbF+kOV7zkWbhK4S7Of/NfN8pE04stJsET1JzP7X0kTwzQyN4QYchZGQ3ljWFUJfp9FrbX2xmu2BWH7ajSPMoiuULRv/BehHeyW3wDyHZ64Hn4m0eyelLHl1PIt9c6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599845; c=relaxed/simple;
	bh=PpQ/4zZIqhV5Bmbzo/POv9RQxWL6uY4EORdaMnDPB/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZ8w8oKT7pck3UybDhesKp0ecT54aPeOuzW8b/hb1lrt/BS//Fl8z68K0pDrbHWWRtM6pHoX+enMR3rP7wxm+UEZ0Zvl5F70gnBYbmRkOxV4nSiBimcBqFeV9Q8YJ5SKFs0Hra8b2NuV+OuEmn2+JloT8qory4UTURgMKYQh8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C3B1477;
	Thu, 19 Dec 2024 01:17:50 -0800 (PST)
Received: from [10.57.68.234] (unknown [10.57.68.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B598F3F528;
	Thu, 19 Dec 2024 01:17:20 -0800 (PST)
Message-ID: <a43ebb14-be7f-4f8a-8892-cdb63eec4043@arm.com>
Date: Thu, 19 Dec 2024 09:18:50 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: energy_model: Rework the depends on for
 CONFIG_ENERGY_MODEL
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, len.brown@intel.com,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, xuewen.yan94@gmail.com,
 jeson.gao@unisoc.com, di.shen@unisoc.com, pavel@ucw.cz
References: <20241219091109.10050-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20241219091109.10050-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/19/24 09:11, Xuewen Yan wrote:
> From: Jeson Gao <jeson.gao@unisoc.com>
> 
> Now not only CPUs can use energy efficiency models, but GPUs
> can also use. On the other hand, even with only one CPU, we can also
> use energy_model to align control in thermal.
> So remove the dependence of SMP, and add the DEVFREQ.

That's true, there are 1-CPU platforms supported. Also, GPU can have
the EM alone.

> 
> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> ---
>   kernel/power/Kconfig | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index afce8130d8b9..c532aee09e12 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -361,8 +361,7 @@ config CPU_PM
>   
>   config ENERGY_MODEL
>   	bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
> -	depends on SMP
> -	depends on CPU_FREQ
> +	depends on CPU_FREQ || PM_DEVFREQ
>   	help
>   	  Several subsystems (thermal and/or the task scheduler for example)
>   	  can leverage information about the energy consumed by devices to

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

