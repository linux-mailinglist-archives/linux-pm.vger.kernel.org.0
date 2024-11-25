Return-Path: <linux-pm+bounces-18063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E979D86CA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C46165467
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B906192D8F;
	Mon, 25 Nov 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rZibG91j"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DB18872F;
	Mon, 25 Nov 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542313; cv=none; b=ZSx0t2May5sCnzmaScgSz9PxxizxbcEc6Rh6dFDWmHQ3s5aIHisNY+/Qx040rPmWEXrC/6+6siFtqvP74D+9mxTc3mUN/vAnc9OltDTtJ/elHj3EpH7A/elYkIYpj5A3C3ZxTr7iXBe4liPYThq4UcSyEhslfdqnGLRO9gLjmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542313; c=relaxed/simple;
	bh=6j+7tTXXVfZ4HmRx0rLEXPk7sOXrEITSmqML0HL/VrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1+KwQfghu9p38WTSS+BN3457doXe+9u+8NmWmAVsEFxcuYxjqm1dkZTaE/nCVjg3yQHiQ27PIGXugXCq+EWOkSeH5CNlRHLNveodDScxq6UipPWsxRowHZjeKchQ8/j11+AhHIDjwNZydv1EQSPAbYRa8cJf0A+uvD899hVJRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rZibG91j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PlA37XS3kIHnDddfculUSepb2VyrGVfj/y6TD8nVizU=; b=rZibG91jhwAnK9mMZqBgMf/wn/
	jtM8zqCwyJbmasgXpN9RQVIF3Ey9PNMNazQ2V5d/E40rnixfI6fUu4h73vwKqxf11QTcHxuE9OhOs
	T218TkRwJC9RevOPabUP2pB1pS6FTnyBRW1K87yRoxCmF1WXfXE0rB26x0qeTKYbymStQDztDwe4r
	pTf5SHsie+co8VNZin/GZx0r4nr3sHlllr10uqFCf5yauHOEBJDBp8YVE60EbPllYryqMlKuNGGk0
	y51TKSD6InEbnYPlr9/M0J/lwumRhIdV2GwhnZn2hac3HSqz61IGr+Uh4zE6EnyCnqHQtFbKstnFT
	c8L744Cw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFZOj-0000000Bvgr-03Bx;
	Mon, 25 Nov 2024 13:45:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9C2C30026A; Mon, 25 Nov 2024 14:45:05 +0100 (CET)
Date: Mon, 25 Nov 2024 14:45:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	tglx@linutronix.de, gautham.shenoy@amd.com
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
Message-ID: <20241125134505.GC38837@noisy.programming.kicks-ass.net>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>

On Mon, Nov 25, 2024 at 02:20:25PM +0100, Patryk Wlazlyn wrote:
> The algorithm based on cpuid leaf 0x5 in the mwait_play_dead(),
> for looking up the mwait hint for the deepest cstate may calculate the
> wrong hint on recent Intel x86 platforms.
> 
> Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
> only fallback to the later in case of missing appropriate enter_dead()
> handler.

So 7/8 should go first, such that picking cpuidle doesn't end up in some
weird state.

> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index d0464c7a0af5..2627b56fb9bc 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1413,9 +1413,10 @@ void native_play_dead(void)
>  	play_dead_common();
>  	tboot_shutdown(TB_SHUTDOWN_WFS);
>  
> +	/* The first successful play_dead() will not return */
> +	cpuidle_play_dead();
>  	mwait_play_dead();
> -	if (cpuidle_play_dead())
> -		hlt_play_dead();
> +	hlt_play_dead();
>  }
>  
>  #else /* ... !CONFIG_HOTPLUG_CPU */
> -- 
> 2.47.0
> 

