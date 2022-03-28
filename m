Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A514E952D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Mar 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbiC1Lkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Mar 2022 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiC1Lgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2022 07:36:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3550B1BEBA
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 04:28:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bt26so24137252lfb.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alkm6GAWo2f9KK0udr6YqOnxDL3wRG7VC8zZzqw/UA0=;
        b=C5qKK5COQt2vcAc0rnvS5bZFeoWGxCzJAq7CaTUZ2pzdsH66opPE+nHoCq8cSuKk4F
         cnYHLhyt/luVE7n5FBubfWOQVCYwhoO2SpUFGEPbAzUcVcqCdVYa/JGRgd2etiYjwlSd
         kS6+BUfHW2j6DTKPUCR4RskPRlnXwtm1PuX1Rgwgjr1kuDgnywxhYgepzCJ1KzTVHT8D
         FGLgefVnDRdH+XuuyKryvaFCQllHXBdtha86k9bBW24aqXmKSTcTUqCDOnxsYFKYYlbZ
         cFLP7QfVe8bnYfLWd2g5RPr/114apDHHBuzBeZbd8SkLWvOxVEzrtlU1Zghmm0TgRxn+
         gdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alkm6GAWo2f9KK0udr6YqOnxDL3wRG7VC8zZzqw/UA0=;
        b=dgT2IVXczpVAb4a6piX7jb02uRVSJTMln4Wjo4oiG+/rrTPQjPODtSxrAKey4pOEqI
         Na85au0DVZQN2eqfBnOlCGda7/0EDHgELPzZEHwTsBlOhCqtbLZtoTOAHvZ5ZdEnqSIA
         6fpr0pv0Tl6TKSfiICg9KCLdEuhd1QbvgaIl6ry+GOGrXVc1HcCP7Zujt1IZsiGvWC5H
         G3BXTXsLLZzP+aj/06tRqBzoEW66d/DmK+QaxWfSuwlESIHwxonvffmjRMw8Bn1CTQJk
         frYRiFJ3YRoYE0i81PT8GdemvA0I4euMVQ8rQK8nnsJkCByen94MDkfP6fJQZ/xMOEhV
         /MhQ==
X-Gm-Message-State: AOAM531rlnBpEXavnGHUBcXQaW5ozf2Zwf80HaBtWwKGJthIcr3uQkcA
        fNX3Hgb+IeHuPQlkiiEwkdJqZg==
X-Google-Smtp-Source: ABdhPJzCbBGvm5ABKxgC0QMItHLeB7ll+t5pmGeZX5KAly8LAdVOG6WyvFpK9/KbNMKu93Cdw3kiIg==
X-Received: by 2002:a05:6512:689:b0:44a:3b4c:8bf3 with SMTP id t9-20020a056512068900b0044a3b4c8bf3mr19052511lfe.378.1648466920750;
        Mon, 28 Mar 2022 04:28:40 -0700 (PDT)
Received: from localhost.localdomain (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e9084000000b00244cb29e3e4sm1700373ljg.133.2022.03.28.04.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:28:40 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: qcom-cpufreq-hw: Fix throttle frequency value on EPSS platforms
Date:   Mon, 28 Mar 2022 14:28:36 +0300
Message-Id: <20220328112836.2464486-3-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220328112836.2464486-1-vladimir.zapolskiy@linaro.org>
References: <20220328112836.2464486-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On QCOM platforms with EPSS flavour of cpufreq IP a throttled frequency is
obtained from another register REG_DOMAIN_STATE, thus the helper function
qcom_lmh_get_throttle_freq() should be modified accordingly, as for now
it returns gibberish since .reg_current_vote is unset for EPSS hardware.

Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 53954e5086e0..3156d79ef39e 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -30,6 +30,7 @@
 
 struct qcom_cpufreq_soc_data {
 	u32 reg_enable;
+	u32 reg_domain_state;
 	u32 reg_dcvs_ctrl;
 	u32 reg_freq_lut;
 	u32 reg_volt_lut;
@@ -283,11 +284,16 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
-static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
+static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 {
-	unsigned int val = readl_relaxed(data->base + data->soc_data->reg_current_vote);
+	unsigned int lval;
 
-	return (val & 0x3FF) * 19200;
+	if (data->soc_data->reg_current_vote)
+		lval = readl_relaxed(data->base + data->soc_data->reg_current_vote) & 0x3ff;
+	else
+		lval = readl_relaxed(data->base + data->soc_data->reg_domain_state) & 0xff;
+
+	return lval * xo_rate;
 }
 
 static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
@@ -297,14 +303,12 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	struct device *dev = get_cpu_device(cpu);
 	unsigned long freq_hz, throttled_freq;
 	struct dev_pm_opp *opp;
-	unsigned int freq;
 
 	/*
 	 * Get the h/w throttled frequency, normalize it using the
 	 * registered opp table and use it to calculate thermal pressure.
 	 */
-	freq = qcom_lmh_get_throttle_freq(data);
-	freq_hz = freq * HZ_PER_KHZ;
+	freq_hz = qcom_lmh_get_throttle_freq(data);
 
 	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
 	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
@@ -371,6 +375,7 @@ static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 
 static const struct qcom_cpufreq_soc_data epss_soc_data = {
 	.reg_enable = 0x0,
+	.reg_domain_state = 0x20,
 	.reg_dcvs_ctrl = 0xb0,
 	.reg_freq_lut = 0x100,
 	.reg_volt_lut = 0x200,
-- 
2.33.0

