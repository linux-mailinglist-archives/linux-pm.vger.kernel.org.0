Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3E29D4D9
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 22:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgJ1VzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgJ1VzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:55:09 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF1C0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:55:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c11so1008456iln.9
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUQGYHl6fL0itz3RWijtbqZBDnCCvlTy72hHOJX7pSU=;
        b=wnl6oBn/Zw2KFaEIcPW+DYoJ9y6mSCx1bVJxZNJVS8dmkAv8U2yzrNU2SFR+/J5ZoI
         qLH21UEmwAqmSsLU6Fq4UKGDLHhOWBgDt36ptPjUbm6quVeflh/e5YH8n3MCqDw72/3f
         ZZh6gCQmzLpXxhm6Hku3R0CXNSBwi2nb81p8pauc7WFhrkAuoaAz2IjXVgOY+aKYfbQn
         m4Acp4WRhR8UFnibB71sCTgW/sgIHJZRXMrSRDZSdpxPL3I9/RH/AmBs5XM3HK7YY1oR
         XrGindx3PneZp60ijEP/JNl1BIrI04ZTN/nVFq1hqvrd5q+QN6SsA8AFH45BdXre49SJ
         4Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUQGYHl6fL0itz3RWijtbqZBDnCCvlTy72hHOJX7pSU=;
        b=sr0Xv3V+M+xxre8C0mWMZdx4psRm3T0lciomIM7sG/F8cKuUDx4vfW0chDDWSNURC4
         sd1CxP7Oa1a7U6+s0rV9w/laUOERYkEWpCV2YwWZy4gOuZghQTajpvxWZf4on71P9b16
         khcDa7zkMdfTgaL5s8yolsf1DAuJV8ncq4/ZXxM6v1lu1UWWy5w3iaNdTAYawzNZmojV
         luJGGwzKfDrJ9178wSN3cBWwjKNjcSh5UaorYyXARnSmdPl+x4+ryMz333ZqxGjRAyMw
         a1+mT7/gu+Wo0Mj6WZlFkVz/ed9eyxxMCCuxBzAD/aEJjFdT5NAgXcLRDd3F8XylCxxx
         koMA==
X-Gm-Message-State: AOAM531+LO4/bsHV9jnlHVflZ27WiYivOSSSjYJcwZTlNcxQmtlUQccZ
        GHebFQ2B5sGLG179tmOl8gsDnPT+4ii2mA==
X-Google-Smtp-Source: ABdhPJzhs5ftHX5k7BVSVR6ZAGDS0bIZvFqJD54c6guw3/I+nlMW2C5NSqlFji45AE+WjYTD8+7SXw==
X-Received: by 2002:a63:4d0b:: with SMTP id a11mr5168634pgb.296.1603873311277;
        Wed, 28 Oct 2020 01:21:51 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id k1sm1225956pgn.66.2020.10.28.01.21.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 01:21:50 -0700 (PDT)
Date:   Wed, 28 Oct 2020 13:51:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhuguangqing83@gmail.com
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the
 final cpufreq
Message-ID: <20201028082148.zkvcqau4p6xcihoq@vireshk-i7>
References: <20201027115459.19318-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027115459.19318-1-zhuguangqing83@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-10-20, 19:54, zhuguangqing83@gmail.com wrote:
> From: zhuguangqing <zhuguangqing@xiaomi.com>
> 
> In the following code path, next_freq is clamped between policy->min
> and policy->max twice in functions cpufreq_driver_resolve_freq() and
> cpufreq_driver_fast_switch(). For there is no update_lock in the code
> path, policy->min and policy->max may be modified (one or more times),
> so sg_policy->next_freq updated in function sugov_update_next_freq()
> may be not the final cpufreq.

Understood until here, but not sure I followed everything after that.

> Next time when we use
> "if (sg_policy->next_freq == next_freq)" to judge whether to update
> next_freq, we may get a wrong result.
> 
> -> sugov_update_single()
>   -> get_next_freq()
>     -> cpufreq_driver_resolve_freq()
>   -> sugov_fast_switch()
>     -> sugov_update_next_freq()
>     -> cpufreq_driver_fast_switch()
> 
> For example, at first sg_policy->next_freq is 1 GHz, but the final
> cpufreq is 1.2 GHz because policy->min is modified to 1.2 GHz when
> we reached cpufreq_driver_fast_switch(). Then next time, policy->min
> is changed before we reached cpufreq_driver_resolve_freq() and (assume)
> next_freq is 1 GHz, we find "if (sg_policy->next_freq == next_freq)" is
> satisfied so we don't change the cpufreq. Actually we should change
> the cpufreq to 1.0 GHz this time.

FWIW, whenever policy->min/max gets changed, sg_policy->limits_changed
gets set to true by sugov_limits() and the next time schedutil
callback gets called from the scheduler, we will fix the frequency.

And so there shouldn't be any issue here, unless I am missing
something.

-- 
viresh
