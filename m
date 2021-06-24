Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079A53B24C1
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 04:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFXCNM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 22:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXCNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 22:13:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97423C061756
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:10:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u2so2145829plf.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 19:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4QIFhqycNj8GLoDIog1T+fSxwI5JTO5+UemhkS0t2o=;
        b=R7ELIICz9WdFf+PGQ2jd2Jt56KpGpgdj/4QUrfnuSVt9qDOiSeZ1+sg7CIfqUbvAiT
         BWH1QCojYmnncpNYSViPShe1SstM37ttCtOYpejVyNdYGeE/u1yGV+8VOSPgf+uC0bkB
         56aZ4Z1rFm/m9lLLqvEaf/z8jJvjdqJUhL7DHA4Oo2PmCaC0y/18re6FfDRRT0Dl749x
         kRvLjp0Wveo0QxlOCCPcu5iOPOSwAKriMPrSTTm+NGvs9+Z5GURRdgR2KAFAcpCe3EhQ
         4WIyQOLG2uLbH8iZwSgi2PUmd9pXfEGiA86tGVEBAQzjf4U4l8xdcQPwXswrG2ALuma4
         lVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4QIFhqycNj8GLoDIog1T+fSxwI5JTO5+UemhkS0t2o=;
        b=DTwwBmUvD0dMTh/oUrlbX2o6TW1qbqeVY51Vw2WvUQ72TNRWnpYOVR9/kOnbzNo6Wg
         Xffh7OjUYD4k1seYi6GntjF5F6YXSdlGL0nbl4tem060ub5r3IW+jtWQfyRR3zMsYPmN
         jS0DG7bJpBOCPgtjHFBifY4cIPLfm1DFC81dAsTC01eZB0KTvGTJHa2vvX3AvUktOzTH
         CafQmlS8UUZS8ZHcPOFmf9LcGRUuQQzT9CuX67tBM+mThkxuZhcIesoUvV+BGf+m1CD0
         Z8o9srkczkeTDISLe+8subnsMy2mISS088qKlIY260hg/sYVdjzP7A9CcjrabLFPHVZv
         vcrQ==
X-Gm-Message-State: AOAM5329bQE2kjKKLrWdzQDjfNk6oAZwoAjDfbLKbxkefd8FXDZ672Ze
        87NgBBQEaiIzrgat1GJd7RYDWQ==
X-Google-Smtp-Source: ABdhPJyA+BlUi6sU0IPP4K9bydQuXz1y1ea9apcmprLEGbvqRPkSS7TMCoR2Ioy9JSEx0GmseMDG9w==
X-Received: by 2002:a17:90b:11ca:: with SMTP id gv10mr12509991pjb.94.1624500652154;
        Wed, 23 Jun 2021 19:10:52 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id r207sm988256pfc.118.2021.06.23.19.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:10:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3.1 1/4] cpufreq: cppc: Fix potential memleak in cppc_cpufreq_cpu_init
Date:   Thu, 24 Jun 2021 07:40:45 +0530
Message-Id: <445b58405e81d996fb4037223b9e81fc258a07ea.1624500522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <579689469ed8a7dfd68dcbb41e9191472799a326.1624266901.git.viresh.kumar@linaro.org>
References: <579689469ed8a7dfd68dcbb41e9191472799a326.1624266901.git.viresh.kumar@linaro.org>
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
V3->V3.1:
- Updated "if (!ret)" to "if (ret)", the more commonly used format.

 drivers/cpufreq/cppc_cpufreq.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index be4f62e2c5f1..945ab4942c1c 100644
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
@@ -324,10 +335,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
+	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->highest_perf, cpu, ret);
+		goto out;
+	}
+
+	return 0;
 
+out:
+	cppc_cpufreq_put_cpu_data(policy);
 	return ret;
 }
 
@@ -345,12 +362,7 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
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

