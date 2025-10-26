Return-Path: <linux-pm+bounces-36842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B56C0A727
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB93A855A
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E52989BF;
	Sun, 26 Oct 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="nVr8C+Vn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17328724D;
	Sun, 26 Oct 2025 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481911; cv=none; b=GLjKAfrTIl2LmxHSJbZs9NdWldkGzOYWpBH/t7I4bfpqQyDJchDf0KY8DsNemvUgr0VcANrBFsubz+QTxkuTcv20XSMoVaALogB6URqvOCouTMFDoeJs0HhKTBPmF9C6QIBNRx34w9BVDz2L/ybQjSI+FQAcSoRRwpI4mdZ4YWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481911; c=relaxed/simple;
	bh=3A6NWFIsP5XoXA/AEOYp2kgioSTLb9Q2LPR3Gx5m+3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrhBPn+Vig0iIAK3IryDcvHVDEDUb/dJ0NPs9gZxXnM5CTkdKqGCTwPeOiPK5C1ftu3tH0E2n3A/uSQRwdP0OHqEs1WY7bTZ0mv+hJsJhvdyDd14d+K/0Rz6UhXBsZ/ytUf2NTlMMnuS4W98Z/08RAJRW37IiyRNuo6IVpzDW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=nVr8C+Vn; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 34C575FE3B;
	Sun, 26 Oct 2025 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1761481325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ho+w8/wSlfCk13S0AyROefe1juINq8GVHtpVrKG2OZs=;
	b=nVr8C+Vn+KAo+Bd+a4p465nQp0MfJnNckoX0+J3zBPfUZ6730yJqjkPXPOg0gVrNqSd9BL
	lUDlXaRy/xNHuOhNc/qQni2AWjgh+izzFJKxFSbygcy92F83hU7sXkgqz29unsA5hvsHp8
	offO6xk3GadQLvRKQsoHWPjvUBrLfVc=
Received: from frank-u24.. (fttx-pool-217.61.154.70.bambit.de [217.61.154.70])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E847A122700;
	Sun, 26 Oct 2025 12:22:04 +0000 (UTC)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Balsam CHIHI <bchihi@baylibre.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 2/5] dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT7987
Date: Sun, 26 Oct 2025 13:21:31 +0100
Message-ID: <20251026122143.71100-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026122143.71100-1-linux@fw-web.de>
References: <20251026122143.71100-1-linux@fw-web.de>
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
---
 .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml     | 1 +
 include/dt-bindings/thermal/mediatek,lvts-thermal.h            | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
index 7ec9c46eef22..13e948a2a909 100644
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


