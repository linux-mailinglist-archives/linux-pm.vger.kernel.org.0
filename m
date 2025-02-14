Return-Path: <linux-pm+bounces-22091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452FA36449
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2D51895704
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6CF26869E;
	Fri, 14 Feb 2025 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fyVuWwIz"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F5268686;
	Fri, 14 Feb 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553563; cv=none; b=g86vXVZrqB/6/2gQ/3uYFRGJPDxZz14QnaLJ/ab5gLwppz6rp0Jph0TzayPINSXhWELcOKX1qSMAd+To00Rr+fQiRVwR+STaYIO0G+TsBTB2FFO/AgS8+aVISgHwMDWa0FPZGaFDhoARFKWV13i3iLxk7XODCSiQzT32Rtc4W3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553563; c=relaxed/simple;
	bh=0R9z82uYLHvZq/ZMlFXfZkW3m4VdLNpXjo+5ho6sUN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urZClvZCqBxT6gbexzxQDdgH/O93d9i1Fqe2+e+LCcAKcvXgWH4hw+SrrGQwtALwetJQg5gxUL/vGDW32anvn4YrGavEg6vtWVuP2JO1+oOb1XrFYzEXJ1AaRj8Q+QB1nrQdkpo3z22BRfFGV0ObEzQw9AlYmd7gQUxe8wUfVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fyVuWwIz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739553559;
	bh=0R9z82uYLHvZq/ZMlFXfZkW3m4VdLNpXjo+5ho6sUN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fyVuWwIzp04LN5oANUcC1i84G4bqMTDULj87UfWPrvUvacBfKFAb/xweQUyLiCL/m
	 dWM/GxLwrIu+qgwET9T902Ckh6Or9NWwq245VMX51O+/fBsZMiLsW9ENrWuvLPKiM3
	 zUczZ/KfbOyaRH6M2w2ZjlUk/EAla8zx/cs9t7DfH68VpUo5YqNJKrMFxw7zvJ8/hx
	 4RyxAm02E08doRQB1fR96GuOaLFvq2JQk8QOTclE9QHiCOmhJiR8IIVC4lRm6Hrz1J
	 AmdCcsOOvgs5sZdFVze+RWesFQMbK/A11LfE7rXSQjM05sWUJJPI+q4PsDB6furluc
	 kuFcYRXmgeliA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4759717E0FC1;
	Fri, 14 Feb 2025 18:19:15 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 14:18:32 -0300
Subject: [PATCH 01/13] ASoC: dt-bindings: Add document for mt6359-accdet
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt6359-accdet-dts-v1-1-677a151b9b4c@collabora.com>
References: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
In-Reply-To: <20250214-mt6359-accdet-dts-v1-0-677a151b9b4c@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Add dt-binding for the MT6359 ACCDET hardware block.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../bindings/sound/mediatek,mt6359-accdet.yaml     | 293 +++++++++++++++++++++
 1 file changed, 293 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8922003d3b9d039d2a0355add7a90cf42b1a9da6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
