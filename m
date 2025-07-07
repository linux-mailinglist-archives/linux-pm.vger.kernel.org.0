Return-Path: <linux-pm+bounces-30273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789EAAFB1B9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7367AD55A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33082882CF;
	Mon,  7 Jul 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gUXl0ElY"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B31C1F2F;
	Mon,  7 Jul 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885779; cv=none; b=PLg014seH1FMfcU98ZKN+na0nwwLfIMDK8NQcGZwoQlLHkNVsHx8VYJt9TtujCiZ2QE95I94pbmnjSdjhlH/0zxwCkKkJ556kqak0qE8RDewkIyp6eS0a8mbc1y5UZBx4Ua0FLZMdAAjasX1gRAjF9PV0C44K90M8izQzyuhaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885779; c=relaxed/simple;
	bh=KHr4A5nG0FU7osUHbAlxCjMzJS9aprXshutzewcPyjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXK1VT78Hmf23fbL5/Ba1bAWXa7HxV2BZiL78tP4Op/S+tLBUsPdOpF1P8Y8SI6qPhocfolaWFgLS4aDW72FvHrAYk7U4AzkLbp1PVcVFP6n/V1lBo9xCsWWnIj5V33Jrg4sSUsTK/DhTaPtVOtA/wYxzNKa1Otoy/sI/cEFUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gUXl0ElY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751885776;
	bh=KHr4A5nG0FU7osUHbAlxCjMzJS9aprXshutzewcPyjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUXl0ElYdw1eO6ewpMWumjDgKHXeIxg9jAQu97kgZ8/B3VOxoMaVj3Hn4yVipnFlz
	 rqw8e+0tevEqCCGenOvbXymjP5dAmA/1ca6MgJI6wQ2Xzi7rN900EaDSt+jfS0w7Nh
	 TyYEWFK07bJ21IFfLqxjqyhd0AJXRnQ3bSRa+y9f4EUQ+A0T2oikH3t1uwXZgS5uTy
	 SWrS73PA8A7O6BGZbCNC5/twH/dWwSealJ0RTM7pd0cokSne+lEUGE99AT0Hhr09oH
	 +nS+IKq6ZQTivkTnRHu6liMVpNfa8Tf5/S+wM/+H3bFrQVbRwixW4JRvwP6kRHwmu1
	 eS1oBIJuAjusQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2437F17E053B;
	Mon,  7 Jul 2025 12:56:15 +0200 (CEST)
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
Subject: [PATCH v2 01/10] dt-bindings: memory: mtk-smi: Document #access-controller-cells
Date: Mon,  7 Jul 2025 12:55:56 +0200
Message-ID: <20250707105605.98248-2-angelogioacchino.delregno@collabora.com>
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

Some of the SMI Common HW provides access control to at least
the power controller: document the #access-controller-cells
property and allow specifying it only for MT8183 and MT8365
as those are the only known SoCs with an SMI acting as access
controller.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../memory-controllers/mediatek,smi-common.yaml  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 0762e0ff66ef..74b355a08493 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -74,6 +74,9 @@ properties:
     minItems: 2
     maxItems: 4
 
+  '#access-controller-cells':
+    const: 0
+
   mediatek,smi:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: a phandle to the smi-common node above. Only for sub-common.
@@ -168,6 +171,19 @@ allOf:
             - const: apb
             - const: smi
 
+  - if:  # for SMI providing access control
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt8183-smi-common
+            - mediatek,mt8365-smi-common
+    then:
+      properties:
+        '#access-controller-cells': true
+    else:
+      properties:
+        '#access-controller-cells': false
+
 additionalProperties: false
 
 examples:
-- 
2.49.0


