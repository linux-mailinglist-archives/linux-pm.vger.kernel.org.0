Return-Path: <linux-pm+bounces-28186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD049ACFE2C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFBD1895880
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8703283FE0;
	Fri,  6 Jun 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KwzOt/gD"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A9189F43;
	Fri,  6 Jun 2025 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198188; cv=none; b=X9kngHLrrvbWiyfbeyW9HtcRTdC2FAmsMBXoVGwdQw1KT/4L0xehNfF0/H6zmPK1+baKDgIQsvFGV3w5APMZ4Iq5f36eiCoadgmLOliV+6UOdrVJahOgeuDHKE6AIAjU6Wkm4ug6LVbZaORSap5K1i0soKxJYc/Z43b+kYum2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198188; c=relaxed/simple;
	bh=ivoX4r7KYxAqKYD1s1wmwegF8q36RQsFe5fTjupGLJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuFIzQC1pu+2qcl1ePUl8+gGr/XQQCemB7yaIzzZsXIUFUpb12gwD3PVLULly3QNL0VB1f5VbuhDgdxnIvK0L1uQImtdPeKYo3rRHsGSstaQsq27usO/tdk5xwl1g5GNBjM94AEhVj+UYeMjzeR4HLkirqX10rAnt9IDWYH9XJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KwzOt/gD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H0JpHwrg6m9oWWv4QZ7+WuHnHXvL+MLbWUK7Sbl+PVA=; b=KwzOt/gDHutXCfdoTahbJ0Q4H1
	1Q4GNDzPMnJuQJoWFShR8pF4q/tbrTdRS4YGxFKJC4r2KDtlJoFt4mvMRktLdcvx7lUq3FB60ecOI
	JT74645Q2ozznQyJwvT20cz3LzLz4vGy3SodLKzkvf3LSSYkiRWy/R37aDrPxZhUcktO5DRh2iP3u
	Ip6LX9s1QTxQnet+eaYJJ8UHd33cd6XgPtrOC7HDaq/Nusc5K0+ZUEYfPJOfdu1lHpeDsIpKsOzB7
	d473Xeo75i/7/VCY0bLDgixhhV6bfgcYWT6PLnI7PyJ9wUPZM0vJ2fhlmGsTWU40tR5Pwq6ESOlI3
	oQA2CwTA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNSLd-000000057xs-18V4;
	Fri, 06 Jun 2025 08:22:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1DA8300348; Fri,  6 Jun 2025 10:22:44 +0200 (CEST)
Date: Fri, 6 Jun 2025 10:22:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
	kees@kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
Message-ID: <20250606082244.GL30486@noisy.programming.kicks-ass.net>
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606062502.19607-1-zhangzihuan@kylinos.cn>

On Fri, Jun 06, 2025 at 02:25:02PM +0800, Zihuan Zhang wrote:

> @@ -2596,6 +2597,11 @@ pid_t kernel_clone(struct kernel_clone_args *args)
>  			trace = 0;
>  	}
>  
> +#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
> +	if (pm_should_block_fork() && !(current->flags & PF_KTHREAD))
> +		return -EBUSY;
> +#endif
> +
>  	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
>  	add_latent_entropy();

This isn't blocking fork(), this is failing fork(). Huge difference.
Also problematic, because -EBUSY is not a recognised return value of
fork(). As such, no existing software will adequately handle it.

