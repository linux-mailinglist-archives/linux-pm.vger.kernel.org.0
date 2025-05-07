Return-Path: <linux-pm+bounces-26823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F7AAE583
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151DB1889BE6
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2A28D829;
	Wed,  7 May 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HbNhBWWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847A28C861;
	Wed,  7 May 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632986; cv=none; b=e1YXQK7O0Gk6chNLQ6C8ZyloDGxg/1XqsdgLCPw/j6B6dhYc+617Pi5JjRRz/cnNlFqOZgGRXBNRAXz09ZtFmuw9t3G35eo7ozSXabN++jVqOaP6Ayogw1ity2As9Wb8AfAf3w9+jBlAhQ04YUhgSEpr+0gLkIF/WkbOjPZ+hzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632986; c=relaxed/simple;
	bh=nNzHKx96NKIWwmqZT773FwQ0tJHihDbRn8PZQIr1ypk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUyjJV8xYlN58G2zdR7swQ8zrzH7WZZDPjoHzEw3XGHwSAeMJEg4HMlDAqJmHAuLLlkaEbJddx+4MNo5vxVW3EKrAgAiagVqy0iDwpXOSYyp8KCa/zWo8MsUKfwWfm0C0oOR/vu/EUCWpsn0yzil73y8mR8kFG5LC6wIQKxas7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HbNhBWWt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=XrB6lkb4kjYGUyvVTgh7sRxO8qkr0KQ3qTvgnKF9Guw=; b=HbNhBWWte43Fv5kuCqbpHhn/3b
	ozaiWNEm+7ZeZNWHs+UA7boIngxYZAk+/TS10Y4z7uT/jCw70n8HHsqeWCagYiShZhZDTYpR4PhMV
	aYPFXltC2a6pIm+LHQBJfQ1PD4qsYVvSkuOqgjqOolmgriTNE1Q7LsohaUPPldbXtiCrqcUJhO3QA
	dRkhpzH1n+45qZqRV4J/B9qwvErE51DQU5inkKyzMa7uis2XE95F3vOob2At1B4tvktlDGp225045
	QIBqKW82DhqYGR+U3B7g0zFFTvmm6X/zDO3Q2aDcq7KRjH0t5UN7mSAMmb1zf3F37guGuosLxZ3tR
	JSNrqzYg==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCh1T-0000000FsKa-0PVQ;
	Wed, 07 May 2025 15:49:27 +0000
Message-ID: <06bcea82-11d5-4dcf-8331-c073e6d9078f@infradead.org>
Date: Wed, 7 May 2025 08:49:20 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / sleep: add configurable delay for pm_test
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, corbet@lwn.net, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, thuth@redhat.com, bp@alien8.de,
 ardb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250507063520.419635-1-zhangzihuan@kylinos.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250507063520.419635-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/6/25 11:35 PM, Zihuan Zhang wrote:
> This patch turns this 5 second delay into a configurable module
> parameter, so users can determine how long to wait in this
> pseudo-hibernate state before resuming the system.
> 
> The configurable delay parameter has been added to suspend and
> synchronized to hibernation.
> 
> Example (wait 30 seconds);
> 
>   # echo 30 > /sys/module/hibernate/parameters/pm_test_delay
>   # echo core > /sys/power/pm_test
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> v3:
>  - Fix the location of the hibernate.pm_test_delay parameter in
>    kernel-parameters.txt.
>  - Update ‘[hibernate]’ to ‘[HIBERNATION]’
> v2:
>  - Fix typos.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  kernel/power/hibernate.c                        | 9 +++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d9fd26b95b34..a110cbb37f20 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1828,6 +1828,13 @@
>  				lz4: Select LZ4 compression algorithm to
>  				compress/decompress hibernation image.
>  
> +	hibernate.pm_test_delay=
> +			[HIBERNATION]
> +			Sets the number of seconds to remain in a hibernation test
> +			mode before resuming the system (see
> +			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
> +			is set. Default value is 5.
> +
>  	highmem=nn[KMG]	[KNL,BOOT,EARLY] forces the highmem zone to have an exact
>  			size of <nn>. This works even on boxes that have no
>  			highmem otherwise. This also works to reduce highmem
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 23c0f4e6cb2f..485133af884d 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -133,10 +133,15 @@ bool system_entering_hibernation(void)
>  EXPORT_SYMBOL(system_entering_hibernation);
>  
>  #ifdef CONFIG_PM_DEBUG
> +static unsigned int pm_test_delay = 5;
> +module_param(pm_test_delay, uint, 0644);
> +MODULE_PARM_DESC(pm_test_delay,
> +		 "Number of seconds to wait before resuming from hibernation test");
>  static void hibernation_debug_sleep(void)
>  {
> -	pr_info("debug: Waiting for 5 seconds.\n");
> -	mdelay(5000);
> +	pr_info("hibernation debug: Waiting for %d second(s).\n",
> +		pm_test_delay);
> +	mdelay(pm_test_delay * 1000);
>  }
>  
>  static int hibernation_test(int level)

-- 
~Randy

