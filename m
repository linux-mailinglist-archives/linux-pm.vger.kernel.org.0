Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503B5583DA6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 13:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiG1LiM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 07:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbiG1LiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 07:38:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6570D51A33
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p11so2436056lfu.5
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=usmNtICGsrCUJyolCdHCzkhV9grLDIARX51+dprqmNM=;
        b=OkkueWPc06JcsVdkqxZC0yfR7iEdAPUrSqlfEMHIfUkKHSKiwik/UQ57lPBQMSA/1I
         3MsqLOfCMH3vRS9TYfMGssNRlKMwn+HVH5WptF/ieJDysdoJvH6yufozgZ3BP5h6aSJA
         030gmIVrX6Nb6eTLTrI6dEZLG1cU6IguhhDjdxybXI2POlMmtJQ57QHCf9oQOwz10cTS
         bBnCtsZDDDjLfpQtIGzsAd9K8R3Qd0a+3EusnZBQhJBWaCFftQfTDxdxDRe9Ki3loTVe
         3mqNMEJ6uuABWfLNCIRlG8Hp5aCS2P+ClAZP7Y9ZZ5w2n2uWfisTP2Kh3hfDqnrP+J8E
         F+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usmNtICGsrCUJyolCdHCzkhV9grLDIARX51+dprqmNM=;
        b=qG/CVSPrS5NKtxiTPSlb5bmrZNM/ZQnRTWlVU/bPxLRAsDXaAxJk6FVqe0y0tUDeVR
         sPO8TJnh1KMnqrZAhrST9npggl9QBouJlFFc5Sl+5riuWIGqTbt/GXPFsZboZNU5AbWv
         NJSX30xBeRDoUAPbZuLNre3sPOK2ZUyHp2aHn4h7TEm+b/Gvndn3Rn4R9e85e3+1ap4c
         xoJ5zRgZDgESjyk6SblECEbVKqD4zeKoh74S3B+TKLrFA4OWJTwy7as9ctT0NmiL6PAB
         ZIK1wD4uQDxfuzeGNHvytpDWhBwbt+EPEsRTEJNHa3jpc8VnciEbMQWqWNmK/kEV+Drn
         v1sw==
X-Gm-Message-State: AJIora//O0kiNKhQFqtf7pts4LR2HiTjw1yE3VgWGLQVTJTF+9x6vYX1
        G4WLxU8NrUgwaDYOY09ARuHk1A==
X-Google-Smtp-Source: AGRyM1tCJEwPllfn7MIF+qaJlQLoEgmRtwNJSVZgUN4wRevjVMVDyO7oUcr2xSO1B3uwSfRb36MDFA==
X-Received: by 2002:a19:ac09:0:b0:48a:c37b:3c06 with SMTP id g9-20020a19ac09000000b0048ac37b3c06mr1234698lfc.532.1659008279789;
        Thu, 28 Jul 2022 04:37:59 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:37:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v2 05/11] soc: qcom: icc-bwmon: clear all registers on init
Date:   Thu, 28 Jul 2022 13:37:42 +0200
Message-Id: <20220728113748.170548-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
References: <20220728113748.170548-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The hardware programming guide recommends to clear all registers on
first initialization, through separate field in BWMON_CLEAR register.

This makes sense in general but especially if driver is rebound to avoid
spurious/early interrupts.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index a820855e85b4..d2df8feff651 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -50,6 +50,7 @@
 
 #define BWMON_CLEAR				0x2a4
 #define BWMON_CLEAR_CLEAR			BIT(0)
+#define BWMON_CLEAR_CLEAR_ALL			BIT(1)
 
 #define BWMON_SAMPLE_WINDOW			0x2a8
 #define BWMON_THRESHOLD_HIGH			0x2ac
@@ -127,8 +128,12 @@ struct icc_bwmon {
 	unsigned int current_kbps;
 };
 
-static void bwmon_clear_counters(struct icc_bwmon *bwmon)
+static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 {
+	unsigned int val = BWMON_CLEAR_CLEAR;
+
+	if (clear_all)
+		val |= BWMON_CLEAR_CLEAR_ALL;
 	/*
 	 * Clear counters. The order and barriers are
 	 * important. Quoting downstream Qualcomm msm-4.9 tree:
@@ -137,7 +142,7 @@ static void bwmon_clear_counters(struct icc_bwmon *bwmon)
 	 * region. So, we need to make sure the counter clear is completed
 	 * before we try to clear the IRQ or do any other counter operations.
 	 */
-	writel(BWMON_CLEAR_CLEAR, bwmon->base + BWMON_CLEAR);
+	writel(val, bwmon->base + BWMON_CLEAR);
 }
 
 static void bwmon_clear_irq(struct icc_bwmon *bwmon)
@@ -208,7 +213,7 @@ static void bwmon_start(struct icc_bwmon *bwmon)
 	unsigned int thres_count;
 	int window;
 
-	bwmon_clear_counters(bwmon);
+	bwmon_clear_counters(bwmon, true);
 
 	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
 	/* Maximum sampling window: 0xfffff */
@@ -304,7 +309,7 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
 	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH, up_kbps);
 	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED, down_kbps);
 	/* Write barriers in bwmon_clear_counters() */
-	bwmon_clear_counters(bwmon);
+	bwmon_clear_counters(bwmon, false);
 	bwmon_clear_irq(bwmon);
 	bwmon_enable(bwmon, irq_enable);
 
-- 
2.34.1

