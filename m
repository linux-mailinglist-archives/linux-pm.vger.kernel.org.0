Return-Path: <linux-pm+bounces-18767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2209E8527
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154021642D4
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634014A615;
	Sun,  8 Dec 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Q5GLVUUs"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68836146A7A;
	Sun,  8 Dec 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662962; cv=none; b=Nhf592TvFlE3NJCTaS3D1Q2UIqpnIH8kfYmO28C0DZGyiwwhpEXzZOYqNGWHRo8KzoCxsgA4gWNRFsV/GqJXVz2Sdc3e7GArjevF3ls/rStP3egU850Y2YtwdOlDeCODZ8iVBQ3Mc590e6zSsgKvm3U0Q5HB1C/8zWqm+UHTOW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662962; c=relaxed/simple;
	bh=AnzrS0Cj4WPlkOAM/7ap8p1NV70oBJJ4Lt/P7u21PYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNkX4aislUHUUUrUNEEJRFOzHzKc6pgF8g8D+WX3UMnaDfBMTwr/gGrI2dc2AZmVjs04jTGKX+Dyzrq3ozpa/JzLa836c7b2qo3VqQZVk/NjT+uxPlHttCutYWepI9rAXKS70jkooNZlM+r1ZzNCZvMJ1j5yD1yySf04gsDO8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Q5GLVUUs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662958;
	bh=AnzrS0Cj4WPlkOAM/7ap8p1NV70oBJJ4Lt/P7u21PYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q5GLVUUsSko2aXHz7JNtIXp0fvxUoRqy4EyLypwH6Bs89NcI/hAK0QLIIr9MwsZBn
	 +aYFPFigBQiu7ROFTvyUybMctAZgFxPtfoOD2/IUNHwG/OkhriXM6pxhnufsWo+Q0q
	 mGZSQikv9ictcuQizCBkplobtPXcDwnBBSBte7tk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:37 +0100
Subject: [PATCH 05/14] power: supply: apm_power: use
 power_supply_for_each_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-5-f95de9117558@weissschuh.net>
References: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
In-Reply-To: <20241208-power-supply-dev_to_psy-v1-0-f95de9117558@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=1267;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AnzrS0Cj4WPlkOAM/7ap8p1NV70oBJJ4Lt/P7u21PYY=;
 b=+80ZNPfkGRGxK6lRxaPrZ1Vz6BhI94/bLD3wcpo14IJSiUR4a+CnF2acqiGZ/tGQHtM1zJ+/u
 EJR+JhZlVR8Bxlgy+PMZne/96D8ilcSeDP0Myuhq7lm9AxSyMuUdxS+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the callbacks by removing the need to convert a 'struct device'
into a 'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/apm_power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/apm_power.c b/drivers/power/supply/apm_power.c
index 8ef1b6f1f78793a6ec0dea524c2c21f08bd6bb35..9236e007857860e1001d192d9f1a5fe7204332f8 100644
--- a/drivers/power/supply/apm_power.c
+++ b/drivers/power/supply/apm_power.c
@@ -42,11 +42,11 @@ struct find_bat_param {
 	int max_energy;
 };
 
-static int __find_main_battery(struct device *dev, void *data)
+static int __find_main_battery(struct power_supply *psy, void *data)
 {
 	struct find_bat_param *bp = (struct find_bat_param *)data;
 
-	bp->bat = dev_get_drvdata(dev);
+	bp->bat = psy;
 
 	if (bp->bat->desc->use_for_apm) {
 		/* nice, we explicitly asked to report this battery. */
@@ -79,7 +79,7 @@ static void find_main_battery(void)
 	main_battery = NULL;
 	bp.main = main_battery;
 
-	error = power_supply_for_each_device(&bp, __find_main_battery);
+	error = power_supply_for_each_psy(&bp, __find_main_battery);
 	if (error) {
 		main_battery = bp.main;
 		return;

-- 
2.47.1


