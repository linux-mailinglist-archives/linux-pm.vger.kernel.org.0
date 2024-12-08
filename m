Return-Path: <linux-pm+bounces-18779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713099E854A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331EF164410
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D2C1598EE;
	Sun,  8 Dec 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NSeEINBQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59186154423;
	Sun,  8 Dec 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662967; cv=none; b=gHtfbHn7770xkF5gRfzeNkGZrythpseBe6z6OWDJY+ufu8M8OvmwPt7vBmCvJKI+sHnTJGi4RTx5oe+NSnoNF6TPfgMjHZp5Pn6nOAheHniyqr6MrwWkbTspa0rjPCSCCDqmPUTeZ704QydzX7oT/3sdtQBBw+t0Onb0H0JBv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662967; c=relaxed/simple;
	bh=2dKqKFfjbF4q4dgVkRSJTDS4XDDuY531CCkNnNU2v/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bj5QWPhYrkwDy+yi/CKzkfC6yVZIVs1sS7ZqeHzvMAnEwuFuTafUaGX1l1+zDdgooA73mJHiTx79gk9UTDTQ07Pcyy5mZAMmcfLmU6OQ8JN2bQWf05yamVyaPJjpcIPv06BCM/CM9V1Tmc13uPEUhQWZhLbtVWvrC2Hp1tqeAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NSeEINBQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733662959;
	bh=2dKqKFfjbF4q4dgVkRSJTDS4XDDuY531CCkNnNU2v/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSeEINBQAZwIT2crC2n8AWzhtAUvk0ZRv/4K6gaVDd14r7Af0oYj1iAg+kkJm9GRC
	 1rnJV6xltZiWwsR7tBWPuPQLEMZ5JX7ykTdzX8fD2bZL33BX4jvUVtEYUsPDKLrH4Q
	 V899gxmZ+ASGQaSiILouh4DQ+j5FfNZ2IKmsDjIY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 14:02:44 +0100
Subject: [PATCH 12/14] power: supply: bq2415x_charger: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-power-supply-dev_to_psy-v1-12-f95de9117558@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733662957; l=4630;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2dKqKFfjbF4q4dgVkRSJTDS4XDDuY531CCkNnNU2v/U=;
 b=fl6NyUbZzUygqkE8n5mGlJaPmOl1e2Qnj5+IuuYL9OnM4e4Dggoxre6aO/XUjBirBZI4WCzA0
 5RIGaEsfAy4DP0yI9bZLMSYzwziE+fMpj0LWXy0kj0qQOMhvE6wXr2/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/bq2415x_charger.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 25e28dac900deae8c3ab605f1fdab53c397c8ecb..5e174242d2dec49f0dc16822ae862af77a82f3d7 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1050,7 +1050,7 @@ static ssize_t bq2415x_sysfs_show_status(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_command command;
 	int ret;
@@ -1083,7 +1083,7 @@ static ssize_t bq2415x_sysfs_set_timer(struct device *dev,
 				       const char *buf,
 				       size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	int ret = 0;
 
@@ -1104,7 +1104,7 @@ static ssize_t bq2415x_sysfs_show_timer(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 
 	if (bq->timer_error)
@@ -1128,7 +1128,7 @@ static ssize_t bq2415x_sysfs_set_mode(struct device *dev,
 				      const char *buf,
 				      size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_mode mode;
 	int ret = 0;
@@ -1180,7 +1180,7 @@ static ssize_t bq2415x_sysfs_show_mode(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	ssize_t ret = 0;
 
@@ -1217,7 +1217,7 @@ static ssize_t bq2415x_sysfs_show_reported_mode(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 
 	if (bq->automode < 0)
@@ -1245,7 +1245,7 @@ static ssize_t bq2415x_sysfs_set_registers(struct device *dev,
 					   const char *buf,
 					   size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	ssize_t ret = 0;
 	unsigned int reg;
@@ -1280,7 +1280,7 @@ static ssize_t bq2415x_sysfs_show_registers(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	ssize_t ret = 0;
 
@@ -1298,7 +1298,7 @@ static ssize_t bq2415x_sysfs_set_limit(struct device *dev,
 				       const char *buf,
 				       size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	long val;
 	int ret;
@@ -1329,7 +1329,7 @@ static ssize_t bq2415x_sysfs_show_limit(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	int ret;
 
@@ -1357,7 +1357,7 @@ static ssize_t bq2415x_sysfs_set_enable(struct device *dev,
 					const char *buf,
 					size_t count)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_command command;
 	long val;
@@ -1392,7 +1392,7 @@ static ssize_t bq2415x_sysfs_show_enable(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);
 	enum bq2415x_command command;
 	int ret;

-- 
2.47.1


