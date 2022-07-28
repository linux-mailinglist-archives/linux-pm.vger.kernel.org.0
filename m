Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020A9583D9A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiG1LiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 07:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiG1LiL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 07:38:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DF61D77
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w18so1679915lje.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4E4ZpRRBiSt4prWSjtt/tlG1ntxY2YUOQqTaH587sJs=;
        b=oUjIFxePcHOen0XvNvUfTXgAyNgPx04xpNN5Zu8/447lUmblII0dpR9lMM3ZGbjHjB
         onuLFC1nKHHJlzFsTmpRzfKcU2WjShuGVmAFsiP/Xd0RVkswfOUM9+mkxd8Ar7qaM9KQ
         RnJyj4aMGPCQh3p8dI24t0CVPDJO+W0qYiom9Wd4qj0PK/ClmHup/06fE+0igItcE+ng
         NlIXCKcTWoXWLKz9b6O0QfXBN1Wi+f3izBxx9s6wPcyUTdP2rZWFvwfIkBMLeoqaXRlJ
         A56HBtX4NYreNDxPK90mBVMgmAlXZy8JoIfp6cph56RSvPOzQ68avWke3uY+9NdyhHI2
         HD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4E4ZpRRBiSt4prWSjtt/tlG1ntxY2YUOQqTaH587sJs=;
        b=bl1UPS9MK8iPCSoQbP/X2k5svD1uk/VM5eUScC/DusZMljD6Wm45yVaKA/V2UOvrsJ
         HN9DcfwJg5aS11Q+HHNnhU1wLf1ywG0e9QbvAk+2fTz9DVlIWdTSGuZt6p5WnFIcVc0l
         5MnMco7ATfSkEPNP9fz3X2yQqgn0E3oxiUnq/mh5Y2S5p2C7QRonxABmDowN7leXIizT
         ZlgMA/MzSAi7NOGFcjFxZZo/TsdvTn4o/SnBEYPU65uUUJTb/ifn5qfyE0JSEJEDOXDj
         H6bPgOyamHI1B9uRzGUJO1nJiM7euHsP8+uMjE3gvvyAd7tQaJLbgj622ggdrDIG751C
         Lwqw==
X-Gm-Message-State: AJIora/LHFd1pUO3B+UvQ3m8W0wWyh71thhm8Ej2DLt7hA38VJ1Kgyy5
        4HYtk9bQTFXz1DKy2/dKXfNjHA==
X-Google-Smtp-Source: AGRyM1uiCsF2TKehRmM8girZmFexYc7sCS4vIAS3JTbG+VrAcScxFzqVRIC3/APBu/7f5gLiBPzUkw==
X-Received: by 2002:a2e:5746:0:b0:25e:2da3:e244 with SMTP id r6-20020a2e5746000000b0025e2da3e244mr760737ljd.297.1659008281258;
        Thu, 28 Jul 2022 04:38:01 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id l12-20020a2ea80c000000b0025e0396786dsm98192ljq.93.2022.07.28.04.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:38:00 -0700 (PDT)
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
Subject: [PATCH v2 06/11] soc: qcom: icc-bwmon: store count unit per variant
Date:   Thu, 28 Jul 2022 13:37:43 +0200
Message-Id: <20220728113748.170548-7-krzysztof.kozlowski@linaro.org>
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

Versions v4 and v5 of BWMON on SDM845 use different unit count, so allow
easier variant customization by storing its value in struct
icc_bwmon_data.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/soc/qcom/icc-bwmon.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index d2df8feff651..7fd0e41c63e6 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -103,12 +103,11 @@
 #define BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT	0xff
 #define BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT	0xff
 
-/* BWMONv4 count registers use count unit of 64 kB */
-#define BWMON_COUNT_UNIT_KB			64
 #define BWMON_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
 
 struct icc_bwmon_data {
 	unsigned int sample_ms;
+	unsigned int count_unit_kb; /* kbytes */
 	unsigned int default_highbw_kbps;
 	unsigned int default_medbw_kbps;
 	unsigned int default_lowbw_kbps;
@@ -192,9 +191,10 @@ static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
 	writel(BWMON_ENABLE_ENABLE, bwmon->base + BWMON_ENABLE);
 }
 
-static unsigned int bwmon_kbps_to_count(unsigned int kbps)
+static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon,
+					unsigned int kbps)
 {
-	return kbps / BWMON_COUNT_UNIT_KB;
+	return kbps / bwmon->data->count_unit_kb;
 }
 
 static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
@@ -202,8 +202,8 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
 {
 	unsigned int thres;
 
-	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->data->sample_ms,
-			  MSEC_PER_SEC);
+	thres = mult_frac(bwmon_kbps_to_count(bwmon, kbps),
+			  bwmon->data->sample_ms, MSEC_PER_SEC);
 	writel_relaxed(thres, bwmon->base + reg);
 }
 
@@ -269,7 +269,7 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 	 * downstream) always increments the max bytes count by one.
 	 */
 	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
-	max *= BWMON_COUNT_UNIT_KB;
+	max *= bwmon->data->count_unit_kb;
 	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
 
 	return IRQ_WAKE_THREAD;
@@ -393,6 +393,7 @@ static int bwmon_remove(struct platform_device *pdev)
 /* BWMON v4 */
 static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.sample_ms = 4,
+	.count_unit_kb = 64,
 	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
 	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
 	.default_lowbw_kbps = 0,
-- 
2.34.1

