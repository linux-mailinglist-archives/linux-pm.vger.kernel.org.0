Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B4572B7A5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjFLFkN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjFLFjx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE421717
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4426468e87.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548379; x=1689140379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UX7NK4V+9Hzbg8jKZOwQnFK6tOBZPs2ooDLmGE25jY=;
        b=AzpjJjf1rRnX9/8zALf3MesyN9OaLzUS92PcVFWMfUfz61cX6SINAyaN4rtAf0Cvp3
         yJyHbyTKfbyg6l79QWpNVS+eG379IO/ympACeqdSJdwFhPQVHr2H4RZ56dOi4I9iO6dw
         WuGJV/Y9mOGgmqEeaAr7W0VAqENtiV/KfSD/cgk3OnxkiMOKGBGCjlsQos2JGxLxECB/
         xNbH0a2IcBH25Byze5J6+IJi02GDsxQQaQ/SdW8iuubwTJxJTMp/L1smdcRqeWB18nU/
         /ZnnudIsga+wsvHHLPFYCCmBUgH51cVLJJZFZ3htw6zTbzoSnxIKAT5rlmjmKthkD/tA
         326A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548379; x=1689140379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UX7NK4V+9Hzbg8jKZOwQnFK6tOBZPs2ooDLmGE25jY=;
        b=dWBd3SP0VkkrTkQarGH4LebrSfAgiA5eXsg3G/i2PBqzJemB41A/d+uKnqOa+h+aQi
         KusWzJ8lxfdyfkIn1ZTD5CCS0hxK00KvSiEha4Hwqb0ODj+YbmH1loKhh/lxbneQdxYC
         Uwb6PIdSCtZmZygr/pKv+e1UuBxCKfiDmDmAXMWu4RIe59N1Tc20h4CP2X31diaTVWRL
         n2utSd7TtQS5lTwJWZCZm6x6xXeHj7e9bl4jr68GwG8bx2vk2O6BjxQC6BvZ5rxAF3Hy
         lGjq3Kdw+eoFd0taWlNiOoofouGodYc2GF6Sf9BNDEOo25jFsUOaX6PaeLASOkkAll/a
         2VrA==
X-Gm-Message-State: AC+VfDy3YGJMEmg8FIVZPCRtQpPpDRhafXiv8qaiSnUFfmfVvcq6ONwX
        QhVTgZrSyh0UJo6gvga3UwJp6w==
X-Google-Smtp-Source: ACHHUZ4wzWtxLIONvLUsoHjLluwV+c2yaJibWU04gw+Iy3i1r8PtS/J7Hs69VzzP644zHXsD6fSuag==
X-Received: by 2002:a19:6d1c:0:b0:4f6:424c:4fa8 with SMTP id i28-20020a196d1c000000b004f6424c4fa8mr2903128lfc.17.1686548379413;
        Sun, 11 Jun 2023 22:39:39 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:38 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 16/18] ARM: dts: qcom: apq8064: enable passive CPU cooling
Date:   Mon, 12 Jun 2023 08:39:20 +0300
Message-Id: <20230612053922.3284394-17-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index f35853b59544..82b381b66cfb 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/soc/qcom,gsbi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -1279,6 +1280,13 @@ cpu_crit0: trip1 {
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
@@ -1300,6 +1308,13 @@ cpu_crit1: trip1 {
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
@@ -1321,6 +1336,13 @@ cpu_crit2: trip1 {
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
@@ -1342,6 +1364,13 @@ cpu_crit3: trip1 {
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

