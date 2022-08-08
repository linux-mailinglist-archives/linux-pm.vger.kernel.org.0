Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8CC58CCC6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Aug 2022 19:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiHHRiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Aug 2022 13:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiHHRiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2022 13:38:21 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5691615A33;
        Mon,  8 Aug 2022 10:38:20 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10e6bdbe218so11294360fac.10;
        Mon, 08 Aug 2022 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=L34mygYcsY64WF3ptC9v2v7ym7ZciNtxv50Hixsy1YI=;
        b=lFUXTKxhL8csTgo1zVj4Xe8va4Q9KZhTl/VBjIpkPw3OQiowkMPjoTOlpVJVn+fUKR
         BWNLz9J5/dP0KwSmo6phTXGHiu/dI1ht9y6xslSCh96S4QKhpw2VwQV0un6hnK3iR1Ac
         9ltv5yMznOEb3mLblFNTEv5uV6mN98cUqQd9vtniHJxUv3Of3o/igh4SC2z9F1hbolE5
         B60xOMRBDvlADjcvFLXiP7BGqLMBtxOcyn+TcMe4381L8t8Tsg1333s/idq3DUDGaeAd
         nqyQMgN4RDe/AH+E+o23NwLOeyb8odA8cY7plxG7xkZoOLAIK7lrlgzHhpoumkznqq2E
         /SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=L34mygYcsY64WF3ptC9v2v7ym7ZciNtxv50Hixsy1YI=;
        b=zRNvU2p6TxldkuxBk2FduY2OJkt1YEMzPJYR14BPN+oMJB+s8deAb/BWGfIMDx5aLJ
         b7dzXSL/iD1E34p0uf80VqYRUygSuiPmOSy8NaTeDa9vJpPpBNaaI+j2sVhTgoZ5mOiU
         FR1yH/KQtlEa4ZIQW7a4LhU6ApuNffn2H/zafOl7PZG5Vfu7sKo4CrtVUB1euFJ//9QT
         Ldy/wzJWzPsQc8apTS1aaz1WtPpcqLHQO5IiK7+ADC8l9iVPLbEAO0cYW9YnSgLAswT3
         hoq7je8jnxzflwonLJhw4TU1oUH8Gr+eipqgb0EZLZoYebHZllg9orvIrAXiDiKE5JhF
         o2tw==
X-Gm-Message-State: ACgBeo05hZzkT5pAto6l4k8wIzTkDLPuytapMcSkoJwf15psZ6nOA3Oa
        7RjVeaIyy2Ix0FNZi9VwNppur/ODwvo=
X-Google-Smtp-Source: AA6agR6IoEE8ecvchR2Y/NxDwX5JbFx4dJ7QZJ6Xzm0FFbCe/sHKT48mxnZ6ZY2+8jz7EvPq9wUSJw==
X-Received: by 2002:a05:6870:2191:b0:10e:75b6:fc3a with SMTP id l17-20020a056870219100b0010e75b6fc3amr9066772oae.236.1659980299387;
        Mon, 08 Aug 2022 10:38:19 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id s2-20020a056870248200b0010edfa2b0e8sm2429202oaq.50.2022.08.08.10.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:38:18 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Mon,  8 Aug 2022 12:38:06 -0500
Message-Id: <20220808173809.11320-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808173809.11320-1-macroalpha82@gmail.com>
References: <20220808173809.11320-1-macroalpha82@gmail.com>
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

