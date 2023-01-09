Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6BB661B7B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jan 2023 01:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjAIA3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Jan 2023 19:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjAIA3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2023 19:29:45 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056AE0D7
        for <linux-pm@vger.kernel.org>; Sun,  8 Jan 2023 16:29:44 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f20so7358586lja.4
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2023 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNfbSTvzTfUVFclyKhJFzlWhnbUuUQRODnFghZoCEPo=;
        b=jBKzdXs0VnLPU9YZTTES69mZckW3XDAqBr7odWmWK5Zi6w8hNzKtFv+hQwT/o7OvCg
         +r0JKTmrxwYa2Jp/s7D0b82w86nugvzmzENcJAWFex60QPBqEuMa3mQ+hLKdHLkx3OtQ
         Nk8n8J4f4aWzQzE3Lxe9za/CuZWO2YnTmpDmh9vuip7geyYUJxi5fVPt2PK7Bb7OVCMP
         WR+LMsfbCkKj9vrzYVzHsZ2r2kZ1LqVAQ0Z9t3wU+AaiTs7DXoJiWp8KwST6lnrDwgSi
         gAQya8QRqTFgrljn4cxHFe9o06JpnyWO6i+obeyY/qeFyWVttA4l2PcuR/ppi8ZOVxmT
         FVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNfbSTvzTfUVFclyKhJFzlWhnbUuUQRODnFghZoCEPo=;
        b=e142gF3TF1sWE7xZp9ke5HmHikEATT2LR3J9lDwu/7Vf0ETDXtaokt1rOYHwa5UAFy
         lb6BvtgaPqPf553iXrwK/RDiIZNv1qAiv0fEgn/XCpR/3Qgyf/8FVu5GcrPyH2yM94GF
         oaghvFcfH64yCdh69H4iwAoNCnrx27psoWySQUrzapCAcxTlcdZa4pgWVBx+m0pWz2oy
         MtwjNcSmHTuRUkUtxRyh7PqmozJO4rjcEGJ50yzgaXR1PPcety0KcJq3rTsFZDj0Skqd
         OicUM71UpvDzhjXbijkcvwp2UsyIY6t43Il+pZ9oQI+5rL9Fldr2bnGkJHyeqKZis3+g
         MBeA==
X-Gm-Message-State: AFqh2krVomquo+FMePtxCdbCawPHvBr7Du3zi3hkejrIUPCzYo1kEYjV
        v4Evez2ujpSJB65xQZa0+8arbg==
X-Google-Smtp-Source: AMrXdXtWNsOLwQ0K+KEB9I9ht61JYV078jCBg8XTAOLjgL1cwgtPsFNY+9RyBsOM4jukPJ0S5Rp2lw==
X-Received: by 2002:a2e:9d45:0:b0:27f:e221:2930 with SMTP id y5-20020a2e9d45000000b0027fe2212930mr7559084ljj.35.1673224184222;
        Sun, 08 Jan 2023 16:29:44 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e9816000000b0027fc54f8bf0sm706626ljj.35.2023.01.08.16.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 16:29:43 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Alex Elder <elder@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 09/12] dt-bindings: interconnect: qcom: drop IPA_CORE related defines
Date:   Mon,  9 Jan 2023 02:29:32 +0200
Message-Id: <20230109002935.244320-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
References: <20230109002935.244320-1-dmitry.baryshkov@linaro.org>
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

These interconnects are modeled as clks, not interconnects, therefore
remove corresponding defines from the binding as they're unused.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/dt-bindings/interconnect/qcom,sc7180.h   | 3 ---
 include/dt-bindings/interconnect/qcom,sc8180x.h  | 3 ---
 include/dt-bindings/interconnect/qcom,sc8280xp.h | 4 ++--
 include/dt-bindings/interconnect/qcom,sdx55.h    | 2 --
 include/dt-bindings/interconnect/qcom,sm8150.h   | 3 ---
 include/dt-bindings/interconnect/qcom,sm8250.h   | 3 ---
 6 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/dt-bindings/interconnect/qcom,sc7180.h b/include/dt-bindings/interconnect/qcom,sc7180.h
