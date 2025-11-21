Return-Path: <linux-pm+bounces-38355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92DC78BFA
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CF7F12E16E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A751347FF8;
	Fri, 21 Nov 2025 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mGdYFJ5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADC345CDE;
	Fri, 21 Nov 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723837; cv=none; b=Xd2N0ZLUrlcYzq54ftKCO0tX6WeeHz1O6j6VATpJhXojRoANa14WbM5WOyoiMbghUJxPpl7zn4ExJD3jhHnxKOhClxXUp2WeHklfwoOYpi6KDjZ/5GSaKqbCz6MpUZNI/BpKsTZFt3TNiwVy49loJYqOz48spbxFs+AyHAVTqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723837; c=relaxed/simple;
	bh=aVbakoBQyckYSlNSPoWjsMEdNHC32xZLNcs0IhQ7uVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlwYgrxTF+gDapSwayijDNAgVK8FpwSz5wRlPb5JMqccxMmfhAfsxjN5pn1teK5fVcaLGzSpvkga8NPlNNmDZV6sIy/hCez4Fursd/cWEtjdzBR1Qs6hYXOaQWK8EJArwSItV0xoHfYxj6uFJiqw2YdYFmGCWls+YSOMetan4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mGdYFJ5p; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763723827;
	bh=aVbakoBQyckYSlNSPoWjsMEdNHC32xZLNcs0IhQ7uVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGdYFJ5pC42qGlbSkGh7F1UNEyLUdSu2AD76zGYpcM8TPi7OjhBfod+R+mmnNK55X
	 HUrE3O9865qSvBbPwlbSnux9O1THbew5RHoCw+OUuPzMzUxhWYh3LARrJcbzddN2ni
	 6kxy/wODGvp9LrmrF6nKKWlo8Iwl1ZvPIc/C4o8+qRqItUTFOSkvSAHSFp0iK4CZNK
	 nxtVhkac8m3TDw8ag+qoSy8ervZDQ0b4KBONwy7p1tBLBz+tguuTExpMRJ42/Oy8xW
	 0gDhXEqIlAjjjSvtMT92cMomjLEvdrxu+2RixJd0phvAy5eFst9EmLaOWXp2ndJXN2
	 8JowKthHlnAag==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:c4bf:9969:6e1c:dc69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DBDF517E13E4;
	Fri, 21 Nov 2025 12:17:05 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v4 3/9] thermal/drivers/mediatek/lvts: Fail probe if temp_factor is zero
Date: Fri, 21 Nov 2025 12:16:36 +0100
Message-Id: <20251121-mt8196-lvts-v4-v4-3-357f955a3176@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

temp_factor is used in lvts_temp_to_raw() and lvts_raw_to_temp(). If
platform data is incorrect and temp_factor is zero, it could cause a
division by zero. Fail the probe early to prevent a kernel crash.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1c54d0b75b1a..b49441d82ffd 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1346,6 +1346,11 @@ static int lvts_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	if (!lvts_data->temp_factor)
+		return dev_err_probe(
+			dev, -EINVAL,
+			"temp_factor should never be zero; check platform data.\n");
+
 	golden_temp_offset = lvts_data->temp_offset;
 
 	ret = lvts_domain_init(dev, lvts_td, lvts_data);

-- 
2.39.5

