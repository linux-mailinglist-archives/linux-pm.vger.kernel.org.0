Return-Path: <linux-pm+bounces-17689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8809D0964
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 07:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F6F1F212CF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A2148318;
	Mon, 18 Nov 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gvwt19Ie"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E680BFF;
	Mon, 18 Nov 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910568; cv=none; b=S1wpn/ETvpHFQM3J9zhpPGQMi7Z6zt86lJBTVgNSwCIR6ORpSspJ/0DWWDfX5PLsMwkrniZIo0MKCZKl1jBCPARhMNWHMiecKPi71CLxCEswtbtgOd4NMGTLsX749SgQ2AFi85yD79CSFLr3qI9/Kss/9f+3vzg5ky6EFygS7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910568; c=relaxed/simple;
	bh=XQgvZFznm/KTm80suFUAjYCJpg8vLqeuB0js8ihQD+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyEG12Y2RVEcMOVmQqRNCvhwmFNtf/bBUYszZjZc/kMGQQJmTSrtlSmFyj2m/V0uBBiF13CIScVbmyC6Ais2ICLmBVXS26Y3GJjG3CLJaBKFhlIrg5yMCsTbPwxppI6rkXgVW76q/9uLokyYKhlbDoDWU4EPg4cvqXPDpl3TCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gvwt19Ie; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731910561;
	bh=XQgvZFznm/KTm80suFUAjYCJpg8vLqeuB0js8ihQD+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gvwt19Iel5AVInp6oXH5A1Cbzqlqs/6PDKtFpkkHaawZQ76C7Nk+o4TWPz5JQziyf
	 Rhwm1WDvNdDuCcJKBpowoDZm/apEj6WTenoiUIkU8y6nTqzYOykzZLkP4Rkhg2SCoa
	 4Ko9Ie+xuSCCrc976ThnU50SfbjIBxEPbI9KbsrU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 18 Nov 2024 07:15:59 +0100
Subject: [PATCH v3 2/2] hwmon: (core) Avoid ifdef CONFIG_THERMAL in C
 source file
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241118-hwmon-thermal-v3-2-9c17973e7342@weissschuh.net>
References: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net>
In-Reply-To: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731910561; l=2293;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XQgvZFznm/KTm80suFUAjYCJpg8vLqeuB0js8ihQD+w=;
 b=WEIs60uRkDtK8HMWMK5J2YA8reycwreYFxJTMjU5qXgPwOujG0KcQfIUaSPKnVj69BdehRPWa
 +e2AJ6tqDpRB4R6XrF9oM92haadQmnuBy957+ActuAPb7GiEM9lJWU4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Using an #ifdef in a C source files to have different definitions
of the same symbol makes the code harder to read and understand.
Furthermore it makes it harder to test compilation of the different
branches.

Replace the ifdeffery with IS_ENABLED() which is just a normal
conditional.
The resulting binary is still the same as before as the compiler
optimizes away all the unused code and definitions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 9c35c4d0369d7aad7ea61ccd25f4f63fc98b9e02..86fb674c85d3f54d475be014c3fd3dd74c815c57 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -147,11 +147,6 @@ static DEFINE_IDA(hwmon_ida);
 
 /* Thermal zone handling */
 
-/*
- * The complex conditional is necessary to avoid a cyclic dependency
- * between hwmon and thermal_sys modules.
- */
-#ifdef CONFIG_THERMAL_OF
 static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
@@ -257,6 +252,9 @@ static int hwmon_thermal_register_sensors(struct device *dev)
 	void *drvdata = dev_get_drvdata(dev);
 	int i;
 
+	if (!IS_ENABLED(CONFIG_THERMAL_OF))
+		return 0;
+
 	for (i = 1; info[i]; i++) {
 		int j;
 
@@ -285,6 +283,9 @@ static void hwmon_thermal_notify(struct device *dev, int index)
 	struct hwmon_device *hwdev = to_hwmon_device(dev);
 	struct hwmon_thermal_data *tzdata;
 
+	if (!IS_ENABLED(CONFIG_THERMAL_OF))
+		return;
+
 	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
 		if (tzdata->index == index) {
 			thermal_zone_device_update(tzdata->tzd,
@@ -293,16 +294,6 @@ static void hwmon_thermal_notify(struct device *dev, int index)
 	}
 }
 
-#else
-static int hwmon_thermal_register_sensors(struct device *dev)
-{
-	return 0;
-}
-
-static void hwmon_thermal_notify(struct device *dev, int index) { }
-
-#endif /* IS_REACHABLE(CONFIG_THERMAL) && ... */
-
 static int hwmon_attr_base(enum hwmon_sensor_types type)
 {
 	if (type == hwmon_in || type == hwmon_intrusion)

-- 
2.47.0


