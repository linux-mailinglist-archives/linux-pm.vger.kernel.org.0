Return-Path: <linux-pm+bounces-40715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C8D1853C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76506304323D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A553806B8;
	Tue, 13 Jan 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dI8R5Q8v"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C835342C88;
	Tue, 13 Jan 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302014; cv=none; b=rzXGLo1LyyApZW40kZI2YtZO+sY8QjzA17kwMhavxSAgSH7EoZJjdAWI5BwCSI0eUom/ADZ1zmugcdo7HCZE9LQpPsa4PZ3YnDSq6GRgzzP4iCq8QpBhiu6VDp+fnwWEUB/l4FmXdPNWV0LMykmiaf0onRISNi/pM7XBGxxBABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302014; c=relaxed/simple;
	bh=YrrX4LhkIqhiJ1xMnYBI7HsHkhFKyR5kTvGyFViGPiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcFyM0uWeRd/posZ1PkKoUL6iNcoBQJ3FiS5VgYWVu7y3lKLy2abcaJgXyR3bWg9CkqeTrR60MYwFrExiI3+OvUbE/IK32FOjcBX8tsgRemOgfHBrHOyN2mq9sZd7khg/djRfnX9PHl6+8YdEzTGtxicwsFu72MbpqhOmxcBFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dI8R5Q8v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302006;
	bh=YrrX4LhkIqhiJ1xMnYBI7HsHkhFKyR5kTvGyFViGPiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dI8R5Q8vld24qRwJNodGjix4Zz9uisevI8kIPKqTZRNe0eLhRBxANCyYmNBH4nW2u
	 jEDrci1Epx+jv1X5mLqScrcPntPDHy39dqcXsEGX+uBhPbv/nrWJcE5Y38NTjY7da2
	 lT35tyVC/r7xkjDnnaeVIZZ1YL4EAi6mDMBw0jo4CfIUgJm5vO546zZPAyg/LGUkxP
	 RAeYx86Q3FVVCRNW9/cF8J6RgOoq6uAY0vHz/56udMTqyxgKRiY/95ZvW0i63K3O0i
	 cauCRPOWFSiasmdhZ/UodGK/jwur88HvHYcTfV91wdFDNP+xG3kTMtUahtZ5NK3dO+
	 rCCvZrfS/sfvQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A53F17E10F4;
	Tue, 13 Jan 2026 12:00:05 +0100 (CET)
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
Subject: [PATCH 1/6] dt-bindings: mfd: mediatek,mt8195-scpsys: Add mediatek,mt6795-scpsys
Date: Tue, 13 Jan 2026 11:59:55 +0100
Message-ID: <20260113110000.36953-2-angelogioacchino.delregno@collabora.com>
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

Add a new compatible for the SCPSYS IP block found in the MT6795
Helio X10 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
index 1cb9d6797b92..4cafa381979b 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     items:
       - enum:
+          - mediatek,mt6795-scpsys
           - mediatek,mt6893-scpsys
           - mediatek,mt8167-scpsys
           - mediatek,mt8173-scpsys
-- 
2.52.0


