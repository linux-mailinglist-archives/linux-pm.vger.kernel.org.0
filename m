Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092E1332DC2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhCISEm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:04:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35240 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhCISEQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0590B1F45804
Received: by jupiter.universe (Postfix, from userid 1000)
        id B48C64800D9; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4/7] power: supply: sbs-manager: use managed i2c_mux_adapter
Date:   Tue,  9 Mar 2021 19:04:04 +0100
Message-Id: <20210309180407.650943-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309180407.650943-1-sebastian.reichel@collabora.com>
References: <20210309180407.650943-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify code by using devm_add_action_or_reset to unregister
the i2c_mux_adapter.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-manager.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index 666243d9dd59..cd2bf0b247fe 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -311,6 +311,12 @@ static const struct power_supply_desc sbsm_default_psy_desc = {
 	.property_is_writeable = &sbsm_prop_is_writeable,
 };
 
+static void sbsm_del_mux_adapter(void *data)
+{
+	struct sbsm_data *sbsm = data;
+	i2c_mux_del_adapters(sbsm->muxc);
+}
+
 static int sbsm_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
@@ -350,6 +356,10 @@ static int sbsm_probe(struct i2c_client *client,
 	}
 	data->muxc->priv = data;
 
+	ret = devm_add_action_or_reset(dev, sbsm_del_mux_adapter, data);
+	if (ret)
+		return ret;
+
 	/* register muxed i2c channels. One for each supported battery */
 	for (i = 0; i < SBSM_MAX_BATS; ++i) {
 		if (data->supported_bats & BIT(i)) {
@@ -395,20 +405,10 @@ static int sbsm_probe(struct i2c_client *client,
 
 err_psy:
 err_mux_register:
-	i2c_mux_del_adapters(data->muxc);
-
 err_mux_alloc:
 	return ret;
 }
 
-static int sbsm_remove(struct i2c_client *client)
-{
-	struct sbsm_data *data = i2c_get_clientdata(client);
-
-	i2c_mux_del_adapters(data->muxc);
-	return 0;
-}
-
 static const struct i2c_device_id sbsm_ids[] = {
 	{ "sbs-manager", 0 },
 	{ "ltc1760",     0 },
@@ -431,7 +431,6 @@ static struct i2c_driver sbsm_driver = {
 		.of_match_table = of_match_ptr(sbsm_dt_ids),
 	},
 	.probe		= sbsm_probe,
-	.remove		= sbsm_remove,
 	.alert		= sbsm_alert,
 	.id_table	= sbsm_ids
 };
-- 
2.30.1

