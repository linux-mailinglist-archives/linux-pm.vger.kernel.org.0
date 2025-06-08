Return-Path: <linux-pm+bounces-28257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB62AD1442
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA093AAC53
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C50254874;
	Sun,  8 Jun 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twnlZ+iA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB318CC1C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415222; cv=none; b=F4kZ3aax25cXjXeDEpmDU2gquHYYE/0B6/zpZutFPkADL4Od5EsFqjMOYfzhkPgS48oRnll6gmGB6GQ0Wm6pohnzd2YD7MPE/sVhiNGgzc97edJxDEAAL7s18nqFlXSE0Vmv7pbFUfKmLUKtMKRqz593BXYtXT63g6CUjn6KlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415222; c=relaxed/simple;
	bh=vuKnESaBbThs2Ul53Pi+Hd5SXFdYZONrY95yvzz06xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkxmSuZuhH7yIVBgJfUNffpSUex6LpgqS9HvcQZnzVZD+PXShzlu/7L70b+F0IuIQD/ZdChuVWddGiQtXe7Ze2br4h1QUkuidWi7QMU7ZoZOjGLD8Bxwrhzk6iL5nYNyEqSkPwVixQCNNKmJlx+ExwTy7FezPTdI3F6sLPxUt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twnlZ+iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC48C4CEF1;
	Sun,  8 Jun 2025 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749415222;
	bh=vuKnESaBbThs2Ul53Pi+Hd5SXFdYZONrY95yvzz06xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twnlZ+iAOVl9p1TkuVd50Y4b6DefTMarMqIJ42O5ksBv7szNIMHdlLJeIRIdnwxS4
	 7ksyETRk0WETxu8e/m1A1pUbbzgtwLoyqL9jVFj53kFEwHWYPxTv4+10HDkHjBx0TO
	 GosFIWEs5wh1rPMCuIQvPTqvmEDrGr4vAvXV8HUux9B4xe+lThjFhAQekAVy47vLdh
	 HgeTOi3QcDZYBICQ4+IiHsr43taWBTLYcIy9krJsLXTPdelHDaXeZZkBaQuwG42Cz8
	 U41r89FloNQA5VrfBQuVvFusB6LaPNFCw8dhYIynMJl4huV0U8DOZIYipyAENdjhM/
	 FhjZeFA4/tyMQ==
From: Hans de Goede <hansg@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 04/10] fixup! power: supply: core: battery-info: fully switch to fwnode
Date: Sun,  8 Jun 2025 22:40:04 +0200
Message-ID: <20250608204010.37482-5-hansg@kernel.org>
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

After ("power: supply: core: battery-info: fully switch to fwnode")
power_supply_get_battery_info() will always fail for battery fwnodes
which do not define a "resistance-temp-table".

Fix this by cleanly exiting on both 0 and EINVAL returns from
fwnode_property_count_u32(fwnode, "resistance-temp-table") which
indicates that the property is empty or not there.

While at it also fix:

1. The weird -ENOMEM return for other errors. For other errors
propagate the existing error or -EINVAL for an odd proplen.
2. Wrongly using "goto out_ret_pointer" on errors, out_ret_pointer
should only be used on success, error paths should use
out_put_node;

Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a8d1fe66e248..9bbc3be2e483 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -795,19 +795,20 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	}
 
 	proplen = fwnode_property_count_u32(fwnode, "resistance-temp-table");
-	if (proplen < 0 || proplen % 2 != 0) {
+	if (proplen == 0 || proplen == -EINVAL) {
+		err = 0;
+		goto out_ret_pointer;
+	} else if (proplen < 0 || proplen % 2 != 0) {
 		power_supply_put_battery_info(psy, info);
-		err = -ENOMEM;
-		goto out_ret_pointer;
-	} else if (proplen == 0) {
-		goto out_ret_pointer;
+		err = (proplen < 0) ? proplen : -EINVAL;
+		goto out_put_node;
 	}
 
 	propdata = kcalloc(proplen, sizeof(*propdata), GFP_KERNEL);
 	if (!propdata) {
 		power_supply_put_battery_info(psy, info);
 		err = -ENOMEM;
-		goto out_ret_pointer;
+		goto out_put_node;
 	}
 
 	err = fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
-- 
2.49.0


