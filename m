Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A817624DF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jul 2023 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGYVwP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jul 2023 17:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGYVwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2023 17:52:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F831FEB;
        Tue, 25 Jul 2023 14:52:12 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a1d9b64837so4174240b6e.0;
        Tue, 25 Jul 2023 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690321931; x=1690926731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2G/e8y/tvnNGTMmNmnaD68PLNtHT6GiMZvoHdRg+aU=;
        b=R3puFFKq+ZSGzNHmxPCpnTeYSaLCatWyIWrrZry4+8MTe4ZYoHOqQyVLOJkTIO6LdI
         XaZlYEeLZHO5anL2SR2yyCgHJFsLbOnlsLOfAevIYDaKTrV3FP9DSGTEk5umBkS6Q2dO
         +oI4fzhIMqls8oEpa2uNjE7O3BuVthvGynrKXA6FpaRE3528ZMBIrmT8HzY2K9bzVHBT
         wsJmUYGsKcB0Mv3agSU3IhgvbUbt+lS4vYybGAHs4dk0slYivmLKTp8T+FuhMpSadz5g
         kNAWtZkrOSD1djGuw4pc+DumKUy0XZZoyGEvFkgvlVfE7JXlLLixSwTFiGx3FTnuQCoA
         6Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690321931; x=1690926731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2G/e8y/tvnNGTMmNmnaD68PLNtHT6GiMZvoHdRg+aU=;
        b=BdZkmo38UcSC8khF8Oxa+EcqizzKVhJfzIKQ+YuDswRYVxy5h5JS/rqByerLYCKjkw
         K47HASx0zixu6q9o4tvor86Hn0YKNc2/tCrPLtnjhgvu/4GUDbstkrGcxkvhPEYSCulz
         pGNm6J/QmIR+Pzdq6SDMshG2HpTEhp0Sn4I308ziN19SdqYne/c+0IYuUcrbsfCs92kp
         OEwCLejod+D7tt5DA0fNy7umeNLwj8dRTdPuiG2uNuDr7+hPlf+nOlCvopRLppGJNnFu
         BG1O036M36Kg5DI83v5AMM8eN7Xhrrgiyp/bYbzFdEqSARAU610Hhv1vnNZ/EUdPE7w4
         VTgg==
X-Gm-Message-State: ABy/qLZPo1xO0eMx3Fox9TCi4h+KyDO+TPtYfw45sntaTzEdF00Tb0tK
        +LC7r6vX5tcmOlb/ox3NR6g=
X-Google-Smtp-Source: APBJJlG54o8WY98CP+xjRTeR1S+q2Ldy/fPlKKU1BXd7oYHQ/qegEG4jGeoIlI/AUnc8VPS3G6mssQ==
X-Received: by 2002:a05:6808:e87:b0:3a4:225d:82c0 with SMTP id k7-20020a0568080e8700b003a4225d82c0mr179900oil.31.1690321931094;
        Tue, 25 Jul 2023 14:52:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:18d])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a005d00b002612150d958sm57830pjb.16.2023.07.25.14.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:52:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 25 Jul 2023 11:52:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Linux PM list <linux-pm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: [PATCH wq/for-6.5-fixes] workqueue: Drop the special locking rule
 for worker->flags and worker_pool->flags
Message-ID: <ZMBECezjAixaMccA@slm.duckdns.org>
References: <ZF6WsSVGX3O1d0pL@slm.duckdns.org>
 <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
 <ZK3MBfPS-3-tJgjO@slm.duckdns.org>
 <ZK30CR196rs-OWLq@slm.duckdns.org>
 <CAMuHMdUCXPi+aS-7bR3qRetKF9T3W9jk_HKjvaXmfHv5SEeuFg@mail.gmail.com>
 <ZLXIvXBvhsnL-ik_@slm.duckdns.org>
 <CAMuHMdU8CGhsU-1PZNdWH1xjbWcWSg2s2RFAegXi+vs=d-0t8Q@mail.gmail.com>
 <ZLcLnoAoJmQ9WTuM@slm.duckdns.org>
 <CAMuHMdUo=17kYsNEYr=qyVceRpJ4D3jMFrMOiqaH--OOhJOM4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUo=17kYsNEYr=qyVceRpJ4D3jMFrMOiqaH--OOhJOM4w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From aa6fde93f3a49e42c0fe0490d7f3711bac0d162e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 17 Jul 2023 12:50:02 -1000
Subject: [PATCH] workqueue: Scale up wq_cpu_intensive_thresh_us if BogoMIPS is
 below 4000

