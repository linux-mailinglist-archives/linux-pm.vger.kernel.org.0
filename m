Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A341ECE0
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhJAMGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 08:06:36 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47056
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231263AbhJAMGf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 08:06:35 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E487E4030C;
        Fri,  1 Oct 2021 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633089890;
        bh=5fW1zbFX9A+lWTjDceGHH/kyiO5490vMTq5bgwnRlDE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=LNgCHl6STFmq8gzscybaEkOEZ6mqkxCypEqJuj7bi509k+QXiO6uxCHbRMm+5PGEE
         Tk18nrjC30MkOU1uTxQjCngAxLOcX0sQSGQJOE85nWOdgtSv7v6Kl0Du/LWkICYVLj
         jmjYevQqu1RbXu07ZLxw4VnZQHDl874Q3WJJm8In5h+UdZeSKlwueEgEmcVCSORQaf
         vzYGmx87TbLpO9xHn/9Z2SG9bau6oZHavtwb3tRV1JhIDvzLLmUd362ce8jo9X4zSF
         SgNloDsv7Kq9FXHmz1sO9oPzIEgS4w2zJZ31ntSdvuFEQ8KzY7ZUMPpPAMhtN1xvNc
         ytkDOURi+bgRg==
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, patches@opensource.cirrus.com,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: wm831x_power: fix spelling mistake on function name
Date:   Fri,  1 Oct 2021 13:04:49 +0100
Message-Id: <20211001120449.17914-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the name wm831x_battey_apply_config,
fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/wm831x_power.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 4cd2dd870039..82e31066c746 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -234,7 +234,7 @@ static struct chg_map chg_times[] = {
 	{ 510, 15 << WM831X_CHG_TIME_SHIFT },
 };
 
-static void wm831x_battey_apply_config(struct wm831x *wm831x,
+static void wm831x_battery_apply_config(struct wm831x *wm831x,
 				       struct chg_map *map, int count, int val,
 				       int *reg, const char *name,
 				       const char *units)
@@ -281,24 +281,24 @@ static void wm831x_config_battery(struct wm831x *wm831x)
 	if (pdata->fast_enable)
 		reg1 |= WM831X_CHG_FAST;
 
-	wm831x_battey_apply_config(wm831x, trickle_ilims,
+	wm831x_battery_apply_config(wm831x, trickle_ilims,
 				   ARRAY_SIZE(trickle_ilims),
 				   pdata->trickle_ilim, &reg2,
 				   "trickle charge current limit", "mA");
 
-	wm831x_battey_apply_config(wm831x, vsels, ARRAY_SIZE(vsels),
+	wm831x_battery_apply_config(wm831x, vsels, ARRAY_SIZE(vsels),
 				   pdata->vsel, &reg2,
 				   "target voltage", "mV");
 
-	wm831x_battey_apply_config(wm831x, fast_ilims, ARRAY_SIZE(fast_ilims),
+	wm831x_battery_apply_config(wm831x, fast_ilims, ARRAY_SIZE(fast_ilims),
 				   pdata->fast_ilim, &reg2,
 				   "fast charge current limit", "mA");
 
-	wm831x_battey_apply_config(wm831x, eoc_iterms, ARRAY_SIZE(eoc_iterms),
+	wm831x_battery_apply_config(wm831x, eoc_iterms, ARRAY_SIZE(eoc_iterms),
 				   pdata->eoc_iterm, &reg1,
 				   "end of charge current threshold", "mA");
 
-	wm831x_battey_apply_config(wm831x, chg_times, ARRAY_SIZE(chg_times),
+	wm831x_battery_apply_config(wm831x, chg_times, ARRAY_SIZE(chg_times),
 				   pdata->timeout, &reg2,
 				   "charger timeout", "min");
 
-- 
2.32.0

