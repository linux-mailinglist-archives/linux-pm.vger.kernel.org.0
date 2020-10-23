Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767A8296CB6
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462101AbgJWKUa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462100AbgJWKU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:20:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C2FC0613D2
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:20:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v22so587293ply.12
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57hzLQaJMNAPBdPxw7/Mh7ohBPiIWIlEXegmuy2e8tQ=;
        b=ACFm6fNwdWbaykKnnsPWj9zBMxJwpz73jrCjLgAomymbDgslm3zxaXPbqzcb71RaHM
         kwuqXrB3gabm92H3vWWYVAW5M1A5Zphih6/uG+hTIiSPtPOnAoff8PIRVsTBKEeLYA3o
         +jcWayTNCzYFgYM8U7Pd64NyOish0Iv59WaarZfsvssYDjnMKunNebmgCUX9Zs3hKDWp
         efHM6iqiV+eV1BNbGx3NWKyUcPSoGSAxFYwSeaqdz7tF1RskfaFOk2mTvFjArlV8FoGk
         7/2S3Nmc6OGl3bm2asof4rTT8KwvfPlcZrbtuyNfeHFoPOwMvhldn7UN8QJBJ38zjLQP
         2QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57hzLQaJMNAPBdPxw7/Mh7ohBPiIWIlEXegmuy2e8tQ=;
        b=XM1e5uL9nkpjhXIfIn599ZvQf7ZWXsJL0vLClMkvhf5EZRDC0uwOIVSB6Q2D5a1aS2
         +/ETwIqi7FZaeIW+zENVwxnPvFb4pugpUbz3At2T8h3OBNAdxCejPHDcZ7vS7hdN3dTv
         9+pFJg7+0S9eU46AmjIC6ZxZFcpICcXTnWakPkQVISTbLO4RzScnykSxXgVxkocfp+N7
         OrpU28DNejhyeB/nBwy+tQFmwAAvyVCPwlrnN5TDztOHRbd4hRP6LXqBaL5F42UjJdOd
         veFxYPROb/OJgx96ve9LOzLs+3oFETbqg1vLcxIV6+jX1ao15yx0Q+61kkhpxsRKeLkQ
         TkYA==
X-Gm-Message-State: AOAM5314YeWZL5PybBzccji7hSrTU9C4PWGtZ2rNMrv3x7KoVU47e1QJ
        LYCTD7cRdx9ZtZ3AxW3rVPB04w==
X-Google-Smtp-Source: ABdhPJz3hhe1HtBQtKMbcAD/xcUY7YzF7JhVwG8E7RIFh9XNFgbAk+A7U6IH3tjuxLu2kVMa1dbNpw==
X-Received: by 2002:a17:902:9006:b029:d6:799:5df4 with SMTP id a6-20020a1709029006b02900d607995df4mr1842897plp.12.1603448429123;
        Fri, 23 Oct 2020 03:20:29 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 197sm1630711pfa.170.2020.10.23.03.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 03:20:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Javi Merino <javi.merino@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH V2 0/2] cpufreq_cooling: Get effective CPU utilization from scheduler
Date:   Fri, 23 Oct 2020 15:50:19 +0530
Message-Id: <cover.1603448113.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter/Rafael,

I thought about the fallback thing getting registered by scheduler with
cpufreq core, and after Peter's comment about two interactions with
cpufreq I didn't like it much. Either way we are exposing the cpu
utilization finding algorithm to rest of the kernel, through cpufreq or
otherwise.

And so kept it simple for now. Scheduler exposes a single routine,
sched_cpu_util(), along with the related enum and that's all schedutil
and cpufreq_cooling stuff want.

V1->V2:
- Name the routine as sched_cpu_util().
- Make it more self sufficient and remove few parameters that aren't
  required to be exposed anymore to rest of the kernel.
- Better cleanups in schedutil and cpufreq_cooling.

---

Schedutil and fair.c use schedutil_cpu_util() to get an idea of how busy
a CPU is. Do the same for cpufreq_cooling which uses CPU's idle time
currently to get load, which is used to calculate the current power
consumption of the CPUs, which isn't that accurate.

Tested with hackbench and sysbench on Hikey (octa-core SMP) and no
regression was observed.

--
Viresh

Viresh Kumar (2):
  sched/core: Rename and move schedutil_cpu_util() to core.c
  thermal: cpufreq_cooling: Reuse sched_cpu_util()

 drivers/thermal/cpufreq_cooling.c |  70 +++++-------------
 include/linux/sched.h             |  19 +++++
 kernel/sched/core.c               | 113 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c  | 116 +-----------------------------
 kernel/sched/fair.c               |   6 +-
 kernel/sched/sched.h              |  29 +-------
 6 files changed, 156 insertions(+), 197 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

