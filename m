Return-Path: <linux-pm+bounces-38626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835BC85EF4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C19C4352C56
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03B27815E;
	Tue, 25 Nov 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P6ir9ksM"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B626F2AD;
	Tue, 25 Nov 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087466; cv=none; b=kIyELI2MS6PtU4FeSfUGeiGV15/o7LK5nhJTwMQTKFafKlSMMeJBGOhMllXn2IuXBjC5H4qfxVBSiYr7DvW4h90uCBiB+rXDKO4kOOOFjBDQ07YxiVsgzHl9fsp0Ujoos2BEKOu3UgfqL0Vy3EOBJcUh6h8plq+qE2+8VUqMQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087466; c=relaxed/simple;
	bh=zXAXmFln9lKY4IcPOhyXbYN0ZlHQuU+Bqq5haznGK8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqqgLn/6j4v1ZkY4dGCT3CvCEXhh3OFc202B1tKfwdh5hbfdovIWIqgnw3JpTgc/eANrSiAFEItzl+17AavLxEr/upTjA7L1H3QYO5rYftfUmmgxItYzCT/+QRzFGgIvNwtvzDsu6EfZOn3kv7HKymihXLLrFhIrYWWEOe4DX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P6ir9ksM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764087463;
	bh=zXAXmFln9lKY4IcPOhyXbYN0ZlHQuU+Bqq5haznGK8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6ir9ksMovBo2EQJGA6pVNWkJ6MVPHf8iajz6fb5N9jNP1C1DZVd32LZ6MiCvBnC6
	 H5DXe/+7HryU6BsztIHJTHSGF+z208cCKgGwMkLFP0dD92hFuawIgfrD+fHO0JEHYA
	 vSFkSQReb4sEig4iRn4xRNujjZcqBCXj9X/3Nkl23TqPZiP4LPUakZ09m2U0/LTT1M
	 9VcswYTOSGU+dKvFOjzK5LN0l6QQ5+/udHB7krs1qHmarB7jvDijoTnGOaqcI+jRMQ
	 jJzdBCTgUc4j8VuX1U/sIfx74gmLZU2yoJKylm07eFhCJFyKI0uz5Zm/16QXlLRMPU
	 bPt/kbVOR5uTw==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:feae:4183:be92:e051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C9B7A17E1400;
	Tue, 25 Nov 2025 17:17:41 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v5 4/8] thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
Date: Tue, 25 Nov 2025 17:16:54 +0100
Message-Id: <20251125-mt8196-lvts-v4-v5-4-6db7eb903fb7@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
References: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

MT8196/MT6991 require a different version of lvts_temp_to_raw(),
specifically the multiplicative inverse of the existing implementation.
Introduce a variant of the function with inverted calculation logic to
match this requirement.

This ensures accurate raw value generation for temperature
thresholds, avoiding spurious thermal interrupts or unintended hardware
resets on MT8196/MT6991.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a684f73d3698..e9b9c1c35020 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -308,6 +308,15 @@ static u32 lvts_temp_to_raw_mt7988(int temperature, int temp_factor)
 	return raw_temp;
 }
 
+static u32 lvts_temp_to_raw_mt8196(int temperature, int temp_factor)
+{
+	u32 raw_temp;
+
+	raw_temp = temperature - golden_temp_offset;
+
+	return div_s64((s64)temp_factor << 14, raw_temp);
+}
+
 static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);

-- 
2.39.5

