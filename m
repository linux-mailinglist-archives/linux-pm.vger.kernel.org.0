Return-Path: <linux-pm+bounces-31901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E2B1A350
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BB43BE239
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6EF26E6FB;
	Mon,  4 Aug 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ndgqcUqV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3EA26CE2D;
	Mon,  4 Aug 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314364; cv=none; b=uNtqSIiLUSHtaOHLkc29GNrZGWNNp6noIhi0bFKNvDf/NJrhUHOIaiNnKTetvdDI0GtY72YGucv07ZSRxg9w9OHDyzo4lhpG0sSg/xf/byBi6j6wZaT1cV4kjFMDIRVsbCMAzLtHBLqNNSiWH5Ey3WHZc5LU7VwZBOHVM04MW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314364; c=relaxed/simple;
	bh=odWRAl94AI131ZH9bWkD5WdWUHexg4q4fcoXkXOB/Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4lvTzgk5c40Ja0H60vzrC8HvwDc6m3NTz9YJ8Rx4sK79db6YJmJJ6LahW7Ump7uU0E2AoGFPHeG5xxFQz1FM2+h2G7igUQvXuTX6Sv083fq8wPtSUN5jvHIC+VDXB5zPUNRtN6lAU5NhvKhOkgvCaBoQrm3GTCd5pPKNP4Ro+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ndgqcUqV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314361;
	bh=odWRAl94AI131ZH9bWkD5WdWUHexg4q4fcoXkXOB/Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndgqcUqVYcbUD2NXFPt0fYbaY2jrSG3jw6FJeKR22KyZkaHqUiPIPyOBmxhxVbNFI
	 a9m3XKnyXFfMcBs0ON06R47cn7fpGzyLUCSxH2qi+hwWR/LPJMrNz3TZkS5GNNqScc
	 2ApT0K37PeP1DwbRlXA95qDgUeXu88IFAExhwIdMsXn7HtHzye3vPHtxEQOtkNbSWY
	 TrmoGjUKJxXxx3HRwhZfjLrqXoxWOnwnhpabMKX3lHWNd7gtF9SVowqGCl/jBKj56a
	 5SHvLLsTK706WyjOwWV9NwCxoGboMvEm5MGcRD9/cG2Z0utmLOcLCU+werVpqifoAY
	 x9iVRcrMoAeCQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:865e:547d:4830:837d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 07F5417E0F3C;
	Mon,  4 Aug 2025 15:32:39 +0200 (CEST)
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
	Laura Nao <laura.nao@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Fei Shao <fshao@chromium.org>
Subject: [PATCH v3 3/9] thermal/drivers/mediatek/lvts: Guard against zero temp_factor in lvts_raw_to_temp
Date: Mon,  4 Aug 2025 15:30:29 +0200
Message-Id: <20250804133035.309990-4-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804133035.309990-1-laura.nao@collabora.com>
References: <20250804133035.309990-1-laura.nao@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 05aa8895ccce..8398af657ba2 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -284,11 +284,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
 
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
@@ -1346,6 +1349,9 @@ static int lvts_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	if (!lvts_data->temp_factor)
+		dev_warn(dev, "temp_factor should never be zero; check platform data.\n");
+
 	golden_temp_offset = lvts_data->temp_offset;
 
 	ret = lvts_domain_init(dev, lvts_td, lvts_data);
-- 
2.39.5


