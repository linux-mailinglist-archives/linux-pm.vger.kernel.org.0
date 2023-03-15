Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570496BBA2A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCOQtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 12:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjCOQtQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 12:49:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7752B5980E
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 09:49:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ek18so46892453edb.6
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678898953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MDMGCcobqwi/a1l36yEQFELeDyhrLe4cYbKsHJruU0=;
        b=Jue10VCE7pDR/X9n255Txry2emurXDGYizex363AJ1dlTCcwKfWx/POZeXjLPpi44P
         le8JKKoxhZrZcv8PCtAn0yA4ppGgEhv1s5Pe8OZY3NeWH15o1tXl0UIwAWXF7b5YhyL6
         31A45AdfR30DFSfFXb8ncHVu2U57qPdy+udRDHWgMdLjdyyfm/nx+1YYSbww60UuXKQN
         m1dLTkS3NWkbJOnFpDng10ymPi3HlsReR1tud1HxvJX5L/VkpoYnrEb73lvl6VNY3qEt
         DvAojHfEYviiPRqzndrxvkruoWTltwUNGEGlXskulg0k1IDFYB7Ikiw1Pf3FejxqRork
         OnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MDMGCcobqwi/a1l36yEQFELeDyhrLe4cYbKsHJruU0=;
        b=YX9ZC1PI0Pv3t/9iU54BxaYCZ0q+XDmICx5MaCZNzgA4tmICPL8FoMKnC40xvkEHjx
         /fGlgZT5+cz1FsThkK+TMVViRuru28xM6skDYfSSQmiQicS5BYZ91DghlX3eGanHyBHz
         5FTmvK6J7XK1UT7BiG+zsBec8NMLv2mdFD5OhRZHqkjlBnzFfeDmmf/nDIqr/JKOSuEe
         SpAijfEnynLgaIPO2g5U30xqPfuRBbijkpFnbvCWfI2ptOhLvIV1B6tp31cwDOA946ij
         dXf1AzV5u1mk7FqOjJ3BoJ49ld1ihmD2PrFu4jVHOm8JTviDntP516zfYn8UqocafVmt
         grVA==
X-Gm-Message-State: AO0yUKUolp4EjhBTdCFdc5XpNROrX68HMmegkIoYV9fPSS2UaxRh8gbe
        5Zo/PWSy/+37n4DqtCTlcUhtRg==
X-Google-Smtp-Source: AK7set/rJ5tb8Yd5Dgalq9MKDJHRISIAqLP7XW1qLne7XCFLEiRjRePOazibNExw7HNsa9vzJiJq0g==
X-Received: by 2002:a17:906:facf:b0:8f4:809e:faee with SMTP id lu15-20020a170906facf00b008f4809efaeemr58817ejb.19.1678898952955;
        Wed, 15 Mar 2023 09:49:12 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906068a00b008e3bf17fb2asm2786972ejb.19.2023.03.15.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:49:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on other CPU for PREEMPT_RT
Date:   Wed, 15 Mar 2023 17:49:10 +0100
Message-Id: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qualcomm cpufreq driver configures interrupts with affinity to each
cluster, e.g.  dcvsh-irq-0, dcvsh-irq-4 and dcvsh-irq-7 on SM8250.
Triggered interrupt will schedule delayed work, but, since workqueue
prefers local CPUs, it might get executed on a CPU dedicated to realtime
tasks causing unexpected latencies in realtime workload.

Use unbound workqueue for such case.  This might come with performance
or energy penalty, e.g. because of cache miss or when other CPU is
sleeping.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 2f581d2d617d..c5ff8d25fabb 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -390,7 +390,16 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
 
 	/* Disable interrupt and enable polling */
 	disable_irq_nosync(c_data->throttle_irq);
-	schedule_delayed_work(&c_data->throttle_work, 0);
+
+	/*
+	 * Workqueue prefers local CPUs and since interrupts have set affinity,
+	 * the work might execute on a CPU dedicated to realtime tasks.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		queue_delayed_work_on(WORK_CPU_UNBOUND, system_unbound_wq,
+				      &c_data->throttle_work, 0);
+	else
+		schedule_delayed_work(&c_data->throttle_work, 0);
 
 	if (qcom_cpufreq.soc_data->reg_intr_clr)
 		writel_relaxed(GT_IRQ_STATUS,
-- 
2.34.1

