Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E584D3F856D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 12:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhHZKkR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 06:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbhHZKkQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 06:40:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760BFC061757
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 03:39:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e7so2730350pgk.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zSb8+oNNJd+qcd1Xbd4r2cy6RPqGNza5Mtwz+ay/kXo=;
        b=l37XQ0QQsZhANbKKTgZQDao0sIJESJiBN7Q+uvWvdX1Q2Xc0ppWvY+KIbPYpi6LKWQ
         yhezMS7p6rn15M2+0Igdx5SAWbNUnUYCawYxktXyKWQGKQ9GSsg+lZHOMyCA3POuqVNc
         lxXLkPq55HhhCsnfYCrQ6UeFwcCWTwTTNoogzko+AMIiUDwMB+J4xl03JKEk1BnyHCrC
         RxNspZMtEmL7FSiHAtcddwoa+WkRFR4lufQwfJrPzwaCK0qDzMgZ3SfLECbXhCaWmcs7
         jUJ0E6wcOVB7wTl3Kq3g4DaSQVh5kiCuEe2XzfBV1six4p87hbZwNCJ45LSwYjFaVwnX
         wv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zSb8+oNNJd+qcd1Xbd4r2cy6RPqGNza5Mtwz+ay/kXo=;
        b=bkQ8kdV02Ngau4VNxJN3lDIIILfgQxzzQl2DbAEddnAFYMKwKxboB+ZIwx+ErN4zc0
         v29aDvoG77N59AN5ftQVRgJYWbodMRwBsSl2yVkcXAIJOjJPXi8ALLynJ8nNF7HOx2Cf
         9wEEooTFf1hoKA+LE/gZ2F46iK+uMIG64RQBPceR2mxbSj6kEWLBoJBWfKTRq5s1K41j
         z6Q31CHfsskowaNYC1HZb3NdgZhGGZUNtW4sCl7iAgOZIeqXyeF87rPsMhMe9TremOf6
         pJ+wFzZrb+inwoODsLMHrmSoLF3aaQHtdE2lW1hoHWjQnyzf1Iu/RuyBzzsTlHNSm6e4
         w5dQ==
X-Gm-Message-State: AOAM531a1ENRNmHUYVSquUqCZObuk0R+UtfCbFxcxqcAbxc8XXt9giO3
        7ArZVS88FMWFj7ht9yAuYqsxqQ==
X-Google-Smtp-Source: ABdhPJx6A7m2uCxW3WAtPM8VdB9T0nQCaGWNLnkTesvek7FgeyUMGuCga3rNT5Peg2/gkDm8khO1Zw==
X-Received: by 2002:a65:494e:: with SMTP id q14mr2788361pgs.314.1629974368955;
        Thu, 26 Aug 2021 03:39:28 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c123sm2659911pfc.50.2021.08.26.03.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 03:39:28 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:09:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v5 7/8] cpufreq: Read inefficiencies from EM
Message-ID: <20210826103926.6k2dxjramfm4a5yo@vireshk-i7>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
 <1629966944-439570-8-git-send-email-vincent.donnefort@arm.com>
 <20210826094649.y3fuohsjlc4c7ada@vireshk-i7>
 <20210826095459.GA443176@e120877-lin.cambridge.arm.com>
 <20210826095946.qnkt6bvvf6frdijn@vireshk-i7>
 <20210826103505.GA445483@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826103505.GA445483@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-21, 11:35, Vincent Donnefort wrote:
> But it looks like a weird back and forth between EM and CPUFreq:
> 
>  cpufreq driver -> register EM -> sets inefficiencies back into cpufreq.
> 
> It creates a dependency loop:  cpufreq -> EM -> cpufreq
> 
> While this version is more straightforward:
> 
>  cpufreq driver -> register EM
>                 -> apply inefficiencies from EM into cpufreq.

The problem is there there is no good place for cpufreq core to call
cpufreq_update_efficiencies(). It may look correct to call it right after the EM
callback is called in the current scenario, but it isn't.

As I said earlier, there can be other stuff later on which can set inefficient
frequencies, not just EM. So they better make these calls.

> Also, I'm not sure how em_dev_register_perf_domain() can access the cpufreq
> policy while the latter hasn't finished initialized.

It is initialized enough at this point so that you can call cpufreq_cpu_get() to
get the policy, that was the whole point of my series which added register_em().

-- 
viresh