@@ -0,0 +1,293 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt6359-accdet.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6359 Accessory Detection
+
+maintainers:
+  - Nícolas F. R. A. Prado <nfraprado@collabora.com>
+
+description: |
+  The MT6359 Accessory Detection block is part of the MT6359 PMIC and allows
+  detecting audio jack insertion and removal, as well as identifying the type of
+  events connected to the jack.
+
+properties:
+  compatible:
+    const: mediatek,mt6359-accdet
+
+  mediatek,mic-vol:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: MIC bias1 output voltage setting
+    enum:
+      - 0 # 1.7V
+      - 1 # 1.8V
+      - 2 # 1.9V
+      - 3 # 2.0V
+      - 4 # 2.1V
+      - 5 # 2.5V
+      - 6 # 2.6V
+      - 7 # 2.7V
+      - 8 # 2.8V
+      - 9 # 2.85V
+
+  mediatek,mic-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Mic mode setting
+    enum:
+      - 1 # ACC
+      - 2 # DCC mode. Low cost mode without internal bias
+      - 6 # DCC mode. Low cost mode with internal bias
+
+  mediatek,eint-cmpmen-pwm-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EINT CMPMEN PWM width
+    enum:
+      - 0 # 50ms
+      - 1 # 80ms
+      - 2 # 100ms
+      - 3 # 200ms
+      - 4 # 400ms
+      - 5 # 500ms
+      - 6 # 800ms
+      - 7 # 1000ms
+
+  mediatek,eint-cmpmen-pwm-thresh:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EINT CMPMEN PWM threshold
+    enum:
+      - 0 # 1ms
+      - 1 # 2ms
+      - 2 # 4ms
+      - 3 # 5ms
+      - 4 # 8ms
+      - 5 # 10ms
+      - 6 # 20ms
+      - 7 # 30ms
+
+  mediatek,pwm-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: PWM width
+    minimum: 0
+    maximum: 65535
+
+  mediatek,pwm-thresh:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: PWM threshold
+    minimum: 0
+    maximum: 65535
+
+  mediatek,pwm-rise-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Rise delay for PWM
+    minimum: 0
+    maximum: 65535
+
+  mediatek,pwm-fall-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Fall delay for PWM
+    minimum: 0
+    maximum: 65535
+
+  mediatek,debounce0:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for state 0
+    minimum: 0
+    maximum: 65535
+
+  mediatek,debounce1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for state 1
+    minimum: 0
+    maximum: 65535
+
+  mediatek,debounce3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for state 3
+    minimum: 0
+    maximum: 65535
+
+  mediatek,debounce-auxadc:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for AUXADC
+    minimum: 0
+    maximum: 65535
+
+  mediatek,eint-debounce0:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for EINT state 0
+    enum:
+      - 0 # 0ms
+      - 1 # 0.12ms
+      - 2 # 0.25ms
+      - 3 # 0.5ms
+      - 4 # 0.75ms
+      - 5 # 1ms
+      - 6 # 2ms
+      - 7 # 4ms
+      - 8 # 8ms
+      - 9 # 16ms
+      - 10 # 32ms
+      - 11 # 48ms
+      - 12 # 64ms
+      - 13 # 128ms
+      - 14 # 256ms
+      - 15 # 512ms
+
+  mediatek,eint-debounce1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for EINT state 1
+    enum:
+      - 0 # 0ms
+      - 1 # 0.5ms
+      - 2 # 0.75ms
+      - 3 # 0.9ms
+      - 4 # 1.5ms
+      - 5 # 1.8ms
+      - 6 # 3ms
+      - 7 # 3.5ms
+      - 8 # 3.8ms
+      - 9 # 16ms
+      - 10 # 32ms
+      - 11 # 48ms
+      - 12 # 64ms
+      - 13 # 128ms
+      - 14 # 256ms
+      - 15 # 512ms
+
+  mediatek,eint-debounce2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for EINT state 2
+    enum:
+      - 0 # 0ms
+      - 1 # 0.5ms
+      - 2 # 0.75ms
+      - 3 # 0.9ms
+      - 4 # 1.5ms
+      - 5 # 1.8ms
+      - 6 # 3ms
+      - 7 # 3.5ms
+      - 8 # 3.8ms
+      - 9 # 4ms
+      - 10 # 4.5ms
+      - 11 # 5ms
+      - 12 # 7ms
+      - 13 # 9ms
+      - 14 # 19ms
+      - 15 # 25ms
+
+  mediatek,eint-debounce3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for EINT state 3
+    enum:
+      - 0 # 0ms
+      - 1 # 0.12ms
+      - 2 # 0.25ms
+      - 3 # 0.5ms
+      - 4 # 0.75ms
+      - 5 # 1ms
+      - 6 # 2ms
+      - 7 # 4ms
+      - 8 # 8ms
+      - 9 # 16ms
+      - 10 # 32ms
+      - 11 # 48ms
+      - 12 # 64ms
+      - 13 # 128ms
+      - 14 # 256ms
+      - 15 # 512ms
+
+  mediatek,eint-inverter-debounce:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Debounce time for EINT inverter
+    enum:
+      - 0 # 0ms
+      - 1 # 0.12ms
+      - 2 # 0.25ms
+      - 3 # 0.5ms
+      - 4 # 0.75ms
+      - 5 # 1ms
+      - 6 # 2ms
+      - 7 # 4ms
+      - 8 # 8ms
+      - 9 # 16ms
+      - 10 # 32ms
+      - 11 # 48ms
+      - 12 # 64ms
+      - 13 # 128ms
+      - 14 # 256ms
+      - 15 # 512ms
+
+  mediatek,eint-detect-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EINT detection mode
+    enum:
+      - 0 # Higher detection power
+      - 1 # Lower detection power
+      - 2 # SW moisture detection mode1
+      - 3 # HW moisture detection mode1
+      - 4 # HW moisture detection mode2
+
+  mediatek,eint-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EINT interrupt that should be enabled
+    enum:
+      - 0 # EINT0
+      - 1 # EINT1
+      - 2 # EINT0 | EINT1
+
+  mediatek,eint-use-ext-res:
+    type: boolean
+    description:
+      Whether an external resistor should be used for the HP_EINT signal.
+      By default an internal pull-up resistor is used.
+
+  mediatek,eint-comp-vth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EINT comparator threshold
+    enum:
+      - 0 # 2.4V
+      - 1 # 2V
+      - 2 # 1.6V
+      - 3 # 1.2V
+      - 4 # 0.8V
+
+  mediatek,eint-level-pol:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: EINT interrupt polarity
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    accdet: accdet {
+        compatible = "mediatek,mt6359-accdet";
+        mediatek,mic-vol = <8>;
+        mediatek,mic-mode = <2>;
+        mediatek,pwm-width = <0x500>;
+        mediatek,pwm-thresh = <0x500>;
+        mediatek,pwm-fall-delay = <1>;
+        mediatek,pwm-rise-delay = <0x1f0>;
+        mediatek,debounce0 = <0x800>;
+        mediatek,debounce1 = <0x800>;
+        mediatek,debounce3 = <0x20>;
+        mediatek,debounce-auxadc = <0x44>;
+        mediatek,eint-cmpmen-pwm-width = <4>;
+        mediatek,eint-cmpmen-pwm-thresh = <1>;
+        mediatek,eint-debounce0 = <5>;
+        mediatek,eint-debounce1 = <3>;
+        mediatek,eint-debounce2 = <3>;
+        mediatek,eint-debounce3 = <5>;
+        mediatek,eint-inverter-debounce = <0xe>;
+        mediatek,eint-detect-mode = <4>;
+        mediatek,eint-num = <0>;
+        mediatek,eint-comp-vth = <2>;
+        mediatek,eint-level-pol = <IRQ_TYPE_LEVEL_LOW>;
+    };

-- 
2.48.1


