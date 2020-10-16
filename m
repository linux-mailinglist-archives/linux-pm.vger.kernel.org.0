Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEAA2909C9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406328AbgJPQgj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410846AbgJPQgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 12:36:37 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124EBC061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 09:36:38 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w78so1744792pfc.15
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=ESK7AGq3xcY8c9Kxha7AtdakH67WdRXIQfnsDd+BhXg=;
        b=dofkqMiAcYaTZ/EU/5BiqncgO4c4vvmzEbKqHqFSlvIscLiIgRE/bTb1TustzDyW5+
         1d+MDxzUeGcty3tPvWgNBr8re5d1r05uCLQVUyvDWo12ygO68kqBUaC/YvvrQOBXKx6C
         lDzvruetF0BhW2g9fEHlRdHlShRQBxUvfcBGy8xB8BE0KZm0AhYakD993Plztl0nmxu3
         7W2ffDpO0liBBnb7GDO5SbSR2mrFTmtKJxjCIoQwys77J/qZgidVxMhgN6EqoA4KNTk8
         wX+qKyK6iRoT+AGjl7M1ZrIyJhBDRT/klURxjkDudaL3DgoJBj3dfx2KzoXfZyfAjs/H
         DAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=ESK7AGq3xcY8c9Kxha7AtdakH67WdRXIQfnsDd+BhXg=;
        b=MuMnzxF1zkR3cQJJa9rlWH0pxgDh9Kbk91G2KFMGzWNReHbg43qzx3hQtDWJMlL+J9
         6KoVwKqZ7I52Ny+haAJSfr/5qLKP9gWw+BRRbjCu+koTWW/P8yDh6EWHQR0xARWi2pbA
         qN5RY3BA1OeLjJuO7mtZTA7jZTOFGoEfnqZkLOhoqWuUU9v5JkJ4k/GxiwKUayNDJY83
         7aqTeK//Vc81SUq+yOYdSQPXENY6tdcmyHqGlc32EOzATvrdfG16EUW4i86IwSWdSAet
         Q1Y6Od12yaD4ESiVdeOEe+hz1Zr30ZGGLSo22ZsxKTJo6jn0E3tQ9GoMuhIV84qPJ+NO
         GXDA==
X-Gm-Message-State: AOAM530CcFYQXpDGxUkSLjIyAKby+bL7Nk4zwmOfnmbi+tWzaJODxZYr
        CsK8M8Mjfq2571DqP31lUfQ0N5U=
X-Google-Smtp-Source: ABdhPJzIj8wfAyuTdoCZc19cbR6Oa/+HMGW+IbJchs8PIY78j7uCCcCE0AmQhWTlP9Gx/+KxhSvLj6o=
Sender: "wvw via sendgmr" <wvw@wvw-pc.mtv.corp.google.com>
X-Received: from wvw-pc.mtv.corp.google.com ([2620:15c:211:1:f693:9fff:fef4:4f9b])
 (user=wvw job=sendgmr) by 2002:a17:902:402:b029:d5:ac47:c33f with SMTP id
 2-20020a1709020402b02900d5ac47c33fmr4582746ple.60.1602866197061; Fri, 16 Oct
 2020 09:36:37 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:36:33 -0700
Message-Id: <20201016163634.857573-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] sched: cpufreq_schedutil: maintain raw cache when next_f is
 not changed
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, viresh.kumar@linaro.org,
        qperret@google.com, Wei Wang <wvw@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, raw cache will be reset when next_f is changed after
get_next_freq for correctness. However, it may introduce more
cycles. This patch changes it to maintain the cached value instead of
dropping it.

This is adapted from https://android-review.googlesource.com/1352810/

Signed-off-by: Wei Wang <wvw@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5ae7b4e6e8d6..ae3ae7fcd027 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -31,6 +31,7 @@ struct sugov_policy {
 	s64			freq_update_delay_ns;
 	unsigned int		next_freq;
 	unsigned int		cached_raw_freq;
+	unsigned int		prev_cached_raw_freq;
 
 	/* The next fields are only needed if fast switch cannot be used: */
 	struct			irq_work irq_work;
@@ -165,6 +166,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 		return sg_policy->next_freq;
 
 	sg_policy->need_freq_update = false;
+	sg_policy->prev_cached_raw_freq = sg_policy->cached_raw_freq;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
@@ -464,8 +466,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (busy && next_f < sg_policy->next_freq) {
 		next_f = sg_policy->next_freq;
 
-		/* Reset cached freq as next_freq has changed */
-		sg_policy->cached_raw_freq = 0;
+		/* Restore cached freq as next_freq has changed */
+		sg_policy->cached_raw_freq = sg_policy->prev_cached_raw_freq;
 	}
 
 	/*
@@ -828,6 +830,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->limits_changed		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
+	sg_policy->prev_cached_raw_freq		= 0;
 
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
-- 
2.29.0.rc1.297.gfa9743e501-goog

