Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4034F1F39
	for <lists+linux-pm@lfdr.de>; Tue,  5 Apr 2022 00:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiDDWrR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345400AbiDDWq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 18:46:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5080838782;
        Mon,  4 Apr 2022 14:58:06 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so8136434otj.10;
        Mon, 04 Apr 2022 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8SF98rfvfsECoLgv/3qDJ7dOWAbp3etpp0VBkgOEd4=;
        b=llbe/jozSemX/Dt2sgIr8j+xJRQHaLnkhS58ESP4PGlU4YqQiTnWTLahrld27BPO/X
         KNJCwjVviq7YOMboPvKdYhdBc4Vpb+Fz50XvHxFU6DcJXtg8LoSwAoG4AZYJpSuVNpZC
         rJscq5/C56OUxWds9fod0ZorT/bPw0V+UC+VW99D0Cm7ftFerBHRtp6agVoCCxWLl6w2
         UoXEe3ggD0wDv464QU5RMyAuzGfKfSGNYs5vABx30KicLVEx2p7/jORpRlopw3zO5nns
         ZGib1aTQ4yIW9s1rDDYB6c2qt3wAJCcs4AHxZJI7elJ903QtaWSnUls4SCWPuC1Tg9Hv
         lNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8SF98rfvfsECoLgv/3qDJ7dOWAbp3etpp0VBkgOEd4=;
        b=csfErRnwjN5bgj1Teog5S3ffpAta57r3D9mHBaX2U4Ux/+tKJqz+fPNLTQmTNS0X+1
         Yb6ubU3rrQQAcrwmCuDPc2AzlBVLjPLVgL6c10k/lNNpBXqAW9PdeozP2m2M5I1Xcfrx
         KPKuAx7M/XM1aXT8SdxslhYEehZa2w+N5AowZCkv3nwmmhpjTA1YbbBzQztq42rhSr3K
         1L9447AlNWwk1/5/3Q4HDsOEiXolohiJwDCqbysDPCXh1RDrJl7d+vh5YzZiTMZLNVRB
         +eINXm4w64lby++3OXYBHShuL+/2DFVX8P3gOTlg1GoTQWPXYFXpi25ZZ1AavOW4sORx
         qMXg==
X-Gm-Message-State: AOAM532aIuhu3ROOmSPZkQgzV5+jO/Wgei1EYpuyB1ElhTf7iCemCjff
        jzYbxwiwE3H98tct6olo0swF18aFMSI=
X-Google-Smtp-Source: ABdhPJxNUEmI/HP0u5EwCfYA2HhDlWdo3pXzSO4krY1nKVPBsaB1PI+VnKEWcQ2aCzvkuu+6qWebTg==
X-Received: by 2002:a05:6830:138d:b0:5b2:4b0a:a4fa with SMTP id d13-20020a056830138d00b005b24b0aa4famr136564otq.380.1649109485376;
        Mon, 04 Apr 2022 14:58:05 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r3-20020aca4403000000b002ecf4d70c83sm4646402oia.27.2022.04.04.14.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:58:04 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzk+dt@kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/4 v5] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Mon,  4 Apr 2022 16:57:51 -0500
Message-Id: <20220404215754.30126-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404215754.30126-1-macroalpha82@gmail.com>
References: <20220404215754.30126-1-macroalpha82@gmail.com>
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
---
 .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
index bfc1720adc43..b949d406a487 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
@@ -117,6 +117,47 @@ properties:
         description:
           Describes if the microphone uses differential mode.
 
+  battery:
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
 
+            rk817_battery: battery {
+                monitored-battery = <&battery_cell>;
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

