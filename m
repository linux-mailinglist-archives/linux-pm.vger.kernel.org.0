Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B678290B37
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbgJPSRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391441AbgJPSRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 14:17:32 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66EC061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 11:17:31 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a16so1879663qtj.7
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=jSjH1eyM8iVzeEs2L9+1VUmTOGY9+1KpajutAHg/TE8=;
        b=stpM8PVUNvapHN5s3GE6OEHXwbzMr7MaqXEB3iezjKNeivnwwyNR3KGpmNu6x4y9yU
         UswZlo7ZUSX34RMC/ZwjPm5rE+hc8UrG5+UDizTp0RdKJClCXsISUAO1ZWr6Z3Pcturf
         g2f0IVLQ7ftWZn039a+ocgXPaPqzGOuynE7yaH8fxx1W77dGedK9ar/lZj2jMybL3EQK
         avRl4dUR7bdVCxMwyfRka2vNbRH8dUOULVcA18YIpMqx8hjQ+ygk8+DrPv6oNRDiis2d
         sKS/ToQvqYgpb+MRvnTt/hib+RFrcWyB1a0BZUN45Qxg8l9OnQeTKrrEE2dl2o0pCpQh
         L2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=jSjH1eyM8iVzeEs2L9+1VUmTOGY9+1KpajutAHg/TE8=;
        b=BpPNzPRaRTzDZTQkYXIm84INP3lcQw/wPWBl9Bw7qqUKw87vmOETalBoiZaZ6upvP9
         QHntUkob4jb7qXqIQAavAenMsAVsN2P333LDRDVuxIP6J3d+LfVafdvhQE9V5I4wxhW7
         JMq+TwBe99RgZZzfRrwW3IuJwEaPqOHRmYu6Z7Jel9lPnT6qbkGllOmXiTfTUme+UO7L
         VtKS8NQU9H/CPmIPRr8yGwBAVJjv/1MsScWnLd80OHdTVPnGxLGrKJf5QA/SURyhOU75
         GNil7iMiNdLGR33Rhd/CvusqqJBtP5qMHOdQnhNBIVr6cG+XuFfEVO7tP4LqFEa5NJkQ
         1jzw==
X-Gm-Message-State: AOAM531Ad9NHkDpf2ASyyblCc2WRtdm5m+k9EQS4wBKQfXvxhbT+bfaE
        1xy6KCEsxheVvwgzkTDyaWcZyf4=
X-Google-Smtp-Source: ABdhPJwBwRGWQ8hx/LhLhBXqOKsJPOZy8AYuESOLuGtz5uVcUy5TNC7Rpt5+0cDqhHwQ1UC00IuKzzA=
Sender: "wvw via sendgmr" <wvw@wvw-pc.mtv.corp.google.com>
X-Received: from wvw-pc.mtv.corp.google.com ([2620:15c:211:1:f693:9fff:fef4:4f9b])
 (user=wvw job=sendgmr) by 2002:ad4:45ec:: with SMTP id q12mr5445691qvu.33.1602872250940;
 Fri, 16 Oct 2020 11:17:30 -0700 (PDT)
Date:   Fri, 16 Oct 2020 11:17:22 -0700
In-Reply-To: <CAGXk5yoNxZBD9gX-8RvtsqAwB4rO=hFQKBewFhOGoMO171aJVA@mail.gmail.com>
Message-Id: <20201016181722.884812-1-wvw@google.com>
Mime-Version: 1.0
References: <CAGXk5yoNxZBD9gX-8RvtsqAwB4rO=hFQKBewFhOGoMO171aJVA@mail.gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] sched: cpufreq_schedutil: restore cached freq when next_f is
 not changed
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, viresh.kumar@linaro.org,
        qperret@google.com, rafael@kernel.org, Wei Wang <wvw@google.com>,
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

We have the raw cached freq to reduce the chance in calling cpufreq
driver where it could be costly in some arch/SoC.

Currently, the raw cached freq will be reset when next_f is changed for
correctness. This patch changes it to maintain the cached value instead
of dropping it to honor the purpose of the cached value.

This is adapted from https://android-review.googlesource.com/1352810/

Signed-off-by: Wei Wang <wvw@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5ae7b4e6e8d6..e254745a82cb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -441,6 +441,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned long util, max;
 	unsigned int next_f;
 	bool busy;
+	unsigned int cached_freq = sg_policy->cached_raw_freq;
 
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -464,8 +465,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (busy && next_f < sg_policy->next_freq) {
 		next_f = sg_policy->next_freq;
 
-		/* Reset cached freq as next_freq has changed */
-		sg_policy->cached_raw_freq = 0;
+		/* Restore cached freq as next_freq has changed */
+		sg_policy->cached_raw_freq = cached_freq;
 	}
 
 	/*
-- 
2.29.0.rc1.297.gfa9743e501-goog

