Return-Path: <linux-pm+bounces-18782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8819E85A6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 15:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5477A281612
	for <lists+linux-pm@lfdr.de>; Sun,  8 Dec 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9713F42F;
	Sun,  8 Dec 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oEZbeElD"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF21482E7;
	Sun,  8 Dec 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733669977; cv=none; b=KlyACPmhmoE1vSaN5NjX1zyGHc3ovgjCJJKRU9V83Z1wUSLoFjp/kt7sB6f3R7MXmtf+3Gv4mxmxtrvEur4d56sKqqLsxUpnaYcts3rt+PKVpdvp9jE6sT7sKtXOAbSra7YzC1lzSc2d0gUQt9Pr7faBsgFc5HS+R3HifIrMI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733669977; c=relaxed/simple;
	bh=3iA03vlkmk8eRVaaMnlEdEo46SKU6oHesbNcFaZ3nK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVYISuLQdF7d0w9ToaCTVNC4AL38j7vcpLq9ZrgJB+PmjOfpN02pRYNNXHrqaPDSUrTCJjW/4i4l7J9fPSFO5UHrQV6asUY92W/rS4Nq6SXk6GtD7VjwqJyYMf19YarhTUqk4o3BcT5PA5nqh8Kr1H4WlkuvNSmBR9aKdl6DctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oEZbeElD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733669973;
	bh=3iA03vlkmk8eRVaaMnlEdEo46SKU6oHesbNcFaZ3nK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oEZbeElDCGXMIki3voW+rTCAMijAk4Pg7tP/cJmy49BgBYNfmoSFwdb3T64WRliAM
	 9Pif9KkVO5W9Zwyq7Ji+00HKm9lpiRLOfL9NNzPj/IyYQvMTj5ByfvhLSWCRHEesw6
	 tDbuiRnPeFWe3qxBYQlHNus7TLoyz4MXXaREyI9c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 08 Dec 2024 15:59:26 +0100
Subject: [PATCH 1/3] power: supply: cros_charge-control: add mutex for
 driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-cros_charge-control-v2-v1-1-8d168d0f08a3@weissschuh.net>
References: <20241208-cros_charge-control-v2-v1-0-8d168d0f08a3@weissschuh.net>
In-Reply-To: <20241208-cros_charge-control-v2-v1-0-8d168d0f08a3@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Thomas Koch <linrunner@gmx.net>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733669972; l=4209;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3iA03vlkmk8eRVaaMnlEdEo46SKU6oHesbNcFaZ3nK8=;
 b=k1t8pVBTjnSJ3XYByNz9U/4joMtP+VFz+aPp2WmWbAJ1oKmxP3gT2N221g5hbt0rmgNZGAnMl
 /Tcy19aikYaDFyR/m+BSHIZ/o217xybOlC7YZF5WkY1eHhGITTd96yr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Concurrent accesses through sysfs may lead to inconsistent state in the
priv data. Introduce a mutex to avoid this.

Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/cros_charge-control.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 17c53591ce197d08d97c94d3d4359a282026dd7d..58ca6d9ed6132af63a36ea4c5bf212acf066936c 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -7,8 +7,10 @@
 #include <acpi/battery.h>
 #include <linux/container_of.h>
 #include <linux/dmi.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
@@ -49,6 +51,7 @@ struct cros_chctl_priv {
 	struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
 	struct attribute_group group;
 
+	struct mutex lock; /* protects fields below and cros_ec */
 	enum power_supply_charge_behaviour current_behaviour;
 	u8 current_start_threshold, current_end_threshold;
 };
@@ -85,6 +88,8 @@ static int cros_chctl_configure_ec(struct cros_chctl_priv *priv)
 {
 	struct ec_params_charge_control req = {};
 
+	lockdep_assert_held(&priv->lock);
+
 	req.cmd = EC_CHARGE_CONTROL_CMD_SET;
 
 	switch (priv->current_behaviour) {
@@ -159,6 +164,7 @@ static ssize_t charge_control_start_threshold_show(struct device *dev,
 	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
 							       CROS_CHCTL_ATTR_START_THRESHOLD);
 
+	guard(mutex)(&priv->lock);
 	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_start_threshold);
 }
 
@@ -169,6 +175,7 @@ static ssize_t charge_control_start_threshold_store(struct device *dev,
 	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
 							       CROS_CHCTL_ATTR_START_THRESHOLD);
 
+	guard(mutex)(&priv->lock);
 	return cros_chctl_store_threshold(dev, priv, 0, buf, count);
 }
 
@@ -178,6 +185,7 @@ static ssize_t charge_control_end_threshold_show(struct device *dev, struct devi
 	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
 							       CROS_CHCTL_ATTR_END_THRESHOLD);
 
+	guard(mutex)(&priv->lock);
 	return sysfs_emit(buf, "%u\n", (unsigned int)priv->current_end_threshold);
 }
 
@@ -187,6 +195,7 @@ static ssize_t charge_control_end_threshold_store(struct device *dev, struct dev
 	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
 							       CROS_CHCTL_ATTR_END_THRESHOLD);
 
+	guard(mutex)(&priv->lock);
 	return cros_chctl_store_threshold(dev, priv, 1, buf, count);
 }
 
@@ -195,6 +204,7 @@ static ssize_t charge_behaviour_show(struct device *dev, struct device_attribute
 	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
 							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
 
+	guard(mutex)(&priv->lock);
 	return power_supply_charge_behaviour_show(dev, EC_CHARGE_CONTROL_BEHAVIOURS,
 						  priv->current_behaviour, buf);
 }
@@ -210,6 +220,7 @@ static ssize_t charge_behaviour_store(struct device *dev, struct device_attribut
 	if (ret < 0)
 		return ret;
 
+	guard(mutex)(&priv->lock);
 	priv->current_behaviour = ret;
 
 	ret = cros_chctl_configure_ec(priv);
@@ -290,6 +301,10 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
+
 	ret = cros_ec_get_cmd_versions(cros_ec, EC_CMD_CHARGE_CONTROL);
 	if (ret < 0)
 		return ret;
@@ -327,7 +342,8 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	priv->current_end_threshold = 100;
 
 	/* Bring EC into well-known state */
-	ret = cros_chctl_configure_ec(priv);
+	scoped_guard(mutex, &priv->lock)
+		ret = cros_chctl_configure_ec(priv);
 	if (ret < 0)
 		return ret;
 

-- 
2.47.1


