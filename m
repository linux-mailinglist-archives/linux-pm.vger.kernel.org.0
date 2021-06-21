Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AE3AE5D9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFUJWk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFUJWf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:22:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A248C06175F
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:20:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5so9588687pjj.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmIDZ3cAKPLMmD3sDAHfD3r1HwdBZo6Uo9FfuobBvbk=;
        b=Y+dxkC/pF6ZmWU24hO2eIFxfT96wCod+04pXPhOSRopF5srtkgkiC1mSwfxcQdpV/o
         9goLQgwz+WDXK9mwVCNp0F896JJ799cVV3gZo6+oqAVDxyzZZG8Norle7LBNo4e3kpV7
         2m1aav/bdFzUyxxqJSWLYaQ4DX5AxwElPm12TxIZ9q5arteGbGfH4mW0A+uybg5cNsXv
         DfvuB84/7MGqeV7TN/TSM8Mj81W88wbB2irt1snZW1ibV6MDPnXM9d56QPmO3EtVKEKr
         c30n523ed3hKNl0H/vLjusqBO1aYtW2GjDTFEUeHxpQLx1LZMTqKii9wZt/yx0fvUgl9
         TjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmIDZ3cAKPLMmD3sDAHfD3r1HwdBZo6Uo9FfuobBvbk=;
        b=RQsk3ITtKBh+NBXlIBWLsogMZLzPZctTtDps0CHownec4SBIjCXFkBzourQqjTjfx9
         iwxkkZ1NQyiCB3okJcregQtP+/1dCIPl6AkeZNEGrrmQxGdU1on4LIBeLEnwof8NzIRJ
         AWecdcujy/ZiimGugqplfhZb/lp/uT14MEwssUsAXoyx+aZYD68cT0EnrvUxKCthifIr
         YIDFXdU+Y26pD5jboktUZoHiSUrZBdPLyItrZQRAS4ywQJcQUEWKiimuBvY9RRvBnith
         NT+qfCOiIJ54UgeQz2M40IPa9fboWbPfA4lmAO2+xc9DIaE+brWwDWE7GUjbMdHyBjL5
         m4QA==
X-Gm-Message-State: AOAM531APH3Wh5br9j/DXTyyNV9y01qQAPBio9ow6H1nEdTOAT9eha/+
        hVWtcnqbPjQlcdOssSc8iHpWHg==
X-Google-Smtp-Source: ABdhPJxKA69E69jDZsy9vRISOJwtNTSMxuZh219SA8wl1Wym31liqYndXU1TvCRwhmrhvTR2lJdO2A==
X-Received: by 2002:a17:90a:1382:: with SMTP id i2mr30426790pja.221.1624267220762;
        Mon, 21 Jun 2021 02:20:20 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id x1sm3015078pfn.198.2021.06.21.02.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 02:20:20 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] arch_topology: Avoid use-after-free for scale_freq_data
Date:   Mon, 21 Jun 2021 14:49:36 +0530
Message-Id: <f0e5849b4fe19b8aabd12640c85e13dd96945e21.1624266901.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624266901.git.viresh.kumar@linaro.org>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently topology_scale_freq_tick() (which gets called from
scheduler_tick()) may end up using a pointer to "struct
scale_freq_data", which was previously cleared by
topology_clear_scale_freq_source(), as there is no protection in place
here. The users of topology_clear_scale_freq_source() though needs a
guarantee that the previously cleared scale_freq_data isn't used
anymore, so they can free the related resources.

Since topology_scale_freq_tick() is called from scheduler tick, we don't
want to add locking in there. Use the RCU update mechanism instead
(which is already used by the scheduler's utilization update path) to
guarantee race free updates here.

synchronize_rcu() makes sure that all RCU critical sections that started
before it is called, will finish before it returns. And so the callers
of topology_clear_scale_freq_source() don't need to worry about their
callback getting called anymore.

Cc: Paul E. McKenney <paulmck@kernel.org>
Fixes: 01e055c120a4 ("arch_topology: Allow multiple entities to provide sched_freq_tick() callback")
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c1179edc0f3b..921312a8d957 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -18,10 +18,11 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 
-static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
+static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
 
@@ -66,16 +67,20 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
 	if (cpumask_empty(&scale_freq_counters_mask))
 		scale_freq_invariant = topology_scale_freq_invariant();
 
+	rcu_read_lock();
+
 	for_each_cpu(cpu, cpus) {
-		sfd = per_cpu(sft_data, cpu);
+		sfd = rcu_dereference(*per_cpu_ptr(&sft_data, cpu));
 
 		/* Use ARCH provided counters whenever possible */
 		if (!sfd || sfd->source != SCALE_FREQ_SOURCE_ARCH) {
-			per_cpu(sft_data, cpu) = data;
+			rcu_assign_pointer(per_cpu(sft_data, cpu), data);
 			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
 		}
 	}
 
+	rcu_read_unlock();
+
 	update_scale_freq_invariant(true);
 }
 EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
@@ -86,22 +91,32 @@ void topology_clear_scale_freq_source(enum scale_freq_source source,
 	struct scale_freq_data *sfd;
 	int cpu;
 
+	rcu_read_lock();
+
 	for_each_cpu(cpu, cpus) {
-		sfd = per_cpu(sft_data, cpu);
+		sfd = rcu_dereference(*per_cpu_ptr(&sft_data, cpu));
 
 		if (sfd && sfd->source == source) {
-			per_cpu(sft_data, cpu) = NULL;
+			rcu_assign_pointer(per_cpu(sft_data, cpu), NULL);
 			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
 		}
 	}
 
+	rcu_read_unlock();
+
+	/*
+	 * Make sure all references to previous sft_data are dropped to avoid
+	 * use-after-free races.
+	 */
+	synchronize_rcu();
+
 	update_scale_freq_invariant(false);
 }
 EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
 
 void topology_scale_freq_tick(void)
 {
-	struct scale_freq_data *sfd = *this_cpu_ptr(&sft_data);
+	struct scale_freq_data *sfd = rcu_dereference_sched(*this_cpu_ptr(&sft_data));
 
 	if (sfd)
 		sfd->set_freq_scale();
-- 
2.31.1.272.g89b43f80a514

