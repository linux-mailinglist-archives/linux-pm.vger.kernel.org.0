Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A789526AB45
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgIORrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbgIORqv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:46:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473CAC061788;
        Tue, 15 Sep 2020 10:46:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e42006096e946d741c4e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:6096:e946:d741:c4e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 85C571EC032C;
        Tue, 15 Sep 2020 19:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600192009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rmBa7gEzQYxBNGzsURQUEAttoyf870NKssUflXTeqCg=;
        b=q10yfnNWGXiBR4ItVPXZCGDs9iOdT/kKwdkymGIzET6Usrbyfg/m/xLXMbJWVyu+Ylj9N/
        qUMBLAqTn3Bxhy5xIzRIN+ZT8bXacFZ+ERU0CdywcWfI+XcugOR3XYFOgh42qu93Gqk2QM
        vVPZeDeXh0qg5VKVF0F8CJJp8Ru0K70=
Date:   Tue, 15 Sep 2020 19:46:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     rkir@google.com
Cc:     rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, ndesaulniers@google.com,
        adelva@google.com, Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
Message-ID: <20200915174643.GT14436@zn.tnic>
References: <20200915172658.1432732-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915172658.1432732-1-rkir@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 15, 2020 at 10:26:58AM -0700, rkir@google.com wrote:
> From: Haitao Shan <hshan@google.com>
> 
> This is a workaround which fixes triple fault
> in __restore_processor_state on clang when
> built with LTO.
> 
> When load_TR_desc and load_mm_ldt are inlined into
> fix_processor_context due to LTO, they cause
> fix_processor_context (or in this case __restore_processor_state,
> as fix_processor_context was inlined into __restore_processor_state)
> to access the stack canary through %gs, but before
> __restore_processor_state has restored the previous value
> of %gs properly. LLVM appears to be inlining functions with stack
> protectors into functions compiled with -fno-stack-protector,
> which is likely a bug in LLVM's inliner that needs to be fixed.
> 
> The LLVM bug is here: https://bugs.llvm.org/show_bug.cgi?id=47479
> 
> Signed-off-by: Haitao Shan <hshan@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Ok, google guys, pls make sure you Cc LKML too as this is where *all*
patches and discussions are archived. Adding it now to Cc.

> ---
>  arch/x86/power/cpu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index db1378c6ff26..e5677adb2d28 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -274,6 +274,16 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>  /* Needed by apm.c */
>  void notrace restore_processor_state(void)
>  {
> +#ifdef __clang__
> +	// The following code snippet is copied from __restore_processor_state.
> +	// Its purpose is to prepare GS segment before the function is called.
> +#ifdef CONFIG_X86_64
> +	wrmsrl(MSR_GS_BASE, saved_context.kernelmode_gs_base);
> +#else
> +	loadsegment(fs, __KERNEL_PERCPU);
> +	loadsegment(gs, __KERNEL_STACK_CANARY);
> +#endif
> +#endif

Ok, so why is the kernel supposed to take yet another ugly workaround
because there's a bug in the compiler?

If it is too late to fix it there, then maybe disable LTO builds for the
buggy version only.

We had a similar discussion this week and we already have one buggy
compiler to deal with and this second one is not making it any easier...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
