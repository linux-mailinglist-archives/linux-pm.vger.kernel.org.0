Return-Path: <linux-pm+bounces-31937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38C7B1AFA8
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597AB7A1F1D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5E24728F;
	Tue,  5 Aug 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qqZTmbMe"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F8235BE8;
	Tue,  5 Aug 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380123; cv=none; b=LdSMql9ccBhEzcBZmb4u182esDCZi8Y2GRlFuKChbAofpS8alGsxdjt2JunybNW7l9sI1rG4n+2bQLdjdbMn4mIgdna6f+f7FUp2BIngaZv06sVY3XJGW+WxunK/QMjxtYu+/S5A6dkUV+3DlV7G1Vwn9YZB24OTkCuk5CgKVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380123; c=relaxed/simple;
	bh=t7Rehz1Jrb0D0nap14L/kwRSRhOnQ0fHBCl9LYwxpeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+n2spN9kaZNKqDI2JtLZPua+289qI/pwyPw4cgmf3SO3wnGP5b5yPiseGUBmJ3k4d4iP6t0dqSdd89CvVS0X9DoSNX7qiLxBPvA8xMMEiwEcS63CtcPHa4GDeP2/ewDQdYIlqaEdeqO1ZkI3BlX20G5NvYSQGzBhAFJlgJH+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qqZTmbMe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754380119;
	bh=t7Rehz1Jrb0D0nap14L/kwRSRhOnQ0fHBCl9LYwxpeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqZTmbMeyuJR1FWoWPIBn1q+u7lDZJx4B4wh8yjAynf3RZJxGZ/opTOFlFSkWsW1S
	 iBtcbDLbFd/TLDVUf/tY69GZWW8AhBPmfkDtHiDyxwTisq5hqv5JRtiug6edzvMT8B
	 woC6N3DzykUt9EJ4eDT+1kg671SfdT8VD2D5pIrsRGVo64VbOOENky9pRjHTv5TVNE
	 o0687OyuN3EnnLhUjtELTcm9Cn00gabEy6gpe7F2omk2ME0PQsUIkq1gMLRuHP+Sm8
	 mwupupeSJbWle1e6j2jSyP5V+ZPbdSDNt7zI7Z4X4HaEI9Vr8Y/uJf/kcf4mEWDJCm
	 fL4J9S+Dx3LVg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4CBB117E07E6;
	Tue,  5 Aug 2025 09:48:38 +0200 (CEST)
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
Subject: [PATCH v3 03/10] dt-bindings: power: mediatek: Document access-controllers property
Date: Tue,  5 Aug 2025 09:47:39 +0200
Message-ID: <20250805074746.29457-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
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
 .../power/mediatek,power-controller.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 9c7cc632abee..500d98921581 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -44,6 +44,15 @@ properties:
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
+
 patternProperties:
   "^power-domain@[0-9a-f]+$":
     $ref: "#/$defs/power-domain-node"
@@ -123,14 +132,17 @@ $defs:
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
@@ -138,6 +150,31 @@ $defs:
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
2.50.1


