Return-Path: <linux-pm+bounces-17402-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37B9C56E8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358DA1F21565
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3919E992;
	Tue, 12 Nov 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hhWllPcO"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5D230998;
	Tue, 12 Nov 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412070; cv=none; b=cO1Kyn2Dc2hPJ7ZSpbYWbBG/MyOnUC6ek/Xo8VqOw3x6XOsWZp8CFck62tiwz+yCJ6u2+jTH/xXQyIK0zI0gY/Cc4dORW6FLAc0Gbzddr2VAzj33IHOl0Tcn3WEldEWdDqlTYMA5NKa9AwafbxjgfgK53Vu53DWvczPIQfkcWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412070; c=relaxed/simple;
	bh=vWKt6okpf1CcZtMnFmPB0o2JO+FOA7FIyM+xEZiMp9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t//6e5TUQtPps8Moac2yIu74bdWWvGi0v6AedPiSp12fBWiKb2eabh1jxSjrA2CpXcw9/tURtkH0UWWD6F/kJCoATLCLBrk/tfhLPvqjv6Gm6SaGYeuudDe32VxW6j6y16V8Rk12HFX+KNcsDOmHPYblXn7mlgMpk9kMnZc6zQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hhWllPcO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AF6r0SiSXgSSjWFrdKOoPwokbb994bWrrG0GTMLbQmY=; b=hhWllPcOv1wg/u2ts/CNVlKU5o
	UlypYgntJFRU2OPFKKRrqmWMj85Ex/1+p2ZfWhtB2le01TZc+/Rg5WWmwkWcX12ZR2/BE/PFHdSsO
	HzZ1AM9Ykh3nYmIHHa7LJVxQWDzijkuWcCJGbYJQvEl5QAeb4Kndb5a7Z1XEZjv59Yg1kY30DtYs1
	C3AEjO7Z7Wxu8vsI12kHZbuk+nvOAK5nN7LCagEt8WnedC1lLQhT986u4HXm5DzJpcHnLgYIXL4D2
	jOM8T17/G5sb6zJSkEDMY503KU34Y2HWFmlzHhwDkzj6pMG2QKDJs7bOl4SZPX1OqDaEGGeS4Q3Mj
	bup6jYfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tApN2-0000000EKTc-2IFJ;
	Tue, 12 Nov 2024 11:47:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2A94300478; Tue, 12 Nov 2024 12:47:43 +0100 (CET)
Date: Tue, 12 Nov 2024 12:47:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH v3 2/3] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241112114743.GQ22801@noisy.programming.kicks-ass.net>
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108122909.763663-3-patryk.wlazlyn@linux.intel.com>

On Fri, Nov 08, 2024 at 01:29:08PM +0100, Patryk Wlazlyn wrote:
> The generic implementation, based on cpuid leaf 0x5, for looking up the
> mwait hint for the deepest cstate, depends on them to be continuous in
> range [0, NUM_SUBSTATES-1]. While that is correct on most Intel x86
> platforms, it is not architectural and may not result in reaching the
> most optimized idle state on some of them.
> 
> Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
> fallback to the later in case of missing enter_dead() handler.
> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 44c40781bad6..721bb931181c 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1416,9 +1416,9 @@ void native_play_dead(void)
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  
> -	mwait_play_dead();
>  	if (cpuidle_play_dead())
> -		hlt_play_dead();
> +		mwait_play_dead();
> +	hlt_play_dead();
>  }

Yeah, I don't think so. we don't want to accidentally hit
acpi_idle_play_dead().