wq_cpu_intensive_thresh_us is used to detect CPU-hogging per-cpu work items.
Once detected, they're excluded from concurrency management to prevent them
from blocking other per-cpu work items. If CONFIG_WQ_CPU_INTENSIVE_REPORT is
enabled, repeat offenders are also reported so that the code can be updated.

The default threshold is 10ms which is long enough to do fair bit of work on
modern CPUs while short enough to be usually not noticeable. This
unfortunately leads to a lot of, arguable spurious, detections on very slow
CPUs. Using the same threshold across CPUs whose performance levels may be
apart by multiple levels of magnitude doesn't make whole lot of sense.

This patch scales up wq_cpu_intensive_thresh_us upto 1 second when BogoMIPS
is below 4000. This is obviously very inaccurate but it doesn't have to be
accurate to be useful. The mechanism is still useful when the threshold is
fully scaled up and the benefits of reports are usually shared with everyone
regardless of who's reporting, so as long as there are sufficient number of
fast machines reporting, we don't lose much.

Some (or is it all?) ARM CPUs systemtically report significantly lower
BogoMIPS. While this doesn't break anything, given how widespread ARM CPUs
are, it's at least a missed opportunity and it probably would be a good idea
to teach workqueue about it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Hello,

Geert, applied this to wq/for-6.5-fixes. The local variable `mips` is
renamed to `bogo` to avoid collision.

Thanks for testing!

 kernel/workqueue.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 02a8f402eeb5..800b4208dba9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -52,6 +52,7 @@
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/delay.h>
 
 #include "workqueue_internal.h"
 
@@ -338,8 +339,10 @@ static cpumask_var_t *wq_numa_possible_cpumask;
  * Per-cpu work items which run for longer than the following threshold are
  * automatically considered CPU intensive and excluded from concurrency
  * management to prevent them from noticeably delaying other per-cpu work items.
+ * ULONG_MAX indicates that the user hasn't overridden it with a boot parameter.
+ * The actual value is initialized in wq_cpu_intensive_thresh_init().
  */
-static unsigned long wq_cpu_intensive_thresh_us = 10000;
+static unsigned long wq_cpu_intensive_thresh_us = ULONG_MAX;
 module_param_named(cpu_intensive_thresh_us, wq_cpu_intensive_thresh_us, ulong, 0644);
 
 static bool wq_disable_numa;
@@ -6513,6 +6516,42 @@ void __init workqueue_init_early(void)
 	       !system_freezable_power_efficient_wq);
 }
 
+static void __init wq_cpu_intensive_thresh_init(void)
+{
+	unsigned long thresh;
+	unsigned long bogo;
+
+	/* if the user set it to a specific value, keep it */
+	if (wq_cpu_intensive_thresh_us != ULONG_MAX)
+		return;
+
+	/*
+	 * The default of 10ms is derived from the fact that most modern (as of
+	 * 2023) processors can do a lot in 10ms and that it's just below what
+	 * most consider human-perceivable. However, the kernel also runs on a
+	 * lot slower CPUs including microcontrollers where the threshold is way
+	 * too low.
+	 *
+	 * Let's scale up the threshold upto 1 second if BogoMips is below 4000.
+	 * This is by no means accurate but it doesn't have to be. The mechanism
+	 * is still useful even when the threshold is fully scaled up. Also, as
+	 * the reports would usually be applicable to everyone, some machines
+	 * operating on longer thresholds won't significantly diminish their
+	 * usefulness.
+	 */
+	thresh = 10 * USEC_PER_MSEC;
+
+	/* see init/calibrate.c for lpj -> BogoMIPS calculation */
+	bogo = max_t(unsigned long, loops_per_jiffy / 500000 * HZ, 1);
+	if (bogo < 4000)
+		thresh = min_t(unsigned long, thresh * 4000 / bogo, USEC_PER_SEC);
+
+	pr_debug("wq_cpu_intensive_thresh: lpj=%lu BogoMIPS=%lu thresh_us=%lu\n",
+		 loops_per_jiffy, bogo, thresh);
+
+	wq_cpu_intensive_thresh_us = thresh;
+}
+
 /**
  * workqueue_init - bring workqueue subsystem fully online
  *
@@ -6528,6 +6567,8 @@ void __init workqueue_init(void)
 	struct worker_pool *pool;
 	int cpu, bkt;
 
+	wq_cpu_intensive_thresh_init();
+
 	/*
 	 * It'd be simpler to initialize NUMA in workqueue_init_early() but
 	 * CPU to node mapping may not be available that early on some
-- 
2.41.0

