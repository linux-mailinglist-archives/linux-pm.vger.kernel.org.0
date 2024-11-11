Return-Path: <linux-pm+bounces-17338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 919729C46BE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4990F1F2791A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA151BDA97;
	Mon, 11 Nov 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XO27st+G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYsTkWdL"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0021AB6CD;
	Mon, 11 Nov 2024 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356474; cv=none; b=YUPew8ncG+o4DqRwiWFlvQBIdJ3Qtk4rzGodZmg8vQfbX/aysrv7Nzqxo2XMXjtNQCypwIad45LUPy+YcoA8fEgtbfm852AUWA+t5qCjnTHlOw2NQvzJl7LruUr3TGUNUTUB3kYHzRIboc7Sf/yqaoamBGaoK/n1wUz4XAudVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356474; c=relaxed/simple;
	bh=ojQykrLwa+tKVHzD0LKClI4RYtpcQsk2fkaiV9hWwpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EzNGbYKrEA92zEzxNdzXYaq6/jYq4GimwOG4rr4pi8VXX1LdlESEr8O0VkJOHG28rtdhTx0g8xpf3tU07tL8eXZ31Dzo1R0AzdsctiPqMFIVQTwdt2lALHoHM9yAGLMXuliXUjAkJT3zdDrmkyZwtMNQi6tkpzqQezzpgKNdhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XO27st+G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYsTkWdL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731356470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hSl5IUzYiQFRrGtMgdO4k5sLda41cEm5CkQfrFqzmg=;
	b=XO27st+GHxZL95ZbvppHkQaXDaJcUHok9iYlRsmI35VBlEa0A2e9T+Bg6PuYqpL25nG7a1
	tuZ+iCcfaeLakCH3Zs64Ayj7B+9285nVSJFDTw80ocGV7EIH8W/Q4vuNVWZo8iVwjnjRV9
	h+LYslP0m7iCGEnMGcLXf4gDP6ppy3sVVrQnLIyQiqg8zyMUD6mzBrq9bIadLGrE2DFudf
	WKLPZSxdEs34o2OZHyJ5U3MptPi3QG3T+cuQcjuEmt7Fexj85BnEl2undFq0eXa/kNf8qA
	qpxLiESJ6IVxLGHpcOfoGOsL+rAV165AyEjlGAyoTqJvH6FEKyxxXM2m8aCGbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731356470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hSl5IUzYiQFRrGtMgdO4k5sLda41cEm5CkQfrFqzmg=;
	b=QYsTkWdLTzQnfzA4P0VAiCNBJsx//D6VySQ3xBlhN0TSRc6RKxay3wX046CGMfOKMr4akp
	bpAnO0aTER4xLRDw==
To: Len Brown <lenb@kernel.org>, peterz@infradead.org, x86@kernel.org
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
In-Reply-To: <20241108135206.435793-3-lenb@kernel.org>
References: <20241108135206.435793-1-lenb@kernel.org>
 <20241108135206.435793-3-lenb@kernel.org>
Date: Mon, 11 Nov 2024 21:20:32 +0100
Message-ID: <87msi5o73j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 08 2024 at 08:49, Len Brown wrote:
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index e7656cbef68d..aa63f5f780a0 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -586,7 +586,8 @@ static void init_intel(struct cpuinfo_x86 *c)
>  	     c->x86_vfm == INTEL_WESTMERE_EX))
>  		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
>  
> -	if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm == INTEL_ATOM_GOLDMONT)
> +	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> +			(c->x86_vfm == INTEL_ATOM_GOLDMONT || c->x86_vfm == INTEL_LUNARLAKE_M))

This indentation is bogus.

>  		set_cpu_bug(c, X86_BUG_MONITOR);

> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 766f092dab80..910cb2d72c13 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1377,6 +1377,9 @@ void smp_kick_mwait_play_dead(void)
>  		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
>  			/* Bring it out of mwait */
>  			WRITE_ONCE(md->control, newstate);
> +			/* If MONITOR unreliable, send IPI */
> +			if (boot_cpu_has_bug(X86_BUG_MONITOR))
> +				__apic_send_IPI(cpu, RESCHEDULE_VECTOR);

How is this supposed to work?

The local APIC of the offline CPU is shut down and only responds to
INIT, NMI, SMI, and SIPI.

Even if the APIC would react to the IPI, then the offline CPU would not
notice as is has interrupts disabled when it reaches mwait_play_dead().

Seriously?

Thanks,

        tglx

