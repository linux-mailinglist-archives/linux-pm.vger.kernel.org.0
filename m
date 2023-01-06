Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C56607CC
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 21:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjAFULL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 15:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbjAFUKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 15:10:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B884091
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 12:10:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so3540800lfr.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNfbSTvzTfUVFclyKhJFzlWhnbUuUQRODnFghZoCEPo=;
        b=Cpp6PbMszA8NXM5V/FLNTCCIQXOF4qxKXSNkgNa3UGHvtKFCDn5IirMlYMsVIEOu65
         H0tQVJDVNY098LztdISe2BOZSbt/QtQTdjmd7t5aXUqV29HHRHY3lzOjw54z6i91RiJ/
         g9VCOC1H+X1PdAFShPV4VYBBa6cmXHyAM76wa0IkewynxFrCdi5uV5CfaLbjLbuF1cB5
         /box2ubN7qCIkd4i2ilqu/EoC40FLVHACdgi8ew8mAFIJTZ5RXYJro5KO7pHTv3i4Ge0
         p+w86uDcXDYKxWb5GkuNoYTI2LVDrozT3CEPyvJJuNC+KNyhPy8+h1uG1ajDSJtr3eqS
         H7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNfbSTvzTfUVFclyKhJFzlWhnbUuUQRODnFghZoCEPo=;
        b=Xn+KLqoZDPewxTbPX3QIumQyhbxMAtYYsMaqwuBwAqV2vzsKs/7moEqwnPHr2fy2ZS
         G/7njotay5WhzcQa6QfahIwl1vsJCK5moEVMQUw20jIIIElQwXPsUKI0Ne4z1CodTebf
         2beRBbTxOXkfygJEemD5RBtPS1bj7txc3lPk52F9oa/8vPf5k3xCd4U7w/BKylFlcYq9
         Zuls/JOGKyD/2HJqxpdwWCAHShvpc1zMIzAm2HqssYJ2HBZOKScDcM5wqVvxt5Kld0YK
         MniDvZqc0BPTFph6lMROb1EiwaiTvRsqBbSWHkgFLx6/VdSb5pG9snupzneSmJSNFDpq
         +2Xg==
X-Gm-Message-State: AFqh2koudA2TvcHXIMuYywYK7CowMyvatk2nxHfdYENUStDO8A3EV8tJ
        9F0pqA+rqeoI7AqY7U+8Ow17xA==
X-Google-Smtp-Source: AMrXdXsbIEOaQ8RJqoa/0MDJoGWyAGE8fp7cvabmZUzh1NpaqhqNy6xl1fjDhBv+R9LMhccbKbt7mQ==
X-Received: by 2002:a05:6512:224d:b0:4b4:b5d3:6603 with SMTP id i13-20020a056512224d00b004b4b5d36603mr25635114lfu.32.1673035837373;
        Fri, 06 Jan 2023 12:10:37 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f14-20020a0565123b0e00b004b7033da2d7sm260875lfv.128.2023.01.06.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:10:36 -0800 (PST)
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
Subject: [PATCH v2 08/11] dt-bindings: interconnect: qcom: drop IPA_CORE related defines
Date:   Fri,  6 Jan 2023 22:10:25 +0200
Message-Id: <20230106201028.1809541-9-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106201028.1809541-1-dmitry.baryshkov@linaro.org>
References: <20230106201028.1809541-1-dmitry.baryshkov@linaro.org>
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

