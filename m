Return-Path: <linux-pm+bounces-28254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7ABAD143E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C76168855
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16867254855;
	Sun,  8 Jun 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9l3PJ3G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FCA18CC1C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415217; cv=none; b=O2ejUlrDB4zmAXWxcJmFCO/GNXXsKYe6UeLrDOH3/mEsGlS/Tg2TvdFvlTJGLpWyGYAr92gY2hHbeid3ZhLUn7JRtg1t5yNKVyBCrkwRi/8wBmvN+bjZisz/Djo9d9TDkJUAMSEc/fZYhgdefjmCOFtpkQKpziwpXCU+0DFHwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415217; c=relaxed/simple;
	bh=6k84NDF/UFSgdkBu89qk4s4Ny/cAH9w+gjDgw6Nkv24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlqlgHmb3TeiWjjd9ROHDcbLisvSeUQ/xec91cJdJShMbMbsqxku9EddyV9ay/wxxmB3gYr7vlvcoInX/BFxKE7PBSLVy34S1qM1xPJslJno++iGkU42RFksGQcG9z3nfrdoLvSaXPOHwog8mQI9joBkhULzCP8SMxBDcM3VGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9l3PJ3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7775C4CEF3;
	Sun,  8 Jun 2025 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415216;
	bh=6k84NDF/UFSgdkBu89qk4s4Ny/cAH9w+gjDgw6Nkv24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9l3PJ3GyTDZ5a/F+rDfnll9tQHq1MDW6p6zlKIaAdfTIGrO1kjIcH7td+O/6UNco
	 3+Ern4bJUi/UuLLnH03eGomEHnTfTs1Ke/YPbt37X2e+lVivpJi5XgxSofuU7Cqeiz
	 Q70W2twBM3bTaoBncyaRGWgSo6IUfkyvSw11cRZbQxwE+nGpCm4c6H3RErfXYMGgL3
	 0KQhS5Q1VxlxliUb7gU6O30FbL94wrAMSnBygjp/WWu9NU1hsmz+yZQ3t6Tptj9vJg
	 SwUi8orWDDt//PRCUvoqCPJWPuw7imgIisFgBKtwOvl3WV1bPSSHNEW/HJnf0zJJ3H
	 QwOG7zcs4Ma4A==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 01/10] regulator: act8865-regulator: switch psy_cfg from of_node to fwnode
Date: Sun,  8 Jun 2025 22:40:01 +0200
Message-ID: <20250608204010.37482-2-hansg@kernel.org>
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

In order to remove .of_node from the power_supply_config struct,
use .fwnode instead.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250430-psy-core-convert-to-fwnode-v2-1-f9643b958677@collabora.com
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 0457af23c55a..b2a6ddc6f56d 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -643,7 +643,7 @@ static int act8600_charger_probe(struct device *dev, struct regmap *regmap)
 	struct power_supply *charger;
 	struct power_supply_config cfg = {
 		.drv_data = regmap,
-		.of_node = dev->of_node,
+		.fwnode = dev_fwnode(dev),
 	};
 
 	charger = devm_power_supply_register(dev, &act8600_charger_desc, &cfg);
-- 
2.49.0


