Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110BD70EA4C
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 02:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjEXAel (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjEXAek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 20:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598FCD;
        Tue, 23 May 2023 17:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3A5163208;
        Wed, 24 May 2023 00:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3224CC433D2;
        Wed, 24 May 2023 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684888478;
        bh=eb7MQ0gJQceyQWoKkAr/p+wkRYtO3rruBw03PEtrdDs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=uhcbhZzrcckqZQZ5XrWVLdJ+/IyEfhmEKarasMfXs/N/3mG0odYp1dJFWP/44mLbn
         3DipWB8e2ZDgOxqTSz/G1S/2+u4n45ZEZRRzVRAw5lmm6MH6ygsZ34jaTyZlW/Wf2W
         CnyI/TL3PIEZ+uhzbPBuNZH8tiML8Bo02CAg8/vo55gZAIs4wSwCcu9p4K1/h1qccQ
         JwGstn5+GrGCCpBC1HYaYnzKchxqzZASN0mugS+Y8cGw9nyFOJKmVhQHsTj0B6N4JD
         HH4OW+paF5Iw0rumRniJlkHo7Lp9I5rHAtMY6soXJfY3gUE4t6V5+PYb7hZ4/iS6EU
         ptvVFUIPO7UDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 10F69C7EE29;
        Wed, 24 May 2023 00:34:38 +0000 (UTC)
From:   Caleb Connolly via B4 Relay 
        <devnull+caleb.connolly.linaro.org@kernel.org>
Date:   Wed, 24 May 2023 01:34:17 +0100
Subject: [PATCH v8 1/2] dt-bindings: power: supply: qcom,pmi8998-charger:
 add bindings for smb2 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230524-pmi8998-charger-v8-1-b87ffcd9864d@linaro.org>
References: <20230524-pmi8998-charger-v8-0-b87ffcd9864d@linaro.org>
In-Reply-To: <20230524-pmi8998-charger-v8-0-b87ffcd9864d@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-1ec66
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=mAKhQB4vMKOTIi4ptw5/6sx61rxVOFQj12BF/0V6Wf4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBkbVuca91BFBxEWn37qyjvWZIrMB0BwpMgCgKCs
 cJ8M3sZRReJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZG1bnAAKCRAFgzErGV9k
 tmgbEACjPSDR8eI8EsY4Om5WGMdOAO/tbAfYF0j8s33wbRWawjdCBg3GQNdrk3wMLA0yRzWXfVp
 GI9whTjT9mdQD9vRSWdFjh1MYynIXKMSjDQpSadw28WGFu2yiHsmdHNo3KGoaWPicvS55Z1iKv7
 dKRkRMmkDPsqjCLaFfs2LT7rif3y0l1bY5vyNXZVBkZTYSuVcbJV557QZCHCMt8FntRv1h/ni7T
 kkR83slKYrmEPMdMxqjc2A7cx3WtNHLrSPaUxCATzMrZXnIN8JvsD1Q/VMEHhFquZb8y5FD+H4g
 a3KU6AHASEAtOlRKRIuHB47ydPMQRdF1N6r5rf1hWHoSUpb2Gjy37ur1xTcL2Ng7lzEIy6sMJV0
 3Ubxc04LH8h4BS2RHNuFzixylLqmi8QxBNplVA/MlW8ue103toTf6A+2KHxYSbQOjE/bwHXX4h5
 Y47CFZ0HpfXxmXA0a8srIENWgBWVcVjRKREeepxU1VW4WP101z+lJBO+C8D0vogEqvc1j5XmyLh
 lFlikCA0H4jzEoDPvZmIdD2mKNXpc8kRJYtMRTgj2PhlJQv8SVy4nww7IYzvh0CE1oC6x3lMvSy
 GXtLYN22rD3MlqP6aEYj61lNLvfKoRfRLHCgRb6OsMZQKokJ5D1/etPw56pYZDlZndHpOqX6Ueq
 Q0ywnBAAzqGrYMw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Endpoint-Received: by B4 Relay for caleb.connolly@linaro.org/default with auth_id=49
X-Original-From: Caleb Connolly <caleb.connolly@linaro.org>
Reply-To: <caleb.connolly@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Caleb Connolly <caleb.connolly@linaro.org>

Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../power/supply/qcom,pmi8998-charger.yaml         | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
new file mode 100644
index 000000000000..277c47e048b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pmi8998-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-charger
+      - qcom,pm660-charger
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: usb-plugin
+      - const: bat-ov
+      - const: wdog-bark
+      - const: usbin-icl-change
+
+  io-channels:
+    items:
+      - description: USB in current in uA
+      - description: USB in voltage in uV
+
+  io-channel-names:
+    items:
+      - const: usbin_i
+      - const: usbin_v
+
+  monitored-battery:
+    description: phandle to the simple-battery node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #interrupt-cells = <4>;
+
+      charger@1000 {
+        compatible = "qcom,pmi8998-charger";
+        reg = <0x1000>;
+
+        interrupts = <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
+
+        io-channels = <&pmi8998_rradc 3>,
+                      <&pmi8998_rradc 4>;
+        io-channel-names = "usbin_i",
+                           "usbin_v";
+
+        monitored-battery = <&battery>;
+      };
+    };

-- 
2.40.1

