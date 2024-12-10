Return-Path: <linux-pm+bounces-18964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE499EBC4A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD45188B0F2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F44723EBEC;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WMIDN/Zm"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122D23EA72;
	Tue, 10 Dec 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=bvBHgrTmeG2cRuUX2nkj9NCNQkfJihsSAtMa7ZXnmS0CGe18SJxUxdaeBcjYbHME8rmhlRU/kiQ6Xd+O99ogcVGBrVC4NbwiF63dziv6ShH+CTNU8TC8CoVSDBRY7apEUe8/IWsq5UAM9Jz8veeD7QHEpz+jgwCdXNRdKgRGXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=nIcvu1PbHs9o1TJjSMqsv4HKZSKfRqzmsx36a6kqvSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zj2J+TeQBhJMCMfjhoJtDcRVgD8E0De15T1i+V2xrEw18AcuNi7Tt0kb4aKO/n6kFgZTLqj/++iG7RztLyfUvRV+xP9f0Bf+TWdd0/XQmUGzsJy2eZQuwloaXwGo5TtBWKUC9H2DJ7dR2SfEnjVifz664XTq//gsYNC1fh9761U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WMIDN/Zm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=nIcvu1PbHs9o1TJjSMqsv4HKZSKfRqzmsx36a6kqvSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WMIDN/ZmDrHFDL2rqB652u1UscK7mzhUqfWZjBVq5Az3E1aF5Av3CmLjD0FqUpDrc
	 5zKRup6c/625xNE60TfJ8McU5gmdAtoYlgKtoHVD9wgsPhlSesY7CIHxE83svDY9Se
	 1YU+9MwdMVL5opVbp7+JZqIMrrmJxtDkSrPeM2pk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:56:00 +0100
Subject: [PATCH v2 13/14] power: supply: bq24190_charger: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-13-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=1395;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nIcvu1PbHs9o1TJjSMqsv4HKZSKfRqzmsx36a6kqvSs=;
 b=PCYmuYBtKoa9dCIIJ5iQR6/WCQiwYfJO3LwPKU6lHQBClxPRLngDpjCO2DpE0mL16fb9VaCid
 SRD0BzRvdFzAzQrm9bge6gjyBzg5yzyBu5YdatjJlZQ4B2M7o8GNfmT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/bq24190_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 3b97f788496795b321c12ee69df29c701cb83031..b71e21a0196a4becace5233c1cbe89c24e2004e2 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -480,7 +480,7 @@ static struct bq24190_sysfs_field_info *bq24190_sysfs_field_lookup(
 static ssize_t bq24190_sysfs_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	struct bq24190_sysfs_field_info *info;
 	ssize_t count;
@@ -510,7 +510,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 static ssize_t bq24190_sysfs_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
 	struct bq24190_sysfs_field_info *info;
 	int ret;

-- 
2.47.1


