Return-Path: <linux-pm+bounces-15599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF3F99C247
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC71F21482
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535D14D430;
	Mon, 14 Oct 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="XNBqLfi7";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="hGGDTu8O"
X-Original-To: linux-pm@vger.kernel.org
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46221384BF;
	Mon, 14 Oct 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892698; cv=none; b=JcnnF1UL/62RyhvyqHWaltg04vC5s8ULPu8Dv0qvEwPgldokwBKCGajZWb++BbJELIVNK7l+qnKAGD/NnpKLBXM23M2UFanOonmzNuBCapeC4+BzETZCclGKMlSpKPWiXjtBmFZX065pLiLoROr4uPS960Ig/ae52GVuvmjwnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892698; c=relaxed/simple;
	bh=lPoc6pym9DSYQLknNxVyoHOgF8wwG7bJWhc07t4BUfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI0zWUCc91HEMMcFg63kIi1eITAhAMQP2zStEla0cWBmw9e+K8A0iaI7xmT1EBCdu4xFywC23FDdTvog9DUmAN+1RQo1EL/OWao9PZXmvOOdBY1X2tDKf7dLJa2Kggqv5vCaTv/WRAbB3AcVLN/ObO8S3/3umLCawOTKGosrmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=XNBqLfi7; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=hGGDTu8O; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 73092122FE26;
	Mon, 14 Oct 2024 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891525; bh=lPoc6pym9DSYQLknNxVyoHOgF8wwG7bJWhc07t4BUfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNBqLfi7Mg3aScFk8JnEbvZBA21HfmeOGJM6Y7VVpBkau4Nhui0v5Ua2g7KT2t02y
	 MVNcJRLyiXuieb6NzLCgivi23CbCY1Dg+e+FWou+Wr05NGsVh03ghJpV62+srEXtcy
	 YzCkE20l18zZ7KZe+G0zvLYOMtzt3PsiR52HBDG6fArE1wJrGdsQ3+mko9tdnDgChj
	 lwMg/uL2YBdvRDfjwE/oadRfc/CQ/fqXsRR46QiEAY1jq0/afUKW0X1UAGI+qwU6/V
	 iZnqWI8//h8XfyFtFohVS8kLBXC7M/0ahs1LvUov4iKHXGb5IkjDIDKtrf7kR1y8O8
	 fVOBrP4+C6EdA==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7A1VF3tOUE2e; Mon, 14 Oct 2024 00:38:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [110.52.220.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 43A51122FE21;
	Mon, 14 Oct 2024 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891523; bh=lPoc6pym9DSYQLknNxVyoHOgF8wwG7bJWhc07t4BUfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGGDTu8OZMFmxGIKeJkuFmaktpuekIOPExp+WOYDAz88vgV8YsjRJ8UFgUI0Y1zsD
	 9GAZS58elqBBYecsSMI8iL/Aih6VvReW3q9jnb6DO2AyNLwhcNUlGXVxNg0d/XjlPg
	 mYoofXAGXxksWZu9f0sFMvF5xW8JtAg9SseNAbvL7/PREq53RPXrwTD153yKaT3+u+
	 Sv7tv2DRRQR+WwZYVE2tLgNXh1i2/zdTxi4tfPZtf5v9ry8fjGjsuUDxhp9zuPwpoV
	 uvPrWQv+xkfsvsRHXMa4xAWZa06yDwca9rxngnapls3Cp1lLihAa9A/bxr6NIS/ZN3
	 G1OBCpguG8UDg==
From: Haylen Chu <heylenay@4d2.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add Sophgo CV1800 thermal
Date: Mon, 14 Oct 2024 07:38:11 +0000
Message-ID: <20241014073813.23984-2-heylenay@4d2.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014073813.23984-1-heylenay@4d2.org>
References: <20241014073813.23984-1-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding documentation for thermal sensors integrated in
Sophgo CV1800 SoCs.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 .../thermal/sophgo,cv1800-thermal.yaml        | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
new file mode 100644
index 000000000000..14abeb7a272a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 on-SoC Thermal Sensor
+
+maintainers:
+  - Haylen Chu <heylenay@4d2.org>
+
+description: Sophgo CV1800 on-SoC thermal sensor
+
+$ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sophgo,cv1800-thermal
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  sample-rate-hz:
+    minimum: 1
+    maximum: 1908
+    default: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    thermal-sensor@30e0000 {
+        compatible = "sophgo,cv1800-thermal";
+        reg = <0x30e0000 0x100>;
+        clocks = <&clk CLK_TEMPSEN>;
+        interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+        #thermal-sensor-cells = <0>;
+    };
+...
-- 
2.46.2


