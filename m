Return-Path: <linux-pm+bounces-27118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB27AB64EE
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 09:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58A53A6B73
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEBB20C46B;
	Wed, 14 May 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDBxF6zL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B35E552;
	Wed, 14 May 2025 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209389; cv=none; b=aYw8zbhrCh2yj9M8/RfDuYdXAD9zHSf03xirTjwqF2pcwCZiAcnDB9hdu7eOzCydHFzZrAMIeuEUcFDv4LFSYOgOCE4sHzo6Lzhkz/MMpRiCnRavOG+WzfscVFm1yd7LjjPR7h0szebS6I0aL8tWTwr8o8Pguh5hIX8u5pwGTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209389; c=relaxed/simple;
	bh=HircwdfxMbWuxF8/YQz1mDhdby31zCrV+U5yKPgDiiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZQmataxuPRDGkGYlIgbXQUNqiN7gIcn/dYSPo2LYIPihFsZh/BWHY4Re9Ur1jp4HBB7dGnq2KIAQYiQpMCwHPuRJKJOkBhOd42blEOdJ03GZ25k7B1ZwrpmvEdDw+gharc9PETu71TsyrWsyRfRLPpV8T1NaqFH4mL8yhJDYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDBxF6zL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299F5C4CEE9;
	Wed, 14 May 2025 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747209389;
	bh=HircwdfxMbWuxF8/YQz1mDhdby31zCrV+U5yKPgDiiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDBxF6zLjHmwx9UFgUEh+wbnTA+2nq5e0ZRePxBrdUac7rKKgN0Yj0NR3rkjyDM4U
	 Vldapi6SOWCHkO3PJXYd/qUicE7TIYs5DdMqWGhBZwTlI/ngJ/dCJhnCXrM2ZbQofA
	 wuYh3KrixdhUQS9A06KTEuaskBIPJ0gusuOVgDtfGK6p69/YzO/wGL4b/ewk4AsKze
	 C9edaKWLPsfK98sCx9ybaNfZOeT5wGbXsmtPp4dCBayMv3XFMHIwgNnm1QnvRLCGGN
	 61k+BnpxehKlYMhye+IO6CnIvAMA44HW15c8AXtCmaHmGSwPCADFdOXJvAK78SYwbZ
	 4V2/8julBT7nA==
Date: Wed, 14 May 2025 09:56:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Shivank Garg <shivankg@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	luto@kernel.org, peterz@infradead.org, rafael@kernel.org,
	pavel@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	sohil.mehta@intel.com, rui.zhang@intel.com, yuntao.wang@linux.dev,
	kai.huang@intel.com, xiaoyao.li@intel.com, peterx@redhat.com,
	sandipan.das@amd.com, ak@linux.intel.com, rostedt@goodmis.org
Subject: Re: [PATCH RESEND 4/4] x86/apic: Fix W=1 build kernel-doc warning
Message-ID: <aCRMpba5mp5YvmY3@gmail.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
 <20250514062637.3287779-4-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514062637.3287779-4-shivankg@amd.com>


* Shivank Garg <shivankg@amd.com> wrote:

> Building the kernel with W=1 generates the following warning:
> 
> arch/x86/kernel/apic/apic.c:2140: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
> arch/x86/kernel/apic/apic.c:2140: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
> 
> Fix the description format to fix the warning.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  arch/x86/kernel/apic/apic.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 62584a347931..f888a28d400f 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2128,9 +2128,10 @@ static noinline void handle_spurious_interrupt(u8 vector)
>  }
>  
>  /**
> - * spurious_interrupt - Catch all for interrupts raised on unused vectors
> - * @regs:	Pointer to pt_regs on stack
> - * @vector:	The vector number
> + * DEFINE_IDTENTRY_IRQ - Handler for spurious interrupts
> + * @spurious_interrupt: Catch all for interrupts raised on unused vectors
> + * regs:	Pointer to pt_regs on stack
> + * vector:	The vector number

This is incorrect and is based on a misunderstanding of what the code 
does:

DEFINE_IDTENTRY_IRQ(spurious_interrupt)
{
        handle_spurious_interrupt(vector);
}

Thanks,

	Ingo

