Return-Path: <linux-pm+bounces-30202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A73AFA537
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5F61894A32
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F72135D7;
	Sun,  6 Jul 2025 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="QXuWPtnj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505544C9D;
	Sun,  6 Jul 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808158; cv=none; b=RGVQTXA67+1wRCQ4Zk0EnnElqTry5NISxv+4dWSelvP19DN6VNgmitLZW5/D+NZGyjvqq6oAZTwerVDlwQGcAPGH5JUxBtOQjJ3DJVQzepA2BaDJfs7nlvkwlnmBxT8ynMXJ2dVoRUmulubrzaPVY0h7QbgaQk4h9227N2cdspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808158; c=relaxed/simple;
	bh=+BvUX9y9HlznKTksf6XPUyfiHbJBnA3CB04YdeM1+w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4ov2vRpB/IS+GdLkyPtOUcKAoSdi6wZROL4zRZ7wPEIQoUtIbjanDA9psGHNNyIJapOI+dUT9lGGyJDLQZcYhfa09UijofxV+sK64wkpQ/Fk9OoNM1i5vz1ykzWZJ2C7hZ/ksHDdMmA1L1Ih8aPo49KrVSF6+mCddUO8F3XSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=QXuWPtnj; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id C915C604DB;
	Sun,  6 Jul 2025 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751808148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EB6hNHt8FOhHLQ2d1gn4ZCXh4990JbNQXr8yU3xNg5Y=;
	b=QXuWPtnjGrubMHvjoedppmQdjg5/RwFPMhmlbV5gQoeTmfH2yxE0oTsLz6Aer4dC65al4V
	m4L0ER2jwxIQ6GGlGQV9c4ruSRZlN+mMKD8QT1ck5ZGwok/S+Hv7JQRh/jnoPlkTNrsqu0
	9Z1k0oXV9RxDiHhcOgDlV5q7toYSD88=
Received: from frank-u24.. (fttx-pool-194.15.86.111.bambit.de [194.15.86.111])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 702CD1226A5;
	Sun,  6 Jul 2025 13:22:27 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v8 02/16] dt-bindings: net: mediatek,net: allow up to 8 IRQs
Date: Sun,  6 Jul 2025 15:21:57 +0200
Message-ID: <20250706132213.20412-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250706132213.20412-1-linux@fw-web.de>
References: <20250706132213.20412-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Increase the maximum IRQ count to 8 (4 FE + 4 RSS/LRO).

Frame-engine-IRQs (max 4):
MT7621, MT7628: 1 IRQ
MT7622, MT7623: 3 IRQs (only two used by the driver for now)
MT7981, MT7986, MT7988: 4 IRQs (only two used by the driver for now)

Mediatek Filogic SoCs (mt798x) have 4 additional IRQs for RSS and/or
LRO.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v8: separate irq-count change from interrupt-names patch
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 175d1d011dc6..766224e4ed86 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -40,7 +40,7 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 4
+    maxItems: 8
 
   power-domains:
     maxItems: 1
-- 
2.43.0


