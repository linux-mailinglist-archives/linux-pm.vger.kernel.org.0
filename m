Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2035D3AE5D4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhFUJWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFUJWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:22:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD40C061756
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:20:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i34so8027287pgl.9
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+Pr0hB3aQxiWpb5eCV/aiPVZfCXjZdbK/uF+fA2suE=;
        b=GzDORQUQfU4EyaIz84r9ofxl7S2qiMUmnL8adgMAMRlSCje4XuoLkb9AZt5+OZ/uYc
         bdmFmBbJfOOzTSdfwKiThKNfnYfOjUzcgK0E1v1AHbdJxj8yDUAmT/WcHTgZF5V86eaW
         IOmErKVtiXIbnK72LGtHfyBwiLysLsLxXc0MfVqxq9qm/mlS5bUsh24zUD08THTH36H0
         7lBFyItmFb6sudEMOE4c8N6ae5aX1P0TbHDDmPPZdn5KYMBx5RczSegJQAcVOZyMWfGg
         vGNdwbIlfXD/vcmiDSuJsLaxrDRF+VXQsFrVUwIzFWJfHeRnc3YnWU0PCpSzn6OM8NwF
         B5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+Pr0hB3aQxiWpb5eCV/aiPVZfCXjZdbK/uF+fA2suE=;
        b=YGOEe24yLkeCtAU5tWCqEEKsjqoo8NEFCSvRTb0Q2vmQS1np7TS3DelADeV8RLC4N4
         EQfSRL9KbrsfWQigSaVmwWGEt5BpGsyJJNi6D1Kz7Ds4nxTY4qJ5rcZy1uxcr8xqQfLy
         w5XWeELiXxZkixOu7M+Es55mKKRgDgXYhTdMOuOOeyvfxRn4VqT+2PuW4QkUXP+eA5w5
         NmVFoPH0f9Dw74y1dUpPAIDlXuQREFicwzMMu2JUxqh9XUeM2MLFc2gzELvgjWE753bz
         1p0ZehZ9TnNrS+XX1HdB0Z128VuPZl5xbs1P1Wf0Fo0hJBzQhLUvyJwaiO97EqUU9ZSi
         TlpQ==
X-Gm-Message-State: AOAM532Uj7GjOatC3ayAKfv9jhsPirZk9ybQd6nqFd5w2GTb2GQ0V4QA
        6FGl1tvzy5L3zEDT9GNIufs5bA==
X-Google-Smtp-Source: ABdhPJztGqVoSVeigfrMYYjeWjpM2W5IxlGJLJaOWvr+uIBpPJEwCRmMsMAJm6R+YxhzlWO4jag9lw==
X-Received: by 2002:a63:36c1:: with SMTP id d184mr23133582pga.47.1624267215148;
        Mon, 21 Jun 2021 02:20:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id c18sm1521186pfo.143.2021.06.21.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 02:20:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] cpufreq: cppc: Fix potential memleak in cppc_cpufreq_cpu_init
Date:   Mon, 21 Jun 2021 14:49:34 +0530
Message-Id: <579689469ed8a7dfd68dcbb41e9191472799a326.1624266901.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624266901.git.viresh.kumar@linaro.org>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's a classic example of memleak, we allocate something, we fail and
never free the resources.

Make sure we free all resources on policy ->init() failures.

Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index be4f62e2c5f1..35b8ae66d1fb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -256,6 +256,16 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 	return NULL;
 }
 
+static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+
+	list_del(&cpu_data->node);
+	free_cpumask_var(cpu_data->shared_cpu_map);
+	kfree(cpu_data);
+	policy->driver_data = NULL;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -309,7 +319,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	default:
 		pr_debug("Unsupported CPU co-ord type: %d\n",
 			 policy->shared_type);
-		return -EFAULT;
+		ret = -EFAULT;
+		goto out;
 	}
 
 	/*
@@ -324,10 +335,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
+	if (!ret)
+		return 0;
 
+	pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+		 caps->highest_perf, cpu, ret);
+
+out:
+	cppc_cpufreq_put_cpu_data(policy);
 	return ret;
 }
 
@@ -345,12 +360,7 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->lowest_perf, cpu, ret);
 
-	/* Remove CPU node from list and free driver data for policy */
-	free_cpumask_var(cpu_data->shared_cpu_map);
-	list_del(&cpu_data->node);
-	kfree(policy->driver_data);
-	policy->driver_data = NULL;
-
+	cppc_cpufreq_put_cpu_data(policy);
 	return 0;
 }
 
-- 
2.31.1.272.g89b43f80a514

