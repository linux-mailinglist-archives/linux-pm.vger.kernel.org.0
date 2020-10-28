Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83A29D7AA
	for <lists+linux-pm@lfdr.de>; Wed, 28 Oct 2020 23:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgJ1WZ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732935AbgJ1WZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:25:44 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0DC0613CF
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:25:44 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id w25so435012vsk.9
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 15:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EqOGNgE9WW0hrYEzgqgI3sT6nrO+744/k+/HNuwRgBQ=;
        b=ZIXKHQrPLo/vu+fCaMw4w25P3q1sw1n88Nu+8inRgWDwQEgrJ4vxU1wEQFraBG8dU7
         5UevqPsQcjUGHG6DvBqDkc/cxkWoxYa2y/1TdwNLdelQtTQO02VaRXEJvPluChU7goMs
         Um3rALmFyg4mfhoToSdeyqS6uqd3L73TKxVjGela+sq1D1pDD1Vd+q4xU2zOPKW6Gq5+
         RBO9ewiJl2em69+GwrJ1Sk6beugesleTYUltr9++E/HsN5dba3r8xNJt0mhtdjj/WLeX
         ig/E/jbOqQEZioWdX2RqgaVYJ+bD6yju3yvKOBueai3025SBhUcT04uTWrR2zjkdfS+E
         GNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EqOGNgE9WW0hrYEzgqgI3sT6nrO+744/k+/HNuwRgBQ=;
        b=TzSlneyfjCNYGGCCimjJFlpvvwyKpS7NYfZv0ozdGBXjNsdvMTDn8J/RgQQD/BbOKw
         ESs/rX8x+OGn887HpCon7DdyRg9KYx/WVbwb5KwCbY5+iW527uqskx4K8ufsjuXW1rMY
         /4T507Aiu6CTjFRlcnJJ5c8Ca1vQ385phIlnR3SsEKFpm3Wdv/whNMfbLZkdujNZTvVO
         +8BsZnsbq0Gx0me2FcXzphbO+fFCGyyfBWmkvPf8zrO4LdgSxh0ut6n13ms3PWFqYrev
         Y7MC7PBjt7DKIVbxrtDUG4LRvKDTpV9jEvvr8DlGnnT42qWd4Bpt8lRDhCejNLgyNU+c
         sYcA==
X-Gm-Message-State: AOAM533YNX0TKJ3/nz96IA0ixpxV3sjQY1y6ytcyFtXt32rMfgAA5yhB
        dvgoSFvsb9lEwn+XjH2TutwRDYZVBYtFuQ==
X-Google-Smtp-Source: ABdhPJywy/ga60IcwttPdRHFJcWFGFtaDf05nbvaK244IuijPHjbk9Zoz8Mxk9rC7dAGM1m9ZGraNg==
X-Received: by 2002:a62:aa0f:0:b029:162:ecc2:4d44 with SMTP id e15-20020a62aa0f0000b0290162ecc24d44mr8419846pff.52.1603899319799;
        Wed, 28 Oct 2020 08:35:19 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z4sm20pjn.0.2020.10.28.08.35.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:35:18 -0700 (PDT)
Date:   Wed, 28 Oct 2020 21:05:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhuguangqing83 <zhuguangqing83@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'zhuguangqing' <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the
 final cpufreq
Message-ID: <20201028153516.5aimftwtjbqgayqc@vireshk-i7>
References: <083a01d6ad19$fbdfbca0$f39f35e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083a01d6ad19$fbdfbca0$f39f35e0$@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-10-20, 19:03, zhuguangqing83 wrote:
> Thanks for your comments. Maybe my description was not clear before.
> 
> If I understand correctly, when policy->min/max get changed in the time
> Window between get_next_freq() and sugov_fast_switch(), to be more
> precise between cpufreq_driver_resolve_freq() and
> cpufreq_driver_fast_switch(), the issue may happen.
> 
> For example, the first time schedutil callback gets called from the
> scheduler, we reached get_next_freq() and calculate the next_freq,
> suppose next_freq is 1.0 GHz, then sg_policy->next_freq is updated
> to 1.0 GHz in sugov_update_next_freq(). If policy->min/max get
> change right now, suppose policy->min is changed to 1.2 GHz, 
> then the final next_freq is 1.2 GHz for there is another clamp
> between policy->min and policy->max in cpufreq_driver_fast_switch().
> Then sg_policy->next_freq(1.0 GHz) is not the final next_freq(1.2 GHz).
> 
> The second time schedutil callback gets called from the scheduler, there
> are two issues:
> (1) Suppose policy->min is still 1.2 GHz, we reached get_next_freq() and
> calculate the next_freq, because sg_policy->limits_changed gets set to
> true by sugov_limits() and there is a clamp between policy->min and
> policy->max, so this time next_freq will be greater than or equal to 1.2
> GHz, suppose next_freq is also 1.2 GHz. Now next_freq is 1.2 GHz and
> sg_policy->next_freq is 1.0 GHz,  then we find
> "if (sg_policy->next_freq == next_freq)" is not satisfied and we call
> cpufreq driver to change the cpufreq to 1.2 GHz. Actually it's already
> 1.2 GHz, it's not necessary to change this time.

This isn't that bad, but ...

> (2) Suppose policy->min was changed again to 1.0 GHz before, we reached
> get_next_freq() and calculate the next_freq, suppose next_freq is also
> 1.0 GHz. Now next_freq is 1.0 GHz and sg_policy->next_freq is also 1.0 GHz,
> then we find "if (sg_policy->next_freq == next_freq)" is satisfied and we
> don't change the cpufreq. Actually we should change the cpufreq to 1.0 GHz
> this time.

This is a real problem we can get into. What about this diff instead ?

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 0c5c61a095f6..bf7800e853d3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -105,7 +105,6 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
        if (sg_policy->next_freq == next_freq)
                return false;
 
-       sg_policy->next_freq = next_freq;
        sg_policy->last_freq_update_time = time;
 
        return true;
@@ -115,7 +114,7 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
                              unsigned int next_freq)
 {
        if (sugov_update_next_freq(sg_policy, time, next_freq))
-               cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
+               sg_policy->next_freq = cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
 }
 
 static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
@@ -124,6 +123,7 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
        if (!sugov_update_next_freq(sg_policy, time, next_freq))
                return;
 
+       sg_policy->next_freq = next_freq;
        if (!sg_policy->work_in_progress) {
                sg_policy->work_in_progress = true;
                irq_work_queue(&sg_policy->irq_work);

-- 
viresh
