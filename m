Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFB2D21E1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 05:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgLHERo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 23:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgLHERo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 23:17:44 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3076C061749
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 20:17:03 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so12614348pfb.9
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 20:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHdvJA2HTSsKcq12ECvAFT6hATkrl/TFzJg0uMaRku0=;
        b=YKPk34UO6uwnipQNlIBKtdQw/9xGkncAFiZryxzvH34O/VEGjEaYwyr3zstJRQ23yy
         2d6nIPyAZaPz21F5m+W7/O9qXIU0UQjDz2ncZzh2LBOlfEHAKFTGEVYcOnI+a7Zxd7ax
         dbsoZwoatQouMGQaIftlSidpryFdaeILezrvQeIjFP8uIdffKQJKbpbIURf3dHOM0MtH
         0RyLIMvZkHvvRLFth5i+QTQbJPkxe8zkdskTn6ptpRb7DjXH/VJq0vsbf+bNOsM1qP2M
         Fn8f968ZMyDnvZ/3Itqt4GKht5ji6dSFw/F4MNLEGV+E7bIybyrDipAGSf26A4Kcq5ph
         g5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QHdvJA2HTSsKcq12ECvAFT6hATkrl/TFzJg0uMaRku0=;
        b=aNZh4AA383WpoKEURcp/SFlcJ0U0P7GeReyi/OZKaxfPqfuyPxgn0qRyh+to05G+YL
         e2m20C3TE99X2i6i3XyLwt9GJGlAGRUhC2Dn2DUeG3Dj006PtmATroIdKCY8rlGX19ij
         WjvTQEVtwM3pu9A4M8Ai1yHJ0F5sItWce0AvmuYXUI6JpNCyE3HxuvRZb/occucmvgy2
         8XQbqL/MUqDAm80uaoF5cFYZtfg6JcWrgXNRiEqKRNuT4EFdjB9f+wuSTTBej0cxXBiF
         r2WWXJ7dmlR6s6gBWAhmk7Uz2AXzcBMCfUbbuX9GKQjvtyCmWYe+T/KIpZSPI+bMKCnT
         GTVg==
X-Gm-Message-State: AOAM531E7xaxQ/xTBJUv0MJljX0TVeft8FWTwhsDOeMlJcqCzB5HZOw0
        n5NB9LKicrgQbZb4t8NF9HO/2A==
X-Google-Smtp-Source: ABdhPJwJUzPaDCBiYEYyn3tMURt2qiGQGs2mL3byq2uqzBnMc5ig1jS6M6TLGHIYPgvzT9y5ea3XhA==
X-Received: by 2002:aa7:9afb:0:b029:19e:45d8:b102 with SMTP id y27-20020aa79afb0000b029019e45d8b102mr3130288pfp.48.1607401023135;
        Mon, 07 Dec 2020 20:17:03 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id w9sm13052748pfj.128.2020.12.07.20.17.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:17:02 -0800 (PST)
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
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V5 0/3] cpufreq_cooling: Get effective CPU utilization from scheduler
Date:   Tue,  8 Dec 2020 09:46:54 +0530
Message-Id: <cover.1607400596.git.viresh.kumar@linaro.org>
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
CPU for the next cycle. More details can be seen in the commit logs of
the patches.

V4->V5:
- Don't export enum cpu_util_type and don't pass it as argument to
  sched_cpu_util().
- Fixed a build issue with !CONFIG_THERMAL_GOV_POWER_ALLOCATOR by moving
  {allocate|free}_idle_time() out of CONFIG_THERMAL_GOV_POWER_ALLOCATOR
  in patch 3/3.
- Applied Acks from Rafael.

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

 drivers/thermal/cpufreq_cooling.c |  69 ++++++++++++++----
 include/linux/sched.h             |   5 ++
 kernel/sched/core.c               | 114 ++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c  | 108 +---------------------------
 kernel/sched/fair.c               |   6 +-
 kernel/sched/sched.h              |  22 ++----
 6 files changed, 184 insertions(+), 140 deletions(-)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.25.0.rc1.19.g042ed3e048af

