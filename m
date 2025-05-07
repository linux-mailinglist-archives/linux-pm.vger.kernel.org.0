Return-Path: <linux-pm+bounces-26771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39FEAAD4A7
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 06:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D14B3B5D29
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 04:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46621DC997;
	Wed,  7 May 2025 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kc+QE9oF"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0C1D47AD;
	Wed,  7 May 2025 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593786; cv=none; b=pcXAfoRtsJr0uKbyvBZMeNhn6Gl+Tzw04pyrCBHGKR7nXqojOvj7NcukKRk9/VQBRKJj0QFNZeJv4KHBkIqoZhXTSN5BSaJ7J37kyKoel4KF88ggqEybCKpRAEVa6msdkmWRLYHLtbIE0GHOM7QqBz+6boQuedV8AbWBVRw+Fn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593786; c=relaxed/simple;
	bh=9jIBqH7TPNDVTmKhd7KpKnbNdxeWwBlPYvHE2AcFR1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr+psoic5wt8TgaCt0QgNYG03/MAnISxDOx9dLVcXnXgf0RFbypb7Re0x7ayx4Klo1lH0/SiWJV00ZJS0E6guTiA9gYis/mq8zIWK7PZKeIK3YCWwRrrYdBqAtNXvHwsjZlp+65k+94AQjH2RYsKKiLV5outBLT81jn8ikoxZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kc+QE9oF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=N5bPkg226EKMF4WuvG4/jLahT3vup/kMIHHolfgCUkc=; b=Kc+QE9oFwrl8dJabek7e1KhsIU
	DnMQDt6l3zM2+lgtVcmu3JF/1GMOJsj40p/cGGAF0ZnUQFoh2kHIwYwtCRadHKexciUeIf6xEEUor
	rTXfnqqwjySG/NDtJaOEiU2KsAFkzNZgxGy48iOH+w3in6BZY4m84xCs7k1/y8xkvg9SGt8OdeCzI
	2+47HzslA/H6FmbB9MVGI3bkvFJgzWSK9aEKO2vdynO2jE6BrauO/iFWJf4Yq0C/MC9mtC4jryLee
	vEV+HHnaU0JVzEMnaX9+JNdIYmDP27XhYiKGRxg94Go/H2YIdpBBJFJ8v4KwqNwNAGENSkuxNqHEd
	l5QDyzlA==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCWpB-0000000Flty-1EHz;
	Wed, 07 May 2025 04:56:06 +0000
Message-ID: <494e6102-6d4d-46df-ba1d-8603113609b5@infradead.org>
Date: Tue, 6 May 2025 21:55:59 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM / sleep: add configurable delay for pm_test
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, corbet@lwn.net, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, thuth@redhat.com, bp@alien8.de,
 ardb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250507034449.336863-1-zhangzihuan@kylinos.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250507034449.336863-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 5/6/25 8:44 PM, Zihuan Zhang wrote:
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
> ---
> v2:
>  - Fix typos.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  kernel/power/hibernate.c                        | 9 +++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d9fd26b95b34..1532c6fdc2d1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6998,6 +6998,13 @@
>  			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
>  			is set. Default value is 5.
>  

Please keep entries in kernel-parameters.txt in alphabetical order.

> +	hibernate.pm_test_delay=
> +			[hibernate]

	According to kernel-parameters.rst, that line above should be
			[HIBERNATION]

> +			Sets the number of seconds to remain in a hibernation test
> +			mode before resuming the system (see
> +			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
> +			is set. Default value is 5.
> +
>  	svm=		[PPC]
>  			Format: { on | off | y | n | 1 | 0 }
>  			This parameter controls use of the Protected
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


