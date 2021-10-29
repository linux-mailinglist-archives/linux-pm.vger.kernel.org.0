Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3877943F589
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 05:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJ2Dxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 23:53:50 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:41718 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231523AbhJ2Dxu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 23:53:50 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2021 23:53:49 EDT
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowAAH6e32a3thTamVBQ--.42489S2;
        Fri, 29 Oct 2021 11:35:18 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] cpufreq: Fix implicit type conversion
Date:   Fri, 29 Oct 2021 03:35:17 +0000
Message-Id: <1635478517-3071352-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowAAH6e32a3thTamVBQ--.42489S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr45Gr48ZF4rJF1xtFWxXrb_yoW8CFW5pF
        Wj9ayYyr4qgryjy3y7CrWkWF45KFnrJ39rKr9xGr9YywnrJ3WF9w18KF1DXrW8Crn5uF17
        Ar1Yqay7Ga18JaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1U
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUk3ktUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The variable 'cpu' and 'j' are defined as unsigned int.
However in the for_each_cpu, their values are assigned to -1.
That doesn't make sense and in the cpumask_next() they are
implicitly type conversed to int.
It is universally accepted that the implicit type conversion is
terrible.
Also, having the good programming custom will set an example for
others.
Thus, it might be better to change the definition of 'cpu' and 'j'
from unsigned int to int.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4f09afd..4aff4b6 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -409,7 +409,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util = 0, max = 1;
-	unsigned int j;
+	int j;
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
@@ -746,7 +746,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 	void (*uu)(struct update_util_data *data, u64 time, unsigned int flags);
-	unsigned int cpu;
+	int cpu;
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
@@ -783,7 +783,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 static void sugov_stop(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
-	unsigned int cpu;
+	int cpu;
 
 	for_each_cpu(cpu, policy->cpus)
 		cpufreq_remove_update_util_hook(cpu);
-- 
2.7.4

