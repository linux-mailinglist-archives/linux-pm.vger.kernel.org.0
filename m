Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF55535B9
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 17:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352439AbiFUPRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 11:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352464AbiFUPRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 11:17:45 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA0E6B1D4
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=874mi
        Ft/EXWqwThsbW0J9BjN7pqOHV57xpu59rNwMhE=; b=IgwSvuURY834b0ODJVgXQ
        ++9vTjxDM2ddwYKf86Zp6va2cfhscRQep5xXnYPaST85O3uxqXCo3/MamRZd9VgK
        jLAqwe+yJWhaHCBiTSUnUaexf5iNmJitqAL394Io7VsCcyv/2LLutYdbDikekYm4
        K54euhnKjJGLCyWxa2FGxc=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgCnXZID4bFifZRyGA--.42361S2;
        Tue, 21 Jun 2022 23:17:24 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org, windhl@126.com
Subject: [PATCH v2] power/supply/olpc_battery: Hold the reference returned by of_find_compatible_node
Date:   Tue, 21 Jun 2022 23:17:20 +0800
Message-Id: <20220621151720.4083639-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgCnXZID4bFifZRyGA--.42361S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xr1UAry5AF1kuF4DZF4DCFg_yoW8JF1UpF
        Z8CrWY9FWrJFWrGa1IyF18CFy3Kw42yFW3JFy3A34j9347XFWkJr10qryY9rn8JFWFkF4r
        trn3tw1rZF1akwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_5l15UUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgwnF1-HZWTqrwAAs6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In olpc_battery_probe(), we should hold the reference returned by
of_find_compatible_node() and use it to call of_node_put() for
refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:

 v2: fix bug intro-ed by v1, reported by lkp.
 v1: add hold-ref code.

 drivers/power/supply/olpc_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index e0476ec06601..a5da20ffd685 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -635,6 +635,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	struct power_supply_config bat_psy_cfg = {};
 	struct power_supply_config ac_psy_cfg = {};
 	struct olpc_battery_data *data;
+	struct device_node *np;
 	uint8_t status;
 	uint8_t ecver;
 	int ret;
@@ -649,7 +650,9 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
+	np = of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec");
+	if (np) {
+		of_node_put(np);
 		/* XO 1.75 */
 		data->new_proto = true;
 		data->little_endian = true;
-- 
2.25.1

