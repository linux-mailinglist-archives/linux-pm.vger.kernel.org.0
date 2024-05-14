Return-Path: <linux-pm+bounces-7803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B238C4F56
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D6E1C20643
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9B7D06B;
	Tue, 14 May 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHFO2gR8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1MAfjo96"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F478691
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681936; cv=none; b=COaHHoYRJZTR+j8GrmOaSNkwc8bg84vt2dFJbDm/SCj0BMGNekLAR9xsrEsl0JTmMO/rKHelNToPPHufRXyI1FRv/Ny7h9RMttN3RUAXLXtwhZHD0xJrlF5nsC2uaQC3Wr3yYfnyF91Hlzu2SwHoUn2aBm8bFacLyCHDPQip+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681936; c=relaxed/simple;
	bh=TlHXdu+mtFSP9tSEN/g8YvmZYNV5/uO8aS4UH2NaQmU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UrUwhFuIOeUBVxiW0ahZW73d4+u39r4BJvgcV7Ma4HBllTgLIYSCVOEeP76etZev9A1xYx5bl3+nWUKtQV83M6E1o0D6k4iTUQTgW71r3ccu1/LBedhgG0qRQdvI7MKEYq1WK+3WcPjRqef4MEdk7Vf2wUGyypqHbFeIM3yaQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHFO2gR8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1MAfjo96; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYxCTFsJZS8YA43Uldq5aOyWl4u6or4Pmbi+cZ27+IE=;
	b=EHFO2gR8j1augAHWF+4Ed7RHRk/S0PxqzLLEhfQDGJ1IF2EcQlwUAXhpRqo6tSzlkDERj1
	isSjWvnnOJI60ksAcicNukKeMvqoQ5nDUmuejMIWr0BIxhcGdvOBVNmc+f+ewDhmqnJO7A
	y4un6avoEx6dldIrUokE9y3MPVnD472Uj/Smd8HmC04H/l+DyxyKDvM/TZfcgXH4SJqbDM
	z2PltgJ3fGUXSkuBu0Q8XotS+Zmvj54Lncx7UhmbQpsh98dot24qlKlux79YoSnYUJqXLk
	CTLs65WqPYxLzZDqGIAedT5xAr5YMQGUFbJxPmal4uk3/FfoK6xSRplXoG2BUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYxCTFsJZS8YA43Uldq5aOyWl4u6or4Pmbi+cZ27+IE=;
	b=1MAfjo96EjTJ46/uuBZD068RlG2dQT6Mn81l6zPhk0pewx9WRqAxYj/9HtRZkHasAIe5u7
	1NuXHM926o1IDyBA==
From: "thermal-bot for Binbin Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] dt-bindings: thermal: loongson,ls2k-thermal:
 Fix incorrect compatible definition
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Binbin Zhou <zhoubinbin@loongson.cn>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: =?utf-8?q?=3C5198999d679f1a1c3457385acb9fadfc85da1f1e=2E17138?=
 =?utf-8?q?37379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
References: =?utf-8?q?=3C5198999d679f1a1c3457385acb9fadfc85da1f1e=2E171383?=
 =?utf-8?q?7379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193292.10875.138258500319101503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     c8c4353685778e75e186103411e9d01a4a3f2b90
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c8c4353685778e75e186103411e9d01a4a3f2b90
Author:        Binbin Zhou <zhoubinbin@loongson.cn>
AuthorDate:    Tue, 23 Apr 2024 09:59:02 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect compatible definition

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
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/5198999d679f1a1c3457385acb9fadfc85da1f1e.1713837379.git.zhoubinbin@loongson.cn
---
 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index 9748a47..ca81c8a 100644
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

