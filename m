Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0835166722C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 13:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjALM1e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 07:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjALM1c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 07:27:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE99A46E
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 04:27:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so16450183wms.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sCX1b48e8dRGm1touskXh42mYr8pJ9DdJayuAposRc=;
        b=IE/wdueTnBV8FapPdkMf8yP0YzRm2TMURIv35p5iyuS5/ZvpJv0s4IkPuEd9ph6f9p
         18fvwd6Oan1q4yWzwtvPT+ZpnYofMxaM8PpVENT6PgWFsirii8BfyN5PXDZbrIT5WsMW
         Uf723Po9SiWTNphA9rk3HXvJizFTFrgC2FN47U90YgbGczl00r6ZulYdKDdIIIvgBKro
         NaiCOO9XtL1fCUa7CEY9HK4nJmfbUGNm6VHsDLaBJnQzNLql6Zpea2VQ066IfbNUTkzz
         I+tOKkG7KlByWNPhSMMHUzP8xcVfAXNZBYehy5e7CxgBia0ppLJYRCNf1MrmImasNasc
         e//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sCX1b48e8dRGm1touskXh42mYr8pJ9DdJayuAposRc=;
        b=P2hPcVnvSRt9cmTcfSHHepIlFgVNQULIJzrYTj1kZXxJmUFknefY9fOVyUqFOx/zrm
         DtNeFI7jgSLFWe4UE13Uqm5ZnkPQCUX3HCzkEjxYSUfb5Ef5kQuP/7BmiM4xgawPATgE
         W+mdqa2qFrSqzG7yqA8KjZzZEO2TlGsNcNshvrvq2nXBNsJRLCoo03orEXZvtoeeUv8e
         Wr0qG91yF5zvV3+caY7mTAY2zqNB4vLHv87ncxwhmVp+cKESZvxci99gr7TTTHx6Xozm
         L6pGKp077a1HoD5NJuKsayJ87zbx5BxZ38ffZ3XnoTDhqhPZzn8aXM1ZRn09dP9+rU2b
         1ixg==
X-Gm-Message-State: AFqh2koSsNdODruvogJzkvWarNSNVMIdmZtlGn3byinffDabGbmzX9Hs
        Iz+oANsLtkaaSdgfKzyBThQsMQ==
X-Google-Smtp-Source: AMrXdXvUCFEgHhLT6z/Jt7Oae8f3sKqIfWixkAEiIfyelwJg072FkpqJkrXJJTq+OkPsb+sEGQCzGQ==
X-Received: by 2002:a05:600c:2112:b0:3d3:396e:5e36 with SMTP id u18-20020a05600c211200b003d3396e5e36mr54272884wml.0.1673526449885;
        Thu, 12 Jan 2023 04:27:29 -0800 (PST)
Received: from airbuntu.lon.corp.google.com ([104.132.45.104])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm30132354wmq.22.2023.01.12.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:27:29 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 2/2] sched/fair: Fixes for capacity inversion detection
Date:   Thu, 12 Jan 2023 12:27:08 +0000
Message-Id: <20230112122708.330667-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112122708.330667-1-qyousef@layalina.io>
References: <20230112122708.330667-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Traversing the Perf Domains requires rcu_read_lock() to be held and is
conditional on sched_energy_enabled(). Ensure right protections applied.

Also skip capacity inversion detection for our own pd; which was an
error.

Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5a8e75d4a17b..34239d3118f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8992,16 +8992,23 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	 *   * Thermal pressure will impact all cpus in this perf domain
 	 *     equally.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_energy_enabled()) {
 		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
+		struct perf_domain *pd;
+
+		rcu_read_lock();
 
+		pd = rcu_dereference(rq->rd->pd);
 		rq->cpu_capacity_inverted = 0;
 
 		for (; pd; pd = pd->next) {
 			struct cpumask *pd_span = perf_domain_span(pd);
 			unsigned long pd_cap_orig, pd_cap;
 
+			/* We can't be inverted against our own pd */
+			if (cpumask_test_cpu(cpu_of(rq), pd_span))
+				continue;
+
 			cpu = cpumask_any(pd_span);
 			pd_cap_orig = arch_scale_cpu_capacity(cpu);
 
@@ -9026,6 +9033,8 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 				break;
 			}
 		}
+
+		rcu_read_unlock();
 	}
 
 	trace_sched_cpu_capacity_tp(rq);
-- 
2.25.1

