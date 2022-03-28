Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517224E952A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Mar 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbiC1Lkp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Mar 2022 07:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbiC1Lgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2022 07:36:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8A1B7BE
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 04:28:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v12so6002198ljd.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2022 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqC0e531L2oE8lVZ9RPbtihhwJCblxRCd+3d5T+LwAM=;
        b=bi8vMXjpWb85/xAiYFFW184SrT+Y0+2k/83nA1jENRc25mVqg35kt+1XamnkVUzPeg
         XkCry2svN2ZYYfJE1nlP1qOLgtbUpIgU8sO6kDcLQ862bpV1Kyq1+0moCQ6My+SL0kNh
         fvwNI+1BbfM2MOtZ+EV8QleMZNIc3TNS20otLPVzEeomsU2gvhjb5Hlai81sGdAKPzNY
         bx4FWRfwd4XEiMTZCWXWkn81HjmH0DPOalQEVrlYZDHwzsJ2eW5OPQ4cT9PLXYG86nSl
         7BVJNfUZ240RqHGOmFAx6mkzAcDkSw5GK8yyYlS2ki2keoNiwrztLlLh+1QVZnPfDV/D
         2nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqC0e531L2oE8lVZ9RPbtihhwJCblxRCd+3d5T+LwAM=;
        b=2M8tUmmkrJ++xRf05ngBXk/BSsCAR0m12jtQrJn4cw11q08epltBOcaR8gJ0fUR37Y
         6pnuRtPJ/sst3HgvWGNPE1ZdmwNETSWJ/Rl1A0nfC8pwG/JO5ta6w3hiXFAu84jyOHAO
         lxHCBiTSRiCXJIndH2XUyOQmFmbWdHQdqioqofLe8mncgCZnpX05cPOpEhb9pUiEk6zx
         PzbLjCm54KCZjSQP4A70wfNjCfpojqVqzCvxsdLSWE2G4WxZENGq1VjVzdH9WxNZTwrf
         DNhWsKBuKzz+h4/s0THIJ30ZT1VxLRGWfcCYV9We+L4+YnhF3cNQdPGjk38Os4Sn/Dg9
         36Pw==
X-Gm-Message-State: AOAM531TsgXcfyPG/jbGtp4tp4Pus6NPCEyxXoU13rUKZWdb80GAvu2A
        BxlTztJ5l2IDrRVTC6WXpIUMUw==
X-Google-Smtp-Source: ABdhPJwLtTtiRnhC0K0MvgbO/+aBvmZouclJpqqyhRPLuMc6LkV9jd/xogStAePBfvXKPRigSk4dPA==
X-Received: by 2002:a2e:8542:0:b0:24a:c21e:dfe with SMTP id u2-20020a2e8542000000b0024ac21e0dfemr10622965ljj.154.1648466919978;
        Mon, 28 Mar 2022 04:28:39 -0700 (PDT)
Received: from localhost.localdomain (88-113-46-102.elisa-laajakaista.fi. [88.113.46.102])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e9084000000b00244cb29e3e4sm1700373ljg.133.2022.03.28.04.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:28:39 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: qcom-cpufreq-hw: Clear dcvs interrupts
Date:   Mon, 28 Mar 2022 14:28:35 +0300
Message-Id: <20220328112836.2464486-2-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220328112836.2464486-1-vladimir.zapolskiy@linaro.org>
References: <20220328112836.2464486-1-vladimir.zapolskiy@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's noted that dcvs interrupts are not self-clearing, thus an interrupt
handler runs constantly, which leads to a severe regression in runtime.
To fix the problem an explicit write to clear interrupt register is
required.

Fixes: 275157b367f4 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f9d593ff4718..53954e5086e0 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -24,6 +24,8 @@
 #define CLK_HW_DIV			2
 #define LUT_TURBO_IND			1
 
+#define GT_IRQ_STATUS			BIT(2)
+
 #define HZ_PER_KHZ			1000
 
 struct qcom_cpufreq_soc_data {
@@ -31,6 +33,7 @@ struct qcom_cpufreq_soc_data {
 	u32 reg_dcvs_ctrl;
 	u32 reg_freq_lut;
 	u32 reg_volt_lut;
+	u32 reg_intr_clr;
 	u32 reg_current_vote;
 	u32 reg_perf_state;
 	u8 lut_row_size;
@@ -350,6 +353,9 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
 	disable_irq_nosync(c_data->throttle_irq);
 	schedule_delayed_work(&c_data->throttle_work, 0);
 
+	writel_relaxed(GT_IRQ_STATUS,
+		       c_data->base + c_data->soc_data->reg_intr_clr);
+
 	return IRQ_HANDLED;
 }
 
@@ -368,6 +374,7 @@ static const struct qcom_cpufreq_soc_data epss_soc_data = {
 	.reg_dcvs_ctrl = 0xb0,
 	.reg_freq_lut = 0x100,
 	.reg_volt_lut = 0x200,
+	.reg_intr_clr = 0x308,
 	.reg_perf_state = 0x320,
 	.lut_row_size = 4,
 };
-- 
2.33.0

