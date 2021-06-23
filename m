Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE713B12D0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhFWE1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhFWE1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:27:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C8C061766
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:25:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u18so1278579pfk.11
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6a7/7P/WOJQ+/PmIgspG1zB1PV41tmG6f1/nfdy7CoM=;
        b=t+6xWab1VxarnVqfUhkbXR1Ff5de0zTzo6XWVJnzQqjtYQbcC0d0cwq4YGD7lFkZPL
         3VCCQ7GyVb0fc4NVhfd/P5AuT6vvj8LMYcV0/Okt3M12xDfYFLcdTNd7rLbPP6G68KMG
         jJgp22S2nIfWa1lhHXimlMG3L8KN6gVp+UbHs4gidPoZnMN0hCN6L/361N2/NoVK+Ir+
         iPlUq/8muUIcSsjjbPXhs0T21QyPAq2VdPnsrhetmIYDy/jKyl5y/5fVsP/VLneiminp
         VsYSBgGBoYAkDjGRKIxwWgctQSbsV2gmtktRZUjk+InzJza/FNeuXGeywqk8f4y+4FPV
         e3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6a7/7P/WOJQ+/PmIgspG1zB1PV41tmG6f1/nfdy7CoM=;
        b=JKJntAZ3B0kNuhI8+UuNQlj/nxkurKjPzgRCnAZQqypvOhIlhEQ6Xl8tN1R0Uv8p59
         4N1ywuMWNCg8BFaX9OrB34BgkusvQuR+PNjW0pG2q3QpfYKeBp9EMST3Cw2cI4mFZLQi
         rf5MsnAbbYgDyNaXLA3M0IfUNs+UMnovoi/Hro0a4F4xA48WuCVENSLyV95brlkuQgnU
         vIvsI+TncB+CpelNo+XshUfB2a8wt+JFk+Dr2+WZ/rHgMvuklTtcbd9weQtBD0AEdcnn
         ixlBw0u09MXa2MSqfOcry+7UXYh7gqfRsdf5yxsF2SVjTZNaPugcS6XJMv8QckgO0OCT
         RNsg==
X-Gm-Message-State: AOAM532uabCDYfDiTDEd8spI/U0M5ANxZbO7WW64Shkd20qS29AdrVNk
        NTSyAaX8Awq2Q8csNfbSqViOrw==
X-Google-Smtp-Source: ABdhPJzDpVOwS7ZIEb2SJs2H+EoxRoC+xD1xxTofOAwnibpWwbSbX5cAVwje8er8lFqQVADCv8VVzg==
X-Received: by 2002:a63:6dca:: with SMTP id i193mr1944100pgc.107.1624422304847;
        Tue, 22 Jun 2021 21:25:04 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id b9sm748602pfm.124.2021.06.22.21.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:25:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Wed, 23 Jun 2021 09:54:41 +0530
Message-Id: <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624421816.git.viresh.kumar@linaro.org>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state can't be
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

