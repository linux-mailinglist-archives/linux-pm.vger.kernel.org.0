Return-Path: <linux-pm+bounces-6168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED989EF26
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EABE1C214A5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF815885C;
	Wed, 10 Apr 2024 09:49:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB172156F23;
	Wed, 10 Apr 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742568; cv=none; b=hhkRTi0R/UVpz73fEcrlS/6NWg7UxFkyRpDnD++5ylpjt5JPNxz4v3E6k+d9iB01tv6ESFnSXdGoI98wDC2EL59W/JwYHwho3IVisafGsccdjeZIPlMYiT9cTmgvm6JB7lQSP5T+z29UW5UIVm/KlBwbjo7W0i8G+Q1Bju2pI/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742568; c=relaxed/simple;
	bh=dCh7wsYn/sidy+QkhPu5sh5AobkM9piAescsjCjTvjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNcl5wbU0SWmc2ZFcJi4Tj5kBDUcUQLum58f7RSyF23zx6x9WUEOphciWZwMAlQtqf0EcCL+5qeAEco2QBhJINVv5PN6blwgM3MkH9+JHEkEPGYo7+dRQl17h7U6M7b0Ti2tWKUySwZyq9b3TDMvSxy4ZJVkHNx/v810uy76Aq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8DxOLqeYBZmIS8lAA--.4244S3;
	Wed, 10 Apr 2024 17:49:18 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxSRKZYBZmXlV3AA--.21925S5;
	Wed, 10 Apr 2024 17:49:17 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	WANG Xuerui <git@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 3/4] dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible definition
Date: Wed, 10 Apr 2024 17:49:02 +0800
Message-ID: <217ce2745a8787c504bbda1d085daba7e9cb2f70.1712733065.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712733065.git.zhoubinbin@loongson.cn>
References: <cover.1712733065.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxSRKZYBZmXlV3AA--.21925S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1DCFyDur1DArW8Jr4DJrc_yoW8Cr4kpF
	sxCa15Kr1kKF17C39xAFWkCwsYvr93tanrXFs2kF1Ygws8G34av345KF1Yqa1fCry0qFyU
	Zr10kr4UCayDC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=

The temperature output register of the Loongson-2K2000 is defined in the
chip configuration domain, which is different from the Loongson-2K1000,
so it can't be fallbacked.

We need to use two groups of registers to describe it: the first group
is the high and low temperature threshold setting register; the second
group is the temperature output register.

It is true that this fix will cause ABI corruption, but it is necessary
otherwise the Loongson-2K2000 temperature sensor will not work properly.

Fixes: 72684d99a854 ("thermal: dt-bindings: add loongson-2 thermal")
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../thermal/loongson,ls2k-thermal.yaml        | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index 9748a479dcd4..a25b42702788 100644
--- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
@@ -18,14 +18,15 @@ properties:
     oneOf:
       - enum:
           - loongson,ls2k1000-thermal
+          - loongson,ls2k2000-thermal
       - items:
           - enum:
               - loongson,ls2k0500-thermal
-              - loongson,ls2k2000-thermal
           - const: loongson,ls2k1000-thermal
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -41,6 +42,23 @@ required:
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls2k2000-thermal
+
+then:
+  properties:
+    reg:
+      maxItems: 2
+
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.43.0


