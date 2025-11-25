Return-Path: <linux-pm+bounces-38630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC7C85EFD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3260D3B50C2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17632824D;
	Tue, 25 Nov 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iPSq7mxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1562325734;
	Tue, 25 Nov 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087472; cv=none; b=Dd6dsL9dCfoWN0bA+ug3SZhAz7qcW1fQnVBtEvefEfhxv7EoltVuhEROXznDtDfePfazrcpQgNRJ5PViaZEN4fi8SMOJt+X0YnUToqRPI2sPCk9d4+s2HhBl/e6sUXguXTK/HLWhjDNuRejRjijz8tJIHmWPrt9Sui9zkGetpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087472; c=relaxed/simple;
	bh=4DAkv37ea+2d/7BYgVUeJPDn9xhNgNPTUmdoIJAvKNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5Wa8qLDk3YA1YpvoxmcCoZwYqn++AMrDZlTtQZ0BZirkFH+Lw5uamp6E0YSJv9kQ4uZUnWkheixdwRk8PPkdXwlNNYgI82dh1+utxH7cF97viO+iNuCPNIRj4HBBL/eVBTCT/66hVyqKY0Gl3zW2pYWLkpeKjqBV8Pjc0eFDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iPSq7mxx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764087468;
	bh=4DAkv37ea+2d/7BYgVUeJPDn9xhNgNPTUmdoIJAvKNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPSq7mxxyfNeGveBwVsVoCKMTXATIu6R2Cpwc2EAscZRhVEHQcPAWSuRHD7hj0trA
	 OgwbWJJYHwPqh0vf6NSMSCmzE7RuqkGlYsvyYOMz2eJ4ou4wT4ZbxoRfYSIFevVt5w
	 c8tb7/by2WVgdDrdYqDEPu8AQqGztgLu005aID5c0D+i2qWIpspc10I3SKBq7vpo3f
	 K+7oQO3lLQ20ciCVaDOzunGV4RkaAt8W5bS/WQ4tEb9dH/SxG3VUDnecyqxhnmKlij
	 2Petz1tBps93z7ZU6/pN6vzjTVVEZoV2qFmYobc2RCfXWFOo9c0uSJDjYR3QZhQlV6
	 DiDRygtxaItqw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:feae:4183:be92:e051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 96F0A17E10E7;
	Tue, 25 Nov 2025 17:17:47 +0100 (CET)
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	fshao@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v5 8/8] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Tue, 25 Nov 2025 17:16:58 +0100
Message-Id: <20251125-mt8196-lvts-v4-v5-8-6db7eb903fb7@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
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

