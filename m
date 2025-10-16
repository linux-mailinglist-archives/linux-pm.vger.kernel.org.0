Return-Path: <linux-pm+bounces-36271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7CBE3E57
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA65080BB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3453431FE;
	Thu, 16 Oct 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aVNVNzti"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2833EB19;
	Thu, 16 Oct 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624576; cv=none; b=LGE612G3Rt7UPVn/nltjj8795qeU0nf5YrH9uTa/xkFIibhukqDO7PXEGfRAfW1um/a6CM63hG1DsKqMgasuR0NKGcafc0g95tDkGjPqfWIO/NL/3cqdwJ7PGFtGhD+aJ0Jn2D6bdimp5nJkT4jZh/NnjYXPD0fW0wKsOAo3EGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624576; c=relaxed/simple;
	bh=/Trh+v1W/uhiBFTYoqQXEekxqHsqS7bTdkGqVrRYRBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a08uVm8QvVOnOlg0Yxeh/Tmopp6FI+7tmQQSpRyA1zRzZ1tArEIr23DHHemiki+W/S7he7Ua8rlK24iGYPRqGC910RLtEzPFHFAaMNuVBjvKAfFXVJZjb/jX+PzyU4nhoakHZD7AawNx738Be7/ys7QUk8wyxEniAuc+yvpWlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aVNVNzti; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760624573;
	bh=/Trh+v1W/uhiBFTYoqQXEekxqHsqS7bTdkGqVrRYRBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVNVNztiHaDJ0c9NLhWPwbjZhsvWW8Zr/b4eqAt5QGaoNsJn0Z6AC3HqzYYD13Lt4
	 /axQTpMlyei9J2PFKmBPQKos3F41LEApQ++DW0nMJk+oixKiuSR7VbtPtPPx6yAEvc
	 7h6VWqyfGMdXPu2EDJlc7tedWdghXJDPgJo52ziMw9k0LbHJsBBYTe1nUMguwxkrMu
	 U4agrD0lL+8dq1trQ2zOE+yFr4nN1x0aJqhTfhiB0mrLuJ7HW3Zhsu4+s7xiYqT88o
	 fp7DlSq9wbQ4iduXlp4aBlTV6JAk5zqcBTFhgIHVEBny6SYdf3vwBYXj8a6vaqsyXi
	 cq3sIcvc66/XA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:655a:5eaa:d2ad:4ee4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2DBE617E10C8;
	Thu, 16 Oct 2025 16:22:52 +0200 (CEST)
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
Subject: [PATCH RESEND v3 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
Date: Thu, 16 Oct 2025 16:21:58 +0200
Message-Id: <20251016142158.740242-10-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016142158.740242-1-laura.nao@collabora.com>
References: <20251016142158.740242-1-laura.nao@collabora.com>
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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


