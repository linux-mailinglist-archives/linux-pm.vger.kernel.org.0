Return-Path: <linux-pm+bounces-27259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8042ABA89C
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEA51BA06EA
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D81C5D46;
	Sat, 17 May 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCpjNeHj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1415689A;
	Sat, 17 May 2025 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747465747; cv=none; b=hbVe62ATUtLrWne5zjE+TOJGq2jlt2OFGum+SRXqPKuF/haW1xod4SS+b3j+wJjfhtPwICM6EbLIAld0cg+gL0vAJpLjs8cgaYNg8LNNrKXod/DD74EXRSv+G1VhNsQf7JzJbtLuyDY74eJkciQGhx9FsJJYi0wL1s56f70REBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747465747; c=relaxed/simple;
	bh=cixUaHmJPeAy0w9OJHTf4T/FfmSyq6GN6NLOKZFyEYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NupMC+HUk9H+JCfKv8054106BcYoJIBeeR8N4xnoQuD0n1Mw3C+RTvwrTvKmmpoCWToNshwQsGRq3krCfKPwvk8lT7HrOVQypyiAA1fW6vaXnyZ+qFZ5KcyYWzXMch7jfBpnl2GNG1gL54f9Wcjg1dAGTWDaXzFlKQXsEg2tjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCpjNeHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31039C4CEE3;
	Sat, 17 May 2025 07:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747465746;
	bh=cixUaHmJPeAy0w9OJHTf4T/FfmSyq6GN6NLOKZFyEYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCpjNeHjO2aKbvNdlwWIy+3GB269SRrIM91wDAVVoWbIzU5fNUKIXrJEFLqgi+YQv
	 PmYrcITCBsy2mdA5klrKoRPKglBsNb6442h098hTn68JWYzlJ1dq2TTXJDI1nJmr08
	 1SDY2Y9brnIco5DVNmZMYrrhv/byUSNTbgeoEHQUzgpHO83KHHiZW67Zyg9OLusK4I
	 qfmqVVc9cdnETNBWx5YWVZXKAo3/onw4w8oJAUzO8mp7wHUa01W1zu8xz6LK2El4FL
	 HgalOj094PLloazT1UwSY52MfpXvx3KtXrEy2Bxpy34Qiaaw8JaZ6sKQtob0on+QKF
	 BbcjxXsW4Ae2w==
Date: Sat, 17 May 2025 09:09:01 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when
 irqs_disabled()
Message-ID: <aCg2DSYp0nakwX3l@gmail.com>
References: <20250516231858.27899-1-ebiggers@kernel.org>
 <20250516231858.27899-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516231858.27899-4-ebiggers@kernel.org>


* Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Make irq_fpu_usable() return false when irqs_disabled().  That makes the
> irqs_disabled() checks in kernel_fpu_begin_mask() and kernel_fpu_end()
> unnecessary, so also remove those.
> 
> Rationale:
> 
> - There's no known use case for kernel-mode FPU when irqs_disabled().

Except EFI?

>   arm64 and riscv already disallow kernel-mode FPU when irqs_disabled().
>   __save_processor_state() previously did expect kernel_fpu_begin() and
>   kernel_fpu_end() to work when irqs_disabled(), but this was a
>   different use case and not actual kernel-mode FPU use.
> 
> - This is more efficient, since one call to irqs_disabled() replaces two
>   irqs_disabled() and one in_hardirq().

This is noise compared to the overhead of saving/restoring vector CPU 
context ...

> - This fixes irq_fpu_usable() to correctly return false during CPU
>   initialization.  Incorrectly returning true caused the SHA-256 library
>   code, which is called when loading AMD microcode, to take a
>   SIMD-optimized code path too early, causing a crash.  By correctly
>   returning false from irq_fpu_usable(), the generic SHA-256 code
>   correctly gets used instead.  (Note: SIMD-optimized SHA-256 doesn't
>   get enabled until subsys_initcall, but CPU hotplug can happen later.)

Alternatively we could set in_kernel_fpu during CPU bootstrap, and 
clear it once we know the FPU is usable? This is only a relatively 
short early boot period, with no scheduling, right?

Thanks,

	Ingo

