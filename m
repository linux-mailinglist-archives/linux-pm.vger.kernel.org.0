Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF90E29699B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 08:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372343AbgJWGRH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372337AbgJWGRG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 02:17:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4AAC0613CE
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 23:17:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bf6so318919plb.4
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qZx9FbWhVPPPhazjV3moDfr24pwj93WkkmuXXCaHCHA=;
        b=B64hrugZLYwFDebwJ2n7cVm7IRpj+T6U2GvjbXeupsrBGTGAYwZLtGRoMLjXS0LCNS
         Nmo2U523Hv+ktz4L2Otq4L86ZqOFYu3WLlrAGgpC49UpMaaAYNxmetjkWeXqk0jiSIla
         gY5Ho3k8QylY8TFUS5YT3M6B9u2h4iyXMgZXERvFgGVAcRiT1CaboY4C/hVO8V4atbq6
         rPURegBP7LxCH+Yr4d4x1Qa7LALmduuR2heeao1YguWmBHEJ87V3XyUSsA2jJopT9x3d
         rQLsbWY1PBXHXcJEfEf4Mrc4huuq4akMabCdSsVJtGm8Kgp+4t+qR6lvCa8qqXL9hsz+
         nLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qZx9FbWhVPPPhazjV3moDfr24pwj93WkkmuXXCaHCHA=;
        b=M/dZp4je4DroPYlCVQsrNQDLcc2Y3eGaIURJrtbArapsX4uaHG9EjPPxKZHMYTH9lL
         28XsjGK9RhqUySyuMeDxl/8Oe/sgRu6XuBXZKKqU4hf0hcBrnZrqF3jJQ6vBbFpzo6YX
         RSWpHc0X0fWNopydvepO2PDhYDIts3Ie4xy4HdQv32jgcKW6FF6Krf+r8kl3tPlcfzjd
         rGWEA8hgn2PsAFn0LeiimT+2n6LWb9VqKvNHVHFPM7q3CvpPs6vPpNLUlatm1DDtEjXe
         kJeoBD4rXJMGpNlM91YnmaJ2ehmOixseMiUiJumzZ4pZLcYVPkqNrVjbYTWxdiDeRhIf
         Qjsg==
X-Gm-Message-State: AOAM532QsKCLk/eUvTi9t4deXDLZR2ZNqLKwwfkiGY+TWknhqlRnQURv
        3Gkia+GgvGGAuY+GlXGtJ6GM0Q==
X-Google-Smtp-Source: ABdhPJzxbFDFyOM5J2fHvcReFefR6cHQ7tvPbgE4SQ5a7DPzKvxN0M1pWbmG6xTE/UMs2sLWAUz7Tg==
X-Received: by 2002:a17:902:6b45:b029:d3:df34:3222 with SMTP id g5-20020a1709026b45b02900d3df343222mr874550plt.68.1603433825974;
        Thu, 22 Oct 2020 23:17:05 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id lb13sm600802pjb.5.2020.10.22.23.17.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 23:17:05 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:47:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] cpufreq: Avoid configuring old governors as default with
 intel_pstate
Message-ID: <20201023061703.jjpmoeq7wzwqtsid@vireshk-i7>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <8312288.dAKoTdFk2S@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8312288.dAKoTdFk2S@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-20, 18:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: Avoid configuring old governors as default with intel_pstate
> 
> Commit 33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by
> default without HWP") was meant to cause intel_pstate without HWP
> to be used in the passive mode with the schedutil governor on top of
> it by default, but it missed the case in which either "ondemand" or
> "conservative" was selected as the default governor in the existing
> kernel config, in which case the previous old governor configuration
> would be used, causing the default legacy governor to be used on top
> of intel_pstate instead of schedutil.
> 
> Address this by preventing "ondemand" and "conservative" from being
> configured as the default cpufreq governor in the case when schedutil
> is the default choice for the default governor setting.
> 
> [Note that the default cpufreq governor can still be set via the
>  kernel command line if need be and that choice is not limited,
>  so if anyone really wants to use one of the legacy governors by
>  default, it can be achieved this way.]
> 
> Fixes: 33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by default without HWP")
> Cc: 5.8+ <stable@vger.kernel.org> # 5.8+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/Kconfig
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/Kconfig
> +++ linux-pm/drivers/cpufreq/Kconfig
> @@ -71,6 +71,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
>  
>  config CPU_FREQ_DEFAULT_GOV_ONDEMAND
>  	bool "ondemand"
> +	depends on !SMP || !X86_INTEL_PSTATE
>  	select CPU_FREQ_GOV_ONDEMAND
>  	select CPU_FREQ_GOV_PERFORMANCE
>  	help
> @@ -83,6 +84,7 @@ config CPU_FREQ_DEFAULT_GOV_ONDEMAND
>  
>  config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
>  	bool "conservative"
> +	depends on !SMP || !X86_INTEL_PSTATE

While reading this first it felt like a SMP platforms related problem
(which I was surprised about), and then I understood what you are
doing.

I wonder if rewriting it this way makes it more readable with same
result eventually.

	depends on !(X86_INTEL_PSTATE && SMP)

-- 
viresh
