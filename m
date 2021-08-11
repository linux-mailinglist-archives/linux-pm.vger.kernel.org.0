Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A43E8993
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 07:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhHKFDx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 01:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhHKFDx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 01:03:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6CC061765
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 22:03:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q2so1101040plr.11
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 22:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m8Vuc12nkOtKj8Tmc2m3PPOmyZGEWDnC41TJJxSyiFY=;
        b=nLLZQEHouLliJNEisx69s5GYTZxWLqoq+g6oR/APktXzMgWiOn5WvwU++OvUjYMFuu
         LF799VaRb/fOKN2iUuD2V4SYUgve9/oZVUT7NKFG0nQ39qU7pftN2cIjm1cixPkuFap2
         AR/eAle97WVqT+9/b8AIUmB54jNNJClMZSsbe8KCEPyXw5kgKtDeyUiwOl1Tfmq92BvJ
         yJo94oXRdL+rpuJBJ/ZLdAfwYfbCBTNc4UesJluvy62P+ePplM5Kar2N/md0gSwU8PoA
         klft+e09JLah7atrHlhVJ1sSgBtiBcHB0cHCkB2RsIUDrSdObzmTQHHQ7JD0lNgNhvDV
         3t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m8Vuc12nkOtKj8Tmc2m3PPOmyZGEWDnC41TJJxSyiFY=;
        b=hZH3Cvv4i33ChxXs3kZlVAHaUBO4Jsky2GNJJkZKFLv/nQ36yczyP/MJeDaB+fcRn3
         HW0Ip0hFL6n4zZpIHrcBIc+NN8A+8LeCct05Af9Ywm/sdf+UvAU2Hnlot3YPW9+y2NCp
         Augwnn4g3hmxVIxQA3ok4FZz0UfiYDIaCJSNWvzqR3RpW6rl87FKVWrzg60prpIrEYNx
         jaG2HdAae0/O5popGHCsovzHXSiSVxd3FmgFOBv+kDNG93fkj0D4MDtERlF/eOB9p8JS
         abENb6H/oh59qzySDRkC17FiDAfrVu1x4L/p0StcnCSCAs8GjpTahupCRjDAhcBYmRlA
         ZJyA==
X-Gm-Message-State: AOAM5331AwlHRlJQ68aACHejWYJRHIn9KiR7NBXtenqDY71KuY0p/sIr
        0jYlyZw+QsLPvWAV/hfEDtPVUg==
X-Google-Smtp-Source: ABdhPJwOXhuvigI203mBa8qBfD5jUeXbkoJ2tFP9xIPJ3uRHgK5z7KHxKnDbhfWBYdMk38Nq1/miCQ==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr32771198pff.49.1628658209978;
        Tue, 10 Aug 2021 22:03:29 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id n11sm24290042pjf.17.2021.08.10.22.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:03:29 -0700 (PDT)
Date:   Wed, 11 Aug 2021 10:33:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, r@google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <20210811050327.3yxrk4kqxjjwaztx@vireshk-i7>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <78bc08fe-71c2-398c-9a10-caa54b8bd866@arm.com>
 <YRKINFhDmYqvgxsN@google.com>
 <cf9d78fe-cff0-1992-2c15-7053e4431296@arm.com>
 <b888407c-d444-8184-cbb7-ce8e925b254b@arm.com>
 <YRKfluMP8G41/P61@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRKfluMP8G41/P61@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-21, 16:47, Quentin Perret wrote:
> On Tuesday 10 Aug 2021 at 16:12:29 (+0100), Lukasz Luba wrote:
> > I've checked that. It's not the policy notifier and arch_topology which
> > cause an issue, but the cpufreq governor setup code. Anyway, we cannot
> > wait so late with the EM registration, till e.g. ::ready() callback.
> 
> Aha, yes, because by the time the arch_topology driver rebuilds the
> sched domains, the governor is not 'installed', which means the
> scheduler is not in a position to enable EAS yet. So we need to wait
> until sched_cpufreq_governor_change() is called for that. Makes sense,
> thanks for checking, and +1 to your conclusion.

What about this then ?

Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Aug 11 10:24:28 2021 +0530

    cpufreq: Call ->ready() before initializing governor

    The driver may want to do stuff from the ->ready() callback, like
    registering with the EM core, after the policy is initialized, but
    before the governor is setup (since governor may end up using that
    information).

    Call the ->ready() callback before setting up the governor.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a060dc2aa2f2..2df41b98bbb3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1494,6 +1494,10 @@ static int cpufreq_online(unsigned int cpu)
                write_unlock_irqrestore(&cpufreq_driver_lock, flags);
        }

+       /* Callback for handling stuff after policy is ready */
+       if (cpufreq_driver->ready)
+               cpufreq_driver->ready(policy);
+
        ret = cpufreq_init_policy(policy);
        if (ret) {
                pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
@@ -1505,10 +1509,6 @@ static int cpufreq_online(unsigned int cpu)

        kobject_uevent(&policy->kobj, KOBJ_ADD);

-       /* Callback for handling stuff after policy is ready */
-       if (cpufreq_driver->ready)
-               cpufreq_driver->ready(policy);
-
        if (cpufreq_thermal_control_enabled(cpufreq_driver))
                policy->cdev = of_cpufreq_cooling_register(policy);

-- 
viresh
