Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3457BE81
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiGTT2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiGTT2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 15:28:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4BF4AD7D
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 12:28:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a9so31912146lfk.11
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utKhEvxkkiNmRPoQss7Z3vkBr7gzz6DZWSvtk4VHQN4=;
        b=i7akPaplPaLIgeeZbJXpfed/+tkF/OPqIGRDZxI+IdxIu6ma8CJ8i5eMIowfOpt163
         /SYsH5VrGwSVM/E/3ouwfh6d2yB396y2ZlTmbJfKT+Q7w5pZe+LEuF+2HyReC0a2y+PQ
         U+Z6mIhfgmXIlKQ1MZRMtg/r6d1J7buc7EI3/rbFc3Uafme0oVgyTSaehuXnn+XnjGR5
         E5t6jV3OeRDeT/fQvZZ5hMnJheD+WsQ6lCKsI/g8mUT5bmiZBp9Pp1JDq/Ou9ViTJR7K
         7GVGU/kBIxNQf6/TkJX+4AGkestxxmSnsVvHQKpW+Axnv7WMnBhRIWPcxa7riCum1SPx
         gEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utKhEvxkkiNmRPoQss7Z3vkBr7gzz6DZWSvtk4VHQN4=;
        b=ziSBp8oLHqfhMSTidn3ltP49Fc2cmJyNHtSIe+zs4fhbUnKm1Xc1Uhf1B0nnC23c4V
         qhXsGxIDtvfA22XtJO4pzIBGawtJTIeZbvThzVDC6Be2+Lg8EQlBlCVQxLPzJb73JUwg
         moMybCwOOO25Tfl2GNebrLQyg5GlA+/auYaAYk8QtrtcgUfAY9dkYQnV/6inrzSrLhEa
         ORv97Lg3sUwL+YS6bH9QBiPoi6tTmZbm+QIDmrzJZA216PztPFmu6s0VpgWWBHfeSAwp
         O5IraUQBhFw2iLrC21CUvpXj4k6dQbta0Rj2qiTVkVvLt0ahn+83VG5i4ogUI1rrj3fW
         vyTQ==
X-Gm-Message-State: AJIora/VK7zRtEdi4CvbS5TT9p3uYtU9LzDLyUAkSdCp78fz/gpq03Ja
        jHdCTNSHuBlURe6jjsFoEJ4A9Q==
X-Google-Smtp-Source: AGRyM1vtLkEHRRsjGiqgjkAQYKwaIAM72EovJibQc1clcjeVb8HEE9Wibchgqj/SOnVFGtr/NS8Pyw==
X-Received: by 2002:a05:6512:220d:b0:488:c3ba:acc4 with SMTP id h13-20020a056512220d00b00488c3baacc4mr21640439lfu.196.1658345299856;
        Wed, 20 Jul 2022 12:28:19 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:19 -0700 (PDT)
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
Subject: [PATCH 06/10] soc: qcom: icc-bwmon: store count unit per variant
Date:   Wed, 20 Jul 2022 21:28:03 +0200
Message-Id: <20220720192807.130098-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Versions v4 and v5 of BWMON on SDM845 use different unit count, so allow
easier variant customization by storing its value in struct
icc_bwmon_data.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index dcd445af6488..9a99e0fd1140 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -104,12 +104,11 @@
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
@@ -193,9 +192,10 @@ static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
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
@@ -203,8 +203,8 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon, unsigned int reg,
 {
 	unsigned int thres;
 
-	thres = mult_frac(bwmon_kbps_to_count(kbps), bwmon->data->sample_ms,
-			  MSEC_PER_SEC);
+	thres = mult_frac(bwmon_kbps_to_count(bwmon, kbps),
+			  bwmon->data->sample_ms, MSEC_PER_SEC);
 	writel_relaxed(thres, bwmon->base + reg);
 }
 
@@ -270,7 +270,7 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 	 * downstream) always increments the max bytes count by one.
 	 */
 	max = readl(bwmon->base + BWMON_ZONE_MAX(zone)) + 1;
-	max *= BWMON_COUNT_UNIT_KB;
+	max *= bwmon->data->count_unit_kb;
 	bwmon->target_kbps = mult_frac(max, MSEC_PER_SEC, bwmon->data->sample_ms);
 
 	return IRQ_WAKE_THREAD;
@@ -394,6 +394,7 @@ static int bwmon_remove(struct platform_device *pdev)
 /* BWMON v4 */
 static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.sample_ms = 4,
+	.count_unit_kb = 64,
 	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
 	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
 	.default_lowbw_kbps = 0,
-- 
2.34.1

