Return-Path: <linux-pm+bounces-40724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF1D1856C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 560A8305C6BB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF6738FF04;
	Tue, 13 Jan 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kn6uZ/m7"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8238B7A2;
	Tue, 13 Jan 2026 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302020; cv=none; b=eqiC7rcTxvUvCR7Waf4Gs1KbB6BORatmBhPA7jNRGb1LLLsiddv+N7L3d3x2cs+Tg5EX4n04aJ5IgW651zo7xtBd0+7YGRnphLGZlDifhlQWqIW7xP5EbuCvjXUeRWchYFhodOfNI8gOiLyr0AD5EPM84e7hj0pcbI76lVgP26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302020; c=relaxed/simple;
	bh=Tr1QlgpyH4V/BMEcHr0IvsfySZs0/Z/SUCzxP2lKDwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G97mCekrxsm1l2vHhAOTF53jeHxjb1ujSmkd17smDOdjiupunQTYku567F+IrLuOpcSpzmuuuYGxOo+jKhLhzfID58R9AAvzteJ4w7y19JkVyxywSZx8zm57gI9Y4uY/GDbrLwIJ9dsR13rfgwOcuG+95GJ8r2e7cGmPRz7f/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kn6uZ/m7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302015;
	bh=Tr1QlgpyH4V/BMEcHr0IvsfySZs0/Z/SUCzxP2lKDwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kn6uZ/m7jSwNQJqMNHb9+Hpuon9dUySJ4tnP5xf/piraEdEWy2U4zBtdtK7XfKarU
	 yhRnB8nm37ohZO8c3Cl9f2d5yt6/GspLDbJubfkw29Er72Jz9vTV6k1y6vMn4ucZiF
	 O13NDxJhj3VjaPiR54HjOo1nV54lhwrnzZOpCGkEjJEwXCkXZz98tIGFqxiSTsVRv4
	 L/+bcZ7FKDAfaAO7ZzquHDt6DT8s/vSUsOHg/v80hivxiM5nudJwm6I+PhQdIySHMF
	 JcEGdC/rCJcMIgUMJMnp4QvOBEqavclPCjrN7DMv1nmj/7fqXYFh+fwWq/YQeO7Zgq
	 GwIdfBevb8R4Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BE62217E10C8;
	Tue, 13 Jan 2026 12:00:14 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 1/5] dt-bindings: clock: mediatek,mt7622-pciesys: Remove syscon compatible
Date: Tue, 13 Jan 2026 12:00:08 +0100
Message-ID: <20260113110012.36984-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIESYS register space contains a pure clock controller, which
has no system controller register, so this definitely doesn't need
any "syscon" compatible.

As a side note, luckily no devicetree ever added the syscon string
to PCIESYS clock controller node compatibles, so this also resolves
a dtbs_check warning for mt7622.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/clock/mediatek,mt7622-pciesys.yaml        | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
index 9c3913f9092c..c77111d10f90 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
@@ -14,11 +14,9 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: mediatek,mt7622-pciesys
-          - const: syscon
-      - const: mediatek,mt7629-pciesys
+    enum:
+      - mediatek,mt7622-pciesys
+      - mediatek,mt7629-pciesys
 
   reg:
     maxItems: 1
@@ -40,7 +38,7 @@ additionalProperties: false
 examples:
   - |
     clock-controller@1a100800 {
-        compatible = "mediatek,mt7622-pciesys", "syscon";
+        compatible = "mediatek,mt7622-pciesys";
         reg = <0x1a100800 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
-- 
2.52.0


