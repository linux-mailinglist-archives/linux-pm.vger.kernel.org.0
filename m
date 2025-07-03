Return-Path: <linux-pm+bounces-30022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD7FAF7198
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C44E68AD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C62E4261;
	Thu,  3 Jul 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AtqbVI5q"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3D2D46D8;
	Thu,  3 Jul 2025 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540576; cv=none; b=OnkIrAF6ZRVRUaSPpuPNwuNZjs5bvRowhDzZK16JJH7YofwwlQdl2PKRj/ESlkBlwRge/rQoDZH9s7KhXhl6x1kU+/GzqVSDRAu1GrnWPz0W48biddWeuE6DTcMTRsUiOzmCrI5aG33dy/9sNdPd9DVQx93Y2no9xIgIAUgM3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540576; c=relaxed/simple;
	bh=FfEf8IjEzBgA7KdoP2f2VYa26/4KslWyDnI+7I3w8CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnfEkqcaaS03bo8HBQN0stpi+8ApLtx434tVoSOxkSAT/KIrqf8T6PCv7EAkh9JWql1YU+PzBEoDVzcGjKKZsQKhaqE/cj+qBhsi3EqSBoXFJbwQfGu98Wp4OkJxCnE4R53F98v5qYE3XBtTzg/QtZUS69xJs2bSTcRnOueE1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AtqbVI5q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751540572;
	bh=FfEf8IjEzBgA7KdoP2f2VYa26/4KslWyDnI+7I3w8CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtqbVI5qDXQmhh/Uz+G519yx06QVmReK+eFyKOSuSCT4RGTuxoQK7EmXzn5LnXllS
	 3OfYPzL4Becd92vdYEPCAuf7cxrUtz1lxx3nBs70f0z2rj+yU/RJzBIsDT31MdKxUC
	 IKsag2eTxFDgOixpcRaHgvCNG5zBeyzwLnsHwvZmlMSb6kN4hstgBLsZwUCNtZSENz
	 8lBSLaxiLMLcCh/X/kp8dBCF+5hZsjz1ZbYI1o7eyxKlrF5EScQAWu6BHORiIn0k/9
	 BGbHLRF1NE+IcL2XXjk+jo8jf5lUpocBHdNYqRwV/NbBATlf9LfG2xQuxETfy2YANw
	 FhaZ42q2omvYQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EA0E917E09C6;
	Thu,  3 Jul 2025 13:02:51 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	y.oudjana@protonmail.com,
	fshao@chromium.org,
	wenst@chromium.org,
	lihongbo22@huawei.com,
	mandyjh.liu@mediatek.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 02/10] dt-bindings: clock: mediatek: Document #access-controller-cells
Date: Thu,  3 Jul 2025 13:02:39 +0200
Message-ID: <20250703110247.99927-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703110247.99927-1-angelogioacchino.delregno@collabora.com>
References: <20250703110247.99927-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the #access-controller-cells property on all of the infracfg
controllers on all MediaTek SoCs, as this always acts as an access
control provider.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/clock/mediatek,infracfg.yaml         |  3 +++
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml | 15 +++++++++++++++
 .../bindings/clock/mediatek,mt8192-sys-clock.yaml | 15 +++++++++++++++
 .../bindings/clock/mediatek,mt8365-sys-clock.yaml | 15 +++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
index d1d30700d9b0..27f1a31c3424 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,infracfg.yaml
@@ -47,6 +47,9 @@ properties:
   reg:
     maxItems: 1
 
+  '#access-controller-cells':
+    const: 0
+
   '#clock-cells':
     const: 1
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 1c446fbc5108..2a1bf9073b7d 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -36,6 +36,9 @@ properties:
   reg:
     maxItems: 1
 
+  '#access-controller-cells':
+    const: 0
+
   '#clock-cells':
     const: 1
 
@@ -48,6 +51,18 @@ required:
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: mediatek,mt8186-infracfg_ao
+then:
+  properties:
+    '#access-controller-cells': true
+else:
+  properties:
+    '#access-controller-cells': false
+
 examples:
   - |
     topckgen: syscon@10000000 {
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
index bf8c9aacdf1e..f1ab8b0e0a98 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
@@ -26,6 +26,9 @@ properties:
   reg:
     maxItems: 1
 
+  '#access-controller-cells':
+    const: 0
+
   '#clock-cells':
     const: 1
 
@@ -38,6 +41,18 @@ required:
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: mediatek,mt8192-infracfg
+then:
+  properties:
+    '#access-controller-cells': true
+else:
+  properties:
+    '#access-controller-cells': false
+
 examples:
   - |
     topckgen: syscon@10000000 {
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8365-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8365-sys-clock.yaml
index 643f84660c8e..b6f074f98db7 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8365-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8365-sys-clock.yaml
@@ -28,6 +28,9 @@ properties:
   reg:
     maxItems: 1
 
+  '#access-controller-cells':
+    const: 0
+
   '#clock-cells':
     const: 1
 
@@ -38,6 +41,18 @@ required:
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: mediatek,mt8365-infracfg
+then:
+  properties:
+    '#access-controller-cells': true
+else:
+  properties:
+    '#access-controller-cells': false
+
 examples:
   - |
     topckgen: clock-controller@10000000 {
-- 
2.49.0


