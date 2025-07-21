Return-Path: <linux-pm+bounces-31182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE02B0BE9D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81044189E650
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EED28A70C;
	Mon, 21 Jul 2025 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ql7Vz9ts"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227128A1F2;
	Mon, 21 Jul 2025 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085792; cv=none; b=L1MX0EyPk704OTpxM3nCds8wNe6L4uFAkRaBQ/+dwG1zbd1ijgvnT8zMUgLdMx5qpWu6FLSFQ2u4CaYNPAPyv8vXsFFsJPzQqz+jKOIxw6VlCiHqYnyLf+Xalqfm3C1H/qyDcRJipWCxKh7vGfaSAOHN9FermauzOMAqKnpIPc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085792; c=relaxed/simple;
	bh=w6sh/7u7ae2yAWUxtx6cgY5xdFm6qlPDPDfS1bNNr9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LH2gIqHXPffKrOofaAaQXd5sTyUl9h//GNWVx2SJ2TKgumrVUP67oETXQulaCGKLZRvPe+gBCU6URenS9xsBTQkgvTOmAxLeiJcqiBgHk1x3+3qose0C3khvdPJDrscEIyXinFqfXKNMDqNhbd9qh2zvW4JEEH8I4O46jHenRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ql7Vz9ts; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753085789;
	bh=w6sh/7u7ae2yAWUxtx6cgY5xdFm6qlPDPDfS1bNNr9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ql7Vz9tszCFPv6ICq2j2HeW8YhQ/rWQg6eDqXi6u7jqFFvlqtK/7npwqHaIRVlnuj
	 prYaHEZJLTboETdYQi8j7Eytttphl6P7XOejOqmeTIt6aw25Gx3VS0bquszf+t9WW3
	 zlkrtwibyy5o6UWzpqv8U6nMbUX+AyefKPaDKW43jy4V1NPNGGkfnMyOu2Zf0w3lEa
	 /F8stPxdhySbNajuAuyBZeSd7OFZDSw+j15gjB5LFVVWH9pcrP28yxh2FHflPcU0qz
	 HAia5o6fHpw97g5vihxJ2T7+VShqH0WPKUXCQid2yuFDJmRBBHz04Wm9lc36ltaHtx
	 gZzDnVV4or+iA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4487:69c6:40a:81be])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA0B917E0F66;
	Mon, 21 Jul 2025 10:16:27 +0200 (CEST)
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
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Mon, 21 Jul 2025 10:14:59 +0200
Message-Id: <20250721081459.16278-10-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721081459.16278-1-laura.nao@collabora.com>
References: <20250721081459.16278-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for MT8196 SoC.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 32b8c1eb4e80..e209a1132a26 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -37,6 +37,7 @@ properties:
               - mediatek,mt8188-efuse
               - mediatek,mt8192-efuse
               - mediatek,mt8195-efuse
+              - mediatek,mt8196-efuse
               - mediatek,mt8516-efuse
           - const: mediatek,efuse
       - const: mediatek,mt8173-efuse
-- 
2.39.5


