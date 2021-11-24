Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724AE45CA8E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349467AbhKXRFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 12:05:43 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:47956 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349416AbhKXRFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 12:05:42 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 12:05:39 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=f7cxo
        81Jyy/MlDMAZmvQHlwJdJ/bK+AjY9CliasYTAc=; b=Jw0jKPWRfT84gkTZrNC3t
        W6e9i6tbvxXiLkoiHEQ1QTIqPv4hMZClRVoN0y2GogwVHBwsQy1VijP5Zightnp0
        zp74VY/g+mw+0xHTldt4G/lc0wimgrPzYO3bgy7b5u6Y5C8Wbeb7eYrTgxkCiGqf
        0gdrObnvmYXR+/6GgVoJ28=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp2 (Coremail) with SMTP id GtxpCgD3RCmEbJ5htkyJKQ--.4644S4;
        Thu, 25 Nov 2021 00:47:11 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     daniel.lezcano@kernel.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei@gmail.com>
Subject: [PATCH] powercap: DTPM: Fix reference leak in cpuhp_dtpm_cpu_offline()
Date:   Thu, 25 Nov 2021 00:46:57 +0800
Message-Id: <20211124164657.20519-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgD3RCmEbJ5htkyJKQ--.4644S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDXr1xWw48JFy5JF43KFg_yoW8Aw4Dpr
        s8K3yav348tFWDK397J3WDXFyYvF92ya9YkrW3Gw1rZa43X3WFgw4DKryYqF1rCrn5Cw13
        try5Xay8Jay5JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bOv3bUUUUU=
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBORxVjF-PKEzbggABsQ
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jianglei Nie <niejianglei@gmail.com>

In line 153 (#1), cpufreq_cpu_get() increments the kobject reference
counter of the policy it returned on success. According to the
document, the policy returned by cpufreq_cpu_get() has to be
released with the help of cpufreq_cpu_put() to balance its kobject
reference counter properly. Forgetting the cpufreq_cpu_put()
operation will result in reference leak.

We can fix it by calling cpufreq_cpu_put() before the function
returns (#2, #3 and #4).

147 static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
148 {
153     policy = cpufreq_cpu_get(cpu);
        // #1: reference increment

155     if (!policy)
156         return 0;

158     pd = em_cpu_get(cpu);
159     if (!pd)
160         return -EINVAL; // #2: missing reference decrement

166     if (cpumask_weight(policy->cpus) != 1)
167         return 0; // #3: missing reference decrement

174     return 0; // #4: missing reference decrement
175 }

Signed-off-by: Jianglei Nie <niejianglei@gmail.com>
---
 drivers/powercap/dtpm_cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 51c366938acd..182a07ee14b6 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -156,21 +156,26 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd)
+	if (!pd) {
+		cpufreq_cpu_put(policy);
 		return -EINVAL;
+	}
 
 	dtpm = per_cpu(dtpm_per_cpu, cpu);
 
 	power_sub(dtpm, pd);
 
-	if (cpumask_weight(policy->cpus) != 1)
+	if (cpumask_weight(policy->cpus) != 1) {
+		cpufreq_cpu_put(policy);
 		return 0;
+	}
 
 	for_each_cpu(cpu, policy->related_cpus)
 		per_cpu(dtpm_per_cpu, cpu) = NULL;
 
 	dtpm_unregister(dtpm);
 
+	cpufreq_cpu_put(policy);
 	return 0;
 }
 
-- 
2.25.1

