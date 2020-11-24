Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BA2C1E2A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 07:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgKXG0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 01:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgKXG0W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 01:26:22 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BFEC0613D6
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 22:26:22 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id n137so7437088pfd.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 22:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpZw9Iej76OYuUGFvM+oELcoTaKPmqjpkVWxqorKfuc=;
        b=Xv/A2ULC/Ok9WfCZGQKExT+MDpPlNLIiKoRnayVzlu5cJ9+f2QTMIQZh4TnuwxFzCj
         qMWHnMM37/b/MLGm0vSq7k9REQu9iRjh3AXlKd52WgXmjc8VgkMsdXvKStaqQ/4f9zCv
         IhqMvmnE9Ue1kqDasiSEqMkCNS0MwJSml2pKbD9Wx7cTAGKeUST2X/6HQ/cX2o5upzwe
         SKsSkeY3ag3dK/LgL33C3ubxgkLxNcpXmpIf3QClddFEcDLwPHSz6XolWRhUMJK3JboD
         0AL3TrMPc74lGa7wRwncbdL1iltJFDxhaa3Q9Esi0OyDPdbeKXCfEGE/q5HQbjLjS54J
         ZrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpZw9Iej76OYuUGFvM+oELcoTaKPmqjpkVWxqorKfuc=;
        b=qtyoY1oorfCNgV94zEaiKyeSOeYdXodhZ1tGx77G7jISMHhIurohv+jhH6zcqpgi8j
         OYs/QBX/kHvwHAT++UveIzLMEScD29MKMR5BR/u9+tpKnaa7SYqh88UpT7Z96oVLk+Jh
         1V7lcTNjXmqfzMjNA7hpP3vKZeIG6ORoXwzCs3VhtMDJwYMlgg5HHqBVaNlKuK1YYylN
         0oR6KRxZQFUovldjXZUqqcig8J8xHPIGTRXNXUvQdrohdUptaZMBCXDKZkJDWMwhANG5
         ZLSZD+f07tp5DFS0uZv/BV+jKAcqhxvTkq2dXhdL66Q0LCJGXTA9tsCFxk63GXIRk7yV
         cB9Q==
X-Gm-Message-State: AOAM531pgDq073thtyRwBktvPQIlY0CG7iHxnZRrnPZ1341y1Wv1rOTv
        oEM+u58zJ3bZ3qOlLN31rRiWEQ==
X-Google-Smtp-Source: ABdhPJzSE6Krloh3zuTDK0TQPefXqGY3SdvFhb05zcIkKe8FZifbiRpzKRKf1hWkLPX/0GznUt8NMA==
X-Received: by 2002:a63:4765:: with SMTP id w37mr2537452pgk.332.1606199182233;
        Mon, 23 Nov 2020 22:26:22 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 67sm4436226pfz.96.2020.11.23.22.26.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 22:26:21 -0800 (PST)
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
Subject: [PATCH V4 0/3] cpufreq_cooling: Get effective CPU utilization from scheduler
Date:   Tue, 24 Nov 2020 11:56:13 +0530
Message-Id: <cover.1606198885.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patchset makes the cpufreq_cooling driver reuse the CPU utilization
metric provided by the scheduler instead of depending on idle and busy
times of a CPU, which aren't that accurate to measure the busyness of a
CPU for the next cycle. More details can be seen in the commit log of
patch 2/2.

V3->V4:
- Broke the first patch into two parts and used effective_cpu_util() in
  schedutil (Rafael).

- Removed comment about idle-injection in last patch based on feedback
  from Lukasz and added hi Reviewed-by tag.

V2->V3:
- Put the scheduler helpers within ifdef CONFIG_SMP.
- Keep both SMP and !SMP implementations in the cpufreq_cooling driver.
- Improved commit log with testing related information.

--
Viresh

Viresh Kumar (3):
  sched/core: Move schedutil_cpu_util() to core.c
  sched/core: Rename schedutil_cpu_util() and allow rest of the kernel
    to use it
  thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms

 drivers/thermal/cpufreq_cooling.c |  68 ++++++++++++++----
 include/linux/sched.h             |  21 ++++++
 kernel/sched/core.c               | 115 ++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c  | 108 +---------------------------
 kernel/sched/fair.c               |   6 +-
 kernel/sched/sched.h              |  31 +-------
 6 files changed, 197 insertions(+), 152 deletions(-)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.25.0.rc1.19.g042ed3e048af

