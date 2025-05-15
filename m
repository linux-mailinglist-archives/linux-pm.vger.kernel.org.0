Return-Path: <linux-pm+bounces-27192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DDCAB800B
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 10:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DA33A7C46
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8012EAE5;
	Thu, 15 May 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4jUvVcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEC8F58;
	Thu, 15 May 2025 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296964; cv=none; b=r6msumgq6d6yiEC0jphAqibXmVEmPDhx8CZdPvE9iLl+HlbjXC6c95G3am1X6viztrKr9wCOSWA8rO4GsEDPIK5FryL7izIqw0VGvkLoG8DuFDTzwbOGqowRAGw1lUf2tyIS3aqpRDaYqfO15+l1vVgxlgZChr/gfe0CgHwJlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296964; c=relaxed/simple;
	bh=R0EFqKLDLT6J3UP/BdZNpD7merVLGkoQ8JVBy5Ut2rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsxLaEtlNyBruCPkBxNZH3pYaYL3hCftQH7wl69saLofAANF1OQm78Z3Po2RO22BfHdFh8owdvEp6pTZOYKvW1DBSfpNohSoBnl0A1i4lS9HnACbVt5aYHBOKIbNXqpkz4Gosc97RMzNowgG5E/oofZpkQvY70SiMNK+WmyEm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4jUvVcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DD6C4CEE7;
	Thu, 15 May 2025 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747296963;
	bh=R0EFqKLDLT6J3UP/BdZNpD7merVLGkoQ8JVBy5Ut2rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4jUvVcYzKM+FQUmZLYtlkcg83dszd6q/t7Yfky44mUWpMvVTRJ/nnmvsgGAWUvWQ
	 IzT7GN8JjvIxgsVlErA4BTqvzH6V9QHm1cbZLOvF1TMWasaJvg8ze4bUa0J90T1PIt
	 3MBxH/H8+ddC0kF8DwPHkCNL5j3MWTgvw3V/PAjriI1d6u/q7yAnEKKAmdcQxMGEEX
	 ojSmLyQ/bklJOSH/GecLC8EIhQCn+h0xjU9Sez6nqpfvPOjIOYg9OUXQnycU80C67B
	 54RXSAoM1WTACcDQs0MOdUYywIDB/X6IjMpiq19pe76Ra+uKE5afHy5tMQkZCL5Im3
	 pTFq16Hi1ll/w==
Date: Thu, 15 May 2025 10:15:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Shivank Garg <shivankg@amd.com>, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	luto@kernel.org, peterz@infradead.org, rafael@kernel.org,
	pavel@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	sohil.mehta@intel.com, rui.zhang@intel.com, yuntao.wang@linux.dev,
	kai.huang@intel.com, xiaoyao.li@intel.com, peterx@redhat.com,
	sandipan.das@amd.com, ak@linux.intel.com, rostedt@goodmis.org
Subject: [PATCH] x86/apic: Better document spurious_interrupt() and
 __spurious_interrupt()
Message-ID: <aCWivMggS9mektCu@gmail.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
 <20250514062637.3287779-4-shivankg@amd.com>
 <aCRMpba5mp5YvmY3@gmail.com>
 <51fbdbcd-a895-43b0-bb59-aa3361d77cad@amd.com>
 <87o6vuibnu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6vuibnu.ffs@tglx>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, May 15 2025 at 12:03, Shivank Garg wrote:
> > On 5/14/2025 1:26 PM, Ingo Molnar wrote:
> >> This is incorrect and is based on a misunderstanding of what the code 
> >> does:
> >> 
> >> DEFINE_IDTENTRY_IRQ(spurious_interrupt)
> >> {
> >>         handle_spurious_interrupt(vector);
> >> }
> >
> > The kernel-doc tool doesn't handle macros properly.
> > Can I change it to a normal comment instead?
> > or if a kernel-doc comment is required how should I make it correct?
> 
> Fix the stupid tool and leave the comment alone.

Yeah, so the problem is that the kernel-doc tool is partially right to 
complain about the status quo:

	/**
	 * spurious_interrupt - Catch all for interrupts raised on unused vectors
	 * @regs:       Pointer to pt_regs on stack
	 * @vector:     The vector number
	 *
	 * This is invoked from ASM entry code to catch all interrupts which
	 * trigger on an entry which is routed to the common_spurious idtentry
	 * point.
	 */
	DEFINE_IDTENTRY_IRQ(spurious_interrupt)
	{
	        handle_spurious_interrupt(vector);
	}

This description is incorrect as-is: the parameters described are not 
that of the main 'spurious_interrupt()' handler, which is:

        extern __visible noinstr void spurious_interrupt(struct pt_regs *regs, unsigned long error_code);

Note that it has an 'error_code', not 'vector'. (Which, of course, are 
the same actual numeric value in this case, but are in different 
functions and different prototypes.)

But the description is that of the __spurious_interrupt() lower level 
(sub-)handler function:

	static void __spurious_interrupt(struct pt_regs *regs, u32 vector);

So yeah, this documention is arguably a bit messy, and not just because 
kernel-doc is confused about macros.

So I'd fix it like this:

	/*
	 * spurious_interrupt(): Catch all for interrupts raised on unused vectors
	 * @regs:	Pointer to pt_regs on stack
	 * @error_code: Hardware exception/interrupt data
	 *
	 * The spurious_interrupt() high level function is invoked from ASM entry code
	 * to catch all interrupts which trigger on an entry which is routed to the
	 * common_spurious idtentry point.
	 *
	 * __spurious_interrupt(): Catch all for interrupts raised on unused vectors
	 * @regs:	Pointer to pt_regs on stack
	 * @vector:	The IRQ vector number
	 *
	 * This is the lower level spurious interrupts handler function.
	 */
	DEFINE_IDTENTRY_IRQ(spurious_interrupt)
	{
		handle_spurious_interrupt(vector);
	}
	
... or so.

Which also moves it out of kernel-doc style, and should thus avoid 
kernel-doc's confusion. Patch below.

Or we could:

  s/spurious_interrupt
   /__spurious_interrupt

and remove the kernel-doc trigger line.

Whichever your preference is.

Thanks,

	Ingo

=============>
 arch/x86/kernel/apic/apic.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d73ba5a7b623..462dcdb3af85 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2128,14 +2128,20 @@ static noinline void handle_spurious_interrupt(u8 vector)
 	trace_spurious_apic_exit(vector);
 }
 
-/**
- * spurious_interrupt - Catch all for interrupts raised on unused vectors
+/*
+ * spurious_interrupt(): Catch all for interrupts raised on unused vectors
+ * @regs:	Pointer to pt_regs on stack
+ * @error_code: Hardware exception/interrupt data
+ *
+ * The spurious_interrupt() high level function is invoked from ASM entry code
+ * to catch all interrupts which trigger on an entry which is routed to the
+ * common_spurious idtentry point.
+ *
+ * __spurious_interrupt(): Catch all for interrupts raised on unused vectors
  * @regs:	Pointer to pt_regs on stack
  * @vector:	The IRQ vector number
  *
- * This is invoked from ASM entry code to catch all interrupts which
- * trigger on an entry which is routed to the common_spurious idtentry
- * point.
+ * This is the lower level spurious interrupts handler function.
  */
 DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 {


