Return-Path: <linux-pm+bounces-18776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A91199E853D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68719281862
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A377E156F41;
	Sun,  8 Dec 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VBd5Nnk7"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB81547C8;
	Sun,  8 Dec 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662966; cv=none; b=Trf4YN7UJ3pmQTdvVhFBJcXnLo1cRZrnAdhqAJemZUYmvtDdlG0YctU6+twjaazqpPLCnCTD42+KLRfM9eAeQuniHpI7m+6UKFNhzgVEIMdNSwBRSORXPru+LyXqfynSQc3VOWNEAGhaFRz6cZ3AtvCjUNLMCcourozddd8eCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662966; c=relaxed/simple;
	bh=8VBKzyLSPAGekr2MvdVRCAUGf5HHmqa9y4g6LCA+Gek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKyxvG16bcYL2+8xIGe7UmLJ6M/njYt9UWlJAxqbvXGEIUjTZq8C0fs1wxGh2DSsHrvpohUlTzetKwAkCWOnK9ydP34tsMvnPsmX12MvAXQiGgtHO2Fo9Cc7CLJQHOqnldp24S/2EyklXQvdRSu0SR/IUgLkpdVNMAAxYm6sGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VBd5Nnk7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662959;
	bh=8VBKzyLSPAGekr2MvdVRCAUGf5HHmqa9y4g6LCA+Gek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VBd5Nnk7UGR9/O1gWDT9vrSiqSHlNZYciS8wBwBDjpP9MomheRuttXXz0RJbLfYVQ
	 5so69dT3HlzV+qXjMbXspPbdi9OmFJ/w0La6Ouh8d9R3N5G548CkAv9o0C3oMkGmc0
	 /Wx7ZKumEyh+dV/TdK7pXHyNnIk8ChZaWgWFy8oA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:43 +0100
Subject: [PATCH 11/14] power: supply: surface_battery: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-11-f95de9117558@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=1371;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8VBKzyLSPAGekr2MvdVRCAUGf5HHmqa9y4g6LCA+Gek=;
 b=6XUmrLCaEMEhfA4Q7Sku1lTXXndBwIVSSYBgAy3BE76a9+wvZTgV41My+szrGsaCxsjNP1ZPT
 eIoXTWs/adgCOkMlniBX6fIBxQFzMK9a6ga7GvU26FwkkKvhidbHe7f
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/surface_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index ebd1edde28f12aa7711e4ff07f8516abc8cbc946..c759add4df49dafc92538ef1316b19f186e73929 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -667,7 +667,7 @@ static int spwr_battery_get_property(struct power_supply *psy, enum power_supply
 
 static ssize_t alarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct spwr_battery_device *bat = power_supply_get_drvdata(psy);
 	int status;
 
@@ -681,7 +681,7 @@ static ssize_t alarm_show(struct device *dev, struct device_attribute *attr, cha
 static ssize_t alarm_store(struct device *dev, struct device_attribute *attr, const char *buf,
 			   size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct spwr_battery_device *bat = power_supply_get_drvdata(psy);
 	unsigned long value;
 	int status;

-- 
2.47.1


