Return-Path: <linux-pm+bounces-31907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6AB1A367
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CB3B9078
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67BA27467D;
	Mon,  4 Aug 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e3lJoDgQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A822737EE;
	Mon,  4 Aug 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314374; cv=none; b=vAkz5C0l6A9M1+RfjKJzi9P4YP1X0PkfYqXBdLKPCclzpv5KMMPD/uRxs0AkUqWQxrIl13GGLJVhITqfT7YYlB0bbrfjGuHQ2QC3e339pbsW3yzMAlHt7aOj1XwyD1nf6C0+ZqOKyETlW5R9nlWTsk3isspUR7li2gZ96uCIj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314374; c=relaxed/simple;
	bh=ercQN29j590aHpm9+xA8hm1HdQq4WZB6Q1EllLqESa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aetmZZyJ68vlbjCgdHM0E4r6qHJ9mP4NpzkFmWGWm+n4G73UDRnd4sMPIXJ6X9IAnxai7/Qb3loZbNbSpXxtQ/ZHFHtQVWAN40bVlH90TrjGwNi6+ZP70NCtMl+zXAaYP52/7XP8r3LwC1bp0hP6jsW4SoAcyFP5lIvWfQ7ym4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e3lJoDgQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314371;
	bh=ercQN29j590aHpm9+xA8hm1HdQq4WZB6Q1EllLqESa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e3lJoDgQEhq4oap7y5IdSE+kxRF8tHZ0W6wDxkCfzrAhotv2C9LzW6zlLkj4H8UnX
	 NcOtDy7AUvpdovsyjs/0izCwO29xV8zPZWPrByJla0OfMJbbD8i+qd0gOeDJbCb9vI
	 CGXQEy0mAk/pIKU8ebVQZjO82DJAJ4OHQ/ARXyfAUYP7bbv2cXyDIxQgyUluH+hHI7
	 zOE1H3WID+aVItyRnp5gA110WH9cfosb7WR9GojVccK/QOks62ULgL+8A8QUD36NcY
	 TtbfYNfgMf1Rxh5v871sm/V+mRYmaGhfOy6IYKHWsYdntL8FBfmAVzGMx65i0Pn6iq
	 h/czDa+NKrIJg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:865e:547d:4830:837d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D5F6F17E132A;
	Mon,  4 Aug 2025 15:32:49 +0200 (CEST)
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
Subject: [PATCH v3 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Mon,  4 Aug 2025 15:30:35 +0200
Message-Id: <20250804133035.309990-10-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804133035.309990-1-laura.nao@collabora.com>
References: <20250804133035.309990-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8196 eFuse layout is compatible with MT8186 and shares the same
decoding scheme for the gpu-speedbin cell.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 4dc0d42df3e6..c90b026e40bd 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -25,7 +25,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: mediatek,mt8188-efuse
+          - enum:
+              - mediatek,mt8196-efuse
+              - mediatek,mt8188-efuse
           - const: mediatek,mt8186-efuse
       - const: mediatek,mt8186-efuse
 
-- 
2.39.5