index f9970f6032eb..de5d5867bd67 100644
--- a/include/dt-bindings/interconnect/qcom,sc7180.h
+++ b/include/dt-bindings/interconnect/qcom,sc7180.h
@@ -108,9 +108,6 @@
 #define SLAVE_LLCC			11
 #define SLAVE_SERVICE_GEM_NOC			12
 
-#define MASTER_IPA_CORE			0
-#define SLAVE_IPA_CORE			1
-
 #define MASTER_LLCC			0
 #define SLAVE_EBI1			1
 
diff --git a/include/dt-bindings/interconnect/qcom,sc8180x.h b/include/dt-bindings/interconnect/qcom,sc8180x.h
index e84cfec5afdd..0bdc8d6cb401 100644
--- a/include/dt-bindings/interconnect/qcom,sc8180x.h
+++ b/include/dt-bindings/interconnect/qcom,sc8180x.h
@@ -129,9 +129,6 @@
 #define SLAVE_SERVICE_GEM_NOC			16
 #define SLAVE_SERVICE_GEM_NOC_1			17
 
-#define MASTER_IPA_CORE				0
-#define SLAVE_IPA_CORE				1
-
 #define MASTER_LLCC				0
 #define SLAVE_EBI_CH0				1
 
diff --git a/include/dt-bindings/interconnect/qcom,sc8280xp.h b/include/dt-bindings/interconnect/qcom,sc8280xp.h
index a3e5fda7c127..f89f47e99c6d 100644
--- a/include/dt-bindings/interconnect/qcom,sc8280xp.h
+++ b/include/dt-bindings/interconnect/qcom,sc8280xp.h
@@ -48,11 +48,11 @@
 #define SLAVE_SERVICE_A2NOC		19
 
 /* clk_virt */
-#define MASTER_IPA_CORE			0
+/* 0 was used by MASTER_IPA_CORE, now represented as RPMh clock */
 #define MASTER_QUP_CORE_0		1
 #define MASTER_QUP_CORE_1		2
 #define MASTER_QUP_CORE_2		3
-#define SLAVE_IPA_CORE			4
+/* 4 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
 #define SLAVE_QUP_CORE_0		5
 #define SLAVE_QUP_CORE_1		6
 #define SLAVE_QUP_CORE_2		7
diff --git a/include/dt-bindings/interconnect/qcom,sdx55.h b/include/dt-bindings/interconnect/qcom,sdx55.h
index bfb6524a2d90..1925f0784ab2 100644
--- a/include/dt-bindings/interconnect/qcom,sdx55.h
+++ b/include/dt-bindings/interconnect/qcom,sdx55.h
@@ -70,7 +70,5 @@
 #define SLAVE_QDSS_STM			48
 #define SLAVE_TCU			49
 
-#define MASTER_IPA_CORE			0
-#define SLAVE_IPA_CORE			1
 
 #endif
diff --git a/include/dt-bindings/interconnect/qcom,sm8150.h b/include/dt-bindings/interconnect/qcom,sm8150.h
index a25684680c42..ef292791f52e 100644
--- a/include/dt-bindings/interconnect/qcom,sm8150.h
+++ b/include/dt-bindings/interconnect/qcom,sm8150.h
@@ -121,9 +121,6 @@
 #define SLAVE_LLCC			15
 #define SLAVE_SERVICE_GEM_NOC		16
 
-#define MASTER_IPA_CORE			0
-#define SLAVE_IPA_CORE			1
-
 #define MASTER_LLCC			0
 #define SLAVE_EBI_CH0			1
 
diff --git a/include/dt-bindings/interconnect/qcom,sm8250.h b/include/dt-bindings/interconnect/qcom,sm8250.h
index 1b4d9fbe888d..a4af5cc19271 100644
--- a/include/dt-bindings/interconnect/qcom,sm8250.h
+++ b/include/dt-bindings/interconnect/qcom,sm8250.h
@@ -115,9 +115,6 @@
 #define SLAVE_SERVICE_GEM_NOC_2		15
 #define SLAVE_SERVICE_GEM_NOC		16
 
-#define MASTER_IPA_CORE			0
-#define SLAVE_IPA_CORE			1
-
 #define MASTER_LLCC			0
 #define SLAVE_EBI_CH0			1
 
-- 
2.39.0

