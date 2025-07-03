Return-Path: <linux-pm+bounces-30023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF38AF719D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42E24E73D6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA78E2E499C;
	Thu,  3 Jul 2025 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mhi2EzE6"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78002E3AE7;
	Thu,  3 Jul 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540577; cv=none; b=szNuMq5zvGR2fy9SoV1nOvNq61eMCAXMo1ufZ8CFWrFVs/g6KiR1140x5mlvqKA5M6+KEc93c55Q8HCJiCamGh8ALPaKMTEErMJvI/+NoKXovP8WrWGkGRkHh7a4qcL/quYELmckGXY/CdYShtIkFDfrVEmxhntbOWriwmHBkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540577; c=relaxed/simple;
	bh=AEKCOZLewbT3WJ11kuH+FT6CuFYkZkE6eijdU6k3Ymo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDx9F79fDszjhVCln9SO31vMVQ8v+IkkMi8pm9E7pLwk2ZS/4/pQpUTtDPM6WdpiGIiMo5NPzCM4KEhpNhnL9bVPC8fU9VHj19JTMw0sB+otKUU+wuN3Gv5CjyT0LZBQ3tH4KwJ8gWUnQkaLJiXVqhbjocP6EFDyZARsvH94/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mhi2EzE6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751540574;
	bh=AEKCOZLewbT3WJ11kuH+FT6CuFYkZkE6eijdU6k3Ymo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhi2EzE69pP8XHTrNOpYgalSdx9biM5KLOD33MywcZIZ/UM1dUKmq6frIGrZ5tFvf
	 G8+36Dine+6wRx9szYDbO5KfaihxhCUPB+kXuWcRypovB7Bic/5PxeRNQ2fOuDM9j3
	 fc+v51XtLQFyMAeIzNP3/YZBkAxl1IxSDqaxUS55PR7o2WdRT81LnUr8x0dQqrMkqf
	 cxut3Xu5HuMxVTUDpSTTyZJs5IApEBWR2dE+rKDOTeVwDO1CnPDjOGHq6goUw+Qx9b
	 zYb1gh9bY7Jdt8fuo6iAfn6bIC2nMWUgFCzgwPRhWkfV0imbhzSoUHIG6Z3sfzUaNL
	 soo+v93xnp9FQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1763117E0EBD;
	Thu,  3 Jul 2025 13:02:53 +0200 (CEST)
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
Subject: [PATCH 03/10] dt-bindings: power: mediatek: Document access-controllers property
Date: Thu,  3 Jul 2025 13:02:40 +0200
Message-ID: <20250703110247.99927-4-angelogioacchino.delregno@collabora.com>
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

Allow specifying access-controllers in the main power controller
node and deprecate the old mediatek,infracfg, mediatek,infracfg-nao
and mediatek,smi properties located in the children.

This is done in order to both simplify the power controller
nodes and in preparation for adding support for new generation
SoCs like MT8196/MT6991 and other variants, which will need
to set protection on new busses.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../power/mediatek,power-controller.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 9c7cc632abee..82bfd3899b22 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -44,6 +44,17 @@ properties:
   '#size-cells':
     const: 0
 
+  access-controllers:
+    description:
+      A number of phandles to external blocks to set and clear the required
+      bits to enable or disable bus protection, necessary to avoid any bus
+      faults while enabling or disabling a power domain.
+      For example, this may hold phandles to INFRACFG and SMI.
+    minItems: 1
+    maxItems: 3
+    items:
+      maxItems: 1
+
 patternProperties:
   "^power-domain@[0-9a-f]+$":
     $ref: "#/$defs/power-domain-node"
@@ -123,14 +134,17 @@ $defs:
       mediatek,infracfg:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the INFRACFG register range.
+        deprecated: true
 
       mediatek,infracfg-nao:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the INFRACFG-NAO register range.
+        deprecated: true
 
       mediatek,smi:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the SMI register range.
+        deprecated: true
 
     required:
       - reg
@@ -138,6 +152,31 @@ $defs:
 required:
   - compatible
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8183-power-controller
+    then:
+      properties:
+        access-controllers:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8365-power-controller
+    then:
+      properties:
+        access-controllers:
+          minItems: 3
+          maxItems: 3
+
 additionalProperties: false
 
 examples:
-- 
2.49.0


