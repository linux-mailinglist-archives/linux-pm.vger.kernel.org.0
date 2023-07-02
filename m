Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43404744F24
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGBRni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGBRnN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:43:13 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBAE62
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:43:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so58081951fa.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319789; x=1690911789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXNVV7/JT60lwXwIFOgnJdtoSqHgaAkhji7YcNwL/qM=;
        b=dtFUT7aT7PLUXxySw4GRrBK63XpaF4HcxIdN0P8fm7ptw8XZMQmIzs9WAYVpXacVNx
         VMC4FyT4iJU3qKc6IG6s3SmjPmR0G40l1BHINTcBTncKNeeS8nSYUpD+FG5lamf3t2/a
         BdzFyxK2r/LAoJuaOMbDn/Md2f+epdaDDR5KMrj00HRwfzfBlARRISWdYJoxbyOWkKG7
         4rYYjnm0sdZwyfdBCQxcyjjZZObMrLDNxK6kt1O9Raf5O9Y6sGavbb0SY0KPQgrA1vCN
         RfVPPr7V6G2bce0mVp3zpS0hXvg2Uo0aSwWoVm/6DS/edpLRdLRTXWKgY92zrOm3JDM/
         Nn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319789; x=1690911789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXNVV7/JT60lwXwIFOgnJdtoSqHgaAkhji7YcNwL/qM=;
        b=UEFzC0Fj4w/zCDgsS5D8nfImCAPFKISW4L8r8ytc3jUm9Xk0T941KxfdlmeK1MdTZR
         5WMek7ClLN/MYcKkHGamtyMPhCX5/m6+d3NalOdAixqX7a8zStgRD9WOESjbtlwCV5l8
         n5VmRrs3y/I0/inuDJFYKeUMQb0+cUdYOUhdkHqmafyoyzNUhRZB/gCW0x6QTkNCPPK4
         az1lSYyGay9EBi2LiCTUm17Iv8zTk20jypZmskucahIHb95hCL7tmeRtnkHNVHJy9rvc
         ba9MrbQ7L0PVzGPCruWuINnrnjFJABpUmbUs/y/MJVQwk+Uf6iJIqoQ+Z0ezSB/Gn2ha
         vjSg==
X-Gm-Message-State: ABy/qLbja3lCxgVpxRhQ3zvpQc9Swn5ChiI1LZK2eOLiLCJzVmVs1M8w
        6sLGmojSRAaY7FdCBo1wcQRL7g==
X-Google-Smtp-Source: APBJJlGrzedUqU7L8aOB4HUnA9YJyn/PbaYcqp9zcVhUMx6Z5A+9kIDNaqP9I2ld0JkJb0+a1ZuP9g==
X-Received: by 2002:a2e:9014:0:b0:2b6:d9ad:aec9 with SMTP id h20-20020a2e9014000000b002b6d9adaec9mr2633501ljg.35.1688319789168;
        Sun, 02 Jul 2023 10:43:09 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:43:08 -0700 (PDT)
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
Subject: [PATCH v3 23/28] ARM: dts: qcom: apq8064: enable passive CPU cooling
Date:   Sun,  2 Jul 2023 20:42:41 +0300
Message-Id: <20230702174246.121656-24-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

Wire up CPUs and thermal trip points to save the SoC from overheating by
lowering the CPU frequency.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 5c9daa997e72..cc23adc13444 100644
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
@@ -699,6 +700,13 @@ cpu_crit0: trip1 {
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
@@ -720,6 +728,13 @@ cpu_crit1: trip1 {
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
@@ -741,6 +756,13 @@ cpu_crit2: trip1 {
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
@@ -762,6 +784,13 @@ cpu_crit3: trip1 {
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

