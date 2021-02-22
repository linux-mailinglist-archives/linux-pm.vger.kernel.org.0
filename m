Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17932106F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 06:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBVFbA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 00:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhBVFbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 00:31:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2111C061574
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2021 21:30:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k22so7032457pll.6
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2021 21:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=88bCU0wVX0zazGnaAQhw1Te7NFEOR8aLunDEDqQi1Z4=;
        b=Y/5/Ig063lR7XiqKZl8egup3Bw/7Q79fv9uidDgZJ+d31Fed4RfdYAYDgNcOiMkLle
         DiBlIUsEBr4EpfSA5eE30xl0LdLAWTmxvEEPSmvwE/C5yfxk3dcwoYw37+Sssqa875Jx
         9p6aRBt1TbGorSxSmzd7cPS4NoT1DDEins0tvkz+pcdSzVdfMhBKFPDnUCsvZyCy+obe
         zhjFNOTS5+GX5tsls6GlwrBiUlhtoEvrSaJCTTrgS8S3b7CZtrd6EAz7JSsaJwf/7Swd
         yfNQ10331+hrXcep02vkjKD0h8paB/IsoEckuIySzjw9gSB2vqBQSeB6rcf7pPbzLkFN
         nbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=88bCU0wVX0zazGnaAQhw1Te7NFEOR8aLunDEDqQi1Z4=;
        b=Ywy5izJc0Hwyxfyj5Hx2gNdbmU4ME1jiZsjTy83dExMtrF+qbTwLZKoi/U4ppxkQ67
         GR58pv3usNGARXlmm2mw9Dycneer/ZQCnmO8gsNEEZXUsp8/TyWKQ6NQvy5taWTi5zpi
         zaG43FuhIQgV/B5vkTdLGgrz9HNNDyw4y6bYaKoneQzf8AiWYvaL7TLk8b0Tt7JyHJJi
         ykmR9izhjF8gV0xHlEqeE8Q7PdCUPwmGc5b9ELcW5isTyNYo/s5KXEHeBm36xONreg51
         mCQAzsz8yOhMWA1bZRH9u+dipFo8HSnDGId91id90ePsTrb5x6SVVPBgjYsXjZOWz2vL
         peDg==
X-Gm-Message-State: AOAM531kWGt3W5Sd0S7z2GOcetSv4INLMKqUqJpu9WVP8OmPfpzUQ6BO
        +WzsCv8ul87MNhhvhb+HqkFEWA==
X-Google-Smtp-Source: ABdhPJxxUldPNtASIvqHMCd0gy1HyqRM3BSDH/3dNeY642zgH1crWjaH8NJhBWi3riNxSSYPIRzftw==
X-Received: by 2002:a17:90a:1503:: with SMTP id l3mr21543094pja.41.1613971819001;
        Sun, 21 Feb 2021 21:30:19 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id w203sm9743518pff.184.2021.02.21.21.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2021 21:30:17 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:00:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't consider freq reduction to
 busy CPU if need_freq_update is set
Message-ID: <20210222053014.s45odi3qsfio2ahp@vireshk-i7>
References: <20210218082514.1437-1-zbestahu@gmail.com>
 <20210218102029.syj6vkltlbtoxsig@vireshk-i7>
 <20210219113804.00004a7e.zbestahu@gmail.com>
 <20210219040933.2o5hhbjb6emf3xl4@vireshk-i7>
 <20210219144140.00004de9.zbestahu@gmail.com>
 <20210219074249.2hcwcnakihor343h@vireshk-i7>
 <20210219162026.00002e2b.zbestahu@gmail.com>
 <20210219093551.bykqhjk6xvs4kszi@vireshk-i7>
 <20210219194509.00005884.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219194509.00005884.zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-02-21, 19:45, Yue Hu wrote:
> We will set next_f to next_freq(previous freq) if next_f is
> reduced for busy CPU. Then the next sugov_update_next_freq() will check
> if next_freq matches next_f if need_freq_update is not set.
> Obviously, we will do nothing for the case. And The related check to
> fast_switch_enabled and raw_spin_{lock,unlock} operations are
> unnecessary.

Right, but we will still need sugov_update_next_freq() to have the
same implementation regardless and so I am not sure if we should add
this change:

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 41e498b0008a..7289e1adab73 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -362,6 +362,9 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
         * recently, as the reduction is likely to be premature then.
         */
        if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
+               if (!sg_policy->need_freq_update)
+                       return;
+
                next_f = sg_policy->next_freq;
 
                /* Restore cached freq as next_freq has changed */


-- 
viresh
