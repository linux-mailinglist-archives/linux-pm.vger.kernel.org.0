Return-Path: <linux-pm+bounces-35537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86CBA84E3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 09:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B330116E354
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1C25C816;
	Mon, 29 Sep 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="dyOwIEQ+"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E8216E23;
	Mon, 29 Sep 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132076; cv=pass; b=O/mxlA5Da+rpt5sBu3/dP2rqNN7Wsfg6E26iQzipsfShuDw7kkLxjhtZwFS7E8UrOJ+bp3g+6DC54G2BfmtkTtdzguZWPiV3Apee8gCIzR7ydPQju/qMfNaPHiaCSd/mf5Wdv5dURrdB3O/PGp4T9hfbJCY+7/xadBHe1W+CzU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132076; c=relaxed/simple;
	bh=5gWMGkdYhXs5j+k9aP3QPWoAud9qxdjD8VhYmvI25JA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJKZpflzSZp+Bk0ujUJ4Ij7H72Vmyb6AGRjjbdueulS/9LRvoUZHK6mQgqtd6ZFKPliaiF/bye89Yz7w5WfZ22L8gUfjbXSr9zAxLVc/7focS8nbkBvkdOQ5ENWvhu1GITxxmuDSx2xCEyQDuaELVF+ZrQCHGuW++xPZMfnAtAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=dyOwIEQ+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759132053; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SOWnuBfyx4wo4O6Bu1lVkbkC7iJ1X4ODVrZTSc1gVUqrKbXoWMeNxzhOKmtwHY4RkQnX+FW0NFJzPD7WQrWBvbwikNsdfeT8pBtG/Ay8otTLQXtHr+DqbfBcdS+3EoV7z5eH/8TxeCN2jpqmI3j+TLqc+MN4Noagsu6XNi0Ke2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759132053; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Wltohi1m5SDbJkLhV1v5gx0uRt+qjskx2yr9lkFdxy8=; 
	b=IE6fehIL+J9Vd8swLUDD34BBANiQLaxz0WsM6vHNW4ogBBZLdBCu3xEoFsIKQJAkVfFgFiaWICi9ope1MvwpKvTJIkwqF5D0G4IA76BZ0UNxhKXHtzFDhGuvufarMzcqHk1gM6eEMeZpLMnuQ8udxMuo2363oxo21p4tKzJU8h8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759132052;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Wltohi1m5SDbJkLhV1v5gx0uRt+qjskx2yr9lkFdxy8=;
	b=dyOwIEQ+0F8omspo+25ci3ExlwsUtZW7790twj/InISQ8Hc4rgj32dCVUYGTDmUY
	c248G44tzRGVbXQBj2b0rMIK4UAIp4WpUcCjJ3c+ur8FP1JGdbcEe6rj2p4pSiJqFct
	0/HCOn+NrPmIYobx+Ra9bllEItMfAG/9XQU9KAzY=
Received: by mx.zohomail.com with SMTPS id 1759132050265403.9411869295931;
	Mon, 29 Sep 2025 00:47:30 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 29 Sep 2025 09:46:46 +0200
Subject: [PATCH v5 3/7] dt-bindings: mailbox: Add MT8196 GPUEB Mailbox
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-mt8196-gpufreq-v5-3-3056e5ecf765@collabora.com>
References: <20250929-mt8196-gpufreq-v5-0-3056e5ecf765@collabora.com>
In-Reply-To: <20250929-mt8196-gpufreq-v5-0-3056e5ecf765@collabora.com>
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


