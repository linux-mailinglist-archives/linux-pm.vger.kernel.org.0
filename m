Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23A921E84B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 08:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgGNGhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 02:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGNGg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 02:36:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB84FC061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 23:36:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so6607153plm.10
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbfKQREcoHPRf158XU0NW9idW+wBMzJwoASt/jMG48E=;
        b=U1CHUpPVALPCRm2GeeE0rAYNmIhgWuHt4IhvISlOf8IAmDCGM8f5XPKotEJJmnprrJ
         Gf+fbSf4vE2f/VJLVuwGqMIv++0tp6II899RIQdLpsan1vymqNP6niU1LD03GxnJ5TsE
         CMEFdAGK8MuDYIFYbf0LhBWxS2pnjA/bJ/HxMzuvotRHKNwtAKE1qISErPzQUDmdPSTx
         yk8BmtwaDya8LgEl2cdyRkblidtvRQELBQhdpE6RbXQ1z1rbpWtTHpDwF1S2Rrkhu2Tv
         B5oXH0yaeb9zdpEUTZGUHnJS/GIUVIyDd6BdPJdXfQmk6ldTsrZ6CgMimeHojAdrS/k7
         /vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbfKQREcoHPRf158XU0NW9idW+wBMzJwoASt/jMG48E=;
        b=qs7ArFjnTM0jQd9YlH02wyx54Oc1PAE4njTmzT/a6V16G4yC5zCYPLtTnBO7X0On9y
         h6QPgxxJgI7CMVUs70hv40fpI68QMaU3skmdg32XEcHMrVfjvzXGlE34P6GNK4FTo6B+
         IYCFHu4FIoFHFs6zLuGiAkiGLh6eTLG2iQjBiRsc7P2MmGc86zIw1NcywjP0VrM/rUu2
         wa7BuHQ/2nX3Y9x3wa+OQ/HvT6mjZN9pEKf8AnuFwBeTCTzsh2YQtnybgSP3J5w+43FA
         krLAycQ4qqr03PgavV5+Pss9umaTcIfVqMZ0MM2I0XFl/1EH+HsJpdrTu5JzeR6XLF/1
         alpQ==
X-Gm-Message-State: AOAM533F3AAuXVmbSKqSkiqxJ8ok9a5UgWaF9E5HD7msOXYM3og+xGx/
        WdJkbANQX5iGr4A5EoocHj4GjA==
X-Google-Smtp-Source: ABdhPJzPSDpx104AHJyC0SptSEf+RNXyoMEuzRH/VkY9e6+TY68j6A7Xsn7ZLbnkTPDWTQb4XUyvQQ==
X-Received: by 2002:a17:902:e9d2:: with SMTP id 18mr2739643plk.40.1594708619207;
        Mon, 13 Jul 2020 23:36:59 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id y17sm16080185pfe.30.2020.07.13.23.36.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 23:36:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Javi Merino <javi.merino@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] cpufreq_cooling: Get effective CPU utilization from scheduler
Date:   Tue, 14 Jul 2020 12:06:51 +0530
Message-Id: <cover.1594707424.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Schedutil and fair.c use schedutil_cpu_util() currently to get an idea
of how busy a CPU is. Do the same for cpufreq_cooling which uses CPU's
idle time currently to get load, which is used to calculate the current
power consumption of the CPUs.

Tested with hackbench and sysbench on Hikey (octa-core SMP) and no
regression was observed.

--
Viresh

Viresh Kumar (2):
  sched/core: Rename and move schedutil_cpu_util to core.c
  thermal: cpufreq_cooling: Reuse effective_cpu_util()

 drivers/thermal/cpufreq_cooling.c |  65 +++++-------------
 kernel/sched/core.c               | 106 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c  | 108 +-----------------------------
 kernel/sched/fair.c               |   6 +-
 kernel/sched/sched.h              |  20 ++----
 5 files changed, 130 insertions(+), 175 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

