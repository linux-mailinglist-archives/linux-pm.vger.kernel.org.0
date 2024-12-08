Return-Path: <linux-pm+bounces-18778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B59E8547
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC528165129
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86243158D8B;
	Sun,  8 Dec 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QPTqwV7g"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63915535A;
	Sun,  8 Dec 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662967; cv=none; b=ixwpwyKBaE5TV8qX49VScwG9wlcPwzeoCFvmxxA6bjHDRbFVH+FufkdXtKKeU4PEgps/nQnNV4aaRJdn361ofA557dltRc13aGpjcT8UVZakmf63BLUVGZoHjbkemiEXcqUqsRuc2sQksKonXOFeLply4GuorcjxDBQR15PL/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662967; c=relaxed/simple;
	bh=P5CWt3BVsC+c2sqfY7XeeNRv/K9JDQ71/LSy5sJxSQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2LBxS1FxGvynVLW15VEIjMh6UcOiTHvvC2N97bcf9Lj0Exz67wf6FjE7mBQwClV16Y3PS/rArjdltUbPKdFN3R9oWvOL3iotT2TxjWiu739eq/JVUQbG91JH2kJJw6r9cME6ctn+dVla+18BNXBUR1qN9QCf3SzuiK8sWtG+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QPTqwV7g; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662959;
	bh=P5CWt3BVsC+c2sqfY7XeeNRv/K9JDQ71/LSy5sJxSQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QPTqwV7g3sQT3FuQGsgZwf0uPwDJ5hlzPUvOk7fPg42EQoQG+41X8I832hQ9ST4kY
	 P9ujTTgYxMnB7e4wxfEdq6i2tvE/nouPcQg3NC74GT9PTtZ2Ip46HtCky38iE28GwP
	 tnbq7f6kQOxt7G1a4hot3qN+xZZ60TRwoVEbdOx4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:45 +0100
Subject: [PATCH 13/14] power: supply: bq24190_charger: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-13-f95de9117558@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=1395;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=P5CWt3BVsC+c2sqfY7XeeNRv/K9JDQ71/LSy5sJxSQA=;
 b=kVXKe5dgWBXpmkZ9ZjFJz+Ma6WmE7cLO52DrEVlG6HtVshddTBLykibnTJLvjAbJNTko+TImA
 BjKE2nfRNo6B4phYE4lP0+LQvdc5BsITfF0sct67Kok9Q2hhYPu3iPZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/bq24190_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 2b393eb5c2820e18d6244fad53efc6ef689613de..ebd2ca8d90644a37aa4ab2ddb30beec8d80da9b1 100644
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


