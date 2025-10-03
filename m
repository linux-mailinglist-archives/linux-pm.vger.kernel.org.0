Return-Path: <linux-pm+bounces-35704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B53BB812D
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFED1B20F30
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688F254B18;
	Fri,  3 Oct 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Z4+erogT"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97BF23AB81;
	Fri,  3 Oct 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522594; cv=pass; b=OXWEOtozNv6XMmeEw3AbiG+eu5VKEtlATlvsJuHnYXzaQ6g9xUucdDqYaQofXrxWzvUpgqK4detPek8uISE40WwOhg/9+DV+vFYcibwX4SZJT51EFkEciN/2250Td2FoZQ4Qob/xpvntRl6NxzD+77qxyKu4dTFgHfhrClwa7x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522594; c=relaxed/simple;
	bh=B9+iSsDq6Y2Xn6HaaMA/DQYg/3MUR47dxKFt2/z8GUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTaFBzpR/KphTlYCZ5lM70YoKipYyKrdWVCF8Xs3dZBka4Zal+eyT6y2r36BC2ClD/X6vbrIUc/y7FmcdUsUB2hG3fq8YRGfmncAlylNxLUhaVvAgCaxgSu3ja/62Xkmriw7jAq0r+SRVeEQ7KvZt9jiTns9GVW6As5aCWsV4A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Z4+erogT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759522545; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HmtINvFXYSZlri46KuZFWW0pqwUwDq6TJRed9FP+bEqHBpKrLCRdtp7olE4ud/yjDRmYhDZtcHoVMAPEgMCGkHyRX8ubzI8c6Tfi2YNIgiT3cbKiSGcaNzDsTGhz9PV7vyEoD29oq0Ud+JGBuSBoIiFUwHmKpROSGbCqEfrmzFo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759522545; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UJP0eLgRH0wRaLU3TMJnGjeyircwL3R7LtmsPmO+Txo=; 
	b=RUGuUXwLGPvU74ziZ221LKro/oWZqsCRAsz+PyLfsdJGy2WWZvqxpbWS8LOYYPwpBvgtkatME/jBUgW1wo83V6CDsM+YLp91e1Nt4Um0oCs1ig88voR9kkPFdKeXsMCEN+uBeqd8u9cvXk2unQf4jvTFVabWItOddwee6scV368=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759522545;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=UJP0eLgRH0wRaLU3TMJnGjeyircwL3R7LtmsPmO+Txo=;
	b=Z4+erogTXxKTZuK9I6uSLWOjbGEIJ0dDhMb/zCXxV+5+wXEsjFUKsQBJV3Ob98mH
	qVJ5gFy8ieV1yjVgRtDFCToxyRDkR55znYacIQGEE97t5HoPTNtJA/eK8l7XKfHLr8D
	toKYl1NljwNS5i5FND1NGgcgf0BmIMSBh85EYx6E=
Received: by mx.zohomail.com with SMTPS id 175952254376424.063998239129887;
	Fri, 3 Oct 2025 13:15:43 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 03 Oct 2025 22:15:04 +0200
Subject: [PATCH v6 2/7] dt-bindings: power: Add MT8196 GPU frequency
 control binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-mt8196-gpufreq-v6-2-76498ad61d9e@collabora.com>
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

On the MT8196 and MT6991 SoCs, the GPU power and frequency is controlled
by some integration logic, referred to as "MFlexGraphics" by MediaTek,
which comes in the form of an embedded controller running
special-purpose firmware.

This controller takes care of the regulators and PLL clock frequencies
to squeeze the maximum amount of power out of the silicon.

Add a binding which models it as a power domain.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/power/mediatek,mt8196-gpufreq.yaml    | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b9e43abaf8a42ce981ce16648fb3350b9c262015
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/mediatek,mt8196-gpufreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MFlexGraphics Power and Frequency Controller
+
+maintainers:
+  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+
+description:
+  A special-purpose embedded MCU to control power and frequency of GPU devices
+  using MediaTek Flexible Graphics integration hardware.
+
+properties:
+  $nodename:
+    pattern: '^power-controller@[a-f0-9]+$'
+
+  compatible:
+    enum:
+      - mediatek,mt8196-gpufreq
+
+  reg:
+    items:
+      - description: GPR memory area
+      - description: RPC memory area
+      - description: SoC variant ID register
+
+  reg-names:
+    items:
+      - const: gpr
+      - const: rpc
+      - const: hw-revision
+
+  clocks:
+    items:
+      - description: main clock of the embedded controller (EB)
+      - description: core PLL
+      - description: stack 0 PLL
+      - description: stack 1 PLL
+
+  clock-names:
+    items:
+      - const: eb
+      - const: core
+      - const: stack0
+      - const: stack1
+
+  mboxes:
+    items:
+      - description: FastDVFS events
+      - description: frequency control
+      - description: sleep control
+      - description: timer control
+      - description: frequency hopping control
+      - description: hardware voter control
+      - description: FastDVFS control
+
+  mbox-names:
+    items:
+      - const: fast-dvfs-event
+      - const: gpufreq
+      - const: sleep
+      - const: timer
+      - const: fhctl
+      - const: ccf
+      - const: fast-dvfs
+
+  memory-region:
+    items:
+      - description: phandle to the GPUEB shared memory
+
+  "#clock-cells":
+    const: 1
+
+  "#power-domain-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - mboxes
+  - mbox-names
+  - memory-region
+  - "#clock-cells"
+  - "#power-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
+
+    power-controller@4b09fd00 {
+        compatible = "mediatek,mt8196-gpufreq";
+        reg = <0x4b09fd00 0x80>,
+              <0x4b800000 0x1000>,
+              <0x4b860128 0x4>;
+        reg-names = "gpr", "rpc", "hw-revision";
+        clocks = <&topckgen CLK_TOP_MFG_EB>,
+                 <&mfgpll CLK_MFG_AO_MFGPLL>,
+                 <&mfgpll_sc0 CLK_MFGSC0_AO_MFGPLL_SC0>,
+                 <&mfgpll_sc1 CLK_MFGSC1_AO_MFGPLL_SC1>;
+        clock-names = "eb", "core", "stack0", "stack1";
+        mboxes = <&gpueb_mbox 0>, <&gpueb_mbox 1>, <&gpueb_mbox 2>,
+                 <&gpueb_mbox 3>, <&gpueb_mbox 4>, <&gpueb_mbox 5>,
+                 <&gpueb_mbox 7>;
+        mbox-names = "fast-dvfs-event", "gpufreq", "sleep", "timer", "fhctl",
+                     "ccf", "fast-dvfs";
+        memory-region = <&gpueb_shared_memory>;
+        #clock-cells = <1>;
+        #power-domain-cells = <0>;
+    };

-- 
2.51.0


