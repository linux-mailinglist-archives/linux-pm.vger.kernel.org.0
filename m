Return-Path: <linux-pm+bounces-38361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7FC78BC7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 02EC3322D8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174034B69F;
	Fri, 21 Nov 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YuKux2y8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388534888D;
	Fri, 21 Nov 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723841; cv=none; b=JxCtTWZab7SKAGFEJNmRxEu1QFpUhxY++OmzMy/csU8aiegPIOQGvK7aEQxSG6k7PBNHcfV8UfQlnO7yV4n8fOvpMV/XIefOjJGzSABD+bgJutAXwbT+yPGj4tI1VpJ+IWoZIZxWW9gNPzwbmh4smDYQX/2g6l/d+bmPpsAVFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723841; c=relaxed/simple;
	bh=4DAkv37ea+2d/7BYgVUeJPDn9xhNgNPTUmdoIJAvKNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzqYdAxdRbZXVZrFcTn5CJ4MkW9o3rK3Ix30Hn0tCeIBq/ZuoSutIe5yKfcWvzTNA+9iUZBYtxlY2ySbpvfAmgIA42pLOLMiVnsyEG87mjvBNIN3VnNW5XOyLB1WrKayidZk7YBfc5j66DT8QFFwUaPTrZasH5sO+uYYSibxknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YuKux2y8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763723835;
	bh=4DAkv37ea+2d/7BYgVUeJPDn9xhNgNPTUmdoIJAvKNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuKux2y803kTOAJcF6X2LPMPlw3oOtE2QVU7UxPy8A8RkM1SyqxkdofM7e93VjNjb
	 37c2AcUJT9J+hyhSMJQ9d2FREgcdsKC9I9mlqCRT2XxTX9SDgj1uodXh8+9gciznCk
	 djtHadqgkkdy//S8rmr7wCe+deTIaxGw6izifKBGtam0AmlTt+9yDJMYV0PDFIJ0n+
	 woFJmXbPRRsVJNx1IUrtpas0HeuuOd6jUt5Hl8Ifif1dxV2p163zwF97S5DPMC79hH
	 sHb7l2Ei87LmE8YWsiXeZoYQTFgyVabVKxfJnUyXVPoDyK5/t9O4SiFCkTngtoap6w
	 5D9KdoCisehKw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:c4bf:9969:6e1c:dc69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EDE717E3682;
	Fri, 21 Nov 2025 12:17:14 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com,
	bchihi@baylibre.com,
	frank-w@public-files.de,
	wenst@chromium.org,
	fshao@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v4 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Fri, 21 Nov 2025 12:16:42 +0100
Message-Id: <20251121-mt8196-lvts-v4-v4-9-357f955a3176@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The MT8196 eFuse layout is compatible with MT8186 and shares the same
decoding scheme for the gpu-speedbin cell.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index c9bf34ee0efb..f9323b3ecfc8 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - mediatek,mt8188-efuse
               - mediatek,mt8189-efuse
+              - mediatek,mt8196-efuse
           - const: mediatek,mt8186-efuse
       - const: mediatek,mt8186-efuse
 

-- 
2.39.5

