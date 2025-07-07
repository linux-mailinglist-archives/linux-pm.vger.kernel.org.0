Return-Path: <linux-pm+bounces-30275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A174CAFB1BF
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B353ACC73
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB353299A98;
	Mon,  7 Jul 2025 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j4yvMqnm"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B4296155;
	Mon,  7 Jul 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885781; cv=none; b=t84mcX+mxL0EMRt4RO8SUQxiJsj7g6zDfRSnfl4vZhe5PVT2SuLwRae/ep+GAYJ1P36M31OLzQu0QbfIEa+2bXDXKE/AiNH2vH/NI2P5j3HyPjUaERbVss1eBCo6otruH5fKTkSXsClmuXDCAec3I/UxmfxWGEyFrsI8SaDCIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885781; c=relaxed/simple;
	bh=BGp/by0qy5om0sHBtMnQDXf+Z4hF738kIkEKJDLYgVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5OCaj3eot2mO3kkgMmY9JtgiVLwk2rD0j/uKpIYcccaemt1GLQbfX+FzxLcjCRR5hOlj3MeGTDMONidIE0jnjO/YFJd0D4DP800fv4ee4oi3vmYMQVxMGFgeGyK8QUT3Q83sdsFzPd0M8SvGO83IcS+1gYctHlA3JQJHkdJOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j4yvMqnm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751885778;
	bh=BGp/by0qy5om0sHBtMnQDXf+Z4hF738kIkEKJDLYgVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4yvMqnmQbWWbz/fHOpX9o4cDrOSeZfW+k7klJhncmmbXh8GtdbjRfI1Y23etjweO
	 b5VM4bQoSOC1XuhBOhvYchZBnSAY1rlMnD4zxS/Cwp+4Y2W9jfZ2pd0UEePEB2xFf/
	 k+43/GZItqsamlYfT0/cqa1P2kEMRcsAgNKIL0NmW3HQatmQ+Z7gcNgEEWVeonFAks
	 euYageJJIk7TeTm/BVc2mQhQiwu8SUTAARCJZn6PFHFu5UIaiJHi8SfVSeYPTEsXIo
	 9OE5trqVkN1Ls4PrbDaL2nH1aNKACFE2fb1tFYkwyxe4TsWjEhod8rQY6cimdsY52V
	 apoK9pOqbe7HQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7353817E1110;
	Mon,  7 Jul 2025 12:56:17 +0200 (CEST)
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
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 03/10] dt-bindings: power: mediatek: Document access-controllers property
Date: Mon,  7 Jul 2025 12:55:58 +0200
Message-ID: <20250707105605.98248-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
References: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow specifying access-controllers in the main power controller
node and deprecate the old mediatek,infracfg, mediatek,infracfg-nao
and mediatek,smi properties located in the children.

This is done in order to both simplify the power controller
nodes and in preparation for adding support for new generation
SoCs like MT8196/MT6991 and other variants, which will need
to set protection on new busses.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
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


