Return-Path: <linux-pm+bounces-29138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A70AE164F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3B7A3AE2
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385E245035;
	Fri, 20 Jun 2025 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="CodhBDQc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42301241668;
	Fri, 20 Jun 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408579; cv=none; b=O2McZ02g9eHR/1T8qwqCV+BETGutChpX1SApOfe6I9fklnyCrEDckmdJX01uTXGt4uDe3SumAy+OWAFh+MTlMX7hMixF7CHluMQo2IkrZRs7x1kAKo4QUDWhGNcyuUf/B1EeVJ40z7C8zmR8Cn0dc63W7DQDanzhPnvial62A4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408579; c=relaxed/simple;
	bh=Dgdiq1horuDoHLdNztjJFaG+cA4sLMSMTTMWhbKe7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twb6kdI3tV6Bjg03E2kz7pwwNwIWJf8wr7lli5100wlpqBEw3Neiw76hLbZPZ6H/mld6cCdZMRrwV+xrRpDFBZ72y5R/c5Vc94zuNpJSV41NtQm8vidn0jtSC1mQpN2AmAFufAiQ9mWmaxj1eS81iqoljeeuTkSKZal6DZjWvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=CodhBDQc; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id C30D7100DA1;
	Fri, 20 Jun 2025 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750408573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIMuNne++IWVgY0azMoYkvyXCjaefI/n17TVM+rpZxc=;
	b=CodhBDQcfHxyptCsdV7EzbPLAKi2/WqdhPPPrn/BIYMm/fwxHo3MeSCzFHas2hYNDb2XV4
	X0IuzS7Mzmsfje2iJzLcJFodTQ9BD55f+meMXuu5sdBqM7NXw4y2lK8Gjq1uRaqG3Thlqe
	iRgKbCs9XqEBlpu5laq7srf6U+GN93U=
Received: from frank-u24.. (fttx-pool-157.180.225.81.bambit.de [157.180.225.81])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 6A0271226B1;
	Fri, 20 Jun 2025 08:36:13 +0000 (UTC)
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
Subject: [PATCH v5 08/13] arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
Date: Fri, 20 Jun 2025 10:35:39 +0200
Message-ID: <20250620083555.6886-9-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620083555.6886-1-linux@fw-web.de>
References: <20250620083555.6886-1-linux@fw-web.de>
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


