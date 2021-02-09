Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC5314E09
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBILOQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 06:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhBILMH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 06:12:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E013DC061786
        for <linux-pm@vger.kernel.org>; Tue,  9 Feb 2021 03:11:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cv23so1355132pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2021 03:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1gfRAu+EF22TJgGrs/thl2AAOrMdVzWuE7892b9S/rs=;
        b=gMlqXT8rWIpJyD5epCoxTSOMoDQeGgVe/OYZzHq885OM3Eec7ej1Ha+es9Qi5ghM0n
         Qzia5l+bxr4acSJhvwVqZ5kdPAcK41l24tLJWRsP+f71m7t51KZPx7C+XhDJYLv4hJBG
         fRuoLRfO+ARlgG4HF1L3wVXCp68Mpf5XYEbN+AG2dq8Gzc+DHZgM/9yi3oP73hTraLLi
         3OAMArWW73mLCyjy9/EuMjm3+H3tAQWtvTpNV7t42N+dnC0FZKly0Xh9cphxwhtN9wap
         WGjEBfkZzSQmNbn8Vw0tgsTwxhq0IjLH00SzIBxf6A9tQ0ZSZSTmpWFOSu48DcJ88nA1
         ueog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gfRAu+EF22TJgGrs/thl2AAOrMdVzWuE7892b9S/rs=;
        b=hqxjhVMMqUID46I53FP645Adc0tjRgTVGAFKdQPVMuMgv/v8JltWQzcwqUtDxfjRMh
         8IITUFBGgXBvK+GS6JHFY9umFgqAwBhyfV6DSbdghkJbHj0asR1D1tEGL/hAiBp3Dj0S
         VRlMlb3W4A0S+6dhfEXovQdyhpnr3kHfdam+w1+QsPA2rHyi4YOzMub3cmuVbYHUV2Gs
         VC0wUr9HGYbRGOfIlUFdn3/Dj2FUZRa9jYzH/Z04faB28jkPLSnZrT15XsKpJyWnKtCu
         oU2qnCSULrurZ8TVeAfoW3IKfze2ROPgOh/ooSyPvNkFSFa0PXIaI67Z3s/KTtD3relt
         FpoQ==
X-Gm-Message-State: AOAM531yok2G8oQ6Xci/8NqR0LC2HY9htvP8C5v5BjxlX2PXVA9ZFGVz
        p9zfJatFfvSgGdJOPdsF2n/3qA==
X-Google-Smtp-Source: ABdhPJzb6OwNr5h9uGAFWKExAYZiQLT3W8yNvzEfekNQUpET/UHm0MoH1Vt9vf374J4PuOEMD42siA==
X-Received: by 2002:a17:90b:33d1:: with SMTP id lk17mr3582252pjb.102.1612869086445;
        Tue, 09 Feb 2021 03:11:26 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id ep14sm2268423pjb.53.2021.02.09.03.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 03:11:25 -0800 (PST)
Date:   Tue, 9 Feb 2021 16:41:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com,
        zhangwen@yulong.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't use the limits_changed flag
 any more
Message-ID: <20210209111123.kzx36ghdac4rpfuh@vireshk-i7>
References: <20210208030723.781-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208030723.781-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-02-21, 11:07, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> The limits_changed flag was introduced by commit 600f5badb78c
> ("cpufreq: schedutil: Don't skip freq update when limits change") due
> to race condition where need_freq_update is cleared in get_next_freq()
> which causes reducing the CPU frequency is ineffective while busy.
> 
> But now, the race condition above is gone because get_next_freq()
> doesn't clear the flag any more after commit 23a881852f3e ("cpufreq:
> schedutil: Don't skip freq update if need_freq_update is set").
> 
> Moreover, need_freq_update currently will be set to true only in
> sugov_should_update_freq() if CPUFREQ_NEED_UPDATE_LIMITS is not set
> for the driver. However, limits may have changed at any time. And
> subsequent frequence update is depending on need_freq_update. So, we
> may skip this update.
> 
> Hence, let's remove it to avoid above issue and make code more simple.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
