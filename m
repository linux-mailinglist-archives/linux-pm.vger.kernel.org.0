Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511B957BE83
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 21:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiGTT2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiGTT2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 15:28:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F54C616
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 12:28:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u14so14302786lju.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJsyxPtLwXGk4TqZHEX/F4px6r4RNduvB718BUsJU20=;
        b=W1yn6x6fi6foFmk38g/socXbc1At71QXP8h8QInqjmvecIimc0E8InEQuHOyQ8r7j+
         RS/G9vwxzVletl1B4EHikWci7W9Bom21XVnVzbWjQyUSqmsbRtofRW9GVel3iPTx4Red
         8MkTydZi21dUwzomv7x1nIP53v8iZYC3NxAO/l/QhTAVxBVDsXZGvcShjSVjzBZvStrh
         Ljfpor8jnmunXXVjxRv9qzORelA4Ic1Rtq+RjYHRfDlWtjEh9GwtU9o9b8Gr0iE+ZMX6
         vFoX8VJ3Ff5Ev+5IN8Ij117nCcLocAUNiseYVuCCFLmyVsI+djcgFeg5WViLOEvs2GNh
         /xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJsyxPtLwXGk4TqZHEX/F4px6r4RNduvB718BUsJU20=;
        b=NQMoas1IpVdwluE4DPF8+C89c354Su6XFy+0uHslGZrtmi4ATe82g9gWr5RIbizwWh
         bRhYQopKkmCJGBUyNozmjgjlwtRjHtnvGeUDSXSxB94agdORTgIWi8KZL9eaiuqpCT5a
         rta4quVVkllSiC0nCNh7c6eL+TjJGTq3pn8CDrI12uxKgRhO82QBIQ1K4/JDRgD2/unJ
         lrmjUCxBae2Qu+DODTZ7KYvoAZsa4bj26AlWzuyodCRIwal54rI4AYyuAYgMZwWb/dqB
         1JBrzX7Q5u3NCSock/bb85z5huCl2IDc1QLEJkFpIEhnTq1VRdcbCJMPgRd58HbA3fKx
         tqiA==
X-Gm-Message-State: AJIora+4MLjcD/wQ+SxKaF/VIRqHSgjgt6Z3U5/yUUQUeT0FUyhg/L24
        gY8PdJjtPwi98CAOZrBIGFA2h0ZB0MJ+ETDG
X-Google-Smtp-Source: AGRyM1sDSid5t3CAb16zaoRilK0yxbsp8AY5AX85ChmTnc/q3znerBRq04qHDIeyw/MTXDW2JYFvGA==
X-Received: by 2002:a2e:92c4:0:b0:25d:9d30:5d61 with SMTP id k4-20020a2e92c4000000b0025d9d305d61mr7379413ljh.202.1658345298637;
        Wed, 20 Jul 2022 12:28:18 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 05/10] soc: qcom: icc-bwmon: clear all registers on init
Date:   Wed, 20 Jul 2022 21:28:02 +0200
Message-Id: <20220720192807.130098-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
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
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 93c3cec84721..dcd445af6488 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -51,6 +51,7 @@
 
 #define BWMON_CLEAR				0x2a4
 #define BWMON_CLEAR_CLEAR			BIT(0)
+#define BWMON_CLEAR_CLEAR_ALL			BIT(1)
 
 #define BWMON_SAMPLE_WINDOW			0x2a8
 #define BWMON_THRESHOLD_HIGH			0x2ac
@@ -128,8 +129,12 @@ struct icc_bwmon {
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
@@ -138,7 +143,7 @@ static void bwmon_clear_counters(struct icc_bwmon *bwmon)
 	 * region. So, we need to make sure the counter clear is completed
 	 * before we try to clear the IRQ or do any other counter operations.
 	 */
-	writel(BWMON_CLEAR_CLEAR, bwmon->base + BWMON_CLEAR);
+	writel(val, bwmon->base + BWMON_CLEAR);
 }
 
 static void bwmon_clear_irq(struct icc_bwmon *bwmon)
@@ -209,7 +214,7 @@ static void bwmon_start(struct icc_bwmon *bwmon)
 	unsigned int thres_count;
 	int window;
 
-	bwmon_clear_counters(bwmon);
+	bwmon_clear_counters(bwmon, true);
 
 	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
 	/* Maximum sampling window: 0xfffff */
@@ -305,7 +310,7 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
 	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_HIGH, up_kbps);
 	bwmon_set_threshold(bwmon, BWMON_THRESHOLD_MED, down_kbps);
 	/* Write barriers in bwmon_clear_counters() */
-	bwmon_clear_counters(bwmon);
+	bwmon_clear_counters(bwmon, false);
 	bwmon_clear_irq(bwmon);
 	bwmon_enable(bwmon, irq_enable);
 
-- 
2.34.1

