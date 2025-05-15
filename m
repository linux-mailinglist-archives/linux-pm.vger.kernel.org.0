Return-Path: <linux-pm+bounces-27189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69514AB7E49
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9751BA0800
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F5028312A;
	Thu, 15 May 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8iprBTj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7881C27;
	Thu, 15 May 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291761; cv=none; b=mZ3256Gy+duLfj4aeUZDkccpbo+HvYMaPHJE/s4ny8ZQaZ/8A5VpE5T8DeOFA+fDeZqhFRWCDhJ2LcnsuAG5GloVdRsn+KJIqy8plr4yCInmqBiV4lkmupPRJZC3h3+rCTNMJY6wpYn4UxdkNdi0FCQY8VkiqAhdj1MET+kZEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291761; c=relaxed/simple;
	bh=QyoPFUDPdYZpUcJBJltlKYg2unT0LhWVQVBvz+ec+U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW+8kJAV89N5XGEs+C75EdKXGTzeeGO8KX1kjAyHDlOJeoWPwAYw1YUWQyXObYz25gV+frsqSOEvwMK95qvC4x5lapc5GP1EYkFfdYEDERY3tA/1h+LqTS/qf6Odf1oKw0gEP4KoiAYs9Ut2Q5HIIjzuaS44MCq5e18TVdj41cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8iprBTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83923C4CEE7;
	Thu, 15 May 2025 06:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747291760;
	bh=QyoPFUDPdYZpUcJBJltlKYg2unT0LhWVQVBvz+ec+U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8iprBTjwYBBZ/WRnbmKY4AK9MLeO+47Jojr1smw62y59fID3oSJkrh1wAuUZtgMF
	 qA15b01rUyGkghPyyZlyurUrpVflidHnyiPrmXACsdmCfmJyIWEwyRN7nYr8tiwQCM
	 OHBJxSRTFyj59a0B8S4eMaCIxQtjln2YDxwnGv5drnxHZ8voOMtC8/vS9f1S1IMhQF
	 i7tzqlmisAHbn4SHqCr5jwcWG4SaGYYOI6cBK9dc0XzOQM15dyHoPnzPeTLduPwPtS
	 n9Ps74fiEbzzn4j3KihmRD//gBNhR9jJodpOcbsDRwjJLcvAUWFB8hBA6D1MnsasoO
	 fykPdPdGw92ww==
Date: Thu, 15 May 2025 08:49:12 +0200
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
Message-ID: <aCWOaA79sHNrz7LD@gmail.com>
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
> Can I change it to a normal comment instead?
> or if a kernel-doc comment is required how should I make it correct?

BTW., kernel-doc could be fixed/extended to work better with macros, 
but I'm not sure it's the right approach in this case: this x86 macro 
*is* obfuscating the real function signature.

We could, perhaps, if the kernel-doc documentation has value, just have 
an additional prototype for the resulting function, right before the 
definition, and document it via kernel-doc.

Something like:

	/**
	 * <kernel-doc annotation>
	 */
	static void __spurious_interrupt(struct pt_regs *regs, u32 vector);

	DEFINE_IDTENTRY_IRQ(spurious_interrupt)
	{
	...

would be the most intuitive outcome IMO, as the trailing part of the 
DEFINE_IDTENTRY_IRQ() definition defines the __spurious_interrupt() 
function.

BTW., note how your kernel-doc annotation has another inaccuracy: the 
function that has the 'vector' parameter which you documented is not 
spurious_interrupt(), but __spurious_interrupt(). The resulting 
spurious_interrupt() function, which is the main entry to the spurious 
interrupts vector, has the following signature:

	extern __visible noinstr void spurious_interrupt(struct pt_regs *regs, unsigned long error_code);

Thanks,

	Ingo

