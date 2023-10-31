Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407517DCB61
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjJaLGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 07:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjJaLGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 07:06:08 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00832A6;
        Tue, 31 Oct 2023 04:06:03 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.17])
        by gateway (Coremail) with SMTP id _____8AxTeuZ30BlcO41AA--.34699S3;
        Tue, 31 Oct 2023 19:06:01 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.17])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxE+SU30BlHm03AA--.56085S2;
        Tue, 31 Oct 2023 19:05:58 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 1/2] dt-bindings: thermal: loongson,ls2k-thermal: Fix binding check issues
Date:   Tue, 31 Oct 2023 19:05:49 +0800
Message-Id: <944559ea3bf7ba0a1540f831ccd7d33591622b22.1698743706.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1698743706.git.zhoubinbin@loongson.cn>
References: <cover.1698743706.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxE+SU30BlHm03AA--.56085S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4DXw43uF4DZrW3Zry3KFX_yoW8XryDpF
        43CryDCr1kKF17Aws0yFy8CwsxtF9Yyasrurs2kw15tFZ8Ja4aq345Kr1qq3yrCr10qFy7
        urZ29r4UCFyDArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzgAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the missing 'thermal-sensor-cells' property which is required for
every thermal sensor as it's used when using phandles.
And add the thermal-sensor.yaml reference.

Fixes: 72684d99a854 ("thermal: dt-bindings: add loongson-2 thermal")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../bindings/thermal/loongson,ls2k-thermal.yaml        | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index 7538469997f9..b634f57cd011 100644
--- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
@@ -10,6 +10,9 @@ maintainers:
   - zhanghongchen <zhanghongchen@loongson.cn>
   - Yinbo Zhu <zhuyinbo@loongson.cn>
 
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -26,12 +29,16 @@ properties:
   interrupts:
     maxItems: 1
 
+  '#thermal-sensor-cells':
+    const: 1
+
 required:
   - compatible
   - reg
   - interrupts
+  - '#thermal-sensor-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -41,4 +48,5 @@ examples:
         reg = <0x1fe01500 0x30>;
         interrupt-parent = <&liointc0>;
         interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+        #thermal-sensor-cells = <1>;
     };
-- 
2.39.3

