Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0765FC2A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 08:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjAFHeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 02:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAFHd3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 02:33:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3235C7815A
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 23:33:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m6so901816lfj.11
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtqtaj1OFg/MyB7wNM/laqasuBrV7DJChC6a1lfJy+U=;
        b=EmcEnZ+1smq/P29KCoPfIYa+sCzShyAh3Iz95Lw+SaxRgSXWyWYNEXsDwvrBlq4/ln
         vls65jn2QK7jAzKcbtpBajWFYGSZuDelgu56JactOH1Gtc7iC8KcKlr/Vyw7SdHvlGqL
         HMOlN49/PmKsAfYv8YN5gnxrDVhqaIcQ8rSRtHirrVdRWaPuTH13Dm3iUNvV+bNLUQ8R
         42kvhjBxFsQXp2fkndh6/q7hi4ksdnUtb2KSYRzIyHNJWlzdHaBXM5HLxFR0VtXP3WED
         HTjbQvZvHKTKlf37Zb1a4xHAKWzYkaMfl71ITO1QUPWiK2dKcbDhRYTNx1psJ8P6p4jc
         Dn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qtqtaj1OFg/MyB7wNM/laqasuBrV7DJChC6a1lfJy+U=;
        b=yN+5y3W8L8+RS5U26WBltQsxBTcYscbm1lHuDELjrfPZGrQwILczD9ZxNCMRabeJPe
         Lw/sjA6mDEQeLZ/Y336o2siEDPhzqblbjH8E3W/k6jYFfO55CISXf5eMkJW6OEwdplCv
         kCgej1Vq7DkFEpoNzaF4qe2bvYflmik0RB/2YWjbHI26Yleop/em0aPp4S1A2yDkCoBs
         ouy964QhAbS60hAAiQKD5vYOxyRCbjKvkgKXkbyPODgM1XdO2UuE7+mK8fh+EDiIrZ9l
         Q0JvFNOD5dEQaASJdSzFeFLewpcyjBbIxzKUwYL8AA7j+Qa6/x+ZW0Nll1jSRs8fKlI/
         2odQ==
X-Gm-Message-State: AFqh2koWm37VuFfuU0F2908I82g9fmeibSi2Sd759VRlhNnENBDXY2Dx
        CySknkyqSMOVB9JX91N1sNI6+w==
X-Google-Smtp-Source: AMrXdXtc5mz1Y9WwcJcGHvCmhoz1myCD8ufBeFTcmKdNTJAgTU5+YyViD7/qeJv2/9/HiEPcAaFIDw==
X-Received: by 2002:a05:6512:224d:b0:4b4:b5d3:6603 with SMTP id i13-20020a056512224d00b004b4b5d36603mr24549503lfu.32.1672990403564;
        Thu, 05 Jan 2023 23:33:23 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b004b4bb6286d8sm61114lfc.84.2023.01.05.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:22 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 9/9] dt-bindings: interconnect: qcom: drop IPA_CORE related defines
Date:   Fri,  6 Jan 2023 09:33:13 +0200
Message-Id: <20230106073313.1720029-10-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
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

These interconnects are modeled as clks, not interconnects, therefore
remove corresponding defines from the binding as they're unused.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/dt-bindings/interconnect/qcom,sc7180.h   | 3 ---
 include/dt-bindings/interconnect/qcom,sc8180x.h  | 3 ---
 include/dt-bindings/interconnect/qcom,sc8280xp.h | 2 --
 include/dt-bindings/interconnect/qcom,sdx55.h    | 2 --
 include/dt-bindings/interconnect/qcom,sm8150.h   | 3 ---
 include/dt-bindings/interconnect/qcom,sm8250.h   | 3 ---
 6 files changed, 16 deletions(-)

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
index a3e5fda7c127..7440c2776415 100644
--- a/include/dt-bindings/interconnect/qcom,sc8280xp.h
+++ b/include/dt-bindings/interconnect/qcom,sc8280xp.h
@@ -48,11 +48,9 @@
 #define SLAVE_SERVICE_A2NOC		19
 
 /* clk_virt */
-#define MASTER_IPA_CORE			0
 #define MASTER_QUP_CORE_0		1
 #define MASTER_QUP_CORE_1		2
 #define MASTER_QUP_CORE_2		3
-#define SLAVE_IPA_CORE			4
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

