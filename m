Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7E13F382
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 19:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbgAPSmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 13:42:19 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390300AbgAPSmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 13:42:18 -0500
Received: from localhost.localdomain ([37.4.249.101]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mleo0-1jIw7L3qrK-00ioZF; Thu, 16 Jan 2020 19:41:50 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] dt-bindings: brcm,avs-ro-thermal: Fix binding check issues
Date:   Thu, 16 Jan 2020 19:41:17 +0100
Message-Id: <1579200077-17496-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:+sPxTCFhphlG3yB/Vx1rT4zv4v7XQNBXEsZUG8nOQTMLN/8oNU1
 cIQrMr4QLHa06BxUeULkTm8FrfWFhdn3mPaqN4tH3TBTXUdVufXlCUcTyj/PHhw6sgBcMTA
 mZx6vCFItqhZnVkuio0WoafXGl9Rs68tikhSvXXdLUXjSDmuepTiEJYCEWJUZh7wwxSA0wr
 w0LTrbo+7cE9tmdYbr1wQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+jcCjposBx0=:yyC7jsIe/of8jUKuHeITgu
 aXK8OBpK/gxv+jhxC/xLDqrj+EQsV55PYLfzhgtNyOzU8bAqhW2KJj69StMrp/PPIExIcljYA
 /NKnN584ptFLAUPLEZIJhzRTWYKErS7Qyy11PUlxJlAGWN4d9xpyU78LaeZIkzENnShU5gFP2
 ABEV0+TqsHRWN9wRs4hW5b5Vr5JTsDMk59PpXMryJlxq1pAd+jXXbkAisQA0p692SObeeE2ZA
 JCgwNiSoVO65Embq7fzXx206TuS1T6Ni1qYLdcnz2t6d540k0EX4Uznciz+quVmEOFIwpEje4
 5HYf1zDbeXdiQD2lElEQx3kiPDJIv3zUpGbvlEhG1aTm5yGYU+/gq3VrmhWHBIqRWVyyU8lqE
 CKux+OgG9+C0CW/Ubh4Q6DJk0SDf+snQVYqBDj/i08YTK7XT9lB5YDbnLUF4+LMOF90pH2n4k
 5SJCuvNRluII63acZiMwR2R8JtD4MV1YcH+2saetnTwzVlOiwxrzjX8hF6fiOGJFS1Zq02HlD
 7AR7JfLd8mpG+8d/Fo+ysomcsyOekC72hYrcpXKCCEezDML1QXz+kyjpOUKBjtmbs7z/EEhZH
 s0cZo5ImMqzAznfg55k0Dr9DqsEq27GiVRU2n3mjX3n2Zcn+FZWW8vZCIfFs6zpQn6dIKv1vN
 dZbtEiCoNjvSG24HGs0lICT3VZrlSIkN073iDLF1p4ylHpgTeiX0fO+qo+9ccGUyW2sSa3PIV
 a15ftUAtAGstL4K/uJ9V4E2VyDuLC3ZGp+FvsQrocWUUkI+lzqnEPEiY0oHcsFfers/JbzOSm
 ygFJhwQotapC0SFx5vQjLaJboailcGKVIn9VXiHryFv8+GfLX4xyDm0LI+cjiAT7tiRmn8zFa
 +cHIfWHSP0PRHTBAuWw3BAY62wsz7dl4364I1V+cs=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop the reg property since this only necessary for the parent and
add the missing thermal-sensor-cells property description.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 3d4849897691 ("dt-bindings: Add Broadcom AVS RO thermal")
---
 .../devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml         | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
index 98e7b57..d9fdf48 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -23,12 +23,15 @@ properties:
   compatible:
     const: brcm,bcm2711-thermal
 
-  reg:
-    maxItems: 1
+  # See ./thermal.txt for details
+  "#thermal-sensor-cells":
+    const: 0
 
 required:
   - compatible
-  - reg
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
 
 examples:
   - |
-- 
2.7.4

