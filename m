Return-Path: <linux-pm+bounces-13612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDBA96C770
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 21:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F6FB21B7A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297BC1E6DD5;
	Wed,  4 Sep 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NkqAtUkg"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C631E6DC3;
	Wed,  4 Sep 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477954; cv=none; b=hanS83MnkO6NzJhnU5+6TwFWFBQ290uKHgVgr4MenYgYRc9UhP+tVIzm31jv1LzJYq9K8kfYvxdmzECfUwsroWHvcMmZAFTHmU6LT+/S/Jt/WpCN0MGCXCwCuUKbX9O52Wo5P3G+NS27jbT1k+fEuwZCkzNyAuxT+aCVGeckAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477954; c=relaxed/simple;
	bh=EV6+zz4CmbgtMfZTkgUenuapQZpHRoJn6kiU2fst8eU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOrM1S4kJP0m99Qk/G+4FCU3y81TyEpVotDJNmD6Vu3cyyBMdFHbzNPemQd7vf3B9mig2PmZ02cwr4qcj7ouJR/SZ1cCLUwBOC3FwhY2+HHmUBbPAy5apu28NZB8YicLXD7kqjr/0lwznp9JEqT+8I+idOVyAqQAML4SvekvWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NkqAtUkg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725477949;
	bh=EV6+zz4CmbgtMfZTkgUenuapQZpHRoJn6kiU2fst8eU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NkqAtUkgQ7X1tNJ/WN7qqdj4bs/ZmVGeEaF/0gNvuL/7pfcbpxsGJt/hVwgLkYAHX
	 qb2uSXQNK2EKxl5GhUr6Dqi8XZwcOah0tQP1XkLWS/4f2T+/8r6Cr8GT5uI4gXnPia
	 9+LK0e/2qxH93u27HD2t1Tqu/lbMlM8c/ff2jVgQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Sep 2024 21:25:36 +0200
Subject: [PATCH RFC v3 3/9] power: supply: hwmon: register battery
 properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-power-supply-extensions-v3-3-62efeb93f8ec@weissschuh.net>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
In-Reply-To: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725477949; l=3100;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EV6+zz4CmbgtMfZTkgUenuapQZpHRoJn6kiU2fst8eU=;
 b=97Z+BIzpLl/uyAcDMqYlGIi1i4RYmsJR3Y5+4OWUEJflVd8pdfW+cCM/lPoedVcBeohKw35mZ
 HlNgkaOj2dUBbHvfZAVfvtwSqbxOKFXVoJsDeQM4pZPCDE1dcNvT5z4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Instead of only registering properties from the psy_desc itself,
also register the ones from the battery.
Use power_supply_has_property() for this test which makes the logic also
easier to read.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply_hwmon.c | 52 +++++++++++++++----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index baacefbdf768..1c1ad3e1d81f 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -8,6 +8,8 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 
+#include "power_supply.h"
+
 struct power_supply_hwmon {
 	struct power_supply *psy;
 	unsigned long *props;
@@ -347,9 +349,28 @@ static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
 	.info = power_supply_hwmon_info,
 };
 
+static const enum power_supply_property power_supply_hwmon_props[] = {
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
 int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 {
-	const struct power_supply_desc *desc = psy->desc;
 	struct power_supply_hwmon *psyhw;
 	struct device *dev = &psy->dev;
 	struct device *hwmon;
@@ -375,32 +396,11 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		goto error;
 	}
 
-	for (i = 0; i < desc->num_properties; i++) {
-		const enum power_supply_property prop = desc->properties[i];
-
-		switch (prop) {
-		case POWER_SUPPLY_PROP_CURRENT_AVG:
-		case POWER_SUPPLY_PROP_CURRENT_MAX:
-		case POWER_SUPPLY_PROP_CURRENT_NOW:
-		case POWER_SUPPLY_PROP_POWER_AVG:
-		case POWER_SUPPLY_PROP_POWER_NOW:
-		case POWER_SUPPLY_PROP_TEMP:
-		case POWER_SUPPLY_PROP_TEMP_MAX:
-		case POWER_SUPPLY_PROP_TEMP_MIN:
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
-		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
-		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
-		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
-		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
-		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
-		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	for (i = 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
+		const enum power_supply_property prop = power_supply_hwmon_props[i];
+
+		if (power_supply_has_property(psy, prop))
 			set_bit(prop, psyhw->props);
-			break;
-		default:
-			break;
-		}
 	}
 
 	name = psy->desc->name;

-- 
2.46.0


