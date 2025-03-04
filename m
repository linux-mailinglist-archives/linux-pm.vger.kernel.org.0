Return-Path: <linux-pm+bounces-23382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE1A4E3AA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0091F8A2064
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053E281363;
	Tue,  4 Mar 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QPCJ5GE8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC527F4C7;
	Tue,  4 Mar 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101376; cv=none; b=Qnm2vqYJD2b+WhGN/g6ZjcwUW+CJ4nGaUSY+NJs9/LgBsYDTLIer98yS/JOndmVZTmIbDAHqgPMihk7uzjFfPfvHM+qyT03uqHqtPTpZ8AGtgQNi3kwA3rIVB8wseM6d4NCOkjd4f/KiPWs5N20V8etRks7I+dFnIJgABrTqNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101376; c=relaxed/simple;
	bh=sv7vt2JjPvah5UEUTejJW8tA4asG5xEJWZ5yqaPrTtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOrkL3zl8YmVVbHnjtSIjZtX4I/TvRPl7rPb/Kso4Otiz5/Mi/p7s7emjkVrs92iT21V4P74PHoUScwVE2pKwg1oryEDVdAflDeabs6qGBR2p9gmrjZsxvppwToTGiwAQlrX0bxsAau8+MEuBmeqMHtBtDlBtgfM/Pzf+qofEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QPCJ5GE8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741101373;
	bh=sv7vt2JjPvah5UEUTejJW8tA4asG5xEJWZ5yqaPrTtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QPCJ5GE8Yie0IXMbI3fkiqyq+XY4XVLqX+fpGOul1EMU3uYNOOWNTt5Z/sLZ3RSOd
	 SNkyjLJtWiZ8wm8T1b5xhLOfoD0wmcb84E49JPQ7lzLEu+EfC8frHcy7fgjYFlIkSg
	 CnUDIZJgGxeXbCWiIuT+cOR4+VDlR5Yk7/l2xXsN3PmQt/h7nAD9167J6iwNAZKxgz
	 NtSeSzFnxYZcC0EJ5gTAeljq5+eqrzp6zEqctEhwCL4L5JDLRpFSxU2atTUVgY3+U6
	 IQz+pZYgMOAMDKnh/NQpRCJHLO0PHpwHMSHTqZ4TVXwtP7Mv8LVmxSNfZU4Ew2narM
	 xXL2hZGdcraAg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 11C8E17E07F8;
	Tue,  4 Mar 2025 16:16:07 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 12:15:42 -0300
Subject: [PATCH v3 01/20] ASoC: dt-bindings: Add document for mt6359-accdet
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt6359-accdet-dts-v3-1-5b0eafc29f5b@collabora.com>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
In-Reply-To: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Add dt-binding for the MT6359 ACCDET hardware block.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../bindings/sound/mediatek,mt6359-accdet.yaml     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1d27148ed7bffee3f73015c8af88bfffa8701843
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt6359-accdet.yaml
@@ -0,0 +1,42 @@
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
+description:
+  The MT6359 Accessory Detection block is part of the MT6359 PMIC and allows
+  detecting audio jack insertion and removal, as well as identifying the type of
+  events connected to the jack.
+
+properties:
+  compatible:
+    const: mediatek,mt6359-accdet
+
+  mediatek,hp-eint-high:
+    type: boolean
+    description:
+      By default, MT6359's HP_EINT pin is assumed to be pulled high and
+      connected to a normally open 3.5mm jack. Plug insertion is detected when
+      the pin is brought low in that case. Add this property if the behavior
+      should be inverted, for example if a normally closed 3.5mm jack is used,
+      or if the line is pulled low on open.
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
+        mediatek,hp-eint-high;
+    };

-- 
2.48.1


