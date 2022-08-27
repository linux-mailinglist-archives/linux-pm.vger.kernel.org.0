Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72F5A33B9
	for <lists+linux-pm@lfdr.de>; Sat, 27 Aug 2022 04:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiH0CQh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiH0CQg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 22:16:36 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3820F5B078;
        Fri, 26 Aug 2022 19:16:35 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id s10-20020a0568302a8a00b0063b1cac26deso73931otu.2;
        Fri, 26 Aug 2022 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mf/Wnkxtmv95NHNcpXu8kZiy3UcFnPoDPtvznQq/TNc=;
        b=R0/8MZkc1X84R5o5lHg0/6TgAc20liCy5Idnswb8aTUKOu8gN4gCpVw0nJB/INIWo1
         N69UI7Fg20nivbMHbK4/Jtqe+OLUp+ytlmt1uRr0Zr8EfTHBX1flgmdbN7OXvTT8bBow
         DvbeMTuQC7KSoc1CrNbGx+KJzMJrLe99Nf2z6oVGltBGdMijm3eHmpwD2a6XmSJczzSt
         2Tv6egOlX2/UWa79ssBIx8IFHqJyzMnFYE7Ds33MTq9MmO9VdS3mSb0AjyH0XhCnG8ih
         DgXSGXPEM4pRzjbGmvUQpClMNLhfgbj42t8AvOVaubiul5dlScpX3HPHLZHZU1UnZtK8
         yk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mf/Wnkxtmv95NHNcpXu8kZiy3UcFnPoDPtvznQq/TNc=;
        b=MFH8Nhy8Cnb9tHBJUiPjOcU0hUz3mzAxhEr1s4qNHt2g4zFVgXiVOTH3EHnFTtiTeL
         nDuYFV1odI32w02+oIfbKL5dp3Y0SC38bPy88YCA73AePPa6rLF7qzyWgjeLw/BZqlzE
         U7EKsPWDob/fxiCTNVKaHMTTBKM7yh9ApX1oGkBbkjqPeo/9uaHdW5mMK+aeKvEa41Wd
         svh93/vivz3zpgRYdWXxiIkTn442T+SbguAboOxPE2q/bskBu3oTSqvcxY7KL/p8hb6B
         VV1zmH+pStlQEBPZcEqg1lNpy8QbZaMhhvhdH3B1uSuZwp5WgbkEtYhTvIHU/MROlHQY
         0SCg==
X-Gm-Message-State: ACgBeo1Wvsba7axH4npWzpyULdWDAlsnZl8ChkZDq8aeux0RXTUtobIA
        btDbr/YcBFZ7s3BZY30aPvguY8dBWqk=
X-Google-Smtp-Source: AA6agR6BRf2WLexC57rqPJP4tMDOlY7NXO7AFX9dF6VDD+b9KLd0oaFyxcQ7XN3KytOTQOMfT7S8bA==
X-Received: by 2002:a05:6830:25c4:b0:637:2a66:1dfd with SMTP id d4-20020a05683025c400b006372a661dfdmr2368113otu.383.1661566594237;
        Fri, 26 Aug 2022 19:16:34 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d7c84000000b0061cd208fadesm1925752otn.71.2022.08.26.19.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 19:16:33 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org, philip@pscan.uk,
        mazziesaccount@gmail.com, Chris Morgan <macromorgan@hotmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V10 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Fri, 26 Aug 2022 21:16:20 -0500
Message-Id: <20220827021623.23829-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827021623.23829-1-macroalpha82@gmail.com>
References: <20220827021623.23829-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Create dt-binding documentation to document rk817 battery and charger
usage. New device-tree properties have been added.

- rockchip,resistor-sense-micro-ohms: The value in microohms of the
                                      sample resistor.
- rockchip,sleep-enter-current-microamp: The value in microamps of the
                                         sleep enter current.
- rockchip,sleep-filter-current: The value in microamps of the sleep
                                 filter current.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mfd/rockchip,rk817.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index bfc1720adc43..5b11184a3936 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -117,6 +117,49 @@ properties:
         description:
           Describes if the microphone uses differential mode.
 
+  charger:
+    description: |
+      The child node for the charger to hold additional properties. If a
+      battery is not in use, this node can be omitted.
+    type: object
+    properties:
+      monitored-battery:
+        description: |
+          A phandle to a monitored battery node that contains a valid
+          value for:
+          charge-full-design-microamp-hours,
+          charge-term-current-microamp,
+          constant-charge-current-max-microamp,
+          constant-charge-voltage-max-microvolt,
+          voltage-max-design-microvolt,
+          voltage-min-design-microvolt,
+          and a valid ocv-capacity table.
+
+      rockchip,resistor-sense-micro-ohms:
+        description: |
+          Value in microohms of the battery sense resistor. This value is
+          used by the driver to set the correct divisor value to translate
+          ADC readings into the proper units of measure.
+        enum: [10000, 20000]
+
+      rockchip,sleep-enter-current-microamp:
+        description: |
+          Value in microamps of the sleep enter current for the charger.
+          Value is used by the driver to calibrate the relax threshold.
+
+      rockchip,sleep-filter-current-microamp:
+        description:
+          Value in microamps of the sleep filter current for the charger.
+          Value is used by the driver to derive the sleep sample current.
+
+    required:
+      - monitored-battery
+      - rockchip,resistor-sense-micro-ohms
+      - rockchip,sleep-enter-current-microamp
+      - rockchip,sleep-filter-current-microamp
+
+    additionalProperties: false
+
 allOf:
   - if:
       properties:
@@ -323,6 +366,13 @@ examples:
                 };
             };
 
+            rk817_charger: charger {
+                monitored-battery = <&battery>;
+                rockchip,resistor-sense-micro-ohms = <10000>;
+                rockchip,sleep-enter-current-microamp = <300000>;
+                rockchip,sleep-filter-current-microamp = <100000>;
+            };
+
             rk817_codec: codec {
                 rockchip,mic-in-differential;
             };
-- 
2.25.1

