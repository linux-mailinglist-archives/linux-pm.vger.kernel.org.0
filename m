Return-Path: <linux-pm+bounces-18965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F069EBC49
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433B8283AF9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0623EC1A;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="W7OH3zKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511AB23EA71;
	Tue, 10 Dec 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=q0jICyi+LxKlN11A0qwJOXupvz0/7WE+/WoWCE4C4N+zQmQHgfc6UoWsjOirTm5nfjpsSLPREGs9OzLPPWam6ab0bjUQMoWWeKXcB/tFdgA1dD8DifetZiquZwX7UUXXK7e0t9pc+0huiokaTYQ8aZwGl/nzJSbXlAn/v1IApp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=2dKqKFfjbF4q4dgVkRSJTDS4XDDuY531CCkNnNU2v/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRr8WXMjfM3blNAe6ONQD3gkKawb870hFrGLHcNW9adbEjvZCQI7r8+BtDhcMAKvJULkmIoqQcy/C9DHgcquYA6RUMG8RJkUiLf5FcTE0xImg2lfWazcKlrvHaSWejErKN1SNKCf4hhlNt0ZSsjrZmthFrolkt6FcSijBHCp1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=W7OH3zKt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=2dKqKFfjbF4q4dgVkRSJTDS4XDDuY531CCkNnNU2v/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W7OH3zKtlXFRgYZ4Z78COkvoeJvW/RtWr/+k7ByOmlUknnTK5OTx2ggFht0VS/vDk
	 WgdR5ouz3yy44CbyL2oIAEbBWFXpXxfwZuMujKz2KnCgS4hp6W5ED1El7hPBxSTRON
	 dzvYjSXL7sMQ9P8FmTK42nX7AsfbVUSyeFXCgyXM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:59 +0100
Subject: [PATCH v2 12/14] power: supply: bq2415x_charger: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-12-9d8c9d24cfe4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=4630;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2dKqKFfjbF4q4dgVkRSJTDS4XDDuY531CCkNnNU2v/U=;
 b=iJ4gamw3zEASK9agIfjeDJ7FUg+h2iu3MQ5A1YYf8SdJLJ3ZrACkkwCTX3rhjJrf9a10Ogr4+
 0hKYhgi8tPBC6e89g+tg5lF5zKKfmcM5I+l8zJsZxwyithOZ0q12Wzw
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


