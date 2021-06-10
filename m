Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54A13A26F2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFJI1c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:27:32 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:34515 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFJI12 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 04:27:28 -0400
Received: by mail-pl1-f177.google.com with SMTP id h1so601372plt.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9brGsoPBB+d+RHY31m7cZqh3sPnjdxBD51bqiyGsmoM=;
        b=z4oi+QtsZIOkUCFtJ2RSljkQbvtIlKWhvmfPM3nkaTcx/SmP2SwZ/OG+gHmMtcJIVI
         Jz+fY/OSo8O9+ELcqVoo7u7WxCuKuZVq4HIvbp2fEaka2FusUdVtB2CaOnVDFdakQq1s
         WgD8eKYVt4xY7SKlklJT0+vTQaaOeIygjrFnC3E8n2TxgASfZSLqW6emrP4ePhogpd3p
         LCP0wfYPCSPY2fDENITlznVP5uwLlXyfFtXxpZyog9xudcUFU5hLh2OauKt2jpqkE710
         p8BQ3NdkFzKdUP8qDnJ5S4CR/6RqEXkcXwAaVGtyWxW6VDOUnL24T7ElbtkSHdIK+Xas
         nWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9brGsoPBB+d+RHY31m7cZqh3sPnjdxBD51bqiyGsmoM=;
        b=IwNCkSYc3MRXL/KYPCHyiTb1CVkJz/xAg+eOikJwJPXu52wzp/hKFDjHRGXjo0p+Ii
         yz66HwoaERO/2VjlzrfauWoFeCGEb8FgW+Iu4vxiaFWvR1M+/1o4tldNzcVIYtq0KCBK
         3vfu7iSZjmwgSHCh1cBV1NXX/gFYG2uAtCFJzvSY+i37Vtnn7CVnSTbi2Pxrxi/VwKLB
         gYTnGkj+1t9gh21JtEP+Vwq4Y7eJlAT2kS3fPUNe6rI1OXlR8+EuQSdfXLvzfaHlcv92
         wBsJzuYBurCmKAnnaUtNS6rX1Vfx1dHZV0h8Zkjq9v4Gz/9PLEYhi6LpW815s4ZN380o
         nTIg==
X-Gm-Message-State: AOAM530B3el0lLt9DKJEsxBjf2Ua1ajciBWNp13CtD4rLJr7/bMtLkTv
        FM1l7E1NUnPTgY5PDBUgilmlgw==
X-Google-Smtp-Source: ABdhPJyL6nxvcvsq34evJFOy65fc9gysLq/3WyEfD7vvQ+tDWp1jEmZFdtmAB1e5fkCXviRh9tP+3g==
X-Received: by 2002:a17:90a:1141:: with SMTP id d1mr2224862pje.56.1623313457758;
        Thu, 10 Jun 2021 01:24:17 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id q13sm1741649pff.13.2021.06.10.01.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] cpufreq: powerenv: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Thu, 10 Jun 2021 13:53:59 +0530
Message-Id: <0990172cba066ec7747e479f8f0a2069ae368339.1623313323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623313323.git.viresh.kumar@linaro.org>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state cannot be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the exit() callback instead of stop_cpu().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index e439b43c19eb..005600cef273 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -875,7 +875,15 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	/* timer is deleted in cpufreq_cpu_stop() */
+	struct powernv_smp_call_data freq_data;
+	struct global_pstate_info *gpstates = policy->driver_data;
+
+	freq_data.pstate_id = idx_to_pstate(powernv_pstate_info.min);
+	freq_data.gpstate_id = idx_to_pstate(powernv_pstate_info.min);
+	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
+	if (gpstates)
+		del_timer_sync(&gpstates->timer);
+
 	kfree(policy->driver_data);
 
 	return 0;
@@ -1007,18 +1015,6 @@ static struct notifier_block powernv_cpufreq_opal_nb = {
 	.priority	= 0,
 };
 
-static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
-{
-	struct powernv_smp_call_data freq_data;
-	struct global_pstate_info *gpstates = policy->driver_data;
-
-	freq_data.pstate_id = idx_to_pstate(powernv_pstate_info.min);
-	freq_data.gpstate_id = idx_to_pstate(powernv_pstate_info.min);
-	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
-	if (gpstates)
-		del_timer_sync(&gpstates->timer);
-}
-
 static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
@@ -1042,7 +1038,6 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.target_index	= powernv_cpufreq_target_index,
 	.fast_switch	= powernv_fast_switch,
 	.get		= powernv_cpufreq_get,
-	.stop_cpu	= powernv_cpufreq_stop_cpu,
 	.attr		= powernv_cpu_freq_attr,
 };
 
-- 
2.31.1.272.g89b43f80a514

