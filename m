Return-Path: <linux-pm+bounces-40722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A0D18581
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A468F3060A56
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630038E5C0;
	Tue, 13 Jan 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YUQdwNOx"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E238BF6B;
	Tue, 13 Jan 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302019; cv=none; b=DFkt4wQXdB2tA9l4A3a88sLz6ezM7hE53jiFT0pYZ7Le50UjMtLilyP6OfxTB5s1uyiJtJDn+l58LRBikwItWNtKFTPDGhvCv6IuQqx+2jyjomoVEJRv04E1DbDl+102V1rOgZBYOSSIcAP1ddKtvjYmMffAxKDFTtClUW5MjFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302019; c=relaxed/simple;
	bh=LVyshAcuwWCeKMfeOL8j7IyTjIznQXuutAHRDxB/Ou4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoQhPgl77/vtIhe0Y4ZV9laFy1b8xV9vgarySJpWvyspQP62IGdP95DYLjoErvpvN5jJVWgq4qQneGV52oWHrSCPcwh4R3nEs8WW3rkaJ+VxQ4GT/9OrfgynGOXcLo9iPch3dxoegsWRayDlVnwtLFz3sqSQQ7552AueM3tqNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YUQdwNOx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768302016;
	bh=LVyshAcuwWCeKMfeOL8j7IyTjIznQXuutAHRDxB/Ou4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUQdwNOxDrB7fGSZAFPqSz7/3kKjmmubd/H2u6MSRxhdjleYrF2tBhTpO5LBCWrTI
	 PIDKMXOjk4FXZEeZXzw0HveonBCS7AFVDPJ4KFg2YgV7HDGYyZ8CGYJA1+opt5gzyB
	 0IC7aM64p1GfH9lH3M2Q2/RgVIq/kvfEfiSkxYvIITLwC+4/ox9Qfzxn6dp0KsN+A3
	 fAMNsTLaUF2dfiGYyUsRwx7/l1u/wMBBLD2Kjaj+XfpQ1fb3qhj9mR+wBL8KGUViDN
	 7B0aVCMGGZmrTJ9nNPKj0YkfQqRrxKSJrLaC0PtFTCvY5hqG/MDdJGA24VGaUGVdiZ
	 +i8PkTOLTPDvw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8627717E10F4;
	Tue, 13 Jan 2026 12:00:15 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ulf.hansson@linaro.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 2/5] dt-bindings: power: mt7622-power: Add MT7622_POWER_DOMAIN_AUDIO
Date: Tue, 13 Jan 2026 12:00:09 +0100
Message-ID: <20260113110012.36984-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing power domain for the Audio IPs in this SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/dt-bindings/power/mt7622-power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/power/mt7622-power.h b/include/dt-bindings/power/mt7622-power.h
index ffad81ad3d46..ec244989eeba 100644
--- a/include/dt-bindings/power/mt7622-power.h
+++ b/include/dt-bindings/power/mt7622-power.h
@@ -10,5 +10,6 @@
 #define MT7622_POWER_DOMAIN_HIF0	1
 #define MT7622_POWER_DOMAIN_HIF1	2
 #define MT7622_POWER_DOMAIN_WB		3
+#define MT7622_POWER_DOMAIN_AUDIO	4
 
 #endif /* _DT_BINDINGS_POWER_MT7622_POWER_H */
-- 
2.52.0


