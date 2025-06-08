Return-Path: <linux-pm+bounces-28255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A25AD1440
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33AB1889F88
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF25254878;
	Sun,  8 Jun 2025 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHcIhLPy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B518CC1C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415218; cv=none; b=iEMopf0UpxuPLpWRyUdDGxPa9ucMeIIaWvtqFKYlnMS2LVFamGNhb+YRojFDo7VgF4rBJtTw7NK7zu4lyEqul2bymQpdPHID+0V39LiWV6bRLQx3EhGKRy1NZ67cKmDGxEQErXJxta/W8DskatXGdD4xZfJ/QQ1jwCkYO4lATSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415218; c=relaxed/simple;
	bh=rdDVrZgNjdEGWhzWL2tEJ8faCkw6O/RR8FTXM1XB5n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtgEbYyk4LhZsoNEbFcb7uIz9RetsWbwhJDcvSNvJSOxXrE39wvNTr1O02NTZkjhie5ChpzQxPtZ67sGUa1f208OiyCszxWvzFhaDUZ6AnTKtlICTYrqED3COSPjcGler7HDQTfYgTryA/8WDlXL4h0P3XOh9arzCk4yBgWVKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHcIhLPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6A3C4CEF1;
	Sun,  8 Jun 2025 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415218;
	bh=rdDVrZgNjdEGWhzWL2tEJ8faCkw6O/RR8FTXM1XB5n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHcIhLPyTGvh/9Dt1EDwNJM/WzgAXlKtQ/qr1AYRpGMU8VYEUociSYhINIiOCDJOz
	 0GFbrXaPo5c7c0XTIkpMQfbqp+T7Yq2lckFff5N73ebM7aj8EJN2R039spe37fysAc
	 oICH5pbfDFjIXlCwtB/UfqCOtZ1ZgHEPRsP7Q8Ar0TuUFCsiBImPOo5dZDpqCryvJF
	 KZFhQK/+7iGrXvaRFVWBggHdEsI0dIiPly/z3zsk+TbMOYTnBJ+N9zYTbbQ4sgLTPL
	 YPdZZ2eSltFK7iHejDWUK83mjDqlpRl1v2nIVN8xgYUyRXO/apmnLe6Vtk/0gWXmjq
	 uiKBhbqaN2G6Q==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 02/10] power: supply: core: remove of_node from power_supply_config
Date: Sun,  8 Jun 2025 22:40:02 +0200
Message-ID: <20250608204010.37482-3-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608204010.37482-1-hansg@kernel.org>
References: <20250608204010.37482-1-hansg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>

All drivers have been migrated from .of_node to .fwnode,
so let's kill the former.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250430-psy-core-convert-to-fwnode-v2-2-f9643b958677@collabora.com
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 3 +--
 include/linux/power_supply.h             | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 33a5bfce4604..89947f1fe610 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1529,10 +1529,9 @@ __power_supply_register(struct device *parent,
 	dev_set_drvdata(dev, psy);
 	psy->desc = desc;
 	if (cfg) {
+		device_set_node(dev, cfg->fwnode);
 		dev->groups = cfg->attr_grp;
 		psy->drv_data = cfg->drv_data;
-		dev->of_node =
-			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
 	}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 03786c8c2efe..3e52883f866b 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -232,7 +232,6 @@ struct power_supply;
 
 /* Run-time specific power supply configuration */
 struct power_supply_config {
-	struct device_node *of_node;
 	struct fwnode_handle *fwnode;
 
 	/* Driver private data */
-- 
2.49.0


