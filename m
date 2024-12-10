Return-Path: <linux-pm+bounces-18963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439FF9EBC44
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FD3188B0D6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4FE23EC03;
	Tue, 10 Dec 2024 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Eklv8FgB"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B923EA6E;
	Tue, 10 Dec 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867769; cv=none; b=FKgAGRvIKfKQzeEEWJR9uxEsB1gYXpRbnJzo936dbdIGnNf5FywwIZGGYBYwKXpRLPEXWGIlUld6gYIJsQKPLRB29Ntd4nep7F3LIutgPunbQDWKRM8A5GedF6SSAtj29zaXU3/fMuY2UZCRxITXVt1jDto9eXuT5qcyZH/RIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867769; c=relaxed/simple;
	bh=48p7mPpsAXRO57ND5gUhUi5Ak5EzGzJrWUgZH4nHfUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKfbJ5zffiQW9sEQfYyxgrC356rYaskaCHqr5iuNzSFXQNrnQZ+1cFlJ1tJHdVb+ZE9MtGWXqEWaLfxmLKJRTfWUTq+5kvs0PD0F76NNDS9kuwkL9ORLUGUF+p4goY5lJp+a5jaaMQw07lMAJFopCUh2oDLz0Agy/wKz9V4ZwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Eklv8FgB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733867761;
	bh=48p7mPpsAXRO57ND5gUhUi5Ak5EzGzJrWUgZH4nHfUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Eklv8FgBqa3Jp8M4d1XExpC048lhEnNN1qgZHgPuykN/AFnxjpqt/ecDSFsSsslvu
	 w7ZOTwcHxoQ7KWOgkZ2JCiunoEeUhtmsPi4UBR+zDjantjJftU4H6D+Cc/PH67K3Wr
	 12NWpgkaz6zGDCEYt3zAOfQz4YBru2S7IDvffE0k=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 10 Dec 2024 22:55:57 +0100
Subject: [PATCH v2 10/14] power: supply: ab8500: use dev_to_psy()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-power-supply-dev_to_psy-v2-10-9d8c9d24cfe4@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733867760; l=5236;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=48p7mPpsAXRO57ND5gUhUi5Ak5EzGzJrWUgZH4nHfUE=;
 b=mGz5x8KIANpd14dVQXyo40/JRb52bDqfyR9P4Dtmm+qHpTMDFGlLJyAPJOnwdCLnqRe5hmDzZ
 xjTMpX4Z3ohDhAdKYBKySJVnun3IvsfkrjVhZEjsJYMyEogTOw1IOOT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use the new, explicit accessor to go from a 'struct device' to its
'struct power_supply'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/ab8500_fg.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 549403c6f73c1581d373c6df83cbc255ab1c2e82..9dd99722667aeb81c1a3d88b40e11ca5a10ccad6 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2574,7 +2574,7 @@ static ssize_t ab8505_powercut_flagtime_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2597,7 +2597,7 @@ static ssize_t ab8505_powercut_flagtime_write(struct device *dev,
 {
 	int ret;
 	int reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	if (kstrtoint(buf, 10, &reg_value))
@@ -2624,7 +2624,7 @@ static ssize_t ab8505_powercut_maxtime_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2648,7 +2648,7 @@ static ssize_t ab8505_powercut_maxtime_write(struct device *dev,
 {
 	int ret;
 	int reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	if (kstrtoint(buf, 10, &reg_value))
@@ -2675,7 +2675,7 @@ static ssize_t ab8505_powercut_restart_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2698,7 +2698,7 @@ static ssize_t ab8505_powercut_restart_write(struct device *dev,
 {
 	int ret;
 	int reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	if (kstrtoint(buf, 10, &reg_value))
@@ -2726,7 +2726,7 @@ static ssize_t ab8505_powercut_timer_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2749,7 +2749,7 @@ static ssize_t ab8505_powercut_restart_counter_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2772,7 +2772,7 @@ static ssize_t ab8505_powercut_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2793,7 +2793,7 @@ static ssize_t ab8505_powercut_write(struct device *dev,
 {
 	int ret;
 	int reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	if (kstrtoint(buf, 10, &reg_value))
@@ -2821,7 +2821,7 @@ static ssize_t ab8505_powercut_flag_read(struct device *dev,
 
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2844,7 +2844,7 @@ static ssize_t ab8505_powercut_debounce_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
@@ -2867,7 +2867,7 @@ static ssize_t ab8505_powercut_debounce_write(struct device *dev,
 {
 	int ret;
 	int reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	if (kstrtoint(buf, 10, &reg_value))
@@ -2894,7 +2894,7 @@ static ssize_t ab8505_powercut_enable_status_read(struct device *dev,
 {
 	int ret;
 	u8 reg_value;
-	struct power_supply *psy = dev_get_drvdata(dev);
+	struct power_supply *psy = dev_to_psy(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,

-- 
2.47.1


