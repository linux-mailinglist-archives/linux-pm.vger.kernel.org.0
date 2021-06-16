Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D505A3A9308
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhFPGu2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhFPGu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 02:50:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA60C061767
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:48:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c12so1400917pfl.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RkESd0HK4MR77nDjYWPFbKW7m8spyK8zJmc8uVKNCY=;
        b=qfJXKeo4h64kbUFW1dLRqCxx1NM3VzPw5VPItHIh652oS+xP0v5eQrBk8wC0asRupc
         urD7ajq67fiNMNrNOlN1GjrYkMdyDTjZHOzfL1ePfvPW7HHsRVq6kC3yqGHk4A1JOeNg
         hpcjD5zn0aUprDFarQsQaL7ztHMKjXVqLPziBk//OG9fQsm1rCNlWtNJlkv8oYacUMeG
         uz+DArLn43Rz92Ak/Fo7+p0G5k+Te1J19SJkX3TnHA80JCoBGpx57wafMSo8jUjyKm+z
         QFgjAlsK52MSIfX5nkVwR6D6JHdboS/xB5+O6LFmU9+v4SNzjy2QgF2pvBqZRWPDQQ7x
         y2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RkESd0HK4MR77nDjYWPFbKW7m8spyK8zJmc8uVKNCY=;
        b=LMYMA5fI+Qiz87dxRgMcJZtJUTS16gPvXBdXnoOHbL4zwdnqNitxTBhcNoa2yYdsRy
         VYVmSu4ubJKjvIlsyzHmKNkAgYaf89Ru9eyCMO7M59L4EB1PpuXdK2Jv6XOK2PAfbuSi
         qOgXs2JHSYRl2/nlArHmZYyoFxScoGdHksKUYT5JrDhiC0yJfSdkH0dhbbLFqygAXhG7
         4mndh3ccvURrpu1JuS8OVuMKgcw7RpuEsY3EmUE51CyBVr5KrdFceUg+0PMIeR95XToY
         Li4owve5BaUFuEg2w8rqNEbDaZY7xsooWodvq8Ae6zSTDmBoEKzMKco6mHLwL2f+VkC/
         Vldw==
X-Gm-Message-State: AOAM530U8xuneizca22he8y9zB9ylfP8KqLhepYX8pMRPjiYNnb9dWiW
        Itb0tk9MO2/QRB42Il1eyADY/Q==
X-Google-Smtp-Source: ABdhPJyFm6ATzjiOHsyOt8CldYhTMAu95Yjowf/OqgLkjA++loMsZoumsgCGadcCrJumRg3OGuoo0w==
X-Received: by 2002:a65:6642:: with SMTP id z2mr3507720pgv.388.1623826101221;
        Tue, 15 Jun 2021 23:48:21 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id p6sm4434629pjk.34.2021.06.15.23.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:48:20 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] arch_topology: Avoid use-after-free for scale_freq_data
Date:   Wed, 16 Jun 2021 12:18:08 +0530
Message-Id: <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623825725.git.viresh.kumar@linaro.org>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently topology_scale_freq_tick() may end up using a pointer to
struct scale_freq_data, which was previously cleared by
topology_clear_scale_freq_source(), as there is no protection in place
here. The users of topology_clear_scale_freq_source() though needs a
guarantee that the previous scale_freq_data isn't used anymore.

Since topology_scale_freq_tick() is called from scheduler tick, we don't
want to add locking in there. Use the RCU update mechanism instead
(which is already used by the scheduler's utilization update path) to
guarantee race free updates here.

Cc: Paul E. McKenney <paulmck@kernel.org>
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

