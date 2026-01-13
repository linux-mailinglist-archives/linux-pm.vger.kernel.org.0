Return-Path: <linux-pm+bounces-40717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A9D1852A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54CB2305B4FE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188038BDB4;
	Tue, 13 Jan 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mc+Pm4+b"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3538A70F;
	Tue, 13 Jan 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302016; cv=none; b=a0Yfg97H80TUqGhi+BglI/hkCMkwry7cs4M4uQPD9y34UGp25VpM2jaa+VZuYrgpwVo6ViK+JRqIhGL6+OWkKfe9x0TlV4QDpaRScY/o/woVhgX4a+QZsEuExwOwFrGg3HzV4z6uwiebOb48IaSbsBlwWPYijGkZSJcl/P0y76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302016; c=relaxed/simple;
	bh=f/A/I/VodskiOgbzllbCrqIcjWpEWW93JtNibaeAlv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMDvLlxrX2CfgjopDzE2UBxmVKYwEpkE98Y8rKpWMOCXBR59QcgZLKR9Wsz1gxJOutaoa/flj9s9fDd+0HVMVci4WQjQvBcjE3bwyvarlY8s3gyYO59nRQZwtZNhjx/NPaTTTja949iwV2dQtUsDM5gEZ+E9P/Mp+fOi0olruf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mc+Pm4+b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302007;
	bh=f/A/I/VodskiOgbzllbCrqIcjWpEWW93JtNibaeAlv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mc+Pm4+befzqQwqspF5nC4T6pKeG5ShW1g6eENK5nAMUVoeBkTeeB2EQ1bTA1LB1g
	 BCSxDZTRpMyCp+DZukMIY4Iup9LBI7lF2ieqsOwNxrcwiUL8KOd8iRn9+MOXqS2YOf
	 MI/ZPQc4kCCf1O44KU/KD+Q3f8mFCtT0//JUzO1xgim8eePhRTylKIgTuTRstJw0W/
	 5sAdg8NxeV0vIM/+KHMcg6a9Kqgs4+0wTypuvxobO2Cy6KWksAzl9qbGYiUMm6uNkP
	 nRgUL2FAw9tK1HX9ElhObXOAHPcr9U/QjraIM6W6trWWgKKJpG75nR7/C/8S5ZTPKn
	 mtE5jKA6QLVMQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2037D17E150D;
	Tue, 13 Jan 2026 12:00:07 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sen.chu@mediatek.com,
	sean.wang@mediatek.com,
	macpaul.lin@mediatek.com,
	lee@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 3/6] dt-bindings: regulator: mediatek,mt6331: Add missing ldo-vio28 vreg
Date: Tue, 13 Jan 2026 11:59:57 +0100
Message-ID: <20260113110000.36953-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
References: <20260113110000.36953-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT6331 has a "ldo-vio28" regulator but this was missing in the
list: add it to resolve a dtbs_check warning.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/regulator/mediatek,mt6331-regulator.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
index c654acf13768..eb16e53cb5bf 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
@@ -40,13 +40,13 @@ patternProperties:
 
     unevaluatedProperties: false
 
-  "^ldo-v(dig18|emc33|ibr|mc|mch|mipi|rtc|sim1|sim2|sram|usb10)$":
+  "^ldo-v(dig18|emc33|ibr|io28|mc|mch|mipi|rtc|sim1|sim2|sram|usb10)$":
     type: object
     $ref: regulator.yaml#
 
     properties:
       regulator-name:
-        pattern: "^v(dig18|emc33|ibr|mc|mch|mipi|rtc|sim1|sim2|sram|usb)$"
+        pattern: "^v(dig18|emc33|ibr|io28|mc|mch|mipi|rtc|sim1|sim2|sram|usb)$"
 
     unevaluatedProperties: false
 
-- 
2.52.0


