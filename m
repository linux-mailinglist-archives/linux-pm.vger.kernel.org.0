Return-Path: <linux-pm+bounces-39890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F41DECDA358
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87A23043555
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101BA2F361A;
	Tue, 23 Dec 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="hAzGLMHN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E32D5C91;
	Tue, 23 Dec 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512652; cv=none; b=bGHEqMAvWUokSDl6QCPuc+nV2AEdEOrSwd82TIwpByMz6mxTctZSqcjRso86+hXINFDhSJoeX0i0xcfjzgFmdSMlP6zZe78/WwHX7ix4VpSWvAEpvKQYC3AWUHFqdw4C5Rm+clIItfyhmv21KH/dF9AH6V1hzQ40Qn8fjbOdnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512652; c=relaxed/simple;
	bh=3wtaN3bESoIswu9lxFtk8tveEUPHd2geRPuBkyewXFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIPpBxKtUxbERXXVGis5RGf+eChhlbQ0KC6Zh7I/MSU8kf3KTQcxxwaddnzLq5oHeW7ITltHgdmSbOKoG+6UENH88xqe0P5kIZ/fjFRS+fmhSs0Tq7yo56CW98eMe76vpw0gLqhXyJ+x/AYqmXVkOWZNnaYxsfTUWFxvppaKWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=hAzGLMHN; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id B541B600EF;
	Tue, 23 Dec 2025 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1766512641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUF+eCTLG+mmzttQnUwvPW7szQcj8nRq0nrcTr5Z0BU=;
	b=hAzGLMHNGuy2VarmXTmSSkr8FUSAN5XyZswHTyFVyWaD47AZV3TK5/U4nMU4luxIzpVzbK
	0GTaNf09WCk8dbMGfsaw8YabjvGol6RK6Zy4hPwlQTaXv/4Tt9s3xZR6mNZC3Ry/BcFk2M
	b60XgVtVi7Nh9XvTuuKzMFLMLe+MCbo=
Received: from frank-u24.. (fttx-pool-217.61.156.193.bambit.de [217.61.156.193])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 73622122705;
	Tue, 23 Dec 2025 17:57:21 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT7987
Date: Tue, 23 Dec 2025 18:56:26 +0100
Message-ID: <20251223175710.25850-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223175710.25850-1-linux@fw-web.de>
References: <20251223175710.25850-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add thermal controller definition for MT7987.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml     | 1 +
 include/dt-bindings/thermal/mediatek,lvts-thermal.h            | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 0259cd3ce9c5..a9befb523fd4 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -18,6 +18,7 @@ description: |
 properties:
   compatible:
     enum:
+      - mediatek,mt7987-lvts-ap
       - mediatek,mt7988-lvts-ap
       - mediatek,mt8186-lvts
       - mediatek,mt8188-lvts-ap
diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index ddc7302a510a..e9780edcd26c 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -7,6 +7,9 @@
 #ifndef __MEDIATEK_LVTS_DT_H
 #define __MEDIATEK_LVTS_DT_H
 
+#define MT7987_CPU		0
+#define MT7987_ETH2P5G		1
+
 #define MT7988_CPU_0		0
 #define MT7988_CPU_1		1
 #define MT7988_ETH2P5G_0	2
-- 
2.43.0


