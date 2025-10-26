Return-Path: <linux-pm+bounces-36840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C799C0A715
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 13:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C9914E3A95
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0814EACE;
	Sun, 26 Oct 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="jzFkCQ0r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF310E3;
	Sun, 26 Oct 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481846; cv=none; b=uvWBXBqDoG7L+bDqonmIRCF1hHoD5D18bG+MACzUMaRNYVKLz0xmg61LhhcdJqq9TV4czYo+VU4AilOWIcAFlAlwgPqA4qJCWBnrBtkl58jVgtSLrxc4pSIhiWXmaTeVi6ojTNAcH0N6ISM21d/EZgtdxjbzumtnMgod0NLSNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481846; c=relaxed/simple;
	bh=FYbtBW4yebr7GZlwdi/roTYzRuQuBFijpmv4L+YCcvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1VRr3p77TtPi7zYRHLJdCYd7UtVnPBmoSN2fUJyTsiKUQE5BZekH34jpZT1AW7+E4sBfFw9/kPtGzrs3Zv0b5SzgBjU+qxRJMhNgS0Cf4zeg2E9pqJU2FDMNSgTinstzIXUIEKFPk5u+xk028jbkqmXtWrT5PaDIaForycUyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=jzFkCQ0r; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id EAA3160666;
	Sun, 26 Oct 2025 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1761481325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utgZIgZouZ2rivSw9fdUqvFMGknqClgIGWmWeoQd928=;
	b=jzFkCQ0rm5xX/AZDOCLrqTZSn5am4MENCC0H+Ho2xlaXNHXFgJ+AKsYvXjQeqZpOg6wnjb
	sPKmZvIwR5nnDZUB+kEYwVgNSXKErXUBoXuXLCUBbExorNtKZaNfeUL24rDCftc4ry0Poo
	b96b3Ur9mhDC6x3sKXiF1rhmN9LZh1Q=
Received: from frank-u24.. (fttx-pool-217.61.154.70.bambit.de [217.61.154.70])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id AA9F51226F7;
	Sun, 26 Oct 2025 12:22:04 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 1/5] dt-bindings: thermal: mediatek: make interrupt only required for current SoCs
Date: Sun, 26 Oct 2025 13:21:30 +0100
Message-ID: <20251026122143.71100-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026122143.71100-1-linux@fw-web.de>
References: <20251026122143.71100-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Upcoming MT7987 does not have a IRQ we have to make interrupt-property only
required for current supported SoCs.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../bindings/thermal/mediatek,lvts-thermal.yaml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 0259cd3ce9c5..7ec9c46eef22 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -58,6 +58,16 @@ properties:
 allOf:
   - $ref: thermal-sensor.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7988-lvts-ap
+    then:
+      required:
+        - interrupts
+
   - if:
       properties:
         compatible:
@@ -75,6 +85,9 @@ allOf:
         nvmem-cell-names:
           maxItems: 1
 
+      required:
+        - interrupts
+
   - if:
       properties:
         compatible:
@@ -91,10 +104,12 @@ allOf:
         nvmem-cell-names:
           minItems: 2
 
+      required:
+        - interrupts
+
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
   - resets
   - nvmem-cells
-- 
2.43.0


