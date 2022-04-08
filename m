Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E54F9F15
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 23:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiDHVXf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 17:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiDHVXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 17:23:33 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABEBDD;
        Fri,  8 Apr 2022 14:21:28 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id b17-20020a0568301df100b005ce0456a9efso6957340otj.9;
        Fri, 08 Apr 2022 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSz7K5b19XO8QthP7HKkn0j7bBJdLPWpwnyCCD24rzg=;
        b=SCk/MAAi/FxNsb7z52mlGHrgzeCDvyZeButxLA9JxQgDGLGn7M7mZrQM57/9nltDAb
         1eXz96dJYi7tP2L4+eM8Pr/CfGjTzbdPDCkHxAbtZr6LmjvJyLyIrA+yYlfPlFweGStO
         8K+vPTtqLLs4bF09NOCFjnN+9T1ylWEJSDYD6PVuX8TwXDifown5dEKOjFz0/iqt0QKw
         /ciZufo3ksJsR7Q6CS5MmmOfVSw1w3YJllIzyMszgTVKDqtKHUaD+8wzhrmvWQUW8m0q
         vYakZZkye+EmPpxrsYD97F0FQv8VeVNvERfaaMcVJruF+qkklL5YWHxPfbd+jrnVllh9
         3UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSz7K5b19XO8QthP7HKkn0j7bBJdLPWpwnyCCD24rzg=;
        b=wKvA9CgQ8tHEaHiLt8laqDJJjoW19KVG9kiDXadmLeuNzME800ZHNdDQFd5w++jksJ
         gzz3uuVIp24Q/XOvJJWXTbU+E4Hx5HasUgaspSU5/tFjWo5x5NiPhQwCkVt3N+Hc6R+O
         K8Bpxy2Qu54yx5jcOyPBF9G3ejfYMcPHq8khITVnM1wXZoTz4y/a564sThtZhtQbceC2
         HNWse0TF6oB13i6Oc2NOxxGxWt3VcIvaYSZC/r+e12vVQIQNw6Y+tjxIYTvL15G6D2wI
         ASDra104RnT8J0mf8kI12YTHmuMi0v+w8Nq7GOIuPGx6wK1S4eVt6b+/qwuDafdctGoW
         pLIQ==
X-Gm-Message-State: AOAM5319QuShtrKRpIXntlfdzaCntX4zX6I4Gsr1x5AS4XAzs4fGDFEi
        0sqR3v8/Hcj1Zm7HCIwL3krCI+cHEvQ=
X-Google-Smtp-Source: ABdhPJzjMt5GRQHD7VGPCTMxCL8blnxKeGKjJIx7U96yzSYdBFjnbvy5/42EShsJh8jjvCFvT7Cljw==
X-Received: by 2002:a9d:b91:0:b0:5cd:99af:bebb with SMTP id 17-20020a9d0b91000000b005cd99afbebbmr7585230oth.245.1649452887769;
        Fri, 08 Apr 2022 14:21:27 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000de98fe4869sm9950375oab.35.2022.04.08.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:21:27 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        maccraft123mc@gmail.com, jon.lin@rock-chips.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/4 v6] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Fri,  8 Apr 2022 16:21:18 -0500
Message-Id: <20220408212121.9368-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408212121.9368-1-macroalpha82@gmail.com>
References: <20220408212121.9368-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Create dt-binding documentation to document rk817 battery and charger
usage. New device-tree properties have been added. Note that this
patch requires the following commit (still pending):
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220404215754.30126-2-macroalpha82@gmail.com/

- rockchip,resistor-sense-micro-ohms: The value in microohms of the
                                      sample resistor.
- rockchip,sleep-enter-current-microamp: The value in microamps of the
                                         sleep enter current.
- rockchip,sleep-filter-current: The value in microamps of the sleep
                                 filter current.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index bfc1720adc43..d0dccb1aaf4c 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -117,6 +117,47 @@ properties:
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
 allOf:
   - if:
       properties:
@@ -323,6 +364,13 @@ examples:
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

