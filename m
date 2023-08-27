Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8D9789D5B
	for <lists+linux-pm@lfdr.de>; Sun, 27 Aug 2023 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjH0LvK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Aug 2023 07:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjH0Lu7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Aug 2023 07:50:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72396CE1
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so3538711e87.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Aug 2023 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693137049; x=1693741849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USgeUwECAkOQEp1wsiFNyllfKzoxZQF/MlR4uioqAes=;
        b=SKRHXexgEO0hh70xfF+rypCfvjUljDWvouh9vQtfzEUqvtIvu0wmjl6kJo+IKL152x
         uqVvmNppO06Mp8tu+RmijGYKqBR/EuUHxzyi62jVbPqDXakTubVpaMqZAJD6uF9yLSZb
         oxsHRClqIq2gZvrTol3lkTTryMWCSV+UMuGPxU1peSxag1qpcUYDO1zJkYhiO4Wl7TtN
         a7Em3/Mc0hUpSpR8yLc0WHY4vOoPdCGvUIn4JwdX5JHQzotkRiHosQLQPUzs/Vuf71BM
         N8Io7qIiRZc37R6hKL2SkARBMrHQ6RpP5x/ZBTAfegpSaj4ubBASEiHO5Um/hOAyn5xu
         Yf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693137049; x=1693741849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USgeUwECAkOQEp1wsiFNyllfKzoxZQF/MlR4uioqAes=;
        b=POK2NCI2aUN2sD3qxkt/Gz9belGEAGdLQnw8fOuiw7QXdKYHDbpIQ0xrAmJEb5eP+l
         8iL5KPnJCkz1b2/5m736uFgA6Ph51qqBmcqbK4z95r5BCaMpYOKVwMfzWungkywt9fMy
         JYEGTzfWyTMVKKfuOclPhdndqYN0BVRvUQMezFd0y+9yXanLnd3ga/BSj4Gc+qofp5E2
         3t8xt15qUIqNXIwPHQ14JbkebSi3gbLLrVM0e4Kkfn6e7mhdN8cQwqdbAjBIAdyv8tgX
         svc7Qex1CcinfSSXcisEhEDUClSLZcvKklgovLrH81P6XimCU48xorpBc9ijQMIvMy+C
         /YGg==
X-Gm-Message-State: AOJu0Yx6uYxuIlwFCtd15hfPkzjpjN29Z0OX7vlVHI/GaZ3gA87FShyO
        xAczOCFwJoU3kgVonI45ATra8g==
X-Google-Smtp-Source: AGHT+IG4gCJRpkHKUBlElPDMU0gUa0vMIXPRfjy4BFBrv0VVbh63oToUWwhhprskD3OTUevMYF7PIw==
X-Received: by 2002:a05:6512:754:b0:4f6:d7b:2f19 with SMTP id c20-20020a056512075400b004f60d7b2f19mr13620653lfs.24.1693137049652;
        Sun, 27 Aug 2023 04:50:49 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a8-20020a19f808000000b004ff9f88b86esm1114770lff.308.2023.08.27.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:50:49 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 18/23] ARM: dts: qcom: apq8064: enable passive CPU cooling
Date:   Sun, 27 Aug 2023 14:50:28 +0300
Message-Id: <20230827115033.935089-19-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Wire up CPUs and thermal trip points to save the SoC from overheating by
lowering the CPU frequency.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index f08d87bcc37e..638b2201ee0d 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/soc/qcom,krait-l2-cache.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -697,6 +698,13 @@ cpu_crit0: trip1 {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu1-thermal {
@@ -718,6 +726,13 @@ cpu_crit1: trip1 {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert1>;
+					cooling-device = <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu2-thermal {
@@ -739,6 +754,13 @@ cpu_crit2: trip1 {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert2>;
+					cooling-device = <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		cpu3-thermal {
@@ -760,6 +782,13 @@ cpu_crit3: trip1 {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert3>;
+					cooling-device = <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 
-- 
2.39.2

