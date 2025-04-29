Return-Path: <linux-pm+bounces-26398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF49AA3BC4
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC65462E95
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E09B2BCF7A;
	Tue, 29 Apr 2025 22:55:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09229E07E;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967308; cv=none; b=agfpolJdTVKofhjCc5bV4HCAyYTZL0GLZSlW3jYKZTxqgo7NGosOJ6CX4+Xpvw/PAeihVyoxiwDiiZJ8PWpe3RA6P4+zrBVTbEg2GtvAGVG+ZdnQhBw9oHqjeMPJLNNVhZ/W/LQmX/lAzsYKDxZJZrI3UMrYOZDPTxojrzJzp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967308; c=relaxed/simple;
	bh=VdxKhz6N3WuAtyhJvRnjh/8RH3azoVAUuV/Qt7lH9OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1CNP3Inn7AbtJfAAhcoe3r94R3q5xzzgmM5PsIny+UlrmKr7jd956KIkb5sLNcWW9mH8c3MOJzaWskjTA4iYEY834xYH9eJjCOIHQk16zIjRkwsyz5fcI/eY60Bdum1WOYmjfg9J9AUU/QC/m5Lza7VwwSVVJWBlx3FzO3KGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66969C4CEE3;
	Tue, 29 Apr 2025 22:55:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 9B5DC180F44; Wed, 30 Apr 2025 00:55:05 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 30 Apr 2025 00:54:24 +0200
Subject: [PATCH v2 2/5] power: supply: core: remove of_node from
 power_supply_config
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-psy-core-convert-to-fwnode-v2-2-f9643b958677@collabora.com>
References: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
In-Reply-To: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=VdxKhz6N3WuAtyhJvRnjh/8RH3azoVAUuV/Qt7lH9OU=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBoEVjIQWkdUql6NNuli5U3aY4Y/bKXE4oGhtlL1
 v31l/zwZ+6JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaBFYyAAKCRDY7tfzyDv6
 mvqJD/4q4P+lOwNAv610m+hf8jOlOOuGuYYiqa9IXiJfUz/0xX0sCa+00tOsyfqDXQvWa4n3nYt
 utv05VXwMp7e0Q6d8W4Nm2+JPgnCKIQ9h5p95IUNEz66Wa8IEiVSOv9xr8K1Axttg2dzaUuGf9m
 DYcuEBWCZJHWKFbDHcxbPKU3jRCSl496VdcyVgtg1o1XHERNLn5t7wYGiagIbi9DcrxyC7oY04O
 9DnUT2ATJBc7RD9Zmbxvsl3sti1nPKepXQ3k4abfGyWByko3PmhV1E6QhB4YJ8XxFH2v17dN2Td
 KB48RRjmYn1PEy98E08AlS6Qd20BlG5phguqg7IXXgaQpmzImHrK3d+fzyn/fwxrmuJgjiG0YlX
 w04O0uJU3Wpush0TofNEsCZISQmMsme6I//qyYCm50AlN2pbBiFLH/WAL0bxpsxC/iTRPuuCoFr
 G90uC6GdFhYTvEAn1kIO5CuyVYvgP/TRKDULENPtCWvlW3Mln8BH2UpsbT0ZPJnTtK9eD6aWuVD
 2qvRwdI0TY68ncJoa9wSG+s5Y6UdVZEZ23qiNd7oPaXYpXNmvx/szd4GSf876ybw3YrdUbG8kdK
 bZKjAqLrvF8EAj8HvOyruxQTn0VLj7FSOg+eW5wqcwc3X99jsnvoVYfTq46xVxje3y4kSRxn0G3
 e0Ci+mdeca0kTKA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

All drivers have been migrated from .of_node to .fwnode,
so let's kill the former.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 3 +--
 include/linux/power_supply.h             | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 33a5bfce4604f012344733ba489eda1c5e8b92c0..89947f1fe610d8a75756e1e4e5339b06349f9ab8 100644
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
index c4cb854971f53a244ba7742a15ce7a5515da6199..b6eb31a23c878aa9ed8ad7bcb02a13721354e1cb 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -229,7 +229,6 @@ struct power_supply;
 
 /* Run-time specific power supply configuration */
 struct power_supply_config {
-	struct device_node *of_node;
 	struct fwnode_handle *fwnode;
 
 	/* Driver private data */

-- 
2.47.2


