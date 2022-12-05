Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEAC64259A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Dec 2022 10:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLEJTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 04:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiLEJSl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 04:18:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612012A85
        for <linux-pm@vger.kernel.org>; Mon,  5 Dec 2022 01:18:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q1so9943485pgl.11
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 01:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RU0EbWEBXFTTYKd6dj/Z3UvzwEwK63Rxz3z+L6vr4Dw=;
        b=whJOuRXQHyEQIV4vaxbJArTYaaA92Dp1YGO7kPBbWHQ48nCetaNBUIRIVfU3F2RZNt
         Z525IMzUv+VRUeduRo/t30JB9SQkianm77FHk0G/zJqj7pr5lIM7GY1mAZfOTBFTQs5C
         TAxXhTl44hwetuXrx076SP1r0ksFzKdelZ1EWnxvEPJUIrgmejr2TP86WpaTaLuVdhXL
         /nztUHNeprxeJrBBtdmtCcuPhn/NvyHIQaXNTHC5rWia9bY5mBs8K4Hf/H8627lG0EPF
         QT/nqcLJUNyY6Eb0oaM8VNYN7CEnfh6FlfusxE2sfsD+svizrB9aAQ5GwOJraMHxD8MD
         NNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU0EbWEBXFTTYKd6dj/Z3UvzwEwK63Rxz3z+L6vr4Dw=;
        b=AEFzkTsse+nD3I2VzwmjtC8JEmggNidxua/TNiPvHWjOPewdOysvd9P5v1PQ5G9Fap
         TV7yqdOvCG+6hAscpLkvfl1Qukv5g9owu5W5uPvQOJge/DweKCUDbuVKPkb8LJ8oHg+5
         UJwexcOw8VR29YbDQ3s3P8Hd77+dHCxPTg7JYpMfNiXcw5c3IrlXYY/+ZonAwMDk0n/Q
         HwwThJE4Fk3DFZ6/lXyjeIyiALlcj7vZ6xt/2qMwgG88mbTlkYA1MoXRPbMDzxaL5INR
         r9i9MVuyQscD2rtyFeG0Sv4C7yJtYJKdSBIclzjPHKGRGcsJSVM4FLkMXNXHVyGs+DdG
         xjhg==
X-Gm-Message-State: ANoB5plldvMNdH5whadJu31cfWJP2xsCAgvsMWQRxG+Cbz3r9TZG4RQt
        UN/4XXOnJFdwf1cHutYjCPXwcg==
X-Google-Smtp-Source: AA0mqf6f1oXQeON5ByRWnaKzwD6/i/Xw+QWo6jUkq+PgCtM5/VgWj7mMIf0bBdXyyNTAZm/Rw8pnrw==
X-Received: by 2002:a63:5016:0:b0:478:538a:aec6 with SMTP id e22-20020a635016000000b00478538aaec6mr24570161pgb.290.1670231913300;
        Mon, 05 Dec 2022 01:18:33 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090a664b00b00216df8f03fdsm10497273pjm.50.2022.12.05.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:18:32 -0800 (PST)
Date:   Mon, 5 Dec 2022 14:48:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sam Wu <wusamuel@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy"
Message-ID: <20221205091830.pttdbyts4hujkpq2@vireshk-i7>
References: <20221110195732.1382314-1-wusamuel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110195732.1382314-1-wusamuel@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Lukasz,

On 10-11-22, 19:57, Sam Wu wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 9161d1136d01..1207c78f85c1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -25,9 +25,6 @@ struct sugov_policy {
>  	unsigned int		next_freq;
>  	unsigned int		cached_raw_freq;
>  
> -	/* max CPU capacity, which is equal for all CPUs in freq. domain */
> -	unsigned long		max;
> -
>  	/* The next fields are only needed if fast switch cannot be used: */
>  	struct			irq_work irq_work;
>  	struct			kthread_work work;
> @@ -51,6 +48,7 @@ struct sugov_cpu {
>  
>  	unsigned long		util;
>  	unsigned long		bw_dl;
> +	unsigned long		max;

IIUC, this part, i.e. moving max to sugov_policy, wasn't the problem
here, right ? Can you send a patch for that at least first, since this
is fully reverted now.

Or it doesn't make sense?

-- 
viresh
