Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7641C28B4C7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgJLMmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJLMmW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 08:42:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3006C0613D0;
        Mon, 12 Oct 2020 05:42:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j18so837993pfa.0;
        Mon, 12 Oct 2020 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Cj47lWhLKBGlmOv6O753WAzZFddEs+CDjhGU44ptXQ=;
        b=QcdgBuug7zCqVBW+8cpJ6GKov6YaGsKH1UgfAAlcJAquIfK+r/DsD2APOBDB4JPvSa
         QJXX77ndYzv2ssaJFZ1Um18zcCvFZrrDuE99dZ+2JNsKKZaVKntqIA1Mebur9/CP5P6w
         QlKSUBna3x3Dxo4PE8Xeh9rnXXQB7x9ahRXWCAJZfnx3Ao2JXopnL99CSedQwt7ea99h
         xDWBVJkVk3qp3XpaE/BGeHOR+CEWIY97wVgBe4V93oQ2wPO1q120m+36cw+/brlFLK/r
         YFsNjkvt/Qb1pzLsMt2Gf1iK0/Mveffj50dnAz/Ev9sNAuHScSGlgQtdAm5rFXu6rmRC
         B9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Cj47lWhLKBGlmOv6O753WAzZFddEs+CDjhGU44ptXQ=;
        b=nqXZ/rOOVSV0GrosqVqX5YIKgBRYDzgXL699kr7O4jWyS4BXmcnGUV+cYL2nYDXAV5
         pM8bbKdMmwqhl0ECMAxpQ1VcTy3cS/obVxgGpso89qkPN/yw3gikAPUAIpwhDwflarTJ
         mxOzuZCvkIyduZlVFymbs1anIftwPRsJ+XDfxnFZWP3OXY4nY/wt9ffY1u9eOiVY1cZz
         L9sELFnzvrk/s8VTJ7EdRv2/mLZ4WJ21Braad0mdluxP4SqWpohnHju2T6ssXs7kgG1n
         DqbnWDVgZMcr6E+DCa3Ezoe/WtarEVvzBz2fAfaN/eRo/McDKFIxCAO3yVmGEIdc3XeS
         F6IA==
X-Gm-Message-State: AOAM530Ef2N0CsoQEYY5dYQN77iYFy+oh9mW1vo+IhA/9BtfUTp0lsWU
        s7R/bPJLUwRD/l7HYQn6a0PFVN6g5ObpKA==
X-Google-Smtp-Source: ABdhPJyTuqeDFAmDfO69EXGtk5fHUyTaExaWAj/zc69Fq7iARWqLSYHTZqNSfe5Dn/FdCH0EZbvy+g==
X-Received: by 2002:a17:90a:aa18:: with SMTP id k24mr19669492pjq.231.1602506541262;
        Mon, 12 Oct 2020 05:42:21 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id r6sm16259559pfg.85.2020.10.12.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 05:42:20 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     lukasz.luba@arm.com, quentin.perret@arm.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: [PATCH] PM / EM: consult something about cpumask in em_dev_register_perf_domain
Date:   Mon, 12 Oct 2020 20:41:36 +0800
Message-Id: <20201012124136.4147-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

Hi, Lukasz, Quentin
  I have three questions to consult about cpumask in energy_model.c.

1, The first one is about the meanings of the following two parameters,
[1] and [2].
[1]: "cpumask_t *cpus" in function em_dev_register_perf_domain(): Pointer
to cpumask_t, which in case of a CPU device is obligatory. It can be taken
from i.e. 'policy->cpus'.
[2]: "unsigned long cpus[]" in struct em_perf_domain: Cpumask covering the
CPUs of the domain. It's here for performance reasons to avoid potential
cache misses during energy calculations in the scheduler and simplifies
allocating/freeing that memory region.

From the current code, we see [2] is copied from [1]. But from comments,
accorinding to my understanding, [2] and [1] have different meanings.
[1] can be taken from i.e. 'policy->cpus', according to the comment in the
defination of struct cpufreq_policy, it means Online CPUs only. Actually,
'policy->cpus' is not always Online CPUs.
[2] means each_possible_cpus in the same domain, including phycical
hotplug cpus(just possible), logically hotplug cpus(just present) and
online cpus.

So, the first question is, what are the meanings of [1] and [2]?
I guess maybe there are the following 4 possible choices.
A), for_each_possible_cpu in the same domain, maybe phycical hotplug
B), for_each_present_cpu in the same domain, maybe logically hotplug
C), for_each_online_cpu in the same domain, online
D), others

2, The second question is about the function em_dev_register_perf_domain().
If multiple clients register the same performance domain with different
*dev or *cpus, how should we handle?

int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
			struct em_data_callback *cb, cpumask_t *cpus)

For example, say cpu0 and cpu1 are in the same performance domain,
cpu0 is registered first. As part of the init process,
em_dev_register_perf_domain() is called, then *dev = cpu0_dev,
*cpus = 01b(cpu1 is initially offline). It creates a em_pd for cpu0_dev.
After a while, cpu1 is online, em_dev_register_perf_domain() is called
again as part of init process for cpu1, then *dev =cpu1_dev,
*cpus = 11b(cpu1 is online).  In this case, for the current code,
cpu1_dev can not get its em_pd.

3, The third question is, how can we ensure cpu_dev as follows is not
NULL? If we can't ensure that, maybe we should add a check before using
it.
/kernel/power/energy_model.c
174) static int em_create_pd(struct device *dev, int nr_states,
175)                    struct em_data_callback *cb, cpumask_t *cpus)
176) {
199)    if (_is_cpu_device(dev))
200)            for_each_cpu(cpu, cpus) {
201)                    cpu_dev = get_cpu_device(cpu);
202)                    cpu_dev->em_pd = pd;
203)            }

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 kernel/power/energy_model.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index c1ff7fa030ab..addf2f400184 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -199,7 +199,13 @@ static int em_create_pd(struct device *dev, int nr_states,
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
 			cpu_dev = get_cpu_device(cpu);
-			cpu_dev->em_pd = pd;
+			if (cpu_dev)
+				cpu_dev->em_pd = pd;
+			else {
+				cpumask_clear_cpu(cpu, em_span_cpus(pd));
+				dev_dbg(dev, "EM: failed to get cpu%d device\n",
+					cpu);
+			}
 		}
 
 	dev->em_pd = pd;
-- 
2.17.1

