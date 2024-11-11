Return-Path: <linux-pm+bounces-17342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508AB9C4844
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F6E280CD3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 21:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77D1BD000;
	Mon, 11 Nov 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pGBoSBFJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0F1B140D;
	Mon, 11 Nov 2024 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361213; cv=none; b=rbu2utFiqKE3dY256v9pzfQXg2MnCKhsk3oSL2T0sE8PcK+qryxrl8L+h/ePTPFq//Llwit+FwUG+oaJBw44uL7djmftRCB0P1LvojHkGgvRChCTQzC85hxRUKpUrBV9+kKEZN8MjuaTGoQpz4FpRGDen21z9plwlSiqO9jBq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361213; c=relaxed/simple;
	bh=nhEr3viuDM9KKMmstDUchZ6pQ7Ygl+kyihGIUWgSr5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YibaJavdsNSiGczbFAaCIIJYLbsw9uTYLi+g4esfAf1QWbPYOQBcBm94GFvKBemqkHkBZabkTGp0QgxTI5lOLewR4Ag15FiSs+vt+R4W33CCT9NEjkcl2663aTdF8xURLfRw9/4g6OLVcGu1yO3IBXJVRvk8uSvMNO7iA1jWs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pGBoSBFJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731361208;
	bh=nhEr3viuDM9KKMmstDUchZ6pQ7Ygl+kyihGIUWgSr5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pGBoSBFJcbvwpZqwX8NEtzz7MOGCJq5GK6Jsyh8qD9R/1tKdOPeZhIxrJPZC98C33
	 wDx/kDBDLe6F2f/qawpuAhOcNyfGIqx3UTfrRN8fk0xEahKl7HOmvk17WGRwVBdWmg
	 drNiL/CurHq9wTNi8qLpqhs0s+fe4uZUB8/1m08E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Nov 2024 22:40:05 +0100
Subject: [PATCH v4 3/9] power: supply: core: introduce
 power_supply_has_property()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241111-power-supply-extensions-v4-3-7240144daa8e@weissschuh.net>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
In-Reply-To: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731361208; l=1978;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nhEr3viuDM9KKMmstDUchZ6pQ7Ygl+kyihGIUWgSr5M=;
 b=brMj9YXiKAD7Hm3c8wzeZH583aS8Oc/YZpIwPgS49fFSQ9wXJzuWKilB2qtnOu3g+19feJdqh
 wo6RHvE2HoRC7w38kaPcEIHBzN40BVQEOOZcBKn3UPqfI/OjabX9R70
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Introduce a helper to check if a power supply implements a certain
property. It will be used by the sysfs and hwmon code to remove similar
open-coded checks.
It also paves the way for the extension API to hook into.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply.h      |  2 ++
 drivers/power/supply/power_supply_core.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 7434a6f2477504ee6c0a3c7420e1444387b41180..5dabbd895538003096b62d03fdd0201b82b090e6 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -15,6 +15,8 @@ struct power_supply;
 
 extern int power_supply_property_is_writeable(struct power_supply *psy,
 					      enum power_supply_property psp);
+extern bool power_supply_has_property(struct power_supply *psy,
+				      enum power_supply_property psp);
 
 #ifdef CONFIG_SYSFS
 
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2f61f6b90b99f40ee04a6d63ebc20036f0447102..502b07468b93dfb7f5a6c2092588d931a7d015f2 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1196,6 +1196,18 @@ static bool psy_desc_has_property(const struct power_supply_desc *psy_desc,
 	return found;
 }
 
+bool power_supply_has_property(struct power_supply *psy,
+			       enum power_supply_property psp)
+{
+	if (psy_desc_has_property(psy->desc, psp))
+		return true;
+
+	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
+		return true;
+
+	return false;
+}
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)

-- 
2.47.0


