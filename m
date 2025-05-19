Return-Path: <linux-pm+bounces-27324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E9AABB72A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06493A591A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCC269D09;
	Mon, 19 May 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzhM0zXv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A8269CE4;
	Mon, 19 May 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643190; cv=none; b=Z+D+m2b9Zydq8LyCFZtTXOFPWKJYjR3BLRqg0nUdiHRz4J4SsOXuiE+uWtKtOewGITXERczdDZao2Ng/oCzDgxc0MhuSuAhsuoc9l7olVcfKjPo8EBSVdd03x0qffzr5Qqq1gTbNNi4fEQKWbR0Er5XPXmZdgQIRDNqOzJrgXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643190; c=relaxed/simple;
	bh=8o3tObdQzHXqS7Dl+JOlZR57bgKeSQtE6Ay18GvtY4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVo7p0kMuAW/UDwsV+7jigbC+FdEoQZ7quscvYSBXIvBPLz26Q93fw5+Ju4ArljZWEtXoMKPjCQkHj+J6D5ByojTlxguPVB6wuYeBjRECxtHmYQRRDDHljGsr7R4BAciue8l2GUylTtkVxZetFuwUck1T7F9yuaxVPj6MD2fG/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzhM0zXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA9DC4CEE4;
	Mon, 19 May 2025 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747643189;
	bh=8o3tObdQzHXqS7Dl+JOlZR57bgKeSQtE6Ay18GvtY4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzhM0zXv8lkCVGBUYggexhmkZJ8ighTi4mbvrZVcrSpVdfda5vU8ISRho27bpkxon
	 LMY1Utt5ltWWTXLZSxfsQfw9xUvxndBgAtcxV+GWi3TAT9W6H16LyTL/vqb+C7T+Ml
	 xEqgghT2tVrS70u+peXzqtcW7HKqkXBg+999Jr7I9ioTPab6v6Gill0p3V2v+d1zok
	 5guoB1Dw46yPPpTL0wTABBm6mw1rJg8raUkAeD5qnzVsSnIJro5JS9J5FRW6sMWD3r
	 TY20AWN1PxdA3h6xVR8d/hlVRuVZ7ezzWo0IgldLng4FJ8SkPOC66/BaacSLzwsRxC
	 wRzJbTaZSV+4w==
Date: Mon, 19 May 2025 10:26:24 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during CPU
 onlining
Message-ID: <aCrrMEN01O7FWY6V@gmail.com>
References: <20250518193212.1822-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518193212.1822-1-ebiggers@kernel.org>


* Eric Biggers <ebiggers@kernel.org> wrote:

> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -42,12 +42,15 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
>   * Represents the initial FPU state. It's mostly (but not completely) zeroes,
>   * depending on the FPU hardware format:
>   */
>  struct fpstate init_fpstate __ro_after_init;
>  
> -/* Track in-kernel FPU usage */
> -static DEFINE_PER_CPU(bool, in_kernel_fpu);
> +/*
> + * Track FPU initialization and kernel-mode usage. 'true' means the FPU is
> + * initialized and is not currently being used by the kernel:
> + */
> +DEFINE_PER_CPU(bool, kernel_fpu_allowed);

So this is a nice independent cleanup, regardless of the CPU 
bootstrapping bug it fixes. The fuzzy/negated meaning of in_kernel_fpu 
always bothered me a bit, and your patch makes this condition a bit 
cleaner, plus it defaults to 'disabled' on zero-initialization, which 
is a bonus.

>  void kernel_fpu_end(void)
>  {
> -	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
> +	/* Toggle kernel_fpu_allowed back to true: */
> +	WARN_ON_FPU(this_cpu_read(kernel_fpu_allowed));
> +	this_cpu_write(kernel_fpu_allowed, true);
>  
> -	this_cpu_write(in_kernel_fpu, false);
>  	if (!irqs_disabled())
>  		fpregs_unlock();

In addition to this fix, feel free to also send your x86 irqs-enabled 
FPU model optimization series on top, Ard says it shouldn't cause 
fundamental problems on EFI.

>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_end);
>  
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 6bb3e35c40e24..99db41bf9fa6b 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -49,10 +49,13 @@ static void fpu__init_cpu_generic(void)
>   */
>  void fpu__init_cpu(void)
>  {
>  	fpu__init_cpu_generic();
>  	fpu__init_cpu_xstate();
> +
> +	/* Start allowing kernel-mode FPU: */
> +	this_cpu_write(kernel_fpu_allowed, true);

Since this goes outside the regular kernel_fpu_begin()/end() methods, 
could you please also add an WARN_ON_FPU() check to make sure it was 
false before? x86 CPU init code is still a bit of spaghetti at times.

> @@ -1186,10 +1186,16 @@ void cpu_disable_common(void)
>  {
>  	int cpu = smp_processor_id();
>  
>  	remove_siblinginfo(cpu);
>  
> +	/*
> +	 * Stop allowing kernel-mode FPU. This is needed so that if the CPU is
> +	 * brought online again, the initial state is not allowed:
> +	 */
> +	this_cpu_write(kernel_fpu_allowed, false);

Ditto, an WARN_ON_FPU() would be nice: if kernel FPU is disabled at 
this point then something's fishy.

Thanks,

	Ingo

