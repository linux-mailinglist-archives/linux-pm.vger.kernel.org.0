Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D88782015
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 23:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjHTVIW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 17:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjHTVIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 17:08:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362EC49CB
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 14:08:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso778488f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Aug 2023 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692565687; x=1693170487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3gpb+XmkO3kHE5m1LvhKTjxDnutMdnBN1ptIU0mlos=;
        b=Vx7ub+UEHibwSm58rblsz2lbfLZYMFzAFCYEr4wy10Ysmns2ib1N5rU/Vo3rQ2V3LD
         Jcei/nJED5cDuWTudsVY9OR8FbJf80QsAktDBH/K/k6J/cyfMIDSDKR3eOUL6T9INIgz
         aG7BNn5GZaV6HIpyUVtt3glePhkW9IkK+M9Uqt/1W8oXsIU+RNmNdZgxxoloso8UaQx7
         WUoGHXBYpXunJrf8zmDxjPSdhdiIpHj6Psg2/oTF2+ix7r1celKs0Ujtd7ApQqrp7L+e
         8HaQA0QUuZy0ndUvkdEWzE/ziXX7wNq41QeL9uD43h1zi50LHDC1iVZ/mmZ4bV2qXYAN
         eR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565687; x=1693170487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3gpb+XmkO3kHE5m1LvhKTjxDnutMdnBN1ptIU0mlos=;
        b=a7h/E4GXjGpjvg1JcfP0xNC1/xCcEewMWBpAcJgdEzLpNVe1xSq/WcUZEWmNokDw+V
         iRQTSmd6JqDtVM7pUtiCf6VbNBz8Yv/Id6NLwOvzajwT4GZfDgkXz8nMmbyy+vcacpaV
         M3xnSn2V5tgJqnu85GWbJCh2vMC2PKOVcQLs4c7UmDxj6+KcSTIfyAG+bN2Z8iazQrFq
         1KGlc+OnyR0Pn6Q/O8ZhPbXg5WQxYGeQaUZxNDSJUmIezjaX1dJVqBVmntuDErKZmuzh
         WzHQZ+ie9kg83wYTTioJsCVS5WlYy47jia473WDu5qGnTFsGM9EuNBtp8b+xSYLwldVW
         80KQ==
X-Gm-Message-State: AOJu0Yx3fXyfS6AymuB1KlsfMsMiVoKIzz/IR0POCw8Y00oon1gIuIKT
        Z9n18wO158jjty2CZ30qhfDbdA==
X-Google-Smtp-Source: AGHT+IGfJM4ptG529Qy8vK3PBDRC2tNg/jFwDG2NVh2mgUavtRwvq099OxDsEoWdWeDZdcMPOsCn7Q==
X-Received: by 2002:a5d:498e:0:b0:31a:e3df:f719 with SMTP id r14-20020a5d498e000000b0031ae3dff719mr3327502wrq.17.1692565686660;
        Sun, 20 Aug 2023 14:08:06 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id j6-20020adfea46000000b003197a4b0f68sm10336800wrn.7.2023.08.20.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:08:06 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH RFC 4/4] sched: cpufreq: Apply DVFS headroom to CFS only
Date:   Sun, 20 Aug 2023 22:06:40 +0100
Message-Id: <20230820210640.585311-5-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820210640.585311-1-qyousef@layalina.io>
References: <20230820210640.585311-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RT and Deadline have exact performance requirement when running. RT runs
at max or a specific OPP defined by uclamp_min. Deadline's OPP is
defined by its bandwidth. Both of which are known ahead of time and
don't require a headroom to grow into.

IRQs on the other hand have no specific performance requirement and
cruises along at whatever the current OPP happens to be when they occur.

Now they all have PELT pressure signals that does impact frequency
selection and task placement. The question is do they need DVFS
headroom?

I think the answer is no because when CFS is not running at all, these
pressure signal has no real impact on performance for RT, DL or IRQ.

If CFS util is not zero, we already add their pressure as an
*additional* headroom to account for the lost/stolen time. So I argue
that the pressure are headroom themselves and shouldn't need an
additional DVFS headroom applied on top.

In summary final outcome should be:

	CFS + DVFS headroom + (RT, DT, IRQ) pressure headroom

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 441d433c83cd..602e369753a3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7438,10 +7438,11 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * When there are no CFS RUNNABLE tasks, clamps are released and
 	 * frequency will be gracefully reduced with the utilization decay.
 	 */
-	util = util_cfs + cpu_util_rt(rq);
 	if (type == FREQUENCY_UTIL) {
-		util = apply_dvfs_headroom(util);
+		util = apply_dvfs_headroom(util_cfs) + cpu_util_rt(rq);
 		util = uclamp_rq_util_with(rq, util, p);
+	} else {
+		util = util_cfs + cpu_util_rt(rq);
 	}
 
 	dl_util = cpu_util_dl(rq);
@@ -7473,12 +7474,9 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 *              max - irq
 	 *   U' = irq + --------- * U
 	 *                 max
-	 *
-	 * We only need to apply dvfs headroom to irq part since the util part
-	 * already had it applied.
 	 */
 	util = scale_irq_capacity(util, irq, max);
-	util += type ==  FREQUENCY_UTIL ? apply_dvfs_headroom(irq) : irq;
+	util += irq;
 
 	/*
 	 * Bandwidth required by DEADLINE must always be granted while, for
@@ -7491,7 +7489,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 	 * an interface. So, we only do the latter for now.
 	 */
 	if (type == FREQUENCY_UTIL)
-		util += apply_dvfs_headroom(cpu_bw_dl(rq));
+		util += cpu_bw_dl(rq);
 
 	return min(max, util);
 }
-- 
2.34.1

