Return-Path: <linux-pm+bounces-24999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843BA821AA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7704E1B85CF0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE32459FF;
	Wed,  9 Apr 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ndC0RNz7"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E921DF247;
	Wed,  9 Apr 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193121; cv=none; b=piZ1HzFKE7X6j+WhnLYysZKMH0Jb6bU0pjNE0Etd33jrqFshPn3kB9wS6o49Wo7IOW6bdg1sPwLZRvUmklx8K0pjyWfc8gZsNpoxqMeH4kj1AXZlWcOAopG+HJlDLaG3cnlZePWhJjm5I+XrvL+zeVdFXuWNaT/XPsayTsygsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193121; c=relaxed/simple;
	bh=dftAXhrtSj6CtjhCfME+c+dNS0JOX5D/+C+I3mPSItA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jb1Y9BO8A3t0hP4gnmfPQvTZYaRU41X2Vhcepar3MPJPlK5qW5eej5QIy97Rlcvxd25AHYMA0WpTvbXKBLhj5u4jj9DFJ45h6NEXzW1dr+TOOd5Di7AgwIwXrehqCihkqmurc6RBQKHYdphxerISmqFMB10gsXbrGruEdu/Bk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ndC0RNz7; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744193111; bh=JRw+TJVVfisiKuNwIGnJ9MSWyLObSQOGDeMTJZPcRVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ndC0RNz7vT64SFOnaVQruznx06fGF6P9wA0huFcB/VwCAQK4TzYmQhECigPjW7w/R
	 rgzDsMQnwkw1txl0O+VyTB7SnFF8bbkmTGsgkHQ8Y2AHTN9vSNWCV9oIVxzSnSJlzW
	 zsrW15yrvSX0LohLPTa86RRxJ3U9DmMgKsEhLSW4=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id CF320A71; Wed, 09 Apr 2025 17:51:51 +0800
X-QQ-mid: xmsmtpt1744192311tpyuc4d19
Message-ID: <tencent_2353FA17ABE475CC48686CA43867C9D6A605@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqJR+Oh04cuw2lq01R2qAcvty0EhcJ7UWAJsqCLQ8yJ6NR9x2NAT
	 JJMj6K/t2RfqcTJIZV0m8mOJ+/tzVKKKl4638WDi3gWh4F5FbFMgA2xgWWZCalZCfgWGBugxCqt4
	 QNhhoKxQuhzcnuUI5TfgoYxSG4MkTfn2jSHaLtizhdwfXgJKHhhPtVJTwUuxgsjb0UZ8Wye+Pwvz
	 VXydZXSSwXPpG5Z+2C3LMOJwvl2+iJrxL7ITJYt2gUY7E6gXuIY/uxHs0uNO69t3Tqs4/Kpdmtae
	 ke2G8fIAksW809Rz+kL8f9JtvOazsRxbUKJxBiszsDD7Q8Tbs0ttp2bDh5D84LT757k0dEe67em7
	 hScaiveMARQqums6RZg5IeL1hcnNgAEft6dM4aCvGimu0w0j5klJoYkBrN0zvgBu0pAgrupiR4RP
	 l7m9sA+DDL8s4GmWlzpfQuffkoYh2BnUoXesLt2PzoXWa9fRcafLMEkKePt0JblW97BPo9AtpCnq
	 jmg+YHYWoHAgZMGG+rFDIYyY7HA2NAUnco70e7xkzovOrRPzKq2g5UymvBu5Vi75NvVUfLnPxelp
	 V24E11jiGsN6o9pqvTLvDq+TSro4i6FGJUY9nRSh/mJfrVhlFX/WT+8BxapBaVpOVKp6V2zYkefX
	 LYuXgifOpyXszB/4Q3kXmdWxAdXiuuY8UDbnnwfdG7+w+sQ0XwEDgk3NE7LlQofM2ghVOWunlfSL
	 Oaa9/92F+hGDheqn0DZf6JZsLoWPouriLn+kNwvgCfMnToRHlAJiUK32AM4g9hAjqbc5mYyLwRB3
	 ZZhvFUKSXlT4kdKrylrHXQdTfsbDsRPlv6TC9cJxwJUNPXlpY8IVTyvrwyytnxeY4veO/dOhugAS
	 Gr8QSJCXQMJFmGnIHd1tDS03ivFcnrWlwK7C02FW71uxAiwtl0d9UHvKApc0vSUnmCRyIbTc/uAA
	 RVTj6H5VnOMbPFCjc7IwqD8sRsyzs+
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yaxiong Tian <iambestgod@qq.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	Pierre.Gondois@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 2/2] cpufreq: cppc: Add comments for CPPC_EM_COST_GAP calculation
Date: Wed,  9 Apr 2025 17:51:50 +0800
X-OQ-MSGID: <20250409095150.1692220-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_D6C4728C5C687C042BA7C156B0F3ECF7AE05@qq.com>
References: <tencent_D6C4728C5C687C042BA7C156B0F3ECF7AE05@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

The existing comments about CPPC_EM_COST_GAP were too brief. To help other
developers better understand its design rationale, this commit adds detailed
explanations about it.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/cpufreq/cppc_cpufreq.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 756034b21682..c8e281ca95c0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -358,7 +358,34 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy);
 #define CPPC_EM_CAP_STEP	(20)
 /* Increase the cost value by CPPC_EM_COST_STEP every performance state. */
 #define CPPC_EM_COST_STEP	(1)
-/* Add a cost gap correspnding to the energy of 4 CPUs. */
+
+/*
+ * In the current EM (Energy Model), energy consumption is calculated as:
+ *   ps->cost * sum_util;
+ *
+ * For CPPC, the cost calculation uses a linear model: cost = a + b * step.
+ *
+ * For a task A with utilization 'util' in a performance domain (pd):
+ * Before placement:
+ *   energy_pd_before = a * sum_util_pd + b * step * sum_util_pd;
+ * After placement:
+ *   energy_pd_after = a * (sum_util_pd + util) + b * (sum_util_pd + util) *
+ *                    (step + util/CPPC_EM_CAP_STEP);
+ * Energy difference:
+ *   energy_diff = a * util + b * util * step_pd +
+ *                 b * (sum_util_pd + util) * util/cap_step
+ *
+ * The placement decision depends on the bias 'a' and slope 'b'. Considering the
+ * extreme case where little cores are nearly full and big cores are nearly idle:
+ *   energy_diff_pd = a_diff * util - b * util * step_pd_small -
+ *                 b * util * sum_util_pd_small/cap_step
+ *
+ * Ignoring smaller terms, the key condition becomes:
+ *   a_diff > b * sum_util_pd_small / step_cap
+ *
+ * Therefore, for a pd domain with 4 CPUs, for ensures the scheduler will prefer
+ * placing it.we can configure accordingly.
+ */
 #define CPPC_EM_COST_GAP	(4 * SCHED_CAPACITY_SCALE * CPPC_EM_COST_STEP \
 				/ CPPC_EM_CAP_STEP)
 
-- 
2.25.1


