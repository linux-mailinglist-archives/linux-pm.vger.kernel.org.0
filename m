Return-Path: <linux-pm+bounces-10688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CBE928795
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEFB241D5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9961494D8;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoM4hH0/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D3148853;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178008; cv=none; b=e//GxiyG619bgUnZj21/2q1eTunBR86J2EnMr4SVkFUBeYvfUQfJhH/sBtaT90bWVxRVbaC/KBdEVbSOYhxnaIfbGkoynYbo9o095DhjtKCes9VAJptObrPsqrSXi5QJeg5ZuXZ/raPgZc98XaXtBvi5i30Zt6SdGR6w0yl85yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178008; c=relaxed/simple;
	bh=HryCnz5qoaUXH/FBSiZsvPjDEnxJY2JJUVkJawwHDVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZ68XcESeibcKYWuoQU09FTBJSoS7ZOB3Qs0uAvAFoAHOHt0OTnVFUjZf6Fy25r8/mx2+hGVmPknJGbU3uVdpe1/CtoZltD1oaOF2vdyg2CDE9wA9CnJorl1hQeEoqwXmQXRaWiSarD3uHLTcs8+jsUHwK2oLy1iOJ3xZCYM/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoM4hH0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6282FC4AF0A;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178008;
	bh=HryCnz5qoaUXH/FBSiZsvPjDEnxJY2JJUVkJawwHDVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UoM4hH0/f8OvRpZci/CA9xk1NWZnkijbFp1/8mZg6BIGvdFsjffJQb7JzYZfenicb
	 iBg6dnFS64ASjqiQUSPhI3P9QlTYig0/jmGS5y0omlRIwUSsQ79okmOTQFEgv543BO
	 aVEe7LSGRDz9BhsfrJHkoUZJmTioqlJ19uJsejG3KskOMzYtYlUbvt4skqQiDGdmDq
	 ao/CFPh2y6AtK5A+Vi+PqK9ow/OCm30Md/lR9ZwsPc/RndDM+UPQB6LFzx/tEE7Kb8
	 lBuwETdiTXrqUS/u+udSuNW95NK+WOZ7LjFHBaqqTk+Pc5gC4SIrdk3C47S/b8bPo3
	 zSwZ4X0VLKchQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA62C3271F;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 05 Jul 2024 19:13:25 +0800
Subject: [PATCH 1/3] dt-bindings: power: Add power sequence for Amloigc WCN
 chips
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-pwrseq-v1-1-31829b47fc72@amlogic.com>
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
In-Reply-To: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178006; l=2253;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=Auw5UiFZ9CP6p9qGv3EDPmIfB9jiHZ0hXlsvvoTN/ac=;
 b=A3eWNA2Xhb2xqKFtC1NDx9O6zNPk8xO2nQ2dBMcUTAi9r8HL2TjivlHCg5VDBH6AYeEOK2Ear
 1bvNUV8YZQHAuYjZKvMOISrEVof3wJSwqigoXnWT8ZWMn5eoq8SQYtK
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add binding document to introduce power sequence of
Amlogic WCN chips.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 .../bindings/power/amlogic,w155s2-pwrseq.yaml      | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
new file mode 100644
index 000000000000..f99a775fcf9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/amlogic,w155s2-pwrseq.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/amlogic,w155s2-pwrseq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic power sequence for WCN chips
+
+maintainers:
+  - Yang Li <yang.li@amlogic.com>
+
+description:
+  The Amlogic WCN chip contains discrete modules for WLAN and Bluetooth. Power on
+  Bluetooth and Wi-Fi respectively, including chip_en pull-up and bt_en pull-up,
+  and generation of the 32.768KHz clock.
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,w155s2-pwrseq
+      - items:
+          - enum:
+              - amlogic,w265s1-pwrseq
+              - amlogic,w265p1-pwrseq
+              - amlogic,w265s2-pwrseq
+          - const: amlogic,w155s2-pwrseq
+
+  clocks:
+    maxItems: 1
+    description: clock provided to the controller (32.768KHz)
+
+  clock-names:
+    items:
+      - const: ext_clock
+
+  amlogic,chip-enable-gpios:
+    maxItems: 1
+    description: gpio specifier used to enable chipset
+
+  amlogic,bt-enable-gpios:
+    maxItems: 1
+    description: gpio specifier used to enable BT
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - amlogic,chip-enable-gpios
+  - amlogic,bt-enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    wcn_pwrseq {
+        compatible = "amlogic,w155s2-pwrseq";
+        clocks = <&extclk>;
+        clock-names = "ext_clock";
+        amlogic,chip-enable-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+        amlogic,bt-enable-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+    };

-- 
2.42.0



