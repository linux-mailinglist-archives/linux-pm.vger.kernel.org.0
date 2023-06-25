Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21F73D3F6
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjFYU0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFYU0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14162E67
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f870247d6aso3107240e87.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724766; x=1690316766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/gIGR5p88bRbqFIR3bdructdjZtrGeYMyqpAN9LK2o=;
        b=Hr4NYCYDh9Ejr8ZwKjAjGQdntwzW7Z5jEqehZ8+GoP0hJ1WR/H99CzIIfQzFh5EE1X
         pi7LGA9BnB2BcYfD8Tk+Kj52cXQqJ+6JlFP3zxnM9CnAx6igkE3g8PXzAWMSwVoWj/Rm
         PaYCHDMPuCFd+GVjtYN6cf0c/VFdlZ5MyFk6Kkm1JN99xUJ9soQ58ERxgQ2gcQIMcnay
         Bgfy88Udq/dO6VvhH8adShO/pURPQEzMjkZkxzkAPaMh7Jil2Xjbn9WovrNhtrW1Hftm
         3MrYozMF/eugpFeRQmjqAWtWq5XWiKwjx6rcdl2QoychMzqm3VNTUSRciA1rcEJahJ9O
         ibeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724766; x=1690316766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/gIGR5p88bRbqFIR3bdructdjZtrGeYMyqpAN9LK2o=;
        b=Y6wAw2I8orUPIIeNDFZxG0tknNmhsc+DO8jUM1ve8ZbsEQfoYjCWm6CcwW14DxppRG
         1HbKgccLgS2KhmJuS4Fg2GZa6xoSJQ9oB7yI9l7xRymOzRrHndV8KP0umFf1Xu2eGAXL
         xg8QiPFOnIFprmJdQtL8GyywWhXbhd8sx5kvXvu41wAJwEN5S0hw+qfqwFCyvAn5kEe1
         gxTNzWGED2OxAPB+XPWoHXQyuwn4ttHsy6q1Gm4Oy4YCV9dTdb8v6xj4qYsV5fVQ6cdR
         ZDUVyFWPyf9WC9NSqkfq05ZKINqc+GJhGc8+ReMl5cwzcd3NbymR58l2Qht6Z0gFyjMq
         LVaA==
X-Gm-Message-State: AC+VfDzoa0K/etR2YlWWPRkDGWorfWcdPZgZ8RJE7f3ejjqNzL4dnPW+
        UQsodhQX989w1b1ZJUOY28A9nw==
X-Google-Smtp-Source: ACHHUZ5jvaHJPeX1ZeYJTC+I5cSM+HJV3traT6tMQJ6ckNnZHG9OislZcpY+YLOCRm63ccgatJi0yw==
X-Received: by 2002:a19:ca5d:0:b0:4f8:5ade:44b5 with SMTP id h29-20020a19ca5d000000b004f85ade44b5mr13231254lfj.53.1687724766408;
        Sun, 25 Jun 2023 13:26:06 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:26:06 -0700 (PDT)
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
Subject: [PATCH v2 19/26] ARM: dts: qcom: apq8064: enable passive CPU cooling
Date:   Sun, 25 Jun 2023 23:25:40 +0300
Message-Id: <20230625202547.174647-20-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index b97d88517805..f38e3394b422 100644
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
@@ -701,6 +702,13 @@ cpu_crit0: trip1 {
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
@@ -722,6 +730,13 @@ cpu_crit1: trip1 {
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
@@ -743,6 +758,13 @@ cpu_crit2: trip1 {
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
@@ -764,6 +786,13 @@ cpu_crit3: trip1 {
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

