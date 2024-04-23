Return-Path: <linux-pm+bounces-6872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8468ADBBD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 03:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5FB1B22C3F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18207175BE;
	Tue, 23 Apr 2024 01:59:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE3C14A8E;
	Tue, 23 Apr 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713837565; cv=none; b=pboB4ojtvwclRR0VxNrbDq46UKl68zFYbjwWKxnkL4T0XOVCfSgLHMh/G26GxXgWUxoJzAVWR7UhdhhYqAW48NmRNLzYWooVjxXYbZtykaB5vdF6fukYhLvW0RcdHLd1Pz7R1fvpfk8qvGlxUuq2h2tDPXeO34aUdJmtFi86p1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713837565; c=relaxed/simple;
	bh=2CJf77h+baOWS6JwuGv5UWHsTGuRb5wG3Iv7oZw3HNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z11eTOdslPs3ryECck0LjqO36mAUID4ZSJqXYgjvV7HverWr3GywUjU1WGQCIuo5rjp/O1iAZcMheoCrFESyf24przwzh3XNFpAx9xwk7I6j9CMLTmQFOkXejPz3lNc77nwya0T4IHgY0lB6tGGauh8cjtVt2QjREhrMIhw8/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxSfH5FSdmCh4BAA--.6823S3;
	Tue, 23 Apr 2024 09:59:21 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnlfxFSdmX+EBAA--.2983S5;
	Tue, 23 Apr 2024 09:59:20 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible definition
Date: Tue, 23 Apr 2024 09:59:02 +0800
Message-ID: <5198999d679f1a1c3457385acb9fadfc85da1f1e.1713837379.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713837379.git.zhoubinbin@loongson.cn>
References: <cover.1713837379.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnlfxFSdmX+EBAA--.2983S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1DCFyDur1DArW8Jr4DJrc_yoW8ZryUpF
	sxCa15Kr1vkF17C398Aa48CwsYvr93tanrXF4Ikw1Ygws8J34Svry5KF1Yqa1fCF10qFWU
	Zr10kr4UCa1DC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYE_NUUUUU=

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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../thermal/loongson,ls2k-thermal.yaml        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index 9748a479dcd4..ca81c8afba79 100644
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
@@ -39,6 +40,24 @@ required:
   - interrupts
   - '#thermal-sensor-cells'
 
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
+      minItems: 2
+      maxItems: 2
+
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


