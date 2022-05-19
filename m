Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7405552DA85
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiESQqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbiESQps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 12:45:48 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1171007
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 09:45:46 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id s11-20020a4ab54b000000b0035f0178dfcfso1089965ooo.7
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za+JFS8UrUe1EXtSy/HN8YRbGNE25Vj78rAPO0Rkf/g=;
        b=cg6+vIhCSI7HHV/IeYX98FFMnomiDXGC8qXPpKRbECi9S5ZPJM/TJ6XLIZGo1Rmtzn
         WubFecTLsBClsoR+g6p1nKIOFb78/bSf4q/MGpl6ATisNNCM4al5jpUhisyKdbJPYQm4
         DniJUGei56MYcf7txmuimwp1geQYYf0ROpbQqrNIZM8WwczMVlgclvFw5oHrzcEArE4X
         821NNnf+nfcY6a0cgayYSzy/ht6XZ0saVVLfwAqsXE6dQZgJjHsTz8e8EOkGQxXbG+GG
         ZIgnTwMYWun0XI3m5LNFIHDjTDH0VX2QwGMtzB1c8oncBk82kZ6v0/7H8eBPDYuRrxcz
         t5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za+JFS8UrUe1EXtSy/HN8YRbGNE25Vj78rAPO0Rkf/g=;
        b=0bRSv3Kg8JAyaVsj5B5UtpVmRS7ubyx9s0ngVjeYFX+pEapz9OZgVU6zK67RtI8I9W
         2Ecr4is9cF9fT3IFgh92GpWbru3GIm5YjXrkxk7YdVFHVa5MNZPkI2c+5oLNkxgwqN41
         8AVs4LiUxxEYer8hVJLOIY6usPLN04oiwoYYW+mvKqEEY6vfjt9KZs1t+TvfNgz0FThR
         ngVCS9Uo+7l4y4XsQGQzwEW6iE39L8O9MIyAtmB9AbRxJcmhirxY3rbnpA3/FR8jrki5
         kEhtaurquerUfhEDsSDAyBOKe1wVy8WlZSIs7u0jG3pNWUOaf+gTN1cbdJtXfJI+atpJ
         wqgA==
X-Gm-Message-State: AOAM530RmOyka8OBitIs9uQm1tonucHYuCo36/O8vkg9pucAR+vgltsL
        s39Ozk81XzMhhkLo9iAfZSyer40DJRsq5A==
X-Google-Smtp-Source: ABdhPJxI5A12WfjhIpKU1q8aHjBpHtVeCEkedOkazEWaDVAuM5xlWJaLTR9YwGgAHnZmikOHhX1Y/g==
X-Received: by 2002:a4a:abcd:0:b0:35d:9b36:62f3 with SMTP id o13-20020a4aabcd000000b0035d9b3662f3mr2450026oon.14.1652978745137;
        Thu, 19 May 2022 09:45:45 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id i20-20020a9d6114000000b0060ae5f10973sm575601otj.15.2022.05.19.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:45:44 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, sre@kernel.org, jon.lin@rock-chips.com,
        zyw@rock-chips.com, zhangqing@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4 v7] dt-bindings: Add Rockchip rk817 battery charger support
Date:   Thu, 19 May 2022 11:45:30 -0500
Message-Id: <20220519164533.1961-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519164533.1961-1-macroalpha82@gmail.com>
References: <20220519164533.1961-1-macroalpha82@gmail.com>
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

