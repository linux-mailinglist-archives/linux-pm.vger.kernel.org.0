Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B578B0B3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjH1Mj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 08:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjH1MjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 08:39:07 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07686E5;
        Mon, 28 Aug 2023 05:39:03 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8Ax1fBmlexkKYEcAA--.58111S3;
        Mon, 28 Aug 2023 20:39:02 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax98xllexkQrJlAA--.29412S2;
        Mon, 28 Aug 2023 20:39:02 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 4/5] dt-bindings: soc: loongson,ls2k-pmc: Allow syscon-reboot/syscon-poweroff as child
Date:   Mon, 28 Aug 2023 20:38:59 +0800
Message-Id: <2bec39b1001732de60c1521d78e44a45ff94d6b6.1693218539.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693218539.git.zhoubinbin@loongson.cn>
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax98xllexkQrJlAA--.29412S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw1fXF1fJF13tw4fWryfGrX_yoW8Cw13pF
        ZrCwnxKw42vF13Zw1rtFyvkF4rJrWkCFsrGFZrJr1UCr9rX3WYqw43KFn0qa1UArWxXFyU
        XFWI9rWruFn2kwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
        6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jsSdgUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The reboot and poweroff features are actually part of the Power
Management Unit system controller, thus allow them as its children,
instead of specifying as separate device nodes with syscon phandle.

Without it, the reboot/poweroff feature becomes unavailable.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../soc/loongson/loongson,ls2k-pmc.yaml       | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
index 7473c5659929..f9e72b43d10c 100644
--- a/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
+++ b/Documentation/devicetree/bindings/soc/loongson/loongson,ls2k-pmc.yaml
@@ -33,6 +33,18 @@ properties:
       addition, the PM need according to it to indicate that current
       SoC whether support Suspend To RAM.
 
+  syscon-poweroff:
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+    type: object
+    description:
+      Node for power off method
+
+  syscon-reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+    type: object
+    description:
+      Node for reboot method
+
 required:
   - compatible
   - reg
@@ -44,10 +56,25 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    power-management@1fe27000 {
+    pmc: power-management@1fe27000 {
         compatible = "loongson,ls2k1000-pmc", "syscon";
         reg = <0x1fe27000 0x58>;
         interrupt-parent = <&liointc1>;
         interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
         loongson,suspend-address = <0x0 0x1c000500>;
+
+        syscon-reboot {
+            compatible ="syscon-reboot";
+            regmap = <&pmc>;
+            offset = <0x30>;
+            mask = <0x1>;
+        };
+
+        syscon-poweroff {
+            compatible ="syscon-poweroff";
+            regmap = <&pmc>;
+            offset = <0x14>;
+            mask = <0x3c00>;
+            value = <0x3c00>;
+        };
     };
-- 
2.39.3

