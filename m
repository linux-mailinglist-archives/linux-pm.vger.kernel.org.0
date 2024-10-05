Return-Path: <linux-pm+bounces-15208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC89915DC
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16F3B2467A
	for <lists+linux-pm@lfdr.de>; Sat,  5 Oct 2024 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ED41531F9;
	Sat,  5 Oct 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="e0HwC/oc"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BED13DDDD;
	Sat,  5 Oct 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122795; cv=none; b=IWTxrwRwPCsAXbPayBn4JQEGPswWQvIHPrzJXYkBkMxEj+GceFNYlPlBmsH9aEwFIfdaPc/nPzyyCULFVP11hMwkxoSo19t2P0iEIy2RraB9e3WnjHSOJwiU7f1I8wAN+0KL9ao/5vZ+3INbO/c9MrHaMqbINpBnzZ0hL6YRXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122795; c=relaxed/simple;
	bh=iaZA482jF5FfFGlgdv4MON26pqjatXtV2BsozZy2/eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAGG+NqJiZ/rE3ch4L2jmEkiI+mufuMUw8brh+8rrjRWGYIElox9r5jKbefZ2Zqg/ok3rXF2xI3Mppt9dZsk/vCxbeyVpvwaJSQZ5uBBLeE1Gz7CTS/OYT0Kv16OwIJcgaRYbEp5X1hrq6lWdZbLU2sKlWd/QlLIW7qj64QCOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=e0HwC/oc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122791;
	bh=iaZA482jF5FfFGlgdv4MON26pqjatXtV2BsozZy2/eI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e0HwC/oct/PbLG/CJCb5Ldue2PY9AH+BmBVqdFSuQjBSXgQOytKpqtL4JkwND7gLX
	 oRRLmGK2ePcwKhxc5MTdAIZxFPOPMVLcrygl0gYNUgROpyQNHAzQJz7+ZDDQcpX14o
	 Nv8O56gLzjaYqwA5JtvybYAd1wekVf/b139E4AVI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 05 Oct 2024 12:06:16 +0200
Subject: [PATCH 2/4] power: supply: core: unexport
 power_supply_property_is_writeable()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241005-power-supply-cleanups-v1-2-45303b2d0a4d@weissschuh.net>
References: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
In-Reply-To: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122791; l=2920;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iaZA482jF5FfFGlgdv4MON26pqjatXtV2BsozZy2/eI=;
 b=gokUJLtPrG3OxCXLQQM2qYbnzx7BmEzF6IYQdyaiIB6VX7GClPy1ikwPL55WN6KM4smoW2deB
 iy84iJWZ+K+B/ukTEGH65uM+okHfok/dShgtqrbptWle8JWfBLi2xO5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since commit ("power: supply: Drop use_cnt check from power_supply_property_is_writeable()"),
this function does not check use_cnt anymore, making it unsuitable for
general usage. As it is only used by the psy core anyways, remove it
from the public header and unexport it to avoid misusage.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/power_supply.h       | 3 +++
 drivers/power/supply/power_supply_core.c  | 1 -
 drivers/power/supply/power_supply_hwmon.c | 1 +
 include/linux/power_supply.h              | 2 --
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 3cbafc58bdad0b9766441fa22981e5cf15870c80..1bc57615ba68fb33e5b77f720e454dbba6daa291 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,6 +13,9 @@ struct device;
 struct device_type;
 struct power_supply;
 
+extern int power_supply_property_is_writeable(struct power_supply *psy,
+					      enum power_supply_property psp);
+
 #ifdef CONFIG_SYSFS
 
 extern void power_supply_init_attrs(void);
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c4608c60f7de2618941aae6e345a413ee249c0ae..3fea6c973d751ba97ab5e132895eaf39c3a79266 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1233,7 +1233,6 @@ int power_supply_property_is_writeable(struct power_supply *psy,
 {
 	return psy->desc->property_is_writeable && psy->desc->property_is_writeable(psy, psp);
 }
-EXPORT_SYMBOL_GPL(power_supply_property_is_writeable);
 
 void power_supply_external_power_changed(struct power_supply *psy)
 {
diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 6fbbfb1c685e6c7fde41ea2fa88a557ed6dda2a1..01be04903d7d2465ae2acb9eeb0b55a87868bb87 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -7,6 +7,7 @@
 #include <linux/hwmon.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
+#include "power_supply.h"
 
 struct power_supply_hwmon {
 	struct power_supply *psy;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 910d407ebe6323aaf4b31f0081f2cdd4be43a9fa..ea0ba149f296644bd18717d91f338172602eb6d6 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -863,8 +863,6 @@ static inline int power_supply_set_property(struct power_supply *psy,
 			    const union power_supply_propval *val)
 { return 0; }
 #endif
-extern int power_supply_property_is_writeable(struct power_supply *psy,
-					enum power_supply_property psp);
 extern void power_supply_external_power_changed(struct power_supply *psy);
 
 extern struct power_supply *__must_check

-- 
2.46.2


