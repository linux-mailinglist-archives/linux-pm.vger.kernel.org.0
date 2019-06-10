Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67DC3C03A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 01:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbfFJXwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 19:52:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43392 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390568AbfFJXwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 19:52:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so6190468pfg.10
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=//UIhUwMjcLEhM8jw0JdGfPxbu/l+D9BdzjQBHxa+3I=;
        b=S5twQrqcfMlYQ7HpJx67BBgHCAXoiezTWufgTwmq7vEJIDmSmgxiNFaSqrzgEZLYBb
         tiZ+uAc3MEee8GOKVN3q66fZBuujaKmt6U4ZDFTEE92khx921OCBx/0XA3OLN2i34diO
         jJwwMQZ/GLIYF6fVKnWmKER+HFF1f0apsT4/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=//UIhUwMjcLEhM8jw0JdGfPxbu/l+D9BdzjQBHxa+3I=;
        b=fzftXvDvMggpqJLWSYEQrGuSH49gX6kKxvwC3Yd+0PrkWVJM4ILzmy9IbZwYB0Pfms
         GDBGtktIROkB7B8TZYAPkSX+UuvfmQFUXh1JDHU8MIcVJ5kZN1OS1AB9u162zV71z4Sx
         g/K1csORDwRFpb3zCrWnf7s24nikbqiBS+o1FPRY2O4ZmguFU13h+iumYGe+X7AXbMLv
         G3Oz4hxbR12dvrrdSPv9XT/BJ0a44v5pNDWhazBUh/9P3flqnOzt08SdcZjg967IWNj6
         ZeWrKN0B6ulPZEEzEeqGh7F97WgdX/+74kxNO6WMC0bf7W6kah+HMUKx4DdLfpkwJWQs
         ljFA==
X-Gm-Message-State: APjAAAWIEFa0bOYustbdrtxfm2sk6jX5F2oE+okG3j9t+kJhpZMxhCtQ
        X4W516Krv/xFhHlAvZun3dtNyA==
X-Google-Smtp-Source: APXvYqx/uFQL581YeJrYZ1Czs+Zxdcfgf1YQbiKV68dE70gZNUeve1m6AmJretOfUB9S5Ieus0eafg==
X-Received: by 2002:a63:a056:: with SMTP id u22mr17603182pgn.318.1560210754118;
        Mon, 10 Jun 2019 16:52:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 144sm18161980pfy.54.2019.06.10.16.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 16:52:33 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:52:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/12] x86/power/64: Adapt assembly for PIE support
Message-ID: <201906101652.94483CD@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-11-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-11-thgarnie@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 20, 2019 at 04:19:35PM -0700, Thomas Garnier wrote:
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
>  arch/x86/power/hibernate_asm_64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
> index 3008baa2fa95..9ed980efef72 100644
> --- a/arch/x86/power/hibernate_asm_64.S
> +++ b/arch/x86/power/hibernate_asm_64.S
> @@ -24,7 +24,7 @@
>  #include <asm/frame.h>
>  
>  ENTRY(swsusp_arch_suspend)
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	%rsp, pt_regs_sp(%rax)
>  	movq	%rbp, pt_regs_bp(%rax)
>  	movq	%rsi, pt_regs_si(%rax)
> @@ -115,7 +115,7 @@ ENTRY(restore_registers)
>  	movq	%rax, %cr4;  # turn PGE back on
>  
>  	/* We don't restore %rax, it must be 0 anyway */
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	pt_regs_sp(%rax), %rsp
>  	movq	pt_regs_bp(%rax), %rbp
>  	movq	pt_regs_si(%rax), %rsi
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
