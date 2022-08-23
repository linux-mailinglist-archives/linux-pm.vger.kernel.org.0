Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6559ED2A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiHWUK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiHWUKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 16:10:41 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B8094EFD;
        Tue, 23 Aug 2022 12:30:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w196so17043845oiw.10;
        Tue, 23 Aug 2022 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=L34mygYcsY64WF3ptC9v2v7ym7ZciNtxv50Hixsy1YI=;
        b=aAjJMbW7malEfNcJRA8xKCK2iWw531h3z1kyfHcQpt+fQmMCbzrV8Qq2PvkyMFwCVd
         dzfyhTnrs9TaPtVRzXrNfSgopmta+oHX/sbIXGEgv0Ik7hw3k7YNP3oM4YEpbbSXXtWn
         GDX6AuN/zNFguv4L2b3LXppGl3lbTFunGpLnwPaheR4kVH3t+j66YWBkOX69gOs9/K8h
         gkSQB9ZgDvN2iif5wDxnQnUp69LLm/mrAPVKY5HGX+9nFfX7+0ZKyflEs7dVWWX0Oc7t
         rwCsgi6vMKP8RKaF/wT/EFXMz+6OPGmURjHX1H+uUrYmclpaQO9ZhNVfU6LklN/F+/5P
         UnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=L34mygYcsY64WF3ptC9v2v7ym7ZciNtxv50Hixsy1YI=;
        b=jNq6b5ktv5z6dFb2Jsd0Y9Dcjt1xykxz/ZWBvhJtX4zDgRSvWU0LCme10Hb42YaYSN
         FzSzzUCDGUwE21/pQvhMLAJ//piJl0oKlbzVWaRvEllm5LnVlJGTkgJU5Rz5w0/ZHCDL
         2AxPZMhpP24sokXT036tDhq5R738ztnf046eokZI4nkauAVrch1mP4k6CZ685w4paUQX
         e8LuqcxXisiEQ2uKPyw+RA41l56Qqi7ijy4JfWY2ubi36VxcEj5ZUyZOdI/T2CgmmmRf
         k+sysXg8Fxna1Chlt4rkF0bw8GSk5L2n7Onzu3EvCnM0xm2Wx78qvQaJqNWjsWJTKsCs
         VD6g==
X-Gm-Message-State: ACgBeo2i/QySicR75ArImvBy/Asv6dQ2fM5LHuXFeHZj98L16GlF6m5Q
        4fnTt8w/WMQJkIuzDtRK5uQ=
X-Google-Smtp-Source: AA6agR7iL4NFe6cr4BmrZKeT85s1EnX/c4C6RYOgtH4291z6DXJ2aiav5YMdqV9SL2+Wbad/wsDxlw==
X-Received: by 2002:a05:6808:1b20:b0:343:678c:451b with SMTP id bx32-20020a0568081b2000b00343678c451bmr1937135oib.171.1661283020016;
        Tue, 23 Aug 2022 12:30:20 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id f36-20020a056871072400b0011382da43aesm4070372oap.16.2022.08.23.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:30:19 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, maccraft123mc@gmail.com, sre@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lee@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V9 1/4] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Tue, 23 Aug 2022 14:30:12 -0500
Message-Id: <20220823193015.10229-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823193015.10229-1-macroalpha82@gmail.com>
References: <20220823193015.10229-1-macroalpha82@gmail.com>
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

