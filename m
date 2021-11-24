Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90D45C90A
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhKXPq3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 10:46:29 -0500
Received: from m12-17.163.com ([220.181.12.17]:52167 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhKXPq3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Nov 2021 10:46:29 -0500
X-Greylist: delayed 951 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 10:46:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=I8JCB
        WetjmtrI9rwQYpyAle7v9jgI2MNc3ikcuPHxr0=; b=Hr6qe2dkAIt7/bplMW3M8
        3vgi5byBttp4O64LC231sJ6J4sQZgBvwIbTpoin3bs+7IAlsZCRYMEba1N5MRzck
        zR1V351A+Jig+QZSnP/iPYj1C9uyH2WH1fgzRqZS1AZdUpjdX2tXadOoQ0vKpr1e
        BTv6VF3gsD0O+LbwV5qcGc=
Received: from localhost.localdomain (unknown [124.115.222.149])
        by smtp13 (Coremail) with SMTP id EcCowAAXHp6EWZ5hfBOLZg--.50622S4;
        Wed, 24 Nov 2021 23:26:43 +0800 (CST)
From:   Wentao_Liang <Wentao_Liang_g@163.com>
To:     daniel.lezcano@kernel.org, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wentao_Liang <Wentao_Liang_g@163.com>
Subject: [PATCH] =?UTF-8?q?/drivers/powercap/dtpm=5Fcpu.c=EF=BC=9A=20fix?= =?UTF-8?q?=20policy=20reference=20leak=20in=20cpuhp=5Fdtpm=5Fcpu=5Fonline?= =?UTF-8?q?()?=
Date:   Wed, 24 Nov 2021 23:25:53 +0800
Message-Id: <20211124152553.3407-1-Wentao_Liang_g@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAAXHp6EWZ5hfBOLZg--.50622S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4kGw1xJryfGw1rCFy5XFb_yoW8Kw4kpr
        s8K34YvF18trZrJ3ySyFs5JFya9rZFyFyrGrWxGryrZ3W3XFnagr1qyryqqFn5ur1kCr1I
        qay5Xa18CFWDCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzuWJUUUUU=
X-Originating-IP: [124.115.222.149]
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/1tbiQxNVL1c7WLYwTgAAsW
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In line 186(#1), 'policy = cpufreq_cpu_get(cpu)' will increase the kobject
reference counter of the policy. The policy has to be released with the
help of 'cpufreq_cpu_put()' to balance its kobject reference counter
properly. However, the function returns without dropping the reference
(#2,#3,#4,#5 and #6). It may result in a reference leak bug.

It can be fixed by calling the function 'cpufreq_cpu_put()' before the
function returns.

178 static int cpuhp_dtpm_cpu_online(unsigned int cpu)
179 {
...
186         policy = cpufreq_cpu_get(cpu);
	      //#1 reference increase
...
191         if (!pd)
192                 return -EINVAL;
	      //#2 function returns without decrementing reference counter
193
194         dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
195         if (dtpm_cpu)
196                 return dtpm_update_power(&dtpm_cpu->dtpm);
	      //#3 function returns without decrementing reference counter
197
198         dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
199         if (!dtpm_cpu)
200                 return -ENOMEM;
	      //#4 function returns without decrementing reference counter
...
220         return 0;
	      //#5 function returns without decrementing reference counter
...
226 out_kfree_dtpm_cpu:
...
231         return ret;
	      //#6 function returns without decrementing reference counter
232 }

Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
---
 drivers/powercap/dtpm_cpu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 51c366938acd..9330cfb31a62 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -189,16 +189,22 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 		return 0;
 
 	pd = em_cpu_get(cpu);
-	if (!pd)
+	if (!pd) {
+		cpufreq_cpu_put(policy);
 		return -EINVAL;
+	}
 
 	dtpm = per_cpu(dtpm_per_cpu, cpu);
-	if (dtpm)
+	if (dtpm) {
+		cpufreq_cpu_put(policy);
 		return power_add(dtpm, pd);
+	}
 
 	dtpm = dtpm_alloc(&dtpm_ops);
-	if (!dtpm)
+	if (!dtpm) {
+		cpufreq_cpu_put(policy);
 		return -EINVAL;
+	}
 
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
 	if (!dtpm_cpu)
@@ -226,6 +232,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	if (ret)
 		goto out_power_sub;
 
+	cpufreq_cpu_put(policy);
 	return 0;
 
 out_power_sub:
@@ -243,6 +250,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 out_kfree_dtpm:
 	kfree(dtpm);
+	cpufreq_cpu_put(policy);
 	return ret;
 }
 
-- 
2.25.1


