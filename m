Return-Path: <linux-pm+bounces-34854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B5EB7D657
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE66D18887DD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151EC30CB51;
	Wed, 17 Sep 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="S5CaLcum"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF952FBDF1;
	Wed, 17 Sep 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111820; cv=pass; b=Ur1GPT1eB05Tnwe8yEkAYVf+UO9iGv1RlkapM3IWdogyJc46UyqHtpZP/QYVEkWNgaBZsAY0alGbkhgn+AfvdJHaD1jA9LVbacSZzFuzBIno8ZGAoLdFgLmXP4KWnDxc0bJQg5npnaXEFMRDL9BThJouSC4MemoX5idPeA/UP7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111820; c=relaxed/simple;
	bh=9f6gmPt02hURiCDSOZMJjp6AiCDZWoTKE4B2L93oIl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqhwtoOSHuXZTLdzDTcLGf0ou7bckbLnIGLaD+vSU4/pu6sGATI3Ec3CAZvCrV2a2nWxncH7DIQuiGlU6duEootTssiYMz3VgzGRB+ChZq+x7FPGnaEiqjnd3Ui2MoE6oZMJDxPP13JzxMqkXZTfBg470+FaFWpD0d0QaOA9Oww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=S5CaLcum; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758111792; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QnWCOGsclrlkOoC4bYtcIHMJLCnzcOWM6YhnWHWO5Dyhyo7eF2rNlvw9zKQ9BSHpkZtw6/NysgTYVmuUAzkNl4Zi91NQd5GRe6J1z+W8K3hdKemkq7qde4EL4scfxa+MUScteFkjxLM98S5ZRI6vmIqJBFSYXUohMn5QDXuw8as=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758111792; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TSOOSd0q3nKiD0MBVwkJ48zGfTq+ks978YmNhkmC9YQ=; 
	b=hRSrA2kA/tSk+NX+0d1Zb5anC1B7ESaFGVF1AOreEfo7DGbZUGGIZisxOKkClYicQlxEQVcz3IR6CNOkhMGIPnHIhyLPh+VzrrFD+4zJRWbN/pNqVG5AOTKnwC+0Xx+/7zJmpKIYSsLeKmzYhH4/jQqkJgEfl8/ElFgdQpOZiCU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758111792;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=TSOOSd0q3nKiD0MBVwkJ48zGfTq+ks978YmNhkmC9YQ=;
	b=S5CaLcumJ7rs6Md6yy14/YJvYczWvvUpwNFjmMUjD0g7S1Wj+04QKuS1T0IUFd9B
	GgHD85qqt9/veXEPcVgF+sjXfLQ6Wc0UdNrcB4N2T1YiW82lXghQczAKnqqoJ/C4xkK
	PKqkvKOS80BM9h8ZjVE4oEEyRJRUEKkb2qU/rt0M=
Received: by mx.zohomail.com with SMTPS id 1758111789568560.3619392555413;
	Wed, 17 Sep 2025 05:23:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 17 Sep 2025 14:22:33 +0200
Subject: [PATCH v3 02/10] dt-bindings: devfreq: add mt8196-gpufreq binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-mt8196-gpufreq-v3-2-c4ede4b4399e@collabora.com>
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
In-Reply-To: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

On the MediaTek MT8196 SoC, the GPU has its power and frequency
dynamically controlled by an embedded special-purpose MCU. This MCU is
in charge of powering up the GPU silicon. It also provides us with a
list of available OPPs at runtime, and is fully in control of all the
regulator and clock fiddling it takes to reach a certain level of
performance. It's also in charge of enforcing limits on power draw or
temperature.

Add a binding for this device in the devfreq subdirectory, where it
seems to fit in best considering its tasks.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/devfreq/mediatek,mt8196-gpufreq.yaml  | 112 +++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/mediatek,mt8196-gpufreq.yaml b/Documentation/devicetree/bindings/devfreq/mediatek,mt8196-gpufreq.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b1c6751662c085eccdead038a2edc61e4bfc5f5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/mediatek,mt8196-gpufreq.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/mediatek,mt8196-gpufreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MFlexGraphics Performance Controller
+
+maintainers:
+  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+
+description: |
+  A special-purpose embedded MCU to control power and frequency of GPU devices
+  using MediaTek Flexible Graphics integration hardware.
+
+properties:
+  $nodename:
+    pattern: '^performance-controller@[a-f0-9]+$'
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
+  shmem:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the shared memory region of the GPUEB MCU
+
+  "#performance-domain-cells":
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
+  - shmem
+  - "#performance-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
+
+    performance-controller@4b09fd00 {
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
+        shmem = <&gpufreq_shmem>;
+        #performance-domain-cells = <0>;
+    };

-- 
2.51.0


