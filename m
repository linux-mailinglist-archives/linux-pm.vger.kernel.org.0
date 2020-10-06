Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803292846D2
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 09:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgJFHKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 03:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgJFHKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 03:10:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DF7C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 00:10:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i3so1169241pjz.4
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xy5wqMUeXlibqHeEj3LQp2tBjNI9zLCjjBKnBCJJgVU=;
        b=RyxzkNxuBWFQ47CWdVmYlqtzz3L4gm7iYrz17kOBXIQQNbebPkVolc8Qh9iz+NlNKf
         SBVDPQakMDXo0hXpZO8IlFdVtcyYO5EXpP+zGOXoEqf8uTO5DuQf9RHXDLNwN7xNKEwa
         T9c61gSHCoh4bUPtRNnfYbleH/kK0TWvNTzLRCynOvKiRbihypdKzHfm/AvzEhI0kwWf
         Weo6z/GlXhVwT5MG6JUymuXP9P1gdqdJFi9C2FP2YBGvhgaGOnV5hS5v7O4pD+BuVkiX
         d44ECxV/3cN/tWe3MpECm3K/d8N+9gpenIuTq5o632JfOGwSvuHYDHNlxOxceG51nKDH
         XF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xy5wqMUeXlibqHeEj3LQp2tBjNI9zLCjjBKnBCJJgVU=;
        b=jjVZnoqGd8eRunuO10IoMsfHAI3BRRapD1Eg2kVTYLjfarVaG7EzLRAl/jYoCsIjgm
         6lfTdSN32IKexhZQCqfOY05V9FnFw5vSKZLGW0BKGapxEd8xyUKb2C/JVHo1QcxDSc1l
         es6hEwvSaIrF17Ywom0x4EIAuIyi/H6JdC5lgL/zEoEEKtXp3M8yN3OQycuc1MnSJ5I8
         BBhc+mA8kPuxr93swI63DIWojFRWqtJNqXFPjujlwTw8SOmlKAtvmtOAVEPtEYAA57S8
         S2u+Bnl8NIMBTSrEXkC+RqN4VqIJSCDg0xVu0Z17VcQlbnMYbI30xuSQfeO28kmDP2YZ
         Jbow==
X-Gm-Message-State: AOAM532eFPBjTlGu4H+LTEF4WmL8skoGxM0vJ7v7+IW28aZEwtyNHjYW
        NL4rl6A99ihrJUy47CYjYwoN85Th/5np4g==
X-Google-Smtp-Source: ABdhPJzUrGr33bgXauuGPiiRUSheuTO3a1+5ATd8VPWULKIaEEp0V6T42MLd3HP+OQMUm4WnZMkppQ==
X-Received: by 2002:a17:90b:3010:: with SMTP id hg16mr2851367pjb.21.1601968237639;
        Tue, 06 Oct 2020 00:10:37 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x4sm2237867pfm.86.2020.10.06.00.10.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 00:10:36 -0700 (PDT)
Date:   Tue, 6 Oct 2020 12:40:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20201006071034.u65c5sphzwlvi6cs@vireshk-i7>
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
 <20200924123016.13427-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924123016.13427-3-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-09-20, 13:30, Ionela Voinescu wrote:
> big.LITTLE switching complicates the setting of a correct cpufreq-based
> frequency invariance scale factor due to (as observed in
> drivers/cpufreq/vexpress-spc-cpufreq.c):
>  - Incorrect current and maximum frequencies as a result of the
>    exposure of a virtual frequency table to the cpufreq core,
>  - Missed updates as a result of asynchronous frequency adjustments
>    caused by frequency changes in other CPU pairs.
> 
> Given that its functionality is atypical in regards to frequency
> invariance and this is an old technology, disable frequency
> invariance for when big.LITTLE switching is configured in to prevent
> incorrect scale setting.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/include/asm/topology.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index e5e3d5ce4d55..470299ee2fba 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -7,10 +7,13 @@
>  #include <linux/cpumask.h>
>  #include <linux/arch_topology.h>
>  
> +/* big.LITTLE switcher is incompatible with frequency invariance */
> +#ifndef CONFIG_BL_SWITCHER
>  /* Replace task scheduler's default frequency-invariant accounting */
>  #define arch_set_freq_scale topology_set_freq_scale
>  #define arch_scale_freq_capacity topology_get_freq_scale
>  #define arch_scale_freq_invariant topology_scale_freq_invariant
> +#endif
>  
>  /* Replace task scheduler's default cpu-invariant accounting */
>  #define arch_scale_cpu_capacity topology_get_cpu_scale

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
