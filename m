Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AFE775C1A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Aug 2023 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjHILXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Aug 2023 07:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjHILXy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2023 07:23:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC81FEB;
        Wed,  9 Aug 2023 04:23:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D749066071A7;
        Wed,  9 Aug 2023 12:23:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691580232;
        bh=pBm4NFjocF1ZWPAuyRdBDN01SrOO9oFGZdF9gRZlNhY=;
        h=From:To:Cc:Subject:Date:From;
        b=Blai+4b+/eEbFNBthBiIyf2I/WD/XU5WOEekbPwFkJ+a449OuqYg9iLQ/bCmMO2Ph
         fOnIxvOYTdnoSZQr/mvihytRR9kvd3zqeFLFoSRwm2AY2JNENG1YdK0rQy4KrBqSiM
         9q2nl9lyJ8V4/SZnzEcTXmoP6/rrjF5lyfAiH7bKnEr4k3aj3Bg62sT4I7WiD2W2HB
         KKEnlR71AdYld/zjMuiTB6LhrKtUIRqJbseXBJ8BEo3dEDjyrC6jpdCKWpq+dLQYsK
         urqaW8XMxCP8UY97JPNeVMC2RWpuZB2I+BTFkFVqd/UhBx43hbzq6YOxIMJqJGDgIc
         1XgS63rjdGu4A==
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH] thermal/of: Fix a leak in thermal_of_zone_register()
Date:   Wed,  9 Aug 2023 13:23:48 +0200
Message-ID: <20230809112348.2302384-1-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

thermal_zone_device_register_with_trips() copies the tzp info. After
calling this function, we should free the tzp object, otherwise it's
leaked.

Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/thermal/thermal_of.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6fb14e521197..e74ef4fa576b 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -524,10 +524,17 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
 						     mask, data, of_ops, tzp,
 						     pdelay, delay);
+
+	/*
+	 * thermal_zone_device_register_with_trips() copies the tzp info.
+	 * We don't need it after that point.
+	 */
+	kfree(tzp);
+
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
 		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
-		goto out_kfree_tzp;
+		goto out_kfree_trips;
 	}
 
 	ret = thermal_zone_device_enable(tz);
@@ -540,8 +547,6 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	return tz;
 
-out_kfree_tzp:
-	kfree(tzp);
 out_kfree_trips:
 	kfree(trips);
 out_kfree_of_ops:
-- 
2.41.0

