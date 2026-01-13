Return-Path: <linux-pm+bounces-40716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD14D18569
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3538330D9EC0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895F38B986;
	Tue, 13 Jan 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NchR6Gia"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2042EA48F;
	Tue, 13 Jan 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302015; cv=none; b=kjqhIhzmznH46NVOPMScyUCN/f5DM4vW4QVWXq2CK3TxW85Sm670z8uykWe48Z3kGaJXPdLczUdSAM0Q8ta6IP7KOGPT+d/ovV7Dvv84JGI/rCNx1ZVvyy7Sf8BPtENYw+FaqTlD23xkQri6N5WpBb4RCpOuwYAbqQPcpQruxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302015; c=relaxed/simple;
	bh=4gfA9VmbxP2vBCiTv/gwlonLU9/zD7M1Pt71XFpBBZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3J6biG1XWT+zn79OJoHev3WBqpebOUSvp4c9V8C0aimFHjZfxB6CBujowNHP1rPlTX/Gp722l7F1eUSreKWI7/JIhmZvIIDCROlIlJCcRAnSFLOlnSveGW7hQEx6p66P2LtiDWKg0IbfYe2TSMu0/ljE3XyN8gpQ2JkRSyw0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NchR6Gia; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302006;
	bh=4gfA9VmbxP2vBCiTv/gwlonLU9/zD7M1Pt71XFpBBZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NchR6GiaUooHTre3WtFcSqbZZGslJfanSyStpK9aZzu8lB94FGIXkxyU5sl8QSVq/
	 MHqWHa86C2Yg+GtFFGaFtlmqTQ+5T1BKlHTlbNrx10nb5AKeWePCAGq2xC1WXve7yw
	 PhsLBD7nrxWJTrduInsxO37Y+uscNvonlahaDWRes0haPnGJVLJmzhBYieEgi8wGP3
	 s8waVxtfXmbE4bAjptp7EC8tjTEMJzEQUUfS3RQSJxH6nyXd1pj3/woskLiSiULz40
	 bFg4UucITHsobve8lFAaGJ2WWJgtlUemrFFoI0vlpYaPvuOYXQdsMweXlXOz/jnttu
	 j0kZiyyxaN7Ow==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4847117E1406;
	Tue, 13 Jan 2026 12:00:06 +0100 (CET)
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
Subject: [PATCH 2/6] dt-bindings: mfd: mediatek: mt6397: Add missing MT6331 regulator compat
Date: Tue, 13 Jan 2026 11:59:56 +0100
Message-ID: <20260113110000.36953-3-angelogioacchino.delregno@collabora.com>
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

Add the missing mediatek,mt6331-regulator in the compatible string
list for the regulators subnode.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10f..05c121b0cb3d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -90,6 +90,7 @@ properties:
           - enum:
               - mediatek,mt6323-regulator
               - mediatek,mt6328-regulator
+              - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
               - mediatek,mt6397-regulator
-- 
2.52.0


