Return-Path: <linux-pm+bounces-30207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2860AFA54B
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC743A9B8D
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jul 2025 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C021C163;
	Sun,  6 Jul 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="sBTYlbOS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C04215F48;
	Sun,  6 Jul 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808161; cv=none; b=gue/PF6SAOA9jEcKp6+01w9Tg3btgaXBdovfj+D8+tRAP70wbxuhgeLlfNZzlPTojdk++JgTI7oBXN0+bFN2uJRD6BO3iyHnlJs1DaBWVdc/BnoVeqcB3dr5TYcUL1fTFSMafAVH1Fr/2TPubH24x8RHGzsgQJFc3t5+yh/i5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808161; c=relaxed/simple;
	bh=Dgdiq1horuDoHLdNztjJFaG+cA4sLMSMTTMWhbKe7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoKf2HP5tntH0lZoJguORYE7nUL3xMa9f42ooDzmEr7JZSXbuabfiuwJ5un81ZWDobglm81vBvJFzwRaQN+r8s4ebYWlBO+g4w4O5sYqMxCbCIhXfypgR6FYP1fFd66CembMikOlEWHdQCL5qWuqaXZfZYrM0gCo3YQZsTk/us4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=sBTYlbOS; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 442CA5FD63;
	Sun,  6 Jul 2025 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1751808151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIMuNne++IWVgY0azMoYkvyXCjaefI/n17TVM+rpZxc=;
	b=sBTYlbOSykDALHtZxOMy4zffw2Ybr9cFinbjeUEfdFi0MpYRiuQgPbsZJWNj8muxrC8m+6
	z/FQC2SfxLA7bzihB+ZEa0cVtoLw7uDYHrAQBPVHzx+9B8GhJXBtaAUQQoqCKIb5HD8Zxw
	aMRzJKFY64k7F3nkYpQB3DhsJgp9xh8=
Received: from frank-u24.. (fttx-pool-194.15.86.111.bambit.de [194.15.86.111])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id DFCF31226F8;
	Sun,  6 Jul 2025 13:22:30 +0000 (UTC)
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
Subject: [PATCH v8 11/16] arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
Date: Sun,  6 Jul 2025 15:22:06 +0200
Message-ID: <20250706132213.20412-12-linux@fw-web.de>
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

CCI requires proc-supply. Add it on board level.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


