Return-Path: <linux-pm+bounces-36165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96BABDD85B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523E6543DAE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8631319859;
	Wed, 15 Oct 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="E9fyDYFy"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629863168FD;
	Wed, 15 Oct 2025 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518272; cv=pass; b=khzQdPYwYE4U/H0J/cpA2+0GgeyUUO3J9Sv5jFxt3v1l67zDjLR2cxNmZG4+DC92fMVtl8HS72gjhbfchtjUZsA9Le0GXQKSH3QbTYoZxpmcUU1kYjscVXcjfklbTtongfwo3lyJ1oESDe77Xw5bt2NfVAu2mhgzP21MbIO0HEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518272; c=relaxed/simple;
	bh=H2R3HfhsejISe0TnCg4fYOv7VDMiJ3viJMo3HtiI2VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQnTxdl0EKPyEy+ksueniJy7PylSqdsosENacaT8rlUnPhIjVRZuXOpVAwcDnxoUtb8PP3qt2h34y+UF0515Rd//AUT8XJUMDajqacuUqP+3TwTcCYGQm/1DwoaZKPjMAfC3PgnnRDMRX34WgfFQlNsr9ywEQ7BxFX/P1UfYiN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=E9fyDYFy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760518235; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZPXzDBKZ4Cfd5oO/57hdOSFrdHoED4T26EQmhoxmxrJ54uA2BPDRYcxjRy2jJMH/RSnEMJKt6JP9IfIESW30E1zyg6tAlJ4cIttRZaSf47bSCTWS0n31lpTyz3gnA9Fz2jdpUW2mpG6jbyKgRyQRHoLpr0ESTi96+ysv2XRIyao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760518235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bM73lypABp16DNaPQ/AZd3Rd/UhyQMrclXHvC1Kw7I=; 
	b=T8nFQi76YL1dFUn224XCWoNeX6sJ2eLizyZHbUDtdnetzvmCrsE0pKXAlXbyXSfPuu5L8VdvEEXqWAB37qPEwE/VbQt4oF/cryN0C4imULn+i5hfiS5X2xcnzWAGVxol9igFp/M0IzSRzmNkZPxSPaiBaxu4uyId0A3msi2OPxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760518235;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7bM73lypABp16DNaPQ/AZd3Rd/UhyQMrclXHvC1Kw7I=;
	b=E9fyDYFyfbOYpPIXeosoZa6YfFNYl9MK0eKWPWJGUciPuYXEidYm3J3ZGEPO8I3/
	O0FP7LS4ZdV3UhIk5W/04yg5ALxKGEwl6VT2zGqNqds9doV1+9Xs2jQZQavY6SR3nEi
	AAaklWvI5NmIRPOeC6NIk2rxxO+OjPeyuSnroSqM=
Received: by mx.zohomail.com with SMTPS id 1760518231241936.3238999689235;
	Wed, 15 Oct 2025 01:50:31 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 15 Oct 2025 10:50:01 +0200
Subject: [PATCH v7 2/5] dt-bindings: power: Add MT8196 GPU frequency
 control binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-mt8196-gpufreq-v7-2-0a6435da2080@collabora.com>
References: <20251015-mt8196-gpufreq-v7-0-0a6435da2080@collabora.com>
In-Reply-To: <20251015-mt8196-gpufreq-v7-0-0a6435da2080@collabora.com>
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
X-Mailer: b4 0.14.3

On the MT8196 and MT6991 SoCs, the GPU power and frequency is controlled
by some integration logic, referred to as "MFlexGraphics" by MediaTek,
which comes in the form of an embedded controller running
special-purpose firmware.

This controller takes care of the regulators and PLL clock frequencies
to squeeze the maximum amount of power out of the silicon.

Add a binding which models it as a power domain.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/power/mediatek,mt8196-gpufreq.yaml    | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml b/Documentation/devicetree/bindings/power/mediatek,mt8196-gpufreq.yaml
new file mode 100644
index 000000000000..b9e43abaf8a4
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


