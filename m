Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20D3C033
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 01:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbfFJXwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 19:52:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46663 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390647AbfFJXwF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 19:52:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so4261915pls.13
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zTMxpEEXAhPalCGk2uwvI4Mw2/TbyDqYYFDJpjeMgJM=;
        b=CA/9jjUGtQ1g8jH3eI7LaH1zTRGcBGM6SIXNKdkqtIKxVMJ52CM8PTouVpZI532u8j
         ujrtQ/dbZ8tEkdej07Kn9Lf2dtpz5B6iMdvzCi0kZHyDAN65FbQPSY2W1MdE62/VJNFD
         DokqiXe3WIqy3Tj6Zsjmbq181/8BklVk2IFTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTMxpEEXAhPalCGk2uwvI4Mw2/TbyDqYYFDJpjeMgJM=;
        b=jSPY3Z/bGFzC3toRUXUYvZYI7HQslzBTgawl/AY2EXFm2aGQLJqFuoR/dgM7C11ch3
         uOkJzh0jjZNdff4hKGce+LNZysnCH6gV85rV9RHgtSDCBw5x/JeeCJAdamSGGMF3EgY5
         RuiDcedYN1qYUrltn4PdUuShmeo6bOVmIOVwgUkwcIcHiNVx8Y9JMghD+ilOwGeQXL5m
         adZqv1gr0ZwECrxu7hiS7UuRpwzsoZ7mzhB62pHqDy2UbGalcmCX2POjQllQqqWS/QYW
         Z1OvJr57HuIynimKCRGs/Qursxg6f8Xaajj7AMTuqM9URSMhK0iw/NcIdbTZvsek2G+P
         f/8w==
X-Gm-Message-State: APjAAAXY2l76l4wLKqmQpU7iSL4XC2Z3wYtvect68pgpFY5hR/nIPT/f
        BardKd8JoJOIeYtkOCEDZyu27A==
X-Google-Smtp-Source: APXvYqwEq2Riap96orfEJ5J7t1DMOxlcSqT8vZ+0LAjMb9tv27xDvdsQ7kXG4J9ZyFg707prgfvnQg==
X-Received: by 2002:a17:902:a708:: with SMTP id w8mr69255143plq.162.1560210724170;
        Mon, 10 Jun 2019 16:52:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm11934800pgc.85.2019.06.10.16.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 16:52:03 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:52:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/12] x86/acpi: Adapt assembly for PIE support
Message-ID: <201906101652.CA88F8F@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-9-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-9-thgarnie@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 20, 2019 at 04:19:33PM -0700, Thomas Garnier wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 510fa12aab73..e080e943e295 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -14,7 +14,7 @@
>  	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
>  	 */
>  ENTRY(wakeup_long64)
> -	movq	saved_magic, %rax
> +	movq	saved_magic(%rip), %rax
>  	movq	$0x123456789abcdef0, %rdx
>  	cmpq	%rdx, %rax
>  	jne	bogus_64_magic
> @@ -25,14 +25,14 @@ ENTRY(wakeup_long64)
>  	movw	%ax, %es
>  	movw	%ax, %fs
>  	movw	%ax, %gs
> -	movq	saved_rsp, %rsp
> +	movq	saved_rsp(%rip), %rsp
>  
> -	movq	saved_rbx, %rbx
> -	movq	saved_rdi, %rdi
> -	movq	saved_rsi, %rsi
> -	movq	saved_rbp, %rbp
> +	movq	saved_rbx(%rip), %rbx
> +	movq	saved_rdi(%rip), %rdi
> +	movq	saved_rsi(%rip), %rsi
> +	movq	saved_rbp(%rip), %rbp
>  
> -	movq	saved_rip, %rax
> +	movq	saved_rip(%rip), %rax
>  	jmp	*%rax
>  ENDPROC(wakeup_long64)
>  
> @@ -45,7 +45,7 @@ ENTRY(do_suspend_lowlevel)
>  	xorl	%eax, %eax
>  	call	save_processor_state
>  
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	%rsp, pt_regs_sp(%rax)
>  	movq	%rbp, pt_regs_bp(%rax)
>  	movq	%rsi, pt_regs_si(%rax)
> @@ -64,13 +64,14 @@ ENTRY(do_suspend_lowlevel)
>  	pushfq
>  	popq	pt_regs_flags(%rax)
>  
> -	movq	$.Lresume_point, saved_rip(%rip)
> +	leaq	.Lresume_point(%rip), %rax
> +	movq	%rax, saved_rip(%rip)
>  
> -	movq	%rsp, saved_rsp
> -	movq	%rbp, saved_rbp
> -	movq	%rbx, saved_rbx
> -	movq	%rdi, saved_rdi
> -	movq	%rsi, saved_rsi
> +	movq	%rsp, saved_rsp(%rip)
> +	movq	%rbp, saved_rbp(%rip)
> +	movq	%rbx, saved_rbx(%rip)
> +	movq	%rdi, saved_rdi(%rip)
> +	movq	%rsi, saved_rsi(%rip)
>  
>  	addq	$8, %rsp
>  	movl	$3, %edi
> @@ -82,7 +83,7 @@ ENTRY(do_suspend_lowlevel)
>  	.align 4
>  .Lresume_point:
>  	/* We don't restore %rax, it must be 0 anyway */
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	saved_context_cr4(%rax), %rbx
>  	movq	%rbx, %cr4
>  	movq	saved_context_cr3(%rax), %rbx
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
