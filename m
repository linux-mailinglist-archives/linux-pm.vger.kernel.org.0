Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15028143143
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgATSGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 13:06:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34590 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATSGP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 13:06:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id c9so178785plo.1;
        Mon, 20 Jan 2020 10:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aiI98fgZ/Z1LosIGL/70Sm6kSYvFhqQxigL0/FAxBUQ=;
        b=lbEPmBJt+pcHaQB+olLvRG2KgqvapOGVcZVfLByFG+nYZl5AKOhHCBLPzgdxFNjd0N
         nQLfOOXEKCMw0Nt/PduXnJ1xx49hpf0Y9Dfh4zwTmGtYOAhNbxFHu5bU3ULx647gGtLg
         cWYfP9TtlcAC6fOkds6H0i9g0Lpi1zqnIM3kGmLu/KZu7Xv0TOmZIDgDgrUWJksmDFi2
         hYZNIlX9NSveUJxkjnClpBtY7Kqcrpz6disr3MwvAR8gdjxjyhCdsqvc4kbaOWKDDAEA
         +zLi8c3ir7vUgIN4KC9RabHfRWjWnYobBvu1049mysgjdh3oevVkA+Ru/TTYBMPSYEN/
         XdGw==
X-Gm-Message-State: APjAAAWOntpSvSrq3aXFM27cCr6yOR/vyoapmN58fF7suG8E7KBuPOc1
        McMbHLQ6Xvow9/NrwHSH0Kk5N9dwsfp/fw==
X-Google-Smtp-Source: APXvYqxo+75Mpun1uPa3aOc2yV6S0hqDlGzn1BlZCoEJwFpw+h1+oP5UMWUQpOt82Vq3zvT8CKCFDQ==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr978204plt.330.1579543574503;
        Mon, 20 Jan 2020 10:06:14 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id k12sm37591661pgm.65.2020.01.20.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 10:06:13 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:06:12 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        paul.burton@mips.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] [Loongson2F] adjust cpufreq uses of LOONGSON_CHIPCFG
Message-ID: <20200120180612.gurkikzbh77stk4v@pburton-laptop>
References: <or5zh9l5ok.fsf@livre.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <or5zh9l5ok.fsf@livre.home>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Alexandre,

On Sat, Jan 18, 2020 at 02:00:43AM -0300, Alexandre Oliva wrote:
> 
> The post-fork cleanup of loongson2ef from loongson64 changed
> LOONGSON_CHIPCFG from a single-argument functional macro to a
> non-functional macro with an mmio address in loongson2ef, but
> loongson2_cpufreq still uses the notation of a functional macro call
> expecting it to be an lvalue.  Fixed based on loongson_suspend_enter.
> 
> Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org
> Cc: paul.burton@mips.com

This patch looks good to me, but you need to copy the cpufreq
maintainers:

$ ./scripts/get_maintainer.pl -f drivers/cpufreq/loongson2_cpufreq.c
Jiaxun Yang <jiaxun.yang@flygoat.com> (maintainer:MIPS/LOONGSON2EF ARCHITECTURE)
"Rafael J. Wysocki" <rjw@rjwysocki.net> (maintainer:CPU FREQUENCY SCALING FRAMEWORK)
Viresh Kumar <viresh.kumar@linaro.org> (maintainer:CPU FREQUENCY SCALING FRAMEWORK)
linux-mips@vger.kernel.org (open list:MIPS/LOONGSON2EF ARCHITECTURE)
linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
linux-kernel@vger.kernel.org (open list)

I've CC'd them now, but they might want the patch resending.

Thanks,
    Paul

> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index 84f0eee..ace2d46 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -144,9 +144,11 @@ static void loongson2_cpu_wait(void)
>  	u32 cpu_freq;
>  
>  	spin_lock_irqsave(&loongson2_wait_lock, flags);
> -	cpu_freq = LOONGSON_CHIPCFG(0);
> -	LOONGSON_CHIPCFG(0) &= ~0x7;	/* Put CPU into wait mode */
> -	LOONGSON_CHIPCFG(0) = cpu_freq;	/* Restore CPU state */
> +	cpu_freq = readl(LOONGSON_CHIPCFG);
> +	/* Put CPU into wait mode */
> +	writel(readl(LOONGSON_CHIPCFG) & ~0x7, LOONGSON_CHIPCFG);
> +	/* Restore CPU state */
> +	writel(cpu_freq, LOONGSON_CHIPCFG);
>  	spin_unlock_irqrestore(&loongson2_wait_lock, flags);
>  	local_irq_enable();
>  }
> -- 
> 2.7.4
> 
> 
> -- 
> Alexandre Oliva, freedom fighter   he/him   https://FSFLA.org/blogs/lxo
> Free Software Evangelist           Stallman was right, but he's left :(
> GNU Toolchain Engineer    FSMatrix: It was he who freed the first of us
> FSF & FSFLA board member                The Savior shall return (true);
