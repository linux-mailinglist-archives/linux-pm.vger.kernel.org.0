Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84722612CF3
	for <lists+linux-pm@lfdr.de>; Sun, 30 Oct 2022 22:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3VJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Oct 2022 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3VJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Oct 2022 17:09:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D7333
        for <linux-pm@vger.kernel.org>; Sun, 30 Oct 2022 14:09:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j14so14639993ljh.12
        for <linux-pm@vger.kernel.org>; Sun, 30 Oct 2022 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rhNzxOecpQ1JpgzYBAF8DJtdEFpcPQfpYXBW0TUud8=;
        b=LgBUP2Q12DY9UYAAaKG1x8wM2iUaJduH6i0IwF2pU14M6Z45fwG0142mFGi/cjXXm3
         nRkMZ3gPiBQ0IOEjMJgKl330lCPbZqlfhZc/2Y//TiPp+MEtLqHZAomtYsuYFxPOsJgI
         gzrYQc5TKFZ27/faUTxqBDzL60H+75BBPIQ8MgttpHBvHWVqTr0qzduBZVwToGGzXhoI
         gr00I70bdkLBAZz+/JwA9Wo7UTraJ8Mv6h3BdJQUa1+xRMuY7r+ECB+4xtJ987Y/c3vO
         +tKI2LKvEZvt41Gk3pLl1FRXd2LOfEtjOXgsByJnbZhr2/br8y5SWmNg4R7dVtDeI/DX
         yfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rhNzxOecpQ1JpgzYBAF8DJtdEFpcPQfpYXBW0TUud8=;
        b=7D5Nl4ngDJhUlCOmw89Cl/m1y2oUR0dNl8GKlQglHTX0QA1bvhwZi8EWSnDtqz6o0r
         ZmVbpEQ+HsT6XdZU4itktGEDWbXjP7uAnGNkIjboiPofBc6mMrpsTilM42J6cLSr+h4w
         bjeACC38sORTWfhnEBlXuvx15OJsPm5PT+azPeJdCabx7uYg8kQquQnM0fJFUeKD+xRY
         MIg+dGRc1nKevLWQvxAj1w3Vzz9k1/hclMRMuz53aHtd6lWu+ZYTPVWPE9tq++0ZOzWc
         LKS2cwLkxQC3TVikfse13gfkl9c9U54MyCSGU9a72oG2ASrAPs60wR7+2BFhLE4VyL2d
         uGqg==
X-Gm-Message-State: ACrzQf0bUUBNpzvbCTkWTLPmEfOghzRuTYIIKf1ywiErzS7/m3nbBUSW
        Be28uxzLN3ILf/Jchd8/x/a4YqcV5YpVmA==
X-Google-Smtp-Source: AMsMyM4jVS49zl1ShsALyG3LdRyib0/eGBhzLCFKG3CYDFb18NQtCzPW/JSZs7Tfo4HdIzmr8X7FLw==
X-Received: by 2002:a05:651c:491:b0:277:5279:142 with SMTP id s17-20020a05651c049100b0027752790142mr1226446ljc.507.1667164144038;
        Sun, 30 Oct 2022 14:09:04 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b00492aefd73a5sm952480lfg.132.2022.10.30.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:09:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] ARM: dts: ux500: Add trips to battery thermal zones
Date:   Sun, 30 Oct 2022 22:08:54 +0100
Message-Id: <20221030210854.346662-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.3
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

Recent changes to the thermal framework has made the trip
points (trips) for thermal zones compulsory, which made
the Ux500 DTS files break validation and also stopped
probing because of similar changes to the code.

Fix this by adding an "outer bounding box": battery thermal
zones should not get warmer than 70 degress, then we will
shut down.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Fixes: 8c596324232d ("dt-bindings: thermal: Fix missing required property")
Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
SoC folks: please apply this patch directly for fixes.
---
 arch/arm/boot/dts/ste-href.dtsi                    | 8 ++++++++
 arch/arm/boot/dts/ste-snowball.dts                 | 8 ++++++++
 arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts | 8 ++++++++
 arch/arm/boot/dts/ste-ux500-samsung-codina.dts     | 8 ++++++++
 arch/arm/boot/dts/ste-ux500-samsung-gavini.dts     | 8 ++++++++
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts     | 8 ++++++++
 arch/arm/boot/dts/ste-ux500-samsung-janice.dts     | 8 ++++++++
 arch/arm/boot/dts/ste-ux500-samsung-kyle.dts       | 8 ++++++++
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts     | 8 ++++++++
 9 files changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index fbaa0ce46427..8f1bb78fc1e4 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -24,6 +24,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 1c9094f24893..e2f0cdacba7d 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -28,6 +28,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts b/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts
index d6940e0afa86..27a3ab7e25e1 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts
@@ -44,6 +44,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts b/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
index 5f41256d7f4b..b88f0c07873d 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-codina.dts
@@ -57,6 +57,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts b/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
index 806da3fc33cd..7231bc745200 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-gavini.dts
@@ -30,6 +30,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index b0dce91aff4b..9604695edf53 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -35,6 +35,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts b/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
index ed5c79c3d04b..69387e8754a9 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-janice.dts
@@ -30,6 +30,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts b/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
index c57676faf181..167846df3104 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-kyle.dts
@@ -34,6 +34,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts b/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
index 81b341a5ae45..93e5f5ed888d 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
@@ -30,6 +30,14 @@ battery-thermal {
 			polling-delay = <0>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&bat_therm>;
+
+			trips {
+				battery-crit-hi {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
-- 
2.37.3

