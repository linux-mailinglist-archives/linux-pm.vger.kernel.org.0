Return-Path: <linux-pm+bounces-28807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50320ADACC3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7847317250F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BD277C86;
	Mon, 16 Jun 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="S2LehjLX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683ED274FE1;
	Mon, 16 Jun 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067930; cv=none; b=fLggG06pxZl9Lq2pSxorwuxr/26WxencHQTjD+4nNzWogsY3UlowelpIuEM+sqT1+UDnSt3MKoS8pANUjjXSadAiLXrMbN/RnGIa25oOFIBVOZZWkUe34ZT5VFupgor3X0nz/teSeJDy8zEAAP4uGpddYX7IiavHUgXe0BXs6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067930; c=relaxed/simple;
	bh=P/EOW+pd0YQ7LiMHFX+KMFe53eWNEXq3yNdzkShDgOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rt99p0WNCjvvMOzNtUKtDmO3iVlzVP39Le5/6F1j1FIyv1a8yr7IakwQhJzYJSxncE9qKHYzuRigRG1Y8Mm5Ogqk4TzFTzVSnVlEtP94qpuyWdG7+D2ItIK7tWjthG0yVCiHW68JuShCJRvqFFvGeHOVi4iBTdUQBwoXQYbRMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=S2LehjLX; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 422905FDD4;
	Mon, 16 Jun 2025 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750067924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c58atM53j6xJlfjeW4uz3/6gYrG19vaD/Ky2Z6w23+4=;
	b=S2LehjLXd/yQHd8qxnYWq3eK3A330mjEoTA67VchHK6Sxsc6VXLmqLRIXFZtuVPgt/g8hq
	c6xd4Y98yBWxv4hQu1lHKcPlzSEuTTB7BsVD+2ls7VtSvcb4Pq4U2W5yBS0Tqcp8jqN4M1
	eGZuCBQYGGaoEc8JdjxdMwbl5s+dJGw=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id DA5B2122704;
	Mon, 16 Jun 2025 09:58:43 +0000 (UTC)
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
Subject: [PATCH v4 11/13] arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
Date: Mon, 16 Jun 2025 11:58:21 +0200
Message-ID: <20250616095828.160900-12-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616095828.160900-1-linux@fw-web.de>
References: <20250616095828.160900-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add aliases for gmacs to allow bootloader setting mac-adresses.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 21eb91c8609f..20073eb4d1bd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -8,6 +8,12 @@
 #include "mt7988a.dtsi"
 
 / {
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.43.0


