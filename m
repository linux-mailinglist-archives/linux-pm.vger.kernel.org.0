Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3C2F2DC9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbhALLUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 06:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhALLUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 06:20:16 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB076C061794
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 03:19:35 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c12so1193753pfo.10
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 03:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5LM7Ut6zxNflOeB9Tu5vwRCaSIoaMf2EWJoyZXprr/E=;
        b=e+mOIRrlD1KehNg+JVuaOY1EyYcVTXUxKF6xeCqvF3Z7tLh0WWfX+uFpqJNOEAcKce
         COBZIWDuZREJdjM/E7aRClLchqqn5uOopesQ4XzTQolfBcqtW364vz3Z0cRggy0q3Nii
         8rekcVLhjrvsj43geeQZ2LmFt8BNs10aBAo2T5NEPMzVFos+8RUE8Bo0wzw43KqvviPN
         gBx++6Yx69ghFKYeusRaBJqvtfoV3o7TkbmmUkfvP6eBZYKR4ikshv8x9/dzw7+7r5IO
         GJSmpKSXLOJwHZPXGRFfnCF6BK2UMV/ym/CD4b6PyI10hzZDp52PAh54A+IpAPpiaj6M
         mgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LM7Ut6zxNflOeB9Tu5vwRCaSIoaMf2EWJoyZXprr/E=;
        b=f9iw+BW2lBsHePjKNtVlaN/LB+p6WKPalXLeGEmaEMuWBfdQGpipnl6IhASWKz8b8O
         /218pFbVRlGm+XTtXVXgZDAlb3ZtHi3kl1I/faqLxYYW7t/Yg8Kd4rFSxuqgBaR1s9Nt
         Suav42F7xs3AiVhre8vN7bVQb54kS6pMpBxhjyz8eBsJkTKlvSJ/5AW+8qkDuCkNXxdV
         7VQuw8apHlmLLPZ/l5jCJhPdHnD1K2z8o+15DLsFqiQu28H4D87x2Rl1Lblp3bmiezZG
         +mEBz8+JjHI/V97sOgw8vZrCKZjssIWy+woD1FZMdYsbJRdF1QfsOKDdF6YUgEMohrN1
         L+VQ==
X-Gm-Message-State: AOAM532/J+eAUH6n/EjZ862xnPw+Kzd30WgM/rmLJ6aDo7o4hdVG3m29
        +2Gf8JS2ruwNDgdMkABvQFnL1A==
X-Google-Smtp-Source: ABdhPJz1t5A+Hn8D1SJ4cDzyUxtyS07h6peXlXUSHts3pcfTI1hbun/9nRaqWGe/75ED+CIDtGbHTA==
X-Received: by 2002:a63:a12:: with SMTP id 18mr4230906pgk.140.1610450375352;
        Tue, 12 Jan 2021 03:19:35 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c10sm3007178pfj.54.2021.01.12.03.19.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jan 2021 03:19:34 -0800 (PST)
Date:   Tue, 12 Jan 2021 19:19:29 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210112111928.GB2479@dragon>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <20210112101449.cmkjaegukxut3tym@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112101449.cmkjaegukxut3tym@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 12, 2021 at 03:44:49PM +0530, Viresh Kumar wrote:
> On 12-01-21, 17:52, Shawn Guo wrote:
> > On SDM845/850, running the following commands to put all cores in
> > freq-domain1 offline and then get one core back online, there will be
> > a request region error seen from qcom-hw driver.
> > 
> > $ echo 0 > /sys/devices/system/cpu/cpu4/online
> > $ echo 0 > /sys/devices/system/cpu/cpu5/online
> > $ echo 0 > /sys/devices/system/cpu/cpu6/online
> > $ echo 0 > /sys/devices/system/cpu/cpu7/online
> > $ echo 1 > /sys/devices/system/cpu/cpu4/online
> > 
> > [ 3395.915416] CPU4: shutdown
> > [ 3395.938185] psci: CPU4 killed (polled 0 ms)
> > [ 3399.071424] CPU5: shutdown
> > [ 3399.094316] psci: CPU5 killed (polled 0 ms)
> > [ 3402.139358] CPU6: shutdown
> > [ 3402.161705] psci: CPU6 killed (polled 0 ms)
> > [ 3404.742939] CPU7: shutdown
> > [ 3404.765592] psci: CPU7 killed (polled 0 ms)
> > [ 3411.492274] Detected VIPT I-cache on CPU4
> > [ 3411.492337] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
> > [ 3411.492448] CPU4: Booted secondary processor 0x0000000400 [0x516f802d]
> > [ 3411.503654] qcom-cpufreq-hw 17d43000.cpufreq: can't request region for resource [mem 0x17d45800-0x17d46bff]
> > 
> > The cause is that the memory region requested in .init hook doesn't get
> > released in .exit hook, and the subsequent call to .init will always fail
> > on this error.  Let's break down the devm_platform_ioremap_resource()
> > call a bit, so that we can have the resource pointer to release memory
> > region from .exit hook.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> FWIW, Ionela also sent a fix though I like this one better for the
> obvious reasons.
> 
> https://lore.kernel.org/lkml/20210108151406.23595-1-ionela.voinescu@arm.com/

Ha, thanks for the pointer.  So the original code was tricky and skipped
the region request call intentionally.

Shawn
