Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42493AE5D6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhFUJWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFUJWc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:22:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1EC06175F
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:20:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y21so2343410plb.4
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMx8BP4MqYPHp6/XglTQi8htgyQDCyPm2g5UMRM0MZY=;
        b=iCa0Ce9ts0oLs1Mc9I319xqPvIhFbThuzm0+AGoxvFz9bQyewJwTrt4krfZCsdkkqx
         JO+qWXwVx0iN4KfJKWFJybLmNSQNxsfTE+nQwBiYEs8I2arWPeh+G5Gib7c3gvT4q/5K
         904OQ/JWYo+pzpGkZdotKSxGhLMhlnSsiDyQr+0vcT7wtpHgV7RU6AS+Dig6V+09zkYp
         z2FAbjA8K73lHkH9LrHCID0QW2Na37AMrEhJP7x1eD9poBMPDD+/AK9/SVXopCgYYZy5
         Bz5Vq8iwJLT3MQYDRGod0IDUKhR2LiHYeU/ej8Au/8vu04VKFsNBmMHVinY6Qf46yNX9
         gwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMx8BP4MqYPHp6/XglTQi8htgyQDCyPm2g5UMRM0MZY=;
        b=LhjRxIeWqsA/yD6aUrEx3XD31iACcPf5MDZ6bvD0/5S91iy2qcka7K3mOW1qxemVW0
         wul+mS6FXMourhK6V+yWt8i4rXqlbPWQaw4u2Nmpr0EPuP99j6YUY4zahNk3AXUxt+Cw
         bMBxAv7E4zJm6AHrINEumS1akr5AAJUr5YgjyowjB1T7rsHvqIUIYCKqFaVcjIPjcNYn
         Z+vWfAWhb1PWSsxdOau34pbBZ6u66KGUHt1aByvyfvOsKom3JpsnGQMLMeznlvUz195z
         lffghhn0TVO08Mk3wlLR7gPCT5KFyKQuad54V+VoJekR5MY/TRmjru1uoRUOJC4Z6gGE
         BesQ==
X-Gm-Message-State: AOAM533i7PvWIK3CESghDyjww4mgVATR21qkPj1P5CuTSbKCIJzizTYX
        3Gsqy1IhhmT2r+rWZU+3StMzzA==
X-Google-Smtp-Source: ABdhPJzhuDmtMjVj9kZ5lFUaIFm9JahAOkD6rmg5jT5d9hhytkaKJ90FW2fH2r7D8iX8l2qz/1Fn5Q==
X-Received: by 2002:a17:90b:1881:: with SMTP id mn1mr2569667pjb.225.1624267217999;
        Mon, 21 Jun 2021 02:20:17 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id u24sm15712153pfm.200.2021.06.21.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 02:20:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] cpufreq: cppc: Pass structure instance by reference
Date:   Mon, 21 Jun 2021 14:49:35 +0530
Message-Id: <b910f89cf11f6916319f9a2fb48d9146005318b1.1624266901.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624266901.git.viresh.kumar@linaro.org>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Don't pass structure instance by value, pass it by reference instead.

Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 35b8ae66d1fb..490175d65082 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -373,18 +373,18 @@ static inline u64 get_delta(u64 t1, u64 t0)
 }
 
 static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
 	u64 reference_perf, delivered_perf;
 
-	reference_perf = fb_ctrs_t0.reference_perf;
+	reference_perf = fb_ctrs_t0->reference_perf;
 
-	delta_reference = get_delta(fb_ctrs_t1.reference,
-				    fb_ctrs_t0.reference);
-	delta_delivered = get_delta(fb_ctrs_t1.delivered,
-				    fb_ctrs_t0.delivered);
+	delta_reference = get_delta(fb_ctrs_t1->reference,
+				    fb_ctrs_t0->reference);
+	delta_delivered = get_delta(fb_ctrs_t1->delivered,
+				    fb_ctrs_t0->delivered);
 
 	/* Check to avoid divide-by zero */
 	if (delta_reference || delta_delivered)
@@ -415,7 +415,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret)
 		return ret;
 
-	return cppc_get_rate_from_fbctrs(cpu_data, fb_ctrs_t0, fb_ctrs_t1);
+	return cppc_get_rate_from_fbctrs(cpu_data, &fb_ctrs_t0, &fb_ctrs_t1);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
-- 
2.31.1.272.g89b43f80a514

