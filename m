Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D7F78A373
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 01:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjH0XcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 19:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjH0XcU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 19:32:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E3106
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 16:32:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401187f8071so16394715e9.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179136; x=1693783936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2o3qJKDZS4dFtdaQhs245LyTqmuk7rvrkvinnh/CtI=;
        b=JvaSnzVw+G2fl49nyDo/YXbHUkfFUiTIHGuH+Sudr/on+fzDWXe5PtGWMmbcdUSKCq
         Mf8RtGMPZZLRXqf2wjmmtBs2+ibHX56kO+M9YmRzSWNxfOkMbxFJB/HFpLHJ5XN6p7Tp
         AvzluRDawzd8QiBhAxRBjN4ZOT6ZsCtE7QI07hjIVw2YLAZKltwHvlKTnGLohChwWvvV
         gvG4fpq7cNdmqY2o9HvkbkDEh1kAX05wnACaqNdj7//7c8sQV8MbOmLpWibKezs9YZUP
         pGCD4ei3HjM04fyxhorlv2Fi1Dnxi8saH1sJIUyo9vhrLk3bxTug+aGgiZ+L5HkibPQh
         6e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179136; x=1693783936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2o3qJKDZS4dFtdaQhs245LyTqmuk7rvrkvinnh/CtI=;
        b=l0eXJ4C4eECm3aBlxr9pX9CO5R3vlr0Ij5sZIXU3ngBygrhYBawgJr5BaOlnCPIjN0
         1yULVbqQFGrmL1JEQt0dJkrYFW3QGk14j11KvDR6+UMpxde2DpCZUOAOJThx3Bp1s7xC
         qV9PoT3KoiD4QDTibtWqbFAgsPizkP7fvreflhaurC0rBvyiHnSIpr3+VhSEQbNSb3yA
         LpktBmlNqEU7xQ0DeGgcNvv4qUEo+72egwvsFfTSiCWXOoMl5KKAq3pIlhwNm+ht2Yti
         34XABlfnawmaBbKKirNPKoU/AR2HW51ix0g8e/RswwYg+yPrMQauVEM/d0yUPPGA3+QM
         ikPQ==
X-Gm-Message-State: AOJu0Ywxk2FP2/TCZ2FlfEcqqHGw3SO64d2mix4Gl+soqU1k1Ov7qbXL
        3W894de0F3HHWX6a+m71VLTP0Q==
X-Google-Smtp-Source: AGHT+IG8+eLA6cvLBCh+GBlr/ZzPkhgG/yiuOJFhbmuRrvZ/TDbhFzbzUvp81jW1aWxqQn1XE/6lNw==
X-Received: by 2002:a05:600c:b42:b0:3fe:1fd9:bedf with SMTP id k2-20020a05600c0b4200b003fe1fd9bedfmr18992148wmr.11.1693179136213;
        Sun, 27 Aug 2023 16:32:16 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm12220395wmk.2.2023.08.27.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:32:15 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 2/7] sched/pelt: Add a new function to approximate runtime to reach given util
Date:   Mon, 28 Aug 2023 00:31:58 +0100
Message-Id: <20230827233203.1315953-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
References: <20230827233203.1315953-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is basically the ramp-up time from 0 to a given value. Will be used
later to implement new tunable to control response time  for schedutil.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 50322005a0ae..f673b9ab92dc 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 
 	return sa.util_avg;
 }
+
+/*
+ * Approximate the required amount of runtime in ms required to reach @util.
+ */
+u64 approximate_runtime(unsigned long util)
+{
+	struct sched_avg sa = {};
+	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 runtime = 0;
+
+	if (unlikely(!util))
+		return runtime;
+
+	while (sa.util_avg < util) {
+		accumulate_sum(delta, &sa, 0, 0, 1);
+		___update_load_avg(&sa, 0);
+		runtime++;
+	}
+
+	return runtime;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f76b8a75a9f..2b889ad399de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2999,6 +2999,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 struct task_struct *p);
 
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
+u64 approximate_runtime(unsigned long util);
 
 /*
  * DVFS decision are made at discrete points. If CPU stays busy, the util will
-- 
2.34.1

