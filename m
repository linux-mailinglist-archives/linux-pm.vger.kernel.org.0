Return-Path: <linux-pm+bounces-31176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD2FB0BE87
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCED13AA31B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A7C2877FB;
	Mon, 21 Jul 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UPeDUpLp"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C004287243;
	Mon, 21 Jul 2025 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085783; cv=none; b=gEFfWNfLEpWoBQYxkrQtTX73R3MPA5q6gcgvhZ4hKUx045Z9QUkH4uQoIVmTmirb/uBFhiP4AM3hR7liI7tQCnISwwh0ek8pBiWclclL/LvR0ScTvUksfZghd6fvC5krNT1+9pkKKwPvskNp3q+l2xKQhfxSc2ROm72OUGVY+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085783; c=relaxed/simple;
	bh=nMWw/YV2aUZ0o1aahtB1fpEazy7YQ0cmyesO53SUJIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCbkBG5ZYomAHYMPcp20ti+6sdXPl7MhhvbsokbmloF+MN2JyivDnv9aEP76JF6oj3n3zT/CAS/iJjMtKDL3nen9HQTofkh2DQ1R1JAJ16JfGfbJM1/novjrnbnaer6F0PmD1KDY9L2iudTbu1q4T3M7YdPOz9wyTbih4Jo0l9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UPeDUpLp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753085779;
	bh=nMWw/YV2aUZ0o1aahtB1fpEazy7YQ0cmyesO53SUJIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPeDUpLpHhCCWKD8CMgaXQhKcPQp7YXYnbS/1e1f44hshETdnHw2gXNkbuS9jFXRZ
	 0FaNcgB1zm8aYBDeVaYWXJy1j5xl7I/d9kSWI/6LHprXeglQBnoIzwpUrGF0evGFH7
	 2Qfx4FJMKC6I+x6X0yVcKBTy9zDnN08mtYnRlGkBLASSTgncjiKsRrnXng4hpmvkBT
	 hE65JJHaDQqBUxptj4zezVLj8TZUSxAqEI79Ztc65/ronqfiw6UkgQ0dNlv2q2wY2e
	 72IpIMRuqNsOGST0nAidsVcOf59Bq/jD0jdfjSDrUfAZv8PKXuyAPIrEPUoOawtRcm
	 WChTszb1HJ7zQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4487:69c6:40a:81be])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6843D17E154C;
	Mon, 21 Jul 2025 10:16:18 +0200 (CEST)
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
Subject: [PATCH 3/9] thermal/drivers/mediatek/lvts: Guard against zero temp_factor in lvts_raw_to_temp
Date: Mon, 21 Jul 2025 10:14:53 +0200
Message-Id: <20250721081459.16278-4-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721081459.16278-1-laura.nao@collabora.com>
References: <20250721081459.16278-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
division by zero and ensure safe conversion.

Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff configurable")
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 8d5259b9d03b..b80c2929ae74 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -280,11 +280,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
 
 static u32 lvts_temp_to_raw(int temperature, int temp_factor)
 {
-	u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
+	u32 raw_temp;
 
-	raw_temp = div_s64(raw_temp, -temp_factor);
+	if (temp_factor == 0)
+		return temperature;
 
-	return raw_temp;
+	raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
+
+	return div_s64(raw_temp, -temp_factor);
 }
 
 static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
-- 
2.39.5


