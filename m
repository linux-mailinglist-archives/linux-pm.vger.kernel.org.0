Return-Path: <linux-pm+bounces-35703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45DBB8124
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 22:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99F1E4EF3BD
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D943324A06A;
	Fri,  3 Oct 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ne6J81sj"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61BC236454;
	Fri,  3 Oct 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522592; cv=pass; b=bjE8MybEJxp6XCE1DCfPR2Xmv41izdBqSUCz0/SDVZ93s0VHKYqtVIVUrkTKrvRdgiHwo1ZRufjQUiOQh4AXRX53YZnG+HkOJlWJI8VWNRIcBrImUoZS52Q+o3PO2YDmFv4IuPtjHZz5oRa6XKhnk/Fn55rGCrpNYl35G5JAA1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522592; c=relaxed/simple;
	bh=5gWMGkdYhXs5j+k9aP3QPWoAud9qxdjD8VhYmvI25JA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJfvunyRqAdBni9GiDGVJ5mXClDYFSudR4WwqNzyEtx7qEovhDwQU0aGcBOr6kTyg2MQkUKisnRJKoJeXX9XXCmo6trvhdWdq//dzMFrflBejOnHgrfwPH/Rb0IkhMRWSD7wFQTay3m6sGvoxPbnnVYlWuW0THyAMTjCmT96yvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Ne6J81sj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759522551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZHUrgik/Z3cz6MIsOzVAJyXkbEtMxNnHDDttdCbsV8+q25asbGRN0S0D+Jxos6mT2r/UxhMh4UGV+L6q0gGldAQnp1ZVFj81ejx45VDw1TQE8HcsTHdajK5OSUwlyDVmvPwNgWUCOQx7lUzoynxXUQ373546GSVnt2EpPow0PG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759522551; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Wltohi1m5SDbJkLhV1v5gx0uRt+qjskx2yr9lkFdxy8=; 
	b=W9A1gmJg71b2pDzj43GRq1TIjdQtPtDP+81cIabJFk1jC2vblqF7nxquaqKz7oF1+2cMyzmCfgMh+7NMclagZIezeZArTdDFCORNlsto0oWHgUmdkVNUOkvIPXEE0pebsFyxwZOaz7h2K678k1k2rUlcjGd2P26uPpVkwcD7ZbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759522551;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Wltohi1m5SDbJkLhV1v5gx0uRt+qjskx2yr9lkFdxy8=;
	b=Ne6J81sjyHPkawZ8cmKyg6xfqKhdd+8T4LoRz3OcACs8C5/KeYaSZIgJSMwP+0Wd
	q5SagKPgE5gwgIMOAEyYsG2XgG2Db3Y7tSn74spLl6b601t20n1Py1y5ZU0gti+8XQ0
	fRiUFYvn4xb4Mj8gfNudTe2UhDuz0z64uqereuFE=
Received: by mx.zohomail.com with SMTPS id 1759522549318401.20665073138446;
	Fri, 3 Oct 2025 13:15:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 03 Oct 2025 22:15:05 +0200
Subject: [PATCH v6 3/7] dt-bindings: mailbox: Add MT8196 GPUEB Mailbox
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-mt8196-gpufreq-v6-3-76498ad61d9e@collabora.com>
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
In-Reply-To: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hardening@vger.kernel.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

The MediaTek MT8196 SoC includes an embedded MCU referred to as "GPUEB",
acting as glue logic to control power and frequency of the Mali GPU.
This MCU runs special-purpose firmware for this use, and the main
application processor communicates with it through a mailbox.

Add a binding that describes this mailbox.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../mailbox/mediatek,mt8196-gpueb-mbox.yaml        | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbox.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ab5b780cb83a708a3897ca1a440131d97b56c3a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-gpueb-mbox.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mediatek,mt8196-gpueb-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MFlexGraphics GPUEB Mailbox Controller
+
+maintainers:
+  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8196-gpueb-mbox
+
+  reg:
+    items:
+      - description: mailbox data registers
+      - description: mailbox control registers
+
+  reg-names:
+    items:
+      - const: data
+      - const: ctl
+
+  clocks:
+    items:
+      - description: main clock of the GPUEB MCU
+
+  interrupts:
+    items:
+      - description: fires when a new message is received
+
+  "#mbox-cells":
+    const: 1
+    description:
+      The number of the mailbox channel.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mailbox@4b09fd80 {
+        compatible = "mediatek,mt8196-gpueb-mbox";
+        reg = <0x4b09fd80 0x280>,
+              <0x4b170000 0x7c>;
+        reg-names = "data", "ctl";
+        clocks = <&topckgen CLK_TOP_MFG_EB>;
+        interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH 0>;
+        #mbox-cells = <1>;
+    };

-- 
2.51.0


