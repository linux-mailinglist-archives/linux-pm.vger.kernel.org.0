Return-Path: <linux-pm+bounces-36269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0FABE3E1D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A2350487
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415A342C8F;
	Thu, 16 Oct 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FQw28xsL"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D9341ABE;
	Thu, 16 Oct 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624574; cv=none; b=E9Nq1cEA24gLasXqekNANAQ7Q1fPPHnPJv8wtyc6jQbkL5qGa1gmYDmfOn6kQWZNxGMqjUHwMZ987xHd9veL7kJXtX4sH6CD6dVoBqnM9mxSwf2MIeshQJ7WfJXRu+BqjiBC1YorG8G8dkseChkwCQZjDm7H2O5ToK4ne/aYbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624574; c=relaxed/simple;
	bh=jCXqcEMXs1uL4tQkq5stQbN8Jcv8lBZqo0hEUKZ0fBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ac63q+x55yuv6ufho0qDwvxTbqSZtqFN9x4DUDYAGM8d8sVDIIRBILn8mMUaIbYtzda4aCUQe4M6ncXGHlfJJQBlKX27JzdtsRSAt+DYd25nDYhfmijb9FFPhA1Yd/4Xz/JPjblnj8CZ4peQVAKaf4xHuX+qBGYR0D0GKBbsKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FQw28xsL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760624570;
	bh=jCXqcEMXs1uL4tQkq5stQbN8Jcv8lBZqo0hEUKZ0fBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQw28xsLHrk35bnJuqVq3idq1jqJVe8KC+yl/hy3bP2MQxPxY74fOyAKO4MwtEOwP
	 EMvudm449wSASMwGzClVO0G6GZ4V4+Nxst1KHYSW6Otasw/0NMWW4rJ7CvJ2nNVSQd
	 XIQ/TpFZFSDqe6g48sJnEnv1Bmu98PZRZWFI314FRCoPZaRWaesLn4QZ1WGhcCGNrk
	 fE0hyAAb1ld3ItlJJx4FFC6ll1so+nJXxwkP/APd27i60p/FBdJhMo00uQLTh8mjAw
	 V0XmzpSyUD1R/+wxJpSa8UqTNILT1vR7Punq+1nHQA1wG/9e4GSslemmVwKJbJzF4A
	 DCpprzI3LIr6g==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:655a:5eaa:d2ad:4ee4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E3B017E1404;
	Thu, 16 Oct 2025 16:22:49 +0200 (CEST)
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
Subject: [PATCH RESEND v3 7/9] thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit calibration data
Date: Thu, 16 Oct 2025 16:21:56 +0200
Message-Id: <20251016142158.740242-8-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016142158.740242-1-laura.nao@collabora.com>
References: <20251016142158.740242-1-laura.nao@collabora.com>
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
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 574e45400214..8ca5760cbb76 100644
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


