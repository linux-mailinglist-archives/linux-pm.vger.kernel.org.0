Return-Path: <linux-pm+bounces-31632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E3AB163A5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6E53BA76E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3F2E11DD;
	Wed, 30 Jul 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d8595H4/"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C682E0B42;
	Wed, 30 Jul 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888963; cv=none; b=CESlktoDR5H6hkg6hrS4ErQfTYLN7Ir8jGgis9E3VqtBUlheeKSML3P0oxR7LCnIEnSP6GNivA2j9J2hUSman5O+tTqjPJEZeWhCkDJ/1yJAS+LAuO7d0fWZb71nn+3yPiTpDuiLlT+hPs213Adx0QeXed9f5AYsZeI+CUExZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888963; c=relaxed/simple;
	bh=Hn1macxBsiwE8zIVXtjtrzSVv+kL8zbKJT5C2OuAsOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbQRX9lWHuMKwbSNXnaC4l7UaEJivWfExPjMB0VD0zerw4HCo9cEN7vqau7Wgj76efMsGQKmnoJOEMXVD0ESAm9XEzxBeAm5r6NtIoHanOGGizBFJqQ6XlY77kj1tSjJ5J4d+Ez3jRZg5bNC7Z0fn4QfdfC5Mifsoi0hMMvm1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d8595H4/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753888960;
	bh=Hn1macxBsiwE8zIVXtjtrzSVv+kL8zbKJT5C2OuAsOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8595H4/FxuZuk/QCIb+PXEPxoFNt6QxfKgDuQUz6v+RDVaefb8DuTmutdarVe5m3
	 TSzeC7uLRfMHEBc5jVOhv5RsQVzqCKFWMBG0KogqiIB+29t5n6+AAkYe9T4fci3O2F
	 IrYY8XB61nbZI7Cruy4xymeabhnTudTpybiWQvzpzbFEe14IeSugacbfhJh74TWLas
	 3j5dIx2G1zenqrO0oDhLQbdZmOqMrTGzScP5N/LrpIPgNTuyKr+hrSbMJL3nXW2B12
	 kVk3UTX87NubKeMhGNn+YUKMrJa8l0iaTwzcH3X5Y0iOf6aMnE57vPl9flx00hyFSR
	 65O8mmbhSD5sQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:41d5:bfd6:7c6f:85ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F1F817E1315;
	Wed, 30 Jul 2025 17:22:39 +0200 (CEST)
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
Cc: wenst@chromium.org,
	nfraprado@collabora.com,
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
Subject: [PATCH v2 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Wed, 30 Jul 2025 17:21:28 +0200
Message-Id: <20250730152128.311109-10-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730152128.311109-1-laura.nao@collabora.com>
References: <20250730152128.311109-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8196 eFuse layout is compatible with MT8186 and shares the same
decoding scheme for the gpu-speedbin cell.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 4dc0d42df3e6..455b96c1e1f4 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     oneOf:
       - items:
+          - const: mediatek,mt8196-efuse
           - const: mediatek,mt8188-efuse
           - const: mediatek,mt8186-efuse
       - const: mediatek,mt8186-efuse
-- 
2.39.5


