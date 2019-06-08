Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72E939CCF
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 12:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfFHK6v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 06:58:51 -0400
Received: from sauhun.de ([88.99.104.3]:51934 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfFHK4v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Jun 2019 06:56:51 -0400
Received: from localhost (p5486CBCC.dip0.t-ipconnect.de [84.134.203.204])
        by pokefinder.org (Postfix) with ESMTPSA id EB3A23E4795;
        Sat,  8 Jun 2019 12:56:49 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/34] power: supply: bq24257_charger: simplify getting the adapter of a client
Date:   Sat,  8 Jun 2019 12:55:56 +0200
Message-Id: <20190608105619.593-18-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/power/supply/bq24257_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 7eb58f10e092..eb151687beb3 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -950,7 +950,7 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 static int bq24257_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
 	const struct acpi_device_id *acpi_id;
 	struct bq24257_device *bq;
-- 
2.19.1

