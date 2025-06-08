Return-Path: <linux-pm+bounces-28264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F343AD146C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61826188AC97
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD65C2550BB;
	Sun,  8 Jun 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="UsbzlzOR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDB1EDA26;
	Sun,  8 Jun 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417312; cv=none; b=HEpBY34eSjO7wfOG79UxIyFRHsVLSitfpg4FECIs4eNCpV873mfkJrWJNAbN1mwjJUCPQxbDC5zKltvzcRj/qVufwE0JYKsn1bjjo4MZEfDamrz6LluJ7ZQVHoUCA/vIgsc4fg4Brq6dv6hLC3MMP0BAC6SSVgsx+Wu6SMoM4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417312; c=relaxed/simple;
	bh=2ayB3FFSLyItlEfwkpXppGL8M59c1GXDrtM74vNQrsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6FjMgzmhvdGfsxGlKsmk9yg2hN/l8h8CHAD7snDAg2AcM0SepYjn7O46DAcEPOfgznoYvIjygcSYLRbLcg+gzuifc0wSDGhMAPqFnFADwf492FvG8Bd1CT4Aeoxb3BmMKjjZW5hlMCBhF116MmUhae52hAfJDeNbPShZ7P8WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=UsbzlzOR; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 3CF8560163;
	Sun,  8 Jun 2025 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749417302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swK23DCVf3KYOYwkgLxTlVXj4MpCXZYzSoeROC7b2Yg=;
	b=UsbzlzORKw1rVN6aqZXL+ORgBb2a0MLXDPlVGvB/JOi28f9Yrixmyt0Gk9K+Zr8RMQAiF6
	krwY1cnEeWCmx3JThEjbRxf5CProA3+bXGIYaY/+RhRlZ418cHLGYKN/TYGlXN2P8MPFIa
	ZMEts3NQw3waDf/K6VojFkZc8D59Fz0=
Received: from frank-u24.. (fttx-pool-80.245.77.166.bambit.de [80.245.77.166])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id D5CCC1226D6;
	Sun,  8 Jun 2025 21:15:01 +0000 (UTC)
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 08/13] arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
Date: Sun,  8 Jun 2025 23:14:41 +0200
Message-ID: <20250608211452.72920-9-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250608211452.72920-1-linux@fw-web.de>
References: <20250608211452.72920-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

CCI requires proc-supply. Add it on board level.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 81ba045e0e0e..afa9e3b2b16a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -40,6 +40,10 @@ reg_3p3v: regulator-3p3v {
 	};
 };
 
+&cci {
+	proc-supply = <&rt5190_buck3>;
+};
+
 &cpu0 {
 	proc-supply = <&rt5190_buck3>;
 };
-- 
2.43.0


