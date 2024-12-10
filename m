Return-Path: <linux-pm+bounces-18966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 997EC9EBC4E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB4D188AE94
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8323F9EC;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jhQ6rsEh"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274E23236A;
	Tue, 10 Dec 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=Pp4WjV0l0HVO4YvckZNebDoLPRK7dc+mseUsk+2cg9QFINJONN74q7VPbZ6ScLdOIXvGi/ZW5R/o8W8JP+wma4cahLIWYXjtVP/JFvTCYdXm5exAfuMNCZKsOXYVFDq6lzQnA2ZhcDbfrZFemNmkiPdcLmpjKiVpwVfKt00BgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=YYfsTx2rAnMr87VKqCAX8bpgiZpeQGkncIQMEpK07sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bG6FWwKBSDV8zoYP4u9YI8TXVOU0XDTwEiTrfpqBzKftGJ3FJeDZKIFuPXcSoqpwnjL8WvyRbA25DEHlsBfH0bHRrhnauCO5oIgEJwc68wLX9bcv671hJHEAKvu/yFlWPEZo9zpSpfLNFzg/5keZrX5x2yCpHm5LplUN/zXkjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jhQ6rsEh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=YYfsTx2rAnMr87VKqCAX8bpgiZpeQGkncIQMEpK07sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jhQ6rsEhqm6JQD8SWTDPwBfkgM7UYsXdoFE+RzHh81VMZz729WYXBArTeCKRLWlfm
	 Gi5//PzQKjLTAoPTUCzsjQ8zwCXMupdRdcrQCz7vU6HimDMqpcdjBEaNWNrh0rEyJs
	 NRw4MAA2IMtEQ1SOcfLRWXkDb8lgVly2eCVwzKF0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:56:01 +0100
Subject: [PATCH v2 14/14] power: supply: bq24257_charger: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-14-9d8c9d24cfe4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=1965;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YYfsTx2rAnMr87VKqCAX8bpgiZpeQGkncIQMEpK07sc=;
 b=+jfvoBiDpY9K6pnoLrb7gnIQKqzEb3DlfDqsf6iP7AovaJ+kjrCsZ58aDj31URy+kM0bpLMv9
 LKqphB6enIBACKy//f/CNyuQIpfsuoNgt6i1E9EIOOPOvgFA0vIn/AJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/bq24257_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 801d0d2c5f2eae90c9c1cbbbfcfb258d257038d5..1416586f2459109b29fe57a5ee86fa3704013aac 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -759,7 +759,7 @@ static ssize_t bq24257_show_ovp_voltage(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq24257_device *bq = power_supply_get_drvdata(psy);
 
 	return sysfs_emit(buf, "%u\n", bq24257_vovp_map[bq->init_data.vovp]);
@@ -769,7 +769,7 @@ static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq24257_device *bq = power_supply_get_drvdata(psy);
 
 	return sysfs_emit(buf, "%u\n", bq24257_vindpm_map[bq->init_data.vindpm]);
@@ -779,7 +779,7 @@ static ssize_t bq24257_sysfs_show_enable(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq24257_device *bq = power_supply_get_drvdata(psy);
 	int ret;
 
@@ -801,7 +801,7 @@ static ssize_t bq24257_sysfs_set_enable(struct device *dev,
 					const char *buf,
 					size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq24257_device *bq = power_supply_get_drvdata(psy);
 	long val;
 	int ret;

-- 
2.47.1


