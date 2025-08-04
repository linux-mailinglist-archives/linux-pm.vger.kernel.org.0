Return-Path: <linux-pm+bounces-31905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD5B1A359
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721F017A7A6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A408272801;
	Mon,  4 Aug 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mK98SG/T"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA714270EC1;
	Mon,  4 Aug 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314371; cv=none; b=j5JmdbJGNsQ+g6dhXQFClTyI36UJhUeGaAiDuy6tkfaGfVZM9gyWsL4YwOZ0v02a0nNj6Te7whgCpjM+gMti2wNB2KVawINbF1BYw4jNYirovXAcPqhlj+wVMuvufSX6iM7vuUD9209MUKekQbXh7u7ugrjUZx9zdAoGvGemEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314371; c=relaxed/simple;
	bh=uY4kKMPnqiqV9X/4qOUA+HIRtOTWlGXuobPhqN9t1qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R9Rj+vmQFqT33SJ1qICinwkShPBVMhm7/HfoN00OF+Jl1KMKfoL7eJCHwXv6dMNCUuVRKVIjXrZW/fKTh/JS8JDw6p/Nz3ig/qZt8q9VXKWk0EZfNUt9hsU7SLVkMFVHhObrBIead8Gd98e3ORDqDPvYM31hel/JbMV0QtEFEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mK98SG/T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314368;
	bh=uY4kKMPnqiqV9X/4qOUA+HIRtOTWlGXuobPhqN9t1qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mK98SG/TQ9nKPQQrppl/cMqudqopj4v5io1iT6quyIecCymqs+P8HKaghPz0X0ilU
	 V7Ph3xUsUHYlAIzvspW6HQxDE1IXZ/i8KK89hFJMuY/2OEL5FmFCSfenocMtfdlA4q
	 DvlELi2Myi4JMH2HcB1+8Ss/ausgsACuw3zSFgEEB1XeqovZhDapdCbsWQjLtnBvPi
	 TcNmVIO1KwIoyTEqqOldIEVthEbGRKAkaGZal2/b5Ky8zHJR9xDfT5DPC7KQkxJ5Dn
	 FMzZ5sKZ5U2Z8VbDWwsJ5dsPOT3v5p3OzKV1OJHRVZG3a8J4+TqZE+MLFaXlauOIK3
	 HCK6YFYmF0XhA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:865e:547d:4830:837d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B2C0617E1540;
	Mon,  4 Aug 2025 15:32:46 +0200 (CEST)
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
Subject: [PATCH v3 7/9] thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit calibration data
Date: Mon,  4 Aug 2025 15:30:33 +0200
Message-Id: <20250804133035.309990-8-laura.nao@collabora.com>
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

On MT8196/MT6991, per-sensor calibration data read from eFuses is
16-bit. When the LVTS controller operates in 16-bit mode, a fixed offset
must be added to MSR values during post-processing to obtain correct
temperature readings. Introduce a new msr_offset field in lvts_data,
program the respective register and apply the offset to the calibration
data read from eFuses.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index dcfcb1be5a09..481ca133902d 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -44,6 +44,7 @@
 #define LVTS_EDATA01(__base)	(__base + 0x0058)
 #define LVTS_EDATA02(__base)	(__base + 0x005C)
 #define LVTS_EDATA03(__base)	(__base + 0x0060)
+#define LVTS_MSROFT(__base)		(__base + 0x006C)
 #define LVTS_ATP0(__base)		(__base + 0x0070)
 #define LVTS_ATP1(__base)		(__base + 0x0074)
 #define LVTS_ATP2(__base)		(__base + 0x0078)
@@ -150,6 +151,7 @@ struct lvts_data {
 	int temp_offset;
 	int gt_calib_bit_offset;
 	unsigned int def_calibration;
+	u16 msr_offset;
 };
 
 struct lvts_sensor {
@@ -218,6 +220,7 @@ static const struct debugfs_reg32 lvts_regs[] = {
 	LVTS_DEBUG_FS_REGS(LVTS_EDATA01),
 	LVTS_DEBUG_FS_REGS(LVTS_EDATA02),
 	LVTS_DEBUG_FS_REGS(LVTS_EDATA03),
+	LVTS_DEBUG_FS_REGS(LVTS_MSROFT),
 	LVTS_DEBUG_FS_REGS(LVTS_ATP0),
 	LVTS_DEBUG_FS_REGS(LVTS_ATP1),
 	LVTS_DEBUG_FS_REGS(LVTS_ATP2),
@@ -788,6 +791,8 @@ static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl
 
 		if (gt) {
 			lvts_ctrl->calibration[i] = calib;
+			if (lvts_ctrl->lvts_data->msr_offset)
+				lvts_ctrl->calibration[i] += lvts_ctrl->lvts_data->msr_offset;
 		} else if (lvts_ctrl->lvts_data->def_calibration) {
 			lvts_ctrl->calibration[i] = lvts_ctrl->lvts_data->def_calibration;
 		} else {
@@ -1095,6 +1100,17 @@ static int lvts_ctrl_calibrate(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	for (i = 0; i < LVTS_SENSOR_MAX; i++)
 		writel(lvts_ctrl->calibration[i], lvts_edata[i]);
 
+	/* LVTS_MSROFT : Constant offset applied to MSR values
+	 * for post-processing
+	 *
+	 * Bits:
+	 *
+	 * 20-0 : Constant data added to MSR values
+	 */
+	if (lvts_ctrl->lvts_data->msr_offset)
+		writel(lvts_ctrl->lvts_data->msr_offset,
+		       LVTS_MSROFT(lvts_ctrl->base));
+
 	return 0;
 }
 
-- 
2.39.5


