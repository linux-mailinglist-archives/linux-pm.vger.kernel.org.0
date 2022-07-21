Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150A57D151
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiGUQSj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiGUQSK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 12:18:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3480F89A9A;
        Thu, 21 Jul 2022 09:17:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u76so2570272oie.3;
        Thu, 21 Jul 2022 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za+JFS8UrUe1EXtSy/HN8YRbGNE25Vj78rAPO0Rkf/g=;
        b=XE5kAqwl3Rf5mcVlgqYtU3nZNYS1XkyqIh80DOiZZT8LTpu5cJy5s70ZJUkGGj80Is
         cxR8Dngy+eim6aaUkbJZKdTm2oVowGoTVk+TqMk3NqHgZ7OFVFqYU3KMmBmlz1u2+q4H
         MVzp9ppVTVsHVfli3f2Xa5banhpGKdQG4Uj8lVmvpL8Fls4GVRFHoBn7T6UlWv4K+uuI
         3uiYOCvD3R5a2rgvoTvqwh8rnMnaW1t2SPb28P6aPC/2ZnRz61iH5yp7QAyFDYcgLUDk
         RQ4qfUMvsKzXwu7occ9gO+oji3gk/fu3V6TXvLSQ0vOZ55BMwedY07oFPxwV7t1vDiaM
         l+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za+JFS8UrUe1EXtSy/HN8YRbGNE25Vj78rAPO0Rkf/g=;
        b=UDQVZ7r62i9AN7Wy737BIg72rZsBcUwcAlCayZEECusZbYL/4Vj710hsbk2+dcA2Ll
         mEkC4JVaNmLpnRbG5HTuFVJIZCUyullV+ky/pgA+F83KtU8AfZAB3ukT3YCTcY03uY5a
         N88SXzJAS70iek0nTY7JsaSHAHgICCiIPHSAP8Lee20pBhGLYe4etlAD/0Y3KQgF2o+g
         HSRzga0kQ60bsUDmID1sBkv5ltXdwxAT8DDxE0wHV74UJHRWl4owzxT/Y6+BJ3Q48/8j
         kEcRFl5Hp5/prftnsT1aJVvK8DxBVMdKMeIjos9hzcCpRQwx5rC2IKS5vbGrX7wcE120
         2bEw==
X-Gm-Message-State: AJIora8z9Ntn/lXY/NwvHmGzddqsDyWNkqnuVKaJZT8TKn9OdUa++gqL
        NQyhhzIA/vLPQJdpCE2n/b+yu4ZbHYI=
X-Google-Smtp-Source: AGRyM1sM7fsacs//VGlMkfgECCovjPPTLIXhH1cECgMNdUWQh5ZDiWMSUGDHlQDg3KznL+HThctTxQ==
X-Received: by 2002:a05:6808:1647:b0:335:4374:487 with SMTP id az7-20020a056808164700b0033543740487mr4904952oib.121.1658420253643;
        Thu, 21 Jul 2022 09:17:33 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id cy18-20020a056830699200b0061cc06a886csm951732otb.9.2022.07.21.09.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:17:33 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND 1/4 v7] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Thu, 21 Jul 2022 11:17:15 -0500
Message-Id: <20220721161718.29800-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721161718.29800-1-macroalpha82@gmail.com>
References: <20220721161718.29800-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Note that this patch requires the following commit (still pending):
https://lore.kernel.org/linux-rockchip/20220519161731.1168-1-macroalpha82@gmail.com/

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

