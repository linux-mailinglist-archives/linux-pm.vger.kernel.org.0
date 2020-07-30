Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ADF232ABA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 06:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgG3ENj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 00:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgG3ENi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 00:13:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEB0C0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:13:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so8246131pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNLK7uM4PfoxFTg5k9G9c/AFUYqdGbH3MtTXOTQJaMA=;
        b=k9ofiJ5HPC2c49FkjkRDv2WrdWzMLcrlR6JVb5UEy1jRB1F2doEKibWHmYB96YHfO1
         +xmyBCak32xRg5E30RrmUepIYmCfiHM8qzHx6Pf0gPPFWbfPtbbR+7U6gwEmoWX5jhzd
         JcZwE7oWCFIvx3B7sY1UBBgW72St1Hkj7dvReZCDIVqSAFj/A2ie8eCwDcx6oEx2u1Kk
         orizXhIJ2UOtsj0mTBVQVrr/JnWEfbZUazhyrSySiL5lYbK+ac15UnGKTPSOw95lT2Ua
         /Wqt1Xle+UOxdGBAK3e4v1iEyTpxlPUFpRQmgyCtN0IHPE+rRLrNLXpoPrQP6ONPZfr4
         a2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNLK7uM4PfoxFTg5k9G9c/AFUYqdGbH3MtTXOTQJaMA=;
        b=VrRO6QtjeR4ngo/pSiEaDBtIftqzqew6CBWmqVGBDsf0YisDS3DxyP2jdXqsdsex/z
         Uh0Kt5yORigwJlegHtSYwJQxUzj313AOGKIMCo3xLv36TYiHJEGRTpChtTYpUhGcp9HC
         rfJkGpRqiwFYZraf3OZEjoVw/0DGaT7JEwLhPW2RRAswrXnH0uPa8TJYdaz6siMz6DsJ
         khZAJ7/1rhajKYDdfm215LinNg0GcUkhgs6ohl6+KHv/soDCVTrh+MO1giA6JOS6l9Lz
         IGinPmhCS/E4x7d1byr6WyOg3rn2LweUkeICD56wZL+b4D3YqVlEpYUTBszr2ELTePC0
         /3hA==
X-Gm-Message-State: AOAM530IS1iKbK//2dQYVdAKRu/h3DKtyXhe8jQu/iIqgMAle6Vaghjl
        bbCUSLUSeev88vOWJE5SsfUmKGn9Gr0=
X-Google-Smtp-Source: ABdhPJwPnH7KizZyrysK8KyR0jonI6jqQMT/juFfmsTEABa51D5nnau5TsXaq9+lQm+B6VwOhO5Wdg==
X-Received: by 2002:a65:4549:: with SMTP id x9mr31737542pgr.415.1596082418039;
        Wed, 29 Jul 2020 21:13:38 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id w9sm3769942pja.39.2020.07.29.21.13.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:13:37 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:43:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] cpufreq: set invariance scale factor on
 transition end
Message-ID: <20200730041334.cjg5mc5xpopd2lst@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722093732.14297-3-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-07-20, 10:37, Ionela Voinescu wrote:
> While the move of the invariance setter calls (arch_set_freq_scale())
> from cpufreq drivers to cpufreq core maintained the previous
> functionality for existing drivers that use target_index() and
> fast_switch() for frequency switching, it also gives the possibility
> of adding support for users of the target() callback, which is exploited
> here.
> 
> To be noted that the target() callback has been flagged as deprecated
> since:
> 
> commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> 
> It also doesn't have that many users:
> 
>   cpufreq-nforce2.c:371:2:      .target = nforce2_target,
>   cppc_cpufreq.c:416:2:         .target = cppc_cpufreq_set_target,
>   gx-suspmod.c:439:2:           .target = cpufreq_gx_target,
>   pcc-cpufreq.c:573:2:          .target = pcc_cpufreq_target,
> 
> Similarly to the path taken for target_index() calls in the cpufreq core
> during a frequency change, all of the drivers above will mark the end of a
> frequency change by a call to cpufreq_freq_transition_end().
> 
> Therefore, cpufreq_freq_transition_end() can be used as the location for
> the arch_set_freq_scale() call to potentially inform the scheduler of the
> frequency change.
> 
> This change maintains the previous functionality for the drivers that
> implement the target_index() callback, while also adding support for the
> few drivers that implement the deprecated target() callback.
> 
> Two notes are worthwhile here:
>  - In __target_index(), cpufreq_freq_transition_end() is called only for
>    drivers that have synchronous notifications enabled. There is only one
>    driver that disables them,
> 
>    drivers/cpufreq/powernow-k8.c:1142: .flags = CPUFREQ_ASYNC_NOTIFICATION,
> 
>    which is deprecated.

I don't think this is deprecated.

-- 
viresh
