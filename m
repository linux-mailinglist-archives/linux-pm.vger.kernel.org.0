Return-Path: <linux-pm+bounces-27186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B22AB7E21
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC8189FA8F
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17CC2868B2;
	Thu, 15 May 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfR2+h8z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2718F6B;
	Thu, 15 May 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291097; cv=none; b=GXaQM3Fuu5F0pvJCFSFZncPiXypXCSjJ6GPRXONKFsc7SEYX5DxvecuElqBcxyiwDydOHA+ktXEIzh7dOx9q/U5rKKMw8a84D/MPc3GtuXdUJIHCy6sDMbOF3e5fLB+Pn4z2MavT6E3ZdHrm6cLSNEp+2rzJyOYeBR/gxTyb8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291097; c=relaxed/simple;
	bh=kaMxMal0WDtSKibQxuRR6urJ0WFqEyh250V+wFi3kHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBS98r3Ql+DKVx5imYICXyZPhxUf0xHOJJRLx3toIkW3UCYd5OlfrKU4/MbIZE3NrxDu6nvnqgTjrhJfYaeEF4fGTt/uhUex8GRRiKPdCIpf8R76LTZIiuEct0g9eC52DUcmlSJYV2eLEuIfkzptht5eC6Y8iuSJ1wZBvCLhtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfR2+h8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E791C4CEE7;
	Thu, 15 May 2025 06:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747291097;
	bh=kaMxMal0WDtSKibQxuRR6urJ0WFqEyh250V+wFi3kHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfR2+h8z5qwd/o3OAGA4Ok46z8v9OfgojsKiQinHKXhn4yDMkRgAtle8x++cItyL9
	 7/hfMWLmlnVSz/lDDruJSZ/GYXx4F23Nx3nyeO3GtkQ0QRvjXpguPztygeufio/7xU
	 kdiXPujLATYmTyuU1QIYzjM7mJEfMopVDi0C6c7nczPwAswInfzE6K1iAPYgZXE/4n
	 Zf4t4q+cboMF64kai1WXjL4FgXcAni3uXLkHoDOfHkD+yDCyISi8Q5JWGXb+wvscPZ
	 J+ciV4xWflEIX4qwdqB4JB4+jbpkYjgZLj3zMmsFsDq0uno0bUE6LVfmognZsDCeO7
	 IQsLElRFsYeRg==
Date: Thu, 15 May 2025 08:38:09 +0200
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
Message-ID: <aCWL0Ql27EIpJsr1@gmail.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
 <20250514062637.3287779-4-shivankg@amd.com>
 <aCRMpba5mp5YvmY3@gmail.com>
 <51fbdbcd-a895-43b0-bb59-aa3361d77cad@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51fbdbcd-a895-43b0-bb59-aa3361d77cad@amd.com>


* Shivank Garg <shivankg@amd.com> wrote:

> 
> 
> On 5/14/2025 1:26 PM, Ingo Molnar wrote:
> > 
> > * Shivank Garg <shivankg@amd.com> wrote:
> > 
> >> Building the kernel with W=1 generates the following warning:
> >>
> >> arch/x86/kernel/apic/apic.c:2140: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
> >> arch/x86/kernel/apic/apic.c:2140: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
> >>
> >> Fix the description format to fix the warning.
> >>
> >> Signed-off-by: Shivank Garg <shivankg@amd.com>
> >> ---
> >>  arch/x86/kernel/apic/apic.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> >> index 62584a347931..f888a28d400f 100644
> >> --- a/arch/x86/kernel/apic/apic.c
> >> +++ b/arch/x86/kernel/apic/apic.c
> >> @@ -2128,9 +2128,10 @@ static noinline void handle_spurious_interrupt(u8 vector)
> >>  }
> >>  
> >>  /**
> >> - * spurious_interrupt - Catch all for interrupts raised on unused vectors
> >> - * @regs:	Pointer to pt_regs on stack
> >> - * @vector:	The vector number
> >> + * DEFINE_IDTENTRY_IRQ - Handler for spurious interrupts
> >> + * @spurious_interrupt: Catch all for interrupts raised on unused vectors
> >> + * regs:	Pointer to pt_regs on stack
> >> + * vector:	The vector number
> > 
> > This is incorrect and is based on a misunderstanding of what the code 
> > does:
> > 
> > DEFINE_IDTENTRY_IRQ(spurious_interrupt)
> > {
> >         handle_spurious_interrupt(vector);
> > }
> 
> The kernel-doc tool doesn't handle macros properly.

Then we should not document that function in a misleading fashion, just 
to work around kernel-doc limitations.

> Can I change it to a normal comment instead?

Yeah, I think that's fine.

Thanks,

	Ingo

